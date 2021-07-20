Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11BFC07E95
	for <linux-s390@archiver.kernel.org>; Tue, 20 Jul 2021 22:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7ACD6113A
	for <linux-s390@archiver.kernel.org>; Tue, 20 Jul 2021 22:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhGTVVg (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 20 Jul 2021 17:21:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49578 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231319AbhGTVVG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 20 Jul 2021 17:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626818493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DGxLxC73Q30FLZh4kHloeV2LTAZ2CJRDqzZBDuBEMfM=;
        b=Ty6BN3NVh1tbncLXYO5K+ZGbp3ho5S8x+Hry/Nlf+J2EDkFSAFfLt4jbi3QTpiBM9zALCR
        owCtdHz5w6tODcx7oUteVm1faC9NtzB0HQyDwr4LgKQCDL2gBPIeVy6gY+06lqzLZx3HB3
        r3azSQQqPJPHLyYTHwl31Vj7CZvtG9E=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-Ti5i8kNTMhCrQk50a4B7Yw-1; Tue, 20 Jul 2021 18:01:32 -0400
X-MC-Unique: Ti5i8kNTMhCrQk50a4B7Yw-1
Received: by mail-oi1-f198.google.com with SMTP id f205-20020acacfd60000b02901f424a672b7so415449oig.18
        for <linux-s390@vger.kernel.org>; Tue, 20 Jul 2021 15:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DGxLxC73Q30FLZh4kHloeV2LTAZ2CJRDqzZBDuBEMfM=;
        b=rE1yW0iwY1yX9TyHQv7EzkLPqElkcFQI6on/A6JQncN75on8H7d1v6PSeaANGG1lKW
         GVt97dVw1AQ/ZM2aCbCKWW52QBUIqH3VajoGJE0De19IIICSHZAm88JzFChoE66Z4nqF
         +Xp0DI3zKIm/y0QYc42GIeKuDM7R8HTaHSg6KWOT6ffWbpwAMwafzLkV9+0GO3J0Crdv
         JirP3H4ByBzBCgLaG5GJ/MJBXSXH6ebqGnKJT2CgtOUeRUPoZw2MQDRWyyGSuO+WlixR
         vwrYTzz5j0sC/Nzc1xItkKZ8mdmP578YXptI05xffjgdoWI60mK4OtZ8p839Xocy6ttD
         Tpfw==
X-Gm-Message-State: AOAM532+PZkQaMbzxQvH9jneZRXb3OAsOleUR3YXNHrCV0YRXF1IIFOa
        NKuYJa+mdOoW5ZF8fnDfAW1cUJKKc2tTnsVQkBnyAQja1IZJLdG1yU9DySvByxHisTvpcd4E6Dt
        tyCVXv3/44jkJSaYlbAdtnQ==
X-Received: by 2002:a05:6808:aa3:: with SMTP id r3mr18166276oij.133.1626818491799;
        Tue, 20 Jul 2021 15:01:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuyDIfTXjm5YKo9TBgR+HrFk2cZEkVnlsdeNA/JOY8RcUjz3Wmb8/jGMHDDitpmXWLkurNEg==
X-Received: by 2002:a05:6808:aa3:: with SMTP id r3mr18166225oij.133.1626818491525;
        Tue, 20 Jul 2021 15:01:31 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id q187sm259680oif.2.2021.07.20.15.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 15:01:30 -0700 (PDT)
Date:   Tue, 20 Jul 2021 16:01:27 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     David Airlie <airlied@linux.ie>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        dri-devel@lists.freedesktop.org,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        kvm@vger.kernel.org, Kirti Wankhede <kwankhede@nvidia.com>,
        linux-doc@vger.kernel.org, linux-s390@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v2 02/14] vfio/mbochs: Fix missing error unwind in
 mbochs_probe()
Message-ID: <20210720160127.17bf3c19.alex.williamson@redhat.com>
In-Reply-To: <2-v2-b6a5582525c9+ff96-vfio_reflck_jgg@nvidia.com>
References: <0-v2-b6a5582525c9+ff96-vfio_reflck_jgg@nvidia.com>
        <2-v2-b6a5582525c9+ff96-vfio_reflck_jgg@nvidia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 20 Jul 2021 14:42:48 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> Compared to mbochs_remove() two cases are missing from the
> vfio_register_group_dev() unwind. Add them in.
> 
> Fixes: 681c1615f891 ("vfio/mbochs: Convert to use vfio_register_group_dev()")
> Reported-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  samples/vfio-mdev/mbochs.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
> index e81b875b4d87b4..501845b08c0974 100644
> --- a/samples/vfio-mdev/mbochs.c
> +++ b/samples/vfio-mdev/mbochs.c
> @@ -553,11 +553,14 @@ static int mbochs_probe(struct mdev_device *mdev)
>  
>  	ret = vfio_register_group_dev(&mdev_state->vdev);
>  	if (ret)
> -		goto err_mem;
> +		goto err_bytes;
>  	dev_set_drvdata(&mdev->dev, mdev_state);
>  	return 0;
>  
> +err_bytes:
> +	mbochs_used_mbytes -= mdev_state->type->mbytes;
>  err_mem:
> +	kfree(mdev_state->pages);
>  	kfree(mdev_state->vconfig);
>  	kfree(mdev_state);
>  	return ret;
> @@ -567,8 +570,8 @@ static void mbochs_remove(struct mdev_device *mdev)
>  {
>  	struct mdev_state *mdev_state = dev_get_drvdata(&mdev->dev);
>  
> -	mbochs_used_mbytes -= mdev_state->type->mbytes;
>  	vfio_unregister_group_dev(&mdev_state->vdev);
> +	mbochs_used_mbytes -= mdev_state->type->mbytes;
>  	kfree(mdev_state->pages);
>  	kfree(mdev_state->vconfig);
>  	kfree(mdev_state);

Hmm, doesn't this suggest we need another atomic conversion?  (untested)

diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
index e81b875b4d87..842819e29c6b 100644
--- a/samples/vfio-mdev/mbochs.c
+++ b/samples/vfio-mdev/mbochs.c
@@ -129,7 +129,7 @@ static dev_t		mbochs_devt;
 static struct class	*mbochs_class;
 static struct cdev	mbochs_cdev;
 static struct device	mbochs_dev;
-static int		mbochs_used_mbytes;
+static atomic_t		mbochs_avail_mbytes;
 static const struct vfio_device_ops mbochs_dev_ops;
 
 struct vfio_region_info_ext {
@@ -511,14 +511,19 @@ static int mbochs_probe(struct mdev_device *mdev)
 		&mbochs_types[mdev_get_type_group_id(mdev)];
 	struct device *dev = mdev_dev(mdev);
 	struct mdev_state *mdev_state;
+	int avail_mbytes = atomic_read(&mbochs_avail_mbytes);
 	int ret = -ENOMEM;
 
-	if (type->mbytes + mbochs_used_mbytes > max_mbytes)
-		return -ENOMEM;
+	do {
+		if (avail_mbytes < type->mbytes)
+			return ret;
+	} while (!atomic_try_cmpxchg(&mbochs_avail_mbytes, &avail_mbytes,
+				     avail_mbytes - type->mbytes));
 
 	mdev_state = kzalloc(sizeof(struct mdev_state), GFP_KERNEL);
 	if (mdev_state == NULL)
-		return -ENOMEM;
+		goto err_resv;
+
 	vfio_init_group_dev(&mdev_state->vdev, &mdev->dev, &mbochs_dev_ops);
 
 	mdev_state->vconfig = kzalloc(MBOCHS_CONFIG_SPACE_SIZE, GFP_KERNEL);
@@ -549,8 +554,6 @@ static int mbochs_probe(struct mdev_device *mdev)
 	mbochs_create_config_space(mdev_state);
 	mbochs_reset(mdev_state);
 
-	mbochs_used_mbytes += type->mbytes;
-
 	ret = vfio_register_group_dev(&mdev_state->vdev);
 	if (ret)
 		goto err_mem;
@@ -558,8 +561,11 @@ static int mbochs_probe(struct mdev_device *mdev)
 	return 0;
 
 err_mem:
+	kfree(mdev_state->pages);
 	kfree(mdev_state->vconfig);
 	kfree(mdev_state);
+err_resv:
+	atomic_add(mdev_state->type->mbytes, &mbochs_avail_mbytes);
 	return ret;
 }
 
@@ -567,11 +573,11 @@ static void mbochs_remove(struct mdev_device *mdev)
 {
 	struct mdev_state *mdev_state = dev_get_drvdata(&mdev->dev);
 
-	mbochs_used_mbytes -= mdev_state->type->mbytes;
 	vfio_unregister_group_dev(&mdev_state->vdev);
 	kfree(mdev_state->pages);
 	kfree(mdev_state->vconfig);
 	kfree(mdev_state);
+	atomic_add(mdev_state->type->mbytes, &mbochs_avail_mbytes);
 }
 
 static ssize_t mbochs_read(struct vfio_device *vdev, char __user *buf,
@@ -1351,7 +1357,7 @@ static ssize_t available_instances_show(struct mdev_type *mtype,
 {
 	const struct mbochs_type *type =
 		&mbochs_types[mtype_get_type_group_id(mtype)];
-	int count = (max_mbytes - mbochs_used_mbytes) / type->mbytes;
+	int count = atomic_read(&mbochs_avail_mbytes) / type->mbytes;
 
 	return sprintf(buf, "%d\n", count);
 }
@@ -1460,6 +1466,8 @@ static int __init mbochs_dev_init(void)
 	if (ret)
 		goto err_class;
 
+	atomic_set(&mbochs_avail_mbytes, max_mbytes);
+
 	ret = mdev_register_device(&mbochs_dev, &mdev_fops);
 	if (ret)
 		goto err_device;

