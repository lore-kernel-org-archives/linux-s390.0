From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
Date: Mon, 21 Jan 2019 21:20:18 +0100
Message-ID: <20190121212018.4e377e59@oc2783563651>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20190121110354.2247-3-cohuck@redhat.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, qemu-s390x@nongnu.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 21 Jan 2019 12:03:51 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> Rework handling of multiple I/O requests to return -EAGAIN if
> we are already processing an I/O request. Introduce a mutex
> to disallow concurrent writes to the I/O region.
> 
> The expectation is that userspace simply retries the operation
> if it gets -EAGAIN.
> 
> We currently don't allow multiple ssch requests at the same
> time, as we don't have support for keeping channel programs
> around for more than one request.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---

[..]

>  static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
> @@ -188,25 +192,30 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
>  {
>  	struct vfio_ccw_private *private;
>  	struct ccw_io_region *region;
> +	int ret;
>  
>  	if (*ppos + count > sizeof(*region))
>  		return -EINVAL;
>  
>  	private = dev_get_drvdata(mdev_parent_dev(mdev));
> -	if (private->state != VFIO_CCW_STATE_IDLE)
> +	if (private->state == VFIO_CCW_STATE_NOT_OPER ||
> +	    private->state == VFIO_CCW_STATE_STANDBY)
>  		return -EACCES;
> +	if (!mutex_trylock(&private->io_mutex))
> +		return -EAGAIN;
>  
>  	region = private->io_region;
> -	if (copy_from_user((void *)region + *ppos, buf, count))
> -		return -EFAULT;
> +	if (copy_from_user((void *)region + *ppos, buf, count)) {

This might race with vfio_ccw_sch_io_todo() on
private->io_region->irb_area, or?

> +		ret = -EFAULT;
> +		goto out_unlock;
> +	}
>  
>  	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_IO_REQ);
> -	if (region->ret_code != 0) {
> -		private->state = VFIO_CCW_STATE_IDLE;
> -		return region->ret_code;
> -	}
> +	ret = (region->ret_code != 0) ? region->ret_code : count;
>  
> -	return count;
> +out_unlock:
> +	mutex_unlock(&private->io_mutex);
> +	return ret;
>  }
>  
[..]
