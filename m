Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30708 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725908AbfKMMke (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Nov 2019 07:40:34 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xADCXR97153689
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 07:40:33 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w8gk83t6h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 07:40:33 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Wed, 13 Nov 2019 12:40:31 -0000
Date: Wed, 13 Nov 2019 13:40:24 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v3 2/2] s390x: SCLP unit test
In-Reply-To: <fe853e54-ef79-ed94-eaf8-18b2acfd95f5@redhat.com>
References: <1573492826-24589-1-git-send-email-imbrenda@linux.ibm.com>
        <1573492826-24589-3-git-send-email-imbrenda@linux.ibm.com>
        <fe853e54-ef79-ed94-eaf8-18b2acfd95f5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20191113134024.75beb67d@p-imbrenda.boeblingen.de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On Wed, 13 Nov 2019 10:34:02 +0100
Thomas Huth <thuth@redhat.com> wrote:

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
> I don't have a strong opinion here, but I think I'd slightly prefer to
> use the function from lib/s390x/sclp.c instead, too.

fine, I'll export it

> > +/**
> > + * Perform one service call, handling exceptions and interrupts.
> > + */
> > +static int sclp_service_call_test(unsigned int command, void *sccb)
> > +{
> > +	int cc;
> > +
> > +	sclp_mark_busy();
> > +	sclp_setup_int_test();
> > +	cc = servc(command, __pa(sccb));
> > +	if (lc->pgm_int_code) {
> > +		sclp_handle_ext();
> > +		return 0;
> > +	}
> > +	if (!cc)
> > +		sclp_wait_busy();
> > +	return cc;
> > +}
> > +
> > +/**
> > + * Perform one test at the given address, optionally using the
> > SCCB template,  
> 
> I think you should at least mention the meaning of the "len" parameter
> here, otherwise this is rather confusing (see below, my comment to
> sccb_template).

I'll rename it and add comments

> > + * checking for the expected program interrupts and return codes.
> > + * Returns 1 in case of success or 0 in case of failure  
> 
> Could use bool with true + false instead.
> 
> > + */
> > +static int test_one_sccb(uint32_t cmd, uint8_t *addr, uint16_t
> > len, uint64_t exp_pgm, uint16_t exp_rc) +{
> > +	SCCBHeader *h = (SCCBHeader *)addr;
> > +	int res, pgm;
> > +
> > +	/* Copy the template to the test address if needed */
> > +	if (len)
> > +		memcpy(addr, sccb_template, len);  
> 
> Honestly, that sccb_template is rather confusing. Why does the caller
> has to provide both, the data in the sccb_template and the "addr"
> variable for yet another buffer? Wouldn't it be simpler if the caller
> simply sets up everything in a place of choice and then only passes
> the "addr" to the buffer?

because you will test the same buffer at different addresses. this
mechanism abstracts this. instead of having to clear the buffer and set
the values for each address, you can simply set the template once and
then call the same function, changing only the target address.

also, the target address is not always a buffer, in many cases it is in
fact an invalid address, which should generate exceptions. 

> > +	expect_pgm_int();
> > +	res = sclp_service_call_test(cmd, h);
> > +	if (res) {
> > +		report_info("SCLP not ready (command %#x, address
> > %p, cc %d)", cmd, addr, res);
> > +		return 0;
> > +	}
> > +	pgm = clear_pgm_int();
> > +	/* Check if the program exception was one of the expected
> > ones */
> > +	if (!((1ULL << pgm) & exp_pgm)) {
> > +		report_info("First failure at addr %p, size %d,
> > cmd %#x, pgm code %d", addr, len, cmd, pgm);
> > +		return 0;
> > +	}
> > +	/* Check if the response code is the one expected */
> > +	if (exp_rc && (exp_rc != h->response_code)) {  
> 
> You can drop the parentheses around "exp_rc != h->response_code".

fine, although I don't understand you hatred toward parentheses :)

> > +		report_info("First failure at addr %p, size %d,
> > cmd %#x, resp code %#x",
> > +				addr, len, cmd, h->response_code);
> > +		return 0;
> > +	}
> > +	return 1;
> > +}
> > +
> > +/**
> > + * Wrapper for test_one_sccb to set up a simple SCCB template.
> > + * Returns 1 in case of success or 0 in case of failure
> > + */
> > +static int test_one_simple(uint32_t cmd, uint8_t *addr, uint16_t
> > sccb_len,
> > +			uint16_t buf_len, uint64_t exp_pgm,
> > uint16_t exp_rc) +{
> > +	if (buf_len)
> > +		memset(sccb_template, 0, sizeof(sccb_template));
> > +	((SCCBHeader *)sccb_template)->length = sccb_len;
> > +	return test_one_sccb(cmd, addr, buf_len, exp_pgm, exp_rc);
> > +}  
> [...]
> > +/**
> > + * Test SCCBs whose address is in the lowcore or prefix area.
> > + */
> > +static void test_sccb_prefix(void)
> > +{
> > +	uint32_t prefix, new_prefix;
> > +	int offset;
> > +
> > +	/* can't actually trash the lowcore, unsurprisingly things
> > break if we do */
> > +	for (offset = 0; offset < 8192; offset += 8)
> > +		if (!test_one_sccb(valid_code, MKPTR(offset), 0,
> > PGM_BIT_SPEC, 0))
> > +			break;
> > +	report("SCCB low pages", offset == 8192);
> > +
> > +	memcpy(prefix_buf, 0, 8192);
> > +	new_prefix = (uint32_t)(intptr_t)prefix_buf;
> > +	asm volatile("stpx %0" : "=Q" (prefix));
> > +	asm volatile("spx %0" : : "Q" (new_prefix) : "memory");
> > +
> > +	for (offset = 0; offset < 8192; offset += 8)
> > +		if (!test_one_simple(valid_code, MKPTR(new_prefix
> > + offset), 8, 8, PGM_BIT_SPEC, 0))
> > +			break;
> > +	report("SCCB prefix pages", offset == 8192);
> > +
> > +	memcpy(prefix_buf, 0, 8192);  
> 
> What's that memcpy() good for? A comment would be helpful.

we just moved the prefix to a temporary one, and thrashed the old one.
we can't simply set the old prefix and call it a day, things will break.

I added multiple comments to that function for v4 to explain what's
going on

> > +	asm volatile("spx %0" : : "Q" (prefix) : "memory");
> > +}
> > +
> > +/**
> > + * Test SCCBs that are above 2GB. If outside of memory, an
> > addressing
> > + * exception is also allowed.
> > + */
> > +static void test_sccb_high(void)
> > +{
> > +	SCCBHeader *h = (SCCBHeader *)pagebuf;
> > +	uintptr_t a[33 * 4 * 2 + 2];
> > +	uint64_t maxram;
> > +	int i, pgm, len = 0;
> > +
> > +	h->length = 8;
> > +
> > +	for (i = 0; i < 33; i++)
> > +		a[len++] = 1UL << (i + 31);
> > +	for (i = 0; i < 33; i++)
> > +		a[len++] = 3UL << (i + 31);
> > +	for (i = 0; i < 33; i++)
> > +		a[len++] = 0xffffffff80000000UL << i;
> > +	a[len++] = 0x80000000;
> > +	for (i = 1; i < 33; i++, len++)
> > +		a[len] = a[len - 1] | (1UL << (i + 31));
> > +	for (i = 0; i < len; i++)
> > +		a[len + i] = a[i] + (intptr_t)h;
> > +	len += i;
> > +	a[len++] = 0xdeadbeef00000000;
> > +	a[len++] = 0xdeaddeadbeef0000;  
> 
> IMHO a short comment in the code right in front of the above code
> block would be helpful to understand what you're doing here.

v4 will have comments explaining each of the loops

> > +	maxram = get_ram_size();
> > +	for (i = 0; i < len; i++) {
> > +		pgm = PGM_BIT_SPEC | (a[i] >= maxram ?
> > PGM_BIT_ADDR : 0);
> > +		if (!test_one_sccb(valid_code, (void *)a[i], 0,
> > pgm, 0))
> > +			break;
> > +	}
> > +	report("SCCB high addresses", i == len);
> > +}
> > +
> > +/**
> > + * Test invalid commands, both invalid command detail codes and
> > valid
> > + * ones with invalid command class code.
> > + */
> > +static void test_inval(void)
> > +{
> > +	const uint16_t res = SCLP_RC_INVALID_SCLP_COMMAND;
> > +	uint32_t cmd;
> > +	int i;
> > +
> > +	report_prefix_push("Invalid command");
> > +	for (i = 0; i < 65536; i++) {
> > +		cmd = (0xdead0000) | i;  
> 
> Please remove the parentheses around 0xdead0000

ok, these ones were actually superfluous :)
probably a leftover from previous versions
 
> > +		if (!test_one_simple(cmd, pagebuf, PAGE_SIZE,
> > PAGE_SIZE, PGM_NONE, res))
> > +			break;
> > +	}
> > +	report("Command detail code", i == 65536);
> > +
> > +	for (i = 0; i < 256; i++) {
> > +		cmd = (valid_code & ~0xff) | i;
> > +		if (cmd == valid_code)
> > +			continue;
> > +		if (!test_one_simple(cmd, pagebuf, PAGE_SIZE,
> > PAGE_SIZE, PGM_NONE, res))
> > +			break;
> > +	}
> > +	report("Command class code", i == 256);
> > +	report_prefix_pop();
> > +}  
> 
>  Thomas
> 
