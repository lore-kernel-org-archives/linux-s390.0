Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A572C07E96
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jul 2021 08:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F40A96127C
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jul 2021 08:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbhGOIzc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 15 Jul 2021 04:55:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53101 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231726AbhGOIzb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 15 Jul 2021 04:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626339158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kjJcHjl6F1c9c06u+Cty1wPbq2wMQMTR8ijLpEU91MA=;
        b=AtdvEvK5N7ilRrqRkT78mnQ4EJ3S2oU5nrydU9ijSthNJIob/3IKbpr73/jCZuayIiSVgU
        k1lT28gu37T4xOHP3ge3edlAJ9H1p1Z8sCp1sbrWQQYdtrvbQHwTnjzCF+6E3yXW34Uykd
        mGbbw1b8T2uPZxPWdoI7DTxtWdAFDZQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-PWx78MGHOnqixDmPkJhDqQ-1; Thu, 15 Jul 2021 04:52:37 -0400
X-MC-Unique: PWx78MGHOnqixDmPkJhDqQ-1
Received: by mail-wm1-f71.google.com with SMTP id b26-20020a7bc25a0000b0290218757e2783so1519285wmj.7
        for <linux-s390@vger.kernel.org>; Thu, 15 Jul 2021 01:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kjJcHjl6F1c9c06u+Cty1wPbq2wMQMTR8ijLpEU91MA=;
        b=XHbWKj1/fmGoPCWWz7q3aN4TWbffTdSXl/4NOXfx3k70mhhpUjDmybsAuaNZl9ErhI
         O6q8eDMkY+0dfxfZoRDVw+nzYAhCXV0rURPO8tImlBlcgrEAqqjfnHULUMLsrGaX+yMo
         3AHvfIxaFoNPaY7sfgnp8roo/AMRHDSWs2BeDwhErfDrU+POxwct3AXMUEU0WnC/7M9a
         Fkbo1e+FtUGF1NnzEG6JGTPog4/DpTFv4zTFgSBWLFBa7OczBreUtZe6sy+ZaJjRFExS
         kpvMMW6Vu2UZV1IyvTpjL94q6ulCiZzXdp7JLMt96Kk9c08i6tFbgEOW8rmCTZW/lh4f
         Bdvw==
X-Gm-Message-State: AOAM532143Rw+E+FcjIh0Ghzyoa3kLly8M+QaXb/JbLFmogutgohCus0
        5nADNmy2Bx9enFEdknMeF9vHP85W3D5Fc3Ww4Bwt4Zz2Y1nO1b/B3jO72La/0D85tBue99TzTaq
        HoH/9B9FJ5ohozTS8fMpdOA==
X-Received: by 2002:a05:600c:4657:: with SMTP id n23mr1532687wmo.28.1626339154915;
        Thu, 15 Jul 2021 01:52:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwG04gNyhAovDkzb27Ic90ObKsP032kjSM4Ta6rsdLHYz3DjpiTPfAKMPYYw2KwDBRjER7OUQ==
X-Received: by 2002:a05:600c:4657:: with SMTP id n23mr1532680wmo.28.1626339154774;
        Thu, 15 Jul 2021 01:52:34 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23bb3.dip0.t-ipconnect.de. [79.242.59.179])
        by smtp.gmail.com with ESMTPSA id d14sm5579705wrs.49.2021.07.15.01.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 01:52:34 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] KVM: s390: Topology expose TOPOLOGY facility
To:     Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, cohuck@redhat.com,
        thuth@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
References: <1626276343-22805-1-git-send-email-pmorel@linux.ibm.com>
 <1626276343-22805-3-git-send-email-pmorel@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <3a7836ad-f748-296e-cd1a-a10cbc570474@redhat.com>
Date:   Thu, 15 Jul 2021 10:52:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1626276343-22805-3-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 14.07.21 17:25, Pierre Morel wrote:
> We add the KVM extension KVM_CAP_S390_CPU_TOPOLOGY, this will
> allow the userland hypervisor to handle the interception of the
> PTF (Perform topology Function) instruction.

Ehm, no you don't add any new capability. Or my eyes are too tired to 
spot it :)

> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   arch/s390/tools/gen_facilities.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
> index 606324e56e4e..2c260eb22bae 100644
> --- a/arch/s390/tools/gen_facilities.c
> +++ b/arch/s390/tools/gen_facilities.c
> @@ -112,6 +112,7 @@ static struct facility_def facility_defs[] = {
>   
>   		.name = "FACILITIES_KVM_CPUMODEL",
>   		.bits = (int[]){
> +			11, /* configuration topology facility */
>   			12, /* AP Query Configuration Information */
>   			15, /* AP Facilities Test */
>   			156, /* etoken facility */
> 


-- 
Thanks,

David / dhildenb

