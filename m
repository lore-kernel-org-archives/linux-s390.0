Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 20 Jul 2018 00:34:26 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v15 00/26] Early boot time stamps
In-Reply-To: <20180719205545.16512-1-pasha.tatashin@oracle.com>
Message-ID: <alpine.DEB.2.21.1807200029440.1693@nanos.tec.linutronix.de>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

Pavel,

On Thu, 19 Jul 2018, Pavel Tatashin wrote:

> changelog
> ---------
> v15 - v14

I've applied the series to tip:x86/timers and pushed it out.

Thanks for the patience and for going the extra miles to reach your initial
goal of early TSC timestamps. The overall result looks very reasonable and
is not only a functional improvement: Quite some old ballast and duct tape
has been cleaned up on the way.

Thanks,

	tglx
