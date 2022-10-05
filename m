Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651E7C433FE
	for <linux-s390@archiver.kernel.org>; Wed,  5 Oct 2022 06:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiJEG1n (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 5 Oct 2022 02:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiJEG1m (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Oct 2022 02:27:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37714733D1
        for <linux-s390@vger.kernel.org>; Tue,  4 Oct 2022 23:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664951260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hzgr+GJhjprVie4kFrMDBNKKq7b6UhoiqIdbK544F4E=;
        b=O6A/xE9WM/x6EHyd3+QY1Rxqm8t24x1nLwSyYIOtv5vqnct1esKuLDi9gaEfXHzRQSvml4
        NV3YsUHEDZdin0J02Zo57WekRDa8mBt2poJX4cLNkDDBHcwB0L7ATbXP0tqPavPayz4Szv
        A9IUqLR3j/fyoPEZ05xlzCe/NiOsPLk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-658-SloAd0JOPxSotHTgZ9L7qQ-1; Wed, 05 Oct 2022 02:27:31 -0400
X-MC-Unique: SloAd0JOPxSotHTgZ9L7qQ-1
Received: by mail-wm1-f70.google.com with SMTP id n32-20020a05600c3ba000b003b5054c71faso519941wms.9
        for <linux-s390@vger.kernel.org>; Tue, 04 Oct 2022 23:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Hzgr+GJhjprVie4kFrMDBNKKq7b6UhoiqIdbK544F4E=;
        b=mp44pBOGuMn4m8eBJ7098Ie6YwXe8DPoJ0cO2TwOKXU5qFyX8+Y6YUVbLTA7Ao6yk+
         6QRzAr/XnB16laqfCHXtz76tYQ4FgGCL8JWiIKIpZMEZZWKeAzDcZrYo1mZWJnjCInTu
         jiLQX9T9tvL9LLYRjbNBnZ4E6CmbHUsm5E7sUP8Wj942QNH5/CYy0Vv5Ex+FudZ3420z
         VzFe778sWcg9Oqgu9105MOlI0hb8fab8XIG83fz3t9JHJqV8GwkuVq9fSA+WssWxKpSm
         snCABPA24pUWCWOzvEUgOYUtoyRBRq/ehL+GAi54o5Ww13zz0IXWC7b6ylyNuVb0cnNr
         YjEA==
X-Gm-Message-State: ACrzQf0z2N2pvewnt9ZEsGIgpftQ6/OY1qhtOnYpwLlowwHtLHWlD1Tn
        t5FUUMHwMiOj4ARFhzBlEPry082034zHAGRBEVK2mjljjB76XO2iZb4o44rI5Y+LFzWpgRAhjPK
        xZe4rlE5qwox7v2NrdiyY8A==
X-Received: by 2002:a5d:6dac:0:b0:22a:fbff:b2d3 with SMTP id u12-20020a5d6dac000000b0022afbffb2d3mr17477369wrs.543.1664951250884;
        Tue, 04 Oct 2022 23:27:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM51k5PL/MMj9nNisaw28ILfu80lWeQorWwHNn3p0/GD+K8Uowfp7d1JM62SxQHy7Gip404Y4Q==
X-Received: by 2002:a5d:6dac:0:b0:22a:fbff:b2d3 with SMTP id u12-20020a5d6dac000000b0022afbffb2d3mr17477361wrs.543.1664951250690;
        Tue, 04 Oct 2022 23:27:30 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-249.web.vodafone.de. [109.43.177.249])
        by smtp.gmail.com with ESMTPSA id r6-20020a5d4986000000b0022ccae2fa62sm2068711wrq.22.2022.10.04.23.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 23:27:29 -0700 (PDT)
Message-ID: <69854d56-510c-dab0-7cd6-f593ae2bef14@redhat.com>
Date:   Wed, 5 Oct 2022 08:27:26 +0200
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
References: <20220930210751.225873-1-scgl@linux.ibm.com>
 <20220930210751.225873-4-scgl@linux.ibm.com>
 <85399389-9b5a-d72a-5db1-b8418008ad58@redhat.com>
 <dca9e17ffbe71c76665ba25a6d9cd91d4aa0c329.camel@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v1 3/9] Documentation: KVM: s390: Describe
 KVM_S390_MEMOP_F_CMPXCHG
In-Reply-To: <dca9e17ffbe71c76665ba25a6d9cd91d4aa0c329.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 04/10/2022 20.51, Janis Schoetterl-Glausch wrote:
> On Tue, 2022-10-04 at 10:16 +0200, Thomas Huth wrote:
>> On 30/09/2022 23.07, Janis Schoetterl-Glausch wrote:
>>> Describe the semantics of the new KVM_S390_MEMOP_F_CMPXCHG flag for
>>> absolute vm write memops which allows user space to perform (storage key
>>> checked) cmpxchg operations on guest memory.
>>>
>>> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
>>> ---
>>>    Documentation/virt/kvm/api.rst | 18 +++++++++++++++++-
>>>    1 file changed, 17 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>>> index abd7c32126ce..0e02d66e38ae 100644
>>> --- a/Documentation/virt/kvm/api.rst
>>> +++ b/Documentation/virt/kvm/api.rst
>>> @@ -3771,6 +3771,7 @@ Parameters are specified via the following structure::
>>>    		struct {
> 
> What is the reason you initially didn't copy the /* in */ comment here?

You mean in commit 41408c28f283b ? Uh, don't ask me, that's more than 7 
years ago...

Anyway, please be aware that the MEMOP ioctl is defined as IOW only:

#define KVM_S390_MEM_OP _IOW(KVMIO, 0xb1, struct kvm_s390_mem_op)

... so if you now introduce an "out" field in that struct, this might have 
some impact, e.g. on Valgrind etc.

  Thomas

