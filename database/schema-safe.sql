-- =============================================================
--  AURELIA FC - Database schema (MySQL 8.0)
-- =============================================================
--  A clean, normalized schema for the AURELIA FC Web Forms site.
--
--  Design notes
--   * Every table has an explicit surrogate primary key.
--   * Every relationship the application relies on is enforced with a
--     real FOREIGN KEY (users, players, matches, tickets, orders, news).
--   * Natural keys are protected with UNIQUE constraints
--     (email, slug, order reference, competition+season, ...).
--   * utf8mb4 / utf8mb4_unicode_ci throughout (names with accents).
--   * Lookup and sort columns used by the repositories are indexed.
--   * league_standings stores only facts; goal difference and points are
--     derived at query time (see vw_league_table).
--
--  Usage:  mysql -u root -h 127.0.0.1 < schema.sql
--          mysql -u root -h 127.0.0.1 < data.sql
--     or:  setup.cmd   (Windows, runs both)
-- =============================================================

USE `aurelia_fc_v2`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- =============================================================
--  TABLES
-- =============================================================
CREATE TABLE `club_executives` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_title` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `club_honours` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `years` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `count_label` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_order` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `club_info` (
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `club_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `motto` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `founded_year` smallint unsigned NOT NULL,
  `description` varchar(600) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stadium_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `capacity` int unsigned NOT NULL,
  `built_year` smallint unsigned NOT NULL,
  `record_attendance` int unsigned NOT NULL,
  `address` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `club_milestones` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `year_label` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_order` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `club_values` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_order` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `competitions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('League','Cup','Friendly') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'League',
  `season` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_competitions` (`name`,`season`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `contact_departments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `contact_messages` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_handled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ix_contact_created` (`created_at`),
  KEY `fk_contact_user` (`user_id`),
  CONSTRAINT `fk_contact_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `faqs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `question` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `answer` varchar(600) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_order` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `gallery_images` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `category` enum('Match Day','Training','Events','Stadium') COLLATE utf8mb4_unicode_ci NOT NULL,
  `caption` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `width_px` smallint unsigned NOT NULL,
  `height_px` smallint unsigned NOT NULL,
  `sort_order` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ix_gallery_category` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `hospitality_packages` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `price_unit` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '/ match',
  `description` varchar(400) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `league_standings` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `competition_id` int unsigned NOT NULL,
  `position` tinyint unsigned NOT NULL,
  `club_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `played` tinyint unsigned NOT NULL DEFAULT '0',
  `won` tinyint unsigned NOT NULL DEFAULT '0',
  `drawn` tinyint unsigned NOT NULL DEFAULT '0',
  `lost` tinyint unsigned NOT NULL DEFAULT '0',
  `goals_for` smallint unsigned NOT NULL DEFAULT '0',
  `goals_against` smallint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_standings_pos` (`competition_id`,`position`),
  CONSTRAINT `fk_standings_competition` FOREIGN KEY (`competition_id`) REFERENCES `competitions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `match_events` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `match_id` int unsigned NOT NULL,
  `minute` tinyint unsigned NOT NULL,
  `team_side` enum('Home','Away') COLLATE utf8mb4_unicode_ci NOT NULL,
  `player_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_type` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_order` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ix_events_match` (`match_id`),
  CONSTRAINT `fk_events_match` FOREIGN KEY (`match_id`) REFERENCES `matches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `match_lineups` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `match_id` int unsigned NOT NULL,
  `side` enum('Home','Away') COLLATE utf8mb4_unicode_ci NOT NULL,
  `formation` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `squad_no` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `player_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_code` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_order` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ix_lineups_match` (`match_id`,`side`),
  CONSTRAINT `fk_lineups_match` FOREIGN KEY (`match_id`) REFERENCES `matches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `match_stats` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `match_id` int unsigned NOT NULL,
  `stat_label` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `home_value` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `away_value` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_order` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_match_stat` (`match_id`,`stat_label`),
  CONSTRAINT `fk_stats_match` FOREIGN KEY (`match_id`) REFERENCES `matches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `matches` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `competition_id` int unsigned NOT NULL,
  `home_team` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `away_team` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kickoff_at` datetime NOT NULL,
  `venue` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_home` tinyint(1) NOT NULL DEFAULT '0',
  `status` enum('Scheduled','Completed','Cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Scheduled',
  `home_score` tinyint unsigned DEFAULT NULL,
  `away_score` tinyint unsigned DEFAULT NULL,
  `attendance` int unsigned DEFAULT NULL,
  `match_report` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_matches_kickoff` (`kickoff_at`),
  KEY `ix_matches_status` (`status`),
  KEY `fk_matches_competition` (`competition_id`),
  CONSTRAINT `fk_matches_competition` FOREIGN KEY (`competition_id`) REFERENCES `competitions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `news_articles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(220) COLLATE utf8mb4_unicode_ci NOT NULL,
  `excerpt` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `author_name` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pull_quote` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pull_quote_by` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `published_at` datetime NOT NULL,
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_news_slug` (`slug`),
  KEY `ix_news_published` (`published_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `news_tags` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL,
  `tag` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_news_tag` (`article_id`,`tag`),
  CONSTRAINT `fk_news_tags_article` FOREIGN KEY (`article_id`) REFERENCES `news_articles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `order_items` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int unsigned NOT NULL,
  `item_type` enum('Product','MatchTicket','SeasonTicket','Hospitality') COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_ref_id` int unsigned DEFAULT NULL,
  `description` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` smallint unsigned NOT NULL DEFAULT '1',
  `unit_price` decimal(8,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_order_items_order` (`order_id`),
  CONSTRAINT `fk_order_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chk_order_qty` CHECK ((`quantity` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `orders` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `reference` char(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_type` enum('Shop','Tickets','SeasonTicket','Hospitality') COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('Pending','Paid','Cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pending',
  `total_amount` decimal(10,2) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_orders_reference` (`reference`),
  KEY `ix_orders_user` (`user_id`),
  CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `partners` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_order` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_partners_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `password_reset_tokens` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `token_hash` char(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` datetime NOT NULL,
  `used_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_prt_token` (`token_hash`),
  KEY `ix_prt_user` (`user_id`),
  CONSTRAINT `fk_prt_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `player_career_history` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `player_id` int unsigned NOT NULL,
  `club_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `period` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `appearances` smallint unsigned DEFAULT NULL,
  `goals` smallint unsigned DEFAULT NULL,
  `note` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ix_pch_player` (`player_id`),
  CONSTRAINT `fk_pch_player` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `player_season_stats` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `player_id` int unsigned NOT NULL,
  `season` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `month_label` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_order` smallint NOT NULL DEFAULT '0',
  `apps` smallint unsigned NOT NULL DEFAULT '0',
  `goals` smallint unsigned NOT NULL DEFAULT '0',
  `assists` smallint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ix_pss_player` (`player_id`),
  CONSTRAINT `fk_pss_player` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `players` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `team_id` int unsigned NOT NULL,
  `position_id` tinyint unsigned NOT NULL,
  `squad_number` tinyint unsigned NOT NULL,
  `first_name` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nationality` char(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `height_cm` smallint unsigned DEFAULT NULL,
  `bio` text COLLATE utf8mb4_unicode_ci,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `goals` smallint unsigned NOT NULL DEFAULT '0',
  `assists` smallint unsigned NOT NULL DEFAULT '0',
  `appearances` smallint unsigned NOT NULL DEFAULT '0',
  `avg_rating` decimal(4,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_players_team_squad` (`team_id`,`squad_number`),
  KEY `ix_players_position` (`position_id`),
  CONSTRAINT `fk_players_position` FOREIGN KEY (`position_id`) REFERENCES `positions` (`id`),
  CONSTRAINT `fk_players_team` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chk_players_nationality` CHECK ((char_length(`nationality`) = 3)),
  CONSTRAINT `chk_players_rating` CHECK (((`avg_rating` >= 0) and (`avg_rating` <= 10)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `positions` (
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_positions_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `product_categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_order` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_product_categories` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `products` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int unsigned NOT NULL,
  `name` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `badge` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ix_products_category` (`category_id`),
  CONSTRAINT `fk_products_category` FOREIGN KEY (`category_id`) REFERENCES `product_categories` (`id`),
  CONSTRAINT `chk_products_price` CHECK ((`price` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `quick_links` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `href` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_order` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `season_ticket_features` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `tier_id` int unsigned NOT NULL,
  `feature` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_order` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ix_stf_tier` (`tier_id`),
  CONSTRAINT `fk_stf_tier` FOREIGN KEY (`tier_id`) REFERENCES `season_ticket_tiers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `season_ticket_tiers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_order` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_season_tier` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `teams` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `coach` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `player_count` smallint unsigned NOT NULL DEFAULT '0',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_teams_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `ticket_fixtures` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `match_id` int unsigned NOT NULL,
  `price_min` decimal(8,2) NOT NULL,
  `price_max` decimal(8,2) NOT NULL,
  `available_seats` smallint unsigned NOT NULL,
  `status_label` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_ticket_fixture` (`match_id`),
  CONSTRAINT `fk_ticket_fixture_match` FOREIGN KEY (`match_id`) REFERENCES `matches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chk_ticket_price` CHECK ((`price_max` >= `price_min`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('Member','Admin') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Member',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_users_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
-- =============================================================
--  ADDITIONAL INDEXES
--  (query patterns used by the DAL: featured/latest listings,
--   fixture ordering, squad lookups, order history)
-- =============================================================

ALTER TABLE `matches`
    DROP INDEX `ix_matches_status`,
    ADD INDEX `ix_matches_status_kickoff` (`status`, `kickoff_at`);

ALTER TABLE `orders`
    ADD INDEX `ix_orders_user_created` (`user_id`, `created_at`);

ALTER TABLE `news_articles`
    ADD INDEX `ix_news_featured_published` (`is_featured`, `published_at`),
    ADD INDEX `ix_news_category_published` (`category`, `published_at`);

ALTER TABLE `players`
    ADD INDEX `ix_players_name` (`last_name`, `first_name`),
    ADD INDEX `ix_players_squad` (`squad_number`);

ALTER TABLE `products`
    ADD INDEX `ix_products_featured` (`is_featured`);

ALTER TABLE `gallery_images`
    ADD INDEX `ix_gallery_category_order` (`category`, `sort_order`);

ALTER TABLE `contact_messages`
    ADD INDEX `ix_contact_handled` (`is_handled`);

ALTER TABLE `ticket_fixtures`
    ADD INDEX `ix_ticket_fixtures_price` (`price_min`);

SET FOREIGN_KEY_CHECKS = 1;

-- =============================================================
--  VIEWS
-- =============================================================

-- League table with the derived columns the UI shows. CAST to SIGNED is
-- required because goals_for/goals_against are UNSIGNED and the subtraction
-- would otherwise overflow for a negative goal difference.
CREATE OR REPLACE VIEW `vw_league_table` AS
SELECT
    `ls`.`id`,
    `ls`.`competition_id`,
    `c`.`name`                                   AS `competition_name`,
    `c`.`season`,
    `ls`.`position`,
    `ls`.`club_name`,
    `ls`.`played`,
    `ls`.`won`,
    `ls`.`drawn`,
    `ls`.`lost`,
    `ls`.`goals_for`,
    `ls`.`goals_against`,
    (CAST(`ls`.`goals_for` AS SIGNED) - CAST(`ls`.`goals_against` AS SIGNED)) AS `goal_difference`,
    ((`ls`.`won` * 3) + `ls`.`drawn`)        AS `points`
FROM `league_standings` `ls`
JOIN `competitions` `c` ON `c`.`id` = `ls`.`competition_id`;

-- Squad list with the team and position names resolved.
CREATE OR REPLACE VIEW `vw_squad` AS
SELECT
    `p`.`id`,
    `p`.`team_id`,
    `p`.`position_id`,
    `p`.`squad_number`,
    `p`.`first_name`,
    `p`.`last_name`,
    CONCAT(`p`.`first_name`, ' ', `p`.`last_name`) AS `full_name`,
    `p`.`nationality`,
    `p`.`date_of_birth`,
    `p`.`height_cm`,
    `p`.`image_path`,
    `p`.`goals`,
    `p`.`assists`,
    `p`.`appearances`,
    `p`.`avg_rating`,
    `t`.`name`  AS `team_name`,
    `pos`.`name` AS `position_name`
FROM `players` `p`
JOIN `teams` `t`      ON `t`.`id` = `p`.`team_id`
JOIN `positions` `pos` ON `pos`.`id` = `p`.`position_id`;
