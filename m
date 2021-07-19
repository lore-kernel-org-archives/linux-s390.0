Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B435CC12002
	for <linux-s390@archiver.kernel.org>; Mon, 19 Jul 2021 14:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D3F061002
	for <linux-s390@archiver.kernel.org>; Mon, 19 Jul 2021 14:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241017AbhGSOLg (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 19 Jul 2021 10:11:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25815 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241260AbhGSOJk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 19 Jul 2021 10:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626706210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4+c2mimUJxS/GfqKAMPDQnAMd4K+lxrp07r5+X88g/E=;
        b=LYU400GzjNex+/htbOm3+6q3o+oVAJO3SPI1kB8DtVrquYNzhIeSzJRQOtbpw99SkyMl0m
        AP/5Fow38NfEz7k5AwpOtcTq+e7/05OLFIwzBPKy/AXh5AKHwyvxO4yLULcLla27vkLOod
        h4nA5ddS7vli53sOEACU0rYQLcVOZnM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-i1pU7SFlN4-XnU6s5O2Fxg-1; Mon, 19 Jul 2021 10:47:52 -0400
X-MC-Unique: i1pU7SFlN4-XnU6s5O2Fxg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BA6BC73A1;
        Mon, 19 Jul 2021 14:47:48 +0000 (UTC)
Received: from localhost (ovpn-112-158.ams2.redhat.com [10.36.112.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 727BE5D9DC;
        Mon, 19 Jul 2021 14:47:40 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, David Airlie <airlied@linux.ie>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
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
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH 12/13] vfio/gvt: Fix open/close when multiple device FDs
 are open
In-Reply-To: <12-v1-eaf3ccbba33c+1add0-vfio_reflck_jgg@nvidia.com>
Organization: Red Hat GmbH
References: <12-v1-eaf3ccbba33c+1add0-vfio_reflck_jgg@nvidia.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Mon, 19 Jul 2021 16:47:38 +0200
Message-ID: <87lf629x85.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jul 14 2021, Jason Gunthorpe <jgg@nvidia.com> wrote:

> The user can open multiple device FDs if it likes, however the open
> function calls vfio_register_notifier() on device global state. Calling
> vfio_register_notifier() twice will trigger a WARN_ON from
> notifier_chain_register() and the first close will wrongly delete the
> notifier and more.
>
> Since these really want the new open/close_device() semantics just change
> the function over.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/gpu/drm/i915/gvt/kvmgt.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

