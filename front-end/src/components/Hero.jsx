import React from "react";
import { Link } from 'react-router-dom';
import "animate.css";
import "../assets/styles/components/Hero.css";
import DGNft from "../assets/images/dgnft.png";
import { Container, Row, Col } from "react-bootstrap";
import TrackVisibility from "react-on-screen";
import Typewriter from "typewriter-effect";
import Button from "./Button";

function Hero() {
  return (
    <section className="hero">
      <Container>
        <Row className="aligh-items-center">
          <Col xs={12} md={6} xl={7}>
            <TrackVisibility>
              {({ isVisible }) => (
                <div
                  className={
                    isVisible ? "animate__animated animate__fadeIn" : ""
                  }
                >
                  <span className="tagline">Welcome to Dnero Gold Nft Market</span>
                  <h1>
                    <Typewriter
                      options={{
                        autoStart: true,
                        loop: true,
                      }}
                      onInit={(typewriter) => {
                        typewriter
                          .typeString(
                            //`<span class='txt-rotate'>Mint, Earn Royalties On</span>`
                            `<span class='txt-rotate'>A Collection Marketplace of</span>`
                          )
                          .pauseFor(2000)
                          .deleteAll()
                          .typeString(
                            //`<span class='txt-rotate'>Buy, Sell and trade</span>`
                            `<span class='txt-rotate'>Buy, Trade or Hold Your</span>`
                          )
                          .pauseFor(2000)
                          .deleteAll()
                          .typeString(
                            //`<span class='txt-rotate'>Auction Your</span>`
                            `<span class='txt-rotate'>Or Redeem for Real Gold Your</span>`
                          )
                          .pauseFor(2000)
                          .deleteAll()
                          .start();
                      }}
                    />
                    Dnero Gold NFTs
                  </h1>
                  <p>
                    Dnero Gold NFTs are a collection of 100,000 buy and redeem NFTs to be 			    paired to real life Gold. More details on how to purchase, after the 			    minting will be giving soon!
                  </p>
                  <div>
                    <Link to="/collection">
                      <Button btnName="Discover" />
                    </Link>
                  </div>
                </div>
              )}
            </TrackVisibility>
          </Col>
          <Col xs={12} md={6} xl={5}>
            <TrackVisibility>
              {({ isVisible }) => (
                <div
                  className={
                    isVisible ? "animate__animated animate__zoomIn" : ""
                  }
                >
                  <img
                    src={DGNft}
                    alt="Dnero Gold Nft"
                  />
                </div>
              )}
            </TrackVisibility>
          </Col>
        </Row>
      </Container>
    </section>
  );
}

export default Hero;
