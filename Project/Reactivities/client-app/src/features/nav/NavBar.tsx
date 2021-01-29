import React from 'react';
import { Button, Container, Menu } from 'semantic-ui-react';

interface IProps {
  openCreateForm: () => void;
}

const NavBar: React.FC<IProps> = ({ openCreateForm }) => {
  return (
    <Menu inverted>
      <Container>
        <Menu.Item header>
          <img
            src="/assets/logo.png"
            alt="logo"
            style={{ marginRight: '10px' }}
          />
        </Menu.Item>
        <Menu.Item name="Activities" />
        <Menu.Item>
          <Button onClick={openCreateForm} positive content="Create Activity" />
        </Menu.Item>
      </Container>
    </Menu>
  );
};
export default NavBar;
