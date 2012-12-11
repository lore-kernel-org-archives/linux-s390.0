From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 3/5] s390: Add a mechanism to get the subchannel id.
Date: Tue, 11 Dec 2012 13:34:18 +0100
Message-ID: <20121211133418.5eb58cd0@BR9GNB5Z>
References: <1354883369-36537-1-git-send-email-cornelia.huck@de.ibm.com>
	<1354883369-36537-4-git-send-email-cornelia.huck@de.ibm.com>
	<53E49765-6413-4E4A-A0A2-4A63E6CD814C@suse.de>
	<20121210100301.021b9d3e@BR9GNB5Z>
	<8EFB3FAF-AD87-4263-B190-0ED30ABED5DB@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <8EFB3FAF-AD87-4263-B190-0ED30ABED5DB@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Avi Kivity <avi.kivity@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 11 Dec 2012 11:09:55 +0100
Alexander Graf <agraf@suse.de> wrote:

> 
> On 10.12.2012, at 10:03, Cornelia Huck wrote:
> 
> > On Sun, 9 Dec 2012 13:12:37 +0100
> > Alexander Graf <agraf@suse.de> wrote:
> > 
> >> 
> >> On 07.12.2012, at 13:29, Cornelia Huck wrote:
> >> 
> >>> This will be needed by the new virtio-ccw transport.
> >>> 
> >>> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> >>> ---
> >>> arch/s390/include/asm/ccwdev.h |  5 +++++
> >>> drivers/s390/cio/device_ops.c  | 12 ++++++++++++
> >>> 2 files changed, 17 insertions(+)
> >>> 
> >>> diff --git a/arch/s390/include/asm/ccwdev.h b/arch/s390/include/asm/ccwdev.h
> >>> index 1cb4bb3..9ad79f7 100644
> >>> --- a/arch/s390/include/asm/ccwdev.h
> >>> +++ b/arch/s390/include/asm/ccwdev.h
> >>> @@ -18,6 +18,9 @@ struct irb;
> >>> struct ccw1;
> >>> struct ccw_dev_id;
> >>> 
> >>> +/* from asm/schid.h */
> >>> +struct subchannel_id;
> >>> +
> >>> /* simplified initializers for struct ccw_device:
> >>> * CCW_DEVICE and CCW_DEVICE_DEVTYPE initialize one
> >>> * entry in your MODULE_DEVICE_TABLE and set the match_flag correctly */
> >>> @@ -226,5 +229,7 @@ int ccw_device_siosl(struct ccw_device *);
> >>> // FIXME: these have to go
> >>> extern int _ccw_device_get_subchannel_number(struct ccw_device *);
> >>> 
> >>> +extern void ccw_device_get_schid(struct ccw_device *, struct subchannel_id *);
> >>> +
> >>> extern void *ccw_device_get_chp_desc(struct ccw_device *, int);
> >>> #endif /* _S390_CCWDEV_H_ */
> >>> diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
> >>> index ec7fb6d..2ad832f 100644
> >>> --- a/drivers/s390/cio/device_ops.c
> >>> +++ b/drivers/s390/cio/device_ops.c
> >>> @@ -763,6 +763,18 @@ _ccw_device_get_subchannel_number(struct ccw_device *cdev)
> >>> 	return cdev->private->schid.sch_no;
> >>> }
> >>> 
> >>> +/**
> >>> + * ccw_device_get_schid - obtain a subchannel id
> >>> + * @cdev: device to obtain the id for
> >>> + * @schid: where to fill in the values
> >>> + */
> >>> +void ccw_device_get_schid(struct ccw_device *cdev, struct subchannel_id *schid)
> >> 
> >> If you make this
> >> 
> >> u32 ccw_device_get_schid(struct ccw_device *cdev)
> >> 
> >> and you return the u32 (architected) value of the schid, not the internal struct, then you can save yourself the struct export (patch 2/5) and the ugly cast in patch 4/5 to get the u32 value.
> > 
> > I really prefer using the structure instead.
> > 
> > Moreover, there's a patch based on this that switches non-kvm users to
> > this new interface (getting rid of an old, broken interface) already
> > queued in the linux-s390 tree AFAIK.
> 
> Well, then base on top of that patch and add another interface that allows you to receive a schid as integer value. Randomly casting structs to u32 in random code across the tree is just pure ugly.

We seem to have different ideas of 'ugly' :)

I really prefer to have a function called ccw_device_get_schid()
provide a struct subchannel_id and not a u32 - a subchannel id is,
after all, what the caller asks for. The fact that a subchannel id may
fit into a u32 is an implementation detail, as well as the fact that an
instruction takes a 32 bit value containing a subchannel id. Passing
around a 32 bit value instead of a subchannel id basically discards the
information that we're dealing with a subchannel id and not with a
random 32 bit value.

> 
> An alternative would be to create a union around the struct and to return that one, so that you can access the u32 value or the struct value depending on the user's needs. That way the u32 cast is part of the API and not implicit, as it would be today.

What's the API here? I think we have two parts:

- The API to get the current subchannel id for a ccw device. For the
reasons above, I think this should use struct subchannel_id.

- The hardware/hypervisor API for addressing a subchannel, which
basically requires that a register contains a subchannel id. The easiest
way to do this is to cast to an integer. I don't see any need to play
games with unions here, after all we're using C and not Pascal ;)
