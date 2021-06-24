Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D546AC49EA7
	for <linux-s390@archiver.kernel.org>; Thu, 24 Jun 2021 16:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFF90613DC
	for <linux-s390@archiver.kernel.org>; Thu, 24 Jun 2021 16:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhFXQE4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 24 Jun 2021 12:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38275 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229445AbhFXQE4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Jun 2021 12:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624550556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wh7FfFRwRKHmN3Jxy+axdn4aGV5vraFn3lggiq8SLBQ=;
        b=AGI1GV7bSRaaWZ1Axl8746uiGKYAhZnppN+LEt0en/2Dwc5pWpRqWFA4uKxjQRCVqKGAHh
        P89drBcRT/FrRNJVTq4VW3MPfxNmEHQnTDmOm3rEpgTmNiBtb1+v6dbDCEwyTiV47nxBg7
        Rl/IsvHjvBQN5YnvlybA3ZRSNWquXeY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-CY7AzAbiOTmy-_J2DLbqyA-1; Thu, 24 Jun 2021 12:02:34 -0400
X-MC-Unique: CY7AzAbiOTmy-_J2DLbqyA-1
Received: by mail-wr1-f72.google.com with SMTP id h17-20020adff4d10000b029011a7b7961dbso2358759wrp.15
        for <linux-s390@vger.kernel.org>; Thu, 24 Jun 2021 09:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wh7FfFRwRKHmN3Jxy+axdn4aGV5vraFn3lggiq8SLBQ=;
        b=WHX2jyI8qjxdDr1u4zzkLXONW9RdQn+Itpi5aobQ3Gae0i/q8kF1xmj/yf8ezoH4zr
         VHYyuJqYWOH2MWbdpZaaPuaErlUxi2sCaIRpYV03aGs4BiGz0uswImHbJsyA7WKiitB7
         U4uumoE4Qo2/iCaoyPg7QN9H1OWROaVK05yFFL+C1XAmLTwb+bEarAPpG/EzE1i/1a+t
         IQYWwlgNQHdZo8tFpnpi9YIoMAocugU5EWVk0NYwjEIuLsd79wjaG659rfxzuvQIdqEX
         nYYGVqaoEGON1QFXF1ztsX1U3L8rUwwMD9hZL8YaBYbOSdfkIWBrJ/QOlp+vgCQA3Jhm
         0GSw==
X-Gm-Message-State: AOAM532dCZleRjLmUB8mVtfSts1lxwTIPn5teKfcA3/1YhBbbUkgohqb
        pWSbGtx8TetHB/rxVJo4Xx3oCmW6whi+54tZLfMi9JHhxdBPoscQQfam6S2oKKX59Alc9ek7Atc
        BWLBQD5H98uaQfEFQQghovw==
X-Received: by 2002:a5d:5707:: with SMTP id a7mr5303691wrv.179.1624550553498;
        Thu, 24 Jun 2021 09:02:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/pd3hiplPxW791gJrORcjSNaz63eFXt+17jMtoK/Oz8zj5tSYzneHn7H1zU/vLGPcmtjB2g==
X-Received: by 2002:a5d:5707:: with SMTP id a7mr5303662wrv.179.1624550553317;
        Thu, 24 Jun 2021 09:02:33 -0700 (PDT)
Received: from thuth.remote.csb (pd9575c8c.dip0.t-ipconnect.de. [217.87.92.140])
        by smtp.gmail.com with ESMTPSA id b9sm3662980wrt.55.2021.06.24.09.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 09:02:32 -0700 (PDT)
Subject: Re: [PATCH 2/3] s390x: snippets: Add snippet compilation
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com, seiden@linux.ibm.com
References: <20210624120152.344009-1-frankja@linux.ibm.com>
 <20210624120152.344009-3-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <d54552af-4694-638f-9100-e7ba720febfa@redhat.com>
Date:   Thu, 24 Jun 2021 18:02:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210624120152.344009-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 24/06/2021 14.01, Janosch Frank wrote:
> From: Steffen Eiden <seiden@linux.ibm.com>
> 
> This patch provides the necessary make targets to properly compile
> snippets and link them into their associated host.
> 
> To define the guest-host definition, we use the make-feature
> `SECONDEXPANSION` in combination with `Target specific Variable
> Values`. The variable `snippets` has different values depending on the
> current target. This enables us to define which snippets (=guests)
> belong to which hosts. Furthermore, using the second-expansion, we can
> use `snippets` in the perquisites of the host's `%.elf` rule, which
> otherwise would be not set.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>   s390x/Makefile | 27 +++++++++++++++++++++------
>   1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/s390x/Makefile b/s390x/Makefile
> index 8820e99..ba32f4c 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -76,11 +76,26 @@ OBJDIRS += lib/s390x
>   asmlib = $(TEST_DIR)/cstart64.o $(TEST_DIR)/cpu.o
>   
>   FLATLIBS = $(libcflat)
> -%.elf: %.o $(FLATLIBS) $(SRCDIR)/s390x/flat.lds $(asmlib)
> -	$(CC) $(CFLAGS) -c -o $(@:.elf=.aux.o) \
> -		$(SRCDIR)/lib/auxinfo.c -DPROGNAME=\"$@\"
> -	$(CC) $(LDFLAGS) -o $@ -T $(SRCDIR)/s390x/flat.lds \
> -		$(filter %.o, $^) $(FLATLIBS) $(@:.elf=.aux.o)
> +
> +SNIPPET_DIR = $(TEST_DIR)/snippets
> +snippet_asmlib = $(SNIPPET_DIR)/c/cstart.o
> +
> +# perquisites (=guests) for the snippet hosts.
> +# $(TEST_DIR)/<snippet-host>.elf: snippets = $(SNIPPET_DIR)/<c/asm>/<snippet>.gbin
> +
> +$(SNIPPET_DIR)/asm/%.gbin: $(SNIPPET_DIR)/asm/%.o $(FLATLIBS)
> +	$(OBJCOPY) -O binary $(patsubst %.gbin,%.o,$@) $@
> +	$(OBJCOPY) -I binary -O elf64-s390 -B "s390:64-bit" $@ $@
> +
> +$(SNIPPET_DIR)/c/%.gbin: $(SNIPPET_DIR)/c/%.o $(snippet_asmlib) $(FLATLIBS)
> +	$(CC) $(LDFLAGS) -o $@ -T $(SNIPPET_DIR)/c/flat.lds $(patsubst %.gbin,%.o,$@) $(snippet_asmlib) $(FLATLIBS)
> +	$(OBJCOPY) -O binary $@ $@
> +	$(OBJCOPY) -I binary -O elf64-s390 -B "s390:64-bit" $@ $@
> +
> +.SECONDEXPANSION:
> +%.elf: $$(snippets) %.o $(FLATLIBS) $(SRCDIR)/s390x/flat.lds $(asmlib)
> +	$(CC) $(CFLAGS) -c -o $(@:.elf=.aux.o) $(SRCDIR)/lib/auxinfo.c -DPROGNAME=\"$@\"
> +	$(CC) $(LDFLAGS) -o $@ -T $(SRCDIR)/s390x/flat.lds $(filter %.o, $^) $(FLATLIBS) $(snippets) $(@:.elf=.aux.o)

Wow, weird Makefile magic, never seend that before ... but it sounds 
reasonable, so:

Acked-by: Thomas Huth <thuth@redhat.com>

