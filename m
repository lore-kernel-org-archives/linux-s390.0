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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27D3C433E6
	for <linux-s390@archiver.kernel.org>; Wed, 17 Feb 2021 17:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9822864E42
	for <linux-s390@archiver.kernel.org>; Wed, 17 Feb 2021 17:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbhBQRE4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 17 Feb 2021 12:04:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25323 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234352AbhBQRE4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Feb 2021 12:04:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613581409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4VB/06A3t0EJ2bLByb7cuuguXJQk0VpzA/18ssL03D0=;
        b=dHuhCap0KadZkWAa1MsbGA32XH7804Ryjib8oeEMbzbQ6GC1lsxfI0DJQicHf9cZ0RqKQm
        Z21Cv+4kBMlXC1P72O9u6yQLmMrmGPjd9u5bA/+JaWVglWELdGQfb5NNoRVC1KEXb9t5hb
        0kSkHH7svDkuDuf3obUW1z2+uf3BoDU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-iWsGh1oIO_-K-cNZ1UQoXg-1; Wed, 17 Feb 2021 12:03:25 -0500
X-MC-Unique: iWsGh1oIO_-K-cNZ1UQoXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1F29803F4C;
        Wed, 17 Feb 2021 17:03:23 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-116.ams2.redhat.com [10.36.112.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56C7F5D748;
        Wed, 17 Feb 2021 17:03:19 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v2 4/8] s390x: Introduce and use
 CALL_INT_HANDLER macro
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        pmorel@linux.ibm.com, david@redhat.com
References: <20210217144116.3368-1-frankja@linux.ibm.com>
 <20210217144116.3368-5-frankja@linux.ibm.com>
 <313546fb-35df-22ab-79f8-d5b49286058f@redhat.com>
 <8f95d948-a814-92ab-91f5-52424a53a28b@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <bf4f49dd-5255-91c6-5a65-4d346d7d2701@redhat.com>
Date:   Wed, 17 Feb 2021 18:03:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <8f95d948-a814-92ab-91f5-52424a53a28b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 17/02/2021 17.22, Janosch Frank wrote:
> On 2/17/21 4:55 PM, Thomas Huth wrote:
>> On 17/02/2021 15.41, Janosch Frank wrote:
>>> The ELF ABI dictates that we need to allocate 160 bytes of stack space
>>> for the C functions we're calling. Since we would need to do that for
>>> every interruption handler which, combined with the new stack argument
>>> being saved in GR2, makes cstart64.S look a bit messy.
>>>
>>> So let's introduce the CALL_INT_HANDLER macro that handles all of
>>> that, calls the C interrupt handler and handles cleanup afterwards.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>    s390x/cstart64.S | 28 +++++-----------------------
>>>    s390x/macros.S   | 17 +++++++++++++++++
>>>    2 files changed, 22 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
>>> index 35d20293..666a9567 100644
>>> --- a/s390x/cstart64.S
>>> +++ b/s390x/cstart64.S
>>> @@ -92,37 +92,19 @@ memsetxc:
>>>    
>>>    .section .text
>>>    pgm_int:
>>> -	SAVE_REGS_STACK
>>> -	lgr     %r2, %r15
>>> -	brasl	%r14, handle_pgm_int
>>> -	RESTORE_REGS_STACK
>>> -	lpswe	GEN_LC_PGM_OLD_PSW
>>> +	CALL_INT_HANDLER handle_pgm_int, GEN_LC_PGM_OLD_PSW
>>>    
>>>    ext_int:
>>> -	SAVE_REGS_STACK
>>> -	lgr     %r2, %r15
>>> -	brasl	%r14, handle_ext_int
>>> -	RESTORE_REGS_STACK
>>> -	lpswe	GEN_LC_EXT_OLD_PSW
>>> +	CALL_INT_HANDLER handle_ext_int, GEN_LC_EXT_OLD_PSW
>>>    
>>>    mcck_int:
>>> -	SAVE_REGS_STACK
>>> -	brasl	%r14, handle_mcck_int
>>> -	RESTORE_REGS_STACK
>>> -	lpswe	GEN_LC_MCCK_OLD_PSW
>>> +	CALL_INT_HANDLER handle_mcck_int, GEN_LC_MCCK_OLD_PSW
>>>    
>>>    io_int:
>>> -	SAVE_REGS_STACK
>>> -	lgr     %r2, %r15
>>> -	brasl	%r14, handle_io_int
>>> -	RESTORE_REGS_STACK
>>> -	lpswe	GEN_LC_IO_OLD_PSW
>>> +	CALL_INT_HANDLER handle_io_int, GEN_LC_IO_OLD_PSW
>>>    
>>>    svc_int:
>>> -	SAVE_REGS_STACK
>>> -	brasl	%r14, handle_svc_int
>>> -	RESTORE_REGS_STACK
>>> -	lpswe	GEN_LC_SVC_OLD_PSW
>>> +	CALL_INT_HANDLER handle_svc_int, GEN_LC_SVC_OLD_PSW
>>>    
>>>    	.align	8
>>>    initial_psw:
>>> diff --git a/s390x/macros.S b/s390x/macros.S
>>> index a7d62c6f..212a3823 100644
>>> --- a/s390x/macros.S
>>> +++ b/s390x/macros.S
>>> @@ -11,6 +11,23 @@
>>>     *  David Hildenbrand <david@redhat.com>
>>>     */
>>>    #include <asm/asm-offsets.h>
>>> +/*
>>> + * Exception handler macro that saves registers on the stack,
>>> + * allocates stack space and calls the C handler function. Afterwards
>>> + * we re-load the registers and load the old PSW.
>>> + */
>>> +	.macro CALL_INT_HANDLER c_func, old_psw
>>> +	SAVE_REGS_STACK
>>> +	/* Save the stack address in GR2 which is the first function argument */
>>> +	lgr     %r2, %r15
>>> +	/* Allocate stack pace for called C function, as specified in s390 ELF ABI */
>>> +	slgfi   %r15, 160
>>
>> By the way, don't you have to store a back chain pointer at the bottom of
>> that area, too, if you want to use -mbackchoin in the next patch?
> 
> Don't I already do that in #2?

You do it in the SAVE_REGS_STACK patch, yes. But not on the bottom of the 
new 160 bytes stack frame that you've added here. But I guess it doesn't 
really matter for your back traces, since you load %r2 with %r15 before 
decrementing the stack by 160, so this new stack frame simply gets ignored 
anyway.

  Thomas

