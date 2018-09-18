From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 2/2] virtio/s390: fix race in ccw_io_helper()
Date: Tue, 18 Sep 2018 20:45:47 +0200
Message-ID: <20180918204547.2500c848.cohuck@redhat.com>
References: <20180912140202.12292-1-pasic@linux.ibm.com>
	<20180912140202.12292-3-pasic@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180912140202.12292-3-pasic@linux.ibm.com>
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

On Wed, 12 Sep 2018 16:02:02 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> While ccw_io_helper() seems like intended to be exclusive in a sense that
> it is supposed to facilitate I/O for at most one thread at any given
> time, there is actually nothing ensuring that threads won't pile up at
> vcdev->wait_q. If they all threads get woken up and see the status that
> belongs to some other request as their own. This can lead to bugs. For an
> example see :
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1788432
> 
> This normally does not cause problems, as these are usually infrequent
> operations that happen in a well defined sequence and normally do not
> fail. But occasionally sysfs attributes are directly dependent
> on pieces of virio config and trigger a get on each read.  This gives us
> at least one method to trigger races.

Yes, the idea behind ccw_io_helper() was to provide a simple way to use
the inherently asynchronous channel I/O operations in a synchronous
way, as that's what the virtio callbacks expect. I did not consider
multiple callbacks for a device running at the same time; but if the
interface allows that, we obviously need to be able to handle it.

Has this only been observed for the config get/set commands? (The
read-before-write thing?)

> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Reported-by: Colin Ian King <colin.king@canonical.com>
> ---
> 
> This is a big hammer -- mutex on virtio_ccw device level would more than
> suffice. But I don't think it hurts, and maybe there is a better way e.g.
> one using some common ccw/cio mechanisms to address this. That's why this
> is an RFC.

I'm for using more delicate tools, if possible :)

We basically have two options:
- Have a way to queue I/O operations and then handle them in sequence.
  Creates complexity, and is likely overkill. (We already have a kind
  of serialization because we re-submit the channel program until the
  hypervisor accepts it; the problem comes from the wait queue usage.)
- Add serialization around the submit/wait procedure (as you did), but
  with a per-device mutex. That looks like the easiest solution.

> ---
>  drivers/s390/virtio/virtio_ccw.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index a5e8530a3391..36252f344660 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -289,6 +289,8 @@ static int doing_io(struct virtio_ccw_device *vcdev, __u32 flag)
>  	return ret;
>  }
>  
> +DEFINE_MUTEX(vcio_mtx);
> +
>  static int ccw_io_helper(struct virtio_ccw_device *vcdev,
>  			 struct ccw1 *ccw, __u32 intparm)
>  {
> @@ -296,6 +298,7 @@ static int ccw_io_helper(struct virtio_ccw_device *vcdev,
>  	unsigned long flags;
>  	int flag = intparm & VIRTIO_CCW_INTPARM_MASK;
>  
> +	mutex_lock(&vcio_mtx);
>  	do {
>  		spin_lock_irqsave(get_ccwdev_lock(vcdev->cdev), flags);
>  		ret = ccw_device_start(vcdev->cdev, ccw, intparm, 0, 0);
> @@ -308,7 +311,9 @@ static int ccw_io_helper(struct virtio_ccw_device *vcdev,
>  		cpu_relax();
>  	} while (ret == -EBUSY);

We probably still want to keep this while loop to be on the safe side
(unsolicited status from the hypervisor, for example.)

>  	wait_event(vcdev->wait_q, doing_io(vcdev, flag) == 0);
> -	return ret ? ret : vcdev->err;
> +	ret = ret ? ret : vcdev->err;
> +	mutex_unlock(&vcio_mtx);
> +	return ret;
>  }
>  
>  static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
