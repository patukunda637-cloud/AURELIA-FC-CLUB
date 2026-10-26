-- =============================================================
--  AURELIA FC - Seed / reference data
--  Load this after schema.sql. It targets the aurelia_fc_v2 schema.
-- =============================================================

USE `aurelia_fc_v2`;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

/*!40000 ALTER TABLE `club_executives` DISABLE KEYS */;
INSERT INTO `club_executives` (`id`, `full_name`, `role_title`, `image_path`, `sort_order`) VALUES (1,'Sir Arthur Sterling','Club President','assets/images/executive-arthur.jpg',1);
INSERT INTO `club_executives` (`id`, `full_name`, `role_title`, `image_path`, `sort_order`) VALUES (2,'Adrianna Vance','Head Coach','assets/images/executive-adrianna.jpg',2);
/*!40000 ALTER TABLE `club_executives` ENABLE KEYS */;

/*!40000 ALTER TABLE `club_honours` DISABLE KEYS */;
INSERT INTO `club_honours` (`id`, `title`, `years`, `count_label`, `sort_order`) VALUES (1,'Premier Division Champions','2015, 2017, 2018, 2020','4 Trophies',1);
INSERT INTO `club_honours` (`id`, `title`, `years`, `count_label`, `sort_order`) VALUES (2,'National Cup Winners','1994, 2001, 2005, 2012, 2019, 2024','6 Cups',2);
INSERT INTO `club_honours` (`id`, `title`, `years`, `count_label`, `sort_order`) VALUES (3,'Super Cup Champions','2016, 2019','2 Trophies',3);
/*!40000 ALTER TABLE `club_honours` ENABLE KEYS */;

/*!40000 ALTER TABLE `club_info` DISABLE KEYS */;
INSERT INTO `club_info` (`id`, `club_name`, `motto`, `founded_year`, `description`, `stadium_name`, `capacity`, `built_year`, `record_attendance`, `address`, `phone`) VALUES (1,'Aurelia FC','Rise. Unite. Conquer.',1987,'Aurelia Football Club is a professional football club based in Aurelia. Founded in 1987, the club competes in the premier tier of sports excellence.','Aurelia Arena',45000,2003,45210,'100 Royal Way, Aurelia','+44 (0) 20 8123 4567');
/*!40000 ALTER TABLE `club_info` ENABLE KEYS */;

/*!40000 ALTER TABLE `club_milestones` DISABLE KEYS */;
INSERT INTO `club_milestones` (`id`, `year_label`, `title`, `body`, `sort_order`) VALUES (1,'1987','Club Founded','Originally established by community leaders under the motto Rise. Unite. Conquer.',1);
INSERT INTO `club_milestones` (`id`, `year_label`, `title`, `body`, `sort_order`) VALUES (2,'1994','First Trophy','Aurelia FC secures the National Cup, beginning a long journey of major honors.',2);
INSERT INTO `club_milestones` (`id`, `year_label`, `title`, `body`, `sort_order`) VALUES (3,'2003','Arena Completed','Inauguration of the state-of-the-art Aurelia Arena with a massive 45,000 capacity.',3);
INSERT INTO `club_milestones` (`id`, `year_label`, `title`, `body`, `sort_order`) VALUES (4,'2015-2020','The Golden Era','Five consecutive league titles and three continental finals cemented legacy.',4);
/*!40000 ALTER TABLE `club_milestones` ENABLE KEYS */;

/*!40000 ALTER TABLE `club_values` DISABLE KEYS */;
INSERT INTO `club_values` (`id`, `title`, `body`, `sort_order`) VALUES (1,'Excellence','We strive to reach the pinnacle of performance in coaching, playstyle, and operational efficiency.',1);
INSERT INTO `club_values` (`id`, `title`, `body`, `sort_order`) VALUES (2,'Unity','A family on and off the pitch. Fans, players, and staff rise together in perfect alignment.',2);
INSERT INTO `club_values` (`id`, `title`, `body`, `sort_order`) VALUES (3,'Community','Supporting local foundations, youth academies, and empowering Aurelia\'s neighborhood programs.',3);
/*!40000 ALTER TABLE `club_values` ENABLE KEYS */;

/*!40000 ALTER TABLE `competitions` DISABLE KEYS */;
INSERT INTO `competitions` (`id`, `name`, `type`, `season`) VALUES (1,'Premier Division','League','2026/2027');
INSERT INTO `competitions` (`id`, `name`, `type`, `season`) VALUES (2,'National Cup','Cup','2026/2027');
/*!40000 ALTER TABLE `competitions` ENABLE KEYS */;

/*!40000 ALTER TABLE `contact_departments` DISABLE KEYS */;
INSERT INTO `contact_departments` (`id`, `name`, `email`, `phone`, `note`, `sort_order`) VALUES (1,'General Enquiries','hello@aureliafc.com','+44 (0) 20 8123 4567','Standard club operations and inquiries.',1);
INSERT INTO `contact_departments` (`id`, `name`, `email`, `phone`, `note`, `sort_order`) VALUES (2,'Ticket Office','tickets@aureliafc.com','+44 (0) 20 8123 4568','Mon-Fri: 9:00 AM - 5:00 PM BST',2);
INSERT INTO `contact_departments` (`id`, `name`, `email`, `phone`, `note`, `sort_order`) VALUES (3,'Media & Press','press@aureliafc.com',NULL,'For accredited press & media inquiries only.',3);
/*!40000 ALTER TABLE `contact_departments` ENABLE KEYS */;

/*!40000 ALTER TABLE `contact_messages` DISABLE KEYS */;
INSERT INTO `contact_messages` (`id`, `full_name`, `email`, `subject`, `message`, `user_id`, `created_at`, `is_handled`) VALUES (1,'Jane Fan','jane@example.com','General Enquiries','Hello, I would like to know about membership options please.',NULL,'2026-10-21 04:46:56',0);
INSERT INTO `contact_messages` (`id`, `full_name`, `email`, `subject`, `message`, `user_id`, `created_at`, `is_handled`) VALUES (2,'Vera Lint','ui.verify.1792559341150@example.com','Ticket Enquiries','Please confirm my season ticket seats.',NULL,'2026-10-21 05:09:01',0);
INSERT INTO `contact_messages` (`id`, `full_name`, `email`, `subject`, `message`, `user_id`, `created_at`, `is_handled`) VALUES (3,'Integration Tester','it-715d97ee30cb44308d7e2de718e1c598@example.com','Automated test','This message was created by the automated integration test suite.',NULL,'2026-10-21 05:19:45',0);
INSERT INTO `contact_messages` (`id`, `full_name`, `email`, `subject`, `message`, `user_id`, `created_at`, `is_handled`) VALUES (4,'Flow Tester','flow-1792560059708@example.com','Flow check','Automated live flow verification message.',NULL,'2026-10-21 05:21:03',0);
INSERT INTO `contact_messages` (`id`, `full_name`, `email`, `subject`, `message`, `user_id`, `created_at`, `is_handled`) VALUES (5,'Integration Tester','it-dce1aa06e8744ef0aa95ded9ce8c179d@example.com','Automated test','This message was created by the automated integration test suite.',NULL,'2026-10-21 05:22:31',0);
INSERT INTO `contact_messages` (`id`, `full_name`, `email`, `subject`, `message`, `user_id`, `created_at`, `is_handled`) VALUES (6,'Integration Tester','it-85f314852a764940bdffd4d9561c18fe@example.com','Automated test','This message was created by the automated integration test suite.',NULL,'2026-10-21 09:17:24',0);
/*!40000 ALTER TABLE `contact_messages` ENABLE KEYS */;

/*!40000 ALTER TABLE `faqs` DISABLE KEYS */;
INSERT INTO `faqs` (`id`, `question`, `answer`, `sort_order`) VALUES (1,'How do I purchase matchday tickets?','Matchday tickets can be purchased online through our Ticket portal or directly at the Aurelia Arena box office.',1);
INSERT INTO `faqs` (`id`, `question`, `answer`, `sort_order`) VALUES (2,'Are stadium tours available?','Yes, stadium tours run every Tuesday and Thursday. Advanced booking is required through the quick links.',2);
INSERT INTO `faqs` (`id`, `question`, `answer`, `sort_order`) VALUES (3,'How can I join the Youth Academy?','Our youth academy holds open trials twice a year. Keep an eye on our latest news or contact trials@aureliafc.com.',3);
INSERT INTO `faqs` (`id`, `question`, `answer`, `sort_order`) VALUES (4,'Can I host private events at Aurelia Arena?','Absolutely, we have several luxurious hospitality suites available for corporate events and private celebrations.',4);
INSERT INTO `faqs` (`id`, `question`, `answer`, `sort_order`) VALUES (5,'Is there matchday parking available?','Yes, stadium parking is available but limited. We highly recommend booking a parking pass alongside your tickets.',5);
/*!40000 ALTER TABLE `faqs` ENABLE KEYS */;

/*!40000 ALTER TABLE `gallery_images` DISABLE KEYS */;
INSERT INTO `gallery_images` (`id`, `category`, `caption`, `image_path`, `width_px`, `height_px`, `sort_order`) VALUES (1,'Match Day','Vane secures the game-winning goal','assets/images/gallery-vane-winning-goal.jpg',420,280,1);
INSERT INTO `gallery_images` (`id`, `category`, `caption`, `image_path`, `width_px`, `height_px`, `sort_order`) VALUES (2,'Training','Manager Vance dynamic pitch strategy','assets/images/gallery-vance-tactics.jpg',420,280,2);
INSERT INTO `gallery_images` (`id`, `category`, `caption`, `image_path`, `width_px`, `height_px`, `sort_order`) VALUES (3,'Match Day','Aggressive slide tackle stops counter','assets/images/gallery-slide-tackle.jpg',420,280,3);
INSERT INTO `gallery_images` (`id`, `category`, `caption`, `image_path`, `width_px`, `height_px`, `sort_order`) VALUES (4,'Stadium','Aurelia Arena pitch perfect grass','assets/images/gallery-pitch-grass.jpg',400,292,4);
INSERT INTO `gallery_images` (`id`, `category`, `caption`, `image_path`, `width_px`, `height_px`, `sort_order`) VALUES (5,'Training','Team training conditioning drills','assets/images/gallery-training-drills.jpg',856,375,5);
INSERT INTO `gallery_images` (`id`, `category`, `caption`, `image_path`, `width_px`, `height_px`, `sort_order`) VALUES (6,'Events','Passionate Royals fanbase in full roar','assets/images/gallery-crowd-roar.jpg',420,280,6);
INSERT INTO `gallery_images` (`id`, `category`, `caption`, `image_path`, `width_px`, `height_px`, `sort_order`) VALUES (7,'Events','Royal Home Kit details for new season','assets/images/gallery-home-kit-detail.jpg',420,280,7);
INSERT INTO `gallery_images` (`id`, `category`, `caption`, `image_path`, `width_px`, `height_px`, `sort_order`) VALUES (8,'Training','Pre-game tactical drills setups','assets/images/gallery-pre-game-drills.jpg',420,280,8);
INSERT INTO `gallery_images` (`id`, `category`, `caption`, `image_path`, `width_px`, `height_px`, `sort_order`) VALUES (9,'Stadium','Morning light over Aurelia Arena','assets/images/gallery-morning-light.jpg',856,375,9);
INSERT INTO `gallery_images` (`id`, `category`, `caption`, `image_path`, `width_px`, `height_px`, `sort_order`) VALUES (10,'Events','Unified in locker room triumph','assets/images/gallery-locker-room.jpg',400,292,10);
/*!40000 ALTER TABLE `gallery_images` ENABLE KEYS */;

/*!40000 ALTER TABLE `hospitality_packages` DISABLE KEYS */;
INSERT INTO `hospitality_packages` (`id`, `name`, `price`, `price_unit`, `description`, `image_path`, `sort_order`) VALUES (1,'The Royal Lounge',150.00,'/ match','Indulge in pre-match buffets, live musical entertainment, and padded executive balcony seating.','assets/images/hospitality-royal-lounge.jpg',1);
INSERT INTO `hospitality_packages` (`id`, `name`, `price`, `price_unit`, `description`, `image_path`, `sort_order`) VALUES (2,'Aurelia Executive Box',2500.00,'/ match','Private suite for up to 10 guests. Personal host, gourmet culinary experience and supreme royal comfort.','assets/images/hospitality-executive-box.jpg',2);
/*!40000 ALTER TABLE `hospitality_packages` ENABLE KEYS */;

/*!40000 ALTER TABLE `league_standings` DISABLE KEYS */;
INSERT INTO `league_standings` (`id`, `competition_id`, `position`, `club_name`, `played`, `won`, `drawn`, `lost`, `goals_for`, `goals_against`) VALUES (1,1,1,'Stormgate FC',16,12,2,2,34,12);
INSERT INTO `league_standings` (`id`, `competition_id`, `position`, `club_name`, `played`, `won`, `drawn`, `lost`, `goals_for`, `goals_against`) VALUES (2,1,2,'Aurelia FC',16,11,2,3,31,15);
INSERT INTO `league_standings` (`id`, `competition_id`, `position`, `club_name`, `played`, `won`, `drawn`, `lost`, `goals_for`, `goals_against`) VALUES (3,1,3,'Northvale City',16,10,3,3,28,14);
INSERT INTO `league_standings` (`id`, `competition_id`, `position`, `club_name`, `played`, `won`, `drawn`, `lost`, `goals_for`, `goals_against`) VALUES (4,1,4,'Crestwood Athletic',16,9,3,4,25,18);
INSERT INTO `league_standings` (`id`, `competition_id`, `position`, `club_name`, `played`, `won`, `drawn`, `lost`, `goals_for`, `goals_against`) VALUES (5,1,5,'Ironclad United',16,8,4,4,24,20);
INSERT INTO `league_standings` (`id`, `competition_id`, `position`, `club_name`, `played`, `won`, `drawn`, `lost`, `goals_for`, `goals_against`) VALUES (6,1,6,'Thornfield Rangers',16,7,5,4,21,19);
INSERT INTO `league_standings` (`id`, `competition_id`, `position`, `club_name`, `played`, `won`, `drawn`, `lost`, `goals_for`, `goals_against`) VALUES (7,1,7,'Meridian Town',16,7,3,6,19,18);
INSERT INTO `league_standings` (`id`, `competition_id`, `position`, `club_name`, `played`, `won`, `drawn`, `lost`, `goals_for`, `goals_against`) VALUES (8,1,8,'Ashford Vale',16,6,4,6,18,22);
INSERT INTO `league_standings` (`id`, `competition_id`, `position`, `club_name`, `played`, `won`, `drawn`, `lost`, `goals_for`, `goals_against`) VALUES (9,1,9,'Blackmoor FC',16,5,4,7,15,23);
INSERT INTO `league_standings` (`id`, `competition_id`, `position`, `club_name`, `played`, `won`, `drawn`, `lost`, `goals_for`, `goals_against`) VALUES (10,1,10,'Silverpeak United',16,4,5,7,14,26);
INSERT INTO `league_standings` (`id`, `competition_id`, `position`, `club_name`, `played`, `won`, `drawn`, `lost`, `goals_for`, `goals_against`) VALUES (11,1,11,'Dunhaven City',16,3,5,8,11,29);
INSERT INTO `league_standings` (`id`, `competition_id`, `position`, `club_name`, `played`, `won`, `drawn`, `lost`, `goals_for`, `goals_against`) VALUES (12,1,12,'Redcliffe Borough',16,2,5,9,8,32);
/*!40000 ALTER TABLE `league_standings` ENABLE KEYS */;

/*!40000 ALTER TABLE `match_events` DISABLE KEYS */;
INSERT INTO `match_events` (`id`, `match_id`, `minute`, `team_side`, `player_name`, `event_type`, `sort_order`) VALUES (1,1,23,'Home','Marcus Vane','Goal (Assisted by Elena Cross)',1);
INSERT INTO `match_events` (`id`, `match_id`, `minute`, `team_side`, `player_name`, `event_type`, `sort_order`) VALUES (2,1,51,'Home','Elena Cross','Goal (Direct Free Kick)',2);
INSERT INTO `match_events` (`id`, `match_id`, `minute`, `team_side`, `player_name`, `event_type`, `sort_order`) VALUES (3,1,65,'Away','Torres','Goal (Header)',3);
INSERT INTO `match_events` (`id`, `match_id`, `minute`, `team_side`, `player_name`, `event_type`, `sort_order`) VALUES (4,1,78,'Home','Almeida','Goal (Corner Kick)',4);
/*!40000 ALTER TABLE `match_events` ENABLE KEYS */;

/*!40000 ALTER TABLE `match_lineups` DISABLE KEYS */;
INSERT INTO `match_lineups` (`id`, `match_id`, `side`, `formation`, `squad_no`, `player_name`, `role_code`, `sort_order`) VALUES (1,1,'Home','4-3-3','#1','T. Harrison','GK',1);
INSERT INTO `match_lineups` (`id`, `match_id`, `side`, `formation`, `squad_no`, `player_name`, `role_code`, `sort_order`) VALUES (2,1,'Home','4-3-3','#4','D. Okafor','CB',2);
INSERT INTO `match_lineups` (`id`, `match_id`, `side`, `formation`, `squad_no`, `player_name`, `role_code`, `sort_order`) VALUES (3,1,'Home','4-3-3','#5','A. Sterling','CB',3);
INSERT INTO `match_lineups` (`id`, `match_id`, `side`, `formation`, `squad_no`, `player_name`, `role_code`, `sort_order`) VALUES (4,1,'Home','4-3-3','#3','R. Kael','LB',4);
INSERT INTO `match_lineups` (`id`, `match_id`, `side`, `formation`, `squad_no`, `player_name`, `role_code`, `sort_order`) VALUES (5,1,'Home','4-3-3','#2','J. Mercer','RB',5);
INSERT INTO `match_lineups` (`id`, `match_id`, `side`, `formation`, `squad_no`, `player_name`, `role_code`, `sort_order`) VALUES (6,1,'Home','4-3-3','#6','K. Vance','DM',6);
INSERT INTO `match_lineups` (`id`, `match_id`, `side`, `formation`, `squad_no`, `player_name`, `role_code`, `sort_order`) VALUES (7,1,'Home','4-3-3','#7','Elena Cross','CM',7);
INSERT INTO `match_lineups` (`id`, `match_id`, `side`, `formation`, `squad_no`, `player_name`, `role_code`, `sort_order`) VALUES (8,1,'Home','4-3-3','#8','L. Almeida','CM',8);
INSERT INTO `match_lineups` (`id`, `match_id`, `side`, `formation`, `squad_no`, `player_name`, `role_code`, `sort_order`) VALUES (9,1,'Home','4-3-3','#11','S. Russo','LW',9);
INSERT INTO `match_lineups` (`id`, `match_id`, `side`, `formation`, `squad_no`, `player_name`, `role_code`, `sort_order`) VALUES (10,1,'Home','4-3-3','#10','C. Sterling','RW',10);
INSERT INTO `match_lineups` (`id`, `match_id`, `side`, `formation`, `squad_no`, `player_name`, `role_code`, `sort_order`) VALUES (11,1,'Home','4-3-3','#9','Marcus Vane','CF',11);
INSERT INTO `match_lineups` (`id`, `match_id`, `side`, `formation`, `squad_no`, `player_name`, `role_code`, `sort_order`) VALUES (12,1,'Away','4-4-2','#1','M. Slayter','GK',1);
INSERT INTO `match_lineups` (`id`, `match_id`, `side`, `formation`, `squad_no`, `player_name`, `role_code`, `sort_order`) VALUES (13,1,'Away','4-4-2','#3','G. Thorne','CB',2);
INSERT INTO `match_lineups` (`id`, `match_id`, `side`, `formation`, `squad_no`, `player_name`, `role_code`, `sort_order`) VALUES (14,1,'Away','4-4-2','#4','H. Bishop','CB',3);
INSERT INTO `match_lineups` (`id`, `match_id`, `side`, `formation`, `squad_no`, `player_name`, `role_code`, `sort_order`) VALUES (15,1,'Away','4-4-2','#2','E. Vance','LB',4);
INSERT INTO `match_lineups` (`id`, `match_id`, `side`, `formation`, `squad_no`, `player_name`, `role_code`, `sort_order`) VALUES (16,1,'Away','4-4-2','#5','O. Crest','RB',5);
INSERT INTO `match_lineups` (`id`, `match_id`, `side`, `formation`, `squad_no`, `player_name`, `role_code`, `sort_order`) VALUES (17,1,'Away','4-4-2','#8','R. Torres','CM',6);
INSERT INTO `match_lineups` (`id`, `match_id`, `side`, `formation`, `squad_no`, `player_name`, `role_code`, `sort_order`) VALUES (18,1,'Away','4-4-2','#6','S. Finch','CM',7);
INSERT INTO `match_lineups` (`id`, `match_id`, `side`, `formation`, `squad_no`, `player_name`, `role_code`, `sort_order`) VALUES (19,1,'Away','4-4-2','#7','T. Novak','LM',8);
INSERT INTO `match_lineups` (`id`, `match_id`, `side`, `formation`, `squad_no`, `player_name`, `role_code`, `sort_order`) VALUES (20,1,'Away','4-4-2','#11','P. Mercer','RM',9);
INSERT INTO `match_lineups` (`id`, `match_id`, `side`, `formation`, `squad_no`, `player_name`, `role_code`, `sort_order`) VALUES (21,1,'Away','4-4-2','#9','A. Torres','CF',10);
INSERT INTO `match_lineups` (`id`, `match_id`, `side`, `formation`, `squad_no`, `player_name`, `role_code`, `sort_order`) VALUES (22,1,'Away','4-4-2','#10','J. Sterling','CF',11);
/*!40000 ALTER TABLE `match_lineups` ENABLE KEYS */;

/*!40000 ALTER TABLE `match_stats` DISABLE KEYS */;
INSERT INTO `match_stats` (`id`, `match_id`, `stat_label`, `home_value`, `away_value`, `sort_order`) VALUES (1,1,'Possession','58%','42%',1);
INSERT INTO `match_stats` (`id`, `match_id`, `stat_label`, `home_value`, `away_value`, `sort_order`) VALUES (2,1,'Shots','14','8',2);
INSERT INTO `match_stats` (`id`, `match_id`, `stat_label`, `home_value`, `away_value`, `sort_order`) VALUES (3,1,'Shots on Target','7','3',3);
INSERT INTO `match_stats` (`id`, `match_id`, `stat_label`, `home_value`, `away_value`, `sort_order`) VALUES (4,1,'Corners','6','4',4);
INSERT INTO `match_stats` (`id`, `match_id`, `stat_label`, `home_value`, `away_value`, `sort_order`) VALUES (5,1,'Fouls','11','13',5);
INSERT INTO `match_stats` (`id`, `match_id`, `stat_label`, `home_value`, `away_value`, `sort_order`) VALUES (6,1,'Yellow Cards','2','3',6);
/*!40000 ALTER TABLE `match_stats` ENABLE KEYS */;

/*!40000 ALTER TABLE `matches` DISABLE KEYS */;
INSERT INTO `matches` (`id`, `competition_id`, `home_team`, `away_team`, `kickoff_at`, `venue`, `is_home`, `status`, `home_score`, `away_score`, `attendance`, `match_report`) VALUES (1,1,'Aurelia FC','Northvale City','2026-09-07 19:45:00','Aurelia Arena',1,'Completed',3,1,44812,'Marcus Vane Secures Crucial Hat Trick in Derby Victory');
INSERT INTO `matches` (`id`, `competition_id`, `home_team`, `away_team`, `kickoff_at`, `venue`, `is_home`, `status`, `home_score`, `away_score`, `attendance`, `match_report`) VALUES (2,1,'Aurelia FC','Ironclad United','2026-09-12 19:45:00','Aurelia Arena',1,'Scheduled',NULL,NULL,NULL,NULL);
INSERT INTO `matches` (`id`, `competition_id`, `home_team`, `away_team`, `kickoff_at`, `venue`, `is_home`, `status`, `home_score`, `away_score`, `attendance`, `match_report`) VALUES (3,2,'Aurelia FC','Thornfield Rangers','2026-09-19 19:45:00','Thornfield Stadium',0,'Scheduled',NULL,NULL,NULL,NULL);
INSERT INTO `matches` (`id`, `competition_id`, `home_team`, `away_team`, `kickoff_at`, `venue`, `is_home`, `status`, `home_score`, `away_score`, `attendance`, `match_report`) VALUES (4,1,'Aurelia FC','Crestwood Athletic','2026-09-26 19:45:00','Aurelia Arena',1,'Scheduled',NULL,NULL,NULL,NULL);
INSERT INTO `matches` (`id`, `competition_id`, `home_team`, `away_team`, `kickoff_at`, `venue`, `is_home`, `status`, `home_score`, `away_score`, `attendance`, `match_report`) VALUES (5,1,'Aurelia FC','Stormgate FC','2026-10-03 19:45:00','Aurelia Arena',1,'Scheduled',NULL,NULL,NULL,NULL);
INSERT INTO `matches` (`id`, `competition_id`, `home_team`, `away_team`, `kickoff_at`, `venue`, `is_home`, `status`, `home_score`, `away_score`, `attendance`, `match_report`) VALUES (6,1,'Aurelia FC','Northvale City','2026-09-02 19:45:00','Aurelia Arena',1,'Completed',3,1,44120,NULL);
INSERT INTO `matches` (`id`, `competition_id`, `home_team`, `away_team`, `kickoff_at`, `venue`, `is_home`, `status`, `home_score`, `away_score`, `attendance`, `match_report`) VALUES (7,2,'Stormgate FC','Aurelia FC','2026-08-28 19:45:00','Stormgate Park',0,'Completed',0,2,38210,NULL);
INSERT INTO `matches` (`id`, `competition_id`, `home_team`, `away_team`, `kickoff_at`, `venue`, `is_home`, `status`, `home_score`, `away_score`, `attendance`, `match_report`) VALUES (8,1,'Aurelia FC','Crestwood Athletic','2026-08-22 19:45:00','Aurelia Arena',1,'Completed',1,1,43980,NULL);
/*!40000 ALTER TABLE `matches` ENABLE KEYS */;

/*!40000 ALTER TABLE `news_articles` DISABLE KEYS */;
INSERT INTO `news_articles` (`id`, `slug`, `category`, `title`, `excerpt`, `body`, `author_name`, `pull_quote`, `pull_quote_by`, `image_path`, `published_at`, `is_featured`) VALUES (1,'aurelia-fc-royal-sports-partnership','CLUB NEWS','Aurelia FC signs exciting new partnership with Royal Sports','The Royals announce a long term sponsorship agreement that secures future training development funding, state-of-the-art player analytics equipment, and expanded grassroots academies.','The Royals are delighted to confirm a landmark partnership with Royal Sports. The agreement secures future training development funding, state-of-the-art player analytics equipment and expanded grassroots academies across the region. Club President Sir Arthur Sterling described the deal as a defining moment for the next decade of Aurelia FC.','Sarah Mitchell',NULL,NULL,'assets/images/news-featured-partnership.jpg','2026-09-05 10:00:00',1);
INSERT INTO `news_articles` (`id`, `slug`, `category`, `title`, `excerpt`, `body`, `author_name`, `pull_quote`, `pull_quote_by`, `image_path`, `published_at`, `is_featured`) VALUES (2,'vane-hat-trick-derby-victory','MATCH REPORT','Marcus Vane secures crucial hat-trick in derby victory','A thrilling game at Aurelia Arena ended with a 3-1 triumph as Vane dominates the second half with classic finishes.','In what will be remembered as one of the most electric derby matchdays of the decade, Aurelia FC dominated the turf at Aurelia Arena this Saturday. The primary protagonist was none other than striker Marcus Vane, who put on a clinical finishing masterclass to secure all three points for the Royals. From the opening whistle, Head Coach Adrianna Vance deployed an aggressive high-press setup, seeking to rattle Northvale City\'s deep backline. Vane found the opener in the 23rd minute after a brilliant line-breaking pass from midfielder Elena Cross, lifting the roaring crowd of 45,000 to their feet. Northvale found a brief glimmer of hope when Torres converted a well-timed header in the 65th minute. However, Aurelia\'s superior tactical conditioning eventually proved too much. Elena Cross converted a direct free kick just ten minutes later to seal the dominance before Almeida\'s late corner completed the final 3-1 scoreline.','Sarah Mitchell','We played as one collective family today. The crowd\'s roar in the second half was the extra push we needed to finish them off.','MARCUS VANE, CF','assets/images/article-vane-derby-hero.jpg','2026-09-07 09:00:00',0);
INSERT INTO `news_articles` (`id`, `slug`, `category`, `title`, `excerpt`, `body`, `author_name`, `pull_quote`, `pull_quote_by`, `image_path`, `published_at`, `is_featured`) VALUES (3,'youth-prodigy-five-year-deal','TRANSFER','Aurelia FC signs exciting youth prodigy on long term deal','The 19-year-old playmaker commits to a 5-year developmental pathway with the club with big high-tier potential.','The 19-year-old playmaker commits to a 5-year developmental pathway with the club. Scouts have tracked his progress for three seasons and the coaching staff believe he can graduate into the first team squad within eighteen months.','Daniel Ross',NULL,NULL,'assets/images/news-young-prodigy.jpg','2026-09-04 14:00:00',0);
INSERT INTO `news_articles` (`id`, `slug`, `category`, `title`, `excerpt`, `body`, `author_name`, `pull_quote`, `pull_quote_by`, `image_path`, `published_at`, `is_featured`) VALUES (4,'arena-next-gen-dome-roof','CLUB NEWS','Aurelia Arena upgrades with next-generation dome roof','Continuing our carbon neutral initiative, Aurelia Arena stadium will host zero emission matches starting next spring.','Continuing our carbon neutral initiative, Aurelia Arena will host zero emission matches starting next spring. The new dome roof incorporates photovoltaic cladding and rainwater harvesting, cutting matchday energy consumption by 40%.','Priya Nair',NULL,NULL,'assets/images/news-stadium-roof.jpg','2026-08-30 11:00:00',0);
INSERT INTO `news_articles` (`id`, `slug`, `category`, `title`, `excerpt`, `body`, `author_name`, `pull_quote`, `pull_quote_by`, `image_path`, `published_at`, `is_featured`) VALUES (5,'okafor-contract-extension-2030','TRANSFER','Defensive powerhouse David Okafor pens contract extension','The international CB locks down his position at the club, extending his tenure through the 2030 season.','The international centre-back locks down his position at the club, extending his tenure through the 2030 season. Okafor has been a cornerstone of the defence since arriving at Aurelia.','Daniel Ross',NULL,NULL,'assets/images/news-okafor.jpg','2026-08-18 09:30:00',0);
INSERT INTO `news_articles` (`id`, `slug`, `category`, `title`, `excerpt`, `body`, `author_name`, `pull_quote`, `pull_quote_by`, `image_path`, `published_at`, `is_featured`) VALUES (6,'u18-national-cup-final','YOUTH ACADEMY','Under-18 squad secures historic national cup final','Our development prospects defeated Stormgate Academy 4-0 to reach the pinnacle cup final this autumn.','Our development prospects defeated Stormgate Academy 4-0 to reach the pinnacle cup final this autumn. The academy coaching staff praised the group\'s maturity and tactical discipline.','Leon Croft',NULL,NULL,'assets/images/news-u18-cup.jpg','2026-08-24 16:00:00',0);
INSERT INTO `news_articles` (`id`, `slug`, `category`, `title`, `excerpt`, `body`, `author_name`, `pull_quote`, `pull_quote_by`, `image_path`, `published_at`, `is_featured`) VALUES (7,'summer-tour-north-america','CLUB NEWS','Announcing international summer tour dates cities','The club embarks on a historic pre-season friendlies series across North America starting mid-July next season.','The club embarks on a historic pre-season friendlies series across North America starting mid-July next season, with fixtures planned in three major cities.','Priya Nair',NULL,NULL,'assets/images/news-summer-tour.jpg','2026-08-15 12:00:00',0);
/*!40000 ALTER TABLE `news_articles` ENABLE KEYS */;

/*!40000 ALTER TABLE `news_tags` DISABLE KEYS */;
INSERT INTO `news_tags` (`id`, `article_id`, `tag`) VALUES (3,2,'#Aurelia Arena');
INSERT INTO `news_tags` (`id`, `article_id`, `tag`) VALUES (1,2,'#Derby');
INSERT INTO `news_tags` (`id`, `article_id`, `tag`) VALUES (4,2,'#Matchday');
INSERT INTO `news_tags` (`id`, `article_id`, `tag`) VALUES (2,2,'#Vane Hat Trick');
/*!40000 ALTER TABLE `news_tags` ENABLE KEYS */;

/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` (`id`, `order_id`, `item_type`, `item_ref_id`, `description`, `quantity`, `unit_price`) VALUES (1,1,'Product',1,'Home Kit 2026/27',2,89.99);
INSERT INTO `order_items` (`id`, `order_id`, `item_type`, `item_ref_id`, `description`, `quantity`, `unit_price`) VALUES (2,2,'MatchTicket',5,'Aurelia FC vs Ironclad United - General',2,35.00);
INSERT INTO `order_items` (`id`, `order_id`, `item_type`, `item_ref_id`, `description`, `quantity`, `unit_price`) VALUES (3,3,'Product',2,'Away Kit 2026/27',3,89.99);
INSERT INTO `order_items` (`id`, `order_id`, `item_type`, `item_ref_id`, `description`, `quantity`, `unit_price`) VALUES (4,4,'Product',2,'Away Kit 2026/27',3,89.99);
INSERT INTO `order_items` (`id`, `order_id`, `item_type`, `item_ref_id`, `description`, `quantity`, `unit_price`) VALUES (5,5,'Product',2,'Away Kit 2026/27',3,89.99);
INSERT INTO `order_items` (`id`, `order_id`, `item_type`, `item_ref_id`, `description`, `quantity`, `unit_price`) VALUES (6,6,'MatchTicket',5,'Aurelia FC vs Ironclad United - General',2,35.00);
INSERT INTO `order_items` (`id`, `order_id`, `item_type`, `item_ref_id`, `description`, `quantity`, `unit_price`) VALUES (7,7,'Product',1,'Home Kit 2026/27',3,89.99);
INSERT INTO `order_items` (`id`, `order_id`, `item_type`, `item_ref_id`, `description`, `quantity`, `unit_price`) VALUES (8,8,'Product',1,'Home Kit 2026/27',1,89.99);
INSERT INTO `order_items` (`id`, `order_id`, `item_type`, `item_ref_id`, `description`, `quantity`, `unit_price`) VALUES (9,9,'Product',1,'Home Kit 2026/27',1,89.99);
INSERT INTO `order_items` (`id`, `order_id`, `item_type`, `item_ref_id`, `description`, `quantity`, `unit_price`) VALUES (10,10,'Product',1,'Home Kit 2026/27',1,89.99);
INSERT INTO `order_items` (`id`, `order_id`, `item_type`, `item_ref_id`, `description`, `quantity`, `unit_price`) VALUES (11,11,'Product',1,'Home Kit 2026/27',2,89.99);
INSERT INTO `order_items` (`id`, `order_id`, `item_type`, `item_ref_id`, `description`, `quantity`, `unit_price`) VALUES (12,12,'Product',1,'Home Kit 2026/27',3,89.99);
INSERT INTO `order_items` (`id`, `order_id`, `item_type`, `item_ref_id`, `description`, `quantity`, `unit_price`) VALUES (13,13,'Product',1,'Home Kit 2026/27',1,89.99);
INSERT INTO `order_items` (`id`, `order_id`, `item_type`, `item_ref_id`, `description`, `quantity`, `unit_price`) VALUES (14,14,'Product',1,'Home Kit 2026/27',1,89.99);
INSERT INTO `order_items` (`id`, `order_id`, `item_type`, `item_ref_id`, `description`, `quantity`, `unit_price`) VALUES (15,15,'Product',1,'Home Kit 2026/27',1,89.99);
INSERT INTO `order_items` (`id`, `order_id`, `item_type`, `item_ref_id`, `description`, `quantity`, `unit_price`) VALUES (16,16,'Product',1,'Home Kit 2026/27',2,89.99);
INSERT INTO `order_items` (`id`, `order_id`, `item_type`, `item_ref_id`, `description`, `quantity`, `unit_price`) VALUES (17,17,'Product',1,'Home Kit 2026/27',3,89.99);
INSERT INTO `order_items` (`id`, `order_id`, `item_type`, `item_ref_id`, `description`, `quantity`, `unit_price`) VALUES (18,18,'Product',1,'Home Kit 2026/27',1,89.99);
INSERT INTO `order_items` (`id`, `order_id`, `item_type`, `item_ref_id`, `description`, `quantity`, `unit_price`) VALUES (19,19,'Product',1,'Home Kit 2026/27',1,89.99);
INSERT INTO `order_items` (`id`, `order_id`, `item_type`, `item_ref_id`, `description`, `quantity`, `unit_price`) VALUES (20,20,'Product',1,'Home Kit 2026/27',1,89.99);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;

/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` (`id`, `user_id`, `reference`, `order_type`, `status`, `total_amount`, `created_at`) VALUES (1,2,'AURCJ5FL46S6','Shop','Pending',179.98,'2026-10-21 04:47:44');
INSERT INTO `orders` (`id`, `user_id`, `reference`, `order_type`, `status`, `total_amount`, `created_at`) VALUES (2,NULL,'AURMN6ETQ6GE','Tickets','Pending',70.00,'2026-10-21 04:47:45');
INSERT INTO `orders` (`id`, `user_id`, `reference`, `order_type`, `status`, `total_amount`, `created_at`) VALUES (3,NULL,'AURAX3QX5YNP','Shop','Pending',269.97,'2026-10-21 05:08:55');
INSERT INTO `orders` (`id`, `user_id`, `reference`, `order_type`, `status`, `total_amount`, `created_at`) VALUES (4,NULL,'AUR9HU58X2NW','Shop','Pending',269.97,'2026-10-21 05:09:01');
INSERT INTO `orders` (`id`, `user_id`, `reference`, `order_type`, `status`, `total_amount`, `created_at`) VALUES (5,3,'AUR9YZS5RGLE','Shop','Pending',269.97,'2026-10-21 05:09:56');
INSERT INTO `orders` (`id`, `user_id`, `reference`, `order_type`, `status`, `total_amount`, `created_at`) VALUES (6,3,'AUR27P4VCGRF','Tickets','Pending',70.00,'2026-10-21 05:09:56');
INSERT INTO `orders` (`id`, `user_id`, `reference`, `order_type`, `status`, `total_amount`, `created_at`) VALUES (7,4,'AUR9JHJVWWMN','Shop','Pending',269.97,'2026-10-21 05:19:44');
INSERT INTO `orders` (`id`, `user_id`, `reference`, `order_type`, `status`, `total_amount`, `created_at`) VALUES (8,5,'AURWTRAL6SHN','Shop','Pending',89.99,'2026-10-21 05:19:46');
INSERT INTO `orders` (`id`, `user_id`, `reference`, `order_type`, `status`, `total_amount`, `created_at`) VALUES (9,NULL,'AURKHJK27R7S','Shop','Pending',89.99,'2026-10-21 05:19:46');
INSERT INTO `orders` (`id`, `user_id`, `reference`, `order_type`, `status`, `total_amount`, `created_at`) VALUES (10,7,'AURKRJ65XU5L','Shop','Pending',89.99,'2026-10-21 05:19:48');
INSERT INTO `orders` (`id`, `user_id`, `reference`, `order_type`, `status`, `total_amount`, `created_at`) VALUES (11,11,'AURT4ABAXZDY','Shop','Pending',179.98,'2026-10-21 05:21:03');
INSERT INTO `orders` (`id`, `user_id`, `reference`, `order_type`, `status`, `total_amount`, `created_at`) VALUES (12,12,'AURA7G837B8Q','Shop','Pending',269.97,'2026-10-21 05:22:31');
INSERT INTO `orders` (`id`, `user_id`, `reference`, `order_type`, `status`, `total_amount`, `created_at`) VALUES (13,13,'AURAUDBX9ZCM','Shop','Pending',89.99,'2026-10-21 05:22:32');
INSERT INTO `orders` (`id`, `user_id`, `reference`, `order_type`, `status`, `total_amount`, `created_at`) VALUES (14,NULL,'AURVVKVS44GL','Shop','Pending',89.99,'2026-10-21 05:22:32');
INSERT INTO `orders` (`id`, `user_id`, `reference`, `order_type`, `status`, `total_amount`, `created_at`) VALUES (15,15,'AURPEMCYK7LW','Shop','Pending',89.99,'2026-10-21 05:22:33');
INSERT INTO `orders` (`id`, `user_id`, `reference`, `order_type`, `status`, `total_amount`, `created_at`) VALUES (16,19,'AUR7XVZJVYCU','Shop','Pending',179.98,'2026-10-21 09:13:07');
INSERT INTO `orders` (`id`, `user_id`, `reference`, `order_type`, `status`, `total_amount`, `created_at`) VALUES (17,20,'AUR7B8TXRFAZ','Shop','Pending',269.97,'2026-10-21 09:17:23');
INSERT INTO `orders` (`id`, `user_id`, `reference`, `order_type`, `status`, `total_amount`, `created_at`) VALUES (18,21,'AURNZ5Y6TYLC','Shop','Pending',89.99,'2026-10-21 09:17:25');
INSERT INTO `orders` (`id`, `user_id`, `reference`, `order_type`, `status`, `total_amount`, `created_at`) VALUES (19,NULL,'AURXNFSUENGC','Shop','Pending',89.99,'2026-10-21 09:17:26');
INSERT INTO `orders` (`id`, `user_id`, `reference`, `order_type`, `status`, `total_amount`, `created_at`) VALUES (20,23,'AUR9DRV5AFY4','Shop','Pending',89.99,'2026-10-21 09:17:30');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;

/*!40000 ALTER TABLE `partners` DISABLE KEYS */;
INSERT INTO `partners` (`id`, `name`, `sort_order`) VALUES (1,'AURELIA AIRWAYS',1);
INSERT INTO `partners` (`id`, `name`, `sort_order`) VALUES (2,'AMBER TRUST',2);
INSERT INTO `partners` (`id`, `name`, `sort_order`) VALUES (3,'ROYAL SPORTS',3);
INSERT INTO `partners` (`id`, `name`, `sort_order`) VALUES (4,'SPRING WATER',4);
INSERT INTO `partners` (`id`, `name`, `sort_order`) VALUES (5,'STADIUM GROUP',5);
/*!40000 ALTER TABLE `partners` ENABLE KEYS */;

/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;

/*!40000 ALTER TABLE `player_career_history` DISABLE KEYS */;
INSERT INTO `player_career_history` (`id`, `player_id`, `club_name`, `period`, `appearances`, `goals`, `note`, `sort_order`) VALUES (1,6,'Aurelia FC','2023 - Present',74,48,NULL,1);
INSERT INTO `player_career_history` (`id`, `player_id`, `club_name`, `period`, `appearances`, `goals`, `note`, `sort_order`) VALUES (2,6,'Ironclad United','2020 - 2023',92,35,NULL,2);
INSERT INTO `player_career_history` (`id`, `player_id`, `club_name`, `period`, `appearances`, `goals`, `note`, `sort_order`) VALUES (3,6,'Crestwood Youth','2018 - 2020',NULL,NULL,'Graduate Academy',3);
/*!40000 ALTER TABLE `player_career_history` ENABLE KEYS */;

/*!40000 ALTER TABLE `player_season_stats` DISABLE KEYS */;
INSERT INTO `player_season_stats` (`id`, `player_id`, `season`, `month_label`, `sort_order`, `apps`, `goals`, `assists`) VALUES (1,6,'2026/2027','September 2026',1,2,3,1);
INSERT INTO `player_season_stats` (`id`, `player_id`, `season`, `month_label`, `sort_order`, `apps`, `goals`, `assists`) VALUES (2,6,'2026/2027','August 2026',2,4,4,2);
INSERT INTO `player_season_stats` (`id`, `player_id`, `season`, `month_label`, `sort_order`, `apps`, `goals`, `assists`) VALUES (3,6,'2026/2027','May 2026',3,5,5,3);
INSERT INTO `player_season_stats` (`id`, `player_id`, `season`, `month_label`, `sort_order`, `apps`, `goals`, `assists`) VALUES (4,6,'2026/2027','April 2026',4,6,8,2);
/*!40000 ALTER TABLE `player_season_stats` ENABLE KEYS */;

/*!40000 ALTER TABLE `players` DISABLE KEYS */;
INSERT INTO `players` (`id`, `team_id`, `position_id`, `squad_number`, `first_name`, `last_name`, `nationality`, `date_of_birth`, `height_cm`, `bio`, `image_path`, `goals`, `assists`, `appearances`, `avg_rating`) VALUES (1,1,1,1,'Thomas','Reign','GBR','1996-03-14',191,'Commanding shot-stopper with outstanding distribution and a calm presence under pressure.','assets/images/squad-thomas-reign.jpg',0,0,34,7.60);
INSERT INTO `players` (`id`, `team_id`, `position_id`, `squad_number`, `first_name`, `last_name`, `nationality`, `date_of_birth`, `height_cm`, `bio`, `image_path`, `goals`, `assists`, `appearances`, `avg_rating`) VALUES (2,1,2,4,'David','Okafor','NGA','1998-07-22',188,'The international centre-back locks down his position at the club, extending his tenure through the 2030 season.','assets/images/squad-david-okafor.jpg',3,2,33,7.80);
INSERT INTO `players` (`id`, `team_id`, `position_id`, `squad_number`, `first_name`, `last_name`, `nationality`, `date_of_birth`, `height_cm`, `bio`, `image_path`, `goals`, `assists`, `appearances`, `avg_rating`) VALUES (3,1,2,5,'Lena','Hartwell','USA','1999-11-02',180,'Aggressive slide-tackling defender who reads the game and starts attacks from the back.','assets/images/squad-lena-hartwell.jpg',2,4,31,7.70);
INSERT INTO `players` (`id`, `team_id`, `position_id`, `squad_number`, `first_name`, `last_name`, `nationality`, `date_of_birth`, `height_cm`, `bio`, `image_path`, `goals`, `assists`, `appearances`, `avg_rating`) VALUES (4,1,3,7,'Elena','Cross','ESP','1997-05-30',172,'Creative midfielder with a lethal direct free kick and an exceptional eye for a line-breaking pass.','assets/images/squad-elena-cross.jpg',9,12,36,8.10);
INSERT INTO `players` (`id`, `team_id`, `position_id`, `squad_number`, `first_name`, `last_name`, `nationality`, `date_of_birth`, `height_cm`, `bio`, `image_path`, `goals`, `assists`, `appearances`, `avg_rating`) VALUES (5,1,3,8,'James','Kato','JPN','2000-01-18',176,'Tireless engine in midfield, covers every blade of grass and links defence to attack.','assets/images/squad-james-kato.jpg',5,8,32,7.50);
INSERT INTO `players` (`id`, `team_id`, `position_id`, `squad_number`, `first_name`, `last_name`, `nationality`, `date_of_birth`, `height_cm`, `bio`, `image_path`, `goals`, `assists`, `appearances`, `avg_rating`) VALUES (6,1,4,9,'Marcus','Vane','ENG','1999-08-09',183,'An exceptional athlete with blistering speed and outstanding predatory instincts in the final third. Vane joined Aurelia FC and quickly cemented himself as a core tactical anchor.','assets/images/squad-marcus-vane.jpg',28,12,38,4.20);
INSERT INTO `players` (`id`, `team_id`, `position_id`, `squad_number`, `first_name`, `last_name`, `nationality`, `date_of_birth`, `height_cm`, `bio`, `image_path`, `goals`, `assists`, `appearances`, `avg_rating`) VALUES (7,1,4,10,'Sofia','Almeida','BRA','2001-04-27',170,'Technically gifted forward capable of unlocking any defence with a moment of brilliance.','assets/images/squad-sofia-almeida.jpg',14,7,30,7.90);
INSERT INTO `players` (`id`, `team_id`, `position_id`, `squad_number`, `first_name`, `last_name`, `nationality`, `date_of_birth`, `height_cm`, `bio`, `image_path`, `goals`, `assists`, `appearances`, `avg_rating`) VALUES (8,1,4,11,'Riku','Tanaka','JPN','2002-09-15',175,'Rapid winger who thrives on the counter and delivers pinpoint crosses.','assets/images/squad-riku-tanaka.jpg',11,10,29,7.65);
INSERT INTO `players` (`id`, `team_id`, `position_id`, `squad_number`, `first_name`, `last_name`, `nationality`, `date_of_birth`, `height_cm`, `bio`, `image_path`, `goals`, `assists`, `appearances`, `avg_rating`) VALUES (9,2,1,1,'Peter','Hale','GBR',NULL,NULL,NULL,NULL,0,0,18,7.10);
INSERT INTO `players` (`id`, `team_id`, `position_id`, `squad_number`, `first_name`, `last_name`, `nationality`, `date_of_birth`, `height_cm`, `bio`, `image_path`, `goals`, `assists`, `appearances`, `avg_rating`) VALUES (10,2,2,4,'Owen','Marsh','GBR',NULL,NULL,NULL,NULL,1,1,20,7.00);
INSERT INTO `players` (`id`, `team_id`, `position_id`, `squad_number`, `first_name`, `last_name`, `nationality`, `date_of_birth`, `height_cm`, `bio`, `image_path`, `goals`, `assists`, `appearances`, `avg_rating`) VALUES (11,2,3,8,'Kofi','Boateng','GHA',NULL,NULL,NULL,NULL,4,5,21,7.30);
INSERT INTO `players` (`id`, `team_id`, `position_id`, `squad_number`, `first_name`, `last_name`, `nationality`, `date_of_birth`, `height_cm`, `bio`, `image_path`, `goals`, `assists`, `appearances`, `avg_rating`) VALUES (12,2,4,9,'Luca','Moretti','ITA',NULL,NULL,NULL,NULL,12,4,22,7.55);
INSERT INTO `players` (`id`, `team_id`, `position_id`, `squad_number`, `first_name`, `last_name`, `nationality`, `date_of_birth`, `height_cm`, `bio`, `image_path`, `goals`, `assists`, `appearances`, `avg_rating`) VALUES (13,3,2,5,'Ivan','Petrov','BUL',NULL,NULL,NULL,NULL,1,2,16,6.95);
INSERT INTO `players` (`id`, `team_id`, `position_id`, `squad_number`, `first_name`, `last_name`, `nationality`, `date_of_birth`, `height_cm`, `bio`, `image_path`, `goals`, `assists`, `appearances`, `avg_rating`) VALUES (14,3,3,10,'Noah','Berg','SWE',NULL,NULL,NULL,NULL,7,6,19,7.40);
INSERT INTO `players` (`id`, `team_id`, `position_id`, `squad_number`, `first_name`, `last_name`, `nationality`, `date_of_birth`, `height_cm`, `bio`, `image_path`, `goals`, `assists`, `appearances`, `avg_rating`) VALUES (15,3,4,11,'Diego','Santos','POR',NULL,NULL,NULL,NULL,9,3,18,7.35);
INSERT INTO `players` (`id`, `team_id`, `position_id`, `squad_number`, `first_name`, `last_name`, `nationality`, `date_of_birth`, `height_cm`, `bio`, `image_path`, `goals`, `assists`, `appearances`, `avg_rating`) VALUES (16,4,1,1,'Sam','Whitlock','GBR',NULL,NULL,NULL,NULL,0,0,14,6.90);
INSERT INTO `players` (`id`, `team_id`, `position_id`, `squad_number`, `first_name`, `last_name`, `nationality`, `date_of_birth`, `height_cm`, `bio`, `image_path`, `goals`, `assists`, `appearances`, `avg_rating`) VALUES (17,4,2,3,'Tariq','Rahman','PAK',NULL,NULL,NULL,NULL,1,1,15,6.85);
INSERT INTO `players` (`id`, `team_id`, `position_id`, `squad_number`, `first_name`, `last_name`, `nationality`, `date_of_birth`, `height_cm`, `bio`, `image_path`, `goals`, `assists`, `appearances`, `avg_rating`) VALUES (18,4,3,8,'Felix','Nolan','IRL',NULL,NULL,NULL,NULL,5,4,16,7.20);
INSERT INTO `players` (`id`, `team_id`, `position_id`, `squad_number`, `first_name`, `last_name`, `nationality`, `date_of_birth`, `height_cm`, `bio`, `image_path`, `goals`, `assists`, `appearances`, `avg_rating`) VALUES (19,4,4,9,'Andre','Costa','BRA',NULL,NULL,NULL,NULL,8,2,15,7.25);
INSERT INTO `players` (`id`, `team_id`, `position_id`, `squad_number`, `first_name`, `last_name`, `nationality`, `date_of_birth`, `height_cm`, `bio`, `image_path`, `goals`, `assists`, `appearances`, `avg_rating`) VALUES (20,5,1,1,'Grace','Bell','GBR',NULL,NULL,NULL,NULL,0,0,22,7.45);
INSERT INTO `players` (`id`, `team_id`, `position_id`, `squad_number`, `first_name`, `last_name`, `nationality`, `date_of_birth`, `height_cm`, `bio`, `image_path`, `goals`, `assists`, `appearances`, `avg_rating`) VALUES (21,5,2,6,'Nadia','Farah','MAR',NULL,NULL,NULL,NULL,2,3,23,7.55);
INSERT INTO `players` (`id`, `team_id`, `position_id`, `squad_number`, `first_name`, `last_name`, `nationality`, `date_of_birth`, `height_cm`, `bio`, `image_path`, `goals`, `assists`, `appearances`, `avg_rating`) VALUES (22,5,3,8,'Emily','Shaw','GBR',NULL,NULL,NULL,NULL,6,9,23,7.70);
INSERT INTO `players` (`id`, `team_id`, `position_id`, `squad_number`, `first_name`, `last_name`, `nationality`, `date_of_birth`, `height_cm`, `bio`, `image_path`, `goals`, `assists`, `appearances`, `avg_rating`) VALUES (23,5,4,9,'Amara','Diallo','SEN',NULL,NULL,NULL,NULL,18,6,23,8.05);
INSERT INTO `players` (`id`, `team_id`, `position_id`, `squad_number`, `first_name`, `last_name`, `nationality`, `date_of_birth`, `height_cm`, `bio`, `image_path`, `goals`, `assists`, `appearances`, `avg_rating`) VALUES (24,6,2,5,'Zoe','Kirby','GBR',NULL,NULL,NULL,NULL,1,2,17,7.05);
INSERT INTO `players` (`id`, `team_id`, `position_id`, `squad_number`, `first_name`, `last_name`, `nationality`, `date_of_birth`, `height_cm`, `bio`, `image_path`, `goals`, `assists`, `appearances`, `avg_rating`) VALUES (25,6,3,7,'Mia','Larsen','DEN',NULL,NULL,NULL,NULL,5,5,19,7.30);
INSERT INTO `players` (`id`, `team_id`, `position_id`, `squad_number`, `first_name`, `last_name`, `nationality`, `date_of_birth`, `height_cm`, `bio`, `image_path`, `goals`, `assists`, `appearances`, `avg_rating`) VALUES (26,6,4,11,'Chiara','Rossi','ITA',NULL,NULL,NULL,NULL,10,4,19,7.40);
/*!40000 ALTER TABLE `players` ENABLE KEYS */;

/*!40000 ALTER TABLE `positions` DISABLE KEYS */;
INSERT INTO `positions` (`id`, `name`) VALUES (2,'Defender');
INSERT INTO `positions` (`id`, `name`) VALUES (4,'Forward');
INSERT INTO `positions` (`id`, `name`) VALUES (1,'Goalkeeper');
INSERT INTO `positions` (`id`, `name`) VALUES (3,'Midfielder');
/*!40000 ALTER TABLE `positions` ENABLE KEYS */;

/*!40000 ALTER TABLE `product_categories` DISABLE KEYS */;
INSERT INTO `product_categories` (`id`, `name`, `sort_order`) VALUES (1,'Kits',1);
INSERT INTO `product_categories` (`id`, `name`, `sort_order`) VALUES (2,'Training',2);
INSERT INTO `product_categories` (`id`, `name`, `sort_order`) VALUES (3,'Accessories',3);
INSERT INTO `product_categories` (`id`, `name`, `sort_order`) VALUES (4,'Lifestyle',4);
/*!40000 ALTER TABLE `product_categories` ENABLE KEYS */;

/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` (`id`, `category_id`, `name`, `price`, `image_path`, `badge`, `is_featured`, `description`, `sort_order`) VALUES (1,1,'Home Kit 2026/27',89.99,'assets/images/product-home-kit.jpg','NEW ARRIVAL',1,'Authentic design crafted for performance. Features royal gold detailing on historic midnight navy.',1);
INSERT INTO `products` (`id`, `category_id`, `name`, `price`, `image_path`, `badge`, `is_featured`, `description`, `sort_order`) VALUES (2,1,'Away Kit 2026/27',89.99,'assets/images/product-away-kit.jpg',NULL,0,'Lightweight away kit built for speed.',2);
INSERT INTO `products` (`id`, `category_id`, `name`, `price`, `image_path`, `badge`, `is_featured`, `description`, `sort_order`) VALUES (3,1,'Third Kit 2026/27',79.99,'assets/images/product-third-kit.jpg',NULL,0,'Bold third kit for European nights.',3);
INSERT INTO `products` (`id`, `category_id`, `name`, `price`, `image_path`, `badge`, `is_featured`, `description`, `sort_order`) VALUES (4,2,'Training Jersey',49.99,'assets/images/product-training-jersey.jpg',NULL,0,'Breathable training jersey worn by the first team.',4);
INSERT INTO `products` (`id`, `category_id`, `name`, `price`, `image_path`, `badge`, `is_featured`, `description`, `sort_order`) VALUES (5,2,'Track Jacket',64.99,'assets/images/product-track-jacket.jpg',NULL,0,'Full-zip track jacket with club crest.',5);
INSERT INTO `products` (`id`, `category_id`, `name`, `price`, `image_path`, `badge`, `is_featured`, `description`, `sort_order`) VALUES (6,3,'Scarf',19.99,'assets/images/product-scarf.jpg',NULL,0,'Woven royal scarf in club colours.',6);
INSERT INTO `products` (`id`, `category_id`, `name`, `price`, `image_path`, `badge`, `is_featured`, `description`, `sort_order`) VALUES (7,3,'Cap',24.99,'assets/images/product-cap.jpg',NULL,0,'Adjustable cap with embroidered crest.',7);
INSERT INTO `products` (`id`, `category_id`, `name`, `price`, `image_path`, `badge`, `is_featured`, `description`, `sort_order`) VALUES (8,3,'Football',29.99,'assets/images/product-football.jpg',NULL,0,'Official match ball replica.',8);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;

/*!40000 ALTER TABLE `quick_links` DISABLE KEYS */;
INSERT INTO `quick_links` (`id`, `label`, `href`, `sort_order`) VALUES (1,'Latest Tickets','/tickets',1);
INSERT INTO `quick_links` (`id`, `label`, `href`, `sort_order`) VALUES (2,'Club Membership','/signup',2);
INSERT INTO `quick_links` (`id`, `label`, `href`, `sort_order`) VALUES (3,'Hospitality Suites','/tickets#hospitality',3);
INSERT INTO `quick_links` (`id`, `label`, `href`, `sort_order`) VALUES (4,'Online Shop','/shop',4);
/*!40000 ALTER TABLE `quick_links` ENABLE KEYS */;

/*!40000 ALTER TABLE `season_ticket_features` DISABLE KEYS */;
INSERT INTO `season_ticket_features` (`id`, `tier_id`, `feature`, `sort_order`) VALUES (1,1,'All Home League fixtures',1);
INSERT INTO `season_ticket_features` (`id`, `tier_id`, `feature`, `sort_order`) VALUES (2,1,'10% online store discount',2);
INSERT INTO `season_ticket_features` (`id`, `tier_id`, `feature`, `sort_order`) VALUES (3,1,'Priority booking for Cup matches',3);
INSERT INTO `season_ticket_features` (`id`, `tier_id`, `feature`, `sort_order`) VALUES (4,2,'Best midfield tier seats',1);
INSERT INTO `season_ticket_features` (`id`, `tier_id`, `feature`, `sort_order`) VALUES (5,2,'Complimentary Match Program',2);
INSERT INTO `season_ticket_features` (`id`, `tier_id`, `feature`, `sort_order`) VALUES (6,2,'Access to exclusive members lounge',3);
INSERT INTO `season_ticket_features` (`id`, `tier_id`, `feature`, `sort_order`) VALUES (7,2,'15% store discount',4);
INSERT INTO `season_ticket_features` (`id`, `tier_id`, `feature`, `sort_order`) VALUES (8,3,'Luxury padded VIP seats',1);
INSERT INTO `season_ticket_features` (`id`, `tier_id`, `feature`, `sort_order`) VALUES (9,3,'Complimentary dining & drinks',2);
INSERT INTO `season_ticket_features` (`id`, `tier_id`, `feature`, `sort_order`) VALUES (10,3,'Pre-match team insights',3);
INSERT INTO `season_ticket_features` (`id`, `tier_id`, `feature`, `sort_order`) VALUES (11,3,'VIP stadium parking spot',4);
/*!40000 ALTER TABLE `season_ticket_features` ENABLE KEYS */;

/*!40000 ALTER TABLE `season_ticket_tiers` DISABLE KEYS */;
INSERT INTO `season_ticket_tiers` (`id`, `name`, `price`, `description`, `sort_order`) VALUES (1,'Standard',450.00,'Secure entry to all 19 Premier Division home fixtures.',1);
INSERT INTO `season_ticket_tiers` (`id`, `name`, `price`, `description`, `sort_order`) VALUES (2,'Premium',750.00,'Exquisite midfield seating and complimentary match programs.',2);
INSERT INTO `season_ticket_tiers` (`id`, `name`, `price`, `description`, `sort_order`) VALUES (3,'VIP',1200.00,'Ultimate experience with stadium lounge access and VIP parking.',3);
/*!40000 ALTER TABLE `season_ticket_tiers` ENABLE KEYS */;

/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
INSERT INTO `teams` (`id`, `name`, `coach`, `player_count`, `description`, `image_path`, `sort_order`) VALUES (1,'First Team','Adrianna Vance',25,'The senior squad competing in the Premier Division.','assets/images/team-first.jpg',1);
INSERT INTO `teams` (`id`, `name`, `coach`, `player_count`, `description`, `image_path`, `sort_order`) VALUES (2,'Reserve Team','David Sterling',22,'Development squad feeding the first team.','assets/images/team-reserve.jpg',2);
INSERT INTO `teams` (`id`, `name`, `coach`, `player_count`, `description`, `image_path`, `sort_order`) VALUES (3,'U-21 Academy','Marcus Thorne',20,'Elite pathway for emerging professional talent.','assets/images/team-u21.jpg',3);
INSERT INTO `teams` (`id`, `name`, `coach`, `player_count`, `description`, `image_path`, `sort_order`) VALUES (4,'U-18 Academy','Leon Croft',18,'Foundation age group focused on technical mastery.','assets/images/team-u18.jpg',4);
INSERT INTO `teams` (`id`, `name`, `coach`, `player_count`, `description`, `image_path`, `sort_order`) VALUES (5,'Women\'s First Team','Sarah Jenkins',23,'Senior women\'s squad in the national top flight.','assets/images/team-women-first.jpg',5);
INSERT INTO `teams` (`id`, `name`, `coach`, `player_count`, `description`, `image_path`, `sort_order`) VALUES (6,'Women\'s Reserve','Elena Rostov',19,'Women\'s development and reserve squad.','assets/images/team-women-reserve.jpg',6);
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;

/*!40000 ALTER TABLE `ticket_fixtures` DISABLE KEYS */;
INSERT INTO `ticket_fixtures` (`id`, `match_id`, `price_min`, `price_max`, `available_seats`, `status_label`) VALUES (1,2,35.00,85.00,12,'Selling Fast');
INSERT INTO `ticket_fixtures` (`id`, `match_id`, `price_min`, `price_max`, `available_seats`, `status_label`) VALUES (2,5,40.00,95.00,24,'Selling Fast');
INSERT INTO `ticket_fixtures` (`id`, `match_id`, `price_min`, `price_max`, `available_seats`, `status_label`) VALUES (3,3,25.00,65.00,32,'Available');
INSERT INTO `ticket_fixtures` (`id`, `match_id`, `price_min`, `price_max`, `available_seats`, `status_label`) VALUES (4,4,30.00,75.00,18,'Selling Fast');
/*!40000 ALTER TABLE `ticket_fixtures` ENABLE KEYS */;

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (1,'Test','Supporter','supporter166655010@example.com','$2a$11$VpBF/r7a38F9/hdV.PuRKOipdS7LjfDg1mM65oQCpwxavIC3UPIJ6','Member','2026-10-21 04:46:55','2026-10-21 04:46:55');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (2,'Test','Buyer','buyer89067272@example.com','$2a$11$ggWHzyvBejgQ/dphdMC3EOVJuhdKsqAmFvUONMiAQlfDfyWaOuCX.','Member','2026-10-21 04:47:44','2026-10-21 04:47:44');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (3,'Vera','Lint','ui.final.1792559395424@example.com','$2a$11$XwvrA4HcarYG5wuFffDmmOoKIbxRvYy9GyAJqWMo6Ek9bUudmcZK2','Member','2026-10-21 05:09:56','2026-10-21 05:09:56');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (4,'Ada','Lovelace','it-fc72fa2c692b4e47ba704146c2892aba@example.com','$2a$11$T564puAy00dy8kWvvPEd.emjoHdIJIFnEQpYB02ByenVq0QWCGANC','Member','2026-10-21 05:19:44','2026-10-21 05:19:44');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (5,'Ada','Lovelace','it-2332b4407c4c48119f642925c982a6d7@example.com','$2a$11$bbOPRuONmyvUElObIKuRZ.czM3duToeuJxZPi6rWG4udYraDrULu2','Member','2026-10-21 05:19:46','2026-10-21 05:19:46');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (6,'Ada','Lovelace','it-46dcaab3be384050b5b9cd0049dccbec@example.com','$2a$11$fuNADycXtiIj5yPErmlOeeRXPfAAKIhi/dHfznmH3MyjZ2JaDWbW6','Member','2026-10-21 05:19:46','2026-10-21 05:19:46');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (7,'Ada','Lovelace','it-18676743e0794c8c945f0c42bb825177@example.com','$2a$11$AAFKmsVNuaUccOd6oh/FWeTOXmasJVS7RiSFg5bI/JNw0kOhPnfPK','Member','2026-10-21 05:19:48','2026-10-21 05:19:48');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (8,'Ada','Lovelace','it-3b5dac000c5545819bfcdc66b2f24db7@example.com','$2a$11$NrVUf0.obKGmupzuBa/JZ.4BXRjAaBglacK2GcoJtPqgOh0vQN0bG','Member','2026-10-21 05:19:48','2026-10-21 05:19:48');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (9,'Ada','Lovelace','it-c1b132242ad34c48bd9109f30019f954@example.com','$2a$11$yTKZ52syy.YxOylY5n5ZHeyAkOBJ0sERR8dySUvx0.OHvzCFaK7My','Member','2026-10-21 05:19:49','2026-10-21 05:19:49');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (10,'Ada','Lovelace','it-dup-f5c1000477a34525b756716e2fb4215d@example.com','$2a$11$eYlh1Mb4J5Wo2Oy8gPxbau4gesIl20biZ9M0PxR913yd87.pjgO6i','Member','2026-10-21 05:19:50','2026-10-21 05:19:50');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (11,'Flow','Tester','flow-1792560059708@example.com','$2a$11$iXU9Ij.rKlZ93SWYL4A8iuY1vm0reGFQhBNrzG7s2qmS834OtS72.','Member','2026-10-21 05:21:01','2026-10-21 05:21:01');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (12,'Ada','Lovelace','it-7498323226c5414ca24205d5176e9e8f@example.com','$2a$11$eTyIZDQlEFLyGEzkEzThW.S.9Mw6TEfMdrveAqPKYB5t5zd433f36','Member','2026-10-21 05:22:30','2026-10-21 05:22:30');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (13,'Ada','Lovelace','it-8a96485f734743db9bae27754a2367af@example.com','$2a$11$3ukKvF8djyyXSe0cPB4s1.cGIIhz8/Rr1tV90bPiMGHRD5N1k.9Eu','Member','2026-10-21 05:22:32','2026-10-21 05:22:32');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (14,'Ada','Lovelace','it-3a5d63350edd4d739972b14b0be280a0@example.com','$2a$11$csPg9JDjaNJHwKAGt6vlNufcESB7zXLnS11W/mrIoum2EKto2tI6G','Member','2026-10-21 05:22:32','2026-10-21 05:22:32');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (15,'Ada','Lovelace','it-180c0d92958d446abf62b1f228feae39@example.com','$2a$11$XFw88eKQWuhm.yYaeDUChuqMn5gwHUyss2n7WG22RJQ0Xu5pwnqdW','Member','2026-10-21 05:22:33','2026-10-21 05:22:33');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (16,'Ada','Lovelace','it-cdbc2bc6ab0345a288e12ddcd3de8af6@example.com','$2a$11$CG1CD0tcq2NCCYO4GxhoXOUB15fjUkLFplLU4iKCDOziExJoxXdVS','Member','2026-10-21 05:22:33','2026-10-21 05:22:33');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (17,'Ada','Lovelace','it-d26761cffee2426a9dd95025f1c451cd@example.com','$2a$11$z.AzzDn.ewGipL0zWbJ6vuDrCBl7H5mgu.xPgbLpdAjqbMTvcAZca','Member','2026-10-21 05:22:34','2026-10-21 05:22:34');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (18,'Ada','Lovelace','it-dup-b5c91852e0e84a6bb788e2b9a9a62443@example.com','$2a$11$BaqpFSDhP8nVdouRm6tH3.UTumiUc7Ujx/1eeI9BIPb1ol3IyMG3i','Member','2026-10-21 05:22:34','2026-10-21 05:22:34');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (19,'Ada','Lovelace','wftest-1792573984657@example.com','$2a$11$sjQWoiHN3ky.NI3ibpGMZOnMkkO7KiumQ.Kk14cXW1W/1f.6p3/Ai','Member','2026-10-21 09:13:05','2026-10-21 09:13:05');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (20,'Ada','Lovelace','it-5266b148708847ba8b9695888b4e3921@example.com','$2a$11$XQPRX2l2g/TN0/qS8zFxWeRXkhJa2XDYYLkjyQhY3derrJ6RD4Eou','Member','2026-10-21 09:17:22','2026-10-21 09:17:22');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (21,'Ada','Lovelace','it-fa2e2acde99b4290934d4d4aa47bc9ac@example.com','$2a$11$I91e4dLfqVXevuSngTmIou4/bvW.lQhdAnY82djYrxnjcS41w9zXi','Member','2026-10-21 09:17:25','2026-10-21 09:17:25');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (22,'Ada','Lovelace','it-7f934e4ffa3e49f1af1d53faeb1bc0b5@example.com','$2a$11$McXMYgp8lsx4luyn2t3FeuSvL2quGEvOviYtErgf0bRy89edLqTFG','Member','2026-10-21 09:17:27','2026-10-21 09:17:27');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (23,'Ada','Lovelace','it-54a53fabb8654e87b1ef2b97648bdf20@example.com','$2a$11$j.HJsZGTh1mVlQM9/uwrg.AMgH7onv70nFwiLGyBSwZbH19s5bNJ6','Member','2026-10-21 09:17:30','2026-10-21 09:17:30');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (24,'Ada','Lovelace','it-024cb5a1e20341eab8e3a871d8265fca@example.com','$2a$11$L.EUNOIDurjpdCr.xrOlf.XaXqUGDiJ0ferZdGv.z/8IH5DdY0Qh.','Member','2026-10-21 09:17:32','2026-10-21 09:17:32');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (25,'Ada','Lovelace','it-895e828892af45a79ab174996c8f317c@example.com','$2a$11$a2RV7ScVQ6ya1jg4bgBV3.U8WRGTObxAMbKr3oYfnV4DiV7ct24DO','Member','2026-10-21 09:17:34','2026-10-21 09:17:34');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `role`, `created_at`, `updated_at`) VALUES (26,'Ada','Lovelace','it-dup-d45248cf365745f19013451ce2031d7f@example.com','$2a$11$AlNZ77IAaC7aUJFfxKg7se4Pe1/hgdt.wNESDpviwXJwcDEUvF4HO','Member','2026-10-21 09:17:38','2026-10-21 09:17:38');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;


