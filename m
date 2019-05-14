Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 14 May 2019 15:35:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing
 addresses
Message-ID: <20190514153503.6b7faaa7@oasis.local.home>
In-Reply-To: <CAMuHMdUhy3uB+G23uXh__F2Y_Jsam5uS1Q5jJC95kWAOEM8WRA@mail.gmail.com>
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
        <20190514143751.48e81e05@oasis.local.home>
        <CAMuHMdUhy3uB+G23uXh__F2Y_Jsam5uS1Q5jJC95kWAOEM8WRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190514193503.XdZN4DHnv7PT3ysPIU9r8z4k2mgdzV7WD0-q-GTF5Zk@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Laight <David.Laight@aculab.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, christophe leroy <christophe.leroy@c-s.fr>, Linus Torvalds <torvalds@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Russell Currey <ruscur@russell.cc>, Stephen Rothwell <sfr@ozlabs.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 14 May 2019 21:13:06 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> > > Do we care about the value? "(-E%u)"?  
> >
> > That too could be confusing. What would (-E22) be considered by a user
> > doing an sprintf() on some string. I know that would confuse me, or I
> > would think that it was what the %pX displayed, and wonder why it
> > displayed it that way. Whereas "(fault)" is quite obvious for any %p
> > use case.  
> 
> I would immediately understand there's a missing IS_ERR() check in a
> function that can return  -EINVAL, without having to add a new printk()
> to find out what kind of bogus value has been received, and without
> having to reboot, and trying to reproduce...

Hi Geert,

I have to ask. Has there actually been a case that you used a %pX and
it faulted, and you had to go back to find what the value of the
failure was?

IMO, sprintf() should not be a tool to do this, because then people
will not add their IS_ERR() and just let sprintf() do the job for them.
I don't think that would be wise to allow.

-- Steve
