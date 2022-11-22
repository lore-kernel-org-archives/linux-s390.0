Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4484C433FE
	for <linux-s390@archiver.kernel.org>; Tue, 22 Nov 2022 07:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbiKVHsd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 22 Nov 2022 02:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiKVHsa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 22 Nov 2022 02:48:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A923206F
        for <linux-s390@vger.kernel.org>; Mon, 21 Nov 2022 23:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669103242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EOlyqNEjSyWRhu789TgVJBojhnd7QCjs246Hat/OGCs=;
        b=Oeb3eSXDahcKQEomPyxeQD8Q0LnB/5EPm7idAHLvxhft8gxmU3e9uKGU9MRP37NHfG9NJ2
        y5hhPSDwjWteQrpBWpEFNJFRbfNlrs2LkLFWAZBjQBw9Xif70hHDqfqPy5zWKOp/gLNLKt
        YZXXhKKJ05NI/Ot+DduaWn1wNCxEu8Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-224-xyGKoqYzOIqAqkY1RlRolA-1; Tue, 22 Nov 2022 02:47:21 -0500
X-MC-Unique: xyGKoqYzOIqAqkY1RlRolA-1
Received: by mail-wr1-f69.google.com with SMTP id w11-20020adfbacb000000b002418a90da01so3941981wrg.16
        for <linux-s390@vger.kernel.org>; Mon, 21 Nov 2022 23:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EOlyqNEjSyWRhu789TgVJBojhnd7QCjs246Hat/OGCs=;
        b=Pm6R8mW6ncQv7CuzcKw3L7LAY8gziRuCncCBnaqRx0WZncx30P5/IZoVkPdLi9a8W2
         lrYO9YiahCsp1oBFBXWVRMfCWFYCOO/XYUA6oJljtOEipn1I/inAIRBoczLLrFeZKgos
         oqa5I/0/w+zb8RI0LWX4TNkd43V1ZvFrKMxORyeJn+mxHPQ+rGJbnrVjUFSZGW6amvDA
         WlncVqQNOSkaac6m2+roOdSFjJ1saVWgeTtelegqEqW+TVan41moDabRbyd0tuTDj6JW
         jMPkTCgzWmc42Ld3mYo8fXL16pFerNmaBmx6AFWucA/pA00udr78bwqWB+tiTACCRVY7
         NuAw==
X-Gm-Message-State: ANoB5pkbasV+NtOXJhGwajUgTSg4nMJdhG+G6Pood1bTbVsitKV/kZcX
        UdZEvjzoJKj+Acy1keVopwjIN+0+m2qKlM8mxqnOC2ZMlFERsmPRN4/Rxc+vABe30QXbxgBnoaf
        7klFf8uWJ0nyGpIztm6TS/Q==
X-Received: by 2002:a05:600c:3492:b0:3cf:ad59:1465 with SMTP id a18-20020a05600c349200b003cfad591465mr7757613wmq.12.1669103240155;
        Mon, 21 Nov 2022 23:47:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5qTCZJA4RPHbgTxYLrcLE6vAWROLjIVZidpN6a8sJSfb4cCoT7Ya0f5MC2dVrj3W0Qw/zP0A==
X-Received: by 2002:a05:600c:3492:b0:3cf:ad59:1465 with SMTP id a18-20020a05600c349200b003cfad591465mr7757600wmq.12.1669103239912;
        Mon, 21 Nov 2022 23:47:19 -0800 (PST)
Received: from [192.168.0.5] (ip-109-43-176-72.web.vodafone.de. [109.43.176.72])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c229700b003cf75213bb9sm20150358wmf.8.2022.11.21.23.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 23:47:19 -0800 (PST)
Message-ID: <f96b50e2-24ac-4016-d3f1-ffc375516e7c@redhat.com>
Date:   Tue, 22 Nov 2022 08:47:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20221117221758.66326-1-scgl@linux.ibm.com>
 <20221117221758.66326-3-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 2/9] Documentation: KVM: s390: Describe
 KVM_S390_MEMOP_F_CMPXCHG
In-Reply-To: <20221117221758.66326-3-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 17/11/2022 23.17, Janis Schoetterl-Glausch wrote:
> Describe the semantics of the new KVM_S390_MEMOP_F_CMPXCHG flag for
> absolute vm write memops which allows user space to perform (storage key
> checked) cmpxchg operations on guest memory.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
...
>   Supported flags:
>     * ``KVM_S390_MEMOP_F_CHECK_ONLY``
>     * ``KVM_S390_MEMOP_F_SKEY_PROTECTION``
> +  * ``KVM_S390_MEMOP_F_CMPXCHG``
> +
> +The semantics of the flags common with logical acesses are as for logical
> +accesses.
> +
> +For write accesses, the KVM_S390_MEMOP_F_CMPXCHG might be supported.

I'd maybe merge this with the last sentence:

For write accesses, the KVM_S390_MEMOP_F_CMPXCHG flag is supported if 
KVM_CAP_S390_MEM_OP_EXTENSION has bit 1 (i.e. bit with value 2) set.

... and speaking of that, I wonder whether it's maybe a good idea to 
introduce some #defines for bit 1 / value 2, to avoid the confusion ?

> +In this case, instead of doing an unconditional write, the access occurs only
> +if the target location contains the "size" byte long value pointed to by
> +"old_p". This is performed as an atomic cmpxchg.

I had to read the first sentence twice to understand it ... maybe it's 
easier to understand if you move the "size" part to the second sentence:

In this case, instead of doing an unconditional write, the access occurs 
only if the target location contains value pointed to by "old_p". This is 
performed as an atomic cmpxchg with the length specified by the "size" 
parameter.

?

> "size" must be a power of two
> +up to and including 16.
> +The value at the target location is written to the location "old_p" points to.

IMHO something like this would be better:

The value at the target location is replaced with the value from the 
location that "old_p" points to.

> +If the exchange did not take place because the target value doesn't match the
> +old value KVM_S390_MEMOP_R_NO_XCHG is returned.
> +The KVM_S390_MEMOP_F_CMPXCHG flag is supported if KVM_CAP_S390_MEM_OP_EXTENSION
> +has bit 1 (i.e. bit with value 2) set.

  Thomas

PS: Please take my suggestions with a grain of salt ... I'm not a native 
speaker either.

