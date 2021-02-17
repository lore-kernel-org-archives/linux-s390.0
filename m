Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC217C433E9
	for <linux-s390@archiver.kernel.org>; Wed, 17 Feb 2021 15:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29B161606
	for <linux-s390@archiver.kernel.org>; Wed, 17 Feb 2021 15:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbhBQPvW (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 17 Feb 2021 10:51:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233634AbhBQPvS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Feb 2021 10:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613576990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U/J5cQ8XXiKIjZ+y85SVmoZqBKcXUS2GEKI4wC7sZFg=;
        b=dQ1HVvgWpIMgVcxHtLzaqN1GMbHMqCVn8WuvJ9j3H7Mf/vxaKaQlcAzlHe9zP+MPryi88U
        m0jAiVCLaK4NTbYYTDuYU6t/ClNfDBQ5C8MU9PhMa9ZlMFODonl+i1JXffcRQZ+4b7qDtA
        cZkNtREA1H1KDN57erO2pnKj085HvXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-2jWtK4fyNYia0NwuVYPnaQ-1; Wed, 17 Feb 2021 10:49:46 -0500
X-MC-Unique: 2jWtK4fyNYia0NwuVYPnaQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 550D56EE26;
        Wed, 17 Feb 2021 15:49:45 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-116.ams2.redhat.com [10.36.112.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B54DF5C1A3;
        Wed, 17 Feb 2021 15:49:40 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v2 4/8] s390x: Introduce and use
 CALL_INT_HANDLER macro
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        pmorel@linux.ibm.com, david@redhat.com
References: <20210217144116.3368-1-frankja@linux.ibm.com>
 <20210217144116.3368-5-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <3cb211f9-cf95-4035-c880-59e0387d68e9@redhat.com>
Date:   Wed, 17 Feb 2021 16:49:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210217144116.3368-5-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 17/02/2021 15.41, Janosch Frank wrote:
> The ELF ABI dictates that we need to allocate 160 bytes of stack space
> for the C functions we're calling.

So this actually some kind of bug fix, since we should have allocated that 
area before already? Why did we never experienced any issues here so far? 
Are the called functions not using the save area?

> 
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index 35d20293..666a9567 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -92,37 +92,19 @@ memsetxc:
>   
>   .section .text
>   pgm_int:
> -	SAVE_REGS_STACK
> -	lgr     %r2, %r15
> -	brasl	%r14, handle_pgm_int
> -	RESTORE_REGS_STACK
> -	lpswe	GEN_LC_PGM_OLD_PSW
> +	CALL_INT_HANDLER handle_pgm_int, GEN_LC_PGM_OLD_PSW
>   
>   ext_int:
> -	SAVE_REGS_STACK
> -	lgr     %r2, %r15
> -	brasl	%r14, handle_ext_int
> -	RESTORE_REGS_STACK
> -	lpswe	GEN_LC_EXT_OLD_PSW
> +	CALL_INT_HANDLER handle_ext_int, GEN_LC_EXT_OLD_PSW
>   
>   mcck_int:
> -	SAVE_REGS_STACK
> -	brasl	%r14, handle_mcck_int
> -	RESTORE_REGS_STACK
> -	lpswe	GEN_LC_MCCK_OLD_PSW
> +	CALL_INT_HANDLER handle_mcck_int, GEN_LC_MCCK_OLD_PSW
>   
>   io_int:
> -	SAVE_REGS_STACK
> -	lgr     %r2, %r15
> -	brasl	%r14, handle_io_int
> -	RESTORE_REGS_STACK
> -	lpswe	GEN_LC_IO_OLD_PSW
> +	CALL_INT_HANDLER handle_io_int, GEN_LC_IO_OLD_PSW
>   
>   svc_int:
> -	SAVE_REGS_STACK
> -	brasl	%r14, handle_svc_int
> -	RESTORE_REGS_STACK
> -	lpswe	GEN_LC_SVC_OLD_PSW
> +	CALL_INT_HANDLER handle_svc_int, GEN_LC_SVC_OLD_PSW
>   
>   	.align	8
>   initial_psw:
> diff --git a/s390x/macros.S b/s390x/macros.S
> index a7d62c6f..212a3823 100644
> --- a/s390x/macros.S
> +++ b/s390x/macros.S
> @@ -11,6 +11,23 @@
>    *  David Hildenbrand <david@redhat.com>
>    */
>   #include <asm/asm-offsets.h>
> +/*
> + * Exception handler macro that saves registers on the stack,
> + * allocates stack space and calls the C handler function. Afterwards
> + * we re-load the registers and load the old PSW.
> + */
> +	.macro CALL_INT_HANDLER c_func, old_psw
> +	SAVE_REGS_STACK
> +	/* Save the stack address in GR2 which is the first function argument */
> +	lgr     %r2, %r15
> +	/* Allocate stack pace for called C function, as specified in s390 ELF ABI */

s/pace/space/

> +	slgfi   %r15, 160
> +	brasl	%r14, \c_func
> +	algfi   %r15, 160
> +	RESTORE_REGS_STACK
> +	lpswe	\old_psw
> +	.endm

As long as the macro is only used in cstart64.S, I think you could also put 
it there (no strong opinion on this, though).

Anyway, with the typo fixed:
Reviewed-by: Thomas Huth <thuth@redhat.com>

