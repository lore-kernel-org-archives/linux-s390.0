Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 14 May 2019 14:37:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing
 addresses
Message-ID: <20190514143751.48e81e05@oasis.local.home>
In-Reply-To: <CAMuHMdXaMObq9h2Sb49PW1-HUysPeaWXB7wJmKFz=xLmSoUDZg@mail.gmail.com>
References: <20190510081635.GA4533@jagdpanzerIV>
        <20190510084213.22149-1-pmladek@suse.com>
        <20190510122401.21a598f6@gandalf.local.home>
        <daf4dfd1-7f4f-8b92-6866-437c3a2be28b@c-s.fr>
        <096d6c9c17b3484484d9d9d3f3aa3a7c@AcuMS.aculab.com>
        <20190513091320.GK9224@smile.fi.intel.com>
        <20190513124220.wty2qbnz4wo52h3x@pathway.suse.cz>
        <20190514020730.GA651@jagdpanzerIV>
        <45348cf615fe40d383c1a25688d4a88f@AcuMS.aculab.com>
        <CAMuHMdXaMObq9h2Sb49PW1-HUysPeaWXB7wJmKFz=xLmSoUDZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190514183751.e9m7K3oevIRrilsKNzAtPbZ1iFL7XriqpwHrBnk9krU@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Laight <David.Laight@aculab.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, christophe leroy <christophe.leroy@c-s.fr>, Linus Torvalds <torvalds@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Russell Currey <ruscur@russell.cc>, Stephen Rothwell <sfr@ozlabs.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


[ Purple is a nice shade on the bike shed. ;-) ]

On Tue, 14 May 2019 11:02:17 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Tue, May 14, 2019 at 10:29 AM David Laight <David.Laight@aculab.com> wrote:
> > > And I like Steven's "(fault)" idea.
> > > How about this:
> > >
> > >       if ptr < PAGE_SIZE              -> "(null)"
> > >       if IS_ERR_VALUE(ptr)            -> "(fault)"
> > >
> > >       -ss  
> >
> > Or:
> >         if (ptr < PAGE_SIZE)
> >                 return ptr ? "(null+)" : "(null)";

Hmm, that is useful.

> >         if IS_ERR_VALUE(ptr)
> >                 return "(errno)"  

I still prefer "(fault)" as is pretty much all I would expect from a
pointer dereference, even if it is just bad parsing of, say, a parsing
an MAC address. "fault" is generic enough. "errno" will be confusing,
because that's normally a variable not a output.

> 
> Do we care about the value? "(-E%u)"?

That too could be confusing. What would (-E22) be considered by a user
doing an sprintf() on some string. I know that would confuse me, or I
would think that it was what the %pX displayed, and wonder why it
displayed it that way. Whereas "(fault)" is quite obvious for any %p
use case.

-- Steve
