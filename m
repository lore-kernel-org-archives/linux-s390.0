Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A6FC43334
	for <linux-s390@archiver.kernel.org>; Wed,  8 Jun 2022 07:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiFHHXM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 8 Jun 2022 03:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbiFHGSC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jun 2022 02:18:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 308B42BEA
        for <linux-s390@vger.kernel.org>; Tue,  7 Jun 2022 23:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654668128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UsmRmrmyC0YlUnFIqRRJkIZ3ojsOtC4OxRQHrbODTWU=;
        b=d9KP3C87EiNwC8875uafmzStpUSq/6l6Lm1olGg2cjxHqMv45Nbm4oWiDZFzw+zm3PSABj
        vWWZtt04d1FQWcvLdYRaBPD0r8CI+Z7OQkfGhFAV2AzY0FpGFyuju/dDmS2Ru6PnU1jBRw
        +UMuEQsmbs2XzpugWN46z5zAHECW1r8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591--9U629UcO9ey6xcHTbtviA-1; Wed, 08 Jun 2022 02:02:06 -0400
X-MC-Unique: -9U629UcO9ey6xcHTbtviA-1
Received: by mail-wm1-f69.google.com with SMTP id o23-20020a05600c511700b0039743cd8093so9484770wms.6
        for <linux-s390@vger.kernel.org>; Tue, 07 Jun 2022 23:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UsmRmrmyC0YlUnFIqRRJkIZ3ojsOtC4OxRQHrbODTWU=;
        b=45a6uaPSmsXCUrp1AXO9ZIaLSOySNKq3RxEpsFbWGokNZcj10n40x0TEKMumVAwGVQ
         1uhIuwIkgQn//j/3fiHuj1mnn0dX0AdkAM86NFJA3jj6tIZBM+lbhN3HcpQAb2Vbydo/
         VKPdAqbXH8KquqiR2NFaHmW9K3cZsTJjeRg+kpJ8NWALYaw9/Fy6KN6N8/HnqjXkiHd3
         sDOjiVMFObNOYg4w1zmInSINdk1c/orQr9y7d04Z7ajB5ZKFe2xZN9FcVq4E1OZlYfOw
         ikWlOMFj8S3rKR80YoayV133TjeoK37o6ML7CQYhNRET2jHJ/ldB+8+OdNaVBlwP/Rp8
         fi8A==
X-Gm-Message-State: AOAM532Nv/3H1B6RD4RUBI7CqlsV3w7vsCiVyZ31DDlPHoqgnYvdA4/W
        HXar8gqXTWUcC6v2v/uUfGQPcyOKLwPfLHSSL9v4Cd/Ncx+Gz6qUUBR16pLqTMzudA9UeEus6GL
        cLh1zCJHQmNJr7ZWYFCbq+Q==
X-Received: by 2002:a05:6000:147:b0:214:7d6e:cb1d with SMTP id r7-20020a056000014700b002147d6ecb1dmr24578579wrx.650.1654668125051;
        Tue, 07 Jun 2022 23:02:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHgUMf0DiGTalylNFpQjB5EiBfIrRc71DZVAGtXhPU6EUyeZBdyPoZS/71mmMYC1pA8jBi1g==
X-Received: by 2002:a05:6000:147:b0:214:7d6e:cb1d with SMTP id r7-20020a056000014700b002147d6ecb1dmr24578561wrx.650.1654668124893;
        Tue, 07 Jun 2022 23:02:04 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-42-114-66.web.vodafone.de. [109.42.114.66])
        by smtp.gmail.com with ESMTPSA id x14-20020adff0ce000000b00210396b2eaesm24124187wro.45.2022.06.07.23.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 23:02:04 -0700 (PDT)
Message-ID: <1bdd501e-01f6-a0fb-86f3-49ec19ec5bcf@redhat.com>
Date:   Wed, 8 Jun 2022 08:02:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v9 21/21] MAINTAINERS: additional files related kvm s390
 pci passthrough
Content-Language: en-US
To:     Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        schnelle@linux.ibm.com, farman@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, freude@linux.ibm.com, pasic@linux.ibm.com,
        pbonzini@redhat.com, corbet@lwn.net, jgg@nvidia.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220606203325.110625-1-mjrosato@linux.ibm.com>
 <20220606203325.110625-22-mjrosato@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220606203325.110625-22-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 06/06/2022 22.33, Matthew Rosato wrote:
> Add entries from the s390 kvm subdirectory related to pci passthrough.
> 
> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a6d3bd9d2a8d..3dd8657f5482 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17454,6 +17454,7 @@ M:	Eric Farman <farman@linux.ibm.com>
>   L:	linux-s390@vger.kernel.org
>   L:	kvm@vger.kernel.org
>   S:	Supported
> +F:	arch/s390/kvm/pci*
>   F:	drivers/vfio/pci/vfio_pci_zdev.c
>   F:	include/uapi/linux/vfio_zdev.h
>   

Reviewed-by: Thomas Huth <thuth@redhat.com>

