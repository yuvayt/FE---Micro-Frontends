import React from "react";
import Category from "./Category";
import FeaturedProducts from "./FeaturedProducts";
import ProductSmallSlider from "./ProductSmallSlider";
import NewPosts from "./NewPosts";
import Banner from "./Banner";
import HelloWorld from "./HelloWorld";

const Homepage = () => {
    return (
        <>
            <Category />
            <FeaturedProducts />
            <Banner />
            <ProductSmallSlider />
            <NewPosts />
            <HelloWorld />
        </>
    );
};

export default Homepage;
