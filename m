Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 19 Jul 2018 12:48:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v14 25/25] sched: use static key for sched_clock_running
Message-ID: <20180719104838.GC2494@hirez.programming.kicks-ass.net>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
 <20180718022211.6259-26-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718022211.6259-26-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jul 17, 2018 at 10:22:11PM -0400, Pavel Tatashin wrote:
> sched_clock_running may be read every time sched_clock_cpu() is called.
> Yet, this variable is updated only twice during boot, and never changes
> again, therefore it is better to make it a static key.

Right, so the focus was always on making the sane TSC case fast, and if
TSC isn't stable we'd just make do and not care too much.

But this certainly isn't wrong, so ACK.
