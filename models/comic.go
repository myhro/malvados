package models

type Comic struct {
	ID   int    `json:"id"`
	Text string `json:"text"`
	URL  string `json:"url"`
}
