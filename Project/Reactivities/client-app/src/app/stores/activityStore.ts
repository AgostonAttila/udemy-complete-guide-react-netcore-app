import { action, computed, observable } from 'mobx';
import { createContext } from 'react';
import agent from '../api/agent';
import { IActivity } from '../models/activity';

class ActivityStore {
  @observable activityRegistry = new Map();
  @observable activities: IActivity[] = [];
  @observable selectedActivity: IActivity | undefined;
  @observable loadingInitial = false;
  @observable editMode = false;
  @observable submitting = false;
  @observable target = '';

  @computed get activitiesByDate() {
    return this.activities.sort((a, b) => Date.parse(a.date) - Date.parse(b.date));
  }

  @action loadActivities = async () => {
    this.loadingInitial = true;
    try {
      const activities = await agent.Activities.list();
      activities.forEach((activity) => {
        activity.date = activity.date.split('.')[0];
        this.activities.push(activity);
      });
      this.loadingInitial = false;
    } catch (error) {
      this.loadingInitial = false;
      console.log(error);
    }
  };

  @action selectActivity = (id: string) => {
    this.selectedActivity = this.activities.find((a) => a.id === id);
    this.editMode = false;
  };

  @action clearActivity = () => {
    //this.activity = null;
  };

  getActivity = (id: string) => {
    // return this.activityRegistry.get(id);
  };

  @action createActivity = async (activity: IActivity) => {
    this.submitting = true;
    try {
      await agent.Activities.create(activity);
      this.activities.push(activity);
      this.editMode = false;
      this.submitting = false;
    } catch (error) {
      this.submitting = false;
      console.log(error);
    }
  };

  @action openCreateForm = () => {
    this.editMode = true;
    this.selectedActivity = undefined;
  };

  /*

@action editActivity = async (activity: IActivity) => {
  this.submitting = true;
  try {
    await agent.Activities.update(activity);
    runInAction('editing activity', () => {
      this.activityRegistry.set(activity.id, activity);
      this.activity = activity;
      this.submitting = false;
    })
  } catch (error) {
    runInAction('edit activity error', () => {
      this.submitting = false;
    })
    console.log(error);
  }
};

@action deleteActivity = async (event: SyntheticEvent<HTMLButtonElement>, id: string) => {
  this.submitting = true;
  this.target = event.currentTarget.name;
  try {
    await agent.Activities.delete(id);
    runInAction('deleting activity', () => {
      this.activityRegistry.delete(id);
      this.submitting = false;
      this.target = '';
    })
  } catch (error) {
    runInAction('delete activity error', () => {
      this.submitting = false;
      this.target = '';
    })
    console.log(error);
  }*/
}

export default createContext(new ActivityStore());
