Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9BCC6FA82
	for <linux-s390@archiver.kernel.org>; Fri, 23 Sep 2022 14:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbiIWOLm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Sep 2022 10:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbiIWOLD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 23 Sep 2022 10:11:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9D95F7F3
        for <linux-s390@vger.kernel.org>; Fri, 23 Sep 2022 07:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663942251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JE+EIlOPFCft+jE9XJOi12dnXpSf7LlMF0zSv8qu96g=;
        b=RQZ9d+kFBu+SKTqpivIO1JBFe7IdRMnTQLu0416cHiEa2lNzbfFuBLqDkAR7OPL81hac3W
        cYrUvUDhMujcJJLiQqGIhRfV3RwG4Gx6bFghZmjIT/JuYQFvjBc7jvxT1Mv5zxvuFwpGxL
        yUZB4PMVHOCbmRs1j5fwgm4p6NQyl9w=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-624-WPbOgonmNSKDvZrMLDz5yQ-1; Fri, 23 Sep 2022 10:10:49 -0400
X-MC-Unique: WPbOgonmNSKDvZrMLDz5yQ-1
Received: by mail-ej1-f70.google.com with SMTP id xh12-20020a170906da8c00b007413144e87fso174673ejb.14
        for <linux-s390@vger.kernel.org>; Fri, 23 Sep 2022 07:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JE+EIlOPFCft+jE9XJOi12dnXpSf7LlMF0zSv8qu96g=;
        b=0TGXlnKBEEa2TtMuPylzZmH9CqKPUFD/Qo0vTjoE1mxHL2ytsNlb6TxswN6mykUloM
         taOoAoOvOoU5T85LkusNm2s2TH0iWcORYYorEXq/ROcftMZQ9FO197jk7Vz6eR22fzEc
         P80w2kRA+mkyItd1V3GpWoeXDiEpMLUAZuiDdoE8B6mknlYGcsyECSX7FX5TiBicNeyX
         ZqMffLytD+/kMAam14MLpmKHQu/AE5HQ3hPu9c/L2o6z0+LL2dA9bZYn1iiyPtq9F6kl
         3ns5mM8DjLBoksgGt5Zu7O4OltibrHP3of1o71L9WzJGyoTWRCgj6VeykcILA6/2saJ6
         B8bw==
X-Gm-Message-State: ACrzQf2qbmUY68ZMj2LheSYAO/MiZrkL9pY82r6CnM7afuh60A2QSCHz
        3nHGx4H2liTXo5YOai/uyyJDqXIijw0GsCjYn+yQ4QhTVjUAp0lnC8sKB+8yph4dX+93blYBCPk
        dRamUWX8AG7F5LeNjioxsXg==
X-Received: by 2002:a17:906:8448:b0:77b:e6d0:58a5 with SMTP id e8-20020a170906844800b0077be6d058a5mr7425552ejy.347.1663942248866;
        Fri, 23 Sep 2022 07:10:48 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6hT4TYX7LnQfuYLlQKy4zfmhp9NFBn8+JsHXXnnMqPdIKCCz3lkbwftkSETsvYydZhnMlFpQ==
X-Received: by 2002:a17:906:8448:b0:77b:e6d0:58a5 with SMTP id e8-20020a170906844800b0077be6d058a5mr7425522ejy.347.1663942248570;
        Fri, 23 Sep 2022 07:10:48 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id au7-20020a170907092700b0073cdeedf56fsm4055072ejc.57.2022.09.23.07.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 07:10:48 -0700 (PDT)
Message-ID: <2d618e8c-782c-b122-f4be-618a548645e9@redhat.com>
Date:   Fri, 23 Sep 2022 16:10:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [GIT PULL 0/4] KVM: s390: Fixes for 6.0 take 2
Content-Language: en-US
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, linux-s390@vger.kernel.org,
        imbrenda@linux.ibm.com
References: <20220923120412.15294-1-frankja@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220923120412.15294-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 9/23/22 14:04, Janosch Frank wrote:
> Paolo,
> 
> vfio-pci has kept us busy for a bit so here are three additional pci fixes.
> Additionally there's a smatch fix by Janis.
> 
> It might be a bit late for rc7 but we wanted to have the coverage.

They're in today's linux-next even, and everybody was busy with other 
stuff last week, so it's fine.  Pulled, thanks!

Paolo

> Enjoy the weekend!
> 
> The following changes since commit 521a547ced6477c54b4b0cc206000406c221b4d6:
> 
>    Linux 6.0-rc6 (2022-09-18 13:44:14 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-master-6.0-2
> 
> for you to fetch changes up to 189e7d876e48d7c791fe1c9c01516f70f5621a9f:
> 
>    KVM: s390: pci: register pci hooks without interpretation (2022-09-21 16:18:38 +0200)
> 
> ----------------------------------------------------------------
> More pci fixes
> Fix for a code analyser warning
> ----------------------------------------------------------------
> 
> Janis Schoetterl-Glausch (1):
>    KVM: s390: Pass initialized arg even if unused
> 
> Matthew Rosato (3):
>    KVM: s390: pci: fix plain integer as NULL pointer warnings
>    KVM: s390: pci: fix GAIT physical vs virtual pointers usage
>    KVM: s390: pci: register pci hooks without interpretation
> 
>   arch/s390/kvm/gaccess.c   | 16 +++++++++++++---
>   arch/s390/kvm/interrupt.c |  2 +-
>   arch/s390/kvm/kvm-s390.c  |  4 ++--
>   arch/s390/kvm/pci.c       | 20 ++++++++++++++------
>   arch/s390/kvm/pci.h       |  6 +++---
>   5 files changed, 33 insertions(+), 15 deletions(-)
> 

