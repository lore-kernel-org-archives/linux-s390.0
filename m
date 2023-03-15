Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0038FC61DA4
	for <linux-s390@archiver.kernel.org>; Wed, 15 Mar 2023 22:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjCOWzR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 15 Mar 2023 18:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjCOWzO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Mar 2023 18:55:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2DF2056F
        for <linux-s390@vger.kernel.org>; Wed, 15 Mar 2023 15:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678920797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PmBI1DpvKaVXYXtA6gtpu5ckoov61ccQSRAX+aljBe0=;
        b=aWW4SidRK7jtNOK4lmoEUBJ03kdoNF5HCgExNhluaTIYHsPFaXAXrdk5eGfCzi3FcpRjCU
        RgLE21wUJe6xnmf/2CmdaNjv/zNA41kJLdeJp4sDu6aC2mV/LfcMlZ68YfiapX7IyJgapF
        BIbKlq7HdnP0/mdkcpmN3DCgtw8q8dY=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-a5PvCBQoNkKcu18DskQXHA-1; Wed, 15 Mar 2023 18:53:15 -0400
X-MC-Unique: a5PvCBQoNkKcu18DskQXHA-1
Received: by mail-il1-f200.google.com with SMTP id p8-20020a92d288000000b0032314990768so3118ilp.22
        for <linux-s390@vger.kernel.org>; Wed, 15 Mar 2023 15:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678920794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmBI1DpvKaVXYXtA6gtpu5ckoov61ccQSRAX+aljBe0=;
        b=othEai3wsu8Q4GhceFPGQPLBiQHQxQAAPc5Q0kHZP6Ggi4aC9796CORw7V4ApEYybm
         r5mFRJVI/lBC/24SCWyJMt5PXoJh9J6HlO0nxyu6ulai+VYYD2+cS1suFo9DZqrX4+RJ
         cp3/ipavPlHfCfx36fVbclNxsGqGsiKbJikCp1Vvbp1AvuLn6N6UDSXSBIGAoNwkXDNP
         OqFlzPMU7Y8qV20Ve3GlzlYb+jZAtu5TJnOxTUBTtS7M1GIqESHtQKCFtFZzTjM+7Dsj
         8QBbEFjSvfLyvNG2xoDRUYElw50uVcgjGGQliyqp+OB7r7pp6Bg8NXeuxh+HSqAYgjPe
         j9cw==
X-Gm-Message-State: AO0yUKV8cjV8m4I7DcyFEi3gaopxpjAE018Yv2H2+zejnmfkVkLySDfD
        kxSbocCcQqZBO8ULZF7MvMUVnUMyNcNbi6fS7MeSADxbcbDm/iyy9cLM9Rsb80VQOKeBXHVCPoR
        8t8JrfU2yKSaYEYjxQEk9OA==
X-Received: by 2002:a92:da05:0:b0:323:70c:ba7a with SMTP id z5-20020a92da05000000b00323070cba7amr6320941ilm.0.1678920794138;
        Wed, 15 Mar 2023 15:53:14 -0700 (PDT)
X-Google-Smtp-Source: AK7set+yni0unT0KaphMd3Dk9lb2xPshPnISgvaAGSRatSEhctfH2YsA/aYF25RNbXHTAq4r4BmLNg==
X-Received: by 2002:a92:da05:0:b0:323:70c:ba7a with SMTP id z5-20020a92da05000000b00323070cba7amr6320918ilm.0.1678920793895;
        Wed, 15 Mar 2023 15:53:13 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id x1-20020a0566380ca100b003c5157c8b2csm209087jad.47.2023.03.15.15.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 15:53:12 -0700 (PDT)
Date:   Wed, 15 Mar 2023 16:53:11 -0600
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
        xudong.hao@intel.com, yan.y.zhao@intel.com, terrence.xu@intel.com
Subject: Re: [PATCH v6 12/24] vfio/pci: Allow passing zero-length fd array
 in VFIO_DEVICE_PCI_HOT_RESET
Message-ID: <20230315165311.01f32bfe.alex.williamson@redhat.com>
In-Reply-To: <20230308132903.465159-13-yi.l.liu@intel.com>
References: <20230308132903.465159-1-yi.l.liu@intel.com>
        <20230308132903.465159-13-yi.l.liu@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed,  8 Mar 2023 05:28:51 -0800
Yi Liu <yi.l.liu@intel.com> wrote:

> This is another method to issue PCI hot reset for the users that bounds
> device to a positive iommufd value. In such case, iommufd is a proof of
> device ownership. By passing a zero-length fd array, user indicates kernel
> to do ownership check with the bound iommufd. All the opened devices within
> the affected dev_set should have been bound to the same iommufd. This is
> simpler and faster as user does not need to pass a set of fds and kernel
> no need to search the device within the given fds.

Couldn't this same idea apply to containers?

I'm afraid this proposal reduces or eliminates the handshake we have
with userspace between VFIO_DEVICE_GET_PCI_HOT_RESET_INFO and
VFIO_DEVICE_PCI_HOT_RESET, which could promote userspace to ignore the
_INFO ioctl altogether, resulting in drivers that don't understand the
scope of the reset.  Is it worth it?  What do we really gain?

> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index d80141969cd1..382d95455f89 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -682,6 +682,11 @@ struct vfio_pci_hot_reset_info {
>   * The ownership can be proved by:
>   *   - An array of group fds
>   *   - An array of device fds
> + *   - A zero-length array
> + *
> + * In the last case all affected devices which are opened by this user
> + * must have been bound to a same iommufd_ctx.  This approach is only
> + * available for devices bound to positive iommufd.
>   *
>   * Return: 0 on success, -errno on failure.
>   */

There's no introspection that this feature is supported, is that why
containers are not considered?  ie. if the host supports vfio cdevs, it
necessarily must support vfio-pci hot reset w/ a zero-length array?
Thanks,

Alex

