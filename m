Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 26 Jun 2018 17:07:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v12 10/11] sched: early boot clock
Message-ID: <20180626150703.GC2458@hirez.programming.kicks-ass.net>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-11-pasha.tatashin@oracle.com>
 <20180625085543.GT2494@hirez.programming.kicks-ass.net>
 <20180625192320.kzmqkvmfh5aeuhhx@xakep.localdomain>
 <20180626090003.GA2458@hirez.programming.kicks-ass.net>
 <20180626112705.4dxrsd5acvobla5y@xakep.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626112705.4dxrsd5acvobla5y@xakep.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jun 26, 2018 at 07:27:05AM -0400, Pavel Tatashin wrote:

> We start getting timer interrupts. Is it acceptable to move
> sched_clock_init() after late_time_init()?

After much puzzling and cursing, yes, I suppose that'll work.
