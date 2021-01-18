import React, {Component} from 'react';
import logo from './logo.svg';
import './App.css';
import { render } from '@testing-library/react';
import axios from 'axios';
import { Header, Icon, List } from 'semantic-ui-react';

class App extends Component {
  
  state = {
    values:[]
  }

        componentDidMount(){
          axios.get('http://localhost:5000/api/values')
          .then((response)=>{
            this.setState({
              values: response.data
            })
          })          
        }
  
  render(){   
    return (
      <div>     
     <Header as='h2' icon textAlign='center'>
      <Icon name='users' circular />
      <Header.Content>Reactivities</Header.Content>
    </Header>

    <List>
    <List.Item>Apples</List.Item>   
    {this.state.values.map((value:any)=>(          
            <List.Item key={value.id}>{value.name}</List.Item>   
          ))}
  </List>
        
       
     
      </div>
    );
  }
}

export default App;
