Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4BBC6FD1D
	for <linux-s390@archiver.kernel.org>; Tue, 28 Mar 2023 02:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjC1CYR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 27 Mar 2023 22:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC1CYQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 27 Mar 2023 22:24:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01EEE1
        for <linux-s390@vger.kernel.org>; Mon, 27 Mar 2023 19:24:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f66-20020a255145000000b00b714602d43fso10751408ybb.10
        for <linux-s390@vger.kernel.org>; Mon, 27 Mar 2023 19:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679970255;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IIWk8E2FhD0ZC/ZMkyMUSyLH1n6qTXVTC28fBAMF0u4=;
        b=eSI0jSMtM8TCN3DIt0ALDF8asOGVoGQPxFSek4Og40V4GHTgb7VX0uVSFnjiDOcbxo
         EQ3YxSPgX5jfI/ZQvGom56MhyFLfgFUBZqwmx8himK0CTXSRg6UdvjMCyTUQWYOaksZE
         fDBQzfJiMuLM4b/9ll9TI9ZUrkGPERrDXmnvtsH1PSk3kAWp4zAb5+s3EDOujPm+XHOz
         ez2ZBUOHwemE68BkBAy+S4R1NRz/YNW2LraknIbs6ZrAcZTGI4Wx7n9kZMcwd2frIrFg
         VTGvQCA4KhdFehoRP7IDJDyjak4oEB5m4es16rsqwoQc4HlhGIVNHMRdkI5K3KsSdbfp
         V6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679970255;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IIWk8E2FhD0ZC/ZMkyMUSyLH1n6qTXVTC28fBAMF0u4=;
        b=K+pfLvnVT8y9A/JcK9rfLEaAKdnQwnQbNXCZlGjovc8brl9T7aC5AKrN/dL6FCW7og
         EOfSl6SevrAK8+oAm3sb4cBxEgu/VdwaYT2hjwdER6K1Hvlggu2MdmX5C01tHISXcZBU
         ykPGwHqjTOADH2keX9Zeqxtruf5wXIXrt3JGCpYmrLMiewlpFQDZaBcQaiq0rcvJjT6c
         7Onyzc6dF2KjgpUvvGe6h0Dp11MhccC87XxkA69mZAkNpxxg0anMH0ocvNWZNCNtoD/y
         yAVakR3nzc+nOfrYI216X1oHgjUFSbmdMkqTgNumr51bvYom9eJ+OhVBFz2hZwK0iKMu
         Ae7A==
X-Gm-Message-State: AAQBX9c7lZeJ0C83t0utm4xShXkTqxUljUn+TSU0X4z2sgjA2f0mv0ck
        sDIojHBdYS5XYbfRCxQ1bdIdfSW2dZk=
X-Google-Smtp-Source: AKy350Yc9gNnjUwkT1L/Czn4VDNPMMf9w37THZNTzarP3ln1ljYD3oSIACFpDcm6vwQtbisDUVLH1n76PiQ=
X-Received: from pandoh.svl.corp.google.com ([2620:15c:2c5:11:7ff3:b6c5:b0f1:63e8])
 (user=pandoh job=sendgmr) by 2002:a05:6902:18c7:b0:b72:fff0:2f7f with SMTP id
 ck7-20020a05690218c700b00b72fff02f7fmr11533578ybb.4.1679970255089; Mon, 27
 Mar 2023 19:24:15 -0700 (PDT)
Date:   Mon, 27 Mar 2023 19:23:57 -0700
In-Reply-To: <20230327094047.47215-17-yi.l.liu@intel.com>
Mime-Version: 1.0
References: <20230327094047.47215-17-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328022357.2268961-1-pandoh@google.com>
Subject: Re: [PATCH v8 16/24] iommufd/device: Add iommufd_access_detach() API
From:   Jon Pan-Doh <pandoh@google.com>
To:     yi.l.liu@intel.com
Cc:     alex.williamson@redhat.com, chao.p.peng@linux.intel.com,
        cohuck@redhat.com, eric.auger@redhat.com,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, jasowang@redhat.com,
        jgg@nvidia.com, joro@8bytes.org, kevin.tian@intel.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org, lulu@redhat.com,
        mjrosato@linux.ibm.com, nicolinc@nvidia.com, peterx@redhat.com,
        robin.murphy@arm.com, shameerali.kolothum.thodi@huawei.com,
        suravee.suthikulpanit@amd.com, terrence.xu@intel.com,
        xudong.hao@intel.com, yan.y.zhao@intel.com,
        yanting.jiang@intel.com, yi.y.sun@linux.intel.com,
        Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 2023/3/27 02:40, Yi Liu wrote:
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 2e6e8e217cce..ec2ce3ef187d 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -263,6 +263,8 @@ struct iommufd_access {
>  	struct iommufd_object obj;
>  	struct iommufd_ctx *ictx;
>  	struct iommufd_ioas *ioas;
> +	struct iommufd_ioas *ioas_unpin;
> +	struct mutex ioas_lock;
>  	const struct iommufd_access_ops *ops;
>  	void *data;
>  	unsigned long iova_alignment;

I think you may need to initialize ioas_lock. I got lockdep warnings running
iommufd selftests against this patch. Those went away when I added mutex_init().

---
 drivers/iommu/iommufd/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index f0522d80919d..0eaae60f3537 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -474,6 +474,7 @@ iommufd_access_create(struct iommufd_ctx *ictx,
 	iommufd_ctx_get(ictx);
 	iommufd_object_finalize(ictx, &access->obj);
 	*id = access->obj.id;
+	mutex_init(&access->ioas_lock);
 	return access;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_create, IOMMUFD);
-- 
2.40.0.348.gf938b09366-goog

