package com.anc.cinema.Entities;

import org.springframework.data.rest.core.config.Projection;

@Projection(name = "TicketProjection", types = Ticket.class)
public interface TicketProjection {
    public Long getId();

    public double getPrix();

    public boolean getReserve();

    public String getNomClient();

    public Place getPlace();
}
