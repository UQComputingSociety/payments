import * as React from "react";
import * as ReactDOM from "react-dom";
import App from "./components/App";
import CssBaseline from "@material-ui/core/CssBaseline";


const Index = () => {
    return (
        <CssBaseline>
            <App/>
        </CssBaseline>
    );
};

ReactDOM.render(<Index/>, document.getElementById("root"));
