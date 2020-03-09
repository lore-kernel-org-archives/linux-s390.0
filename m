Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29694 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727334AbgCIS33 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Mar 2020 14:29:29 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 029ILJNH070241
        for <linux-s390@vger.kernel.org>; Mon, 9 Mar 2020 14:29:28 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ym7ab0str-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 09 Mar 2020 14:29:27 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 9 Mar 2020 18:29:24 -0000
Subject: Re: [PATCH 3/4] KVM: s390: Also reset registers in sync regs for
 initial cpu reset
References: <20200309150026.4329-1-borntraeger@de.ibm.com>
 <20200309150026.4329-4-borntraeger@de.ibm.com>
 <0c644633-b3db-d095-d309-6fb90183f2dc@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 9 Mar 2020 19:29:19 +0100
MIME-Version: 1.0
In-Reply-To: <0c644633-b3db-d095-d309-6fb90183f2dc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <6f38707d-f5e6-9113-12aa-0b7c5bded715@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, stable@vger.kernel.org



On 09.03.20 16:39, David Hildenbrand wrote:
> On 09.03.20 16:00, Christian Borntraeger wrote:
>> When we do the initial CPU reset we must not only clear the registers
>> in the internal data structures but also in kvm_run sync_regs. For
>> modern userspace sync_regs is the only place that it looks at.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 7de3f1423ff943 ("KVM: s390: Add new reset vcpu API")
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/kvm/kvm-s390.c | 18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 6b1842a9feed..81f54ddedb3d 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -3529,7 +3529,10 @@ static void kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
>>  	/* Initial reset is a superset of the normal reset */
>>  	kvm_arch_vcpu_ioctl_normal_reset(vcpu);
>>  
>> -	/* this equals initial cpu reset in pop, but we don't switch to ESA */
>> +	/*
>> +	 * This equals initial cpu reset in pop, but we don't switch to ESA.
>> +	 * We do not even reset the internal data, but also ...
> 
> s/even/only ?

ack and fixed. I will give this series some time but it might be worthwile still for 5.6 (even
with the tests). 
