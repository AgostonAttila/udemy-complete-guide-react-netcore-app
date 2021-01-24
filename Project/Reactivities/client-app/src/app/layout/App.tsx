import React, {Component} from 'react';
import axios from 'axios';
import { Header, Icon, List } from 'semantic-ui-react';
import { IActivity} from '../models/activity';

interface IState{
  activities: IActivity [];
}

class App extends Component {
  
  readonly state: IState = {
    activities:[]  
  }

        componentDidMount(){
          axios.get<IActivity[]>('http://localhost:5000/api/activities')
          .then((response)=>{
            this.setState({
              activities: response.data
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
    {this.state.activities.map((activity)=>(          
            <List.Item key={activity.id}>{activity.title}</List.Item>   
          ))}
  </List>
        
       
     
      </div>
    );
  }
}

export default App;
