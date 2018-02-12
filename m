Return-Path: <linux-kbuild-owner@vger.kernel.org>
Date: Mon, 12 Feb 2018 18:00:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
Message-ID: <20180212170027.GP25181@hirez.programming.kicks-ass.net>
References: <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator>
 <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CA+55aFz3gUKQMr-X-b=ytLPX0AjGUaXNtLSUQ0_xZwZuDU33RQ@mail.gmail.com>
 <20180212082635.GA25314@hirez.programming.kicks-ass.net>
 <1518452362.6606.102.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1518452362.6606.102.camel@infradead.org>
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Ulf Magnusson <ulfalizer@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Feb 12, 2018 at 04:19:22PM +0000, David Woodhouse wrote:
> On Mon, 2018-02-12 at 09:26 +0100, Peter Zijlstra wrote:
> > On Sun, Feb 11, 2018 at 10:13:44AM -0800, Linus Torvalds wrote:
> >=20
> > > That actually sounds like we could just
> > >=A0
> > >=A0 (a) make gcc 4.5 be the minimum required version
> > >=A0
> > >=A0 (b) actually error out if we find a bad compiler
> >=20
> > So the unofficial plan was to enforce asm-goto and -fentry support by
> > hard failure to build, which would get us at gcc-4.6 and then remove all
> > the fallback cruft needed for those features -- for x86. If we want to
> > do this tree wide, that's obviously OK with me too ;-)
>=20
> This would also kill clang support, right?

Yes, not sure why I should care about that though.
