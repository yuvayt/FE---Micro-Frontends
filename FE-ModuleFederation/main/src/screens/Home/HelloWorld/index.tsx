import React, { useState } from "react";
import { mountRemoteComponent } from "@/utils/loadComponent";

const HelloWorld = () => {
    const eventName = "hw-event";
    const [name, setName] = useState("");

    return (
        <section className="from-blog spad">
            <div className="row">
                <div className="col-lg-12">
                    <div className="section-title from-blog__title">
                        <h2>Hello World</h2>
                    </div>
                </div>
            </div>
            <div className="row">
                <div className="col">
                    <div className="mb-3 row input-group">
                        <div className="input-group-prepend">
                            <div
                                className="input-group-text"
                                id="btnGroupAddon"
                            >
                                @
                            </div>
                        </div>
                        <input
                            id="hw-name"
                            type="text"
                            placeholder="Your name"
                            value={name}
                            onChange={(e) => setName(e.target.value)}
                            className="form-control"
                        ></input>
                    </div>
                    <div className="mb-3 row d-md-flex justify-content-md-center">
                        {mountRemoteComponent({
                            module: "shared",
                            component: "Button",
                            props: {
                                title: "Magic",
                                onClick: (s: string) => {
                                    const event = new CustomEvent(eventName, {
                                        detail: name,
                                    });
                                    window.dispatchEvent(event);
                                },
                                class: "btn btn-primary mb-3",
                            },
                        })}
                    </div>
                </div>
                <div className="col">
                    {mountRemoteComponent({
                        module: "helloworld",
                        component: "Hello",
                        props: {
                            id: "hello-world",
                            value: "World",
                            eventName: eventName,
                        },
                    })}
                </div>
            </div>
        </section>
    );
};

export default HelloWorld;
