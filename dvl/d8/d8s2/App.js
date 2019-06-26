// 2du:mk sure rm of all semiz&&rE4m@ng all still BhAvz corectly,lern how2scal main d8 font by dimNsionz,brk apRt&&colr Xpanded 4m@,Dtect touch/click EvNtz,
//   stuD curNt cOd,Xtract&&tune colr cOdz,lern how2Dtect rEorENt8ion EvNtz,lern how2draw scalng gfx,ad all d8ok optnz,rEnAm proj,publish,tSt,msg Bep 2try2,
//   lern how2crE8 special nOtific8ionz4daily 'BEER' time&&optn panL wi ckboxz4wich2NAbl,ad hLp tXt,lern how2ad crnr Iconz4cfg optn setngz&&hLp panL popupz,
//   lern how2Bcom realAndroid dvlpr&&how2publish2AppStor,rsrch similR appz2Dtermin good init prIc,contMpl8 adng cnv&&calN fE8urz,mAB ask Maga 2try2 on iOS,
//   considr adng custm alertz&&alRmz,lern how&&port mor of .pmz 2propr Node pkgz,sync new fE8urz bak2pl2,considr buyng dOmAn&&proj sIte hOstng,mk web vers;
import   React                                                     from 'react'
import { Platform, StatusBar, StyleSheet, Dimensions, View, Text } from 'react-native'
import { AppLoading,   Asset,                         Font, Icon } from 'expo'
import                                                    moment   from 'moment'
import   AppNavigator                                              from './navigation/AppNavigator'
const d8VS='J6KMHa0h'
/* This is what I (Beppu-san) would've done had you not said anything.
 *   class D8
 *     Its render would've contained a View with 8 Text components.
 *     It would have taken a moment object as a prop and transformed that into a d8 to display.
 * Usage of D8Fieldz
 *   <D8Fieldz time={this.state.now}></D8Fieldz> */
/* */
const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#eff',
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
export default class App extends React.Component {
  state = {
    isLoadingComplete: false,
  };
  render() {
    if (!this.state.isLoadingComplete && !this.props.skipLoadingScreen) {
      return (
        <AppLoading
          startAsync={this._loadResourcesAsync}
          onError={this._handleLoadingError}
          onFinish={this._handleFinishLoading}
        />
      );
    } else {
      return (
        <View style={styles.container}>
          {Platform.OS === 'ios' && <StatusBar barStyle="default" />}
          <AppNavigator />
          <D8Fieldz time={this.state.now}></D8Fieldz>
        </View>
      ); } }
  _loadResourcesAsync = async () => {
    return Promise.all([
      Asset.loadAsync([
        require('./assets/images/iconocto.png'),
        require('./assets/images/d80k-radial-112x112-J6KMCups.png'),
      ]),
      Font.loadAsync({
        // This is the font that we are using for our tab bar
        ...Icon.Ionicons.font,
        // We include SpaceMono because we use it in HomeScreen.js. Feel free
        // to remove this if you are not using it in your app
        'space-mono': require('./assets/fonts/SpaceMono-Regular.ttf'),
      }), ]); };
  _handleLoadingError = error => {
    // In this case, you might want to report the error to your error
    // reporting service, for example Sentry
    console.warn(error);
  };
  _handleFinishLoading = () => {
    this.setState({ isLoadingComplete: true });
  }; }

{/*
let orig='export default class App extends React.Component{';
  render() {
    return (
      <View style={styles.container}>
        <D8Fieldz time={this.state.now} />
        <Text style={styles.normal}>{this.state.now.format()}</Text>
      </View>
    );
  }
}
const fixed = Platform.OS === 'ios' ? 'Courier' : 'monospace'
const fontSize = parseInt(Dimensions.get('window').width / 8) + 'px'
const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'column',
    backgroundColor: '#001',
    alignItems: 'center',
    justifyContent: 'center',
  },
  normal: {
    color: '#fff',
  },
  textColor: {
    color: '#afa',
  },
  fontSize: {
    fontSize: 64,
  },
  d8fieldz: {
    flexDirection: 'row'
  },
  Y: {
    color: '#f44',
    fontFamily: 'monospace'
  },
  M: {
    color: '#f88',
    fontFamily: 'monospace'
  },
  D: {
    color: '#fcb',
    fontFamily: 'monospace'
  },
  z: {
    color: '#4f4',
    fontFamily: 'monospace'
  },
  h: {
    color: '#4ff',
    fontFamily: 'monospace'
  },
  m: {
    color: '#44f',
    fontFamily: 'monospace'
  },
  s: {
    color: '#f4f',
    fontFamily: 'monospace'
  },
  p: {
    color: '#c4c',
    fontFamily: 'monospace'
  },
  f: {
    color: '#c4c',
    fontFamily: 'monospace'
  },
}) */}
