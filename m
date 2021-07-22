Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E59FC63797
	for <linux-s390@archiver.kernel.org>; Thu, 22 Jul 2021 09:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1534360C41
	for <linux-s390@archiver.kernel.org>; Thu, 22 Jul 2021 09:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhGVIrh (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 22 Jul 2021 04:47:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33071 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231376AbhGVIrg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 22 Jul 2021 04:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626946091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=caunD6WBo1XAHcQhMhOqrgWHallFQMHiPgjwSWOB4fg=;
        b=aDP0zHYdRpoWdWSnEXKM6GkxZJswIk9Pi6U8B8EckkojsR4PXk2AMDy1X5WkLkiH324CEv
        D3rC+/SX00XwS6igPNaxu76g/42QK2uQNwXD87PJxd9cQdV6tgZaLO1gXwZvEIVxab19pL
        0v6CXuQRMustuuCng1yOCgWA9V9vjJc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-OG4VuS8vNpevgLUgmHbgGg-1; Thu, 22 Jul 2021 05:28:08 -0400
X-MC-Unique: OG4VuS8vNpevgLUgmHbgGg-1
Received: by mail-wr1-f70.google.com with SMTP id i12-20020adffc0c0000b0290140ab4d8389so2232604wrr.10
        for <linux-s390@vger.kernel.org>; Thu, 22 Jul 2021 02:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=caunD6WBo1XAHcQhMhOqrgWHallFQMHiPgjwSWOB4fg=;
        b=fCKp2fes6SNtbSln4JFOs0TOOwN2F6kNGnQws5JTQgbdzdA/c62EYBWdb7vBM7hCaZ
         PeD3UztiYd2DBZ8/Z22bPavw1JUWNMdKZKfjbdQDp3m54OnOGTGjrurt/lE8Ph3jM/Sy
         kNh/46+AmAGQBUH9Pznv5Ogf+zp2obBjaiS6xp0WzUV9LQeRVsu4tff2vM+scdudqHWn
         BdeYqIg7SyQgFcox+3s6jy4pDw9i0d/mx5PhQlpX/RyTvPL/HJyzfHYyQ9XsyH/VOqL4
         EQIOzma2QhMT9LqHMe+MtPG75IYrekT6YOlM8FLqaSS6htVQ1s7ZZLNQILltJvpzKhgg
         EFBA==
X-Gm-Message-State: AOAM531zEYKVKpVrKNdiXe8BTbx8Xe4fpgqqmPsOyckwR2mxpEKm1iG5
        dvM6jufeUB2DFyiKJloQjoU+f603PEgp6VLQ3Z1ma1nyJrFl20kmpPV6sZEgHniL72s1ms30X/t
        zY9SUTGoQZaXKfurJIabrC+ED8fIuOJqDstkFLoY8Ao9Syb4C1CFNf7VUgbro+2aAw8Xtsg==
X-Received: by 2002:adf:eb4c:: with SMTP id u12mr48930647wrn.111.1626946087127;
        Thu, 22 Jul 2021 02:28:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7qEZuQMFJaccMc+yDMrFgFAX3BPD4rQhg/6jaiTrWYa3o98JI+tj1Q4/VvrDgcYk2nAWs4A==
X-Received: by 2002:adf:eb4c:: with SMTP id u12mr48930623wrn.111.1626946086932;
        Thu, 22 Jul 2021 02:28:06 -0700 (PDT)
Received: from thuth.remote.csb (pd9e83f5d.dip0.t-ipconnect.de. [217.232.63.93])
        by smtp.gmail.com with ESMTPSA id 140sm24964988wmb.43.2021.07.22.02.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 02:28:06 -0700 (PDT)
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20210706115724.372901-1-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [kvm-unit-tests PATCH] s390x: Add specification exception
 interception test
Message-ID: <709f6326-efcb-d359-bfac-59a162473c91@redhat.com>
Date:   Thu, 22 Jul 2021 11:28:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210706115724.372901-1-scgl@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 06/07/2021 13.57, Janis Schoetterl-Glausch wrote:
> Check that specification exceptions cause intercepts when
> specification exception interpretation is off.
> Check that specification exceptions caused by program new PSWs
> cause interceptions.
> We cannot assert that non program new PSW specification exceptions
> are interpreted because whether interpretation occurs or not is
> configuration dependent.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
> The patch is based on the following patch sets by Janosch:
> [kvm-unit-tests PATCH 0/5] s390x: sie and uv cleanups
> [kvm-unit-tests PATCH v2 0/3] s390x: Add snippet support
> 
>   s390x/Makefile             |  2 +
>   lib/s390x/sie.h            |  1 +
>   s390x/snippets/c/spec_ex.c | 13 ++++++
>   s390x/spec_ex-sie.c        | 91 ++++++++++++++++++++++++++++++++++++++
>   s390x/unittests.cfg        |  3 ++
>   5 files changed, 110 insertions(+)
>   create mode 100644 s390x/snippets/c/spec_ex.c
>   create mode 100644 s390x/spec_ex-sie.c
> 
> diff --git a/s390x/Makefile b/s390x/Makefile
> index 07af26d..b1b6536 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -24,6 +24,7 @@ tests += $(TEST_DIR)/mvpg.elf
>   tests += $(TEST_DIR)/uv-host.elf
>   tests += $(TEST_DIR)/edat.elf
>   tests += $(TEST_DIR)/mvpg-sie.elf
> +tests += $(TEST_DIR)/spec_ex-sie.elf
>   
>   tests_binary = $(patsubst %.elf,%.bin,$(tests))
>   ifneq ($(HOST_KEY_DOCUMENT),)
> @@ -84,6 +85,7 @@ snippet_asmlib = $(SNIPPET_DIR)/c/cstart.o
>   # perquisites (=guests) for the snippet hosts.
>   # $(TEST_DIR)/<snippet-host>.elf: snippets = $(SNIPPET_DIR)/<c/asm>/<snippet>.gbin
>   $(TEST_DIR)/mvpg-sie.elf: snippets = $(SNIPPET_DIR)/c/mvpg-snippet.gbin
> +$(TEST_DIR)/spec_ex-sie.elf: snippets = $(SNIPPET_DIR)/c/spec_ex.gbin
>   
>   $(SNIPPET_DIR)/asm/%.gbin: $(SNIPPET_DIR)/asm/%.o $(FLATLIBS)
>   	$(OBJCOPY) -O binary $(patsubst %.gbin,%.o,$@) $@
> diff --git a/lib/s390x/sie.h b/lib/s390x/sie.h
> index 6ba858a..a3b8623 100644
> --- a/lib/s390x/sie.h
> +++ b/lib/s390x/sie.h
> @@ -98,6 +98,7 @@ struct kvm_s390_sie_block {
>   	uint8_t		fpf;			/* 0x0060 */
>   #define ECB_GS		0x40
>   #define ECB_TE		0x10
> +#define ECB_SPECI	0x08
>   #define ECB_SRSI	0x04
>   #define ECB_HOSTPROTINT	0x02
>   	uint8_t		ecb;			/* 0x0061 */
> diff --git a/s390x/snippets/c/spec_ex.c b/s390x/snippets/c/spec_ex.c
> new file mode 100644
> index 0000000..f2daab5
> --- /dev/null
> +++ b/s390x/snippets/c/spec_ex.c

Please add a short header comment with the basic idea here + license 
information (e.g. SPDX identifier). Also in the other new file that you 
introduce in this patch.

> @@ -0,0 +1,13 @@
> +#include <stdint.h>
> +#include <asm/arch_def.h>
> +
> +__attribute__((section(".text"))) int main(void)
> +{
> +	uint64_t bad_psw = 0;
> +	struct psw *pgm_new = (struct psw *)464;

Is it possible to use the lib/s390x/asm/arch_def.h in snippets? If so, I'd 
vote for using &lowcore->pgm_new_psw instead of the magic number 464.

> +	pgm_new->mask = 1UL << (63 - 12); //invalid program new PSW

Please add a space after the //
(also in the other spots in this patch)

> +	pgm_new->addr = 0xdeadbeef;

Are we testing the mask or the addr here? If we're testing the mask, I'd 
rather use an even addr here to make sure that we do not trap because of the 
uneven address. Or do we just don't care?

> +	asm volatile ("lpsw %0" :: "Q"(bad_psw));
> +	return 0;
> +}

  Thomas

