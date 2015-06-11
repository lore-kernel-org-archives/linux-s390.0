Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1434018301.1495.73.camel@twins>
Subject: Re: [PATCH 1/2] perf: return ENOENT instead of ENOTSUPP
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Thu, 11 Jun 2015 12:25:01 +0200
In-Reply-To: <1434016745-17608-1-git-send-email-brueckner@linux.vnet.ibm.com>
References: <1434016745-17608-1-git-send-email-brueckner@linux.vnet.ibm.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Vince Weaver <vincent.weaver@maine.edu>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2015-06-11 at 11:59 +0200, Hendrik Brueckner wrote:
> The ENOTSUPP (which actually should be EOPNOTSUPP for user space) does not
> trigger a fallback event selection, for example, by perf record.
> If hardware support for the cycles perf event is available, but the hardware
> does not provide interrupts, returning ENOTSUPP causes perf to end.  Returning
> ENOENT causes the perf tool to fallback to a software-based cycle PMU that
> supports interrupts.
> 
> The commit 53b25335dd ("perf: Disable sampled events if no PMU interrupt")
> introduced that incompatible change.

That's 3.16

>  		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
> -			err = -ENOTSUPP;
> +			err = -ENOENT;
>  			goto err_alloc;
>  		}
>  	}

And now you would be changing an API that's been around for at least 4
releases.

Also, I really think -ENOENT is the wrong return here, you're asking for
things that's not supported, not for something that's not there.
