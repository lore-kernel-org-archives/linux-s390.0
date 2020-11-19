Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40006 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725888AbgKSHaa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Nov 2020 02:30:30 -0500
Subject: Re: [PATCH 5/6] s390/ctcm: Use GFP_KERNEL in add_channel().
References: <20201118105317.605671-1-bigeasy@linutronix.de>
 <20201118105317.605671-6-bigeasy@linutronix.de>
From: Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <f09c3bdd-bb0b-4b77-ba64-675393100b55@linux.ibm.com>
Date: Thu, 19 Nov 2020 09:30:21 +0200
MIME-Version: 1.0
In-Reply-To: <20201118105317.605671-6-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-s390@vger.kernel.org
Cc: Karsten Graul <kgraul@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>

On 18.11.20 12:53, Sebastian Andrzej Siewior wrote:
> gfp_type() uses in_interrupt() to figure out the correct GFP mask.
> 
> The usage of in_interrupt() in drivers is phased out and Linus clearly
> requested that code which changes behaviour depending on context should
> either be separated or the context be conveyed in an argument passed by the
> caller, which usually knows the context.
> 
> The memory allocation of `ch' a few lines above is using GFP_KERNEL,
> also an allocation a few lines later is using GFP_KERNEL.
> 
> Use GFP_KERNEL for the memory allocation.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Julian Wiedmann <jwi@linux.ibm.com>
