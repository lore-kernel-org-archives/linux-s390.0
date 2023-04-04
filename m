Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFB7C761A6
	for <linux-s390@archiver.kernel.org>; Tue,  4 Apr 2023 21:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbjDDVCT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 4 Apr 2023 17:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236438AbjDDVCC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Apr 2023 17:02:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532104C03
        for <linux-s390@vger.kernel.org>; Tue,  4 Apr 2023 14:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680642038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eUlNSkHN+zXMVEgYFwpXLf7eXmZqDjBFuuY+21ymQM8=;
        b=QNXRjxDDVb8WnLfJzpLtcHe9kDPw8/ELQwrFT5e3ilaHTMscvOlkSVw16gcyCI8S21TKrI
        VeWxOX6cqsZOanftzA2xJ2EmhmzbmMm6FAR7SyGNYw4G5ihuzN/W2ez1GUPJTeKTeORA6m
        pRFfIRWDw4HXINHMPHQALeuWUShDVDY=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-mczulPLtMyO9zOouLmnmNA-1; Tue, 04 Apr 2023 17:00:37 -0400
X-MC-Unique: mczulPLtMyO9zOouLmnmNA-1
Received: by mail-io1-f72.google.com with SMTP id 9-20020a5ea509000000b0074ca36737d2so20413367iog.7
        for <linux-s390@vger.kernel.org>; Tue, 04 Apr 2023 14:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680642036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUlNSkHN+zXMVEgYFwpXLf7eXmZqDjBFuuY+21ymQM8=;
        b=gG2Pv5FBgyWE/ud4GsyfBH2cOoqh9xUkLRGsXbtCFs4LIhGHymoM3Rg8z/OkeS5LxX
         VBpHpW441ZccAkVmwZKi44ZzML5DNFjtYy4E/dAumpfd8LNOjn6LRy9uMP9bBHdefLB/
         pxhMcetoXGs6boCJPkdECS7+I80KndAgacBLQTBowgzPLxjYaY0oLCuTs7pqbzQ2UY/U
         rDhLRDbblrhPBRLcZ3wtB+3CWnP1yukfSJxo68rylulGWEGKhiJJglEYPYJTpWq4oQuT
         xXVgMj/j0iWHkNBOYsdN1XS0N5bDZo4nd/soCreade+wp2gV59yzA4+yx0pHsUWJlM3R
         N8+A==
X-Gm-Message-State: AAQBX9e06+J1tOKxD0XEgEJl1hulrr0lKzTn+UbeCeaaxc9Vi1VDDLyv
        KNpiZcispG09zrVOPO7AQTB1H2ZJjO3HKEAcbR0gsZU8NHyMljRmmDPlrIb0jhRzQ0qtziBnr5L
        kBW6a8bjQkCFaeit1a3SFlQ==
X-Received: by 2002:a05:6602:2e05:b0:759:410c:99b6 with SMTP id o5-20020a0566022e0500b00759410c99b6mr565936iow.2.1680642036467;
        Tue, 04 Apr 2023 14:00:36 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZBxWm4a3+LGUk3NVVLqCociOCxX0vWRo5d6ZJ4vSC6uL/zuJZ3VkObdr8SZMcgBOlbc8NPLw==
X-Received: by 2002:a05:6602:2e05:b0:759:410c:99b6 with SMTP id o5-20020a0566022e0500b00759410c99b6mr565895iow.2.1680642036246;
        Tue, 04 Apr 2023 14:00:36 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id m41-20020a026d29000000b003c4d71489aasm3548333jac.6.2023.04.04.14.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 14:00:35 -0700 (PDT)
Date:   Tue, 4 Apr 2023 15:00:34 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     jgg@nvidia.com, kevin.tian@intel.com, joro@8bytes.org,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-s390@vger.kernel.org,
        xudong.hao@intel.com, yan.y.zhao@intel.com, terrence.xu@intel.com,
        yanting.jiang@intel.com
Subject: Re: [PATCH v3 11/12] iommufd: Define IOMMUFD_INVALID_ID in uapi
Message-ID: <20230404150034.312fbcac.alex.williamson@redhat.com>
In-Reply-To: <20230401144429.88673-12-yi.l.liu@intel.com>
References: <20230401144429.88673-1-yi.l.liu@intel.com>
        <20230401144429.88673-12-yi.l.liu@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat,  1 Apr 2023 07:44:28 -0700
Yi Liu <yi.l.liu@intel.com> wrote:

> as there are IOMMUFD users that want to know check if an ID generated
> by IOMMUFD is valid or not. e.g. vfio-pci optionaly returns invalid
> dev_id to user in the VFIO_DEVICE_GET_PCI_HOT_RESET_INFO ioctl. User
> needs to check if the ID is valid or not.
> 
> IOMMUFD_INVALID_ID is defined as 0 since the IDs generated by IOMMUFD
> starts from 0.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  include/uapi/linux/iommufd.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 98ebba80cfa1..aeae73a93833 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -9,6 +9,9 @@
>  
>  #define IOMMUFD_TYPE (';')
>  
> +/* IDs allocated by IOMMUFD starts from 0 */
> +#define IOMMUFD_INVALID_ID 0
> +
>  /**
>   * DOC: General ioctl format
>   *

If allocation "starts from 0" then 0 is a valid id, no?  Does allocation
start from 1, ie. skip 0?  Thanks,

Alex

