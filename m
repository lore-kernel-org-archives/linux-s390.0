Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AF5C2B9F4
	for <linux-s390@archiver.kernel.org>; Fri, 25 Jun 2021 12:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8C3B61623
	for <linux-s390@archiver.kernel.org>; Fri, 25 Jun 2021 12:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhFYMFZ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 25 Jun 2021 08:05:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48928 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229586AbhFYMFY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 25 Jun 2021 08:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624622583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ymzKOG7eCmS27NIB4fnpa2DO5eLRbqnm64rtjBcqss=;
        b=WruhGGbsa+Ke+7CgqkXH33nNYt8rPWGu/HaoKB6eO1vQmUliZh20j99gIRhPjbQMTOfIVr
        gL0WSPkx8XMMmXiL0WHEgXgQK/yH3hsVfUMFvqrOs5MMwET5Ix3HF17ZQFABCKeRhLO4Z6
        3g0nrAi86o/A1YW1nEQcLNdKAMo9yMw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-5a_adLwvOaiA0XfkETBUZA-1; Fri, 25 Jun 2021 08:03:02 -0400
X-MC-Unique: 5a_adLwvOaiA0XfkETBUZA-1
Received: by mail-ej1-f72.google.com with SMTP id lt4-20020a170906fa84b0290481535542e3so3042531ejb.18
        for <linux-s390@vger.kernel.org>; Fri, 25 Jun 2021 05:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4ymzKOG7eCmS27NIB4fnpa2DO5eLRbqnm64rtjBcqss=;
        b=fqx25liXyICaDKu6eCBTUg1arF50IfKdV4emqr1WC0+V1m+iDk3g+9oZbmTnxdF404
         S0MUubxpYlzDvVm/IkklqhrKvaNpJ2I/XvOwV6bEccw0bfrRwupnJ3NWVcToVxZRuppJ
         Z7OtC6rwNlc8Y1HaANFqWcUJeDvRSOhlGHnbRdi+EfTrkQ9CpY/M0AbV3n9SGJaiTsxP
         +dTpU/8mXzNcDiilLTJwLyigEDtjOsfpCPsHuFQdelHeFEQ8FVecCZlq0ccVngLNZNwz
         lq68fl02bYoiUsi5sU7PJQDQSchY6c+WGrr322INqQpatTmvYoGjMeFT5YgTh3Ki4ILl
         Vkfg==
X-Gm-Message-State: AOAM531g7aqnJDP1EUGJNZKF8fgnHOYlzAK3bWjVD2BbBudMOmtCTQgx
        aoKGRiLIFVPML9hVqd/WGGTCBgkW5iqcJlmzFEn1tjl9t/fjTh8nciwfdkSznDjTt3yViNCvXJ0
        xuDaJn+6hWjaL+f9Vjf9wiA==
X-Received: by 2002:a17:906:a28e:: with SMTP id i14mr10337495ejz.395.1624622581256;
        Fri, 25 Jun 2021 05:03:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwraQuO/SrSxwErwpVYMNW0r8W+rMGILi881SIdNMGBp/XVqoUpgwT5/z1mN4s28i2WkEdHeg==
X-Received: by 2002:a17:906:a28e:: with SMTP id i14mr10337470ejz.395.1624622581007;
        Fri, 25 Jun 2021 05:03:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id i10sm3758723edt.25.2021.06.25.05.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 05:03:00 -0700 (PDT)
Subject: Re: [GIT PULL 0/3] KVM: s390: Features and Cleanups for 5.14
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210625112434.12308-1-borntraeger@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <23099284-5b02-e06e-405f-8871b71d8236@redhat.com>
Date:   Fri, 25 Jun 2021 14:02:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210625112434.12308-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 25/06/21 13:24, Christian Borntraeger wrote:
> Paolo,
> 
> only a small amount of patches for 5.14 for KVM on s390.
> 
> The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:
> 
>    Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-5.14-1
> 
> for you to fetch changes up to 1f703d2cf20464338c3d5279dddfb65ac79b8782:
> 
>    KVM: s390: allow facility 192 (vector-packed-decimal-enhancement facility 2) (2021-06-23 09:35:20 +0200)
> 
> ----------------------------------------------------------------
> KVM: s390: Features for 5.14
> 
> - new HW facilities for guests
> - make inline assembly more robust with KASAN and co
> 
> ----------------------------------------------------------------
> Christian Borntraeger (2):
>        KVM: s390: gen_facilities: allow facilities 165, 193, 194 and 196
>        KVM: s390: allow facility 192 (vector-packed-decimal-enhancement facility 2)
> 
> Heiko Carstens (1):
>        KVM: s390: get rid of register asm usage
> 
>   arch/s390/kvm/kvm-s390.c         | 22 +++++++++++++---------
>   arch/s390/tools/gen_facilities.c |  4 ++++
>   2 files changed, 17 insertions(+), 9 deletions(-)
> 

Thanks!  I've already prepared my first pull request for 5.14, but I'll 
merge this soon into kvm.git.

Paolo

