import React from "react";
import "./../assets/styles/components/Footer.css";
import { AiOutlineTwitter, AiOutlineGithub } from "react-icons/ai";
import { RiDiscordFill } from "react-icons/ri";
import images from "../assets/images";

function Footer() {
  return (
    <div className="footer section__padding">
      <div className="footer-links">
        <div className="footer-links_logo">
          <div>
            <img src={images.logo} width={150} />
          </div>
          <div>
            <h3>Dnero Gold Nft Market.</h3>
          </div>
        </div>
        <div className="footer-links_div">
          <h4>Marketplace</h4>
          <p>Explore</p>
          <p>How it Works</p>
          <p>Roadmap</p>
          <p>Contact Us</p>
        </div>
        <div className="footer-links_div">
          <h4>Support</h4>
          <p>Help center</p>
          <p>Terms of service</p>
          <p>Legal</p>
          <p>Privacy policy</p>
        </div>
      </div>
      <div className="footer-copyright">
        <div className="footer-copyright-text">
          <p> © {new Date().getFullYear()} DG NFT Market, Inc. All Rights Reserved</p>
        </div>
        <div className="footer-copyright-icons">
          <a href="https://github.com/dnerochain">
            <AiOutlineGithub size={25} color="white" className="footer-icon" />
          </a>
          <a href="https://github.com/dnerochain">
            <AiOutlineTwitter size={25} color="white" className="footer-icon" />
          </a>
          <a href="https://github.com/dnerochain">
            <RiDiscordFill size={25} color="white" className="footer-icon" />
          </a>
        </div>
      </div>
    </div>
  );
}

export default Footer;
