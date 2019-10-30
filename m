Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:53590 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfJ3Hgn (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 30 Oct 2019 03:36:43 -0400
Subject: Re: [PATCH V5 4/6] mdev: introduce virtio device and its device ops
References: <20191023130752.18980-1-jasowang@redhat.com>
 <20191023130752.18980-5-jasowang@redhat.com>
 <df1eb77c-d159-da11-bb8f-df2c19089ac6@linux.intel.com>
 <14410ac9-cc01-185a-5dcf-7f6c78aefd65@redhat.com>
From: Zhu Lingshan <lingshan.zhu@linux.intel.com>
Message-ID: <bc6b2565-b0b6-bf0a-812f-d0bb157be086@linux.intel.com>
Date: Wed, 30 Oct 2019 15:36:24 +0800
MIME-Version: 1.0
In-Reply-To: <14410ac9-cc01-185a-5dcf-7f6c78aefd65@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, cohuck@redhat.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com, stefanha@redhat.com

On 10/29/2019 6:42 PM, Jason Wang wrote:
> On 2019/10/29 下午3:42, Zhu Lingshan wrote:
>>> +    void (*set_status)(struct mdev_device *mdev, u8 status);
>> Hi Jason
>>
>> Is it possible to make set_status() return an u8 or bool, because this
>> may fail in real hardware. Without a returned code, I am not sure
>> whether it is a good idea to set the status | NEED_RESET when fail.
>>
>> Thanks,
>> BR
>> Zhu Lingshan
>
> Hi:
>
>
> It's possible but I'm not sure whether any user will care about it. E.g
> see virtio_add_status():
>
> void virtio_add_status(struct virtio_device *dev, unsigned int status)
> {
>      might_sleep();
>      dev->config->set_status(dev, dev->config->get_status(dev) | status);
> }
> EXPORT_SYMBOL_GPL(virtio_add_status);
>
> And I believe how it work should be:
>
> virtio_add_status(xyz);
>
> status = virtio_get_status();
>
> if (!(status & xyz))
>
>      error;
>
> Thanks
>
Thanks Jason, then I believe upper layer can handle this well.
>
