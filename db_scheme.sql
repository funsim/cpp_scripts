CREATE TABLE IF NOT EXISTS `glasnot` (
  `id` int NOT NULL AUTO_INCREMENT, 
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date` datetime NOT NULL,
  `destination` varchar(128) NOT NULL,
  `source` varchar(128) NOT NULL,
  `file_id` int NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `ndt` (
  `id` int NOT NULL AUTO_INCREMENT, 
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date` datetime NOT NULL,
  `destination` varchar(128) NOT NULL,
  `source` varchar(128) NOT NULL,
  `file_id` int NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `files` (
  `id` int NOT NULL AUTO_INCREMENT, 
  `filename` varchar(256) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;
