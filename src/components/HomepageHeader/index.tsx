import React from 'react'
import clsx from 'clsx'
// import Link from '@docusaurus/Link'
// import useDocusaurusContext from '@docusaurus/useDocusaurusContext'
// import Translate from '@docusaurus/Translate'

import styles from './styles.module.scss'

export default function HomepageHeader(): React.ReactElement {
  // const { siteConfig } = useDocusaurusContext()

  return (
    <header className={clsx( styles.heroBanner)}>
      {/* <div className='container'>
        <p className='hero__title'>
          "<Translate id="homepage.quote.line1">你写的每一行代码</Translate>
        </p>
        <p className='hero__title'>
          <Translate id="homepage.quote.line2">都是你的名片</Translate>"
        </p>
      </div> */}
            <div className='container'>
        <p className='hero__title'>“你写的每一行代码</p>
        <p className='hero__title'>都是你的名片”</p>
        <p className='hero__title'>"Every line of code you write</p>
        <p className='hero__title'>is your business card"</p>
      </div>
    </header>
  )
}
