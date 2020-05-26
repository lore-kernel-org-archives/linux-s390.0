Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56752 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728151AbgEZLvk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 26 May 2020 07:51:40 -0400
Subject: Re: [kvm-unit-tests PATCH v7 03/12] s390x: Move control register bit
 definitions and add AFP to them
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
 <1589818051-20549-4-git-send-email-pmorel@linux.ibm.com>
 <7614689a-62e6-944e-6162-93aa72407a90@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <d47305f9-7366-eccc-c202-d324236196f2@linux.ibm.com>
Date: Tue, 26 May 2020 13:51:33 +0200
MIME-Version: 1.0
In-Reply-To: <7614689a-62e6-944e-6162-93aa72407a90@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com



On 2020-05-25 20:57, Thomas Huth wrote:
> On 18/05/2020 18.07, Pierre Morel wrote:
>> While adding the definition for the AFP-Register control bit, move all
>> existing definitions for CR0 out of the C zone to the assmbler zone to
>> keep the definitions concerning CR0 together.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>   lib/s390x/asm/arch_def.h | 11 ++++++-----
>>   s390x/cstart64.S         |  2 +-
>>   2 files changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
>> index 820af93..54ffd0b 100644
>> --- a/lib/s390x/asm/arch_def.h
>> +++ b/lib/s390x/asm/arch_def.h
>> @@ -19,17 +19,18 @@
>>   
>>   #define PSW_EXCEPTION_MASK	(PSW_MASK_EA | PSW_MASK_BA)
>>   
>> +#define CR0_EXTM_SCLP			0X0000000000000200UL
>> +#define CR0_EXTM_EXTC			0X0000000000002000UL
>> +#define CR0_EXTM_EMGC			0X0000000000004000UL
>> +#define CR0_EXTM_MASK			0X0000000000006200UL
>> +#define CR0_AFP_REG_CRTL		0x0000000000040000UL
>> +
>>   #ifndef __ASSEMBLER__
>>   struct psw {
>>   	uint64_t	mask;
>>   	uint64_t	addr;
>>   };
>>   
>> -#define CR0_EXTM_SCLP			0X0000000000000200UL
>> -#define CR0_EXTM_EXTC			0X0000000000002000UL
>> -#define CR0_EXTM_EMGC			0X0000000000004000UL
>> -#define CR0_EXTM_MASK			0X0000000000006200UL
> 
> This patch does not apply anymore due to commit f7df29115f736b ...
> please switch to lower-case "0x"s in the next version.
> 
>   Thanks,
>    Thomas
> 

OK, I will rebase.
Thanks,
Pierre



-- 
Pierre Morel
IBM Lab Boeblingen
