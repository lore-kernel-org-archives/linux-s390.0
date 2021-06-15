Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A02FC49361
	for <linux-s390@archiver.kernel.org>; Tue, 15 Jun 2021 19:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6515E60E0C
	for <linux-s390@archiver.kernel.org>; Tue, 15 Jun 2021 19:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhFOTiN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 15 Jun 2021 15:38:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41178 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230205AbhFOTiL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Jun 2021 15:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623785766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=llnAE3X+Il5R8O881N30+k0POgEFanp8l+fSoeV24QM=;
        b=AmAd4DXFZi99Gn8uMAsF7+V7TEz7YAW0UTslZNbEzvscCe80/wMcgiGdmaQZv2ohyJVfgs
        ipy0meWow1aitj65B8plxvwd1ryAE/2IRufnnn4wCmbxMsPcGYmcFw3kSmGhSEVj1U1e/u
        RtAZdKtPYClEf+bj7jAijYz/Noc6vZs=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-O_iyQDBePw2VR5qzDHP3ug-1; Tue, 15 Jun 2021 15:36:05 -0400
X-MC-Unique: O_iyQDBePw2VR5qzDHP3ug-1
Received: by mail-oo1-f71.google.com with SMTP id d12-20020a4aeb8c0000b029023bbaaddcbbso95162ooj.13
        for <linux-s390@vger.kernel.org>; Tue, 15 Jun 2021 12:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=llnAE3X+Il5R8O881N30+k0POgEFanp8l+fSoeV24QM=;
        b=OODPyfg/nqYfUvKfEYXAzSy3i48Ptz24DasdDiepDyyc/A3H/1GJFVwCv3I/L52AOK
         JBjhRrzIX6rphlSMIN6u8A2hjlwg7IYWxbaScgGhQImlETMRU+pl5IOy64wN6OSMCkzQ
         0BA4XY2XXqr5WRWlRPcYGYPZ3D4Ju1n4SJujQfSaTWOtjY/aZShjB/4hvEYvcmZDc3Bq
         Y09QO+8dm+hJElnCXpZeTQMRWRHC74dOLQN9yY2blZe1EnOgL9rULVBhBP+pJOODu8fr
         Zoyx27KHtkgOPzwrvtshX2USTs2jyIhRnNmZ4owQ1fmEjHRVUYgfk7uiKhf/ay7LP/Bz
         nXqg==
X-Gm-Message-State: AOAM532EnZijI+Vz06hpGnrR2SQSMrjwy0AIlby/LMo9oWZQNOlssB+/
        OCt8jB/XfrCJA29i6g+YPaSIgkDkqZhGHNappXj2sjpus0t18dhS+Q2sk7D11rYZn9m8h26o5aN
        6jxCtzxppfjm51AeDfZw8Cg==
X-Received: by 2002:a05:6808:210:: with SMTP id l16mr500267oie.154.1623785764704;
        Tue, 15 Jun 2021 12:36:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8QXhsFTV+W1cxlEpGDuWEWDQP8JmMvkjeZyUYAqX7GqD4McjXkjMc2mNDLmE9O/Xu0RrqmA==
X-Received: by 2002:a05:6808:210:: with SMTP id l16mr500251oie.154.1623785764560;
        Tue, 15 Jun 2021 12:36:04 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id u1sm3965076ooo.18.2021.06.15.12.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 12:36:04 -0700 (PDT)
Date:   Tue, 15 Jun 2021 13:36:02 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        David Airlie <airlied@linux.ie>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH 04/10] driver core: Don't return EPROBE_DEFER to
 userspace during sysfs bind
Message-ID: <20210615133602.0699492d.alex.williamson@redhat.com>
In-Reply-To: <20210615133519.754763-5-hch@lst.de>
References: <20210615133519.754763-1-hch@lst.de>
        <20210615133519.754763-5-hch@lst.de>
Organization: Red Hat
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 15 Jun 2021 15:35:13 +0200
Christoph Hellwig <hch@lst.de> wrote:

> @@ -547,10 +538,9 @@ static int call_driver_probe(struct device *dev, struct device_driver *drv)
>  
>  static int really_probe(struct device *dev, struct device_driver *drv)
>  {
> -	int local_trigger_count = atomic_read(&deferred_trigger_count);
>  	bool test_remove = IS_ENABLED(CONFIG_DEBUG_TEST_DRIVER_REMOVE) &&
>  			   !drv->suppress_bind_attrs;
> -	int ret = -EPROBE_DEFER, probe_ret = 0;
> +	int ret, probe_ret = 0;

nit, probe_ret initialization could be removed with this patch too.

>  
>  	if (defer_all_probes) {
>  		/*
> @@ -559,17 +549,13 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  		 * wait_for_device_probe() right after that to avoid any races.
>  		 */
>  		dev_dbg(dev, "Driver %s force probe deferral\n", drv->name);
> -		driver_deferred_probe_add(dev);
> -		return ret;
> +		return -EPROBE_DEFER;
>  	}
>  
>  	ret = device_links_check_suppliers(dev);
> -	if (ret == -EPROBE_DEFER)
> -		driver_deferred_probe_add_trigger(dev, local_trigger_count);
>  	if (ret)
>  		return ret;
>  
> -	atomic_inc(&probe_count);
>  	pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
>  		 drv->bus->name, __func__, drv->name, dev_name(dev));
>  	if (!list_empty(&dev->devres_head)) {
> @@ -681,11 +667,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  		dev->pm_domain->dismiss(dev);
>  	pm_runtime_reinit(dev);
>  	dev_pm_set_driver_flags(dev, 0);
> -	if (probe_ret == -EPROBE_DEFER)
> -		driver_deferred_probe_add_trigger(dev, local_trigger_count);

This was the only possible uninitialized use case afaict.  Thanks,

Alex

