Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725940AbgKTIHF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Nov 2020 03:07:05 -0500
Subject: Re: [PATCH v2 0/6] s390/ctcm: Remove gfp_type() usage.
References: <20201119135719.983170-1-bigeasy@linutronix.de>
From: Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <d40cf363-c4e0-8f2b-6a39-c180c0f00338@linux.ibm.com>
Date: Fri, 20 Nov 2020 10:06:57 +0200
MIME-Version: 1.0
In-Reply-To: <20201119135719.983170-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-s390@vger.kernel.org
Cc: Karsten Graul <kgraul@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>

On 19.11.20 15:57, Sebastian Andrzej Siewior wrote:
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
> 
> v1…v2:
> 	- Use the pointer from skb_put()/push() instead having it on
> 	  stack.
> 	- Collect acks for patch 4-6.
> 
> Sebastian
> 
> 

Thank you Sebastian! All applied.
