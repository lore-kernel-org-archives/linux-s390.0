Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726672AbgCKKiF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Mar 2020 06:38:05 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BAZ0Hh021945
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2020 06:38:04 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ypxc0r7mh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2020 06:38:03 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 11 Mar 2020 10:38:01 -0000
Subject: Re: [PATCH] KVM: s390: mark sie block as 512 byte aligned
References: <20200311083304.3725276-1-borntraeger@de.ibm.com>
 <9e15182c-f7ef-23b1-91e9-4b21b6bd5d99@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 11 Mar 2020 11:37:57 +0100
MIME-Version: 1.0
In-Reply-To: <9e15182c-f7ef-23b1-91e9-4b21b6bd5d99@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <69dd3390-0155-2538-ed25-1924e40a5b8c@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>



On 11.03.20 09:41, David Hildenbrand wrote:
> On 11.03.20 09:33, Christian Borntraeger wrote:
>> The sie block must be aligned to 512 bytes. Mark it as such.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>> index 0ea82152d2f7..2d50f6c432e2 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -344,7 +344,7 @@ struct kvm_s390_sie_block {
>>  	__u64	itdba;			/* 0x01e8 */
>>  	__u64   riccbd;			/* 0x01f0 */
>>  	__u64	gvrd;			/* 0x01f8 */
>> -} __attribute__((packed));
>> +} __packed __aligned(512);
>>  
> 
> I guess there is no change in the code/behavior, because we always place
> into well defined spots within a page.

In theory gcc can  generate code that relies on that alignment. For example
load relative long requires double word alignment. Or some atomic instructions.
This could - in theory - generate better code.

> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> 
