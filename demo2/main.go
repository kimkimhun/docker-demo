package main

import (
	"log"
	"os"

	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/logger"
)

func main() {
	app := fiber.New(fiber.Config{
		ETag: true,
	})

	app.Use(logger.New(logger.Config{
		Format:     "TIME: ${time} IP: ${ip} HOST: ${host} ${method} - ${status} ${path} LATENCY: ${latency}\n",
		TimeFormat: "2006-01-01 15:04:05",
	}))

	app.Get("/", func(c *fiber.Ctx) error {
		return c.SendString("Hello world! from " + c.Hostname())
	})

	app.Get("/health", func(c *fiber.Ctx) error {
		return c.SendString("Health OK!")
	})

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	log.Fatal(app.Listen(":" + port))

	app.Listen(":8080")
}
