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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44566C48BC2
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 10:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2994561164
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 10:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhFUKNE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 21 Jun 2021 06:13:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45339 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230291AbhFUKND (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Jun 2021 06:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624270249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HOjpFOJ/4nLurltJvbob8ysv+DJPcYt2ytokui1BUB8=;
        b=YuDs9+LSU2zyIY0cz0qySQA8oxtX56yOwf30tleKpXpl0XAXq0eZanHqh4k+c7UFFp4N+F
        fRY2E86UORToZLAHt1PZMZhN9CG5fzmY9iEUNi+LVI1YCTGY9AQh64wPQvnlddfdZep/SQ
        WQr6b9RxfrAvXLAPus0BtKFW7SgTmBc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-icdVGsbXMDOeyTLbUV1a4w-1; Mon, 21 Jun 2021 06:10:48 -0400
X-MC-Unique: icdVGsbXMDOeyTLbUV1a4w-1
Received: by mail-wr1-f69.google.com with SMTP id n2-20020adfb7420000b029010e47b59f31so8171716wre.9
        for <linux-s390@vger.kernel.org>; Mon, 21 Jun 2021 03:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HOjpFOJ/4nLurltJvbob8ysv+DJPcYt2ytokui1BUB8=;
        b=W6D4ZvJKTPztbet/acJUoTP6jclK1rt6q/TlS+7wcea4ngK2t7Rvwq5zovSQ0vP4Tg
         6FTirBK4JeaNFDQdsu1Ul7io+zvn0uWY8JMUj4dHNdno2GkV67JWT3cVPGK07Off0ddK
         7KZVv//kzfZJhou/57nHD+0nFacaLLdhP33rT5YB9h2A8Ethls+40SnSU2gtC+55pxgU
         6PS81BngKktQmiZXmoilgL/N91874PpDH+HFFTCU9UMo0VIwG7cDGNgTjXXlwXeZnMJx
         8rG7eOwzwJKj1VDqMdnelOojbK4rM38BFZuGLTUO7WwHiJLHwdECxrK8eDyNVBbH6MoN
         ZPkg==
X-Gm-Message-State: AOAM533+p/Jt287GcZ4y/XSUAFmE56ChNXHfpTeinvF5SlpQK6A11AQJ
        sem0hsN9tkjnyEp2LfBfqdP70bMX8uT6IbdPl7vqrtZ83I6gRG4sG7D12YllsbxE87n7s4zrlss
        iM1ScUZeSyp5Kr9wSPX5joQ==
X-Received: by 2002:a05:600c:3b1e:: with SMTP id m30mr1586419wms.25.1624270246857;
        Mon, 21 Jun 2021 03:10:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZiYU5pP2UX/Meei5TISEGbiyK6Ex9W3o4xYyxK3CQqz1LrnDy0Lz+9/+Xp7/dGeQP9EEKng==
X-Received: by 2002:a05:600c:3b1e:: with SMTP id m30mr1586395wms.25.1624270246605;
        Mon, 21 Jun 2021 03:10:46 -0700 (PDT)
Received: from thuth.remote.csb (pd9575fcd.dip0.t-ipconnect.de. [217.87.95.205])
        by smtp.gmail.com with ESMTPSA id e38sm12275669wmp.4.2021.06.21.03.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 03:10:46 -0700 (PDT)
Subject: Re: [kvm-unit-tests RFC 1/2] s390x: Add guest snippet support
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com
References: <20210520094730.55759-1-frankja@linux.ibm.com>
 <20210520094730.55759-2-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <b5171773-afb6-e148-a82f-ea78877206ce@redhat.com>
Date:   Mon, 21 Jun 2021 12:10:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210520094730.55759-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 20/05/2021 11.47, Janosch Frank wrote:
> Snippets can be used to easily write and run guest (SIE) tests.
> The snippet is linked into the test binaries and can therefore be
> accessed via a ptr.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   .gitignore                |  2 ++
>   s390x/Makefile            | 28 ++++++++++++++++++---
>   s390x/snippets/c/cstart.S | 13 ++++++++++
>   s390x/snippets/c/flat.lds | 51 +++++++++++++++++++++++++++++++++++++++
>   4 files changed, 91 insertions(+), 3 deletions(-)
>   create mode 100644 s390x/snippets/c/cstart.S
>   create mode 100644 s390x/snippets/c/flat.lds
> 
> diff --git a/.gitignore b/.gitignore
> index 784cb2dd..29d3635b 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -22,3 +22,5 @@ cscope.*
>   /api/dirty-log
>   /api/dirty-log-perf
>   /s390x/*.bin
> +/s390x/snippets/*/*.bin
> +/s390x/snippets/*/*.gbin
> diff --git a/s390x/Makefile b/s390x/Makefile
> index 8de926ab..fe267011 100644
> --- a/s390x/Makefile
> +++ b/s390x/Makefile
> @@ -75,11 +75,33 @@ OBJDIRS += lib/s390x
>   asmlib = $(TEST_DIR)/cstart64.o $(TEST_DIR)/cpu.o
>   
>   FLATLIBS = $(libcflat)
> -%.elf: %.o $(FLATLIBS) $(SRCDIR)/s390x/flat.lds $(asmlib)
> +
> +SNIPPET_DIR = $(TEST_DIR)/snippets
> +
> +# C snippets that need to be linked
> +snippets-c =
> +
> +# ASM snippets that are directly compiled and converted to a *.gbin
> +snippets-a =

Could you please call this snippets-s instead of ...-a ? The -a suffix looks 
like an archive to me otherwise.

> +snippets = $(snippets-a)$(snippets-c)

Shouldn't there be a space between the two?

> +snippets-o += $(patsubst %.gbin,%.o,$(snippets))
> +
> +$(snippets-a): $(snippets-o) $(FLATLIBS)
> +	$(OBJCOPY) -O binary $(patsubst %.gbin,%.o,$@) $@
> +	$(OBJCOPY) -I binary -O elf64-s390 -B "s390:64-bit" $@ $@
> +
> +$(snippets-c): $(snippets-o) $(SNIPPET_DIR)/c/cstart.o  $(FLATLIBS)
> +	$(CC) $(LDFLAGS) -o $@ -T $(SNIPPET_DIR)/c/flat.lds \
> +		$(filter %.o, $^) $(FLATLIBS)
> +	$(OBJCOPY) -O binary $@ $@
> +	$(OBJCOPY) -I binary -O elf64-s390 -B "s390:64-bit" $@ $@
> +
> +%.elf: $(snippets) %.o $(FLATLIBS) $(SRCDIR)/s390x/flat.lds $(asmlib)
>   	$(CC) $(CFLAGS) -c -o $(@:.elf=.aux.o) \
>   		$(SRCDIR)/lib/auxinfo.c -DPROGNAME=\"$@\"
>   	$(CC) $(LDFLAGS) -o $@ -T $(SRCDIR)/s390x/flat.lds \
> -		$(filter %.o, $^) $(FLATLIBS) $(@:.elf=.aux.o)
> +		$(filter %.o, $^) $(FLATLIBS) $(snippets) $(@:.elf=.aux.o)

Does this link the snippets into all elf files? ... wouldn't it be better to 
restrict it somehow to the files that really need them?

>   	$(RM) $(@:.elf=.aux.o)
>   	@chmod a-x $@
>   
> @@ -93,7 +115,7 @@ FLATLIBS = $(libcflat)
>   	$(GENPROTIMG) --host-key-document $(HOST_KEY_DOCUMENT) --no-verify --image $< -o $@
>   
>   arch_clean: asm_offsets_clean
> -	$(RM) $(TEST_DIR)/*.{o,elf,bin} $(TEST_DIR)/.*.d lib/s390x/.*.d
> +	$(RM) $(TEST_DIR)/*.{o,elf,bin} $(SNIPPET_DIR)/c/*.{o,elf,bin,gbin} $(SNIPPET_DIR)/.*.d $(TEST_DIR)/.*.d lib/s390x/.*.d
>   
>   generated-files = $(asm-offsets)
>   $(tests:.elf=.o) $(asmlib) $(cflatobjs): $(generated-files)
> diff --git a/s390x/snippets/c/cstart.S b/s390x/snippets/c/cstart.S
> new file mode 100644
> index 00000000..02a3338b
> --- /dev/null
> +++ b/s390x/snippets/c/cstart.S
> @@ -0,0 +1,13 @@
> +#include <asm/sigp.h>
> +
> +.section .init
> +	.globl start
> +start:
> +	/* XOR all registers with themselves to clear them fully. */
> +	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
> +	xgr \i,\i
> +	.endr
> +	/* 0x3000 is the stack page for now */
> +	lghi	%r15, 0x4000
> +	brasl	%r14, main
> +	sigp    %r1, %r0, SIGP_STOP

I think you should clear r0 before using it here?

  Thomas

