From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v3 0/3] virtio DMA API core stuff
Date: Wed, 28 Oct 2015 00:09:54 -0700
Message-ID: <CALCETrVGggDO94DdAMUsA0KyJnvqLXT4mWcc18VRBft+DsUN4g@mail.gmail.com>
References: <cover.1446014204.git.luto@kernel.org> <1446015204.3405.186.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1446015204.3405.186.camel@infradead.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, KVM <kvm@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Oct 27, 2015 at 11:53 PM, David Woodhouse <dwmw2@infradead.org> wrote:
> On Tue, 2015-10-27 at 23:38 -0700, Andy Lutomirski wrote:
>>
>> Changes from v2:
>>  - Fix really embarrassing bug.  This version actually works.
>
> So embarrassing you didn't want to tell us what it was? ...

Shhh, it's a secret!

I somehow managed to test-boot a different kernel than I thought I was booting.

>
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -292,7 +292,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
>                         vq, desc, total_sg * sizeof(struct vring_desc),
>                         DMA_TO_DEVICE);
>
> -               if (vring_mapping_error(vq, vq->vring.desc[head].addr))
> +               if (vring_mapping_error(vq, addr))
>                         goto unmap_release;
>
>                 vq->vring.desc[head].flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_INDIRECT);
>
> That wasn't going to be the reason for Christian's failure, was it?
>

Not obviously, but it's possible.  Now that I'm staring at it, I have
some more big-endian issues, so there'll be a v4.  I'll also play with
Michael's thing.  Expect a long delay, though -- my flight's about to
leave.

The readme notwithstanding, virtme (https://github.com/amluto/virtme)
actually has s390x support, so I can try to debug when I get home.
I'm not about to try doing this on a laptop :)

--Andy
