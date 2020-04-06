Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726475AbgDFIc6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Apr 2020 04:32:58 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0368WQbU132910
        for <linux-s390@vger.kernel.org>; Mon, 6 Apr 2020 04:32:57 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 306paku76y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 06 Apr 2020 04:32:57 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 6 Apr 2020 09:32:34 +0100
Subject: Re: [PATCH v2 1/5] KVM: s390: vsie: Fix region 1 ASCE sanity shadow
 address checks
References: <59b411eb-dabe-8cac-9270-7a9f0faa63d5@de.ibm.com>
 <67F45F4F-33CB-455A-8CB8-7D20D9A2BF2F@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 6 Apr 2020 10:32:50 +0200
MIME-Version: 1.0
In-Reply-To: <67F45F4F-33CB-455A-8CB8-7D20D9A2BF2F@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <e6ef6a64-70eb-448f-1dcf-2f032f94cf07@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, stable@vger.kernel.org



On 03.04.20 21:55, David Hildenbrand wrote:
> 
> 
>> Am 03.04.2020 um 19:56 schrieb Christian Borntraeger <borntraeger@de.ibm.com>:
>>
>> ﻿
>>
>>> On 03.04.20 17:30, David Hildenbrand wrote:
>>> In case we have a region 1 ASCE, our shadow/g3 address can have any value.
>>> Unfortunately, (-1UL << 64) is undefined and triggers sometimes,
>>> rejecting valid shadow addresses when trying to walk our shadow table
>>> hierarchy.
>>
>> I thin the range of the addresses do not matter.
>> Took me a while to understand maybe rephrase that:
>>
>> In case we have a region 1 the following calculation 
>> (31 + ((gmap->asce & _ASCE_TYPE_MASK) >> 2)*11)
>> results in 64. As shifts beyond the size are undefined the compiler is free to use
>> instructions like sllg. sllg will only use 6 bits of the shift value (here 64)
>> resulting in no shift at all. That means that ALL addresses will be rejected.
> 
> Interestingly, it would not fail when shadowing the r2t, but only when trying to shadow the r3t.
> 
>>
>> With that this makes sense. 
>>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>
> 
> In case there are no other comments, can you fixup when applying, or do you want me to resend?

I can fixup.
