Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5660 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729084AbgKSP4U (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Nov 2020 10:56:20 -0500
Date: Thu, 19 Nov 2020 16:56:11 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 1/2] vfio-mdev: Wire in a request handler for mdev
 parent
Message-ID: <20201119165611.6a811d76.pasic@linux.ibm.com>
In-Reply-To: <20201119123026.1353cb3c.cohuck@redhat.com>
References: <20201117032139.50988-1-farman@linux.ibm.com>
        <20201117032139.50988-2-farman@linux.ibm.com>
        <20201119123026.1353cb3c.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Farman <farman@linux.ibm.com>, Kirti Wankhede <kwankhede@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Tony Krowiak <akrowiak@linux.ibm.com>

On Thu, 19 Nov 2020 12:30:26 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> > +static void vfio_mdev_request(void *device_data, unsigned int count)
> > +{
> > +	struct mdev_device *mdev = device_data;
> > +	struct mdev_parent *parent = mdev->parent;
> > +
> > +	if (unlikely(!parent->ops->request))  
> 
> Hm. Do you think that all drivers should implement a ->request()
> callback?

@Tony: What do you think, does vfio_ap need something like this?

BTW how is this supposed to work in a setup where the one parent
has may children (like vfio_ap or the gpu slice and dice usecases).

After giving this some thought I'm under the impression, I don't
get the full picture yet.

Regards,
Halil
