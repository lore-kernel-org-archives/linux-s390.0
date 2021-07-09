Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF83C07E9B
	for <linux-s390@archiver.kernel.org>; Fri,  9 Jul 2021 09:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EA57613DF
	for <linux-s390@archiver.kernel.org>; Fri,  9 Jul 2021 09:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhGIJZm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 9 Jul 2021 05:25:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45679 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231882AbhGIJZm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 9 Jul 2021 05:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625822578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KyZDNDfWjU0mnejP9qA3aJ1YJ1HJhwNz4vMr50lvk4I=;
        b=GVhRf88mZuepNvftFIPijag1E5nE5R85r7xGbAm6bI2v6f3d9+rn+v5NJ2ZJ9fepiHBSgc
        cSOLLBk9W2qjf9MV6XVUV7uJiwI1X1p5i4RoBlOl7pmCUHT7Tp0UY/OdjRQswsHlo5JJk+
        FYnROcQm0FcuAZAJQXO7lMj8cSAIs7Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-iCdQtYCVPw-Tx6yh5TsxtA-1; Fri, 09 Jul 2021 05:22:55 -0400
X-MC-Unique: iCdQtYCVPw-Tx6yh5TsxtA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C84F800D62;
        Fri,  9 Jul 2021 09:22:54 +0000 (UTC)
Received: from localhost (ovpn-113-97.ams2.redhat.com [10.36.113.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96265E720;
        Fri,  9 Jul 2021 09:22:45 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH] s390x: Add specification exception test
In-Reply-To: <20210706115459.372749-1-scgl@linux.ibm.com>
Organization: Red Hat GmbH
References: <20210706115459.372749-1-scgl@linux.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Fri, 09 Jul 2021 11:22:38 +0200
Message-ID: <87v95jet9d.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jul 06 2021, Janis Schoetterl-Glausch <scgl@linux.ibm.com> wrote:

> Generate specification exceptions and check that they occur.
> Also generate specification exceptions during a transaction,
> which results in another interruption code.
> With the iterations argument one can check if specification
> exception interpretation occurs, e.g. by using a high value and
> checking that the debugfs counters are substantially lower.
> The argument is also useful for estimating the performance benefit
> of interpretation.
>
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>  s390x/Makefile           |   1 +
>  lib/s390x/asm/arch_def.h |   1 +
>  s390x/spec_ex.c          | 344 +++++++++++++++++++++++++++++++++++++++
>  s390x/unittests.cfg      |   3 +
>  4 files changed, 349 insertions(+)
>  create mode 100644 s390x/spec_ex.c

(...)

> +static void lpsw(uint64_t psw)

Maybe call this load_psw(), as you do a bit more than a simple lpsw?

> +{
> +	uint32_t *high, *low;
> +	uint64_t r0 = 0, r1 = 0;
> +
> +	high = (uint32_t *) &fixup_early_pgm_psw.mask;
> +	low = high + 1;
> +
> +	asm volatile (
> +		"	epsw	%0,%1\n"
> +		"	st	%0,%[high]\n"
> +		"	st	%1,%[low]\n"
> +		"	larl	%0,nop%=\n"
> +		"	stg	%0,%[addr]\n"
> +		"	lpsw	%[psw]\n"
> +		"nop%=:	nop\n"
> +		: "+&r"(r0), "+&a"(r1), [high] "=&R"(*high), [low] "=&R"(*low)
> +		, [addr] "=&R"(fixup_early_pgm_psw.addr)
> +		: [psw] "Q"(psw)
> +		: "cc", "memory"
> +	);
> +}

(...)

> +static void test_spec_ex(struct args *args,
> +			 const struct spec_ex_trigger *trigger)
> +{
> +	uint16_t expected_pgm = PGM_INT_CODE_SPECIFICATION;
> +	uint16_t pgm;
> +	unsigned int i;
> +
> +	register_pgm_cleanup_func(trigger->fixup);
> +	for (i = 0; i < args->iterations; i++) {
> +		expect_pgm_int();
> +		trigger->func();
> +		pgm = clear_pgm_int();
> +		if (pgm != expected_pgm) {
> +			report(0,
> +			"Program interrupt: expected(%d) == received(%d)",
> +			expected_pgm,
> +			pgm);

The indentation looks a bit funny here.

> +			return;
> +		}
> +	}
> +	report(1,
> +	"Program interrupt: always expected(%d) == received(%d)",
> +	expected_pgm,
> +	expected_pgm);

Here as well.

> +}

(...)

> +#define report_info_if(cond, fmt, ...)			\
> +	do {						\
> +		if (cond) {				\
> +			report_info(fmt, ##__VA_ARGS__);\
> +		}					\
> +	} while (0)

I'm wondering whether such a wrapper function could be generally useful.

