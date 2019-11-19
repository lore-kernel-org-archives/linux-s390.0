Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21229 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725798AbfKSNEl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Nov 2019 08:04:41 -0500
Received: by mail-qv1-f71.google.com with SMTP id 41so14700326qvw.5
        for <linux-s390@vger.kernel.org>; Tue, 19 Nov 2019 05:04:37 -0800 (PST)
Date: Tue, 19 Nov 2019 08:04:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/1] virtio_ring: fix return code on DMA mapping fails
Message-ID: <20191119080420-mutt-send-email-mst@kernel.org>
References: <20191114124646.74790-1-pasic@linux.ibm.com>
 <20191119121022.03aed69a.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20191119121022.03aed69a.pasic@linux.ibm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, Michael Mueller <mimu@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Christoph Hellwig <hch@lst.de>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Andy Lutomirski <luto@kernel.org>

Will be in the next pull request.

On Tue, Nov 19, 2019 at 12:10:22PM +0100, Halil Pasic wrote:
> ping
>=20
> On Thu, 14 Nov 2019 13:46:46 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
>=20
> > Commit 780bc7903a32 ("virtio_ring: Support DMA APIs")  makes
> > virtqueue_add() return -EIO when we fail to map our I/O buffers. This i=
s
> > a very realistic scenario for guests with encrypted memory, as swiotlb
> > may run out of space, depending on it's size and the I/O load.
> >=20
> > The virtio-blk driver interprets -EIO form virtqueue_add() as an IO
> > error, despite the fact that swiotlb full is in absence of bugs a
> > recoverable condition.
> >=20
> > Let us change the return code to -ENOMEM, and make the block layer
> > recover form these failures when virtio-blk encounters the condition
> > described above.
> >=20
> > Fixes: 780bc7903a32 ("virtio_ring: Support DMA APIs")
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > Tested-by: Michael Mueller <mimu@linux.ibm.com>
> > ---
> >=20
> > Notes
> > =3D=3D=3D=3D=3D
> >=20
> > * When out of descriptors (which might regarded as a similar out of
> > resources condition) virtio uses -ENOSPC, this however seems wrong,
> > as ENOSPC is defined as -ENOSPC. Thus I choose -ENOMEM over -ENOSPC.
> >=20
> > * In virtio_queue_rq() in virtio_blk.c both -ENOMEM and -ENOSPC are
> > handled as BLK_STS_DEV_RESOURCE. Returning BLK_STS_RESOURCE however
> > seems more appropriate for dma mapping failed as we are talking about
> > a global, and not a device local resource. Both seem to do the trick.
> >=20
> > * Mimu tested the patch with virtio-blk and virtio-net (thanks!). We
> > should look into how other virtio devices behave when DMA mapping fails=
.
> > ---
> >  drivers/virtio/virtio_ring.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index a8041e451e9e..867c7ebd3f10 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -583,7 +583,7 @@ static inline int virtqueue_add_split(struct virtqu=
eue *_vq,
> >  =09=09kfree(desc);
> > =20
> >  =09END_USE(vq);
> > -=09return -EIO;
> > +=09return -ENOMEM;
> >  }
> > =20
> >  static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
> > @@ -1085,7 +1085,7 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
> >  =09kfree(desc);
> > =20
> >  =09END_USE(vq);
> > -=09return -EIO;
> > +=09return -ENOMEM;
> >  }
> > =20
> >  static inline int virtqueue_add_packed(struct virtqueue *_vq,
