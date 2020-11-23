Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729873AbgKWTMz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Nov 2020 14:12:55 -0500
Subject: Re: [RFC PATCH 1/2] vfio-mdev: Wire in a request handler for mdev
 parent
References: <20201117032139.50988-1-farman@linux.ibm.com>
 <20201117032139.50988-2-farman@linux.ibm.com>
 <20201119123026.1353cb3c.cohuck@redhat.com>
 <20201119165611.6a811d76.pasic@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <0fead493-332e-ff0a-ffea-c3b162cfe347@linux.ibm.com>
Date: Mon, 23 Nov 2020 14:12:48 -0500
MIME-Version: 1.0
In-Reply-To: <20201119165611.6a811d76.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Eric Farman <farman@linux.ibm.com>, Kirti Wankhede <kwankhede@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org



On 11/19/20 10:56 AM, Halil Pasic wrote:
> On Thu, 19 Nov 2020 12:30:26 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
>
>>> +static void vfio_mdev_request(void *device_data, unsigned int count)
>>> +{
>>> +	struct mdev_device *mdev = device_data;
>>> +	struct mdev_parent *parent = mdev->parent;
>>> +
>>> +	if (unlikely(!parent->ops->request))
>> Hm. Do you think that all drivers should implement a ->request()
>> callback?
> @Tony: What do you think, does vfio_ap need something like this?
>
> BTW how is this supposed to work in a setup where the one parent
> has may children (like vfio_ap or the gpu slice and dice usecases).
>
> After giving this some thought I'm under the impression, I don't
> get the full picture yet.

Eric Farman touched base with me on Friday to discuss this, but
I was on my way out the door for an appointment. He is off this
week; so, the bottom line for me is that I don't have even a
piece of the picture here and therefore don't have enough
info to speculate on whether vfio_ap needs something like this.

>
> Regards,
> Halil
