Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40382 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbfIRGQS (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Sep 2019 02:16:18 -0400
Subject: Re: [RFC PATCH 2/2] mdev: introduce device specific ops
References: <20190912094012.29653-1-jasowang@redhat.com>
 <20190912094012.29653-3-jasowang@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D579F71@SHSMSX104.ccr.corp.intel.com>
 <6bb2c43c-25bb-16f9-1fa0-08cb08e42b94@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57B49A@SHSMSX104.ccr.corp.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e3950e19-b815-1549-72b0-12b628fa2bc1@redhat.com>
Date: Wed, 18 Sep 2019 14:15:54 +0800
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D57B49A@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Tian, Kevin" <kevin.tian@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Cc: "sebott@linux.ibm.com" <sebott@linux.ibm.com>, "mst@redhat.com" <mst@redhat.com>, "airlied@linux.ie" <airlied@linux.ie>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "Wang, Zhi A" <zhi.a.wang@intel.com>, "farman@linux.ibm.com" <farman@linux.ibm.com>, "idos@mellanox.com" <idos@mellanox.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, "Wang, Xiao W" <xiao.w.wang@intel.com>, "freude@linux.ibm.com" <freude@linux.ibm.com>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>, "akrowiak@linux.ibm.com" <akrowiak@linux.ibm.com>, "pmorel@linux.ibm.com" <pmorel@linux.ibm.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "oberpar@linux.ibm.com" <oberpar@linux.ibm.com>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "Wang, Zhihong" <zhihong.wang@intel.com>


On 2019/9/18 上午10:57, Tian, Kevin wrote:
>> From: Jason Wang [mailto:jasowang@redhat.com]
>> Sent: Tuesday, September 17, 2019 6:17 PM
>>
>> On 2019/9/17 下午4:09, Tian, Kevin wrote:
>>>> From: Jason Wang
>>>> Sent: Thursday, September 12, 2019 5:40 PM
>>>>
>>>> Currently, except for the crate and remove. The rest fields of
>>>> mdev_parent_ops is just designed for vfio-mdev driver and may not
>> help
>>>> for kernel mdev driver. So follow the device id support by previous
>>>> patch, this patch introduces device specific ops which points to
>>>> device specific ops (e.g vfio ops). This allows the future drivers
>>>> like virtio-mdev to implement its own device specific ops.
>>> Can you give an example about what ops might be required to support
>>> kernel mdev driver? I know you posted a link earlier, but putting a small
>>> example here can save time and avoid inconsistent understanding. Then
>>> it will help whether the proposed split makes sense or there is a
>>> possibility of redefining the callbacks to meet the both requirements.
>>> imo those callbacks fulfill some basic requirements when mediating
>>> a device...
>> I put it in the cover letter.
>>
>> The link ishttps://lkml.org/lkml/2019/9/10/135  which abuses the current
>> VFIO based mdev parent ops.
>>
>> Thanks
> So the main problem is the handling of userspace pointers vs.
> kernel space pointers. You still implement read/write/ioctl
> callbacks which is a subset of current parent_ops definition.
> In that regard is it better to introduce some helper to handle
> the pointer difference in mdev core, while still keeping the
> same set of parent ops (in whatever form suitable for both)?


Pointers is one of the issues. And read/write/ioctl is designed for 
userspace API not kernel. Technically, we can use them for kernel but it 
would not be as simple and straightforward a set of device specific 
callbacks functions. The link above is just an example, e.g we can 
simply pass the vring address through a dedicated API instead of 
mandatory an offset of a file.

Thanks

>
