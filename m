From: Halil Pasic <pasic@linux.ibm.com>
Date: Mon, 07 Jan 2019 15:33:50 +0000
Subject: Re: [PATCH 1/1] s390/virtio: handle find on invalid queue gracefully
Message-Id: <20190107163350.3f220041@oc2783563651>
In-Reply-To: <20190107160632.06b6f624.cohuck@redhat.com>
References: <20190107160632.06b6f624.cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 7 Jan 2019 16:06:32 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Mon,  7 Jan 2019 13:31:46 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > A queue with a capacity of zero is clearly not a valid virtio queue.
> > Some emulators report zero queue size if queried with an invalid queue
> > index. Instead of crashing in this case let us just return -EINVAL. To
> 
> s/-EINVAL/-ENOENT/
> 

So I did forget something, again. :/ Thanks for spotting it!

> > make that work properly, let us fix the notifier cleanup logic as well.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > ---
> > This patch is motivated by commit 86a5597 "virtio-balloon:
> > VIRTIO_BALLOON_F_FREE_PAGE_HINT" (Wei Wang, 2018-08-27) which triggered
> > the described scenario.  The emulator in question is the current QEMU.
> > The problem we run into is the underflow in the following loop
> > in  __vring_new_virtqueue():
> > for (i = 0; i < vring.num-1; i++)
> > 	vq->vring.desc[i].next = cpu_to_virtio16(vdev, i + 1)
> > Namely vring.num is an unsigned int.
> > 
> > RFC --> v1:
> > * Change error code from -EINVAL to -ENOENT, so we are in line with the
> > other transports.
> > * Push down the detection of the error into virtio_ccw_read_vq_conf().
> > ---
> >  drivers/s390/virtio/virtio_ccw.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Thanks, applied.
> 

Thanks!
Halil
