Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Sat, 23 Jun 2018 15:32:36 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v12 03/11] x86/tsc: redefine notsc to behave as
 tsc=unstable
In-Reply-To: <20180621212518.19914-4-pasha.tatashin@oracle.com>
Message-ID: <alpine.DEB.2.21.1806231532200.8650@nanos.tec.linutronix.de>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com> <20180621212518.19914-4-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 21 Jun 2018, Pavel Tatashin wrote:
> Currently, notsc kernel parameter disables the use of tsc register by
> sched_clock(). However, this parameter does not prevent linux from
> accessing tsc in other places in kernel.
> 
> The only rational to boot with notsc is to avoid timing discrepancies on
> multi-socket systems where different tsc frequencies may present, and thus
> fallback to jiffies for clock source.
> 
> However, there is another method to solve the above problem, it is to boot
> with tsc=unstable parameter. This parameter allows sched_clock() to use tsc
> but in case tsc is outside of expected interval it is corrected back to a
> sane value.
> 
> This is why there is no reason to keep notsc, and it can be removed. But,
> for compatibility reasons we will keep this parameter but change its
> definition to be the same as tsc=unstable.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Reviewed-by: Dou Liyang <douly.fnst@cn.fujitsu.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
