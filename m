From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v11 13/26] s390: vfio-ap: zeroize the AP queues
Date: Thu, 27 Sep 2018 09:04:28 +0200
Message-ID: <20180927090428.5d96d7c0.cohuck@redhat.com>
References: <20180925231641.4954-1-akrowiak@linux.vnet.ibm.com>
        <20180925231641.4954-14-akrowiak@linux.vnet.ibm.com>
        <20180926153831.195af1ce.cohuck@redhat.com>
        <b82748bd-98e5-9db8-a9ca-f1a9ee6bb2e0@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b82748bd-98e5-9db8-a9ca-f1a9ee6bb2e0@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 26 Sep 2018 20:58:41 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 09/26/2018 03:38 PM, Cornelia Huck wrote:
> > On Tue, 25 Sep 2018 19:16:28 -0400
> > Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> >   
> >> From: Tony Krowiak <akrowiak@linux.ibm.com>
> >>
> >> Let's call PAPQ(ZAPQ) to zeroize a queue for each queue configured
> >> for a mediated matrix device when it is released.
> >>
> >> Zeroizing a queue resets the queue, clears all pending
> >> messages for the queue entries and disables adapter interruptions
> >> associated with the queue.
> >>
> >> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> >> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> >> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> >> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> >> ---
> >>  drivers/s390/crypto/vfio_ap_ops.c | 44 +++++++++++++++++++++++++++++++
> >>  1 file changed, 44 insertions(+)
(...)
> >> +static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
> >> +{
> >> +	int ret;
> >> +	int rc = 0;
> >> +	unsigned long apid, apqi;
> >> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> >> +
> >> +	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
> >> +			     matrix_mdev->matrix.apm_max + 1) {
> >> +		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
> >> +				     matrix_mdev->matrix.aqm_max + 1) {
> >> +			ret = vfio_ap_mdev_reset_queue(apid, apqi, 1);  
> > 
> > I'd still like to see a comment here:
> > 
> > /*
> >  * Regardless whether a queue turns out to be busy, or is not
> >  * operational, we need to continue resetting the remaining
> >  * queues.
> >  */  
> 
> I added your proposal to the apv11 branch.

Thanks. With that added,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
