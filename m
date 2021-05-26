Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6D9C47089
	for <linux-s390@archiver.kernel.org>; Wed, 26 May 2021 14:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D540611CD
	for <linux-s390@archiver.kernel.org>; Wed, 26 May 2021 14:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbhEZOgD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 26 May 2021 10:36:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58424 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234694AbhEZOgB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 May 2021 10:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622039669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cqBPgPyUlAbZ7Kk+oGgbHiAKQDgT/aGEeIFiCp5+zq4=;
        b=Z7JqM08OFktzokQsVJFJPz4qA/0FVcsIKa2K7nDkn+dKbmDctbQ+JCAppNnGZQ4xI+LOO7
        LR47e+F1Dp0nWIIotkMq18nTt5uTZh99vZh6mho3IWmA6ZJMt62Fj6JdLnBYv7TS9ROywa
        utL93K+A8xXIV8v6koCQc+ASqyfJeuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-D2hxjXQtPpStZr2pCmQUGA-1; Wed, 26 May 2021 10:34:25 -0400
X-MC-Unique: D2hxjXQtPpStZr2pCmQUGA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3911A107AD35;
        Wed, 26 May 2021 14:34:24 +0000 (UTC)
Received: from gondolin.fritz.box (ovpn-113-79.ams2.redhat.com [10.36.113.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C85BA1037F21;
        Wed, 26 May 2021 14:34:22 +0000 (UTC)
Date:   Wed, 26 May 2021 16:34:20 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] virtio-ccw: allow to disable legacy virtio
Message-ID: <20210526163420.4620f342.cohuck@redhat.com>
In-Reply-To: <20210304132715.1587211-1-cohuck@redhat.com>
References: <20210304132715.1587211-1-cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu,  4 Mar 2021 14:27:13 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

Just found this old series sitting there... does anyone have an opinion
on the general approach?

> Unlike virtio-pci, virtio-ccw is currently always a transitional
> driver (i.e. it always includes support for legacy devices.) The
> differences between legacy and virtio-1+ virtio-ccw devices are not
> that big (the most interesting things are in common virtio code
> anyway.)
> 
> It might be beneficial to make support for legacy virtio generally
> configurable, in case we want to remove it completely in a future
> where we all have flying cars. As a prereq, we need to make it
> configurable for virtio-ccw.
> 
> Patch 1 introduces a parameter; now that I look at it, it's probably
> not that useful (not even for testing), so I'm inclined to drop it
> again.
> 
> Patch 2 adds a new config symbol for generic legacy virtio support,
> which currently does not do anything but being selected by the
> legacy options for virtio-pci and virtio-ccw. A virtio-ccw driver
> without legacy support will require a revision of 1 or higher to
> be supported by the device.
> 
> A virtio-ccw driver with legacy turned off works well for me with
> transitional devices and fails onlining gracefully for legacy devices
> (max_revision=0 in QEMU).
> 
> (I also have some code that allows to make devices non-transitional
> in QEMU, but I haven't yet found time to polish the patches.)
> 
> Cornelia Huck (2):
>   virtio/s390: add parameter for minimum revision
>   virtio/s390: make legacy support configurable
> 
>  arch/s390/Kconfig                       |  11 ++
>  drivers/s390/virtio/Makefile            |   1 +
>  drivers/s390/virtio/virtio_ccw.c        | 179 ++++++++----------------
>  drivers/s390/virtio/virtio_ccw_common.h | 113 +++++++++++++++
>  drivers/s390/virtio/virtio_ccw_legacy.c | 138 ++++++++++++++++++
>  drivers/virtio/Kconfig                  |   8 ++
>  6 files changed, 330 insertions(+), 120 deletions(-)
>  create mode 100644 drivers/s390/virtio/virtio_ccw_common.h
>  create mode 100644 drivers/s390/virtio/virtio_ccw_legacy.c
> 
> 
> base-commit: cf6acb8bdb1d829b85a4daa2944bf9e71c93f4b9

