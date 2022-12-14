-- ----------------------------------------
-- SCHEMA  
-- ----------------------------------------
DROP DATABASE IF EXISTS `lokham`;
CREATE DATABASE IF NOT EXISTS `lokham` DEFAULT CHARACTER SET UTF8;
SHOW WARNINGS;
USE `lokham`; 
-- ----------------------------------------
--   Table `users`
-- ----------------------------------------
DROP TABLE IF EXISTS `users`;
SHOW WARNINGS;

CREATE TABLE IF NOT EXISTS `lokham`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(25) NOT NULL DEFAULT '',
  `last_name` VARCHAR(25) NOT NULL DEFAULT '',
  `middle_name` VARCHAR(25) NULL DEFAULT '',
  `profile_image` VARCHAR(255) NULL,
  `phone` VARCHAR(16) NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `role` ENUM('admin', 'general') NOT NULL DEFAULT 'general',
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`)) ENGINE = INNODB DEFAULT CHARSET=UTF8;
  
SHOW WARNINGS;

INSERT INTO `users` (`id`, `first_name`, `last_name`, `middle_name`, `phone`, `email`, `password`, `role`, `created_at`, `updated_at`) VALUES
(1, 'Sourav', 'Patteri', '', '7067910774', 'srv.ptr@gmail.com', '$2y$10$a8AHDsFblwOih1bUTWMtZeRoNbe1EFk9.o7eKNEJ1/lAHox9ZNtUi', 'general',  '2019-11-04 08:50:02', '2019-11-04 15:30:20');
-- ----------------------------------------
--   Table `issues`
-- ----------------------------------------
 
DROP TABLE IF EXISTS `issues`;
CREATE TABLE IF NOT EXISTS `lokham`.`issues` (
	`issue_id` INT NOT NULL AUTO_INCREMENT,
	`user_id` INT NOT NULL,
  `title` varchar(500) NOT NULL,
  `image` VARCHAR(255) NULL,
	`content` TEXT NOT NULL,
	`created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
     PRIMARY KEY (`issue_id`)) ENGINE = INNODB DEFAULT CHARSET=UTF8;
     
-- Constraints for table `issues`

  ALTER TABLE `lokham`.`issues`
  ADD INDEX `fk_users_idx` (`user_id` ASC),
  ADD CONSTRAINT `fk_user`
  FOREIGN KEY (`user_id`)
  REFERENCES `lokham`.`users` (`id`)
  ON UPDATE CASCADE
  ON DELETE CASCADE;
  
INSERT INTO `issues` (`issue_id`, `user_id`, `content`, `created_at`, `updated_at`) VALUES
(1, 1, 'Earth is dying', '2019-11-04 08:50:02', '2019-11-04 15:30:20');

-- ----------------------------------------
--   Table `ratings`
-- ----------------------------------------
 
DROP TABLE IF EXISTS `ratings`;
CREATE TABLE IF NOT EXISTS `lokham`.`ratings` (
	`user_id` INT NOT NULL,
	`issue_id` INT NOT NULL,
	`rating` ENUM('1', '2', '3', '4', '5') NOT NULL,
	`created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  ) ENGINE = INNODB DEFAULT CHARSET=UTF8;
     
-- Constraints for table `ratings`

  ALTER TABLE `lokham`.`ratings`
  ADD INDEX `fk_users_idx` (`user_id` ASC),
  ADD CONSTRAINT `fk_rating_user`
  FOREIGN KEY (`user_id`)
  REFERENCES `lokham`.`users` (`id`)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
  ADD INDEX `fk_issues_idx` (`issue_id` ASC),
  ADD CONSTRAINT `fk_rating_issue`
  FOREIGN KEY (`issue_id`)
  REFERENCES `lokham`.`issues` (`issue_id`)
  ON UPDATE CASCADE
  ON DELETE CASCADE;

INSERT INTO `ratings` (`user_id`, `issue_id`, `rating`, `created_at`, `updated_at`) VALUES
(1, 1, '5', '2019-11-04 08:50:02', '2019-11-04 15:30:20');
-- ----------------------------------------
--   Table `comments`
-- ----------------------------------------

DROP TABLE IF EXISTS `comments`;
SHOW WARNINGS;

CREATE TABLE IF NOT EXISTS `lokham`.`comments` (
  `comment_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `issue_id` INT NOT NULL,
  `comment` TEXT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`)) ENGINE = INNODB DEFAULT CHARSET=UTF8;
  
  -- Constraints for table `comments` 

  ALTER TABLE `lokham`.`comments` 
  ADD INDEX `fk_users_idx` (`user_id` ASC),
  ADD CONSTRAINT `fk_comment_user`
  FOREIGN KEY (`user_id`)
  REFERENCES `lokham`.`users` (`id`)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
  ADD INDEX `fk_issues_idx` (`issue_id` ASC),
  ADD CONSTRAINT `fk_comment_issue`
  FOREIGN KEY (`issue_id`)
  REFERENCES `lokham`.`issues` (`issue_id`)
  ON UPDATE CASCADE
  ON DELETE CASCADE;
  
INSERT INTO `comments` (`comment_id`, `user_id`, `issue_id`, `comment`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'And unless we act right now, we cannot save it', '2019-11-04 08:50:02', '2019-11-04 15:30:20');
