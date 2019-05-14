Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 14 May 2019 11:07:30 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing addresses
Message-ID: <20190514020730.GA651@jagdpanzerIV>
References: <20190510081635.GA4533@jagdpanzerIV>
 <20190510084213.22149-1-pmladek@suse.com>
 <20190510122401.21a598f6@gandalf.local.home>
 <daf4dfd1-7f4f-8b92-6866-437c3a2be28b@c-s.fr>
 <096d6c9c17b3484484d9d9d3f3aa3a7c@AcuMS.aculab.com>
 <20190513091320.GK9224@smile.fi.intel.com>
 <20190513124220.wty2qbnz4wo52h3x@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513124220.wty2qbnz4wo52h3x@pathway.suse.cz>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190514020730.g4cTS2GpqhzzEgKbRibvfxOK38Jika-NdjcqZLJn1As@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Laight <David.Laight@aculab.com>, 'christophe leroy' <christophe.leroy@c-s.fr>, Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Russell Currey <ruscur@russell.cc>, Stephen Rothwell <sfr@ozlabs.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On (05/13/19 14:42), Petr Mladek wrote:
> > The "(null)" is good enough by itself and already an established
> > practice..
> 
> (efault) made more sense with the probe_kernel_read() that
> checked wide range of addresses. Well, I still think that
> it makes sense to distinguish a pure NULL. And it still
> used also for IS_ERR_VALUE().

Wouldn't anything within first PAGE_SIZE bytes be reported as
a NULL deref?

       char *p = (char *)(PAGE_SIZE - 2);
       *p = 'a';

gives

 kernel: BUG: kernel NULL pointer dereference, address = 0000000000000ffe
 kernel: #PF: supervisor-privileged write access from kernel code
 kernel: #PF: error_code(0x0002) - not-present page


And I like Steven's "(fault)" idea.
How about this:

	if ptr < PAGE_SIZE		-> "(null)"
	if IS_ERR_VALUE(ptr)		-> "(fault)"

	-ss
