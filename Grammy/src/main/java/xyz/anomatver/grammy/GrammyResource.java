package xyz.anomatver.grammy;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JSR310Module;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import jakarta.ws.rs.*;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.Entity;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.stream.Collectors;

@Path("grammy/bands")
public class GrammyResource {
    @GET
    @Path("get-by-genre/{genre}")
    @Produces("application/json")
    public List<MusicBand> getByGenre(@PathParam("genre") String genre) throws JsonProcessingException {
        Client client = ClientBuilder.newClient();

        Response response = client.target("https://localhost:8444/soa-first-0.0.1-SNAPSHOT/musicbands?filterBy=genre&filterValue="+genre)
                .request(MediaType.APPLICATION_JSON)
                .get();

        if (response.getStatus() == Response.Status.OK.getStatusCode()) {
            String jsonResponse = response.readEntity(String.class);
            ObjectMapper mapper = new ObjectMapper();
            mapper.registerModule(new JavaTimeModule());
            mapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);

            List<MusicBand> bands = mapper.readValue(jsonResponse, new TypeReference<>() {
            });

            return bands.stream()
                    .filter(MusicBand::isNominatedToGrammy)
                    .collect(Collectors.toList());
        } else {
            throw new WebApplicationException("Failed to fetch data from Spring service", response.getStatus());
        }
    }

    @POST
    @Path("{id}/nominate/{genre}")
    @Produces("application/json")
    public Response nominate(@PathParam("id") Long id, @PathParam("genre") String genre) throws JsonProcessingException {
        Client client = ClientBuilder.newClient();

        // Fetch the band
        Response response = client.target("https://localhost:8444/soa-first-0.0.1-SNAPSHOT/musicbands/" + id)
                .request(MediaType.APPLICATION_JSON)
                .get();

        if (response.getStatus() != Response.Status.OK.getStatusCode()) {
            throw new WebApplicationException("Failed to fetch data from Spring service", response.getStatus());
        }

        String jsonResponse = response.readEntity(String.class);
        ObjectMapper mapper = new ObjectMapper();
        mapper.registerModule(new JavaTimeModule());
        mapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
        mapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));

        MusicBand band = mapper.readValue(jsonResponse, MusicBand.class);

        // Update the field
        band.setNominatedToGrammy(true);

        // Convert the updated object back to JSON
        String jsonRequest = mapper.writeValueAsString(band);

        // Send a PUT request to update the band
        Response updateResponse = client.target("https://localhost:8444/soa-first-0.0.1-SNAPSHOT/musicbands/" + id)
                .request(MediaType.APPLICATION_JSON)
                .put(Entity.entity(jsonRequest, MediaType.APPLICATION_JSON));

        if (updateResponse.getStatus() != Response.Status.OK.getStatusCode()) {
            throw new WebApplicationException("Failed to update data on Spring service", updateResponse.getStatus());
        }

        return Response.ok("Band has been nominated").build();
    }

}