-- MySQL dump 10.11                                     
--                                                      
-- Host: localhost    Database: greylisting             
-- ------------------------------------------------------
-- Server version       5.0.60-log                       

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;  
/*!40101 SET NAMES utf8 */;                                        
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;                        
/*!40103 SET TIME_ZONE='+00:00' */;                                
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;        
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;                           

--
-- Table structure for table `domain_whitelist`
--                                             

DROP TABLE IF EXISTS `domain_whitelist`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;                  
CREATE TABLE `domain_whitelist` (                 
  `id` int(9) NOT NULL auto_increment,            
  `domainname` varchar(64) default NULL,          
  `domain_ip` varchar(16) default NULL,           
  `added_timestamp` int(32) NOT NULL,             
  `last_mail_timestamp` int(32) NOT NULL,         
  `mail_count` int(9) NOT NULL,                   
  PRIMARY KEY  (`id`),                            
  UNIQUE KEY `domainname` (`domainname`,`domain_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;          

--
-- Table structure for table `greylist`
--                                     

DROP TABLE IF EXISTS `greylist`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;                  
CREATE TABLE `greylist` (                         
  `id` bigint(20) NOT NULL auto_increment,        
  `relay_ip` varchar(80) default NULL,            
  `sender` varchar(255) default NULL,             
  `recipient` varchar(255) default NULL,          
  `block_expires` datetime NOT NULL default '0000-00-00 00:00:00',
  `record_expires` datetime NOT NULL default '9999-12-31 23:59:59',
  `create_time` datetime NOT NULL default '0000-00-00 00:00:00',   
  `type` enum('AUTO','MANUAL') NOT NULL default 'MANUAL',          
  `passcount` bigint(20) NOT NULL default '0',                     
  `blockcount` bigint(20) NOT NULL default '0',                    
  PRIMARY KEY  (`id`)                                              
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;         
SET character_set_client = @saved_cs_client;                       

--
-- Table structure for table `greylist_log`
--                                         

DROP TABLE IF EXISTS `greylist_log`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;                  
CREATE TABLE `greylist_log` (                     
  `id` bigint(20) NOT NULL auto_increment,        
  `listid` bigint(20) NOT NULL,                   
  `timestamp` datetime NOT NULL default '0000-00-00 00:00:00',
  `kind` enum('deferred','accepted') NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `sended_list`
--

DROP TABLE IF EXISTS `sended_list`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `sended_list` (
  `id` int(32) NOT NULL auto_increment,
  `user_from` varchar(64) default NULL,
  `user_to` varchar(64) default NULL,
  `added_timestamp` int(32) NOT NULL,
  `last_mail_timestamp` int(32) NOT NULL,
  `mail_count` int(6) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `user_from` (`user_from`,`user_to`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2008-08-16  3:35:23
