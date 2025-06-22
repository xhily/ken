import React from 'react';
import {translate} from '@docusaurus/Translate';

export default function FooterCopyright(): JSX.Element {
  const copyright = translate({
    id: 'theme.footer.copyright',
    message: 'Copyright © {year} 楷鹏.',
    description: 'The footer copyright',
  }, {
    year: new Date().getFullYear(),
  });

  return (
    <div className="footer__copyright">
      {copyright}
    </div>
  );
} 