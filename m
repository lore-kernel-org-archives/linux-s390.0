From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 1/2] virtio/s390: avoid race on vcdev->config
Date: Tue, 18 Sep 2018 20:29:23 +0200
Message-ID: <20180918202923.31829b3e.cohuck@redhat.com>
References: <20180912140202.12292-1-pasic@linux.ibm.com>
	<20180912140202.12292-2-pasic@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180912140202.12292-2-pasic@linux.ibm.com>
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

On Wed, 12 Sep 2018 16:02:01 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> Currently we have a race on vcdev->config in virtio_ccw_get_config() and
> in virtio_ccw_set_config().
> 
> This normally does not cause problems, as these are usually infrequent
> operations. But occasionally sysfs attributes are directly dependent on
> pieces of virio config and trigger a get on each read. This gives us at
> least one trigger.

So, the problem is that you might get unexpected/inconsistent config
information?

> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index 8f5c1d7f751a..a5e8530a3391 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -828,6 +828,7 @@ static void virtio_ccw_get_config(struct virtio_device *vdev,
>  	int ret;
>  	struct ccw1 *ccw;
>  	void *config_area;
> +	unsigned long flags;
>  
>  	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
>  	if (!ccw)
> @@ -846,11 +847,13 @@ static void virtio_ccw_get_config(struct virtio_device *vdev,
>  	if (ret)
>  		goto out_free;
>  
> +	spin_lock_irqsave(&vcdev->lock, flags);

I'm not sure that vcdev->lock is the right lock to use for this, but
I'm a bit unsure about what you're guarding against here.

>  	memcpy(vcdev->config, config_area, offset + len);
> -	if (buf)
> -		memcpy(buf, &vcdev->config[offset], len);
>  	if (vcdev->config_ready < offset + len)
>  		vcdev->config_ready = offset + len;
> +	spin_unlock_irqrestore(&vcdev->lock, flags);
> +	if (buf)
> +		memcpy(buf, config_area + offset, len);
>  
>  out_free:
>  	kfree(config_area);
> @@ -864,6 +867,7 @@ static void virtio_ccw_set_config(struct virtio_device *vdev,
>  	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
>  	struct ccw1 *ccw;
>  	void *config_area;
> +	unsigned long flags;
>  
>  	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
>  	if (!ccw)
> @@ -876,9 +880,11 @@ static void virtio_ccw_set_config(struct virtio_device *vdev,
>  	/* Make sure we don't overwrite fields. */
>  	if (vcdev->config_ready < offset)
>  		virtio_ccw_get_config(vdev, 0, NULL, offset);
> +	spin_lock_irqsave(&vcdev->lock, flags);
>  	memcpy(&vcdev->config[offset], buf, len);
>  	/* Write the config area to the host. */
>  	memcpy(config_area, vcdev->config, sizeof(vcdev->config));
> +	spin_unlock_irqrestore(&vcdev->lock, flags);
>  	ccw->cmd_code = CCW_CMD_WRITE_CONF;
>  	ccw->flags = 0;
>  	ccw->count = offset + len;

One thing that might be a problem here is how reading/writing the
config stuff works for virtio-ccw: As channel devices don't have a
config space like e.g. PCI devices, I had to come up with a way to
implement something like that via dedicated channel commands. I did not
want to go via a payload that would provide offset/length, but went
with reading/writing everything before the value to be read/written as
well. That means we need to call read before write to make sure we
don't overwrite things (as the comment states), and how this is done
might be problematic.

I'm thinking what we may need is a way to make "read and then write" a
single operation and make sure that it does not run concurrently with
the simple read operation. Factor out the proper invocation of the read
command and the status update, have get_config call this with a reader
lock and have set_config call the read-then-write combo with a write
lock, maybe?

I might not understand the problem correctly, though (or I might have
spent too much time reading email today already :)
