Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
Message-ID: <24734cab3a622e17a4f6408b63ad8ecdc7b496e6.camel@linux.intel.com>
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 29 Jun 2018 20:50:09 +0300
In-Reply-To: <3ae524498e6833abd5bb225987de97580262c4de.camel@linux.intel.com>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
         <20180621212518.19914-10-pasha.tatashin@oracle.com>
         <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de>
         <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
         <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com>
         <alpine.DEB.2.21.1806232347540.8650@nanos.tec.linutronix.de>
         <alpine.DEB.2.21.1806261725510.1587@nanos.tec.linutronix.de>
         <CAGM2reYQ23XhQHAOO0Oo8MGvgrjpNZPZkwp+wwsU8Fb+jfANyA@mail.gmail.com>
         <alpine.DEB.2.21.1806270947410.1587@nanos.tec.linutronix.de>
         <alpine.DEB.2.21.1806281159590.1778@nanos.tec.linutronix.de>
         <3ae524498e6833abd5bb225987de97580262c4de.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, douly.fnst@cn.fujitsu.com, Peter Zijlstra <peterz@infradead.org>, Prarit Bhargava <prarit@redhat.com>, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 2018-06-29 at 17:30 +0300, Andy Shevchenko wrote:
> On Thu, 2018-06-28 at 12:43 +0200, Thomas Gleixner wrote:
> > On Thu, 28 Jun 2018, Thomas Gleixner wrote:
> > > 

> Taking above into consideration, I think we may just remove the legacy
> code from mfld.c and mrfld.c and see what happen.
> 
> If you can tell me points to test, I can prepare patches to remove and
> test on both Medfiled and Merrifield platforms (Penwell and Tangier
> SoCs
> respectively).

I'm almost have a patch series. Tested for now for Intel Merrifield
(Tangier SoC).


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
