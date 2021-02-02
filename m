Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10698 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234310AbhBBOUV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Feb 2021 09:20:21 -0500
Subject: Re: [kvm-unit-tests PATCH v1 1/5] s390x: css: Store CSS
 Characteristics
References: <1611930869-25745-1-git-send-email-pmorel@linux.ibm.com>
 <1611930869-25745-2-git-send-email-pmorel@linux.ibm.com>
 <20210202121123.2397d844.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <e19e0d76-2909-ea01-45fc-6e1127fabcb2@linux.ibm.com>
Date: Tue, 2 Feb 2021 15:19:30 +0100
MIME-Version: 1.0
In-Reply-To: <20210202121123.2397d844.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com, imbrenda@linux.ibm.com



On 2/2/21 12:11 PM, Cornelia Huck wrote:
> On Fri, 29 Jan 2021 15:34:25 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> CSS characteristics exposes the features of the Channel SubSystem.
>> Let's use Store Channel Subsystem Characteristics to retrieve
>> the features of the CSS.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   lib/s390x/css.h     | 57 +++++++++++++++++++++++++++++++++++++++++++++
>>   lib/s390x/css_lib.c | 50 ++++++++++++++++++++++++++++++++++++++-
>>   s390x/css.c         | 12 ++++++++++
>>   3 files changed, 118 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/s390x/css.h b/lib/s390x/css.h
>> index 3e57445..bc0530d 100644
>> --- a/lib/s390x/css.h
>> +++ b/lib/s390x/css.h
>> @@ -288,4 +288,61 @@ int css_residual_count(unsigned int schid);
>>   void enable_io_isc(uint8_t isc);
>>   int wait_and_check_io_completion(int schid);
>>   
>> +/*
>> + * CHSC definitions
>> + */
>> +struct chsc_header {
>> +	u16 len;
>> +	u16 code;
>> +};
>> +
>> +/* Store Channel Subsystem Characteristics */
>> +struct chsc_scsc {
>> +	struct chsc_header req;
>> +	u32 reserved1;
>> +	u32 reserved2;
>> +	u32 reserved3;
>> +	struct chsc_header res;
>> +	u32 format;
>> +	u64 general_char[255];
>> +	u64 chsc_char[254];
> 
> Both the kernel and QEMU use arrays of 32 bit values to model that. Not
> a problem, just a stumbling block when comparing code :)

This spares a devilish cast when using test_bit_inv, so I prefer to keep 
it like this since you seem OK with it.

> 
>> +};
>> +extern struct chsc_scsc *chsc_scsc;
>> +
>> +#define CSS_GENERAL_FEAT_BITLEN	(255 * 64)
>> +#define CSS_CHSC_FEAT_BITLEN	(254 * 64)
>> +
>> +int get_chsc_scsc(void);
>> +
>> +static inline int _chsc(void *p)
>> +{
>> +	int cc;
>> +
>> +	asm volatile(
>> +		"	.insn   rre,0xb25f0000,%2,0\n"
>> +		"	ipm     %0\n"
>> +		"	srl     %0,28\n"
>> +		: "=d" (cc), "=m" (p)
>> +		: "d" (p), "m" (p)
>> +		: "cc");
>> +
>> +	return cc;
>> +}
>> +
>> +#define CHSC_SCSC	0x0010
>> +#define CHSC_SCSC_LEN	0x0010
>> +
>> +static inline int chsc(void *p, uint16_t code, uint16_t len)
>> +{
>> +	struct chsc_header *h = p;
>> +
>> +	h->code = code;
>> +	h->len = len;
>> +	return _chsc(p);
>> +}
> 
> I'm wondering how useful this function is. For store channel subsystem
> characteristics, you indeed only need to fill in code and len, but
> other commands may need more fields filled out in the header, and
> filling in code and len is not really extra work. I guess it depends
> whether you plan to add more commands in the future.

It is different levels, CHSC instruction is the support for the 
different commands.
That is why I prefer to separate CHSC from the command's handling.

After your comment on the check of the response code, I will expand this 
function with response code check and report.


> 
> Also maybe move the definitions to the actual invocation of scsc?

Yes.

> 
>> +
>> +#include <bitops.h>
>> +#define css_general_feature(bit) test_bit_inv(bit, chsc_scsc->general_char)
>> +#define css_chsc_feature(bit) test_bit_inv(bit, chsc_scsc->chsc_char)
>> +
>>   #endif
>> diff --git a/lib/s390x/css_lib.c b/lib/s390x/css_lib.c
>> index 3c24480..fe05021 100644
>> --- a/lib/s390x/css_lib.c
>> +++ b/lib/s390x/css_lib.c
>> @@ -15,11 +15,59 @@
>>   #include <asm/arch_def.h>
>>   #include <asm/time.h>
>>   #include <asm/arch_def.h>
>> -
>> +#include <alloc_page.h>
>>   #include <malloc_io.h>
>>   #include <css.h>
>>   
>>   static struct schib schib;
>> +struct chsc_scsc *chsc_scsc;
>> +
>> +int get_chsc_scsc(void)
>> +{
>> +	int i, n;
>> +	int ret = 0;
>> +	char buffer[510];
>> +	char *p;
>> +
>> +	report_prefix_push("Channel Subsystem Call");
>> +
>> +	if (chsc_scsc) {
>> +		report_info("chsc_scsc already initialized");
>> +		goto end;
>> +	}
>> +
>> +	chsc_scsc = alloc_pages(0);
>> +	report_info("scsc_scsc at: %016lx", (u64)chsc_scsc);
>> +	if (!chsc_scsc) {
>> +		ret = -1;
>> +		report(0, "could not allocate chsc_scsc page!");
>> +		goto end;
>> +	}
>> +
>> +	ret = chsc(chsc_scsc, CHSC_SCSC, CHSC_SCSC_LEN);
>> +	if (ret) {
>> +		report(0, "chsc: CC %d", ret);
>> +		goto end;
>> +	}
> 
> Shouldn't you check the response code in the chsc area as well?

yes, I should... I will.

I will rework the chsc() function to add the response code check.

-- 
Pierre Morel
IBM Lab Boeblingen
