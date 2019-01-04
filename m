From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 1/1] s390/virtio: handle find on invalid queue
	gracefully
Date: Fri, 4 Jan 2019 15:01:49 +0100
Message-ID: <20190104150149.465ec71b.cohuck@redhat.com>
References: <20190102175020.45251-1-pasic@linux.ibm.com>
	<20190102192549.7d7fe4c4.cohuck@redhat.com>
	<20190103140010.191ce605@oc2783563651>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190103140010.191ce605@oc2783563651>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 3 Jan 2019 14:00:10 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Wed, 2 Jan 2019 19:25:49 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Wed,  2 Jan 2019 18:50:20 +0100
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> >   
> > > A queue with a capacity of zero is clearly not a valid virtio queue.
> > > Some emulators report zero queue size if queried with an invalid queue
> > > index. Instead of crashing in this case let us just return -EINVAL. To
> > > make that work properly, let us fix the notifier cleanup logic as well.
> > > 
> > > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > > ---
> > > 
> > > This patch is motivated by commit 86a5597 "virtio-balloon:
> > > VIRTIO_BALLOON_F_FREE_PAGE_HINT" (Wei Wang, 2018-08-27) which triggered
> > > the described scenario.  The emulator in question is the current QEMU.
> > > The problem we run into is the underflow in the following loop
> > > in  __vring_new_virtqueue():
> > > for (i = 0; i < vring.num-1; i++)
> > > 	vq->vring.desc[i].next = cpu_to_virtio16(vdev, i + 1)
> > > Namely vring.num is an unsigned int.
> > > 
> > > RFC because I'm not sure about -EINVAL being a good choice, and about
> > > us caring about what happens if a virtio driver misbehaves like described.  
> > 
> > For virtio-pci, the spec says that a zero queue size means that the
> > queue is unavailable. I don't think we have specified that explicitly
> > for virtio-ccw, but it does make sense.
> > 
> > virtio-pci returns -ENOENT in that case, which might be a good choice
> > here as well.  
> 
> virtio-mmio does the same. I will change it to -ENOENT. Maybe also do
> something like 
> int virtio_ccw_read_vq_conf() {
> [..]
> 	return vcdev->config_block->num ?: -ENOENT;
> }
> 
> instead of the extra if statement, or?


Yes, why not.

> 
> >   
> > > 
> > > ---
> > >  drivers/s390/virtio/virtio_ccw.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > > index fc9dbad476c0..147927ed4fca 100644
> > > --- a/drivers/s390/virtio/virtio_ccw.c
> > > +++ b/drivers/s390/virtio/virtio_ccw.c
> > > @@ -272,6 +272,8 @@ static void virtio_ccw_drop_indicators(struct virtio_ccw_device *vcdev)
> > >  {
> > >  	struct virtio_ccw_vq_info *info;
> > >  
> > > +	if (!vcdev->airq_info)
> > > +		return;  
> > 
> > Which case is this guarding against? names[i] was NULL for every index?
> >   
> 
> Consider:
> static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,       
>                                struct virtqueue *vqs[],                         
>                                vq_callback_t *callbacks[],                      
>                                const char * const names[],                      
>                                const bool *ctx,                                 
>                                struct irq_affinity *desc)                       
> {                                                                               
>         struct virtio_ccw_device *vcdev = to_vc_device(vdev);                   
>         unsigned long *indicatorp = NULL;                                       
>         int ret, i;                                                             
>         struct ccw1 *ccw;                                                       
>                                                                                 
>         ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);                      
>         if (!ccw)                                                               
>                 return -ENOMEM;                                                 
>                                                                                 
>         for (i = 0; i < nvqs; ++i) {                                            
>                 vqs[i] = virtio_ccw_setup_vq(vdev, i, callbacks[i], names[i],   
>                                              ctx ? ctx[i] : false, ccw);        
>                 if (IS_ERR(vqs[i])) {                                           
>                         ret = PTR_ERR(vqs[i]);                                  
>                         vqs[i] = NULL;                                          
>                         goto out;                                               
>                 }                                                               
>         }                      
> [..]
>         if (vcdev->is_thinint) {                                                
>                 ret = virtio_ccw_register_adapter_ind(vcdev, vqs, nvqs, ccw);   
>                 if (ret)                                                        
>                         /* no error, just fall back to legacy interrupts */     
>                         vcdev->is_thinint = false;                              
>         }
> [..]
> out:                                                                            
>         kfree(indicatorp);                                                      
>         kfree(ccw);                                                             
>         virtio_ccw_del_vqs(vdev);                                               
>         return ret;                                                             
> } 
> when the loop that calls virtio_ccw_setup_vq() fails after a couple
> of iterations. We end up with some queues in vcdev->virtqueues but
> with virtio_ccw_register_adapter_ind() never called and thus with
> vcdev->airq_info never set. So when virtio_ccw_del_vqs() tries to clean
> up we get an invalid pointer dereference.
> 
> Does that answer your question?

Yes, thanks.

> 
> I don't quite get your comments about names[i] == NULL.

I was looking at a tree with "virtio: don't allocate vqs when names[i]
= NULL" applied :)
