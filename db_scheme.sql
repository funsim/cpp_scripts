CREATE TABLE IF NOT EXISTS `mlab` (
  `id` int NOT NULL AUTO_INCREMENT, 
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date` datetime NOT NULL,
  `destination` varchar(128) NOT NULL,
  `source` varchar(128) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

