package models

// Comic DB structure for comic strips
type Comic struct {
	ID   int    `json:"id"`
	Text string `json:"text"`
	URL  string `json:"url"`
}
