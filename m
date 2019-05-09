Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH] vsprintf: Do not break early boot with probing addresses
Date: Thu, 9 May 2019 13:46:59 +0000
Message-ID: <8ad8bb83b7034f7e92df12040fb8c2c2@AcuMS.aculab.com>
References: <20190509121923.8339-1-pmladek@suse.com>
 <20190509153829.06319d0c@kitsune.suse.cz>
In-Reply-To: <20190509153829.06319d0c@kitsune.suse.cz>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190509134659.kYjGd-skkWNID8rAreeNzTDTLfzq382O0FQCZ5calZI@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: =?iso-8859-1?Q?=27Michal_Such=E1nek=27?= <msuchanek@suse.de>, Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Michal Hocko <mhocko@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Stephen Rothwell <sfr@ozlabs.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>
List-ID: <linux-s390.vger.kernel.org>

From: Michal Suchánek
> Sent: 09 May 2019 14:38
...
> > The problem is the combination of some new code called via printk(),
> > check_pointer() which calls probe_kernel_read(). That then calls
> > allow_user_access() (PPC_KUAP) and that uses mmu_has_feature() too early
> > (before we've patched features).
> 
> There is early_mmu_has_feature for this case. mmu_has_feature does not
> work before patching so parts of kernel that can run before patching
> must use the early_ variant which actually runs code reading the
> feature bitmap to determine the answer.

Does the early_ variant get patched so the it is reasonably
efficient after the 'patching' is done?
Or should there be a third version which gets patched across?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
