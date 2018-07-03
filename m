Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 3 Jul 2018 22:59:31 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
In-Reply-To: <20180629085752.zkbxlwc2rzlm63lk@xakep.localdomain>
Message-ID: <alpine.DEB.2.21.1807032257330.1816@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de> <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com> <alpine.DEB.2.21.1806232347540.8650@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1806261725510.1587@nanos.tec.linutronix.de> <CAGM2reYQ23XhQHAOO0Oo8MGvgrjpNZPZkwp+wwsU8Fb+jfANyA@mail.gmail.com> <alpine.DEB.2.21.1806270947410.1587@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806281159590.1778@nanos.tec.linutronix.de>
 <CAGM2read-NcUjssuUPHaf=qhdidT8f7cRNOs_GjdPnuOVvi-Lw@mail.gmail.com> <alpine.DEB.2.21.1806290925340.1578@nanos.tec.linutronix.de> <20180629085752.zkbxlwc2rzlm63lk@xakep.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, douly.fnst@cn.fujitsu.com, Peter Zijlstra <peterz@infradead.org>, Prarit Bhargava <prarit@redhat.com>, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, andriy.shevchenko@linux.intel.com, boris.ostrovsky@oracle.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 29 Jun 2018, Pavel Tatashin wrote:
> On 18-06-29 09:30:10, Thomas Gleixner wrote:
> For now, in my series, I would like check in tsc_early_init() if we are
> running xen, and set tsc_khz to 0 if so. Later in tsc_init() we will get
> a proper calibration. The question is how to make this check least
> intrusive.

By not having it at all. Talk to the XEN folks (IIRC there are a few
coworkers of you involved with XEN).

Thanks,

	tglx
