Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 29 Apr 2020 13:30:29 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v7 01/15] s390/vfio-ap: store queue struct in hash table
 for quick access
Message-ID: <20200429133029.583bb0a3.pasic@linux.ibm.com>
In-Reply-To: <bc6ac9ef-f9ad-f41a-024d-db3d5c2ddd10@linux.ibm.com>
References: <20200407192015.19887-1-akrowiak@linux.ibm.com>
        <20200407192015.19887-2-akrowiak@linux.ibm.com>
        <20200424055732.7663896d.pasic@linux.ibm.com>
        <d15b4a8e-66eb-e4ce-c8ac-6885519940aa@linux.ibm.com>
        <20200427171739.76291a74.pasic@linux.ibm.com>
        <6ea12752-d23f-abe4-8d5f-3e7738984576@linux.ibm.com>
        <20200428120726.3f769ce3.pasic@linux.ibm.com>
        <bc6ac9ef-f9ad-f41a-024d-db3d5c2ddd10@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com, fiuczy@linux.ibm.com

On Tue, 28 Apr 2020 12:57:12 +0200
Harald Freudenberger <freude@linux.ibm.com> wrote:

> On 28.04.20 12:07, Halil Pasic wrote:
> > On Mon, 27 Apr 2020 17:48:58 -0400
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >
> >>
> >> On 4/27/20 11:17 AM, Halil Pasic wrote:
> >>> On Mon, 27 Apr 2020 15:05:23 +0200
> >>> Harald Freudenberger <freude@linux.ibm.com> wrote:
> >>>
> >>>> On 24.04.20 05:57, Halil Pasic wrote:
> >>>>> On Tue,  7 Apr 2020 15:20:01 -0400
> >>>>> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >>>>>   
> >>>>>> Rather than looping over potentially 65535 objects, let's store the
> >>>>>> structures for caching information about queue devices bound to the
> >>>>>> vfio_ap device driver in a hash table keyed by APQN.
> >>>>> @Harald:
> >>>>> Would it make sense to make the efficient lookup of an apqueue base
> >>>>> on its APQN core AP functionality instead of each driver figuring it out
> >>>>> on it's own?
> >>>>>
> >>>>> If I'm not wrong the zcrypt device/driver(s) must the problem of
> >>>>> looking up a queue based on its APQN as well.
> >>>>>
> >>>>> For instance struct ep11_cprb has a target_id filed
> >>>>> (arch/s390/include/uapi/asm/zcrypt.h).
> >>>>>
> >>>>> Regards,
> >>>>> Halil
> >>>> Hi Halil
> >>>>
> >>>> no, the zcrypt drivers don't have this problem. They build up their own device object which
> >>>> includes a pointer to the base ap device.
> >>> I'm a bit confused. Doesn't your code loop first trough the ap_card
> >>> objects to find the APID portion of the APQN, and then loop the queue
> >>> list of the matching card to find the right ap_queue object? Or did I
> >>> miss something? Isn't that what _zcrypt_send_ep11_cprb() does? Can you
> >>> point me to the code that avoids the lookup (by apqn) for zcrypt?
> >> The code you reference, _zcrypt_send_ep11_cprb(), does loop through
> >> each queue associated with each card, but it doesn't appear to be 
> >> looking for
> >> a queue with a particular APQN. It appears to be looking for a queue
> >> meeting a specific set of conditions. At least that's my take after 
> >> taking a very
> >> brief look at the code, so I'm not sure that applies here.
> >>
> > One of the possible conditions is that the APQN is in the targets array.
> > Please have another look at the code below, is_desired_ep11_queue()
> > and is_desired_ep11_card() do APQI and APID part of the check
> > respectively:
> >
> >         for_each_zcrypt_card(zc) {
> >                 /* Check for online EP11 cards */
> >                 if (!zc->online || !(zc->card->functions & 0x04000000))
> >                         continue;
> >                 /* Check for user selected EP11 card */
> >                 if (targets &&
> >                     !is_desired_ep11_card(zc->card->id, target_num, targets))
> >                         continue;
> >                 /* check if device node has admission for this card */
> >                 if (!zcrypt_check_card(perms, zc->card->id))
> >                         continue;
> >                 /* get weight index of the card device  */
> >                 weight = speed_idx_ep11(func_code) * zc->speed_rating[SECKEY];
> >                 if (zcrypt_card_compare(zc, pref_zc, weight, pref_weight))
> >                         continue;
> >                 for_each_zcrypt_queue(zq, zc) {
> >                         /* check if device is online and eligible */
> >                         if (!zq->online ||
> >                             !zq->ops->send_ep11_cprb ||
> >                             (targets &&
> >                              !is_desired_ep11_queue(zq->queue->qid,
> >                                                     target_num, targets)))
> >
> >
> > Yes the size of targets may or may not be 1 (example for size == 1 is
> > the invocation form ep11_cryptsingle()) and the respective costs
> > depend on the usual size of the array. Since the goal of the whole
> > exercise seems to be to pick a single queue, and we settle with the first
> > suitable (first not in the input array, but in our lists) that is
> > suitable, I assumed we wouldn't need many hashtable lookups.
> >
> > Regards,
> > Halil
> again, this is all code related to zcrypt card and queues and has nothing directly to do with ap queue and ap cards.

Well, if you look at "struct vfio_ap_queue* vfio_ap_get_queue(unsigned
long apqn)" it also works with vfio_ap_queue and "has nothing directly
to do with ap queue". But ap_queue->private points to zcrypt_queue
and vfio_ap_queue when the queue is driven by a zcrypt and a vfio_ap
driver respectively.



> If you want to have a look how this works for ap devices, have a look into the scan routines for the ap bus in ap_bus.c
> There you can find a bus_for_each_device() which would fit together with the right matching function for your needs.
> And this is exactly what Tony implemented in the first shot. However, as written I can provide something like that
> for you.
> One note for the improvement via hash list with the argument about the max 65535 objects.
> Think about a real big machine which has currently up to 30 crypto cards (z15 GA1.5) which when CEX7S are
> plugged appear as 60 crypto adapters and have up to 85 domains each. When all these crypto resources
> are assigned to one LPAR we end up in 60x85 = 5100 APQNs. Well, of course with a hash you can improve
> the linear search through an array or list but can you measure the performance gain and then compare this
> to the complexity.  ... just some thoughts about beautifying code ...

My train of thought is that looking up a queue by its APQN is a
functionality potentially common to several drivers. I was hoping for a
simplification, not for a ton of added complexity. 

Also I was thinking about the 256 buckets. I mean
"DECLARE_HASHTABLE(qtable, 8);". It would be much easier to reason about
the table size at a bus level.

Regards,
Halil
