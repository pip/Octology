import { AppLoading } from 'expo';
import { Asset      } from 'expo-asset';
import * as Font      from 'expo-font';
import React, { useState                       } from 'react';
import { Platform, StatusBar, StyleSheet, View } from 'react-native';
import { Ionicons   } from '@expo/vector-icons';
import AppNavigator   from './navigation/AppNavigator';
const d8VS='JAIMFlc4';
/* This is what I (Beppu-san) would've done had you not said anything.
 *   class D8
 *     Its render would've contained a View with 8 Text components.
 *     It would have taken a moment object as a prop and transformed that into a d8 to display.
 * Usage of D8Fieldz
 *   <D8Fieldz time={this.state.now}></D8Fieldz> */
const fixed    = Platform.OS === 'ios' ? 'Courier' : 'monospace'
//nst fontSize = parseInt(Dimensions.get('window').width / 8) + 'px'
const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#010', // was #eff
  }, }); /* */
const sb64 = ['0','1','2','3','4','5','6','7', '8','9','A','B','C','D','E','F',  'G','H','I','J','K','L','M','N', 'O','P','Q','R','S','T','U','V',
              'W','X','Y','Z','a','b','c','d', 'e','f','g','h','i','j','k','l',  'm','n','o','p','q','r','s','t', 'u','v','w','x','y','z','.','_']
const smon = ['Jan','Feb','Mar', 'Apr','May','Jun', 'Jul','Aug','Sep', 'Oct','Nov','Dec']
/* Convert an integer into a base64 character
 * @param  {Number} n  a number between 0..63
 * @return {String}    single base64 character */
function b64(n){
  return sb64[mod(n, 64)]}
function mod(n, m){
  return ((n % m) + m)% m}
function   z(n){
  if(n < 0){return 27 + n}
  else     {return      n}}
class D8Fieldz extends React.Component{
  constructor(props){
    super(props)
    this.state = {
      now: moment()
    }
  }
  componentDidMount() {
    this.timer = setInterval(() => {
      this.setState({ now: moment() })
    }, 1000)
  }
  componentWillUnmount() {
    clearInterval(this.timer)
  }
  render() {
    let m = this.props.time;
    return (
      <View     style={styles.d8fieldz}>
        {/*<Text style={styles.fontSize}><Text style={styles.Y}>{b64(2019 - 2000)}</Text>
          <Text style={styles.Y}>{b64(           m.year()        - 2000  )}</Text>
          <Text style={styles.M}>{b64(           m.month()       +    1  )}</Text>
          <Text style={styles.D}>{b64(           m.date()                )}</Text>
          <Text style={styles.z}>{b64(z(parseInt(m.utcOffset()   /   60)))}</Text>
          <Text style={styles.h}>{b64(           m.hour()                )}</Text>
          <Text style={styles.m}>{b64(           m.minute()              )}</Text>
          <Text style={styles.s}>{b64(           m.second()              )}</Text>
          <Text style={styles.p}>{b64(  parseInt(m.millisecond() /   60) )}</Text>
        </Text>*/}
      </View>
    )
  }
}
export default function App(props) {
  const [isLoadingComplete, setLoadingComplete] = useState(false);
  if (!isLoadingComplete && !props.skipLoadingScreen) {
    return (
      <AppLoading
        startAsync={loadResourcesAsync}
        onError   ={handleLoadingError}
        onFinish  ={() => handleFinishLoading(setLoadingComplete)}
      />
    );
  } else {
    return (
      <View style={styles.container}>
        {Platform.OS === 'ios' && <StatusBar barStyle="default" />}
        <AppNavigator />
      </View>
    );
  }
}
async function loadResourcesAsync() {
  await Promise.all([
    Asset.loadAsync([
      require('./assets/images/robot-dev.png'),
      require('./assets/images/robot-prod.png'),
      require('./assets/images/d80k-radial-1920x1080ppi888-J6PMH8jt.png'),
      require('./assets/images/d80k-radial-112x112-J6KMCups.png'),
    ]),
    Font.loadAsync({
      // This is the font that we are using for our tab bar
      ...Ionicons.font,
      // We include SpaceMono because we use it in HomeScreen.js. Feel free to
      // remove this if you are not using it in your app
      'space-mono': require('./assets/fonts/SpaceMono-Regular.ttf'),
    }),
  ]);
}
function handleLoadingError(error) {
  // In this case, you might want to report the error to your error reporting
  // service, for example Sentry
  console.warn(error);
}
function handleFinishLoading(setLoadingComplete) {
  setLoadingComplete(true);
}
/*
const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
  },
});
*/
