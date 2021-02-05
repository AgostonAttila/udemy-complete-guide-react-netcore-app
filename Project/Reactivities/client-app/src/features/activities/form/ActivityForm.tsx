import React, { FormEvent, useContext, useEffect, useState } from 'react';
import { Button, Form, Segment } from 'semantic-ui-react';
import { IActivity } from '../../../app/models/activity';
import { v4 as uuid } from 'uuid';
import ActivityStore from '../../../app/stores/activityStore';
import { observer } from 'mobx-react-lite';
import { RouteComponentProps } from 'react-router';
import { act } from 'react-dom/test-utils';

interface DetailParams {
  id: string;
}

const ActivityForm: React.FC<RouteComponentProps<DetailParams>> = ({ match, history }) => {
  const activityStore = useContext(ActivityStore);
  const {
    createActivity,
    editActivity,
    submitting,
    loadActivity,
    activity: initialFormState,
    clearActivity,
  } = activityStore;

  const [activity, setActivity] = useState<IActivity>({
    id: '',
    title: '',
    category: '',
    description: '',
    date: '',
    city: '',
    venue: '',
  });

  useEffect(() => {
    if (match.params.id && activity.id.length === 0) {
      loadActivity(match.params.id).then(() => initialFormState && setActivity(initialFormState));
    }

    return () => {
      clearActivity();
    };
  }, [loadActivity, clearActivity, match.params.id, initialFormState, activity.id.length]);

  const handleInputChange = (event: FormEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    const { name, value } = event.currentTarget;
    setActivity({ ...activity, [name]: value });
  };

  const handleSubmit = () => {
    if (activity.id.length === 0) {
      let newActivity = {
        ...activity,
        id: uuid(),
      };
      createActivity(newActivity).then(() => history.push(`/activities/${newActivity.id}`));
    } else {
      editActivity(activity).then(() => history.push(`/activities/${activity.id}`));
    }
  };

  return (
    <Segment clearing>
      <Form onSubmit={handleSubmit}>
        <Form.Input placeholder="Title" value={activity.title} onChange={handleInputChange} name="title" />
        <Form.TextArea
          rows={2}
          placeholder="Decription"
          value={activity.description}
          onChange={handleInputChange}
          name="decription"
        />
        <Form.Input placeholder="Category" value={activity.category} onChange={handleInputChange} name="category" />
        <Form.Input
          type="datetime-local"
          placeholder="Date"
          value={activity.date}
          onChange={handleInputChange}
          name="date"
        />
        <Form.Input placeholder="City" value={activity.city} onChange={handleInputChange} name="city" />
        <Form.Input placeholder="Venue" value={activity.venue} onChange={handleInputChange} name="venue" />
        <Button loading={submitting} floated="right" positive type="submit" content="Submit" />
        <Button onClick={() => history.push('/activities')} floated="right" positive type="cancel" content="Cancel" />
      </Form>
    </Segment>
  );
};

export default observer(ActivityForm);
