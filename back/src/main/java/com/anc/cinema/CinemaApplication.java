package com.anc.cinema;

import com.anc.cinema.Entities.Cinema;
import com.anc.cinema.Entities.Film;
import com.anc.cinema.Entities.Salle;
import com.anc.cinema.Entities.Ticket;
import com.anc.cinema.Entities.Ville;
import com.anc.cinema.ICinemaInit.ICinemaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.rest.core.config.RepositoryRestConfiguration;

@SpringBootApplication
public class CinemaApplication implements CommandLineRunner {
    @Autowired
    ICinemaService cinemaService;
    @Autowired
    RepositoryRestConfiguration repositoryRestConfiguration;

    public static void main(String[] args) {
        SpringApplication.run(CinemaApplication.class, args);
    }

    @Override
    public void run(String... args) throws Exception {
        repositoryRestConfiguration.exposeIdsFor(Ville.class, Cinema.class,
                Film.class, Ticket.class, Salle.class);
        // Should only be executed on first run, or if "spring.jpa.hibernate.ddl-auto =
        // create"
        cinemaService.initVilles();
        cinemaService.initCinemas();
        cinemaService.initSalles();
        cinemaService.initPlaces();
        cinemaService.initSeances();
        cinemaService.initCategories();
        cinemaService.initFilms();
        cinemaService.initProjections();
        cinemaService.initTickets();
    }
}
