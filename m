Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36342 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727107AbfK0SVd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 Nov 2019 13:21:33 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARIDfWC063236
        for <linux-s390@vger.kernel.org>; Wed, 27 Nov 2019 13:21:32 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2whcxrvhpm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 27 Nov 2019 13:21:31 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 27 Nov 2019 18:21:29 -0000
Subject: Re: [kvm-unit-tests PATCH v4 3/3] s390x: SCLP unit test
References: <1574157219-22052-1-git-send-email-imbrenda@linux.ibm.com>
 <1574157219-22052-4-git-send-email-imbrenda@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 27 Nov 2019 19:21:23 +0100
MIME-Version: 1.0
In-Reply-To: <1574157219-22052-4-git-send-email-imbrenda@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="W33hqXazalZhXu1SOjZZcOcpQU5yuXi1H"
Message-Id: <8f7d6b1d-7413-76c9-9382-7c510c45145a@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W33hqXazalZhXu1SOjZZcOcpQU5yuXi1H
Content-Type: multipart/mixed; boundary="4HO612aYUDd5SrAyaBXfP48NJwRWBHGkf"

--4HO612aYUDd5SrAyaBXfP48NJwRWBHGkf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/19/19 10:53 AM, Claudio Imbrenda wrote:
> SCLP unit test. Testing the following:
>=20
> * Correctly ignoring instruction bits that should be ignored
> * Privileged instruction check
> * Check for addressing exceptions
> * Specification exceptions:
>   - SCCB size less than 8
>   - SCCB unaligned
>   - SCCB overlaps prefix or lowcore
>   - SCCB address higher than 2GB
> * Return codes for
>   - Invalid command
>   - SCCB too short (but at least 8)
>   - SCCB page boundary violation
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  s390x/Makefile      |   1 +
>  s390x/sclp.c        | 465 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  s390x/unittests.cfg |   3 +
>  3 files changed, 469 insertions(+)
>  create mode 100644 s390x/sclp.c
>=20
> diff --git a/s390x/Makefile b/s390x/Makefile
> index 3744372..ddb4b48 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -16,6 +16,7 @@ tests +=3D $(TEST_DIR)/diag288.elf
>  tests +=3D $(TEST_DIR)/stsi.elf
>  tests +=3D $(TEST_DIR)/skrf.elf
>  tests +=3D $(TEST_DIR)/smp.elf
> +tests +=3D $(TEST_DIR)/sclp.elf
>  tests_binary =3D $(patsubst %.elf,%.bin,$(tests))
> =20
>  all: directories test_cases test_cases_binary
> diff --git a/s390x/sclp.c b/s390x/sclp.c
> new file mode 100644
> index 0000000..aeb0b04
> --- /dev/null
> +++ b/s390x/sclp.c
> @@ -0,0 +1,465 @@
> +/*
> + * Service Call tests
> + *
> + * Copyright (c) 2019 IBM Corp
> + *
> + * Authors:
> + *  Claudio Imbrenda <imbrenda@linux.ibm.com>
> + *
> + * This code is free software; you can redistribute it and/or modify i=
t
> + * under the terms of the GNU General Public License version 2.
> + */
> +
> +#include <libcflat.h>
> +#include <asm/page.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/interrupt.h>
> +#include <sclp.h>
> +
> +#define PGM_NONE	1
> +#define PGM_BIT_SPEC	(1ULL << PGM_INT_CODE_SPECIFICATION)
> +#define PGM_BIT_ADDR	(1ULL << PGM_INT_CODE_ADDRESSING)
> +#define PGM_BIT_PRIV	(1ULL << PGM_INT_CODE_PRIVILEGED_OPERATION)
> +#define MKPTR(x) ((void *)(uint64_t)(x))
> +
> +/* two pages of scratch memory to be used for some of the tests */
> +static uint8_t pagebuf[PAGE_SIZE * 2] __attribute__((aligned(PAGE_SIZE=
 * 2)));
> +/* used as prefix when testing prefix access, to guarantee that prefix=
 !=3D 0 */
> +static uint8_t prefix_buf[PAGE_SIZE * 2] __attribute__((aligned(PAGE_S=
IZE * 2)));

"to guarantee that prefix !=3D 0" ... also returns in an error when used
as a sccb address?


> +/* SCCB template used to */

Used to what? :-)

> +static uint8_t sccb_template[PAGE_SIZE];

> +/* the valid command code to use for getting SCP information */

/* The sccb command code we'll use for the "read info" command. */

> +static uint32_t valid_code;

That's an unfortunate name for this variable.
How about: read_info_cmd_code?


> +/* points to lowcore (real address 0) */
> +static struct lowcore *lc;

I'd guess that a comment for this variable is a bit pointless.


I find this hard to read with all the comments above.

> +
> +/**
> + * Perform one service call, handling exceptions and interrupts.
> + */
> +static int sclp_service_call_test(unsigned int command, void *sccb)
> +{
> +	int cc;
> +
> +	sclp_mark_busy();
> +	sclp_setup_int();
> +	cc =3D servc(command, __pa(sccb));
> +	if (lc->pgm_int_code) {
> +		sclp_handle_ext();
> +		return 0;
> +	}
> +	if (!cc)
> +		sclp_wait_busy();
> +	return cc;
> +}
> +
> +/**
> + * Perform one test at the given address, optionally using the SCCB te=
mplate,
> + * checking for the expected program interrupts and return codes.
> + *
> + * The parameter buf_len indicates the number of bytes of the template=
 that
> + * should be copied to the test address, and should be 0 when the test=

> + * address is invalid, in which case nothing is copied.
> + *
> + * The template is used to simplify tests where the same buffer conten=
t is
> + * used many times in a row, at different addresses.
> + *
> + * Returns true in case of success or false in case of failure
> + */
> +static bool test_one_sccb(uint32_t cmd, uint8_t *addr, uint16_t buf_le=
n, uint64_t exp_pgm, uint16_t exp_rc)
> +{
> +	SCCBHeader *h =3D (SCCBHeader *)addr;
> +	int res, pgm;
> +
> +	/* Copy the template to the test address if needed */
> +	if (buf_len)
> +		memcpy(addr, sccb_template, buf_len);
> +	expect_pgm_int();
> +	/* perform the actuall call */

s/actuall/actual/

> +	res =3D sclp_service_call_test(cmd, h);
> +	if (res) {
> +		report_info("SCLP not ready (command %#x, address %p, cc %d)", cmd, =
addr, res);
> +		return false;
> +	}
> +	pgm =3D clear_pgm_int();
> +	/* Check if the program exception was one of the expected ones */
> +	if (!((1ULL << pgm) & exp_pgm)) {
> +		report_info("First failure at addr %p, buf_len %d, cmd %#x, pgm code=
 %d",
> +				addr, buf_len, cmd, pgm);
> +		return false;
> +	}
> +	/* Check if the response code is the one expected */
> +	if (exp_rc && exp_rc !=3D h->response_code) {
> +		report_info("First failure at addr %p, buf_len %d, cmd %#x, resp cod=
e %#x",
> +				addr, buf_len, cmd, h->response_code);
> +		return false;
> +	}
> +	return true;
> +}
> +
> +/**
> + * Wrapper for test_one_sccb to set up a simple SCCB template.
> + *
> + * The parameter sccb_len indicates the value that will be saved in th=
e SCCB
> + * length field of the SCCB, buf_len indicates the number of bytes of
> + * template that need to be copied to the actual test address. In many=
 cases
> + * it's enough to clear/copy the first 8 bytes of the buffer, while th=
e SCCB
> + * itself can be larger.
> + *
> + * Returns true in case of success or false in case of failure
> + */
> +static bool test_one_simple(uint32_t cmd, uint8_t *addr, uint16_t sccb=
_len,
> +			uint16_t buf_len, uint64_t exp_pgm, uint16_t exp_rc)
> +{
> +	memset(sccb_template, 0, sizeof(sccb_template));
> +	((SCCBHeader *)sccb_template)->length =3D sccb_len;
> +	return test_one_sccb(cmd, addr, buf_len, exp_pgm, exp_rc);
> +}
> +
> +/**
> + * Test SCCB lengths < 8.
> + */
> +static void test_sccb_too_short(void)
> +{
> +	int len;
> +
> +	for (len =3D 0; len < 8; len++)
> +		if (!test_one_simple(valid_code, pagebuf, len, 8, PGM_BIT_SPEC, 0))
> +			break;
> +
> +	report("SCCB too short", len =3D=3D 8);
> +}
> +
> +/**
> + * Test SCCBs that are not 64-bit aligned.
> + */
> +static void test_sccb_unaligned(void)
> +{
> +	int offset;
> +
> +	for (offset =3D 1; offset < 8; offset++)
> +		if (!test_one_simple(valid_code, offset + pagebuf, 8, 8, PGM_BIT_SPE=
C, 0))
> +			break;
> +	report("SCCB unaligned", offset =3D=3D 8);
> +}
> +
> +/**
> + * Test SCCBs whose address is in the lowcore or prefix area.
> + */
> +static void test_sccb_prefix(void)
> +{
> +	uint8_t scratch[2 * PAGE_SIZE];
> +	uint32_t prefix, new_prefix;
> +	int offset;
> +
> +	/*
> +	 * copy the current lowcore to the future new location, otherwise we
> +	 * will not have a valid lowcore after setting the new prefix.
> +	 */
> +	memcpy(prefix_buf, 0, 2 * PAGE_SIZE);
> +	/* save the current prefix (it's probably going to be 0) */
> +	asm volatile("stpx %0" : "=3DQ" (prefix));

s390x/intercept.c already uses it, maybe we can move it to the library
along with spx?

> +	/*
> +	 * save the current content of absolute pages 0 and 1, so we can
> +	 * restore them after we trash them later on
> +	 */
> +	memcpy(scratch, (void *)(intptr_t)prefix, 2 * PAGE_SIZE);
> +	/* set the new prefix to prefix_buf */
> +	new_prefix =3D (uint32_t)(intptr_t)prefix_buf;
> +	asm volatile("spx %0" : : "Q" (new_prefix) : "memory");
> +
> +	/*
> +	 * testing with SCCB addresses in the lowcore; since we can't
> +	 * actually trash the lowcore (unsurprisingly, things break if we
> +	 * do), this will be a read-only test.
> +	 */
> +	for (offset =3D 0; offset < 2 * PAGE_SIZE; offset +=3D 8)
> +		if (!test_one_sccb(valid_code, MKPTR(offset), 0, PGM_BIT_SPEC, 0))
> +			break;
> +	report("SCCB low pages", offset =3D=3D 2 * PAGE_SIZE);
> +
> +	/*
> +	 * this will trash the contents of the two pages at absolute
> +	 * address 0; we will need to restore them later.
> +	 */
> +	for (offset =3D 0; offset < 2 * PAGE_SIZE; offset +=3D 8)
> +		if (!test_one_simple(valid_code, MKPTR(new_prefix + offset), 8, 8, P=
GM_BIT_SPEC, 0))
> +			break;
> +	report("SCCB prefix pages", offset =3D=3D 2 * PAGE_SIZE);
> +
> +	/* restore the previous contents of absolute pages 0 and 1 */
> +	memcpy(prefix_buf, 0, 2 * PAGE_SIZE);
> +	/* restore the prefix to the original value */
> +	asm volatile("spx %0" : : "Q" (prefix) : "memory");
> +}
> +
> +/**
> + * Test SCCBs that are above 2GB. If outside of memory, an addressing
> + * exception is also allowed.
> + */
> +static void test_sccb_high(void)
> +{
> +	SCCBHeader *h =3D (SCCBHeader *)pagebuf;
> +	uintptr_t a[33 * 4 * 2 + 2];	/* for the list of addresses to test */
> +
> +	uint64_t maxram;
> +	int i, pgm, len =3D 0;
> +
> +	h->length =3D 8;
> +	/* addresses with 1 bit set in the first 33 bits */
> +	for (i =3D 0; i < 33; i++)
> +		a[len++] =3D 1UL << (i + 31);
> +	/* addresses with 2 consecutive bits set in the first 33 bits */
> +	for (i =3D 0; i < 33; i++)
> +		a[len++] =3D 3UL << (i + 31);
> +	/* addresses with all bits set in bits 0..N */
> +	for (i =3D 0; i < 33; i++)
> +		a[len++] =3D 0xffffffff80000000UL << i;
> +	/* addresses with all bits set in bits N..33 */
> +	a[len++] =3D 0x80000000;
> +	for (i =3D 1; i < 33; i++, len++)
> +		a[len] =3D a[len - 1] | (1UL << (i + 31));
> +	/* all the addresses above, but adding the offset of a valid buffer *=
/
> +	for (i =3D 0; i < len; i++)
> +		a[len + i] =3D a[i] + (intptr_t)h;
> +	len +=3D i;
> +	/* two more hand-crafted addresses */
> +	a[len++] =3D 0xdeadbeef00000000;
> +	a[len++] =3D 0xdeaddeadbeef0000;
> +
> +	maxram =3D get_ram_size();
> +	for (i =3D 0; i < len; i++) {
> +		pgm =3D PGM_BIT_SPEC | (a[i] >=3D maxram ? PGM_BIT_ADDR : 0);
> +		if (!test_one_sccb(valid_code, (void *)a[i], 0, pgm, 0))
> +			break;
> +	}
> +	report("SCCB high addresses", i =3D=3D len);
> +}
> +
> +/**
> + * Test invalid commands, both invalid command detail codes and valid
> + * ones with invalid command class code.
> + */
> +static void test_inval(void)
> +{
> +	const uint16_t res =3D SCLP_RC_INVALID_SCLP_COMMAND;
> +	uint32_t cmd;
> +	int i;
> +
> +	report_prefix_push("Invalid command");
> +	for (i =3D 0; i < 65536; i++) {
> +		cmd =3D 0xdead0000 | i;
> +		if (!test_one_simple(cmd, pagebuf, PAGE_SIZE, PAGE_SIZE, PGM_NONE, r=
es))
> +			break;
> +	}
> +	report("Command detail code", i =3D=3D 65536);
> +
> +	for (i =3D 0; i < 256; i++) {
> +		cmd =3D (valid_code & ~0xff) | i;
> +		if (cmd =3D=3D valid_code)
> +			continue;
> +		if (!test_one_simple(cmd, pagebuf, PAGE_SIZE, PAGE_SIZE, PGM_NONE, r=
es))
> +			break;
> +	}
> +	report("Command class code", i =3D=3D 256);
> +	report_prefix_pop();
> +}
> +
> +
> +/**
> + * Test short SCCBs (but larger than 8).
> + */
> +static void test_short(void)
> +{
> +	const uint16_t res =3D SCLP_RC_INSUFFICIENT_SCCB_LENGTH;
> +	int len;
> +
> +	for (len =3D 8; len < 144; len++)
> +		if (!test_one_simple(valid_code, pagebuf, len, len, PGM_NONE, res))
> +			break;
> +	report("Insufficient SCCB length (Read SCP info)", len =3D=3D 144);
> +
> +	for (len =3D 8; len < 40; len++)
> +		if (!test_one_simple(SCLP_READ_CPU_INFO, pagebuf, len, len, PGM_NONE=
, res))
> +			break;
> +	report("Insufficient SCCB length (Read CPU info)", len =3D=3D 40);
> +}
> +
> +/**
> + * Test SCCB page boundary violations.
> + */
> +static void test_boundary(void)
> +{
> +	const uint32_t cmd =3D SCLP_CMD_WRITE_EVENT_DATA;
> +	const uint16_t res =3D SCLP_RC_SCCB_BOUNDARY_VIOLATION;
> +	WriteEventData *sccb =3D (WriteEventData *)sccb_template;
> +	int len, offset;
> +
> +	memset(sccb_template, 0, sizeof(sccb_template));
> +	sccb->h.function_code =3D SCLP_FC_NORMAL_WRITE;
> +	for (len =3D 32; len <=3D 4096; len++) {
> +		offset =3D len & 7 ? len & ~7 : len - 8;
> +		for (offset =3D 4096 - offset; offset < 4096; offset +=3D 8) {
> +			sccb->h.length =3D len;
> +			if (!test_one_sccb(cmd, offset + pagebuf, len, PGM_NONE, res))
> +				goto out;
> +		}
> +	}
> +out:
> +	report("SCCB page boundary violation", len > 4096 && offset =3D=3D 40=
96);
> +}
> +
> +/**
> + * Test excessively long SCCBs.
> + */
> +static void test_toolong(void)
> +{
> +	const uint32_t cmd =3D SCLP_CMD_WRITE_EVENT_DATA;
> +	const uint16_t res =3D SCLP_RC_SCCB_BOUNDARY_VIOLATION;
> +	WriteEventData *sccb =3D (WriteEventData *)sccb_template;
> +	int len;
> +
> +	memset(sccb_template, 0, sizeof(sccb_template));
> +	sccb->h.function_code =3D SCLP_FC_NORMAL_WRITE;
> +	for (len =3D 4097; len < 8192; len++) {
> +		sccb->h.length =3D len;
> +		if (!test_one_sccb(cmd, pagebuf, PAGE_SIZE, PGM_NONE, res))
> +			break;
> +	}
> +	report("SCCB bigger than 4k", len =3D=3D 8192);
> +}
> +
> +/**
> + * Test privileged operation.
> + */
> +static void test_priv(void)
> +{
> +	SCCBHeader *h =3D (SCCBHeader *)pagebuf;
> +
> +	report_prefix_push("Privileged operation");
> +	h->length =3D 8;
> +	expect_pgm_int();
> +	enter_pstate();
> +	servc(valid_code, __pa(h));
> +	check_pgm_int_code(PGM_INT_CODE_PRIVILEGED_OPERATION);
> +	report_prefix_pop();
> +}
> +
> +/**
> + * Test addressing exceptions. We need to test SCCB addresses between =
the
> + * end of available memory and 2GB, because after 2GB a specification
> + * exception is also allowed.
> + * Only applicable if the VM has less than 2GB of memory
> + */
> +static void test_addressing(void)
> +{
> +	unsigned long i, maxram =3D get_ram_size();
> +
> +	/* the VM has more than 2GB of memory */
> +	if (maxram >=3D 0x80000000) {
> +		report_skip("Invalid SCCB address");
> +		return;
> +	}
> +	/* test all possible valid addresses immediately after the end of mem=
ory
> +	 * up to 64KB after the end of memory
> +	 */
> +	for (i =3D 0; i < 0x10000 && i + maxram < 0x80000000; i +=3D 8)
> +		if (!test_one_sccb(valid_code, MKPTR(i + maxram), 0, PGM_BIT_ADDR, 0=
))
> +			goto out;
> +	/* test more addresses until we reach 1MB after end of memory;
> +	 * increment by a prime number (times 8) in order to test all
> +	 * possible valid offsets inside pages
> +	 */
> +	for (; i < 0x100000 && i + maxram < 0x80000000 ; i +=3D 808)
> +		if (!test_one_sccb(valid_code, MKPTR(i + maxram), 0, PGM_BIT_ADDR, 0=
))
> +			goto out;
> +	/* test the remaining addresses until we reach address 2GB;
> +	 * increment by a prime number (times 8) in order to test all
> +	 * possible valid offsets inside pages
> +	 */
> +	for (; i < 0x80000000; i +=3D 800024)
> +		if (!test_one_sccb(valid_code, MKPTR(i + maxram), 0, PGM_BIT_ADDR, 0=
))
> +			goto out;
> +out:
> +	report("Invalid SCCB address", i >=3D 0x80000000);
> +}
> +
> +/**
> + * Test some bits in the instruction format that are specified to be i=
gnored.
> + */
> +static void test_instbits(void)
> +{
> +	SCCBHeader *h =3D (SCCBHeader *)pagebuf;
> +	int cc;
> +
> +	expect_pgm_int();
> +	sclp_mark_busy();
> +	h->length =3D 8;
> +	sclp_setup_int();
> +
> +	asm volatile(
> +		"       .insn   rre,0xb2204200,%1,%2\n"  /* servc %1,%2 */
> +		"       ipm     %0\n"
> +		"       srl     %0,28"
> +		: "=3D&d" (cc) : "d" (valid_code), "a" (__pa(pagebuf))
> +		: "cc", "memory");
> +	if (lc->pgm_int_code) {
> +		sclp_handle_ext();
> +		cc =3D 1;
> +	} else if (!cc)
> +		sclp_wait_busy();
> +	report("Instruction format ignored bits", cc =3D=3D 0);
> +}
> +
> +/**
> + * Find a valid SCLP command code; not all codes are always allowed, a=
nd
> + * probing should be performed in the right order.

Find valid READ INFO command code

> + */
> +static void find_valid_sclp_code(void)
> +{
> +	const unsigned int commands[] =3D { SCLP_CMDW_READ_SCP_INFO_FORCED,
> +					  SCLP_CMDW_READ_SCP_INFO };
> +	SCCBHeader *h =3D (SCCBHeader *)pagebuf;
> +	int i, cc;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(commands); i++) {
> +		sclp_mark_busy();
> +		memset(h, 0, sizeof(*h));
> +		h->length =3D 4096;
> +
> +		valid_code =3D commands[i];
> +		cc =3D sclp_service_call(commands[i], h);
> +		if (cc)
> +			break;
> +		if (h->response_code =3D=3D SCLP_RC_NORMAL_READ_COMPLETION)
> +			return;
> +		if (h->response_code !=3D SCLP_RC_INVALID_SCLP_COMMAND)
> +			break;
> +	}
> +	valid_code =3D 0;
> +	report_abort("READ_SCP_INFO failed");
> +}
> +
> +int main(void)
> +{
> +	report_prefix_push("sclp");
> +	find_valid_sclp_code();
> +
> +	/* Test some basic things */
> +	test_instbits();
> +	test_priv();
> +	test_addressing();
> +
> +	/* Test the specification exceptions */
> +	test_sccb_too_short();
> +	test_sccb_unaligned();
> +	test_sccb_prefix();
> +	test_sccb_high();
> +
> +	/* Test the expected response codes */
> +	test_inval();
> +	test_short();
> +	test_boundary();
> +	test_toolong();
> +
> +	return report_summary();
> +}
> diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
> index f1b07cd..75e3d37 100644
> --- a/s390x/unittests.cfg
> +++ b/s390x/unittests.cfg
> @@ -75,3 +75,6 @@ file =3D stsi.elf
>  [smp]
>  file =3D smp.elf
>  extra_params =3D-smp 2
> +
> +[sclp]
> +file =3D sclp.elf

I like Tomas' idea about the two tests.



--4HO612aYUDd5SrAyaBXfP48NJwRWBHGkf--

--W33hqXazalZhXu1SOjZZcOcpQU5yuXi1H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3evqMACgkQ41TmuOI4
ufiifw/9F6wWv8IM6fjq3bbd6HQvcEHgs+Lxh88DCQwOF6gLkGeQsvkfBdtldqbl
eaItLPhjjMXXNwTsj1I74t5RvvdHfexWwg+OVf3XV85CpgOmW6aFCpOEug9OJOEA
jE8y6+I3Gnu+/zypZSMbWbYxMhnqGkC+3nz7hMyW9nV1idSffda9Hz+90sH5KJBl
Wn4LUCnPE758sRPwP5BwPwuxQZM1Axgu6anX4OkyMh/Q2Ssa5PTSWHUPLcEjVS57
pa1KhkWQgjk75sDWdJ23Zi2FpYpCBq7jYgAmbefAJg3QQJT1OKFX50kWVtCp8Q0/
6GvbYA7z+nKKB6Nw7UOa39G/vffmZYsJjsRNZsG/qOgm6fvgAUFl2rtQ9bQp9bmQ
Lhup7Jb7h4IlSqvvMLtMc/EQVP61F9zAjb4+NoejD/euTUs2wLhoLmyHaN2tKhLL
vfq9NSF2pgeHOs+NF/Kb4y/ty0Psf50q+TJl2BSxOeVvFsAE8I1PmgtZyL6tcL/b
qr6X6943lEdwdwfIh42OekX47kGeZtX42d4GvGbaLX48JKH5DqfUylGPQ7ZPdMH2
cjlIkIW4ogVGRhP4TcERo1MoPUMJ9W5pJCNVtpQgzU1O+ApNkswNAZG5ZuQYpKlD
gWyPHMt+ZKVKBluCOHBh+/gCKOOzwKn/JizxgP484OLaNscjzD8=
=i5Lb
-----END PGP SIGNATURE-----

--W33hqXazalZhXu1SOjZZcOcpQU5yuXi1H--
