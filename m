Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93796ECAAD5
	for <linux-s390@archiver.kernel.org>; Fri,  2 Sep 2022 18:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiIBSnL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 2 Sep 2022 14:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiIBSnJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Sep 2022 14:43:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C221B1144F9
        for <linux-s390@vger.kernel.org>; Fri,  2 Sep 2022 11:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662144186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GkQeBnTijrLXZ/faOr5j44851js3+0quKExFB4IcaLs=;
        b=YLVxaoj/CYBE+5ZpHpHwfShtiST1sienVoSxYoPu6c2pi7G9goRH9L+s2ZcLjiM42IkcKK
        ZJAZkJt3eVshKDA0SNQa/l9bt3ucJZ4ShLLIv6r9dHLBJBSGkn/Jj32nFQMciTZgI6WJ+b
        I5UAmNoEXD0MTeHWu7P8LGgXpu2iyVc=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-115-AGCAhGQ5PsSz6MQBHVIzaw-1; Fri, 02 Sep 2022 14:43:05 -0400
X-MC-Unique: AGCAhGQ5PsSz6MQBHVIzaw-1
Received: by mail-io1-f71.google.com with SMTP id t18-20020a5d8852000000b0068832d2b28eso1827342ios.2
        for <linux-s390@vger.kernel.org>; Fri, 02 Sep 2022 11:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=GkQeBnTijrLXZ/faOr5j44851js3+0quKExFB4IcaLs=;
        b=KOy/16QhTaioLK2KZ3N1Y2Lenq9jCLFl+I3NqtHkuJnRy7plQxJPE0JzoS/PoWfRQu
         zOyijOtPSL978qGF7AlUYfua8kjvhQpbDI2Q1OpQySXcac8AsYPhhcrugMLMUflnWL4O
         l/qAP/Iudp1/UXS0kb+Hvic4qvrvLITqSkmSMiVePplvRVfjC8jkc3ql10AIG1EfUE9X
         XwKfgS+jcz8YSvEu/p709xBT2TAF5jlOrdttgsprCptwPMM3vhV2v8szOlF5R5GIleQX
         pHuDXntwg7hkxZAASbfu8+CZLKLrJ5Blb2PcxLisNgmg50f4cN4G4F2Tuw1KDMfxOcvy
         knhw==
X-Gm-Message-State: ACgBeo0ILQOHPKf5SS9+qu6DBLzS6Z5+UY8sky/Pwl6xZ9ayfgFJLzle
        /wtIDAIPnIgIQYNWhhr3kxJNhNgRn2tmuv6oJGgKYq2sPrO4z5+G31dDJEeXDQXY+5jtiu39A+g
        3r+2nn0eoAOTPM1Cet0TpfQ==
X-Received: by 2002:a05:6638:130c:b0:343:5bc5:7a45 with SMTP id r12-20020a056638130c00b003435bc57a45mr21056256jad.250.1662144183882;
        Fri, 02 Sep 2022 11:43:03 -0700 (PDT)
X-Google-Smtp-Source: AA6agR47C2qGZNrW880NJXQ8ruteIAjb7tqheAx1HJ2HEfAtkyfjpRPn1BIqRpqfOZ6NCVfnrnf6CQ==
X-Received: by 2002:a05:6638:130c:b0:343:5bc5:7a45 with SMTP id r12-20020a056638130c00b003435bc57a45mr21056250jad.250.1662144183722;
        Fri, 02 Sep 2022 11:43:03 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id x6-20020a056602160600b0067b7a057ee8sm1126680iow.25.2022.09.02.11.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 11:43:03 -0700 (PDT)
Date:   Fri, 2 Sep 2022 12:42:31 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Eric Farman <farman@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH v2 0/3] Remove private items from linux/vfio_pci_core.h
Message-ID: <20220902124231.5ced46d6.alex.williamson@redhat.com>
In-Reply-To: <0-v2-1bd95d72f298+e0e-vfio_pci_priv_jgg@nvidia.com>
References: <0-v2-1bd95d72f298+e0e-vfio_pci_priv_jgg@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 26 Aug 2022 16:34:00 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> The include/linux header should only include things that are intended to
> be used outside the internal implementation of the vfio_pci_core
> module. Several internal-only items were left over in this file after the
> conversion from vfio_pci.
> 
> Transfer most of the items to a new vfio_pci_priv.h located under
> drivers/vfio/pci/.
> 
> v2:

Applied to vfio next branch for v6.1.  Thanks,

Alex

