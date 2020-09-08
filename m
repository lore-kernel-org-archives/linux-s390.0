Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17062 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730607AbgIHQJr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Sep 2020 12:09:47 -0400
Date: Tue, 8 Sep 2020 15:41:44 +0200
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH] s390/idle: Fix suspicious RCU usage
Message-ID: <20200908134144.GH14136@osiris>
References: <20200908133031.GT1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908133031.GT1362448@hirez.programming.kicks-ass.net>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: peterz@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, rafael.j.wysocki@intel.com, svens@linux.ibm.com

On Tue, Sep 08, 2020 at 03:30:31PM +0200, peterz@infradead.org wrote:
> 
> After commit eb1f00237aca ("lockdep,trace: Expose tracepoints") the
> lock tracepoints are visible to lockdep and RCU-lockdep is finding a
> bunch more RCU violations that were previously hidden.
> 
> Switch the idle->seqcount over to using raw_write_*() to avoid the
> lockdep annotation and thus the lock tracepoints.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/s390/kernel/idle.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Applied, thank you!
