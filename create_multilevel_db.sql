/* glasnost_daily */
DROP TABLE IF EXISTS `glasnost_daily`;

CREATE TABLE IF NOT EXISTS `glasnost_daily` (
  `counter` int NOT NULL, 
  `rangedate` datetime NOT NULL,
  `destination` varchar(128) NOT NULL,
  `source` varchar(128) NOT NULL,
  PRIMARY KEY (rangedate, destination, source)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

INSERT INTO glasnost_daily SELECT COUNT(*) as counter, DATE(date) as rangedate, destination, source FROM glasnost GROUP BY destination, source, DATE(rangedate);

/* glasnost_monthly */
DROP TABLE IF EXISTS `glasnost_monthly`;

CREATE TABLE IF NOT EXISTS `glasnost_monthly` (
  `counter` int NOT NULL, 
  `rangedate` datetime NOT NULL,
  `destination` varchar(128) NOT NULL,
  `source` varchar(128) NOT NULL,
  PRIMARY KEY (rangedate, destination, source)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

INSERT INTO glasnost_monthly SELECT COUNT(*) as counter, LAST_DAY(date) as rangedate, destination, source FROM glasnost GROUP BY destination, source, LAST_DAY(rangedate);

/* glasnost_yearly */
DROP TABLE IF EXISTS `glasnost_yearly`;

CREATE TABLE IF NOT EXISTS `glasnost_yearly` (
  `counter` int NOT NULL, 
  `rangedate` datetime NOT NULL,
  `destination` varchar(128) NOT NULL,
  `source` varchar(128) NOT NULL,
  PRIMARY KEY (rangedate, destination, source)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

INSERT INTO glasnost_yearly SELECT COUNT(*) as counter, MAKEDATE(YEAR(date), 1) as rangedate, destination, source FROM glasnost GROUP BY destination, source, MAKEDATE(YEAR(rangedate), 1);
