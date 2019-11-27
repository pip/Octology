import React                                              from 'react';
import { Platform                                       } from 'react-native';
import { createStackNavigator, createBottomTabNavigator } from 'react-navigation';
import TabBarIcon                                         from '../components/TabBarIcon';
import HomeScreen                                         from '../screens/HomeScreen';
import LinkScreen                                         from '../screens/LinkScreen';
import SetsScreen                                         from '../screens/SetsScreen';
const config = Platform.select({
  web: { headerMode: 'screen' },
  default: {},
});
const HomeStack = createStackNavigator({
    Home: HomeScreen,
  },
  config
);
HomeStack.navigationOptions = {
  tabBarLabel: 'Home',
  tabBarIcon: ({ focused }) => (
    <TabBarIcon  focused={focused} name={Platform.OS === 'ios'
          ? `ios-information-circle${focused ? '' : '-outline'}`
          :  'md-information-circle'
      }
    />
  ),
};
HomeStack.path = '';
const LinkStack = createStackNavigator({
    Link: LinkScreen,
  },
  config
);
LinkStack.navigationOptions = {
  tabBarLabel: 'Links',
  tabBarIcon: ({ focused }) => (
    <TabBarIcon  focused={focused} name={Platform.OS === 'ios' ? 'ios-link' : 'md-link'} />
  ),
};
LinkStack.path = '';
const SetsStack = createStackNavigator({
    Sets: SetsScreen,
  },
  config
);
SetsStack.navigationOptions = {
  tabBarLabel: 'Settings',
  tabBarIcon: ({ focused }) => (
    <TabBarIcon  focused={focused} name={Platform.OS === 'ios' ? 'ios-options' : 'md-options'} />
  ),
};
SetsStack.path = '';
const tabNavigator = createBottomTabNavigator({
  HomeStack,
  LinkStack,
  SetsStack,
});
tabNavigator.path = '';
export default tabNavigator;
