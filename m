Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726531AbgKSIeV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Nov 2020 03:34:21 -0500
Subject: Re: [PATCH 0/6] s390/ctcm: Remove gfp_type() usage.
References: <20201118105317.605671-1-bigeasy@linutronix.de>
From: Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <edffa634-999e-66a0-fb21-c37803912583@linux.ibm.com>
Date: Thu, 19 Nov 2020 10:01:59 +0200
MIME-Version: 1.0
In-Reply-To: <20201118105317.605671-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-s390@vger.kernel.org
Cc: Karsten Graul <kgraul@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>

On 18.11.20 12:53, Sebastian Andrzej Siewior wrote:
> Folks,
> 
> in the discussion about preempt count consistency across kernel
> configurations:
>   https://lore.kernel.org/r/20200914204209.256266093@linutronix.de/
> 
> Linus clearly requested that code in drivers and libraries which changes
> behaviour based on execution context should either be split up so that
> e.g. task context invocations and BH invocations have different interfaces
> or if that's not possible the context information has to be provided by the
> caller which knows in which context it is executing.
> 
> This series is removing the gfp_type() usage which uses in_interrupt().
> Overall it appears to be a nice cleanup according to the diffstat.

Thank you for digging through this mess!

> There are still two in_irq() users left in ctcm which I'm currently
> struggling with.
> 

If that fixes the sparse complaints about unbalanced locking, it will be
very much appreciated!

> Sebastian
> 
> 
