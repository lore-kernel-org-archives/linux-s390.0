Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21225 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725769AbfJUFhb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Oct 2019 01:37:31 -0400
Subject: Re: [PATCH V4 4/6] mdev: introduce virtio device and its device ops
References: <20191017104836.32464-1-jasowang@redhat.com>
 <20191017104836.32464-5-jasowang@redhat.com>
 <20191018114614.6f1e79dc.cohuck@redhat.com>
 <733c0cfe-064f-c8ba-6bf8-165db88d7e07@redhat.com>
 <20191018153042.3516cde1.cohuck@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4a34d071-2e78-c37c-1046-7f9f6bb9e67f@redhat.com>
Date: Mon, 21 Oct 2019 13:36:22 +0800
MIME-Version: 1.0
In-Reply-To: <20191018153042.3516cde1.cohuck@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com, stefanha@redhat.com


On 2019/10/18 =E4=B8=8B=E5=8D=889:30, Cornelia Huck wrote:
> On Fri, 18 Oct 2019 18:55:02 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
>> On 2019/10/18 =E4=B8=8B=E5=8D=885:46, Cornelia Huck wrote:
>>> On Thu, 17 Oct 2019 18:48:34 +0800
>>> Jason Wang <jasowang@redhat.com> wrote:
>>>> + * @get_vendor_id:=09=09Get virtio vendor id
>>>> + *=09=09=09=09@mdev: mediated device
>>>> + *=09=09=09=09Returns u32: virtio vendor id
>>> How is the vendor id defined? As for normal virtio-pci devices?
>>
>> The vendor that provides this device. So something like this
>>
>> I notice that MMIO also had this so it looks to me it's not pci specific=
.
> Ok. Would be good to specify this more explicitly.


Ok.


>
>>
>>>  =20
>>>> + * @get_status: =09=09Get the device status
>>>> + *=09=09=09=09@mdev: mediated device
>>>> + *=09=09=09=09Returns u8: virtio device status
>>>> + * @set_status: =09=09Set the device status
>>>> + *=09=09=09=09@mdev: mediated device
>>>> + *=09=09=09=09@status: virtio device status
>>>> + * @get_config: =09=09Read from device specific configuration space
>>>> + *=09=09=09=09@mdev: mediated device
>>>> + *=09=09=09=09@offset: offset from the beginning of
>>>> + *=09=09=09=09configuration space
>>>> + *=09=09=09=09@buf: buffer used to read to
>>>> + *=09=09=09=09@len: the length to read from
>>>> + *=09=09=09=09configration space
>>>> + * @set_config: =09=09Write to device specific configuration space
>>>> + *=09=09=09=09@mdev: mediated device
>>>> + *=09=09=09=09@offset: offset from the beginning of
>>>> + *=09=09=09=09configuration space
>>>> + *=09=09=09=09@buf: buffer used to write from
>>>> + *=09=09=09=09@len: the length to write to
>>>> + *=09=09=09=09configration space
>>>> + * @get_mdev_features:=09=09Get the feature of virtio mdev device
>>>> + *=09=09=09=09@mdev: mediated device
>>>> + *=09=09=09=09Returns the mdev features (API) support by
>>>> + *=09=09=09=09the device.
>>> What kind of 'features' are supposed to go in there? Are these bits,
>>> like you defined for VIRTIO_MDEV_F_VERSION_1 above?
>>
>> It's the API or mdev features other than virtio features. It could be
>> used by driver to determine the capability of the mdev device. Besides
>> _F_VERSION_1, we may add dirty page tracking etc which means we need new
>> device ops.
> Ok, so that's supposed to be distinct bits that can be or'ed together?


Yes.


> Makes sense, but probably needs some more documentation somewhere.


Let me add some doc above this helper.


>
>>
>>>  =20
>>>> + * @get_generation:=09=09Get device generaton
>>>> + *=09=09=09=09@mdev: mediated device
>>>> + *=09=09=09=09Returns u32: device generation
>>> Is that callback mandatory?
>>
>> I think so, it's hard to emulate that completely in virtio-mdev transpor=
t.
> IIRC, the generation stuff is not mandatory in the current version of
> virtio, as not all transports have that concept.


It looks to me we can have workaround as what has been done by virtio.c.=20
Return 0 if this helper is not provided.


>
> Generally, are any of the callbacks optional, or are all of them
> mandatory? From what I understand, you plan to add new things that
> depend on features... would that mean non-mandatory callbacks?


Yes, not all of them were mandatory, I will explicit explain which are=20
mandatory and which are not.

Thanks
