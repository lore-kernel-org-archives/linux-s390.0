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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450ACC49EA5
	for <linux-s390@archiver.kernel.org>; Thu, 24 Jun 2021 15:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2514661249
	for <linux-s390@archiver.kernel.org>; Thu, 24 Jun 2021 15:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFXPwS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 24 Jun 2021 11:52:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230008AbhFXPwS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Jun 2021 11:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624549798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1cyU0gxyx5x4nyoLMr8QSHN09Zeplw7HF9KeUyPYMbo=;
        b=S5cwqEhHA9Ced+7NBuB0aWQu8KPLB+lmH3Rpv0QC5AN1eIC37sr+o4tKHw1kl6VB2zXW7i
        iwzMKqFNjoaTJoT8L/gValFygZ/PnX0RRdKRUAO/PB/R9i34FpgvqTRaWU9kgi4r3dpMl9
        lkti+Ap7fzltJqC98iQjjCofbY3Watg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-bnfHOrqmO6Os-bDXF0KriQ-1; Thu, 24 Jun 2021 11:49:56 -0400
X-MC-Unique: bnfHOrqmO6Os-bDXF0KriQ-1
Received: by mail-wm1-f72.google.com with SMTP id k16-20020a7bc3100000b02901d849b41038so3220274wmj.7
        for <linux-s390@vger.kernel.org>; Thu, 24 Jun 2021 08:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1cyU0gxyx5x4nyoLMr8QSHN09Zeplw7HF9KeUyPYMbo=;
        b=qtBz4JZ35HPjxQz5yo0vCOXm6tRw1nHQJj/ZiYFHeaa2LD2usjQvF2rQ+eYHPLkoF4
         kyLqkW7Vo9yFB93Vcvr9PPUm9Pxzkf5e/rkYdKMfgaijY8i/Ldd/l2TE3zutuZ69Kajs
         bv4tboD3p2+vjUfpbFreAyPDBJfGlfBLHoTstZd8Opwvq49rtJyw0XZVOfIeqB+79N31
         7xGyhmT0imwO5ZeYa8q2XGrOM3RypmGJM0k8xMtzh1Z3YmL+GPGWOX52leVvPKYCCwVi
         uNi1gTIRT4htY0HHpDaY/IfP2MgysWZx5Hkqbdd4y+YYfmmYOWgTr71n01FkKa/EWlfU
         p2cA==
X-Gm-Message-State: AOAM532aMyawYp+YuwU8il9Ddcs0PO46fI/wrq/srTXmbUyctdbGUZTs
        Autrbhr4a8/FfvBEPKUiXzjBeBzfu0Fh6cvRKXzLF6KxYEz+QhodNoXwUYJfTjPlgzGfjyRBXZP
        GOOQVvSWak5ksbPgUc+9ADw==
X-Received: by 2002:a1c:9ac6:: with SMTP id c189mr5092252wme.149.1624549795615;
        Thu, 24 Jun 2021 08:49:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCqsH//+fCWJ9o/ZxJtQm10IWLQFKx8B4s0/fNmn477yVr6o5E/hX4cm3t3zfhdJwSoJ+2xg==
X-Received: by 2002:a1c:9ac6:: with SMTP id c189mr5092237wme.149.1624549795445;
        Thu, 24 Jun 2021 08:49:55 -0700 (PDT)
Received: from thuth.remote.csb (pd9575c8c.dip0.t-ipconnect.de. [217.87.92.140])
        by smtp.gmail.com with ESMTPSA id f19sm3481801wre.48.2021.06.24.08.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 08:49:55 -0700 (PDT)
Subject: Re: [PATCH 1/3] s390x: snippets: Add gitignore as well as linker
 script and start assembly
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com, seiden@linux.ibm.com
References: <20210624120152.344009-1-frankja@linux.ibm.com>
 <20210624120152.344009-2-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <cd6d6ff0-82f1-269f-f826-56000431c5fb@redhat.com>
Date:   Thu, 24 Jun 2021 17:49:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210624120152.344009-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 24/06/2021 14.01, Janosch Frank wrote:
> Snippets are small guests That can be run under a unit test as the
> hypervisor. They can be written in C or assembly. The C code needs a
> linker script and a start assembly file that jumps to main to work
> properly. So let's add that as well as a gitignore entry for the new
> files.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   .gitignore                |  1 +
>   s390x/snippets/c/cstart.S | 15 ++++++++++++
>   s390x/snippets/c/flat.lds | 51 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 67 insertions(+)
>   create mode 100644 s390x/snippets/c/cstart.S
>   create mode 100644 s390x/snippets/c/flat.lds
> 
> diff --git a/.gitignore b/.gitignore
> index 8534fb7..b3cf2cb 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -23,3 +23,4 @@ cscope.*
>   /api/dirty-log
>   /api/dirty-log-perf
>   /s390x/*.bin
> +/s390x/snippets/*/*.gbin
> diff --git a/s390x/snippets/c/cstart.S b/s390x/snippets/c/cstart.S
> new file mode 100644
> index 0000000..d7f6525
> --- /dev/null
> +++ b/s390x/snippets/c/cstart.S
> @@ -0,0 +1,15 @@
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
> +	lghi	%r15, 0x4000 - 160
> +	brasl	%r14, main
> +	/* For now let's only use cpu 0 in snippets so this will always work. */
> +	xgr	%r0, %r0
> +	sigp    %r2, %r0, SIGP_STOP
> diff --git a/s390x/snippets/c/flat.lds b/s390x/snippets/c/flat.lds
> new file mode 100644
> index 0000000..5e70732
> --- /dev/null
> +++ b/s390x/snippets/c/flat.lds
> @@ -0,0 +1,51 @@
> +SECTIONS
> +{
> +	.lowcore : {
> +		/*
> +		 * Initial short psw for disk boot, with 31 bit addressing for
> +		 * non z/Arch environment compatibility and the instruction
> +		 * address 0x10000 (cstart64.S .init).

I think this comment needs some adjustments (0x10000 => 0x4000 and do not 
talk about cstart64.S)?

Also, what about switching to 64-bit mode in the snippets?

  Thomas


> +		 */
> +		. = 0;
> +		 LONG(0x00080000)
> +		 LONG(0x80004000)
> +		 /* Restart new PSW for booting via PSW restart. */
> +		 . = 0x1a0;
> +		 QUAD(0x0000000180000000)
> +		 QUAD(0x0000000000004000)
> +	}
> +	. = 0x4000;
> +	.text : {
> +		*(.init)
> +		*(.text)
> +		*(.text.*)
> +	}
> +	. = ALIGN(64K);
> +	etext = .;
> +	.opd : { *(.opd) }
> +	. = ALIGN(16);
> +	.dynamic : {
> +		dynamic_start = .;
> +		*(.dynamic)
> +	}
> +	.dynsym : {
> +		dynsym_start = .;
> +		*(.dynsym)
> +	}
> +	.rela.dyn : { *(.rela*) }
> +	. = ALIGN(16);
> +	.data : {
> +		*(.data)
> +		*(.data.rel*)
> +	}
> +	. = ALIGN(16);
> +	.rodata : { *(.rodata) *(.rodata.*) }
> +	. = ALIGN(16);
> +	__bss_start = .;
> +	.bss : { *(.bss) }
> +	__bss_end = .;
> +	. = ALIGN(64K);
> +	edata = .;
> +	. += 64K;
> +	. = ALIGN(64K);
> +}
> 

