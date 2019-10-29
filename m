Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31211 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727389AbfJ2Knt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 29 Oct 2019 06:43:49 -0400
Subject: Re: [PATCH V5 4/6] mdev: introduce virtio device and its device ops
References: <20191023130752.18980-1-jasowang@redhat.com>
 <20191023130752.18980-5-jasowang@redhat.com>
 <df1eb77c-d159-da11-bb8f-df2c19089ac6@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <14410ac9-cc01-185a-5dcf-7f6c78aefd65@redhat.com>
Date: Tue, 29 Oct 2019 18:42:11 +0800
MIME-Version: 1.0
In-Reply-To: <df1eb77c-d159-da11-bb8f-df2c19089ac6@linux.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Zhu Lingshan <lingshan.zhu@linux.intel.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, cohuck@redhat.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com, stefanha@redhat.com


On 2019/10/29 =E4=B8=8B=E5=8D=883:42, Zhu Lingshan wrote:
>>
>> +=C2=A0=C2=A0=C2=A0 void (*set_status)(struct mdev_device *mdev, u8 stat=
us);
>
> Hi Jason
>
> Is it possible to make set_status() return an u8 or bool, because this
> may fail in real hardware. Without a returned code, I am not sure=C2=A0
> whether it is a good idea to set the status | NEED_RESET when fail.
>
> Thanks,
> BR
> Zhu Lingshan=20


Hi:


It's possible but I'm not sure whether any user will care about it. E.g
see virtio_add_status():

void virtio_add_status(struct virtio_device *dev, unsigned int status)
{
=C2=A0=C2=A0=C2=A0 might_sleep();
=C2=A0=C2=A0=C2=A0 dev->config->set_status(dev, dev->config->get_status(dev=
) | status);
}
EXPORT_SYMBOL_GPL(virtio_add_status);

And I believe how it work should be:

virtio_add_status(xyz);

status =3D virtio_get_status();

if (!(status & xyz))

=C2=A0=C2=A0=C2=A0 error;

Thanks
