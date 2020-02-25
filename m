Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20460 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726962AbgBYDi4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 Feb 2020 22:38:56 -0500
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <426e6972-0565-c931-e171-da0f58fbf856@redhat.com>
 <20200221155602.4de41fa7.pasic@linux.ibm.com>
 <0181712c-e533-fcfd-2638-8a0649d713dd@redhat.com>
 <20200224010607-mutt-send-email-mst@kernel.org>
 <b3c52c67-c740-a50e-2595-fe04d179c881@redhat.com>
 <20200224024641-mutt-send-email-mst@kernel.org>
 <08d6bdfb-9b49-c278-3c0b-2e02376cf0cf@redhat.com>
 <20200224083845-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ac15de73-8c61-5e82-4ed2-760b7f3055bb@redhat.com>
Date: Tue, 25 Feb 2020 11:38:34 +0800
MIME-Version: 1.0
In-Reply-To: <20200224083845-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>


On 2020/2/24 =E4=B8=8B=E5=8D=889:40, Michael S. Tsirkin wrote:
>> Subject: [PATCH] vhost: do not set VIRTIO_F_IOMMU_PLATFORM when IOMMU =
is not
>>   used
>>
>> We enable device IOTLB unconditionally when VIRTIO_F_IOMMU_PLATFORM is
>> negotiated. This lead unnecessary IOTLB miss/update transactions when
>> IOMMU is used. This patch fixes this.
>>
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>> ---
>>   hw/net/virtio-net.c | 3 +++
>>   hw/virtio/vhost.c   | 4 +---
>>   2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 3627bb1717..0d50e8bd34 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -879,6 +879,9 @@ static void virtio_net_set_features(VirtIODevice *=
vdev, uint64_t features)
>>           virtio_net_apply_guest_offloads(n);
>>       }
>>  =20
>> +    if (vdev->dma_as =3D=3D &address_space_memory)
>> +        features &=3D ~(1ULL << VIRTIO_F_IOMMU_PLATFORM);
>> +
>>       for (i =3D 0;  i < n->max_queues; i++) {
>>           NetClientState *nc =3D qemu_get_subqueue(n->nic, i);
> This pokes at acked features. I think they are also
> guest visible ...


It's the acked features of vhost device, so I guess not?

E.g virtio_set_features_nocheck() did:

 =C2=A0=C2=A0=C2=A0 val &=3D vdev->host_features;
 =C2=A0=C2=A0=C2=A0 if (k->set_features) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->set_features(vdev, val);
 =C2=A0=C2=A0=C2=A0 }
 =C2=A0=C2=A0=C2=A0 vdev->guest_features =3D val;

Thanks

>
