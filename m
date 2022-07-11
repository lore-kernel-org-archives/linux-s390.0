Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051F9C43334
	for <linux-s390@archiver.kernel.org>; Mon, 11 Jul 2022 12:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiGKMzD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Jul 2022 08:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiGKMzC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 Jul 2022 08:55:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA299275CB
        for <linux-s390@vger.kernel.org>; Mon, 11 Jul 2022 05:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657544100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yYLhtIraH/P83sRqXoqiEPvBMWIbgBnR78rbTzx4Wn0=;
        b=b7+CmSyk2wfciYtcwU3v59vXppIMFt3AblYrcCiafQn4s7XjfBKFryzUVj0DbK2ihFU/U/
        E5PqnBytV4eRggwfCXURzDI4ifRz4BJM6D4swDmYIwSgZS41OexboP+LBuQaRwQ/kYPoez
        B0Ql0NmJef8u85bx9HFXaAmGcvDD2hQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-ND96pqX-M5KnafbbjfYm0A-1; Mon, 11 Jul 2022 08:54:59 -0400
X-MC-Unique: ND96pqX-M5KnafbbjfYm0A-1
Received: by mail-wm1-f69.google.com with SMTP id m20-20020a05600c4f5400b003a03aad6bdfso2631391wmq.6
        for <linux-s390@vger.kernel.org>; Mon, 11 Jul 2022 05:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yYLhtIraH/P83sRqXoqiEPvBMWIbgBnR78rbTzx4Wn0=;
        b=h9uUga3x8sUIp1/1o0QkiGuexvy8rr/MORGCVD0CrC2qFolghK4p0JQGVRvtefmwAW
         I9qUfKsEOXS10xgasiSzFqe5s0Q4Hp6Q2ThZxec8vnXq2FCQdTV0Wx92LEDLp+TPp9Iz
         0y7fnFzw/YnNo9FzvmoydOsC5xlK8p48g44qYQawUrjUQtvzni1R3auoXBnF8ISovTvy
         9zCz7+mbultg31br/uiW+cQ224MyBx5lGTzMAU10nRGpdJXgCniIpwwoXdv11xps7qXy
         EgbjqVxcUHKczgZL5ZF9yQCwmoWf1IpsLlW+3GX5rtwepaysgjEolqDe3dfK1TSlfexT
         VQig==
X-Gm-Message-State: AJIora/CEO4kPxlOU03lMRQfKFXPVYQ8HCKXBEoHfRFmFR81+48kLOog
        u2bzob+/7/810u+1371LB8j3CrW/WNqlIiL//56nkZBz6KUrZnslYRSn1X0qno8UG8cTVKjoMUl
        o2IazIzy75KfcB4/JG990nw==
X-Received: by 2002:adf:d090:0:b0:21d:aa9b:9998 with SMTP id y16-20020adfd090000000b0021daa9b9998mr2867242wrh.33.1657544098669;
        Mon, 11 Jul 2022 05:54:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uE4LsfMjqLjzl8wdl5TmY4Zs+KUc2jxVKGIe34Od9vZ65x0woP5qz7BsmB7x7R0TpiBFRbAA==
X-Received: by 2002:adf:d090:0:b0:21d:aa9b:9998 with SMTP id y16-20020adfd090000000b0021daa9b9998mr2867227wrh.33.1657544098491;
        Mon, 11 Jul 2022 05:54:58 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-23.web.vodafone.de. [109.43.177.23])
        by smtp.gmail.com with ESMTPSA id n18-20020a5d4012000000b0021d83eed0e9sm5784532wrp.30.2022.07.11.05.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 05:54:58 -0700 (PDT)
Message-ID: <9889f7f6-73ad-32f8-ade8-49886dd148a1@redhat.com>
Date:   Mon, 11 Jul 2022 14:54:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [kvm-unit-tests PATCH v2 4/4] s390x: add pgm spec interrupt loop
 test
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc:     frankja@linux.ibm.com, imbrenda@linux.ibm.com
References: <20220704121328.721841-1-nrb@linux.ibm.com>
 <20220704121328.721841-5-nrb@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220704121328.721841-5-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 04/07/2022 14.13, Nico Boehr wrote:
> An invalid PSW causes a program interrupt. When an invalid PSW is
> introduced in the pgm_new_psw, an interrupt loop occurs as soon as a
> program interrupt is caused.
> 
> QEMU should detect that and panic the guest, hence add a test for it.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>   s390x/Makefile         |  1 +
>   s390x/panic-loop-pgm.c | 53 ++++++++++++++++++++++++++++++++++++++++++
>   s390x/unittests.cfg    |  6 +++++
>   3 files changed, 60 insertions(+)
>   create mode 100644 s390x/panic-loop-pgm.c
> 
> diff --git a/s390x/Makefile b/s390x/Makefile
> index e4649da50d9d..66415d0b588d 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -35,6 +35,7 @@ tests += $(TEST_DIR)/pv-attest.elf
>   tests += $(TEST_DIR)/migration-cmm.elf
>   tests += $(TEST_DIR)/migration-skey.elf
>   tests += $(TEST_DIR)/panic-loop-extint.elf
> +tests += $(TEST_DIR)/panic-loop-pgm.elf
>   
>   pv-tests += $(TEST_DIR)/pv-diags.elf
>   
> diff --git a/s390x/panic-loop-pgm.c b/s390x/panic-loop-pgm.c
> new file mode 100644
> index 000000000000..68934057a251
> --- /dev/null
> +++ b/s390x/panic-loop-pgm.c
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Program interrupt loop test
> + *
> + * Copyright IBM Corp. 2022
> + *
> + * Authors:
> + *  Nico Boehr <nrb@linux.ibm.com>
> + */
> +#include <libcflat.h>
> +#include <bitops.h>
> +#include <asm/interrupt.h>
> +#include <asm/barrier.h>
> +#include <hardware.h>
> +
> +static void pgm_int_handler(void)
> +{
> +	/*
> +	 * return to pgm_old_psw. This gives us the chance to print the return_fail
> +	 * in case something goes wrong.
> +	 */
> +	asm volatile (
> +		"lpswe %[pgm_old_psw]\n"
> +		:
> +		: [pgm_old_psw] "Q"(lowcore.pgm_old_psw)
> +		: "memory"
> +	);
> +}
> +
> +int main(void)
> +{
> +	report_prefix_push("panic-loop-pgm");
> +
> +	if (!host_is_qemu() || host_is_tcg()) {

Is TCG not able to detect the loop? ... if so, we should maybe fix QEMU?

> +		report_skip("QEMU-KVM-only test");
> +		goto out;
> +	}
> +
> +	lowcore.pgm_new_psw.addr = (uint64_t) pgm_int_handler;
> +	/* bit 12 set is invalid */
> +	lowcore.pgm_new_psw.mask = extract_psw_mask() | BIT(63 - 12);
> +	mb();
> +
> +	/* cause a pgm int */
> +	*((int *)-4) = 0x42;
> +	mb();
> +
> +	report_fail("survived pgmint loop");
> +
> +out:
> +	report_prefix_pop();
> +	return report_summary();
> +}

Reviewed-by: Thomas Huth <thuth@redhat.com>

