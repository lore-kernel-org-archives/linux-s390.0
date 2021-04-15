Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DB9C433ED
	for <linux-s390@archiver.kernel.org>; Thu, 15 Apr 2021 17:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D7E61184
	for <linux-s390@archiver.kernel.org>; Thu, 15 Apr 2021 17:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhDORCh (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 15 Apr 2021 13:02:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31445 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231549AbhDORCg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 15 Apr 2021 13:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618506132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AIlH6DRtZdL/gylZHFTBxupHs9tLwWR10HxDB9jv7qE=;
        b=BjOyK7HxlNXb3yCWFd9tWhsybEbDct6hPHEwPtUjJV2+Z5o0wJtWXcej4bzGDYEsipLSB+
        C/ZjBf57rvxh/YtsuzmaifDwD2HhbCHgwb4dV4Y5L36O9EUilfFuEG5g39H3mgPu9IiY/v
        xLK5PlaNlwM3NCDrSySLnHDozVQnlJ8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-5jrUNS48NHSCwXzdLP5aDg-1; Thu, 15 Apr 2021 13:02:11 -0400
X-MC-Unique: 5jrUNS48NHSCwXzdLP5aDg-1
Received: by mail-ed1-f71.google.com with SMTP id m18-20020a0564025112b0290378d2a266ebso5519253edd.15
        for <linux-s390@vger.kernel.org>; Thu, 15 Apr 2021 10:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AIlH6DRtZdL/gylZHFTBxupHs9tLwWR10HxDB9jv7qE=;
        b=rwoLi98pp05jSrn/YNPtkeMeU1Ro7Z9UXeWTSv6hhSgPFOhAyPSgiH/hMz8k8l08FT
         4cgJRzSTAeiIcgpc+Y23XQ758sX2Z8Gy3Tq2Zm2dCGZLYQEPRPA29j7FyzTrtWmmVaWQ
         /fDQzZ8VfIDaF9N4ZswcIcdCEqb/xkAI879nd4P/Y3itRO45++YsUFDosLblF1ojyAx/
         RyP3ez+U9hXDgocyYuGsw8TWN8CdL6FSB8/G/z/tay5lwxJIo/Ru1njUZsoqvHDdQTWw
         90Lkg7wmPZHzTQxwUQgOxlEwP7ttWpY4hRYAI9FBh3RGv3qe6ltWfVZl94tresKGgPuk
         oudw==
X-Gm-Message-State: AOAM530NFIB5GktGdUwW6INghxTFp4bLDpohEKHHDnA1hh4PUas3wxql
        29hnzoPgxyKKmIiOH0LrdVvTJxtWmOoUt5ix2HDzNPd0AucV49HDcfDQLniIfBJnDwIlxNZZIPr
        V1ubTdKUKc5wkL6rRss0Q0VZ9d9n3ztiNpVL6YRiajnqEJQHxOblhH1y4k7uGA6H8M1bKfW/TBQ
        ==
X-Received: by 2002:a17:907:1b19:: with SMTP id mp25mr4414632ejc.154.1618506129859;
        Thu, 15 Apr 2021 10:02:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaLY+S5UfPKwgq5AlO7kOuZeMWTVzztYtvhjEBlh08rIyDB4KoToQjdGbkf5ur3ACfS3WLTw==
X-Received: by 2002:a17:907:1b19:: with SMTP id mp25mr4414587ejc.154.1618506129522;
        Thu, 15 Apr 2021 10:02:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id w1sm3023226edt.89.2021.04.15.10.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 10:02:08 -0700 (PDT)
Subject: Re: [GIT PULL 0/7] KVM: s390: Updates for 5.13
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>
References: <20210412160545.231194-1-borntraeger@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <76f5ce85-8e03-ac31-200b-d0bd92cdb9df@redhat.com>
Date:   Thu, 15 Apr 2021 19:02:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210412160545.231194-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 12/04/21 18:05, Christian Borntraeger wrote:
> Paolo,
> 
> only small things for 5.13, one is a fix (with cc stable) consisting of
> multiple patches. I had it running in next for a while since this is
> a pretty complicated area of the architecture but its now good to go.
> 
> The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:
> 
>    Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-5.13-1
> 
> for you to fetch changes up to c3171e94cc1cdcc3229565244112e869f052b8d9:
> 
>    KVM: s390: VSIE: fix MVPG handling for prefixing and MSO (2021-03-24 10:31:55 +0100)
> 
> ----------------------------------------------------------------
> KVM: s390: Updates for 5.13
> 
> - properly handle MVPG in nesting KVM (vsie)
> - allow to forward the yield_to hypercall (diagnose 9c)
> - fixes
> 
> ----------------------------------------------------------------
> Bhaskar Chowdhury (1):
>        KVM: s390: Fix comment spelling in kvm_s390_vcpu_start()
> 
> Claudio Imbrenda (5):
>        KVM: s390: split kvm_s390_logical_to_effective
>        KVM: s390: extend kvm_s390_shadow_fault to return entry pointer
>        KVM: s390: VSIE: correctly handle MVPG when in VSIE
>        KVM: s390: split kvm_s390_real_to_abs
>        KVM: s390: VSIE: fix MVPG handling for prefixing and MSO
> 
> Pierre Morel (1):
>        KVM: s390: diag9c (directed yield) forwarding
> 
>   Documentation/virt/kvm/s390-diag.rst |  33 +++++++++++
>   arch/s390/include/asm/kvm_host.h     |   1 +
>   arch/s390/include/asm/smp.h          |   1 +
>   arch/s390/kernel/smp.c               |   1 +
>   arch/s390/kvm/diag.c                 |  31 +++++++++-
>   arch/s390/kvm/gaccess.c              |  30 ++++++++--
>   arch/s390/kvm/gaccess.h              |  60 ++++++++++++++-----
>   arch/s390/kvm/kvm-s390.c             |   8 ++-
>   arch/s390/kvm/kvm-s390.h             |   8 +++
>   arch/s390/kvm/vsie.c                 | 109 ++++++++++++++++++++++++++++++++---
>   10 files changed, 250 insertions(+), 32 deletions(-)
> 

Pulled, thanks.

Paolo

