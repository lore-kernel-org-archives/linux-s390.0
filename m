Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 19 Jul 2018 12:33:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v14 20/25] x86/tsc: calibrate tsc only once
Message-ID: <20180719103340.GA2494@hirez.programming.kicks-ass.net>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
 <20180718022211.6259-21-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718022211.6259-21-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jul 17, 2018 at 10:22:06PM -0400, Pavel Tatashin wrote:
> During boot tsc is calibrated twice: once in tsc_early_delay_calibrate(),
> and the second time in tsc_init().
> 
> Rename tsc_early_delay_calibrate() to tsc_early_init(), and rework it so
> the calibration is done only early, and make tsc_init() to use the values
> already determined in tsc_early_init().
> 
> Sometimes it is not possible to determine tsc early, as the subsystem that
> is required is not yet initialized, in such case try again later in
> tsc_init().

It might be nice to preserve some of the information tglx dug out during
review of all this. Like the various methods of calibrate_*() and their
dependencies.

And I note that this patch relies on the magic of native_calibrate_cpu()
working really early and not exploding in the quick calibration run.
This either wants fixing or documenting.

I think the initial idea was to only do the fast_calibrate (cpuid, msr
and possibly the quick_pit) things early and delay the HPET/PMTIMER
magic until later.
