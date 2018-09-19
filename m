From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 1/2] virtio/s390: avoid race on vcdev->config
Date: Wed, 19 Sep 2018 13:28:44 +0200
Message-ID: <20180919132844.6b85838b.cohuck@redhat.com>
References: <20180912140202.12292-1-pasic@linux.ibm.com>
	<20180912140202.12292-2-pasic@linux.ibm.com>
	<20180918202923.31829b3e.cohuck@redhat.com>
	<2f27c41d-4465-0fce-bbbb-b7b22a179eae@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <2f27c41d-4465-0fce-bbbb-b7b22a179eae@linux.ibm.com>
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
Cc: linux-s390@vger.kernel.org, Colin Ian King <colin.king@canonical.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 19 Sep 2018 00:52:14 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 09/18/2018 08:29 PM, Cornelia Huck wrote:
> > On Wed, 12 Sep 2018 16:02:01 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> >   
> >> Currently we have a race on vcdev->config in virtio_ccw_get_config() and
> >> in virtio_ccw_set_config().
> >>
> >> This normally does not cause problems, as these are usually infrequent
> >> operations. But occasionally sysfs attributes are directly dependent on
> >> pieces of virio config and trigger a get on each read. This gives us at
> >> least one trigger.  
> > 
> > So, the problem is that you might get unexpected/inconsistent config
> > information?
> >   
> >>
> >> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> >> ---
> >>  drivers/s390/virtio/virtio_ccw.c | 10 ++++++++--
> >>  1 file changed, 8 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> >> index 8f5c1d7f751a..a5e8530a3391 100644
> >> --- a/drivers/s390/virtio/virtio_ccw.c
> >> +++ b/drivers/s390/virtio/virtio_ccw.c
> >> @@ -828,6 +828,7 @@ static void virtio_ccw_get_config(struct virtio_device *vdev,
> >>  	int ret;
> >>  	struct ccw1 *ccw;
> >>  	void *config_area;
> >> +	unsigned long flags;
> >>  
> >>  	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
> >>  	if (!ccw)
> >> @@ -846,11 +847,13 @@ static void virtio_ccw_get_config(struct virtio_device *vdev,
> >>  	if (ret)
> >>  		goto out_free;
> >>  
> >> +	spin_lock_irqsave(&vcdev->lock, flags);  
> > 
> > I'm not sure that vcdev->lock is the right lock to use for this, but
> > I'm a bit unsure about what you're guarding against here.>  
> 
> I'm guarding against multiple threads using the shared state that is
> the config member of struct virtio_ccw_device so that at least one
> writes. I will continue with an example below.

Ok.

>  
> >>  	memcpy(vcdev->config, config_area, offset + len);
> >> -	if (buf)
> >> -		memcpy(buf, &vcdev->config[offset], len);
> >>  	if (vcdev->config_ready < offset + len)
> >>  		vcdev->config_ready = offset + len;
> >> +	spin_unlock_irqrestore(&vcdev->lock, flags);
> >> +	if (buf)
> >> +		memcpy(buf, config_area + offset, len);
> >>  
> >>  out_free:
> >>  	kfree(config_area);
> >> @@ -864,6 +867,7 @@ static void virtio_ccw_set_config(struct virtio_device *vdev,
> >>  	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
> >>  	struct ccw1 *ccw;
> >>  	void *config_area;
> >> +	unsigned long flags;
> >>  
> >>  	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
> >>  	if (!ccw)
> >> @@ -876,9 +880,11 @@ static void virtio_ccw_set_config(struct virtio_device *vdev,
> >>  	/* Make sure we don't overwrite fields. */
> >>  	if (vcdev->config_ready < offset)
> >>  		virtio_ccw_get_config(vdev, 0, NULL, offset);
> >> +	spin_lock_irqsave(&vcdev->lock, flags);
> >>  	memcpy(&vcdev->config[offset], buf, len);
> >>  	/* Write the config area to the host. */
> >>  	memcpy(config_area, vcdev->config, sizeof(vcdev->config));  
> 
> While in this section which is critical now, we could have raced
> with another thread that is writing the vcdev->config (critical section in get)
> that we are reading. That could result in something that could never happen if the
> operations are serialized.

So, the race is basically on the memcpy?

> 
> >> +	spin_unlock_irqrestore(&vcdev->lock, flags);
> >>  	ccw->cmd_code = CCW_CMD_WRITE_CONF;
> >>  	ccw->flags = 0;
> >>  	ccw->count = offset + len;  
> > 
> > One thing that might be a problem here is how reading/writing the
> > config stuff works for virtio-ccw: As channel devices don't have a
> > config space like e.g. PCI devices, I had to come up with a way to
> > implement something like that via dedicated channel commands. I did not
> > want to go via a payload that would provide offset/length, but went
> > with reading/writing everything before the value to be read/written as
> > well. That means we need to call read before write to make sure we
> > don't overwrite things (as the comment states), and how this is done
> > might be problematic.
> >   
> 
> Nod.
> 
> > I'm thinking what we may need is a way to make "read and then write" a
> > single operation and make sure that it does not run concurrently with
> > the simple read operation. Factor out the proper invocation of the read
> > command and the status update, have get_config call this with a reader
> > lock and have set_config call the read-then-write combo with a write
> > lock, maybe?
> >   
> 
> I'm inclined to say. The other tread doing the get may only get us more
> recent results, and that should at least as good. Our get is guaranteed
> to finish, so we won't write complete garbage.
> 
> AFAIR the config can change form the other side too. In that sense making
> the read and the write one operation on the other side would help make us
> completely sane. 

Yes, config fields may be writeable both by the host and by the guest.

> But at the moment I don't think that what you propose
> here is giving us an edge over this patch.

It is probably a bit cleaner concept wise, but I'm not wedded to it.

Another thing that comes to mind is that 'config generation' thing,
which is used on e.g. PCI to make sure that values longer than 32 bits
are consistent. I wonder whether we should explore that direction as
well.
