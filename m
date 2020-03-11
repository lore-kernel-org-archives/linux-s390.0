Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729531AbgCKOJA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Mar 2020 10:09:00 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BE2dM7072726
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2020 10:08:59 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yq0yh9txp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2020 10:08:57 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 11 Mar 2020 14:07:43 -0000
Subject: Re: [PATCH 2/2] selftests: KVM: s390: fix format strings for access
 reg test
References: <20200311131056.140016-1-borntraeger@de.ibm.com>
 <20200311131056.140016-3-borntraeger@de.ibm.com>
 <6c8ac2c1-a4c3-41be-6e9c-0c82f2d7a59d@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 11 Mar 2020 15:07:37 +0100
MIME-Version: 1.0
In-Reply-To: <6c8ac2c1-a4c3-41be-6e9c-0c82f2d7a59d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b403bb7b-b5d7-7c6d-185a-db4b1b6f946f@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Andrew Jones <drjones@redhat.com>



On 11.03.20 15:03, Janosch Frank wrote:
> On 3/11/20 2:10 PM, Christian Borntraeger wrote:
>> acrs are 32 bit and not 64 bit.
>>
>> Reported-by: Andrew Jones <drjones@redhat.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> Acked-by: Janosch Frank <frankja@linux.ibm.com>
> 
>> ---
>>  tools/testing/selftests/kvm/s390x/sync_regs_test.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/s390x/sync_regs_test.c b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
>> index b705637ca14b..70a56580042b 100644
>> --- a/tools/testing/selftests/kvm/s390x/sync_regs_test.c
>> +++ b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
>> @@ -42,6 +42,13 @@ static void guest_code(void)
>>  		    " values did not match: 0x%llx, 0x%llx\n", \
>>  		    left->reg, right->reg)
>>  
>> +#define REG_COMPARE32(reg) \
>> +	TEST_ASSERT(left->reg == right->reg, \
>> +		    "Register " #reg \
>> +		    " values did not match: 0x%x, 0x%x\n", \
>> +		    left->reg, right->reg)
>> +
>> +
> 
> One \n too much?

yep.

> 
>>  static void compare_regs(struct kvm_regs *left, struct kvm_sync_regs *right)
>>  {
>>  	int i;
>> @@ -55,7 +62,7 @@ static void compare_sregs(struct kvm_sregs *left, struct kvm_sync_regs *right)
>>  	int i;
>>  
>>  	for (i = 0; i < 16; i++)
>> -		REG_COMPARE(acrs[i]);
>> +		REG_COMPARE32(acrs[i]);
>>  
>>  	for (i = 0; i < 16; i++)
>>  		REG_COMPARE(crs[i]);
>> @@ -155,7 +162,7 @@ int main(int argc, char *argv[])
>>  		    "r11 sync regs value incorrect 0x%llx.",
>>  		    run->s.regs.gprs[11]);
>>  	TEST_ASSERT(run->s.regs.acrs[0]  == 1 << 11,
>> -		    "acr0 sync regs value incorrect 0x%llx.",
>> +		    "acr0 sync regs value incorrect 0x%x.",
>>  		    run->s.regs.acrs[0]);
>>  
>>  	vcpu_regs_get(vm, VCPU_ID, &regs);
>>
> 
> 
