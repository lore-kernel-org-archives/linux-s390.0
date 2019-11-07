Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24563 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388818AbfKGMrq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 Nov 2019 07:47:46 -0500
Subject: Re: [PATCH V10 6/6] docs: sample driver to demonstrate how to
 implement virtio-mdev framework
From: Jason Wang <jasowang@redhat.com>
References: <20191106133531.693-1-jasowang@redhat.com>
 <20191106133531.693-7-jasowang@redhat.com>
 <20191107040700-mutt-send-email-mst@kernel.org>
 <bd2f7796-8d88-0eb3-b55b-3ec062b186b7@redhat.com>
 <20191107061942-mutt-send-email-mst@kernel.org>
 <d09229bc-c3e4-8d4b-c28f-565fe150ced2@redhat.com>
Message-ID: <c588c724-04da-2991-9f88-f36c0d04364a@redhat.com>
Date: Thu, 7 Nov 2019 20:47:06 +0800
MIME-Version: 1.0
In-Reply-To: <d09229bc-c3e4-8d4b-c28f-565fe150ced2@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com, tiwei.bie@intel.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, cohuck@redhat.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com, freude@linux.ibm.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, christophe.de.dinechin@gmail.com, kevin.tian@intel.com, stefanha@redhat.com


On 2019/11/7 =E4=B8=8B=E5=8D=888:43, Jason Wang wrote:
>
> On 2019/11/7 =E4=B8=8B=E5=8D=887:21, Michael S. Tsirkin wrote:
>> On Thu, Nov 07, 2019 at 06:18:45PM +0800, Jason Wang wrote:
>>> On 2019/11/7 =E4=B8=8B=E5=8D=885:08, Michael S. Tsirkin wrote:
>>>> On Wed, Nov 06, 2019 at 09:35:31PM +0800, Jason Wang wrote:
>>>>> This sample driver creates mdev device that simulate virtio net=20
>>>>> device
>>>>> over virtio mdev transport. The device is implemented through vringh
>>>>> and workqueue. A device specific dma ops is to make sure HVA is used
>>>>> directly as the IOVA. This should be sufficient for kernel virtio
>>>>> driver to work.
>>>>>
>>>>> Only 'virtio' type is supported right now. I plan to add 'vhost' type
>>>>> on top which requires some virtual IOMMU implemented in this sample
>>>>> driver.
>>>>>
>>>>> Acked-by: Cornelia Huck<cohuck@redhat.com>
>>>>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>>>> I'd prefer it that we call this something else, e.g.
>>>> mvnet-loopback. Just so people don't expect a fully
>>>> functional device somehow. Can be renamed when applying?
>>> Actually, I plan to extend it as another standard network interface for
>>> kernel. It could be either a standalone pseudo device or a stack=20
>>> device.
>>> Does this sounds good to you?
>>>
>>> Thanks
>> That's a big change in an interface so it's a good reason
>> to rename the driver at that point right?
>> Oherwise users of an old kernel would expect a stacked driver
>> and get a loopback instead.
>>
>> Or did I miss something?
>
>
> My understanding is that it was a sample driver in /doc. It should not=20
> be used in production environment. Otherwise we need to move it to=20
> driver/virtio.
>
> But if you insist, I can post a V11.
>
> Thanks=20


Or maybe it's better to rename the type of current mdev from 'virtio' to=20
'virtio-loopback'. Then we can add more types in the future.

Thanks
