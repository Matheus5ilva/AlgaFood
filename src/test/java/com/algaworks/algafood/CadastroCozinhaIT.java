package com.algaworks.algafood;

import static org.hamcrest.CoreMatchers.equalTo;

import org.flywaydb.core.Flyway;
import org.hamcrest.Matchers;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.web.server.LocalServerPort;
import org.springframework.http.HttpStatus;

import io.restassured.RestAssured;
import io.restassured.http.ContentType;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class CadastroCozinhaIT {

	@LocalServerPort
	private int port;

	@Autowired
	private Flyway flyway;

	@BeforeEach
	public void setUp() {
		RestAssured.enableLoggingOfRequestAndResponseIfValidationFails();
		RestAssured.port = port;
		RestAssured.basePath = "/cozinhas";

		flyway.migrate();
	}

	@Test
	public void deveRetornarStatus200_QuandoConsultarCozinhas() {
		RestAssured.given().accept(ContentType.JSON).when().get().then().statusCode(200);
	}

	@Test
	public void deveConter4Cozinhas_QuandoConsultarCozinhas() {
		RestAssured.given().accept(ContentType.JSON).when().get().then().body("", Matchers.hasSize(4));
	}

	@Test
	public void deveRetornarStatus201_QuandoCadastrarCozinha() {
		RestAssured.given().body("{ \"nome\": \"Chinesa\" }").contentType(ContentType.JSON).accept(ContentType.JSON)
				.when().post().then().statusCode(HttpStatus.CREATED.value());
	}

	@Test
	public void deveRetornarEStatusCorreto_QuandoConsultarCozinhaExistente() {
		RestAssured.given().pathParam("cozinhaId", 2).accept(ContentType.JSON).when().get("/{cozinhaId}").then()
				.statusCode(HttpStatus.OK.value()).body("nome", equalTo("Indiana"));
	}
	
	@Test
	public void deveRetornarStatus404_QuandoConsultarCozinhaInexistente() {
		RestAssured.given().pathParam("cozinhaId", 100).accept(ContentType.JSON).when().get("/{cozinhaId}").then()
		.statusCode(HttpStatus.NOT_FOUND.value());

	}
	
}