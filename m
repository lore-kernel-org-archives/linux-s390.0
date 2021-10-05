Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECD7C433F5
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 14:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1D696128A
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 14:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbhJEOw7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Oct 2021 10:52:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48850 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235042AbhJEOw6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Oct 2021 10:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633445467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LeZOuNsJ3uAWKW2DCApxQKRjJkRW8EI0ErFrrAz4siU=;
        b=V9LhmKf+KD0O0qN4ZWaoYmKZhfLPhgrGKNyLBXg5HIoE7puRScL2dG9qQXUnsBdpY1GcQS
        hssovL3QtzIvZrh7M33p6EtnW0z8M1Ian6NgAm573t4b3MgQAle1AswHlFrQHDjr6aYh9L
        FDLzaTfsWX6uWikRMAtsdqTtwMXnMS0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-bYHkDj52ONmNfTgilAbvPA-1; Tue, 05 Oct 2021 10:51:06 -0400
X-MC-Unique: bYHkDj52ONmNfTgilAbvPA-1
Received: by mail-wm1-f69.google.com with SMTP id u14-20020a7bcb0e0000b0290248831d46e4so1146217wmj.6
        for <linux-s390@vger.kernel.org>; Tue, 05 Oct 2021 07:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LeZOuNsJ3uAWKW2DCApxQKRjJkRW8EI0ErFrrAz4siU=;
        b=j01oGCvTaC0ZVPWVWsYXe+pSMSQpeoT89korRItztGEgBim0auegyPgOx/GV04/b1U
         8OGGOZvca+IPiDwHTAn5srgYwLr/zkhOBSJrY6jGuAhdNFxIMUaCAJbkZoCmWusueqIQ
         pR4JFp17d6/kmupkkU2iuqcyqsK0IQw0IDZCPeirulO38mU0OZ2S0OmDY2agzwYn77Wc
         MxyzFE8EF2hgFxF2VwokLpBuDuuSm2zYiUTt2bydmxn4V2X9ufuIlmlfOBFZniMiI6p+
         6JzaIFbusV271b2oHFe/LTKie10LW0yG9L8dU4i5lfy3DUX3BcfakmYxFnQ9Wv07EsTk
         Z4yg==
X-Gm-Message-State: AOAM531tIbqcT5qG4DI8eAFD+cuCxTqiQYyy7Z+Q0blrA5Pu9zYSrQq8
        /lVeQ0//QKuf9SW2HlWBAJiMG3tWp09KsLoE8E9nocIJ8awdnYN8dlqbfMEDWGy2sB5xHvKl++n
        Xubho3o0plObkXPvyMJv5lUzvJU6tYDly12r7OfhDabFoDCwgbU+vLv6yUTnkp9UZ8rQwTw==
X-Received: by 2002:adf:c992:: with SMTP id f18mr694337wrh.138.1633445465355;
        Tue, 05 Oct 2021 07:51:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcZ/iAQRs08uIODgdMGgm4VcTrOEqpbIC7mrsVnM3/t3b4y3eBNB69rtsbR6diKodOC/MJtQ==
X-Received: by 2002:adf:c992:: with SMTP id f18mr694290wrh.138.1633445465023;
        Tue, 05 Oct 2021 07:51:05 -0700 (PDT)
Received: from thuth.remote.csb (p549bb2bd.dip0.t-ipconnect.de. [84.155.178.189])
        by smtp.gmail.com with ESMTPSA id z1sm14138897wrt.41.2021.10.05.07.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 07:51:04 -0700 (PDT)
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20211005090921.1816373-1-scgl@linux.ibm.com>
 <20211005090921.1816373-2-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v2 1/5] s390x: Add specification exception
 test
Message-ID: <f21d1d6e-41bd-cab2-d427-f79b734c433c@redhat.com>
Date:   Tue, 5 Oct 2021 16:51:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005090921.1816373-2-scgl@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 05/10/2021 11.09, Janis Schoetterl-Glausch wrote:
> Generate specification exceptions and check that they occur.
> With the iterations argument one can check if specification
> exception interpretation occurs, e.g. by using a high value and
> checking that the debugfs counters are substantially lower.
> The argument is also useful for estimating the performance benefit
> of interpretation.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>   s390x/Makefile      |   1 +
>   s390x/spec_ex.c     | 182 ++++++++++++++++++++++++++++++++++++++++++++
>   s390x/unittests.cfg |   3 +
>   3 files changed, 186 insertions(+)
>   create mode 100644 s390x/spec_ex.c
> 
> diff --git a/s390x/Makefile b/s390x/Makefile
> index ef8041a..57d7c9e 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -24,6 +24,7 @@ tests += $(TEST_DIR)/mvpg.elf
>   tests += $(TEST_DIR)/uv-host.elf
>   tests += $(TEST_DIR)/edat.elf
>   tests += $(TEST_DIR)/mvpg-sie.elf
> +tests += $(TEST_DIR)/spec_ex.elf
>   
>   tests_binary = $(patsubst %.elf,%.bin,$(tests))
>   ifneq ($(HOST_KEY_DOCUMENT),)
> diff --git a/s390x/spec_ex.c b/s390x/spec_ex.c
> new file mode 100644
> index 0000000..dd0ee53
> --- /dev/null
> +++ b/s390x/spec_ex.c
> @@ -0,0 +1,182 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * © Copyright IBM Corp. 2021

Could we please avoid non-ASCII characters in source code if possible? ... 
it's maybe best if you do the Copyright line similar to the other *.c files 
from IBM that are already in the repository.

> + * Specification exception test.
> + * Tests that specification exceptions occur when expected.
> + */
> +#include <stdlib.h>
> +#include <libcflat.h>
> +#include <asm/interrupt.h>
> +#include <asm/facility.h>
> +
> +static struct lowcore *lc = (struct lowcore *) 0;
> +
> +static bool expect_invalid_psw;
> +static struct psw expected_psw;
> +static struct psw fixup_psw;
> +
> +/* The standard program exception handler cannot deal with invalid old PSWs,
> + * especially not invalid instruction addresses, as in that case one cannot
> + * find the instruction following the faulting one from the old PSW.
> + * The PSW to return to is set by load_psw.
> + */
> +static void fixup_invalid_psw(void)
> +{
> +	if (expect_invalid_psw) {
> +		report(expected_psw.mask == lc->pgm_old_psw.mask
> +		       && expected_psw.addr == lc->pgm_old_psw.addr,
> +		       "Invalid program new PSW as expected");
> +		expect_invalid_psw = false;
> +	}
> +	lc->pgm_old_psw = fixup_psw;
> +}
> +
> +static void load_psw(struct psw psw)
> +{
> +	uint64_t r0 = 0, r1 = 0;
> +
> +	asm volatile (
> +		"	epsw	%0,%1\n"
> +		"	st	%0,%[mask]\n"
> +		"	st	%1,4+%[mask]\n"
> +		"	larl	%0,nop%=\n"
> +		"	stg	%0,%[addr]\n"
> +		"	lpswe	%[psw]\n"
> +		"nop%=:	nop\n"
> +		: "+&r"(r0), "+&a"(r1), [mask] "=&R"(fixup_psw.mask),
> +		  [addr] "=&R"(fixup_psw.addr)

stg uses long displacement, so maybe the constraint should rather be "T" 
instead?

> +		: [psw] "Q"(psw)
> +		: "cc", "memory"
> +	);
> +}
> +
> +static void psw_bit_12_is_1(void)
> +{
> +	expected_psw.mask = 0x0008000000000000;
> +	expected_psw.addr = 0x00000000deadbeee;
> +	expect_invalid_psw = true;
> +	load_psw(expected_psw);
> +}
> +
> +static void bad_alignment(void)
> +{
> +	uint32_t words[5] = {0, 0, 0};
> +	uint32_t (*bad_aligned)[4];
> +
> +	register uint64_t r1 asm("6");
> +	register uint64_t r2 asm("7");
> +	if (((uintptr_t)&words[0]) & 0xf)
> +		bad_aligned = (uint32_t (*)[4])&words[0];
> +	else
> +		bad_aligned = (uint32_t (*)[4])&words[1];
> +	asm volatile ("lpq %0,%2"
> +		      : "=r"(r1), "=r"(r2)
> +		      : "T"(*bad_aligned)
> +	);
> +}
> +
> +static void not_even(void)
> +{
> +	uint64_t quad[2];
> +
> +	register uint64_t r1 asm("7");
> +	register uint64_t r2 asm("8");
> +	asm volatile (".insn	rxy,0xe3000000008f,%0,%2" //lpq %0,%2
> +		      : "=r"(r1), "=r"(r2)
> +		      : "T"(quad)
> +	);
> +}
> +
> +struct spec_ex_trigger {
> +	const char *name;
> +	void (*func)(void);
> +	void (*fixup)(void);
> +};
> +
> +static const struct spec_ex_trigger spec_ex_triggers[] = {
> +	{ "psw_bit_12_is_1", &psw_bit_12_is_1, &fixup_invalid_psw},
> +	{ "bad_alignment", &bad_alignment, NULL},
> +	{ "not_even", &not_even, NULL},
> +	{ NULL, NULL, NULL},
> +};
> +
> +struct args {
> +	uint64_t iterations;
> +};
> +
> +static void test_spec_ex(struct args *args,
> +			 const struct spec_ex_trigger *trigger)
> +{
> +	uint16_t expected_pgm = PGM_INT_CODE_SPECIFICATION;
> +	uint16_t pgm;
> +	unsigned int i;
> +
> +	for (i = 0; i < args->iterations; i++) {
> +		expect_pgm_int();
> +		register_pgm_cleanup_func(trigger->fixup);
> +		trigger->func();
> +		register_pgm_cleanup_func(NULL);
> +		pgm = clear_pgm_int();
> +		if (pgm != expected_pgm) {
> +			report(0,
> +			       "Program interrupt: expected(%d) == received(%d)",
> +			       expected_pgm,
> +			       pgm);
> +			return;
> +		}
> +	}
> +	report(1,
> +	       "Program interrupt: always expected(%d) == received(%d)",
> +	       expected_pgm,
> +	       expected_pgm);
> +}
> +
> +static struct args parse_args(int argc, char **argv)
> +{
> +	struct args args = {
> +		.iterations = 1,
> +	};
> +	unsigned int i;
> +	long arg;
> +	bool no_arg;
> +	char *end;
> +
> +	for (i = 1; i < argc; i++) {
> +		no_arg = true;
> +		if (i < argc - 1) {
> +			no_arg = *argv[i+1] == '\0';
> +			arg = strtol(argv[i+1], &end, 10);

Nit: It's more common to use spaces around the "+" (i.e. "i + 1")

> +			no_arg |= *end != '\0';
> +			no_arg |= arg < 0;
> +		}
> +
> +		if (!strcmp("--iterations", argv[i])) {
> +			if (no_arg)
> +				report_abort("--iterations needs a positive parameter");
> +			args.iterations = arg;
> +			++i;
> +		} else {
> +			report_abort("Unsupported parameter '%s'",
> +				     argv[i]);
> +		}
> +	}
> +	return args;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	unsigned int i;
> +
> +	struct args args = parse_args(argc, argv);
> +
> +	report_prefix_push("specification exception");
> +	for (i = 0; spec_ex_triggers[i].name; i++) {
> +		report_prefix_push(spec_ex_triggers[i].name);
> +		test_spec_ex(&args, &spec_ex_triggers[i]);
> +		report_prefix_pop();
> +	}
> +	report_prefix_pop();
> +
> +	return report_summary();
> +}

Apart from the nits, this looks fine to me.

  Thomas

