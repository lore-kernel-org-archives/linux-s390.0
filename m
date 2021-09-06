Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570D3C433F5
	for <linux-s390@archiver.kernel.org>; Mon,  6 Sep 2021 10:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33D2F61051
	for <linux-s390@archiver.kernel.org>; Mon,  6 Sep 2021 10:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbhIFKgy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 6 Sep 2021 06:36:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45467 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231174AbhIFKgy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Sep 2021 06:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630924549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g68PpF6+mUXROjTFT/pPvYK23nXqxvx0vraJdLoo7FI=;
        b=BkKFCp6oV3oCBx21SoP/AZUYvBK+hv4G5hlFuxGbIND2e6zu6CooQLqrKgSHPweOJ9E7mO
        nt2Vh0mceHagtDqkybd9NSNHUL4xjsZGvwJ9aUUN/6NfJBzx2KoGCQ3/qVHOMs08eDv2Ut
        T23OkndCI52kGkEOXK2Ptzqp3MV5Yh0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-KqOhg8kKOpusXL5JDKWHcQ-1; Mon, 06 Sep 2021 06:35:48 -0400
X-MC-Unique: KqOhg8kKOpusXL5JDKWHcQ-1
Received: by mail-ej1-f71.google.com with SMTP id c25-20020a170906529900b005c56c92caa2so2143858ejm.19
        for <linux-s390@vger.kernel.org>; Mon, 06 Sep 2021 03:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g68PpF6+mUXROjTFT/pPvYK23nXqxvx0vraJdLoo7FI=;
        b=LhZyXsV7mmlT8RseqzQS/EAOcuF9q5ZCO9L0cJ3fJNXa2QbVRqsNA6ROnrTC2B0nQP
         bWyQ9pu4tvPES6lgfgp00Hcc6vO320jsPzLwDI31Qlmz1UcslP20jMgLp+ykJG720lTt
         ltnJfvitSIU3r1ebNakh9Dg8TDpphbsB94/HACAJjoemso9xdBz9+66uE4AxmAymwFqk
         +hqt1IYGtz90/n7duwrFYzt6vdpNurN66pQAzStTOQJKP4gHNLGtKDyr3MN9jWnZFGnv
         wwBwqrdbSJvsXz4hhwnqVdXFRMKB65yRmV8twj2/upPY+LwrU4CzRUQefGwJoiQpIg6X
         QNEw==
X-Gm-Message-State: AOAM5306ibSa1VYOvMd0C3UASz2o+c4H8FqzGg+s2KHaabim2It/uWAN
        37eVwzo0jQkh2TNJgrcUAK3d98B1FoBCNq1UVhPa3boQWeUkz88nqOywTq7iPKcNhDOkp3CJGwj
        JbhrhjIn4grEC2lkBdSYtZA==
X-Received: by 2002:a17:906:d045:: with SMTP id bo5mr12803962ejb.461.1630924546937;
        Mon, 06 Sep 2021 03:35:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZNrsZgDmccQd/BU46BG1MwpW2PfB4vsAom9LwPHgvfmCBrJ1P4pbixZweCnbZZISN13+LKw==
X-Received: by 2002:a17:906:d045:: with SMTP id bo5mr12803945ejb.461.1630924546767;
        Mon, 06 Sep 2021 03:35:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id c7sm4327202ede.21.2021.09.06.03.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 03:35:46 -0700 (PDT)
Subject: Re: [GIT PULL 0/2] KVM: s390: Fix and feature for 5.15
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>
References: <20210829060121.16702-1-borntraeger@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <70668bcd-b94d-36d1-dffa-af3315f0c60c@redhat.com>
Date:   Mon, 6 Sep 2021 12:35:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210829060121.16702-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 29/08/21 08:01, Christian Borntraeger wrote:
> Paolo,
> 
> sorry for being so late. One feature (enable hardware interpretion of
> specification exceptions) and one fix targeted for stable. Given the
> short runway to 5.14 I decided to let this go via next and not try to
> sneak it into 5.14.
> 
> The following changes since commit 1f703d2cf20464338c3d5279dddfb65ac79b8782:
> 
>    KVM: s390: allow facility 192 (vector-packed-decimal-enhancement facility 2) (2021-06-23 09:35:20 +0200)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-5.15-1
> 
> for you to fetch changes up to a3e03bc1368c1bc16e19b001fc96dc7430573cc8:
> 
>    KVM: s390: index kvm->arch.idle_mask by vcpu_idx (2021-08-27 18:35:41 +0200)
> 
> ----------------------------------------------------------------
> KVM: s390: Fix and feature for 5.15
> 
> - enable interpretion of specification exceptions
> - fix a vcpu_idx vs vcpu_id mixup
> 
> ----------------------------------------------------------------
> Halil Pasic (1):
>        KVM: s390: index kvm->arch.idle_mask by vcpu_idx
> 
> Janis Schoetterl-Glausch (1):
>        KVM: s390: Enable specification exception interpretation
> 
>   arch/s390/include/asm/kvm_host.h |  2 ++
>   arch/s390/kvm/interrupt.c        | 12 ++++++------
>   arch/s390/kvm/kvm-s390.c         |  4 +++-
>   arch/s390/kvm/kvm-s390.h         |  2 +-
>   arch/s390/kvm/vsie.c             |  2 ++
>   5 files changed, 14 insertions(+), 8 deletions(-)
> 

Pulled now, thanks!

Paolo

