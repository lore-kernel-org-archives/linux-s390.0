Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14058 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725861AbgK3Mjd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Nov 2020 07:39:33 -0500
Subject: Re: [kvm-unit-tests PATCH v2 6/7] s390x: Add diag318 intercept test
References: <20201127130629.120469-1-frankja@linux.ibm.com>
 <20201127130629.120469-7-frankja@linux.ibm.com>
 <f1f8ce84-e30a-29c5-8ab6-7294cdc248ce@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <fb9faf97-339c-e235-cb62-d8581adf7b6a@linux.ibm.com>
Date: Mon, 30 Nov 2020 13:38:45 +0100
MIME-Version: 1.0
In-Reply-To: <f1f8ce84-e30a-29c5-8ab6-7294cdc248ce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 11/27/20 5:46 PM, Thomas Huth wrote:
> On 27/11/2020 14.06, Janosch Frank wrote:
>> Not much to test except for the privilege and specification
>> exceptions.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  lib/s390x/sclp.c  |  2 ++
>>  lib/s390x/sclp.h  |  6 +++++-
>>  s390x/intercept.c | 19 +++++++++++++++++++
>>  3 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
>> index 68833b5..3966086 100644
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
>> index e18f7e6..4e564dd 100644
>> --- a/lib/s390x/sclp.h
>> +++ b/lib/s390x/sclp.h
>> @@ -108,7 +108,8 @@ extern struct sclp_facilities sclp_facilities;
>>  
>>  struct sclp_facilities {
>>  	uint64_t has_sief2 : 1;
>> -	uint64_t : 63;
>> +	uint64_t has_diag318 : 1;
>> +	uint64_t : 62;
>>  };
>>  
>>  typedef struct ReadInfo {
>> @@ -133,6 +134,9 @@ typedef struct ReadInfo {
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
>> index 2e38257..615f0a0 100644
>> --- a/s390x/intercept.c
>> +++ b/s390x/intercept.c
>> @@ -10,6 +10,7 @@
>>   * under the terms of the GNU Library General Public License version 2.
>>   */
>>  #include <libcflat.h>
>> +#include <sclp.h>
>>  #include <asm/asm-offsets.h>
>>  #include <asm/interrupt.h>
>>  #include <asm/page.h>
>> @@ -154,6 +155,23 @@ static void test_testblock(void)
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
> 
> Maybe remove the empty line above.

Sure

> 
>> +}
>> +
>>  struct {
>>  	const char *name;
>>  	void (*func)(void);
>> @@ -164,6 +182,7 @@ struct {
>>  	{ "stap", test_stap, false },
>>  	{ "stidp", test_stidp, false },
>>  	{ "testblock", test_testblock, false },
>> +	{ "diag318", test_diag318, false },
>>  	{ NULL, NULL, false }
>>  };
>>  
>>
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks!

> 
