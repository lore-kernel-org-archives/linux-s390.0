Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875B5C4332F
	for <linux-s390@archiver.kernel.org>; Thu,  8 Dec 2022 21:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiLHVth (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 8 Dec 2022 16:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLHVtg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Dec 2022 16:49:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7D584DE3
        for <linux-s390@vger.kernel.org>; Thu,  8 Dec 2022 13:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670536110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JlSLHZU0UyP1zXnoWLl9wrALkHazYkzcA1gB5b/QBD4=;
        b=h8gJQMxyvGsKoHS5lScHZNQS2cRBg/WEEe6illL3JvtXb8QU1kG7lreELn4yw/hkQInxBq
        v3aASESWuF4iHEQ+zn3lIzLgpt0v2KSvfAJ94F3mpnxDgopE+zPeF2wKRyHrT2Aqqg9w5+
        BDXW5eK7BY+Za/IDjxEha5vcOV7d2YY=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-147-kWX9VxMMMoukDCfNre-i0A-1; Thu, 08 Dec 2022 16:48:29 -0500
X-MC-Unique: kWX9VxMMMoukDCfNre-i0A-1
Received: by mail-il1-f200.google.com with SMTP id g4-20020a92cda4000000b00301ff06da14so2415672ild.11
        for <linux-s390@vger.kernel.org>; Thu, 08 Dec 2022 13:48:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JlSLHZU0UyP1zXnoWLl9wrALkHazYkzcA1gB5b/QBD4=;
        b=Ip1zR4JGggYFU+f9cOO9ix90TSIHids1SeMtj2/MC+ZBvyfkXEnllNBSxS5uFLJTTh
         mGuzfErjfbMy7dPK9KBQRCYTIfA4uH1tAjEHjKA5rmGbjWGgSi46t4uo4J4DJxYkTLNq
         GC+9sJ8hvK9rTDmzQtRgBJnC6/r5TItsR2bcIqU46iJr8J3Qe4VYGQjFcDB7WlAos4UA
         1nPqH0+7RcZm8uGea5UxeBzmL6jPuSpBi08DPp753k1VU+Abi4jPpplmZuuP198kCPkY
         ZGCEpsAFZ/CESgcsKtL5wLgdRalEUofG5yFPYlgNy2vuiVOp70XyWP5g0vo+1c8V+VmT
         MVcg==
X-Gm-Message-State: ANoB5plxiGxTre9GQ7A9wozoJ2MTcUXuHdT8a0/7tbUA92lrOZCAYfAt
        DCOt+Lxw0dRD8j7cN7LTCut1bYdQEY9MTp6PTeTEWQ+Sn23DsgbyiOXg+MSR/q/N8JNIc3Ht2P3
        fUEG6Acso1Y/P8YjcHJpVMg==
X-Received: by 2002:a02:caa9:0:b0:38a:4f3e:a8f3 with SMTP id e9-20020a02caa9000000b0038a4f3ea8f3mr7633694jap.118.1670536108937;
        Thu, 08 Dec 2022 13:48:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5z9amCYid4VD2QKF39+LEnq0/gOoAHkRrex2ThE5am1xPidFCUVQZkXXRQS46wsmIHSMDr3g==
X-Received: by 2002:a02:caa9:0:b0:38a:4f3e:a8f3 with SMTP id e9-20020a02caa9000000b0038a4f3ea8f3mr7633686jap.118.1670536108715;
        Thu, 08 Dec 2022 13:48:28 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id q18-20020a927512000000b00302bb083c2bsm1115985ilc.21.2022.12.08.13.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 13:48:28 -0800 (PST)
Date:   Thu, 8 Dec 2022 14:48:25 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Bharat Bhushan <bharat.bhushan@nxp.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH iommufd 2/9] vfio/type1: Check that every device
 supports IOMMU_CAP_INTR_REMAP
Message-ID: <20221208144825.33823739.alex.williamson@redhat.com>
In-Reply-To: <2-v1-9e466539c244+47b5-secure_msi_jgg@nvidia.com>
References: <0-v1-9e466539c244+47b5-secure_msi_jgg@nvidia.com>
        <2-v1-9e466539c244+47b5-secure_msi_jgg@nvidia.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu,  8 Dec 2022 16:26:29 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> iommu_group_for_each_dev() exits the loop at the first callback that
> returns 1 - thus returning 1 fails to check the rest of the devices in the
> group.
> 
> msi_remap (aka secure MSI) requires that all the devices in the group
> support it, not just any one. This is only a theoretical problem as no
> current drivers will have different secure MSI properties within a group.

Which is exactly how Robin justified the behavior in the referenced
commit:

  As with domains, any capability must in practice be consistent for
  devices in a given group - and after all it's still the same
  capability which was expected to be consistent across an entire bus!
  - so there's no need for any complicated validation.

That suggests to me that it's intentional that we break if any device
supports the capability and therefore this isn't so much a "Fixes:", as
it is a refactoring expressly to support msi_device_has_secure_msi(),
which cannot make these sort of assumptions as a non-group API.  Thanks,

Alex

> Make vfio_iommu_device_secure_msi() reduce AND across all the devices.
> 
> Fixes: eed20c782aea ("vfio/type1: Simplify bus_type determination")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 23c24fe98c00d4..3025b4e643c135 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2160,10 +2160,12 @@ static void vfio_iommu_iova_insert_copy(struct vfio_iommu *iommu,
>  	list_splice_tail(iova_copy, iova);
>  }
>  
> -/* Redundantly walks non-present capabilities to simplify caller */
> -static int vfio_iommu_device_capable(struct device *dev, void *data)
> +static int vfio_iommu_device_secure_msi(struct device *dev, void *data)
>  {
> -	return device_iommu_capable(dev, (enum iommu_cap)data);
> +	bool *secure_msi = data;
> +
> +	*secure_msi &= device_iommu_capable(dev, IOMMU_CAP_INTR_REMAP);
> +	return 0;
>  }
>  
>  static int vfio_iommu_domain_alloc(struct device *dev, void *data)
> @@ -2278,9 +2280,12 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	INIT_LIST_HEAD(&domain->group_list);
>  	list_add(&group->next, &domain->group_list);
>  
> -	msi_remap = irq_domain_check_msi_remap() ||
> -		    iommu_group_for_each_dev(iommu_group, (void *)IOMMU_CAP_INTR_REMAP,
> -					     vfio_iommu_device_capable);
> +	msi_remap = irq_domain_check_msi_remap();
> +	if (!msi_remap) {
> +		msi_remap = true;
> +		iommu_group_for_each_dev(iommu_group, &msi_remap,
> +					 vfio_iommu_device_secure_msi);
> +	}
>  
>  	if (!allow_unsafe_interrupts && !msi_remap) {
>  		pr_warn("%s: No interrupt remapping support.  Use the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this platform\n",

