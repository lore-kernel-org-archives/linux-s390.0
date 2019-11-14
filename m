Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726410AbfKNQjF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 Nov 2019 11:39:05 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEGVGif096712
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 11:39:05 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w99dbkjq8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 11:39:04 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 14 Nov 2019 16:39:02 -0000
Subject: Re: [PATCH v1 4/4] s390x: Testing the Subchannel I/O read
References: <1573647799-30584-1-git-send-email-pmorel@linux.ibm.com>
 <1573647799-30584-5-git-send-email-pmorel@linux.ibm.com>
 <db451544-fcb1-9d81-7042-ef91c8324204@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 14 Nov 2019 17:38:58 +0100
MIME-Version: 1.0
In-Reply-To: <db451544-fcb1-9d81-7042-ef91c8324204@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Message-Id: <81ef68d4-5ec5-b14e-6c3d-6935e9a6a1c1@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com


On 2019-11-14 10:15, Janosch Frank wrote:
> On 11/13/19 1:23 PM, Pierre Morel wrote:
>> This simple test test the I/O reading by the SUB Channel by:
>> - initializing the Channel SubSystem with predefined CSSID:
>>    0xfe000000 CSSID for a Virtual CCW
>>    0x00090000 SSID for CCW-PONG
>> - initializing the ORB pointing to a single READ CCW
>> - starts the STSH command with the ORB
>> - Expect an interrupt
>> - writes the read data to output
>>
>> The test implements lots of traces when DEBUG is on and
>> tests if memory above the stack is corrupted.
> What happens if we do not habe the pong device?

CC error on stsch() which is currently not cached (but will in the next 
version)

CC error on msch() and on ssch() which is cached and makes the test to fail.


>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   lib/s390x/css.h      | 244 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   lib/s390x/css_dump.c | 141 +++++++++++++++++++++++++++++
> Hmm, what about splitting the patch into css.h/css_dump.c and the actual
> test in s390x/css.c?

OK


>
>>   s390x/Makefile       |   2 +
>>   s390x/css.c          | 222 ++++++++++++++++++++++++++++++++++++++++++++++
>>   s390x/unittests.cfg  |   4 +
>>   5 files changed, 613 insertions(+)
>>   create mode 100644 lib/s390x/css.h
>>   create mode 100644 lib/s390x/css_dump.c
>>   create mode 100644 s390x/css.c
>>
>> diff --git a/lib/s390x/css.h b/lib/s390x/css.h
>> new file mode 100644

OK to all comments...  (I sniped out for clarity)

...snip...


>> +static char buffer[4096];
>> +
>> +static void delay(int d)
>> +{
>> +	int i, j;
>> +
>> +	while (d--)
>> +		for (i = 1000000; i; i--)
>> +			for (j = 1000000; j; j--)
>> +				;
>> +}
> You could set a timer.


Hum, do we really want to do this?


>
>> +
>> +static void set_io_irq_subclass_mask(uint64_t const new_mask)
>> +{
>> +	asm volatile (
>> +		"lctlg %%c6, %%c6, %[source]\n"
>> +		: /* No outputs */
>> +		: [source] "R" (new_mask));
> arch_def.h has lctlg() and ctl_set/clear_bit


OK, thanks


>
>> +}
>> +
>> +static void set_system_mask(uint8_t new_mask)
>> +{
>> +	asm volatile (
>> +		"ssm %[source]\n"
>> +		: /* No outputs */
>> +		: [source] "R" (new_mask));
>> +}
>> +
>> +static void enable_io_irq(void)
>> +{
>> +	set_io_irq_subclass_mask(0x00000000ff000000);
>> +	set_system_mask(PSW_PRG_MASK >> 56);
> load_psw_mask(extract_psw_mask() | PSW_PRG_MASK); no need for another
> inline asm function :)
>
> Or add a psw_set/clear_bit function and fixup enter_pstate()

I look at this.


>
>> +}
>> +
>> +void handle_io_int(sregs_t *regs)
>> +{
,,,snip...
>> +
>> +	delay(1);
>> +
>> +	stsch(CSSID_PONG, &schib);
>> +	dump_schib(&schib);
> Is all that dumping necessary or just a dev remainder?


it goes in the logs, so I thought it could be interresting to keep it.


>
>> +	DBG("got: %s\n", buffer);
>> +
>> +	return 0;
>> +}
>> +
>> +#define MAX_ERRORS 10
>> +static int checkmem(phys_addr_t start, phys_addr_t end)
>> +{
>> +	phys_addr_t curr;
>> +	int err = 0;
>> +
>> +	for (curr = start; curr != end; curr += PAGE_SIZE)
>> +		if (memcmp((void *)start, (void *)curr, PAGE_SIZE)) {
>> +			report("memcmp failed %lx", true, curr);
> How many errors do you normally run into (hopefully 0)?


hopefully.

However I thought it could be interesting to know how many pages have 
been dirtied.


>
>> +			if (err++ > MAX_ERRORS)
>> +				break;
>> +		}
>> +	return err;
>> +}
>> +
>> +extern unsigned long bss_end;
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	phys_addr_t base, top;
>> +	int check_mem = 0;
>> +	int err = 0;
>> +
>> +	if (argc == 2 && !strcmp(argv[1], "-i"))
>> +		check_mem = 1;
>> +
>> +	report_prefix_push("css");
>> +	phys_alloc_get_unused(&base, &top);
>> +
>> +	top = 0x08000000; /* 128MB Need to be updated */
>> +	base = (phys_addr_t)&stacktop;
>> +
>> +	if (check_mem)
>> +		memset((void *)base, 0x00, top - base);
>> +
>> +	if (check_mem)
>> +		err = checkmem(base, top);
>> +	if (err)
>> +		goto out;
>> +
>> +	err = css_run(0);
>> +	if (err)
>> +		goto out;
>> +
>> +	if (check_mem)
>> +		err = checkmem(base, top);
>> +
>> +out:
>> +	if (err)
>> +		report("Tested", 0);
>> +	else
>> +		report("Tested", 1);
> Normally we report the sucsess or failure of single actions and a
> summary will tell us if the whole test ran into errors.

Right, will be enhanced.

Thanks for the comments.

Regards,

Pierre


-- 
Pierre Morel
IBM Lab Boeblingen
