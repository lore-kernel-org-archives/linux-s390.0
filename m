Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21480 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726291AbgLQP0r (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Dec 2020 10:26:47 -0500
Subject: Re: [kvm-unit-tests PATCH v3 7/8] s390x: Add diag318 intercept test
References: <20201211100039.63597-1-frankja@linux.ibm.com>
 <20201211100039.63597-8-frankja@linux.ibm.com>
 <20201217155826.33c7bef1@ibm-vm>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <96ce6e78-0c91-2093-5e2b-3d9e9f906ccb@linux.ibm.com>
Date: Thu, 17 Dec 2020 16:25:59 +0100
MIME-Version: 1.0
In-Reply-To: <20201217155826.33c7bef1@ibm-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 12/17/20 3:58 PM, Claudio Imbrenda wrote:
> On Fri, 11 Dec 2020 05:00:38 -0500
> Janosch Frank <frankja@linux.ibm.com> wrote:
> 
>> Not much to test except for the privilege and specification
>> exceptions.
> 
> This patch looks fine. But I wonder what is it doing in this series?
> The series is about SIE testing, and this seems to be an unrelated
> improvement in an existing testcase?

I didn't want to split my patches up in multiple series and this depends
on the sclp changes.

> 
> anyway, looks good to me
> 
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Thanks

> 
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  lib/s390x/sclp.c  |  2 ++
>>  lib/s390x/sclp.h  |  6 +++++-
>>  s390x/intercept.c | 19 +++++++++++++++++++
>>  3 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
>> index cf6ea7c..0001993 100644
>> --- a/lib/s390x/sclp.c
>> +++ b/lib/s390x/sclp.c
>> @@ -138,6 +138,8 @@ void sclp_facilities_setup(void)
>>  
>>  	assert(read_info);
>>  
>> +	sclp_facilities.has_diag318 = read_info->byte_134_diag318;
>> +
>>  	cpu = (void *)read_info + read_info->offset_cpu;
>>  	for (i = 0; i < read_info->entries_cpu; i++, cpu++) {
>>  		if (cpu->address == cpu0_addr) {
>> diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
>> index 6c86037..58f8e54 100644
>> --- a/lib/s390x/sclp.h
>> +++ b/lib/s390x/sclp.h
>> @@ -105,7 +105,8 @@ extern struct sclp_facilities sclp_facilities;
>>  
>>  struct sclp_facilities {
>>  	uint64_t has_sief2 : 1;
>> -	uint64_t : 63;
>> +	uint64_t has_diag318 : 1;
>> +	uint64_t : 62;
>>  };
>>  
>>  typedef struct ReadInfo {
>> @@ -130,6 +131,9 @@ typedef struct ReadInfo {
>>      uint16_t highest_cpu;
>>      uint8_t  _reserved5[124 - 122];     /* 122-123 */
>>      uint32_t hmfai;
>> +    uint8_t reserved7[134 - 128];
>> +    uint8_t byte_134_diag318 : 1;
>> +    uint8_t : 7;
>>      struct CPUEntry entries[0];
>>  } __attribute__((packed)) ReadInfo;
>>  
>> diff --git a/s390x/intercept.c b/s390x/intercept.c
>> index cde2f5f..86e57e1 100644
>> --- a/s390x/intercept.c
>> +++ b/s390x/intercept.c
>> @@ -8,6 +8,7 @@
>>   *  Thomas Huth <thuth@redhat.com>
>>   */
>>  #include <libcflat.h>
>> +#include <sclp.h>
>>  #include <asm/asm-offsets.h>
>>  #include <asm/interrupt.h>
>>  #include <asm/page.h>
>> @@ -152,6 +153,23 @@ static void test_testblock(void)
>>  	check_pgm_int_code(PGM_INT_CODE_ADDRESSING);
>>  }
>>  
>> +static void test_diag318(void)
>> +{
>> +	expect_pgm_int();
>> +	enter_pstate();
>> +	asm volatile("diag %0,0,0x318\n" : : "d" (0x42));
>> +	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
>> +
>> +	if (!sclp_facilities.has_diag318)
>> +		expect_pgm_int();
>> +
>> +	asm volatile("diag %0,0,0x318\n" : : "d" (0x42));
>> +
>> +	if (!sclp_facilities.has_diag318)
>> +		check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
>> +
>> +}
>> +
>>  struct {
>>  	const char *name;
>>  	void (*func)(void);
>> @@ -162,6 +180,7 @@ struct {
>>  	{ "stap", test_stap, false },
>>  	{ "stidp", test_stidp, false },
>>  	{ "testblock", test_testblock, false },
>> +	{ "diag318", test_diag318, false },
>>  	{ NULL, NULL, false }
>>  };
>>  
> 
