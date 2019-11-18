Return-Path: <netdev-owner@vger.kernel.org>
Subject: Re: [PATCH V12 5/6] virtio: introduce a mdev based transport
References: <20191118061703.8669-1-jasowang@redhat.com>
 <20191118061703.8669-6-jasowang@redhat.com>
 <20191118054339-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a59bf414-aefb-954c-86ea-b970513171bf@redhat.com>
Date: Mon, 18 Nov 2019 18:56:52 +0800
MIME-Version: 1.0
In-Reply-To: <20191118054339-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com, tiwei.bie@intel.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, cohuck@redhat.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, gregkh@linuxfoundation.org, jgg@mellanox.com


On 2019/11/18 =E4=B8=8B=E5=8D=886:44, Michael S. Tsirkin wrote:
>> +static const struct mdev_virtio_class_id virtio_id_table[] =3D {
>> +=09{ MDEV_VIRTIO_CLASS_ID_VIRTIO },
>> +=09{ 0 },
>> +};
>> +
> Do we still need the class ID? It's a virtio mdev bus,
> do we need a virtio class as well?
>

If we want to have auto match between vhost-mdev driver and vhost-mdev=20
device, we need this.

Otherwise, user need to manually probe or bind driver to the device.

Thanks
