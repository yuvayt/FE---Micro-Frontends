import React, { useEffect, useState } from "react";
import { createMountComponent } from "../../utils/mountComponent";
import styles from "./hello.module.scss";

export interface IHelloProps {
    id: string;
    value: string;
    eventName: string;
}

const Hello = (props: IHelloProps): JSX.Element => {
    const [value, setValue] = useState(props.value);

    useEffect(() => {
        window.addEventListener(props.eventName, (event: Event) => {
            const detail = (event as CustomEvent).detail as string;
            console.log(detail);
            if (detail) setValue(detail);
        });

        return () => {
            window.removeEventListener(
                props.eventName as string,
                (event: Event) => {
                    console.log(event);
                }
            );
        };
    }, []);

    return (
        <>
            <div id={props.id} className={styles.hello}>
                {"> Hello " + value + "!!!"}
            </div>
        </>
    );
};

export default (el: any, props: IHelloProps) =>
    createMountComponent(Hello, props, el);
