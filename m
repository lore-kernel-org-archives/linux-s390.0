Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726291AbgLQOcU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Dec 2020 09:32:20 -0500
Subject: Re: [kvm-unit-tests PATCH v3 7/8] s390x: Add diag318 intercept test
References: <20201211100039.63597-1-frankja@linux.ibm.com>
 <20201211100039.63597-8-frankja@linux.ibm.com>
 <4f689585-ae2e-4632-9055-f2332d9f7751@redhat.com>
 <44d6ac32-f7ac-6b33-ea9e-e037f936a181@de.ibm.com>
 <24e9883c-22d5-de4f-0001-d271855d7ea3@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <23af5bca-dd2c-43bd-b2b4-6c7e2031517f@linux.ibm.com>
Date: Thu, 17 Dec 2020 15:31:32 +0100
MIME-Version: 1.0
In-Reply-To: <24e9883c-22d5-de4f-0001-d271855d7ea3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: david@redhat.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 12/17/20 11:34 AM, Thomas Huth wrote:
> On 17/12/2020 10.59, Christian Borntraeger wrote:
>>
>>
>> On 17.12.20 10:53, Thomas Huth wrote:
>>> On 11/12/2020 11.00, Janosch Frank wrote:
>>>> Not much to test except for the privilege and specification
>>>> exceptions.
>>>>
>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>  lib/s390x/sclp.c  |  2 ++
>>>>  lib/s390x/sclp.h  |  6 +++++-
>>>>  s390x/intercept.c | 19 +++++++++++++++++++
>>>>  3 files changed, 26 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
>>>> index cf6ea7c..0001993 100644
>>>> --- a/lib/s390x/sclp.c
>>>> +++ b/lib/s390x/sclp.c
>>>> @@ -138,6 +138,8 @@ void sclp_facilities_setup(void)
>>>>  
>>>>  	assert(read_info);
>>>>  
>>>> +	sclp_facilities.has_diag318 = read_info->byte_134_diag318;
>>>> +
>>>>  	cpu = (void *)read_info + read_info->offset_cpu;
>>>>  	for (i = 0; i < read_info->entries_cpu; i++, cpu++) {
>>>>  		if (cpu->address == cpu0_addr) {
>>>> diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
>>>> index 6c86037..58f8e54 100644
>>>> --- a/lib/s390x/sclp.h
>>>> +++ b/lib/s390x/sclp.h
>>>> @@ -105,7 +105,8 @@ extern struct sclp_facilities sclp_facilities;
>>>>  
>>>>  struct sclp_facilities {
>>>>  	uint64_t has_sief2 : 1;
>>>> -	uint64_t : 63;
>>>> +	uint64_t has_diag318 : 1;
>>>> +	uint64_t : 62;
>>>>  };
>>>>  
>>>>  typedef struct ReadInfo {
>>>> @@ -130,6 +131,9 @@ typedef struct ReadInfo {
>>>>      uint16_t highest_cpu;
>>>>      uint8_t  _reserved5[124 - 122];     /* 122-123 */
>>>>      uint32_t hmfai;
>>>> +    uint8_t reserved7[134 - 128];
>>>> +    uint8_t byte_134_diag318 : 1;
>>>> +    uint8_t : 7;
>>>>      struct CPUEntry entries[0];
>>>
>>> ... the entries[] array can be moved around here without any further ado?
>>> Looks confusing to me. Should there be a CPUEntry array here at all, or only
>>> in ReadCpuInfo?
>>
>> there is offset_cpu for the cpu entries at the beginning of the structure.
> 
> Ah, thanks, right, this was used earlier in the patch series, now I
> remember. But I think the "struct CPUEntry entries[0]" here is rather
> confusing, since there is no guarantee that the entries are really at this
> location ... I think this line should rather be replaced by a comment saying
> that offset_cpu should be used instead.

Sure, as long as it's clear that there's something at the end, I'm fine
with it.

> 
>  Thomas
> 
