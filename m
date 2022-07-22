Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C072C43334
	for <linux-s390@archiver.kernel.org>; Fri, 22 Jul 2022 07:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbiGVHRz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 22 Jul 2022 03:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbiGVHRi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 22 Jul 2022 03:17:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CF6BE1E
        for <linux-s390@vger.kernel.org>; Fri, 22 Jul 2022 00:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658474240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y3mN1YY4ZaFhdmgTg9aJTQx2Ag2kI0nqfLpirIW7BV8=;
        b=jBmZT/BwbxxMfG+QPXlwvKSaiwg0Z5e/DpMHL4Igez+rQDpjUrPF/7A2N2P0ea3UghQIuJ
        dIr7uhl4CTEkvOJOOCCzWve29+HRU9D8QGPSZXXeYpEfIGSOGSoCNoWZtpX97u7Uweiqxd
        ODnkztf2ykN/jn6RutUo11pdLP3QOZM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-vBZixIh6OxeSQNSvJYSpkA-1; Fri, 22 Jul 2022 03:17:16 -0400
X-MC-Unique: vBZixIh6OxeSQNSvJYSpkA-1
Received: by mail-wr1-f71.google.com with SMTP id h6-20020adfaa86000000b0021e47bcbc6dso702116wrc.16
        for <linux-s390@vger.kernel.org>; Fri, 22 Jul 2022 00:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y3mN1YY4ZaFhdmgTg9aJTQx2Ag2kI0nqfLpirIW7BV8=;
        b=TBacDyUN8DF1StppvU5Peb1Iw8oWW+VDz6LI5ubEL3d2GQMVYOWhsHqFEXRiGYBp9K
         H8GTYUgUl3MHZl4Ri3IggAqHZsS6d7Ke+uEgM4RuOv9BodUPrdEWNg0/S0M7ZbGHtLYH
         1gUtkEpLQuDWUN0D6WIulfMzVx3v3Ci35Wy+NOH1hirrDyoetBfBbvB6PWyBU40OMmmh
         d6LiHJ7fTFEWI0R0xx0NYEqNaggM7zTQyZj5L5JIlNjKbvrvuN6cWOrTRH5ih/l2rQ6k
         2dimMb6t9bObP7sSrlDr3fGUUqys1jY+u8ttQaPVSeKbJeFtbXFAcY6DVQo1u5M5c4L4
         h4PQ==
X-Gm-Message-State: AJIora/omyDxcdqPs0YDJ/Erfh0qzQIDlkW/qihIfaSQLtGZBk5D1OeZ
        8ndniBI+p2HbGeVgW+jCWsOCebsRRKILzAiyN9OA8lMGelZNi9Dyji4jGcCxvibdqnPvWuQi0nZ
        tn9oFXMWTOFI9XUkcQJY+RA==
X-Received: by 2002:a1c:4c14:0:b0:3a3:ad5:62e7 with SMTP id z20-20020a1c4c14000000b003a30ad562e7mr1448998wmf.114.1658474235033;
        Fri, 22 Jul 2022 00:17:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tPTyl/0KPtnxpM59gT1P2wf7MdYT49hZ3DI5epWHqeeMrpGzMjlP2WihM+i69WoMbaVGkyig==
X-Received: by 2002:a1c:4c14:0:b0:3a3:ad5:62e7 with SMTP id z20-20020a1c4c14000000b003a30ad562e7mr1448946wmf.114.1658474234518;
        Fri, 22 Jul 2022 00:17:14 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id o5-20020a05600c4fc500b003a03185231bsm4350514wmq.31.2022.07.22.00.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 00:17:13 -0700 (PDT)
Message-ID: <4caa1fb2-febd-22e5-54b7-dababe63ae15@redhat.com>
Date:   Fri, 22 Jul 2022 09:17:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL 00/42] KVM: s390: PCI, CPU topology, PV features
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        thuth@redhat.com, david@redhat.com
References: <20220721161302.156182-1-imbrenda@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220721161302.156182-1-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 7/21/22 18:12, Claudio Imbrenda wrote:
> Hi Paolo,
> 
> today you are getting the pull request from me :)

I'll trust you. :)

> this request has:
> 
> * First part of deferred teardown (Claudio)
> * CPU Topology (Pierre)
> * interpretive execution for PCI instructions (Matthew)
> * PV attestation (Steffen)
> * Minor fixes
> 
> 
> Please pull
> 
> 
> The following changes since commit 4b88b1a518b337de1252b8180519ca4c00015c9e:
> 
>    KVM: selftests: Enhance handling WRMSR ICR register in x2APIC mode (2022-06-24 04:52:04 -0400)
> 
> are available in the Git repository at:
> 
>    ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-next-5.20-1

Pulled, but you need to setup separate remote.*.url and remote.*.pushurl 
configuration for git-request-pull to work.

Thanks,

Paolo

