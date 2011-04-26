Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20110426110300.6da0b684@mschwide.boeblingen.de.ibm.com>
References: <20110426110300.6da0b684@mschwide.boeblingen.de.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 26 Apr 2011 11:38:22 -0700
Message-ID: <BANLkTik_SMi17rgLVss9esoez9OeHEhN0w@mail.gmail.com>
Subject: Re: [GIT PULL] s390 patches for 2.6.39-rc4
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

I'll pull this, but:

On Tue, Apr 26, 2011 at 2:03 AM, Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> Jan Glauber (3):
> =A0 =A0 =A0[S390] prng: prevent access beyond end of stack

I don't think that's _still_ correct.

Just looking at the diff, it looks broken:

> =A0 =A0 =A0 =A0/* Add the entropy */
> =A0 =A0 =A0 =A0while (nbytes >=3D 8) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 *((__u64 *)parm_block) ^=3D *((__u64 *)buf+=
i*8);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *((__u64 *)parm_block) ^=3D *((__u64 *)buf+=
i);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prng_add_entropy();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i +=3D 8;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0nbytes -=3D 8;

The "i +=3D 8" implies that "i" is a byte offset.

But "(__u64 *)buf+i" will parse as "((__u64 *)buf) + i" and thus still
do another multiply-by-eight.

So the diff fixes one "off by a factor of 8", but not another, if I
read it right.

So the parenthesis should be moved around to something like "*(__u64
*) (buf+i)", I think.

                     Linus
