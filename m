Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE02C433F5
	for <linux-s390@archiver.kernel.org>; Mon,  2 May 2022 15:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385905AbiEBPnF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 2 May 2022 11:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385940AbiEBPnC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 May 2022 11:43:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5460813E8A
        for <linux-s390@vger.kernel.org>; Mon,  2 May 2022 08:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651505967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZF1XCSE9BpLbLGqd+aMdN/ixk8WqlQNETxHiBvcFAEo=;
        b=JhJnLMGMXRUFqPuWPlfpL+/87CsMgilQZlcAaLFrb7dvAvNYJiEky92yKpZBYZU5CJ9Qr4
        sjtBQFZryQr/2ujZVhxx6KCFrq8y/jnr1HIaLKjOY1PbsrFswGc1jr4oKE9EqNcvzx1pgu
        SFi5bhGI5nEIObfcn9C2CLeqmzqfWvU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-qVML-aS9NVusQIuy7yPq1A-1; Mon, 02 May 2022 11:39:24 -0400
X-MC-Unique: qVML-aS9NVusQIuy7yPq1A-1
Received: by mail-ej1-f72.google.com with SMTP id i14-20020a17090639ce00b006dabe6a112fso6909891eje.13
        for <linux-s390@vger.kernel.org>; Mon, 02 May 2022 08:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZF1XCSE9BpLbLGqd+aMdN/ixk8WqlQNETxHiBvcFAEo=;
        b=IMGWMh+NeVZ5fLQIAGVtytJvtmgC9d3lKx5kpeYkzLa+AIDVtmFpItEYb5tlTrDefz
         gVqjbMcXuKpuiy73HZAmLciVLg9Uws0uON7KUD8wjMxkfBMblhABhvnhtsCLmdPkKdnz
         XKAauHpfLH72l1CFh7yupBq+6AO3ViPuM49svfxQG0Ay76mZrUtAidoLpokyIV2ALNaD
         lQF5a5pGJVJfghdpr/TZJRVMSjxPaGamfcwUSqIIRR0tloLZj1RRo/qMa0fQjsm8hCYQ
         1bqd+49ZXRBjfhjFftXMfATGsPm1Vv0srMNillSPa4bEKueYkEynQDYp6TprsvmtNmUa
         F16A==
X-Gm-Message-State: AOAM532GBWNDss9NSowAMRoOS+n9b8dob8WgcYiq4X0eme199ks+K8mb
        3kuCCttDalvhbtdPYUZ56cOx2QAXw1cyUc7N9EQP+7BeMp/IvV/Dhe4dgExfM7aGLnVBJQ2E+Vh
        Li2Iu8mysrs4iAT6GSon5vQ==
X-Received: by 2002:a05:6402:e9f:b0:41c:df21:b113 with SMTP id h31-20020a0564020e9f00b0041cdf21b113mr14128537eda.217.1651505963160;
        Mon, 02 May 2022 08:39:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNSW0QoKFTZ8zlcqWylcf7sv1LZgw1iIhvcn7gOPBPlprZOO+eArCO5O1mIvjKJ5ZlcDfxwA==
X-Received: by 2002:a05:6402:e9f:b0:41c:df21:b113 with SMTP id h31-20020a0564020e9f00b0041cdf21b113mr14128524eda.217.1651505962959;
        Mon, 02 May 2022 08:39:22 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id ig11-20020a1709072e0b00b006f3ef214e2dsm3839256ejc.147.2022.05.02.08.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 08:39:22 -0700 (PDT)
Message-ID: <47855c4c-dc85-3ee8-b903-4acf0b94e4a9@redhat.com>
Date:   Mon, 2 May 2022 17:39:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [GIT PULL 0/1] KVM: s390: Fix lockdep issue in vm memop
Content-Language: en-US
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>
References: <20220502153053.6460-1-borntraeger@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220502153053.6460-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 5/2/22 17:30, Christian Borntraeger wrote:
> Paolo,
> 
> one patch that is sitting already too long in my tree (sorry, was out of
> office some days).

Hi Christian,

at this point I don't have much waiting for 5.18.  Feel free to send it 
through the s390 tree.

Paolo

> The following changes since commit 3bcc372c9865bec3ab9bfcf30b2426cf68bc18af:
> 
>    KVM: s390: selftests: Add error memop tests (2022-03-14 16:12:27 +0100)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-5.18-1
> 
> for you to fetch changes up to 4aa5ac75bf79cbbc46369163eb2e3addbff0d434:
> 
>    KVM: s390: Fix lockdep issue in vm memop (2022-03-23 10:41:04 +0100)
> 
> ----------------------------------------------------------------
> KVM: s390: fix lockdep warning in new MEMOP call
> 
> ----------------------------------------------------------------
> Janis Schoetterl-Glausch (1):
>        KVM: s390: Fix lockdep issue in vm memop
> 
>   arch/s390/kvm/kvm-s390.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 

