import { observer } from 'mobx-react-lite';
import React, { useContext, useEffect } from 'react';
import { Button, Card, Image } from 'semantic-ui-react';
import ActivityStore from '../../../app/stores/activityStore';
import { RouteComponentProps } from 'react-router';
import LoadingComponent from '../../../app/layout/LoadingComponent';
import { Link } from 'react-router-dom';

interface DetailParams {
  id: string;
}

const ActivityDetails: React.FC<RouteComponentProps<DetailParams>> = ({ match, history }) => {
  const activityStore = useContext(ActivityStore);
  const { activity: activity, loadActivity, loadingInitial } = activityStore;

  useEffect(() => {
    loadActivity(match.params.id);
  }, [loadActivity, match.params.id]);

  if (loadingInitial || !activity) return <LoadingComponent content="Loading activity..." />;

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
          <Button as={Link} to={`/manage/${activity.id}`} basic color="blue" content="Edit"></Button>
          <Button onClick={() => history.push('/')} basic color="grey" content="Cancel"></Button>
        </Button.Group>
      </Card.Content>
    </Card>
  );
};

export default observer(ActivityDetails);
