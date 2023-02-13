Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E33EC636CC
	for <linux-s390@archiver.kernel.org>; Mon, 13 Feb 2023 23:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBMXWo (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 13 Feb 2023 18:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjBMXWn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 13 Feb 2023 18:22:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C6513DFB
        for <linux-s390@vger.kernel.org>; Mon, 13 Feb 2023 15:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676330515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PalnaCa+45zmfRne4PsaOrNHcKeNAHWEUJgujCCpms4=;
        b=fpLnoggxeCuQBlyblQwikOyp1o5A44uqB9/54QFsyVZ9X4FAhXvenzrkz9uQlssUYdAqPR
        fCd2gKHslv1bT9jeTEH0L2azbzfCdoNnQLGB0f+aNtNMvuuDFI7jxfqHAgNEmFxR2qOiFt
        KW5sAIFUoOBlTJj3mqV8lPnK/FxeDZM=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-414-9Gs36O31M7akGBZEM1aOWg-1; Mon, 13 Feb 2023 18:21:54 -0500
X-MC-Unique: 9Gs36O31M7akGBZEM1aOWg-1
Received: by mail-io1-f71.google.com with SMTP id b10-20020a5ea70a000000b0071a96a509a7so9352869iod.22
        for <linux-s390@vger.kernel.org>; Mon, 13 Feb 2023 15:21:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PalnaCa+45zmfRne4PsaOrNHcKeNAHWEUJgujCCpms4=;
        b=1iDfRqhAM8RV4V9pvyDEqqvqjlzKfa39aqd5fS9lEK+P95dp7sh0v3NXH7Tpi5Q9PM
         wfakup/RLg3XElr2KIij+eP1Un64eIb4eJXHG0jNJIUpH2ZALO0xjVTel7rFKdfw0diV
         DgWznS+MXfCWkrcbvl34Nt/QDanw9E9NP66nUoVvQTEqvj/9q5ogN6IuMyWazvx8mQaW
         w5RXnXmZ46TXQZlHCndBd57Wn58wmsj3ce4/Os7vI4UYZfswfHoWbiQjVImmDql6A7Nb
         Z4ZCKmkvZd6GjkyFYukPnhGMrfzJSypQi/GVHizQMZILUjVovXAjrgiTOanDarPeWl67
         2kAw==
X-Gm-Message-State: AO0yUKVaBFdV06Ja9x7fTZ7lOQ8AOCizo/WxPrQed7AvSqQvM1tt4XK6
        BCrjiumyVlGQl+7F1Z7EyFrroFrnxZVTUmqsztTlhFHKeZTIuSgIKDMph6LLL298axn2TuxKJxl
        kQL6jmP4fBQPud2KeqhJN2g==
X-Received: by 2002:a05:6602:424e:b0:707:85b3:5dbb with SMTP id cc14-20020a056602424e00b0070785b35dbbmr247731iob.6.1676330513399;
        Mon, 13 Feb 2023 15:21:53 -0800 (PST)
X-Google-Smtp-Source: AK7set9iQtjrUB3qKlMbOa//wqF8gVTJyU2h1pAAMQbJhVobtNII43EJPHV4Swgm5qp296ZsP/lafg==
X-Received: by 2002:a05:6602:424e:b0:707:85b3:5dbb with SMTP id cc14-20020a056602424e00b0070785b35dbbmr247701iob.6.1676330513164;
        Mon, 13 Feb 2023 15:21:53 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id t66-20020a6bc345000000b00704878474c7sm4626794iof.53.2023.02.13.15.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 15:21:52 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:21:50 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 03/15] vfio: Accept vfio device file in the driver
 facing kAPI
Message-ID: <20230213162150.7626055b.alex.williamson@redhat.com>
In-Reply-To: <20230213151348.56451-4-yi.l.liu@intel.com>
References: <20230213151348.56451-1-yi.l.liu@intel.com>
        <20230213151348.56451-4-yi.l.liu@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 13 Feb 2023 07:13:36 -0800
Yi Liu <yi.l.liu@intel.com> wrote:

> This makes the vfio file kAPIs to accepte vfio device files, also a
> preparation for vfio device cdev support.
> 
> For the kvm set with vfio device file, kvm pointer is stored in struct
> vfio_device_file, and use kvm_ref_lock to protect kvm set and kvm
> pointer usage within VFIO. This kvm pointer will be set to vfio_device
> after device file is bound to iommufd in the cdev path.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>  drivers/vfio/vfio.h      |  2 ++
>  drivers/vfio/vfio_main.c | 51 ++++++++++++++++++++++++++++++++++++----
>  2 files changed, 49 insertions(+), 4 deletions(-)

This subtly changes the behavior of the vfio-pci hot reset functions
without updating the uAPI description or implementation to use less
group-centric variables.  The new behavior appears to be that cdev fds
can also be passed to prove ownership of the affected set of devices
for a hot reset, but this probably needs to be examined for gaps.
Thanks,

Alex

