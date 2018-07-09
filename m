Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
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
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <e256129f-eed8-bd02-a462-d97db68c5de6@oracle.com>
Date: Mon, 9 Jul 2018 19:16:00 -0400
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1806281159590.1778@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, douly.fnst@cn.fujitsu.com, Peter Zijlstra <peterz@infradead.org>, Prarit Bhargava <prarit@redhat.com>, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-ID: <linux-s390.vger.kernel.org>

On 06/28/2018 06:43 AM, Thomas Gleixner wrote:
>
> For enhanced fun the early calibration stuff was moved from right after
> init_hypervisor_platform() to the place where it is now in commit
> ccb64941f375a6 ("x86/timers: Move simple_udelay_calibration() past
> kvmclock_init()") to speed up KVM boot time by avoiding the PIT
> calibration. I have no idea why it wasn't just moved past the XEN
> initialization a few lines further down, especially as the change was done
> by a XEN maintainer :) Boris?

(Sorry for late response, I was out)


No good reason for that. I don't know what (whether?) I was thinking.

-boris
