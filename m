From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue, 04 Apr 2017 12:40:21 +0000
Subject: Re: [bug report] vfio: ccw: introduce a finite state machine
Message-Id: <20170404144021.41559cd5.cornelia.huck@de.ibm.com>
In-Reply-To: <20170404120223.GA8525@mwanda>
References: <20170404120223.GA8525@mwanda>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 4 Apr 2017 15:02:24 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> Hello Dong Jia Shi,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch bbe37e4cb897: "vfio: ccw: introduce a finite state machine" 
> from Mar 17, 2017, leads to the following Smatch complaint:
> 
>     drivers/s390/cio/vfio_ccw_ops.c:151 vfio_ccw_mdev_remove()
>     error: we previously assumed 'private' could be null (see line 137)
> 
> drivers/s390/cio/vfio_ccw_ops.c
>    131  static int vfio_ccw_mdev_remove(struct mdev_device *mdev)
>    132  {
>    133          struct vfio_ccw_private *private =
>    134                  dev_get_drvdata(mdev_parent_dev(mdev));
>    135          int ret;
>    136	
>    137		if (!private)
>                     ^^^^^^^^
> New check for NULL.
> 
>    138			goto out;
> 
> I always feel like "out" is a crap name for a label because it doesn't
> give you any clue what the goto does.  Label names should be a verb
> goto inc_available.  I see this a lot in reviewing static checker
> warnings that out labels are more buggy than verb based labels.

'out' can be a good label name in certain situations, but it seems
there's some more confusion happening here anyway, so let's focus on
that.

I'm not quite clear when private can actually be NULL, as code grabbing
the driver data of the mdev device sometimes checks for it and
sometimes doesn't.

> 
>    139	
>    140		if ((private->state == VFIO_CCW_STATE_NOT_OPER) ||
>    141		    (private->state == VFIO_CCW_STATE_STANDBY))
>    142			goto out;

It would be more readable to reverse that condition, I think.

>    143	
>    144		ret = vfio_ccw_mdev_reset(mdev);
>    145		if (ret)
>    146			return ret;

Is the exit actually correct here? Don't we need to set an error state
or something?

>    147	
>    148		private->state = VFIO_CCW_STATE_STANDBY;
>    149	
>    150	out:
>    151		private->mdev = NULL;
>                 ^^^^^^^^^^^^^^^^^^^^^
> New dereference.
> 
>    152		atomic_inc(&private->avail);
>    153	
