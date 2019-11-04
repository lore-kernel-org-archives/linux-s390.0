Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33256 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728532AbfKDLT7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 06:19:59 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA4BJqxT036806
        for <linux-s390@vger.kernel.org>; Mon, 4 Nov 2019 06:19:58 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w2hubtemd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 04 Nov 2019 06:19:54 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Mon, 4 Nov 2019 11:19:09 -0000
Date: Mon, 4 Nov 2019 12:19:01 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v2 5/5] s390x: SCLP unit test
In-Reply-To: <191dbc7f-74b2-6f78-a721-aaac49895948@linux.ibm.com>
References: <1572023194-14370-1-git-send-email-imbrenda@linux.ibm.com>
        <1572023194-14370-6-git-send-email-imbrenda@linux.ibm.com>
        <191dbc7f-74b2-6f78-a721-aaac49895948@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20191104121901.3b3ab68b@p-imbrenda.boeblingen.de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com

On Mon, 4 Nov 2019 10:45:07 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

[...]

> > +/**
> > + * Enable SCLP interrupt.
> > + */
> > +static void sclp_setup_int_test(void)
> > +{
> > +	uint64_t mask;
> > +
> > +	ctl_set_bit(0, 9);
> > +	mask = extract_psw_mask();
> > +	mask |= PSW_MASK_EXT;
> > +	load_psw_mask(mask);
> > +}  
> 
> Or you could just export the definition in sclp.c...

I could, but is it worth it to export the definition just for this
one use?


[...]

> > +static void test_toolong(void)
> > +{
> > +	uint32_t cmd = SCLP_CMD_WRITE_EVENT_DATA;
> > +	uint16_t res = SCLP_RC_SCCB_BOUNDARY_VIOLATION;  
> 
> Why use variables for constants that are never touched?

readability mostly. the names of the constants are rather long.
the compiler will notice it and do the Right Thing™

> > +	WriteEventData *sccb = (WriteEventData *)sccb_template;
> > +	int cx;
> > +
> > +	memset(sccb_template, 0, sizeof(sccb_template));
> > +	sccb->h.function_code = SCLP_FC_NORMAL_WRITE;
> > +	for (cx = 4097; cx < 8192; cx++) {
> > +		sccb->h.length = cx;
> > +		if (!test_one_sccb(cmd, pagebuf, PAGE_SIZE, 0,
> > res))
> > +			break;
> > +	}
> > +	report("SCCB bigger than 4k", cx == 8192);
> > +}
> > +
> > +/**
> > + * Test privileged operation.
> > + */
> > +static void test_priv(void)
> > +{
> > +	report_prefix_push("Privileged operation");
> > +	pagebuf[0] = 0;
> > +	pagebuf[1] = 8;  
> 
> Id much rather have a proper cast using the header struct.

ok, will fix

> > +	expect_pgm_int();
> > +	enter_pstate();
> > +	servc(valid_code, __pa(pagebuf));
> > +	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
> > +	report_prefix_pop();
> > +}
> > +
> > +/**
> > + * Test addressing exceptions. We need to test SCCB addresses
> > between the
> > + * end of available memory and 2GB, because after 2GB a
> > specification
> > + * exception is also allowed.
> > + * Only applicable if the VM has less than 2GB of memory
> > + */
> > +static void test_addressing(void)
> > +{
> > +	unsigned long cx, maxram = get_ram_size();
> > +
> > +	if (maxram >= 0x80000000) {
> > +		report_skip("Invalid SCCB address");
> > +		return;
> > +	}
> > +	for (cx = maxram; cx < MIN(maxram + 65536, 0x80000000); cx
> > += 8)
> > +		if (!test_one_sccb(valid_code, (void *)cx, 0,
> > PGM_BIT_ADDR, 0))
> > +			goto out;
> > +	for (; cx < MIN((maxram + 0x7fffff) & ~0xfffff,
> > 0x80000000); cx += 4096)
> > +		if (!test_one_sccb(valid_code, (void *)cx, 0,
> > PGM_BIT_ADDR, 0))
> > +			goto out;
> > +	for (; cx < 0x80000000; cx += 1048576)
> > +		if (!test_one_sccb(valid_code, (void *)cx, 0,
> > PGM_BIT_ADDR, 0))
> > +			goto out;
> > +out:
> > +	report("Invalid SCCB address", cx == 0x80000000);
> > +}
> > +
> > +/**
> > + * Test some bits in the instruction format that are specified to
> > be ignored.
> > + */
> > +static void test_instbits(void)
> > +{
> > +	SCCBHeader *h = (SCCBHeader *)pagebuf;
> > +	unsigned long mask;
> > +	int cc;
> > +
> > +	sclp_mark_busy();
> > +	h->length = 8;
> > +
> > +	ctl_set_bit(0, 9);
> > +	mask = extract_psw_mask();
> > +	mask |= PSW_MASK_EXT;
> > +	load_psw_mask(mask);  
> 
> Huh, you already got a function for that at the top.

oops. will fix
 
> > +
> > +	asm volatile(
> > +		"       .insn   rre,0xb2204200,%1,%2\n"  /* servc
> > %1,%2 */
> > +		"       ipm     %0\n"
> > +		"       srl     %0,28"
> > +		: "=&d" (cc) : "d" (valid_code),
> > "a" (__pa(pagebuf))
> > +		: "cc", "memory");
> > +	sclp_wait_busy();
> > +	report("Instruction format ignored bits", cc == 0);
> > +}
> > +
> > +/**
> > + * Find a valid SCLP command code; not all codes are always
> > allowed, and
> > + * probing should be performed in the right order.
> > + */
> > +static void find_valid_sclp_code(void)
> > +{
> > +	unsigned int commands[] = { SCLP_CMDW_READ_SCP_INFO_FORCED,
> > +				    SCLP_CMDW_READ_SCP_INFO };
> > +	SCCBHeader *h = (SCCBHeader *)pagebuf;
> > +	int i, cc;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(commands); i++) {
> > +		sclp_mark_busy();
> > +		memset(h, 0, sizeof(pagebuf));  
> 
> pagebuf is 8k, but you can only use 4k in sclp.
> We don't need to clear 2 pages.

well, technically I don't even need to clear the whole buffer at all.
I should probably simply clear just the header.

> > +		h->length = 4096;
> > +
> > +		valid_code = commands[i];
> > +		cc = sclp_service_call(commands[i], h);
> > +		if (cc)
> > +			break;
> > +		if (h->response_code ==
> > SCLP_RC_NORMAL_READ_COMPLETION)
> > +			return;
> > +		if (h->response_code !=
> > SCLP_RC_INVALID_SCLP_COMMAND)
> > +			break;  
> 
> Depending on line length you could add that to the cc check.
> Maybe you could also group the error conditions before the success
> conditions or the other way around.

yeah it woud fit, but I'm not sure it would be more readable:

if (cc || (h->response_code != SCLP_RC_INVALID_SCLP_COMMAND))
                        break;

I think readability is more important that saving lines of source code,
especially when the compiler will be smart enough to do the Right Thing™

also, that is copy-pasted directly from lib/s390x/sclp.c

> > +	}
> > +	valid_code = 0;
> > +	report_abort("READ_SCP_INFO failed");
> > +}
> > +
> > +int main(void)
> > +{
> > +	report_prefix_push("sclp");
> > +	find_valid_sclp_code();
> > +
> > +	/* Test some basic things */
> > +	test_instbits();
> > +	test_priv();
> > +	test_addressing();
> > +
> > +	/* Test the specification exceptions */
> > +	test_sccb_too_short();
> > +	test_sccb_unaligned();
> > +	test_sccb_prefix();
> > +	test_sccb_high();
> > +
> > +	/* Test the expected response codes */
> > +	test_inval();
> > +	test_short();
> > +	test_boundary();
> > +	test_toolong();
> > +
> > +	return report_summary();
> > +}
> > diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
> > index f1b07cd..75e3d37 100644
> > --- a/s390x/unittests.cfg
> > +++ b/s390x/unittests.cfg
> > @@ -75,3 +75,6 @@ file = stsi.elf
> >  [smp]
> >  file = smp.elf
> >  extra_params =-smp 2
> > +
> > +[sclp]
> > +file = sclp.elf  
> 
> Don't we need a newline here?

no, the file ended already with a newline, the three lines are added
above the final newline, so there is always a newline at the end of the
file.
