Return-Path: <SRS0=rjjQ=ST=vger.kernel.org=kvm-owner@kernel.org>
Date: Wed, 17 Apr 2019 17:37:59 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/7] s390: zcrypt: driver callback to indicate resource
 in use
In-Reply-To: <0c7dbcd5-295c-8dc1-7223-01866694ebc4@linux.ibm.com>
References: <1555016604-2008-1-git-send-email-akrowiak@linux.ibm.com>
        <1555016604-2008-2-git-send-email-akrowiak@linux.ibm.com>
        <223c82c7-6a75-7209-3652-c2341c83878f@linux.ibm.com>
        <20190412114313.0156c01b.cohuck@redhat.com>
        <89f09e58-eab6-94d4-c5aa-937162d60744@linux.ibm.com>
        <20190415115030.1df61182.cohuck@redhat.com>
        <3d762e51-7210-529f-61de-98d80689bff6@linux.ibm.com>
        <20190415205950.7655cee3@oc2783563651>
        <0c7dbcd5-295c-8dc1-7223-01866694ebc4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190417173759.3a7d20d7@oc2783563651>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Reinhard Buendgen <buendgen@de.ibm.com>, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pmorel@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, 15 Apr 2019 18:43:24 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 4/15/19 2:59 PM, Halil Pasic wrote:
> > On Mon, 15 Apr 2019 12:51:23 -0400
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> > 
> >> Having said that, I understand your concern about a driver hogging
> >> resources. I think I can provide a solution that serves both the
> >> purpose of preventing problems associated with accidental removal
> >> of AP resources as well as allowing root to remove them
> >> forcefully. I'll work on that for v2.
> > 
> > Can you tell us some more about this solution? Should we stop reviewing
> > v1 because v2 is going to be different anyway?
> 
> Patch 1 and 2 will be removed. There will not be a major design change
> between these patches and v2. In order to avoid a long explanation of
> my proposed changes, I'd prefer to state that the patch set will 
> establish and enforce the following rules:
> 
>      1. An APQN can be assigned to an mdev device iff it is NOT
>         reserved for use by a zcrypt driver and is not assigned to
>         another mdev device.
> 
>      2. Once an APQN is assigned to an mdev device, it will remain
>         assigned until it is explicitly unassigned.
> 
>      3. A queue's APQN can be set in the guest's CRYCB iff the APQN is
>         assigned to the mdev device used by the guest; however, if the
>         queue is also in the host configuration (i.e., online), it MUST
>         also be bound to the vfio_ap device driver.
> 
>      4. When a queue is bound to the vfio_ap driver and its APQN
>         is assigned to an mdev device in use by a guest, the guest will
>         be given access to the queue.
> 
>      5. When a queue is unbound from the vfio_ap driver and its APQN
>         is assigned to an mdev device in use by the guest, access to
>         the card containing the queue will be removed from the guest.
>         Keep in mind that we can not deny access to a specific queue
>         due to the architecture (i.e., clearing a bit in the AQM
>         removes access to the queue for all adapters)
> 
>      6. When an adapter is assigned to an mdev device that is in use
>         by a guest, the guest will be given access to the adapter.
> 
>      7. When an adapter is unassigned from an mdev device that is in use
>         by a guest, access to the adapter will removed from the guest.
> 
>      8. When a domain is assigned to an mdev device that is in use
>         by a guest, the guest will be given access to the domain.
> 
>      9. When a domain is unassigned from an mdev device that is in use
>         by a guest, access to the domain will removed from the guest.
> 

Based on our off-the-list chat and this list I think I know
where are you heading :). I think it's actually the design that I
currently prefer the most. But in that case, it may be wise to touch
base with Reinhard -- AFAIR he was the strongest proponent of the 'do
not let a[pq]mask changes take away queues from guests' design.

Regards,
Halil
