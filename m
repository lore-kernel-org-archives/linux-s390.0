Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29620 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731702AbgGaHuw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jul 2020 03:50:52 -0400
Subject: Re: [PATCH net-next 4/4] s390/qeth: use all configured RX buffers
References: <20200730150121.18005-1-jwi@linux.ibm.com>
 <20200730150121.18005-5-jwi@linux.ibm.com>
 <20200730163714.7d6a5017@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: Julian Wiedmann <jwi@linux.ibm.com>
Message-ID: <dcc95391-0dea-e7d4-1901-25c00c7a3c60@linux.ibm.com>
Date: Fri, 31 Jul 2020 09:50:43 +0200
MIME-Version: 1.0
In-Reply-To: <20200730163714.7d6a5017@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>

On 31.07.20 01:37, Jakub Kicinski wrote:
> On Thu, 30 Jul 2020 17:01:21 +0200 Julian Wiedmann wrote:
>> The (misplaced) comment doesn't make any sense, enforcing an
>> uninitialized RX buffer won't help with IRQ reduction.
>>
>> So make the best use of all available RX buffers.
> 
> Often one entry in the ring is left free to make it easy to
> differentiate between empty and full conditions. 
> 
> Is this not the reason here?
> 

Hmm no, the HW architecture works slightly different.

There's no index register that we could query for HW progress,
each ring entry has an associated state byte that needs to be
inspected and indicates HW progress (among other things).

So this was more likely just a mis-interpretation of how the
(quirky) IRQ reduction mechanism works in HW, or maybe part of
a code path that got removed during the NAPI conversion.
