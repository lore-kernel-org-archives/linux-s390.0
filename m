Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB16C4332F
	for <linux-s390@archiver.kernel.org>; Tue,  4 Oct 2022 08:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiJDIRj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 4 Oct 2022 04:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiJDIRN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Oct 2022 04:17:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60037EE19
        for <linux-s390@vger.kernel.org>; Tue,  4 Oct 2022 01:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664871392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s1Ke6vWjy6sZVOxZDv/F68Ltu/tjCrJKJ2xupBwFw+g=;
        b=dnUwHWqQuEzMltbTiJ20NAN4dSg15LR1GH3+1ANcZkgsb9nRYgQFwwji2M//NYUVNUm/09
        MPknuTiZS0C6UoSlUpxbMPjoO2pOfYVwjZfFvOE3KeH/1n5URN+/20wBm9edGpXtSZpMcG
        AIE5vrCgWe52ag949FNqPIHgiFoRp0o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-206-rLW5iY9dN12RhJ8ASB1mEw-1; Tue, 04 Oct 2022 04:16:31 -0400
X-MC-Unique: rLW5iY9dN12RhJ8ASB1mEw-1
Received: by mail-wr1-f72.google.com with SMTP id u20-20020adfc654000000b0022cc05e9119so3761247wrg.16
        for <linux-s390@vger.kernel.org>; Tue, 04 Oct 2022 01:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=s1Ke6vWjy6sZVOxZDv/F68Ltu/tjCrJKJ2xupBwFw+g=;
        b=FLyZv3PPQlwh0IQ9o7/NEkrcKkdNOqyK3S6yV2zxxP13JJZSZAisF1h+WATMKMt8IQ
         THf5fFdBMlOCp+kObSNv+uHe4gwlPX/xYyYG6K48vh8dwlcZqzXoD1z5uRRVj4pZIUsf
         TAdErfy8SW1DbAI3TYlB4PFQQt9bct93qagEjdBB8n0lHJ2PJnrPcIA04mFvk9HfKp1e
         HhWhaS4gmeft+llvkfuG+wDqaZUQADvTCYfqg3dsfPXvp7/0ah9g2c4jyH6bgeD1j4hl
         SENGvMZhOMC6noLw98U5gKTK8jkhwPqr9r9ztIZJPxgJxHrGIWfS4gE68VGIG4S9a/MQ
         pPqA==
X-Gm-Message-State: ACrzQf3cqSTZyR0c1uyBucI/3yC8d6SLMx40ZKAX7wUSjxRdM2PM4E1N
        O2IV7iIn2c/qPnGV6rpt9/kOoS+J2afYwhQ5u8uMY9NszqDjv+93homUvznjgcF1+3zVhIEme7V
        4uarSoJoJsdMfTHhlVGiYdg==
X-Received: by 2002:a05:600c:6026:b0:3b5:b00:3a5a with SMTP id az38-20020a05600c602600b003b50b003a5amr9273962wmb.108.1664871388230;
        Tue, 04 Oct 2022 01:16:28 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6AJR6ZKmOGetRSwFQXSiNVHL4YhpjeY5FFbBcjgQ7eWf8MFgd+CX5i7tPqgGgSKXx9pV9qqg==
X-Received: by 2002:a05:600c:6026:b0:3b5:b00:3a5a with SMTP id az38-20020a05600c602600b003b50b003a5amr9273945wmb.108.1664871388035;
        Tue, 04 Oct 2022 01:16:28 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-178-246.web.vodafone.de. [109.43.178.246])
        by smtp.gmail.com with ESMTPSA id b4-20020a05600003c400b0022a3a887ceasm11990805wrg.49.2022.10.04.01.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 01:16:27 -0700 (PDT)
Message-ID: <85399389-9b5a-d72a-5db1-b8418008ad58@redhat.com>
Date:   Tue, 4 Oct 2022 10:16:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1 3/9] Documentation: KVM: s390: Describe
 KVM_S390_MEMOP_F_CMPXCHG
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
References: <20220930210751.225873-1-scgl@linux.ibm.com>
 <20220930210751.225873-4-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220930210751.225873-4-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 30/09/2022 23.07, Janis Schoetterl-Glausch wrote:
> Describe the semantics of the new KVM_S390_MEMOP_F_CMPXCHG flag for
> absolute vm write memops which allows user space to perform (storage key
> checked) cmpxchg operations on guest memory.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>   Documentation/virt/kvm/api.rst | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index abd7c32126ce..0e02d66e38ae 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -3771,6 +3771,7 @@ Parameters are specified via the following structure::
>   		struct {
>   			__u8 ar;	/* the access register number */
>   			__u8 key;	/* access key, ignored if flag unset */

Padding / alignment?

> +			__u64 old[2];	/* ignored if flag unset */
>   		};
>   		__u32 sida_offset; /* offset into the sida */
>   		__u8 reserved[32]; /* ignored */
> @@ -3853,8 +3854,23 @@ Absolute accesses are permitted for non-protected guests only.
>   Supported flags:
>     * ``KVM_S390_MEMOP_F_CHECK_ONLY``
>     * ``KVM_S390_MEMOP_F_SKEY_PROTECTION``
> +  * ``KVM_S390_MEMOP_F_CMPXCHG``
> +
> +The semantics of the flags common with logical acesses are as for logical accesses.
> +
> +For write accesses, the KVM_S390_MEMOP_F_CMPXCHG might be supported.
> +In this case, instead of doing an unconditional write, the access occurs only
> +if the target location contains the value provided in "old". This is performed
> +as an atomic cmpxchg. "size" must be a power of two up to and including 16.
> +Values with sizes <8 byte are to be provided by assignment to "old[1]".
> +Doublewords are provided with the higher value word in "old[0]" and the lower
> +word in "old[1]".
> +The value at the target location is returned in "old", encoded in the same manner.
> +If the value was exchanged the KVM_S390_MEMOP_F_CMPXCHG bit in "flags" is set to
> +0, otherwise it remains set.
> +The KVM_S390_MEMOP_F_CMPXCHG flag is supported if KVM_CAP_S390_MEM_OP_EXTENSION
> +has bit 1 (i.e. bit with value 2) set.

Please try to fit the text within 80 columns.

  Thanks,
   Thomas

