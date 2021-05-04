Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B202C433B4
	for <linux-s390@archiver.kernel.org>; Tue,  4 May 2021 15:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 127BD6008E
	for <linux-s390@archiver.kernel.org>; Tue,  4 May 2021 15:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhEDPbp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 4 May 2021 11:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45579 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230212AbhEDPbp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 May 2021 11:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620142249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vrpD0kusdH/3mBlZvXJdOGvx8oELC63TGIr1q93ZQk8=;
        b=GBDaonUXlcvatbyFMVyEWmovZi5oX2oxuXwTQV2xmD4cDa00dJwBAJSQNGV7KzGeecvUjg
        DklLUucGp3wtmKAJbkvIabEv1lDnmm2Z8gCaxkzxVs3XJrr13mulclczLZ6IS3UnCqpXhi
        Trv8/L9RjGfCFsEJ7Gn9kEryrzDVYQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-SKmQ0tEsMsucKvEUIawe-g-1; Tue, 04 May 2021 11:30:45 -0400
X-MC-Unique: SKmQ0tEsMsucKvEUIawe-g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79659100AA47;
        Tue,  4 May 2021 15:30:33 +0000 (UTC)
Received: from gondolin.fritz.box (ovpn-113-126.ams2.redhat.com [10.36.113.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29D4C6F45F;
        Tue,  4 May 2021 15:30:29 +0000 (UTC)
Date:   Tue, 4 May 2021 17:30:27 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Tarun Gupta <targupta@nvidia.com>,
        "Jason J . Herne" <jjherne@linux.ibm.com>
Subject: Re: [PATCH 06/12] vfio/ap_ops: Convert to use
 vfio_register_group_dev()
Message-ID: <20210504173027.74552e19.cohuck@redhat.com>
In-Reply-To: <597b470b-6f19-4818-7cdd-92ca3683faae@linux.ibm.com>
References: <0-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
        <6-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
        <20210426194859.1665730d.cohuck@redhat.com>
        <597b470b-6f19-4818-7cdd-92ca3683faae@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 3 May 2021 16:14:43 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 4/26/21 1:48 PM, Cornelia Huck wrote:
> > On Fri, 23 Apr 2021 20:03:03 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >  
> >> This is straightforward conversion, the ap_matrix_mdev is actually serving
> >> as the vfio_device and we can replace all the mdev_get_drvdata()'s with a
> >> simple container_of().
> >>
> >> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> >> ---
> >>   drivers/s390/crypto/vfio_ap_ops.c     | 137 ++++++++++++++++----------
> >>   drivers/s390/crypto/vfio_ap_private.h |   2 +
> >>   2 files changed, 89 insertions(+), 50 deletions(-)
> >>  
> > (...)
> >  
> >> -static int vfio_ap_mdev_remove(struct mdev_device *mdev)
> >> +static void vfio_ap_mdev_remove(struct mdev_device *mdev)
> >>   {
> >> -	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> >> +	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(&mdev->dev);
> >>   
> >> -	if (matrix_mdev->kvm)
> >> -		return -EBUSY;
> >> +	/* FIXME: Remove isn't allowed to fail */
> >> +	if (WARN_ON(matrix_mdev->kvm))
> >> +		return;  
> > This is a pre-existing problem, but the rework now makes it more
> > obvious.  
> 
> I agree, I was not aware that returning a non-zero return code
> from this callback did not return the -EBUSY to userspace
> when the mdev is removed.
> 
> >
> > Previously, the mdev code would only print a warning and then continue
> > with device removal, even if a ->remove() callback returned an error.
> > Now, it's quite clear that we'll end up in a weird half-dead state.  
> 
> With the latest kernel from our tree, the remove hangs until the
> guest is shutdown and the mdev fd is closed. During the hang, the
> dmesg log has the following:
> 
> "No mdev vendor driver request callback support, blocked until released 
> by user"
> 
> So, it looks like nothing is done with the mdev until the fd for the
> mdev is closed when the guest is shut down, at which time the
> mdev is removed.

You probably want to wire up the request callback and notify userspace.

What happens today if the device in QEMU is removed via device_del?
Does that already clean up things properly?

