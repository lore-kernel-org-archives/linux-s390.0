From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC v2 06/15] vfio: ccw: register vfio_ccw
 to the mediated device framework
Date: Wed, 18 Jan 2017 10:28:58 +0800
Message-ID: <21175.4413940527$1505296729@news.gmane.org>
References: <20170112071947.98071-1-bjsdjshi@linux.vnet.ibm.com>
	<20170112071947.98071-7-bjsdjshi@linux.vnet.ibm.com>
	<20170117140233.4e169979@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
Content-Disposition: inline
In-Reply-To: <20170117140233.4e169979@t450s.home>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: "Qemu-devel" <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-s390@vger.kernel.org, pasic@linux.vnet.ibm.com, kvm@vger.kernel.org, pmorel@linux.vnet.ibm.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, renxiaof@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, agraf@suse.com
List-ID: <linux-s390.vger.kernel.org>

* Alex Williamson <alex.williamson@redhat.com> [2017-01-17 14:02:33 -0700]:

[...]

> > diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
[...]

> > +static int vfio_ccw_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
> > +{
> > +	struct vfio_ccw_private *private = dev_get_drvdata(mdev->parent->dev);
> > +
> > +	/* Only support one mediated device for each physical subchannel. */
> > +	if (private->mdev)
> > +		return -EPERM;
> > +
> > +	private->mdev = mdev;
> > +	available_instances--;
> 
> 
> This looks racy and doesn't enforce the available instances.  Should
> this maybe be an atomic_t and use atomic_dec_if_positive() to return an
> error if no instances are available?
Hi Alex,

You are right. I will fix this according to your comment.

> 
> 
> > +
> > +	return 0;
> > +}
> > +

[...]

-- 
Dong Jia
