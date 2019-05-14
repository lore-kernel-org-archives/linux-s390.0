Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH] vsprintf: Do not break early boot with probing addresses
Date: Tue, 14 May 2019 08:28:21 +0000
Message-ID: <45348cf615fe40d383c1a25688d4a88f@AcuMS.aculab.com>
References: <20190510081635.GA4533@jagdpanzerIV>
 <20190510084213.22149-1-pmladek@suse.com>
 <20190510122401.21a598f6@gandalf.local.home>
 <daf4dfd1-7f4f-8b92-6866-437c3a2be28b@c-s.fr>
 <096d6c9c17b3484484d9d9d3f3aa3a7c@AcuMS.aculab.com>
 <20190513091320.GK9224@smile.fi.intel.com>
 <20190513124220.wty2qbnz4wo52h3x@pathway.suse.cz>
 <20190514020730.GA651@jagdpanzerIV>
In-Reply-To: <20190514020730.GA651@jagdpanzerIV>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190514082821.vHA7v2O08oEYQIonTCUC1XbIM9aVA42znGjzYx0yqEA@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: 'Sergey Senozhatsky' <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 'christophe leroy' <christophe.leroy@c-s.fr>, Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Russell Currey <ruscur@russell.cc>, Stephen Rothwell <sfr@ozlabs.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

> And I like Steven's "(fault)" idea.
> How about this:
> 
> 	if ptr < PAGE_SIZE		-> "(null)"
> 	if IS_ERR_VALUE(ptr)		-> "(fault)"
> 
> 	-ss

Or:
	if (ptr < PAGE_SIZE)
		return ptr ? "(null+)" : "(null)";
	if IS_ERR_VALUE(ptr)
		return "(errno)"

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
