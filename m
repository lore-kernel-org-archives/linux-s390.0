Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32F5C433EF
	for <linux-s390@archiver.kernel.org>; Wed,  4 May 2022 13:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350385AbiEDNdQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 4 May 2022 09:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350290AbiEDNdP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 May 2022 09:33:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89C6823BEE
        for <linux-s390@vger.kernel.org>; Wed,  4 May 2022 06:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651670978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GtvZ+yOvBlNFv49RVuInDSlpoUJxH/haoA7tigzGHDE=;
        b=eQPhvdvQyMM/Iiv6yqzAlAjiwTLkb5ECToxBJWfcAyUhn4ugqS7jLiEfuGPm86bT2e07xq
        X0cHFXiMcocHK5fHD97J8Ze30TIODefpGGcjYwlYB9bnXObdjpZk1oYwHM92mfkakF1iGR
        8ZKoh48ECO7nAGqe1VQb3+pEMAnAQfQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-ndBwusQzMSaFsjoroN3p6w-1; Wed, 04 May 2022 09:29:37 -0400
X-MC-Unique: ndBwusQzMSaFsjoroN3p6w-1
Received: by mail-wr1-f71.google.com with SMTP id l7-20020adfbd87000000b0020ac0a4d23dso373717wrh.17
        for <linux-s390@vger.kernel.org>; Wed, 04 May 2022 06:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GtvZ+yOvBlNFv49RVuInDSlpoUJxH/haoA7tigzGHDE=;
        b=AhKc42ir0HXLmo+7m2mq5RX8/sys2WtwGJigfmjRzA1XRkVPKMS9dAYS9xdcbjipTH
         kHSI3RiGM1tFiOvwavd3YeOmVIlbqa6dWxwdRkbfJkmvXJmLts1dlf8snzueugPKdAb7
         WOv3Y45vSI6/FBrhVoM4L9HtAQHizAmg8/LSZqagJp+rT5kxzZMaph3apZa73Kyvppip
         VOfNmO0EWb4moPd1dORWFVAxZipldxdw6WS5k336mRIjlLzUbVzUEJwQ3ZO8xlUMt1kq
         IMXkvHSkoOP0CrDaDts4soiaUQNSpDruCU+8exjAS5MpZX1QYqwxYsReOvfWBY/SBaHI
         7KxQ==
X-Gm-Message-State: AOAM533cL1xlaKlX8hElid33aUSSE2MUg9HndTR8HgGbgDCZzhvJLnML
        XvwNmiWDao71NtqaLQAPlqn2Oma0bVgaK4P/23+Qun5DiAsrzjuuWnV+ZaF2Ma6u51ac4YyKHsq
        N+eJZdrEXsM0+ZGQsc+e0pw==
X-Received: by 2002:a5d:4a81:0:b0:207:9abe:2908 with SMTP id o1-20020a5d4a81000000b002079abe2908mr16353541wrq.341.1651670976302;
        Wed, 04 May 2022 06:29:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJys6PzodPjzAmABVijMmkbGoUsXCpEmJNJhIm2rwnXF7F3rIfNmyN+E3HEFa5dVI2+Kns5d3Q==
X-Received: by 2002:a5d:4a81:0:b0:207:9abe:2908 with SMTP id o1-20020a5d4a81000000b002079abe2908mr16353531wrq.341.1651670976064;
        Wed, 04 May 2022 06:29:36 -0700 (PDT)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id h19-20020a1ccc13000000b003942a244ed7sm3849710wmb.28.2022.05.04.06.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 06:29:35 -0700 (PDT)
Message-ID: <7edf256a-1d50-1598-c424-8bef5bc4464d@redhat.com>
Date:   Wed, 4 May 2022 15:29:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [kvm-unit-tests PATCH v7 2/3] s390x: Test effect of storage keys
 on some instructions
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20220502154101.3663941-1-scgl@linux.ibm.com>
 <20220502154101.3663941-3-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220502154101.3663941-3-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 02/05/2022 17.41, Janis Schoetterl-Glausch wrote:
> Some instructions are emulated by KVM. Test that KVM correctly emulates
> storage key checking for two of those instructions (STORE CPU ADDRESS,
> SET PREFIX).
> Test success and error conditions, including coverage of storage and
> fetch protection override.
> Also add test for TEST PROTECTION, even if that instruction will not be
> emulated by KVM under normal conditions.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>   lib/s390x/asm/arch_def.h |  20 ++--
>   s390x/skey.c             | 249 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 260 insertions(+), 9 deletions(-)
Acked-by: Thomas Huth <thuth@redhat.com>

