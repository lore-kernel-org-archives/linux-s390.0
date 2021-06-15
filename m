Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD0BC48BDF
	for <linux-s390@archiver.kernel.org>; Tue, 15 Jun 2021 10:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED800610A3
	for <linux-s390@archiver.kernel.org>; Tue, 15 Jun 2021 10:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhFOKv5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 15 Jun 2021 06:51:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38115 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231359AbhFOKv4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Jun 2021 06:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623754192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x1ren7OSMjaDh6q/6WrOJye4kFus7TOYh5vtXdd/RZc=;
        b=g0DgSjIF+EeU+it5cpFrYUdorJiWj1g4I5l1+jKjQjnslsa7ihJUuuO96nK6iTKcuU1lz2
        07I2Ia6tLGQDnudNi6IzEUe0tjODgkj1W8BFjsTrxwqvfjWFMHmAXA+PBwPs2F9YmsLrri
        tIQbv7hxhV7RwHCiychvqDr8FQflTQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-b-Wl5m1PMUiDRtr-mHZcyw-1; Tue, 15 Jun 2021 06:49:49 -0400
X-MC-Unique: b-Wl5m1PMUiDRtr-mHZcyw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24806947;
        Tue, 15 Jun 2021 10:49:45 +0000 (UTC)
Received: from localhost (ovpn-113-156.ams2.redhat.com [10.36.113.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5EAA5D9CA;
        Tue, 15 Jun 2021 10:49:40 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     David Airlie <airlied@linux.ie>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
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
Subject: Re: [PATCH 05/10] driver core: Export device_driver_attach()
In-Reply-To: <20210614150846.4111871-6-hch@lst.de>
Organization: Red Hat GmbH
References: <20210614150846.4111871-1-hch@lst.de>
 <20210614150846.4111871-6-hch@lst.de>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Tue, 15 Jun 2021 12:49:39 +0200
Message-ID: <87bl87xv0c.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jun 14 2021, Christoph Hellwig <hch@lst.de> wrote:

> From: Jason Gunthorpe <jgg@nvidia.com>
>
> This is intended as a replacement API for device_bind_driver(). It has at
> least the following benefits:
>
> - Internal locking. Few of the users of device_bind_driver() follow the
>   locking rules
>
> - Calls device driver probe() internally. Notably this means that devm
>   support for probe works correctly as probe() error will call
>   devres_release_all()
>
> - struct device_driver -> dev_groups is supported
>
> - Simplified calling convention, no need to manually call probe().
>
> The general usage is for situations that already know what driver to bind
> and need to ensure the bind is synchronized with other logic. Call
> device_driver_attach() after device_add().
>
> If probe() returns a failure then this will be preserved up through to the
> error return of device_driver_attach().
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/base/base.h    | 1 -
>  drivers/base/dd.c      | 3 +++
>  include/linux/device.h | 2 ++
>  3 files changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

