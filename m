Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30376 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725802AbgKSH2m (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Nov 2020 02:28:42 -0500
Subject: Re: [PATCH 4/6] s390/ctcm: Use explicit allocation mask in
 ctcmpc_unpack_skb().
References: <20201118105317.605671-1-bigeasy@linutronix.de>
 <20201118105317.605671-5-bigeasy@linutronix.de>
From: Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <1b886820-3cff-f8d4-46aa-0ec6fbe248bd@linux.ibm.com>
Date: Thu, 19 Nov 2020 09:28:24 +0200
MIME-Version: 1.0
In-Reply-To: <20201118105317.605671-5-bigeasy@linutronix.de>
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
> The call chain of ctcmpc_unpack_skb():
> ctcmpc_bh()
>  -> ctcmpc_unpack_skb()
> 
> ctcmpc_bh() is a tasklet handler so GFP_ATOMIC is needed.
> 
> Use GFP_ATOMIC as allocation type in ctcmpc_unpack_skb().
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Julian Wiedmann <jwi@linux.ibm.com>
