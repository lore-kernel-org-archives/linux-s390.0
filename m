From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH] KVM: s390: virtio_ccw: reset errors for new I/O.
Date: Thu, 4 Apr 2013 12:20:03 +0200
Message-ID: <20130404122003.17bd05fa@gondolin>
References: <1365063906-61392-1-git-send-email-cornelia.huck@de.ibm.com>
	<1365063906-61392-2-git-send-email-cornelia.huck@de.ibm.com>
	<FFC59559-C498-4EA4-971A-A61436932654@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <FFC59559-C498-4EA4-971A-A61436932654@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 4 Apr 2013 11:28:35 +0200
Alexander Graf <agraf@suse.de> wrote:

> 
> On 04.04.2013, at 10:25, Cornelia Huck wrote:
> 
> > ccw_io_helper neglected to reset vcdev->err after a new channel
> > program had been successfully started, resulting in stale errors
> > delivered after one I/O failed. Reset the error after a new
> > channel program has been successfully started with no old I/O
> > pending.
> > 
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> Shouldn't this be CC: stable?

I don't think so, current code will not continue after errors anyway.

> 
> 
> Alex
> 
> > ---
> > drivers/s390/kvm/virtio_ccw.c | 5 ++++-
> > 1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
> > index 42d507c..5948f2a 100644
> > --- a/drivers/s390/kvm/virtio_ccw.c
> > +++ b/drivers/s390/kvm/virtio_ccw.c
> > @@ -133,8 +133,11 @@ static int ccw_io_helper(struct virtio_ccw_device *vcdev,
> > 	do {
> > 		spin_lock_irqsave(get_ccwdev_lock(vcdev->cdev), flags);
> > 		ret = ccw_device_start(vcdev->cdev, ccw, intparm, 0, 0);
> > -		if (!ret)
> > +		if (!ret) {
> > +			if (!vcdev->curr_io)
> > +				vcdev->err = 0;
> > 			vcdev->curr_io |= flag;
> > +		}
> > 		spin_unlock_irqrestore(get_ccwdev_lock(vcdev->cdev), flags);
> > 		cpu_relax();
> > 	} while (ret == -EBUSY);
> > -- 
> > 1.7.12.4
> > 
> 
