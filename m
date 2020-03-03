Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43359 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729372AbgCCOta (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Mar 2020 09:49:30 -0500
Received: by mail-qv1-f72.google.com with SMTP id s2so1421202qvt.16
        for <linux-s390@vger.kernel.org>; Tue, 03 Mar 2020 06:49:27 -0800 (PST)
Date: Tue, 3 Mar 2020 09:49:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/2] virtio-blk: improve handling of DMA mapping failures
Message-ID: <20200303094909-mutt-send-email-mst@kernel.org>
References: <20200213123728.61216-1-pasic@linux.ibm.com>
 <20200303151252.59d45e86.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303151252.59d45e86.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>

On Tue, Mar 03, 2020 at 03:12:52PM +0100, Halil Pasic wrote:
> On Thu, 13 Feb 2020 13:37:26 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > Two patches are handling new edge cases introduced by doing DMA mappings
> > (which can fail) in virtio core.
> > 
> > I stumbled upon this while stress testing I/O for Protected Virtual
> > Machines. I deliberately chose a tiny swiotlb size and have generated
> > load with fio. With more than one virtio-blk disk in use I experienced
> > hangs.
> > 
> > The goal of this series is to fix those hangs.
> > 
> > Halil Pasic (2):
> >   virtio-blk: fix hw_queue stopped on arbitrary error
> >   virtio-blk: improve virtqueue error to BLK_STS
> > 
> >  drivers/block/virtio_blk.c | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> > 
> > 
> > base-commit: 39bed42de2e7d74686a2d5a45638d6a5d7e7d473
> 
> ping
> 
> Hi Michael, hi Jason,
> 
> I got some favorable reviews for this, but AFAIK I got nothing form the
> maintainers yet.
> 
> Is some of you going to pick these?
> 
> Regards,
> Halil

I've queued this, thanks!
