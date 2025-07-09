package database

type Stats struct {
	CheckedIn    int
	ArrivedToday int
	LeavingToday int
	Males        int
	Females      int
	Vegetarian   int
	Volunteers   int
}

const getStats = `SELECT * FROM stats;`

func (c Client) GetStats() (*Stats, error) {
	c.log.Println("Getting all the stats")

	row := c.db.QueryRow(getStats)

	var stats Stats

	if err := row.Scan(
		&stats.CheckedIn,
		&stats.ArrivedToday,
		&stats.LeavingToday,
		&stats.Males,
		&stats.Females,
		&stats.Vegetarian,
		&stats.Volunteers,
	); err != nil {
		return nil, err
	}

	if err := row.Err(); err != nil {
		return nil, err
	}

	return &stats, nil
}
