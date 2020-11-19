Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726182AbgKSHpR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Nov 2020 02:45:17 -0500
Subject: Re: [PATCH 1/6] s390/ctcm: Put struct th_header and th_sweep on
 stack.
References: <20201118105317.605671-1-bigeasy@linutronix.de>
 <20201118105317.605671-2-bigeasy@linutronix.de>
From: Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <88ac2454-32f4-f48b-f255-b23aedabc45b@linux.ibm.com>
Date: Thu, 19 Nov 2020 09:45:08 +0200
MIME-Version: 1.0
In-Reply-To: <20201118105317.605671-2-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-s390@vger.kernel.org
Cc: Karsten Graul <kgraul@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>

On 18.11.20 12:53, Sebastian Andrzej Siewior wrote:
> The size of struct th_header is 8 byte and the size of struct th_sweep
> is 16 byte. The memory for is allocated, initialized, used and
> deallocated a few lines later.
> 
> It is more efficient to avoid the allocation/free dance and keeping the
> variable on stack. Especially since the compiler is smart enough to not
> allocate the memory on stack but assign the values directly.
> 
> Declare struct th_sweep/th_header on stack and initialize it to zero.
> Use the local variable instead of the pointer.
> 

Frankly, I'd much rather see us use the pointers that are returned from
skb_push() and skb_put(). No need for the on-stack & memcpy indirection.
