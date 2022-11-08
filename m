Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F9EC4332F
	for <linux-s390@archiver.kernel.org>; Tue,  8 Nov 2022 22:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiKHWbF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 8 Nov 2022 17:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiKHWad (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Nov 2022 17:30:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C401712D3C
        for <linux-s390@vger.kernel.org>; Tue,  8 Nov 2022 14:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667946520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pAwH+5JDvufKDL3NMoeBuf7w8Ln38eP9Ts8frUc7hNk=;
        b=cyAKLLwxSVSFq17txFP1oVhSjX1UGqtSxaDpoX5XobucL7C+fLt3zSsB5ecw8cw9Ppsrlr
        P3MJIe54z5BdrLvgYItP+DLOjLHMIIGk8zr7SPFEMfKERIGLtSHolDgH3wAViU3Tmlgvnn
        iOd9L7bzCFerA6V/XESuxi4n8/6S0qc=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-311-qYcRt4pkM3q1T-Wx_6ci2Q-1; Tue, 08 Nov 2022 17:28:38 -0500
X-MC-Unique: qYcRt4pkM3q1T-Wx_6ci2Q-1
Received: by mail-il1-f198.google.com with SMTP id q10-20020a056e0220ea00b00300f474693aso9260360ilv.23
        for <linux-s390@vger.kernel.org>; Tue, 08 Nov 2022 14:28:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAwH+5JDvufKDL3NMoeBuf7w8Ln38eP9Ts8frUc7hNk=;
        b=4h4XTjPritOn1pl+Rd7DKYOz9KCkhvcHYJpcKrmXy0scPOeQg+GFCxNN6b0jjxLdZg
         Cabefnl1VHc9uj1PFQNbN44C+X+Kd405JpkWGnJI8sKCh/KrGG1NTsdFj8Db4Z1EE+e4
         icZLdP0ZG4J5b591e6qn03Tx9LHbadoXSBMv0GHre6UZLiFgB0povV/NbgWa6+Ba5kOa
         G11wnoRPjJ8Ydr1hQj8DV8sNqwZBec23sH+pfUFjvUgx2kFzaFEZJVWwMtQwuUIyCV/E
         bzvQeto7vBtJtvOKLH+sHEqo3NQy+AYDc6gXWeQzmJgpeHzWPpunOX4nj5b1JDD/g4pZ
         TVPw==
X-Gm-Message-State: ACrzQf1D0fs4oHBj/CjvEWK/pLX5mtoBwgr3MbAPvirPrKj3czxvjnF3
        Ma2EUrF9Xh0gd9TXhFYHjaske4pI7Ht2GOIP/bEt16cYU5k0yBaCDhcG9AtR7zA1VR631Z5j5iX
        hi+FnaZ0L/dANBseZAr8oNw==
X-Received: by 2002:a05:6638:3e1b:b0:373:9526:ff23 with SMTP id co27-20020a0566383e1b00b003739526ff23mr1059559jab.25.1667946515337;
        Tue, 08 Nov 2022 14:28:35 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7qQUvxc2/UNOHomsJy1dPTa1Nkgqu6DzA5Et+Lrzoib29h+Bm9PbubEw1u6deu68awl9vxhQ==
X-Received: by 2002:a05:6638:3e1b:b0:373:9526:ff23 with SMTP id co27-20020a0566383e1b00b003739526ff23mr1059545jab.25.1667946515058;
        Tue, 08 Nov 2022 14:28:35 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id k9-20020a026609000000b003753b6452f9sm4039228jac.35.2022.11.08.14.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 14:28:34 -0800 (PST)
Date:   Tue, 8 Nov 2022 15:28:31 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        David Airlie <airlied@gmail.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        dri-devel@lists.freedesktop.org,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, iommu@lists.linux.dev,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Longfang Liu <liulongfang@huawei.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 10/11] vfio: Make vfio_container optionally compiled
Message-ID: <20221108152831.1a2ed3df.alex.williamson@redhat.com>
In-Reply-To: <10-v2-65016290f146+33e-vfio_iommufd_jgg@nvidia.com>
References: <0-v2-65016290f146+33e-vfio_iommufd_jgg@nvidia.com>
        <10-v2-65016290f146+33e-vfio_iommufd_jgg@nvidia.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon,  7 Nov 2022 20:52:54 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> Add a kconfig CONFIG_VFIO_CONTAINER that controls compiling the container
> code. If 'n' then only iommufd will provide the container service. All the
> support for vfio iommu drivers, including type1, will not be built.
> 
> This allows a compilation check that no inappropriate dependencies between
> the device/group and container have been created.
> 
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/Kconfig  | 35 +++++++++++++++--------
>  drivers/vfio/Makefile |  4 +--
>  drivers/vfio/vfio.h   | 65 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 91 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> index 1118d322eec97d..286c1663bd7564 100644
> --- a/drivers/vfio/Kconfig
> +++ b/drivers/vfio/Kconfig
> @@ -3,8 +3,8 @@ menuconfig VFIO
>  	tristate "VFIO Non-Privileged userspace driver framework"
>  	select IOMMU_API
>  	depends on IOMMUFD || !IOMMUFD
> -	select VFIO_IOMMU_TYPE1 if MMU && (X86 || S390 || ARM || ARM64)
>  	select INTERVAL_TREE
> +	select VFIO_CONTAINER if IOMMUFD=n
>  	help
>  	  VFIO provides a framework for secure userspace device drivers.
>  	  See Documentation/driver-api/vfio.rst for more details.
> @@ -12,6 +12,18 @@ menuconfig VFIO
>  	  If you don't know what to do here, say N.
>  
>  if VFIO
> +config VFIO_CONTAINER
> +	bool "Support for the VFIO container /dev/vfio/vfio"
> +	select VFIO_IOMMU_TYPE1 if MMU && (X86 || S390 || ARM || ARM64)
> +	default y
> +	help
> +	  The VFIO container is the classic interface to VFIO for establishing
> +	  IOMMU mappings. If N is selected here then IOMMUFD must be used to
> +	  manage the mappings.
> +
> +	  Unless testing IOMMUFD say Y here.
> +
> +if VFIO_CONTAINER
>  config VFIO_IOMMU_TYPE1
>  	tristate
>  	default n
> @@ -21,16 +33,6 @@ config VFIO_IOMMU_SPAPR_TCE
>  	depends on SPAPR_TCE_IOMMU
>  	default VFIO
>  
> -config VFIO_SPAPR_EEH
> -	tristate
> -	depends on EEH && VFIO_IOMMU_SPAPR_TCE
> -	default VFIO
> -
> -config VFIO_VIRQFD
> -	tristate
> -	select EVENTFD
> -	default n
> -
>  config VFIO_NOIOMMU
>  	bool "VFIO No-IOMMU support"
>  	help


Perhaps this should have been obvious, but I'm realizing that
vfio-noiommu mode is completely missing without VFIO_CONTAINER, which
seems a barrier to deprecating VFIO_CONTAINER and perhaps makes it a
question whether IOMMUFD should really be taking over /dev/vfio/vfio.
No-iommu mode has users.  Thanks,

Alex

