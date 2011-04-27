Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 27 Apr 2011 08:37:42 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [GIT PULL] s390 patches for 2.6.39-rc4
Message-ID: <20110427083742.084bda90@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <BANLkTik_SMi17rgLVss9esoez9OeHEhN0w@mail.gmail.com>
References: <20110426110300.6da0b684@mschwide.boeblingen.de.ibm.com>
	<BANLkTik_SMi17rgLVss9esoez9OeHEhN0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 26 Apr 2011 11:38:22 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I'll pull this, but:
> 
> On Tue, Apr 26, 2011 at 2:03 AM, Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> >
> > Jan Glauber (3):
> >      [S390] prng: prevent access beyond end of stack
> 
> I don't think that's _still_ correct.
> 
> Just looking at the diff, it looks broken:
> 
> >        /* Add the entropy */
> >        while (nbytes >= 8) {
> > -               *((__u64 *)parm_block) ^= *((__u64 *)buf+i*8);
> > +               *((__u64 *)parm_block) ^= *((__u64 *)buf+i);
> >                prng_add_entropy();
> >                i += 8;
> >                nbytes -= 8;
> 
> The "i += 8" implies that "i" is a byte offset.
> 
> But "(__u64 *)buf+i" will parse as "((__u64 *)buf) + i" and thus still
> do another multiply-by-eight.
> 
> So the diff fixes one "off by a factor of 8", but not another, if I
> read it right.
> 
> So the parenthesis should be moved around to something like "*(__u64
> *) (buf+i)", I think.

Urgs, pointer arithmetic for dummies..  it is indeed still wrong. We'll fix.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
