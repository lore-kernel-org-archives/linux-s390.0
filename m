Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC10FC48BE8
	for <linux-s390@archiver.kernel.org>; Mon, 14 Jun 2021 09:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE4AA611CA
	for <linux-s390@archiver.kernel.org>; Mon, 14 Jun 2021 09:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbhFNJDz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 14 Jun 2021 05:03:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34162 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232528AbhFNJDy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Jun 2021 05:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623661309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vu71pFISFQB26ccLvg0CQj6wZuEmNrd515lFL21+3Sk=;
        b=WobfIq10qMms42sG/s84lb6csi4G5yTA82ioBir147YiZ80LPG9BimgfWFHXTNwB5fB8nw
        5KkKcoy+hS3/PV7OjWVkEFAIzI/EljqSz/DWQagFCbtEBjRpLccR2lljgphDMMLTuYx77W
        2tYNwWgg1g3MF/uCW0WY5m5tJqZVRO4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-Kl1ASH5fPG-jyiCrQgzl4A-1; Mon, 14 Jun 2021 05:01:47 -0400
X-MC-Unique: Kl1ASH5fPG-jyiCrQgzl4A-1
Received: by mail-ed1-f72.google.com with SMTP id y7-20020aa7ce870000b029038fd7cdcf3bso19834699edv.15
        for <linux-s390@vger.kernel.org>; Mon, 14 Jun 2021 02:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vu71pFISFQB26ccLvg0CQj6wZuEmNrd515lFL21+3Sk=;
        b=les/rYwInLC491j6csMT53FykP9ZpNzCOYFkQT66mncb2W+tzFGfx+BSKnup19ExiO
         6IGaDUvXHnFW1pqnYhpLV/IrEtMmByYxxRPv+rF5swtVzUicIgu5PAR3PeAAhM6iYoM+
         C6URYQA11kW6T4jiHOW82nNV73TtDan812dbGktFPWqL+4cHDS+R6FcIbHoUJt19uWjK
         1X+8lAP79UrfkiodOW+xd2VUSB2KoienNCCIARS3aGEkHv0vwwL5xpUqHYr6eqO5pco7
         wIL4h/EKrGL5pODnQleLNLSTii8dgnCNA5h34Uj8RFk0JHPQWTRVs1ckyWn+CsfbiPXd
         TkGw==
X-Gm-Message-State: AOAM5315zC1jEZ/Y4RdH5uQofQf+sfc4krcKa73ZWW73KmKPmmESJJDX
        EqNKe8jq8DfROewAgCJjG0bFMgsol9ZsLb/cEwfccI5wdsS4ltq5NH86L8Awl13wyovwLVGtuaX
        j722YIE8tfiX4ChSdT5mkUg==
X-Received: by 2002:a17:906:919:: with SMTP id i25mr13807852ejd.171.1623661306862;
        Mon, 14 Jun 2021 02:01:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+fLbnuHGety/JfKAcniNuROzvJXDxZM4MObP9ZDsQ/Xs26Tw0DmHFHnS/gasdb1Ql3S2RTg==
X-Received: by 2002:a17:906:919:: with SMTP id i25mr13807831ejd.171.1623661306669;
        Mon, 14 Jun 2021 02:01:46 -0700 (PDT)
Received: from gator.home (cst2-174-132.cust.vodafone.cz. [31.30.174.132])
        by smtp.gmail.com with ESMTPSA id h22sm8094337edv.0.2021.06.14.02.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 02:01:46 -0700 (PDT)
Date:   Mon, 14 Jun 2021 11:01:44 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        Laurent Vivier <lvivier@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        kvmarm@lists.cs.columbia.edu, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [kvm-unit-tests PATCH v2 1/7] README.md: add guideline for
 header guards format
Message-ID: <20210614090144.q76g5mgmuno47snj@gator.home>
References: <20210609143712.60933-1-cohuck@redhat.com>
 <20210609143712.60933-2-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609143712.60933-2-cohuck@redhat.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 09, 2021 at 04:37:06PM +0200, Cornelia Huck wrote:
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  README.md | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/README.md b/README.md
> index 24d4bdaaee0d..687ff50d0af1 100644
> --- a/README.md
> +++ b/README.md
> @@ -156,6 +156,15 @@ Exceptions:
>  
>    - While the kernel standard requires 80 columns, we allow up to 120.
>  
> +Header guards:
> +
> +Please try to adhere to adhere to the following patterns when adding

Double 'to adhere'

Thanks,
drew

> +"#ifndef <...> #define <...>" header guards:
> +    ./lib:             _HEADER_H_
> +    ./lib/<ARCH>:      _ARCH_HEADER_H_
> +    ./lib/<ARCH>/asm:  _ASMARCH_HEADER_H_
> +    ./<ARCH>:          ARCH_HEADER_H
> +
>  ## Patches
>  
>  Patches are welcome at the KVM mailing list <kvm@vger.kernel.org>.
> -- 
> 2.31.1
> 

