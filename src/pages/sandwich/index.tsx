import type React from 'react'
import { useState, useEffect } from 'react'
import Layout from '@theme/Layout'
import { localStorage } from '@boombox/storage'
import styles from './index.module.scss'

export default function () {
  const KEY = 'sandwich'
  type Storage = {
    prefix: string
    content: string
    suffix: string
  }

  const storage = (localStorage?.getItem(KEY) ?? {
    prefix: '',
    content: '',
    suffix: '',
  }) as Storage

  const [state, setState] = useState<Storage>(storage)
  const [result, setResult] = useState<string>('')
  const [copyFeedback, setCopyFeedback] = useState<string>('copy')
  const [pasteFeedback, setPasteFeedback] = useState<string>('paste')

  useEffect(() => {
    localStorage.setItem(KEY, state)
    setResult(`${state.prefix}${state.content}${state.suffix}`)
  }, [state])

  const handlePrefixChange = (e: React.ChangeEvent<HTMLTextAreaElement>) => {
    setState({ ...state, prefix: e.target.value })
  }
  const handleContentChange = (e: React.ChangeEvent<HTMLTextAreaElement>) => {
    setState({ ...state, content: e.target.value })
  }
  const handleSuffixChange = (e: React.ChangeEvent<HTMLTextAreaElement>) => {
    setState({ ...state, suffix: e.target.value })
  }
  const handleCopy = () => {
    navigator.clipboard.writeText(result)
    setCopyFeedback('Copied!')
    setTimeout(() => {
      setCopyFeedback('Copy')
    }, 1000)
  }
  const handlePaste = async () => {
    try {
      const text = await navigator.clipboard.readText()
      setState({ ...state, content: text })
      setPasteFeedback('pasted')
      setTimeout(() => {
        setPasteFeedback('paste')
      }, 1000)
    } catch (err) {
      setPasteFeedback('failed')
    }
  }

  return (
    <Layout
      title='Post Sandwich'
      description='Post tool that allow you to add fixed prefix and suffix to your content.'
    >
      <main className={styles.main}>
        <div className={styles.left}>
          <textarea
            id='prefix'
            placeholder='Enter the prefix text here'
            value={state.prefix}
            onChange={handlePrefixChange}
          />
          <div className={styles.content}>
            <button type="button" onClick={handlePaste}>Paste</button>
            <textarea
              id='content'
              placeholder='Enter the main content here'
              value={state.content}
              onChange={handleContentChange}
            />
          </div>
          <textarea
            id='suffix'
            placeholder='Enter the suffix text here'
            value={state.suffix}
            onChange={handleSuffixChange}
          />
        </div>
        <div className={styles.right}>
          <button type="button" className={'copy'} onClick={handleCopy}>
            {copyFeedback}
          </button>
          <textarea
            id='result'
            placeholder='The concatenated result of prefix, content, and suffix will appear here'
            value={result}
            readOnly
          />
        </div>
      </main>
    </Layout>
  )
}
