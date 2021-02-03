import { observer } from 'mobx-react-lite';
import React, { useContext } from 'react';
import { Button, Card, Image } from 'semantic-ui-react';
import { IActivity } from '../../../app/models/activity';
import ActivityStore from '../../../app/stores/activityStore';

interface IProps {
  setEditMode: (editMode: boolean) => void;
  setSelectedActivity: (activity: IActivity | null) => void;
}

const ActivityDetails: React.FC<IProps> = ({ setEditMode, setSelectedActivity }) => {
  const activityStore = useContext(ActivityStore);
  const { selectedActivity: activity } = activityStore;
  return (
    <Card>
      <Image src={`/assets/categoryImages/${activity!.category}.png`} wrapped ui={false} />
      <Card.Content>
        <Card.Header>activity!.title</Card.Header>
        <Card.Meta>
          <span>activity!.date</span>
        </Card.Meta>
        <Card.Description>activity!.description</Card.Description>
      </Card.Content>
      <Card.Content>
        <Button.Group widths={2}>
          <Button onClick={() => setEditMode(true)} basic color="blue" content="Edit"></Button>
          <Button onClick={() => setSelectedActivity(null)} basic color="grey" content="Cancel"></Button>
        </Button.Group>
      </Card.Content>
    </Card>
  );
};

export default observer(ActivityDetails);
