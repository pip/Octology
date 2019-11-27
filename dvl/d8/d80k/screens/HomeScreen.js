/* 2du:figure out whatever module has replaced moment or how to install the l8st moment to get timing d8a back in the HomeScreen body,
     gener8 stylez bgcolrz from obtained d8-timez,scale fontz according to resoz,detect landscape rot8,detect phass touch toggle upd8 delayz,
     mk canvas to start drawing radial clock armatures,add ckbox to toggle colrz invert,invert navig8ion tab button colrz at bottom;
 */
import   React                                                                               from 'react';
import { Image, Platform, Dimensions, ScrollView, StyleSheet, Text, TouchableOpacity, View } from 'react-native';
import   moment       from 'moment';
import { WebBrowser } from 'expo';
import { MonoText   } from '../components/StyledText';
const VERSION='0.0';const d8VS='JAIMHPip';
const sb64 = ['0','1','2','3','4','5','6','7', '8','9','A','B','C','D','E','F',  'G','H','I','J','K','L','M','N', 'O','P','Q','R','S','T','U','V',
              'W','X','Y','Z','a','b','c','d', 'e','f','g','h','i','j','k','l',  'm','n','o','p','q','r','s','t', 'u','v','w','x','y','z','.','_']
const smon = ['Jan','Feb','Mar', 'Apr','May','Jun', 'Jul','Aug','Sep', 'Oct','Nov','Dec']
let   w8mi =  151; // 0, 15, 151, 987  when touching seconds or phasses then should cycle these waiting millisecond intervals to upd8 similar to Curses
/* Convert an integer into a base64 character
 * @param  {Number} n  a number between 0..63
 * @return {String}    single base64 character
function b10(c){
  for(i = 0; i<=63; i++){ // JavaScript for-loop syntax is different than C && Perl
    if(sb64[i] == c){
      return i;}}} */
function b64(n){
  return sb64[mod(n, 64)]}
function mod(n, m){
  return ((n % m) + m)% m}
function   z(n){
  if(n < 0){return 27 + n}
  else     {return      n}}
export default class HomeScreen extends React.Component {
  constructor(props){
    super    (props)
    this.state =    { now: moment() }}
  componentDidMount() {
    this.timer = setInterval(() => {
      this.setState({ now: moment() })
    },  w8mi)}
  componenetWillUnmount() {
    clearInterval(this.timer)}
  static navigationOptions = {
    header: null };
  render() {let moment = require('moment');let zutc = moment().utcOffset() - 200;let tstr = ''; /* not sure why my phone is returning only -300 utcOffset */
            let dstr = '';let hstr = '';let mstr = '';let sstr = '';let pstr = '';if(zutc <= 0 && zutc >= -959){zutc = '-' + '0' + (-1 * zutc);}
            let nstr = '';let estr = ';sp';
            if(         moment().date()              <= 9){dstr=' '};dstr +=          moment().date()
            if(         moment().hour()              <= 9){hstr='0'};hstr +=          moment().hour()              + ':'
            if(         moment().minute()            <= 9){mstr='0'};mstr +=          moment().minute()            + ':'
            if(         moment().hour()              < 12){nstr='A';}else{nstr='P';} nstr += 'M';
            if(         moment().second()            <= 9){sstr='0'};sstr +=          moment().second()            + ':'
            if(parseInt(moment().millisecond() / 17) <= 9){pstr='0'};pstr += parseInt(moment().millisecond() / 17)
    return (
      <View         style={styles.container}>
        <ScrollView style={styles.container} contentContainerStyle={styles.contentContainer}>
          <View     style={styles.welcomeContainer}>
            <Image
              source={
                __DEV__
                  ? require('../assets/images/d80k-radial-112x112-J6KMCups.png')
                  : require('../assets/images/d80k-radial-1920x1080ppi888-J6PMH8jt.png')
              }
              style={styles.welcomeImage}
            />
          </View>
          <View style={styles.getStartedContainer}>
            <View style={[styles.d8d8HighlightContainer, styles.homeScreenFilename]}>
              <MonoText style={[styles.d8fText,styles.d8YText]}>{moment().year()} <MonoText
                        style={[styles.d8fText,styles.d8MText]}>{smon[moment().month()]}</MonoText></MonoText>
              <MonoText style={[styles.d8fText,styles.d8DText]}>{dstr} <MonoText
                        style={[styles.d8fText,styles.d8zText,styles.d8znHighlightContainer]}>{zutc}</MonoText></MonoText>
            </View>
            <View style={styles.d8HighlightContainer}>
              <MonoText style={[                               styles.d8Text, styles.d8YText]}>{b64(           moment().year()        - 2000  )}<MonoText
                        style={[                               styles.d8Text, styles.d8MText]}>{b64(           moment().month()       +    1  )}<MonoText
                        style={[                               styles.d8Text, styles.d8DText]}>{b64(           moment().date()                )}<MonoText
                        style={[styles.d8znHighlightContainer, styles.d8Text, styles.d8zText]}>{b64(z(parseInt(moment().utcOffset()   /   60)))} <MonoText
                        style={[styles.d8tmHighlightContainer, styles.d8Text, styles.d8hText]}>{b64(           moment().hour()                )}<MonoText
                        style={[styles.d8tmHighlightContainer, styles.d8Text, styles.d8mText]}>{b64(           moment().minute()              )}<MonoText
                        style={[styles.d8tmHighlightContainer, styles.d8Text, styles.d8sText]}>{b64(           moment().second()              )}<MonoText
                        style={[styles.d8tmHighlightContainer, styles.d8Text, styles.d8pText]}>{b64(  parseInt(moment().millisecond() /   17) )}</MonoText></MonoText></MonoText></MonoText></MonoText></MonoText></MonoText></MonoText>
            </View>
            <View style={styles.d8tmHighlightContainer}>
              <MonoText style={[styles.d8fText, styles.d8hText]}>{hstr}<MonoText
                        style={[styles.d8fText, styles.d8mText]}>{mstr}<MonoText
                        style={[styles.d8fText, styles.d8hText]}>{nstr}</MonoText></MonoText></MonoText><MonoText
                        style={[styles.d8fText, styles.d8sText]}>{sstr}<MonoText
                        style={[styles.d8fText, styles.d8pText]}>{pstr}<MonoText
                        style={[styles.d8fText, styles.d8zText]}>{estr}</MonoText></MonoText></MonoText>
            </View>
            <MonoText style={styles.getStartedText}>
              I need to compute styles based on the changing d8 and hmsp below fan out?;
            </MonoText>
          </View>
          <View style={styles.helpContainer}>
            <TouchableOpacity onPress={this._handleHelpPress} style={styles.helpLink}>
              <MonoText style={styles.d8sText}>{this.state.now.format()}</MonoText>
              <Text     style={styles.helpLinkText}>Help, didn’t auto-reload!</Text>
            </TouchableOpacity>
          </View>
        </ScrollView>
     {/*<View style={styles.tabBarInfoContainer}>
          <Text style={styles.tabBarInfoText}>Edit this tab bar in:</Text>
          <View style={[styles.codeHighlightContainer, styles.navigationFilename]}>
            <MonoText style={styles.codeHighlightText}>Octology nvg8n/MainTabNavigator.js</MonoText>
          </View>
        </View>*/}
      </View>
    );
  }
  _maybeRenderDevelopmentModeWarning() {
    if (__DEV__) {
      const learnMoreButton = (
        <Text onPress={this._handleLearnMorePress} style={styles.helpLinkText}>
          Learn more
        </Text>
      );
      return (
        <Text style={styles.developmentModeText}>
          Development mode is enabled, your app will be slower but you can use useful development tools.  {learnMoreButton}
        </Text>
      );
    } else {
      return (
        <Text style={styles.developmentModeText}>
          You are not in development mode. Your app will run at full speed.
        </Text>
      );
    }
  }
  _handleLearnMorePress = () => {
    WebBrowser.openBrowserAsync('https://docs.expo.io/versions/latest/guides/development-mode');
  };
  _handleHelpPress      = () => {
    WebBrowser.openBrowserAsync(
      'https://docs.expo.io/versions/latest/guides/up-and-running.html#can-t-see-your-changes');
  };
}
{/* body: {
      filter: invert(100%);  HTTPS://Developer.Mozilla.Org/en-US/docs/Web/CSS/filter-function/invert && HTTPS://McDlr.Com/css-inject/ 2 bookmarklet it;
  },
 */}
const fixed       = Platform.OS === 'ios' ? 'Courier' : 'monospace'
//nst fontSizeDim = parseInt(Dimensions.get('window').width / 4); // + 'px' just wants the number below
const styles      = StyleSheet.create({
  container: {
    flex:                  1,
    flexDirection:  'column',
    backgroundColor:  '#001',
    fontFamily:  'monospace',
  },
  normal:    { color: '#fff',
  },
  textColor: { color: '#afa',
  },
  fontSize:  { fontSize: 128, // fontSizeDim, // was 64
  },
  d8fieldz:  { flexDirection: 'row'
  },
  Y: { color: '#f44',
  },
  M: { color: '#f88',
  },
  D: { color: '#fcb',
  },
  z: { color: '#4f4',
  },
  h: { color: '#4ff',
  },
  m: { color: '#44f',
  },
  s: { color: '#f4f',
  },
  p: { color: '#c4c',
  },
  f: { color: '#c4c',
  },
  developmentModeText: {
    color: 'rgba(215,231,223,0.4)',
    fontSize:             14,
    lineHeight:           16,
    marginBottom:         20,
    textAlign:      'center',
  },
  contentContainer: {
    paddingTop:           16,
    alignItems:     'center',
    justifyContent: 'center',
  },
  welcomeContainer: {
    marginTop:             1,
    marginBottom:          1,
    alignItems:     'center',
  },
  welcomeImage: {
    width:               112,
    height:              112,
    marginTop:             1,
    marginLeft:           -8,
    resizeMode:    'contain',
  },
  getStartedContainer: {
    marginHorizontal:     32,
    alignItems:     'center',
  },
  homeScreenFilename: {
    marginVertical:        0,
  },
  d8znHighlightContainer: {
    backgroundColor: 'rgba(127,15, 79,0.6)',
    borderRadius:          1,
    paddingHorizontal:     1,
  },
  d8tmHighlightContainer: {
    backgroundColor: 'rgba(63,127,159,0.5)',
    borderRadius:          2,
    paddingHorizontal:     1,
  },
  d8d8HighlightContainer: {
    backgroundColor: 'rgba(64, 16,144,0.4)',
    borderRadius:          1,
    paddingHorizontal:     0,
  },
  d8HighlightContainer: {
    backgroundColor: 'rgba(76, 24, 80,0.4)',
    borderRadius:          3,
    paddingHorizontal:     1,
  },
  codeHighlightText: {
    color:           'rgba(96,100,109, 0.8)',
  },
  codeHighlightContainer: {
    backgroundColor: 'rgba(0,0,0,0.05)',
    borderRadius:          3,
    paddingHorizontal:     4,
  },
  getStartedText: {
    fontSize:             17,
    color:           'rgba(96,100,109, 1)',
    lineHeight:           24,
    textAlign:      'center',
  },
  d8fText: {
    fontSize:             40,
//  color:           'rgba(76, 24, 80, 1)',
    lineHeight:           48,
    textAlign:      'center',
  },
  d8Text: {
    fontSize:             80,
    lineHeight:          112,
    textAlign:      'center',
  },
  d8YText: {
    color: 'rgba(255, 31,  7, 1)',
  },
  d8MText: {
    color: 'rgba(255,127, 31, 1)',
  },
  d8DText: {
    color: 'rgba(252,255, 15, 1)',
  },
  d8zText: {
    color: 'rgba( 31,255, 63, 1)',
  },
  d8hText: {
    color: 'rgba( 31,255,252, 1)',
  },
  d8mText: {
    color: 'rgba( 31, 63,255, 1)',
  },
  d8sText: {
    color: 'rgba(252, 15,255, 1)',
  },
  d8pText: { // try "phasses" instead of frames from now on, hopefully kinda good deep PurPle
    color: 'rgba(191, 15,159, 1)',
  },
  tabBarInfoContainer: {
    position: 'absolute',
    bottom: 0,
    left:   0,
    right:  0,
    ...Platform.select({
      ios: {
        shadowColor: 'black',
        shadowOffset: { height: -3 },
        shadowOpacity:   0.1,
        shadowRadius:      3,
      },
      android: {
        elevation:        20,
      },
    }),
    alignItems:     'center',
    backgroundColor:  '#010',
    paddingVertical:      20,
  },
  tabBarInfoText: {
    fontSize:             17,
    color: 'rgba(196,200,209, 1)',
    textAlign:      'center',
  },
  navigationFilename: {
    marginTop:             5,
  },
  helpContainer: {
    marginTop:            15,
    alignItems:     'center',
  },
  helpLink: {
    paddingVertical:      15,
  },
  helpLinkText: {
    fontSize:             14,
    color:         '#2e78b7',
  },
});
