Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30441 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730623AbfKFDxp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Nov 2019 22:53:45 -0500
Subject: Re: [PATCH V8 4/6] mdev: introduce virtio device and its device ops
References: <20191105093240.5135-1-jasowang@redhat.com>
 <20191105093240.5135-5-jasowang@redhat.com> <20191105104710.16d0f629@x1.home>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0de9abaf-d740-f4c7-50ff-3bd68a50ab40@redhat.com>
Date: Wed, 6 Nov 2019 11:51:33 +0800
MIME-Version: 1.0
In-Reply-To: <20191105104710.16d0f629@x1.home>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, mst@redhat.com, tiwei.bie@intel.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, cohuck@redhat.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com, stefanha@redhat.com


On 2019/11/6 =E4=B8=8A=E5=8D=881:47, Alex Williamson wrote:
>> +#define VIRTIO_MDEV_DEVICE_API_STRING=09=09"virtio-mdev"
>> +#define VIRTIO_MDEV_F_VERSION_1 0x1
> This entire concept of VIRTIO_MDEV_F_VERSION_1 is gone now, right?
> Let's remove it here and below.  Thanks,
>
> Alex
>

Yes, will fix.

Thanks
