Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677A4EB64DD
	for <linux-s390@archiver.kernel.org>; Thu, 13 Jul 2023 08:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbjGMIho (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 13 Jul 2023 04:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbjGMIhT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 13 Jul 2023 04:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8819330C3
        for <linux-s390@vger.kernel.org>; Thu, 13 Jul 2023 01:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689236993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cstQukCc6R5g+iNCjcRka3+OU408qYV+ropA4l/qCyo=;
        b=WFPjuZ+Cz1aDNkRx3CPqkbIADvV+lxCbdBWbzk5g2qwlqP7cT4W8ap21+wFaHIYTUx5wYJ
        +6kXchsHDOxeYfVaz3ho4WQqYTtDgXPjq9rBqe2nkGJNHZf+++5wtVaMEH1gJ6beCmHBzW
        oMr8XQv3eWlKF3oZwwzf1vL44nehWh4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-gFe_UqxaOoGTYvtgbLTEOw-1; Thu, 13 Jul 2023 04:29:52 -0400
X-MC-Unique: gFe_UqxaOoGTYvtgbLTEOw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-765de3a3404so65212485a.2
        for <linux-s390@vger.kernel.org>; Thu, 13 Jul 2023 01:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689236991; x=1691828991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cstQukCc6R5g+iNCjcRka3+OU408qYV+ropA4l/qCyo=;
        b=EnwJ/fZWWC9uF9t/j/Kmd9RGoguxZPigVjDcoUpjUBYRmURRQNf0HTFdGk/JFZDFRm
         +VdtZY8nyrIxzvTRrntqDVTkpl8oqyaXewgmqffVpf2UDph5B20TdYaY31udNYzdKvmV
         jYWrZPSxg3sXFxNQJCL/09Rr06vBHjqfrIsgk9FjcB4vADhMqKomAkiMqCPhlg8au3UE
         k1KVMM1sVprz0Xb6/oPXvVu/lWM0Hiu+tJnTYK/XO2O1rM1qEVwUD+Xl8qsPmsaiXKXK
         CV/DQTwzbACPDeMakkm9oD6Lg12Ax/5CagHz/+9p09IMU3ikDf1o8pjw2exXCLjNyt6o
         Fdsw==
X-Gm-Message-State: ABy/qLZshxnObHlYQJM2tvP/ycnGobPzxyNYnxZ3WkM/CDisQI+OMp7L
        ZweYcLR1cnglKjfKBrajEvFQwrwxk2OGGvYQpOWBiIucm7zBLlpIei9yOvYBI2OeJSiIidgttWl
        2aIgKoEmYXAvqlRSnk5M3rWF2ANiDtQ==
X-Received: by 2002:a37:f614:0:b0:767:54fd:65b2 with SMTP id y20-20020a37f614000000b0076754fd65b2mr794382qkj.66.1689236991647;
        Thu, 13 Jul 2023 01:29:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFjcKctmvnzO/YG+UBJmNHVyxS4u/ME5z1qvrE0d4EZS0E5aAnboTMf5vel0S7sL6thtmUlLg==
X-Received: by 2002:a37:f614:0:b0:767:54fd:65b2 with SMTP id y20-20020a37f614000000b0076754fd65b2mr794378qkj.66.1689236991380;
        Thu, 13 Jul 2023 01:29:51 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id k5-20020a05620a142500b00767cb046e40sm2721587qkj.94.2023.07.13.01.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 01:29:50 -0700 (PDT)
Message-ID: <1aac769e-7523-a858-8286-35625bfb0145@redhat.com>
Date:   Thu, 13 Jul 2023 10:29:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [kvm-unit-tests PATCH v5 6/6] s390x: add a test for SIE without
 MSO/MSL
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20230712114149.1291580-1-nrb@linux.ibm.com>
 <20230712114149.1291580-7-nrb@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230712114149.1291580-7-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 12/07/2023 13.41, Nico Boehr wrote:
> Since we now have the ability to run guests without MSO/MSL, add a test
> to make sure this doesn't break.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>   s390x/Makefile             |   2 +
>   s390x/sie-dat.c            | 115 +++++++++++++++++++++++++++++++++++++
>   s390x/snippets/c/sie-dat.c |  58 +++++++++++++++++++
>   s390x/unittests.cfg        |   3 +
>   4 files changed, 178 insertions(+)
>   create mode 100644 s390x/sie-dat.c
>   create mode 100644 s390x/snippets/c/sie-dat.c
> 
> diff --git a/s390x/Makefile b/s390x/Makefile
> index a80db538810e..4921669ee4c3 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -40,6 +40,7 @@ tests += $(TEST_DIR)/panic-loop-pgm.elf
>   tests += $(TEST_DIR)/migration-sck.elf
>   tests += $(TEST_DIR)/exittime.elf
>   tests += $(TEST_DIR)/ex.elf
> +tests += $(TEST_DIR)/sie-dat.elf
>   
>   pv-tests += $(TEST_DIR)/pv-diags.elf
>   
> @@ -120,6 +121,7 @@ snippet_lib = $(snippet_asmlib) lib/auxinfo.o
>   # perquisites (=guests) for the snippet hosts.
>   # $(TEST_DIR)/<snippet-host>.elf: snippets = $(SNIPPET_DIR)/<c/asm>/<snippet>.gbin
>   $(TEST_DIR)/mvpg-sie.elf: snippets = $(SNIPPET_DIR)/c/mvpg-snippet.gbin
> +$(TEST_DIR)/sie-dat.elf: snippets = $(SNIPPET_DIR)/c/sie-dat.gbin
>   $(TEST_DIR)/spec_ex-sie.elf: snippets = $(SNIPPET_DIR)/c/spec_ex.gbin
>   
>   $(TEST_DIR)/pv-diags.elf: pv-snippets += $(SNIPPET_DIR)/asm/snippet-pv-diag-yield.gbin
> diff --git a/s390x/sie-dat.c b/s390x/sie-dat.c
> new file mode 100644
> index 000000000000..b326995dfa85
> --- /dev/null
> +++ b/s390x/sie-dat.c
> @@ -0,0 +1,115 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Tests SIE with paging.
> + *
> + * Copyright 2023 IBM Corp.
> + *
> + * Authors:
> + *    Nico Boehr <nrb@linux.ibm.com>
> + */
> +#include <libcflat.h>
> +#include <vmalloc.h>
> +#include <asm/pgtable.h>
> +#include <mmu.h>
> +#include <asm/page.h>
> +#include <asm/interrupt.h>
> +#include <alloc_page.h>
> +#include <sclp.h>
> +#include <sie.h>
> +#include <snippet.h>
> +
> +static struct vm vm;
> +static pgd_t *guest_root;
> +
> +/* keep in sync with TEST_PAGE_COUNT in s390x/snippets/c/sie-dat.c */
> +#define GUEST_TEST_PAGE_COUNT 10
> +
> +/* keep in sync with TOTAL_PAGE_COUNT in s390x/snippets/c/sie-dat.c */
> +#define GUEST_TOTAL_PAGE_COUNT 256

I'd maybe put the defines rather in a header a la s390x/snippets/c/sie-dat.h 
and include that header here and in the snippet C code.

Apart from that, test looks good to me:
Reviewed-by: Thomas Huth <thuth@redhat.com>

