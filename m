Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727349AbgKQPch (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Nov 2020 10:32:37 -0500
Subject: Re: [PATCH 2/2] s390/gmap: make gmap memcg aware
References: <20201117151023.424575-1-borntraeger@de.ibm.com>
 <20201117151023.424575-3-borntraeger@de.ibm.com>
 <fd9f77d2-fdd1-d2ab-d9ca-ee914ac9deaf@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <22430706-ccb1-2df6-79ca-4db53c9d8105@de.ibm.com>
Date: Tue, 17 Nov 2020 16:31:14 +0100
MIME-Version: 1.0
In-Reply-To: <fd9f77d2-fdd1-d2ab-d9ca-ee914ac9deaf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>



On 17.11.20 16:22, Janosch Frank wrote:
> On 11/17/20 4:10 PM, Christian Borntraeger wrote:
>> gmap allocations can be attributed to a process.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Acked-by: Heiko Carstens <hca@linux.ibm.com>
>> ---
>>  arch/s390/mm/gmap.c | 30 +++++++++++++++---------------
>>  1 file changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
>> index 64795d034926..9bb2c7512cd5 100644
>> --- a/arch/s390/mm/gmap.c
>> +++ b/arch/s390/mm/gmap.c
>> @@ -2,7 +2,7 @@
>>  /*
>>   *  KVM guest address space mapping code
>>   *
>> - *    Copyright IBM Corp. 2007, 2016, 2018
>> + *    Copyright IBM Corp. 2007, 2020
> 
> Do you mean 2007 - 2020 or did you drop the 2016 and 2018?
> How does this even work?

Last time I checked this was the IBM preferred variant to define
the range. first and last contribution.
