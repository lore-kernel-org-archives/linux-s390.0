From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PULL v2 1/1] virtio/s390: implement PM operations for virtio_ccw
Date: Wed, 14 Feb 2018 14:37:17 +0200
Message-ID: <20180214143226-mutt-send-email-mst@kernel.org>
References: <20171218162123.963-1-cohuck@redhat.com>
 <20171218162123.963-2-cohuck@redhat.com>
 <1e030d8d-0185-ee75-eda4-5551412db096@de.ibm.com>
 <20180214131652.1908763e.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180214131652.1908763e.cohuck@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, jasowang@redhat.com, pasic@linux.vnet.ibm.com, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Feb 14, 2018 at 01:16:52PM +0100, Cornelia Huck wrote:
> On Mon, 12 Feb 2018 09:52:00 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
> > Michael, Conny,
> > it seems that this patch did not make it into 4.16-rc1.
> 
> Michael, please let me know what you plan to do with the
> virtio-s390-20171218-v2 pull request.

My bad, I did not realize you expect me to merge pulls.
I pretty much can't because I rebase my tree.
I've applied this patch on the vhost branch - will merge
as a bugfix.

> > 
> > 
> > 
> > On 12/18/2017 05:21 PM, Cornelia Huck wrote:
> > > From: Christian Borntraeger <borntraeger@de.ibm.com>
> > > 
> > > Suspend/Resume to/from disk currently fails. Let us wire
> > > up the necessary callbacks. This is mostly just forwarding
> > > the requests to the virtio drivers. The only thing that
> > > has to be done in virtio_ccw itself is to re-set the
> > > virtio revision.
> > > 
> > > Suggested-by: Thomas Huth <thuth@redhat.com>
> > > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > > Message-Id: <20171207141102.70190-2-borntraeger@de.ibm.com>
> > > Reviewed-by: David Hildenbrand <david@redhat.com>
> > > [CH: merged <20171218083706.223836-1-borntraeger@de.ibm.com> to fix
> > > !CONFIG_PM configs]
> > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > > ---
> > >  drivers/s390/virtio/virtio_ccw.c | 29 +++++++++++++++++++++++++++++
> > >  1 file changed, 29 insertions(+)
> > > 
> > > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > > index b18fe2014cf2..985184ebda45 100644
> > > --- a/drivers/s390/virtio/virtio_ccw.c
> > > +++ b/drivers/s390/virtio/virtio_ccw.c
> > > @@ -1300,6 +1300,9 @@ static int virtio_ccw_cio_notify(struct ccw_device *cdev, int event)
> > >  		vcdev->device_lost = true;
> > >  		rc = NOTIFY_DONE;
> > >  		break;
> > > +	case CIO_OPER:
> > > +		rc = NOTIFY_OK;
> > > +		break;
> > >  	default:
> > >  		rc = NOTIFY_DONE;
> > >  		break;
> > > @@ -1312,6 +1315,27 @@ static struct ccw_device_id virtio_ids[] = {
> > >  	{},
> > >  };
> > > 
> > > +#ifdef CONFIG_PM_SLEEP
> > > +static int virtio_ccw_freeze(struct ccw_device *cdev)
> > > +{
> > > +	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
> > > +
> > > +	return virtio_device_freeze(&vcdev->vdev);
> > > +}
> > > +
> > > +static int virtio_ccw_restore(struct ccw_device *cdev)
> > > +{
> > > +	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
> > > +	int ret;
> > > +
> > > +	ret = virtio_ccw_set_transport_rev(vcdev);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return virtio_device_restore(&vcdev->vdev);
> > > +}
> > > +#endif
> > > +
> > >  static struct ccw_driver virtio_ccw_driver = {
> > >  	.driver = {
> > >  		.owner = THIS_MODULE,
> > > @@ -1324,6 +1348,11 @@ static struct ccw_driver virtio_ccw_driver = {
> > >  	.set_online = virtio_ccw_online,
> > >  	.notify = virtio_ccw_cio_notify,
> > >  	.int_class = IRQIO_VIR,
> > > +#ifdef CONFIG_PM_SLEEP
> > > +	.freeze = virtio_ccw_freeze,
> > > +	.thaw = virtio_ccw_restore,
> > > +	.restore = virtio_ccw_restore,
> > > +#endif
> > >  };
> > > 
> > >  static int __init pure_hex(char **cp, unsigned int *val, int min_digit,
> > >   
> > 
