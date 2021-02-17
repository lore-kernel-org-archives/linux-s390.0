Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B42AC433E0
	for <linux-s390@archiver.kernel.org>; Wed, 17 Feb 2021 16:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4239764E33
	for <linux-s390@archiver.kernel.org>; Wed, 17 Feb 2021 16:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbhBQQw1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 17 Feb 2021 11:52:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43870 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233694AbhBQQw0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Feb 2021 11:52:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613580660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4yr23+5m8x5zB27/gTLXl1w4PAs5mRGVC64CTwqvH5Q=;
        b=efy6LCArN9IJQOwqNp6BiN5hxQ5CqK4Sf8Hb7GrYanhi7hlFb3lQ/rhLdXjekrf89pQ2pq
        /SWxK7OL6oAuMAlKhL7GVVs8dYK3QO+PVgdWsqnonKA6e+yqn3Sg2XNUaj1aanR4YzGloz
        zLypvyrZzpBKDG2GwikUtt/VbYkDdo0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-FwF0EOk9PWi6i2GXyWPQtQ-1; Wed, 17 Feb 2021 11:50:58 -0500
X-MC-Unique: FwF0EOk9PWi6i2GXyWPQtQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA5CD874983;
        Wed, 17 Feb 2021 16:50:56 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-116.ams2.redhat.com [10.36.112.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D30760C6D;
        Wed, 17 Feb 2021 16:50:50 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v2 8/8] s390x: Remove SAVE/RESTORE_stack
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        pmorel@linux.ibm.com, david@redhat.com
References: <20210217144116.3368-1-frankja@linux.ibm.com>
 <20210217144116.3368-9-frankja@linux.ibm.com>
 <4fd224a2-1c4d-1663-6615-685eadcf81f6@redhat.com>
 <bd386faf-c635-970a-6be8-659f5f6b4ba8@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <12198726-590c-7ac8-2b89-115d658ad367@redhat.com>
Date:   Wed, 17 Feb 2021 17:50:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <bd386faf-c635-970a-6be8-659f5f6b4ba8@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 17/02/2021 17.46, Janosch Frank wrote:
> On 2/17/21 5:18 PM, Thomas Huth wrote:
>> On 17/02/2021 15.41, Janosch Frank wrote:
>>> There are no more users.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>>> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>>    s390x/macros.S | 29 -----------------------------
>>>    1 file changed, 29 deletions(-)
>>>
>>> diff --git a/s390x/macros.S b/s390x/macros.S
>>> index 212a3823..399a87c6 100644
>>> --- a/s390x/macros.S
>>> +++ b/s390x/macros.S
>>> @@ -28,35 +28,6 @@
>>>    	lpswe	\old_psw
>>>    	.endm
>>>    
>>> -	.macro SAVE_REGS
>>> -	/* save grs 0-15 */
>>> -	stmg	%r0, %r15, GEN_LC_SW_INT_GRS
>>> -	/* save crs 0-15 */
>>> -	stctg	%c0, %c15, GEN_LC_SW_INT_CRS
>>> -	/* load a cr0 that has the AFP control bit which enables all FPRs */
>>> -	larl	%r1, initial_cr0
>>> -	lctlg	%c0, %c0, 0(%r1)
>>> -	/* save fprs 0-15 + fpc */
>>> -	la	%r1, GEN_LC_SW_INT_FPRS
>>> -	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
>>> -	std	\i, \i * 8(%r1)
>>> -	.endr
>>> -	stfpc	GEN_LC_SW_INT_FPC
>>> -	.endm
>>> -
>>> -	.macro RESTORE_REGS
>>> -	/* restore fprs 0-15 + fpc */
>>> -	la	%r1, GEN_LC_SW_INT_FPRS
>>> -	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
>>> -	ld	\i, \i * 8(%r1)
>>> -	.endr
>>> -	lfpc	GEN_LC_SW_INT_FPC
>>
>> Could we now also remove the sw_int_fprs and sw_int_fpc from the lowcore?
>>
>>    Thomas
>>
> 
> git grep tells me that we can.
> Do you want to have both the offset macro and the struct member removed
> or only the macro?

I'd remove both.

  Thomas

