Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DA8C43334
	for <linux-s390@archiver.kernel.org>; Tue, 28 Jun 2022 15:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347297AbiF1PA2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 28 Jun 2022 11:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347287AbiF1PA1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 28 Jun 2022 11:00:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61E362B278
        for <linux-s390@vger.kernel.org>; Tue, 28 Jun 2022 08:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656428426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sn3Aj80ZR5jpI+RNSE98brP0nO4W8nTuF5Ua5228bks=;
        b=GqG6HQ9hdsHDGxqFG1i9dEo5ZEft+aLZJyu39gbPyNKTRGDJF8rLQq7KZW6GT4mcOMVr/e
        DYomuEUPXzBR0nmwDIcCaVrFgNmo3l/UFayIqm1VOl4nh6JPU/kgJtHXDMJiUBHDRrusTj
        Lo6Z9ixFu9QEhnIwqHMfmXFT7cUjFwI=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-eCDf0ZkpO6qbROtV1T7o8g-1; Tue, 28 Jun 2022 11:00:22 -0400
X-MC-Unique: eCDf0ZkpO6qbROtV1T7o8g-1
Received: by mail-il1-f199.google.com with SMTP id k8-20020a056e02156800b002d91998aef7so7472923ilu.0
        for <linux-s390@vger.kernel.org>; Tue, 28 Jun 2022 08:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Sn3Aj80ZR5jpI+RNSE98brP0nO4W8nTuF5Ua5228bks=;
        b=VndJXaJWPllQloRwtUf++RpYkxZhdd0QucdUc1f6bfz7Pt+m0I6DThp6CVtFtyjik3
         0XYlmYi/A9Me48bI/55NGgwjEE7Rtq0qIxem3A4FXY5tDtPkFMbmaqQqvYlbZ4Q1oCVZ
         L7GZi3M97qZmGgmfW9pjq7cQyA0RhaS5T/zqE9pRyukf4iORDpJGe//biwaPzb8FQnrS
         jDYz+5qyExxG3GG+DnUohSOlrqSmFJgCgp6gwjvXVFzPvIeIRQqkbcJkoWs1mMxszWbo
         S0+lPpcBTpH0sj50SAfm/55muT+lz/TPnyswRW5+IPlntETdYXndhSjyLTXguy9ddFMD
         DCng==
X-Gm-Message-State: AJIora+0rmO/fLYWw+Bryr6oDLy6psXFCLvuGXH5CYQxOr/pCljzjr6v
        NlnZCmQN41TbVRRgx859bdLcFIe69E74EMek9GCELi46wiN28GQzejZs93DHF+d5wOIjOXgEZ4b
        SueYQqrGnlyJ/fVBRSl7bng==
X-Received: by 2002:a02:cb19:0:b0:33c:8404:3451 with SMTP id j25-20020a02cb19000000b0033c84043451mr9519992jap.176.1656428421678;
        Tue, 28 Jun 2022 08:00:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1szCC9bL6VETX76nqVy7Fx8MQDHT4jVPeSpKlsaHDHSTpH6oSrxkMCvIh6nmg6xhB/FAzpsBA==
X-Received: by 2002:a02:cb19:0:b0:33c:8404:3451 with SMTP id j25-20020a02cb19000000b0033c84043451mr9519976jap.176.1656428421463;
        Tue, 28 Jun 2022 08:00:21 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id m47-20020a026a6f000000b00339d0617be1sm6078281jaf.35.2022.06.28.08.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 08:00:21 -0700 (PDT)
Date:   Tue, 28 Jun 2022 09:00:19 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, cohuck@redhat.com,
        schnelle@linux.ibm.com, farman@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, freude@linux.ibm.com, thuth@redhat.com,
        pasic@linux.ibm.com, pbonzini@redhat.com, corbet@lwn.net,
        jgg@nvidia.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 19/21] vfio-pci/zdev: different maxstbl for
 interpreted devices
Message-ID: <20220628090019.2903f766.alex.williamson@redhat.com>
In-Reply-To: <20220606203325.110625-20-mjrosato@linux.ibm.com>
References: <20220606203325.110625-1-mjrosato@linux.ibm.com>
        <20220606203325.110625-20-mjrosato@linux.ibm.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon,  6 Jun 2022 16:33:23 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> When doing load/store interpretation, the maximum store block length is
> determined by the underlying firmware, not the host kernel API.  Reflect
> that in the associated Query PCI Function Group clp capability and let
> userspace decide which is appropriate to present to the guest.
> 
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_zdev.c | 6 ++++--
>  include/uapi/linux/vfio_zdev.h   | 4 ++++
>  2 files changed, 8 insertions(+), 2 deletions(-)


Acked-by: Alex Williamson <alex.williamson@redhat.com>


> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> index 4f28cdd7ecd1..e163aa9f6144 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -45,14 +45,16 @@ static int zpci_group_cap(struct zpci_dev *zdev, struct vfio_info_cap *caps)
>  {
>  	struct vfio_device_info_cap_zpci_group cap = {
>  		.header.id = VFIO_DEVICE_INFO_CAP_ZPCI_GROUP,
> -		.header.version = 1,
> +		.header.version = 2,
>  		.dasm = zdev->dma_mask,
>  		.msi_addr = zdev->msi_addr,
>  		.flags = VFIO_DEVICE_INFO_ZPCI_FLAG_REFRESH,
>  		.mui = zdev->fmb_update,
>  		.noi = zdev->max_msi,
>  		.maxstbl = ZPCI_MAX_WRITE_SIZE,
> -		.version = zdev->version
> +		.version = zdev->version,
> +		.reserved = 0,
> +		.imaxstbl = zdev->maxstbl
>  	};
>  
>  	return vfio_info_add_capability(caps, &cap.header, sizeof(cap));
> diff --git a/include/uapi/linux/vfio_zdev.h b/include/uapi/linux/vfio_zdev.h
> index 78c022af3d29..77f2aff1f27e 100644
> --- a/include/uapi/linux/vfio_zdev.h
> +++ b/include/uapi/linux/vfio_zdev.h
> @@ -50,6 +50,10 @@ struct vfio_device_info_cap_zpci_group {
>  	__u16 noi;		/* Maximum number of MSIs */
>  	__u16 maxstbl;		/* Maximum Store Block Length */
>  	__u8 version;		/* Supported PCI Version */
> +	/* End of version 1 */
> +	__u8 reserved;
> +	__u16 imaxstbl;		/* Maximum Interpreted Store Block Length */
> +	/* End of version 2 */
>  };
>  
>  /**

