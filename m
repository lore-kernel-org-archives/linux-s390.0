Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FD5C43219
	for <linux-s390@archiver.kernel.org>; Wed, 16 Mar 2022 08:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354762AbiCPI6W (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 16 Mar 2022 04:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354726AbiCPI6V (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 16 Mar 2022 04:58:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E84765175
        for <linux-s390@vger.kernel.org>; Wed, 16 Mar 2022 01:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647421021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Bc153qdO6aJS+V+8boSatM96Pn9LsInVn8PpJNJpKY=;
        b=V60Ao4Zw1OA7tAOzdGW44leJ0jkElJhSPole8p+6UPMribGjSmwXawi+d7wL2Q1uaj/FON
        k2CwETmF1FBe7qqQ65ImSpIasQTWKeABDsfs/Z/Z9ZDbgpp3vQdsjJ7ohAKIiOP5I7+x9l
        Ax1/tYInHk81E+ISM4zKnhPSG9WCdaE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-DiaEPGDzOu6YWIrPuhEQXA-1; Wed, 16 Mar 2022 04:56:59 -0400
X-MC-Unique: DiaEPGDzOu6YWIrPuhEQXA-1
Received: by mail-wr1-f70.google.com with SMTP id z1-20020adfec81000000b001f1f7e7ec99so316645wrn.17
        for <linux-s390@vger.kernel.org>; Wed, 16 Mar 2022 01:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Bc153qdO6aJS+V+8boSatM96Pn9LsInVn8PpJNJpKY=;
        b=K7ZtQQ8evDXILu5DfC990BZwNFAAa/swgesvNnY+fohUP/RFsbgiV2nuywnIljmMm1
         pXMXOky//HcNW4Op40W8O1EPzRUvxihvfdjNwtnwR92RV30Qm7cp2xcpUjZnZcsCXRJF
         DldpM6X6+2lZRJD/t1UCTaBg06Zp3oeWy/qVtubsQZjPDb+wNThAZDYgcgdo/z2BuGLf
         y/oTrTi60KUj05cdcmht5ymq/WXwWsjjr7OCmLqBR4K1opTQi2ooMY/3V1+FGO/S4Z0H
         UU35PJdIJ3JJdl3ibagOGfRB6Dc1pOxgGlbwjUZDM8VswNmYguvG85qMjgfC4KPpvl5q
         pqDg==
X-Gm-Message-State: AOAM533rCyctTPsIy7XX7ICT+WpUxaiGixLfi0GSf02jw5MJ6oOflKj/
        wXnhSOawdd8SNvOlNyA6SFFZ37zEUXzaKnxUJeyRFxTYx8SX0um9kQI2YrRFsj6dJmuj1P7CNnM
        TNe6h/EXD2TI3mGofKNVx7A==
X-Received: by 2002:a5d:4d4b:0:b0:1f1:d99e:1122 with SMTP id a11-20020a5d4d4b000000b001f1d99e1122mr23570220wru.604.1647421018441;
        Wed, 16 Mar 2022 01:56:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxg+HdKFc+OlgI5Uf6j74GkTyT+tlDfMeOChHK9/5Na0k8DDsBUyiZqTzroGOmIKGPRSv82g==
X-Received: by 2002:a5d:4d4b:0:b0:1f1:d99e:1122 with SMTP id a11-20020a5d4d4b000000b001f1d99e1122mr23570190wru.604.1647421018228;
        Wed, 16 Mar 2022 01:56:58 -0700 (PDT)
Received: from redhat.com ([2.53.2.35])
        by smtp.gmail.com with ESMTPSA id p1-20020a5d59a1000000b00203d83b0ae4sm1136056wrr.109.2022.03.16.01.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 01:56:57 -0700 (PDT)
Date:   Wed, 16 Mar 2022 04:56:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v4 08/11] vdpa: Use helper for safer setting of
 driver_override
Message-ID: <20220316045633-mutt-send-email-mst@kernel.org>
References: <20220312132856.65163-1-krzysztof.kozlowski@canonical.com>
 <20220312132856.65163-9-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220312132856.65163-9-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, Mar 12, 2022 at 02:28:53PM +0100, Krzysztof Kozlowski wrote:
> Use a helper to set driver_override to reduce amount of duplicated code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

feel free to merge with the rest of the patchset.

> ---
>  drivers/vdpa/vdpa.c  | 29 ++++-------------------------
>  include/linux/vdpa.h |  4 +++-
>  2 files changed, 7 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 1ea525433a5c..2dabed1df35c 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -77,32 +77,11 @@ static ssize_t driver_override_store(struct device *dev,
>  				     const char *buf, size_t count)
>  {
>  	struct vdpa_device *vdev = dev_to_vdpa(dev);
> -	const char *driver_override, *old;
> -	char *cp;
> +	int ret;
>  
> -	/* We need to keep extra room for a newline */
> -	if (count >= (PAGE_SIZE - 1))
> -		return -EINVAL;
> -
> -	driver_override = kstrndup(buf, count, GFP_KERNEL);
> -	if (!driver_override)
> -		return -ENOMEM;
> -
> -	cp = strchr(driver_override, '\n');
> -	if (cp)
> -		*cp = '\0';
> -
> -	device_lock(dev);
> -	old = vdev->driver_override;
> -	if (strlen(driver_override)) {
> -		vdev->driver_override = driver_override;
> -	} else {
> -		kfree(driver_override);
> -		vdev->driver_override = NULL;
> -	}
> -	device_unlock(dev);
> -
> -	kfree(old);
> +	ret = driver_set_override(dev, &vdev->driver_override, buf, count);
> +	if (ret)
> +		return ret;
>  
>  	return count;
>  }
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 721089bb4c84..37117404660e 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -64,7 +64,9 @@ struct vdpa_mgmt_dev;
>   * struct vdpa_device - representation of a vDPA device
>   * @dev: underlying device
>   * @dma_dev: the actual device that is performing DMA
> - * @driver_override: driver name to force a match
> + * @driver_override: driver name to force a match; do not set directly,
> + *                   because core frees it; use driver_set_override() to
> + *                   set or clear it.
>   * @config: the configuration ops for this device.
>   * @cf_mutex: Protects get and set access to configuration layout.
>   * @index: device index
> -- 
> 2.32.0

