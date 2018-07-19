Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 19 Jul 2018 08:25:26 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v14 20/25] x86/tsc: calibrate tsc only once
In-Reply-To: <4f0933a3-27b4-5468-83f5-af9b90842812@cn.fujitsu.com>
Message-ID: <alpine.DEB.2.21.1807190818110.1689@nanos.tec.linutronix.de>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com> <20180718022211.6259-21-pasha.tatashin@oracle.com> <4f0933a3-27b4-5468-83f5-af9b90842812@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 19 Jul 2018, Dou Liyang wrote:
> At 07/18/2018 10:22 AM, Pavel Tatashin wrote:
> > +		(unsigned long)cpu_khz % KHZ);
> >     	if (cpu_khz != tsc_khz) {
> >   		pr_info("Detected %lu.%03lu MHz TSC",
> > -			(unsigned long)tsc_khz / 1000,
> > -			(unsigned long)tsc_khz % 1000);
> > +			(unsigned long)tsc_khz / KHZ,
> > +			(unsigned long)tsc_khz % KHZ);
> > +	}
> 
> this curly brackets can be removed

No. They want to stay, really.

    https://lkml.kernel.org/r/alpine.DEB.2.20.1701171956290.3645@nanos

The pr_info() is a multiline statement due to the line breaks.

Thanks,

	tglx
