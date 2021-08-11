Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC243C4338F
	for <linux-s390@archiver.kernel.org>; Wed, 11 Aug 2021 09:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCA706056C
	for <linux-s390@archiver.kernel.org>; Wed, 11 Aug 2021 09:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbhHKJg3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 11 Aug 2021 05:36:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20418 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236651AbhHKJg2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Aug 2021 05:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628674565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yiNoHAcyou5Ou5txT8iiagT+7oEX1cAH3gpbVtY4zz4=;
        b=dftK5sFXrennQ6xQ4ggjHzA+RUMX1XIgocx9LzJJuPT49XLgLpS0Qzi+nmB/cS95VBZdQZ
        G9LVOpzVf91bczS1fIOmoilB4D9WWESx96jiGDCvo7EHEZ5srbf/v3uQ8CY/c3gnWqwNcH
        yug2NhjC5eDs8PDwBb01YOm6rLgpRU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-h_CveXh8MYqqsgCZvVLxhQ-1; Wed, 11 Aug 2021 05:36:04 -0400
X-MC-Unique: h_CveXh8MYqqsgCZvVLxhQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E78CD801A92;
        Wed, 11 Aug 2021 09:35:59 +0000 (UTC)
Received: from localhost (unknown [10.39.192.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F2FB9620DE;
        Wed, 11 Aug 2021 09:35:51 +0000 (UTC)
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
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v4 08/14] vfio/pci: Move to the device set infrastructure
In-Reply-To: <8-v4-9ea22c5e6afb+1adf-vfio_reflck_jgg@nvidia.com>
Organization: Red Hat GmbH
References: <8-v4-9ea22c5e6afb+1adf-vfio_reflck_jgg@nvidia.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Wed, 11 Aug 2021 11:35:50 +0200
Message-ID: <87zgtouxvt.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Aug 05 2021, Jason Gunthorpe <jgg@nvidia.com> wrote:

> From: Yishai Hadas <yishaih@nvidia.com>
>
> PCI wants to have the usual open/close_device() logic with the slight
> twist that the open/close_device() must be done under a singelton lock
> shared by all of the vfio_devices that are in the PCI "reset group".
>
> The reset group, and thus the device set, is determined by what devices
> pci_reset_bus() touches, which is either the entire bus or only the slot.
>
> Rely on the core code to do everything reflck was doing and delete reflck
> entirely.
>
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci.c         | 162 +++++++---------------------
>  drivers/vfio/pci/vfio_pci_private.h |   7 --
>  2 files changed, 37 insertions(+), 132 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

