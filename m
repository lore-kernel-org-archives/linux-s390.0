Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27328 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726008AbfIEXLV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Sep 2019 19:11:21 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x85N3rtE064771
        for <linux-s390@vger.kernel.org>; Thu, 5 Sep 2019 19:11:21 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uub0p1fa9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 05 Sep 2019 19:11:20 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 6 Sep 2019 00:11:18 +0100
Date: Fri, 6 Sep 2019 01:10:49 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2] s390: vfio-ap: remove unnecessary calls to disable
 queue interrupts
In-Reply-To: <839467aa-5743-3d56-44e2-05ba5533a31c@linux.ibm.com>
References: <1566236929-18995-1-git-send-email-akrowiak@linux.ibm.com>
        <20190830180250.79804f76.pasic@linux.ibm.com>
        <839467aa-5743-3d56-44e2-05ba5533a31c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20190906011049.50d8a476.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, freude@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, pasic@linux.vnet.ibm.com, frankja@linux.ibm.com, jjherne@linux.ibm.com

On Thu, 5 Sep 2019 12:26:15 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 8/30/19 12:02 PM, Halil Pasic wrote:
[..]
> >> @@ -1177,7 +1179,18 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
> >>   			 */
> >>   			if (ret)
> >>   				rc = ret;
> >> -			vfio_ap_irq_disable_apqn(AP_MKQID(apid, apqi));
> >> +
> >> +			/*
> >> +			 * Resetting a queue disables interrupts as a side
> >> +			 * effect, so there is no need to disable interrupts
> >> +			 * here. Note that an error on reset indicates the
> >> +			 * queue is inaccessible, so an attempt to disable
> >> +			 * interrupts would fail and is therefore unnecessary.
> >> +			 * Just free up the resources used by IRQ processing.
> >> +			 */
> > 
> > I have some concerns about this patch. One thing we must ensure is that
> > the machine does not poke freed memory (NIB, GISA). With the current
> > design that means we must ensure that there won't be any interruption
> > conditions indicated (and interrupts made pending) after this point.
> 
> If reset disables interrupts, why would we need to turn around and
> disable interrupts after completion of the reset, unless reset disables
> interrupts only for the duration of the reset processing?

That a successful queue reset disables interrupts on the queue is beyond
any doubt. My concern is about the fact that a part of the reset itself
is done asynchronously with respect to the PQAP ZAPQ that asks for the
reset.

> If interrupts
> are disabled only for the duration of the reset, then I question whether
> we need to be at all concerned about interrupts in the context of
> resetting a queue.
> 

We need to clean up the NIB. We must avoid use after free like stuff, so
my concern is about the waits.

> > 
> > I'm not entirely convinced this is ensured after your change. The
> > relevant bits of the  documentation are particularly hard to figure out.
> > I could use some clarifications for sure.
> > 
> > This hunk removes the wait implemented by vfio_ap_wait_for_irqclear()
> > along with the hopefully overkill AQIC.
> > 
> > Let me name some of the scenarios I'm concerned about, along with the
> > code that is currently supposed to handle these.
> > 
> > 
> > int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
> >                               unsigned int retry)
> > {
> >          struct ap_queue_status status;
> >          int retry2 = 2;
> >          int apqn = AP_MKQID(apid, apqi);
> >                                                                                  
> >          do {
> >                  status = ap_zapq(apqn);
> >                  switch (status.response_code) {
> >                  case AP_RESPONSE_NORMAL:
> >                          while (!status.queue_empty && retry2--) {
> >                                  msleep(20);
> >                                  status = ap_tapq(apqn, NULL);
> >                          }
> >                          WARN_ON_ONCE(retry <= 0);
> >                          return 0;
> >                  case AP_RESPONSE_RESET_IN_PROGRESS:
> >                  case AP_RESPONSE_BUSY:
> >                          msleep(20);
> >                          break;
> >                  default:
> >                          /* things are really broken, give up */
> >                          return -EIO;
> >                  }
> >          } while (retry--);
> >                                                                                  
> >          return -EBUSY;
> > 
> > Scenario 1)
> > 
> > ap_zapq() returns status.response_code == AP_RESPONSE_RESET_IN_PROGRESS,
> > because for example G2 did a ZAPQ before us.
> > 
> > The current logic retries ap_zapq() once after 20 msec. I have no idea
> > if that is sufficient under all circumstances. If we get a
> > AP_RESPONSE_RESET_IN_PROGRESS again, we return with -EBUSY and do nothing
> > about it if the whole process was triggered by vfio_ap_mdev_release().
> > Not even a warning.
> 
> I'm not sure this is a major concern, If the response code is
> AP_RESPONSE_RESET_IN_PROGRESS due to a ZAPQ issued by G2 before us,
> then once that completes the queue will be reset which accomplishes
> the goal anyway. Maybe what should be done in this case is to wait
> for the queue to empty?
> 

Yes I'm concerned about do we wait long enough because we need to avoid
HW poking memory that could be used for something else at that point
(NIB, GISA.IPM).

> > 
> > Please notice that this was almost fine before IRQ support, because the
> > queue will get reset ASAP, and ...
> 
> I'm not sure what IRQ support has to do with how soon the queue is
> reset.
> 

If there is no IRQs AP HW won't just poke guest memory like it does with
the NIB. And since the AP instructions are bound to get reset in progress
response code even there is no danger of queue state leaking because the
reset is not fully completed yet.

> > 
> > Scenario 2)
> > 
> > It takes longer than 40 msec for the reset to complete. I don't know if
> > this is a possibility, but before your patch we used to wait of 1 sec.
> 
> Where are you coming up with 1 sec?

My bad, it was supposed to be 0.1 sec == 5 X 20ms (wait after AQIC that
got kicked by this patch). What I want to say is this patch
substantially reduces the wait time.

> The only thing my patch did was
> remove the disable IRQ. Even if you include the the wait for IRQ disable
> to complete, I don't see 1 second of wait time. By my calculations:
> 
> 5 x 20ms = 100ms  Max wait for ZAPQ response code 0
> 2 x 20ms =  40ms  Max wait time for qempty
> 5 x 20ms = 100ms  Max wait for AQIC response code 0
> 5 x 20ms = 100ms  Max wait time for IRQ clear
> ----------------
>             340ms  Max total wait time
> 
> > 
> > I guess the we need the timeouts because do this with matrix_dev->lock
> > held. I'm not sure it's a good idea long term.
> 
> It looks like your concern here is making sure we wait a
> sufficient amount of time for the reset to complete. That may be
> a question for the firmware folks.
> 

Yes, my concern is making sure we don't clean up/give up stuff
prematurely. The current code seems to do the waits for this purpose.
I'm not sure what is actually necessary. Clarifying stuff with firmware
or somebody else that knows better than I do is probably a good idea.

> > 
> > Scenario 3)
> > 
> > ap_zapq() returns status.response_code == AP_RESPONSE_DECONFIGURED. In
> > this case we would give up right away. Again so that we don't even know
> > we hit this case. There ain't much I can think about we could do here.
> 
> The only thing I can think of is to log an error. I am introducing
> logging in the dynamic configuration series if that helps.
> 

I don't think it is an error.

> > 
> > I hope we are guaranteed to  not get any bits set at this point, but I could
> > use some help.
> 
> I don't know what your concern is here. If the card is not in the
> configuration, then no activity can take place until it is reconfigured.
> 

Yes, I also think that is the only way this make sense. But I usually
don't assume complex things happen atomically unless I have a guarantee
they do. I will explain what I mean by this offline.

> > 
> >                                    *
> > 
> > The good thing is I'm pretty sure that we are safe (i.e. no bits will be
> > poked by the hardware) after seeing the queue empty after we issued a
> > reset request.
> 
> You expressed several concerns above, yet now you say you think we're
> safe; I don't understand.

We are safe after we see the E bit set to one (queue empty) after the
reset. Above I describe the scenarios where we don't wait for that to
happen (in scenario 3 because it won't happen because the card is gone,
and in the other two because of the implemented timeouts).

> 
> > 
> > So my concerns basically boil down to are the cumulative timeouts big enough
> > so we never time out (including are timeouts really the way to go)?
> > 
> > We should probably take any discussion about from which point on is it safe
> > to assume that NIB and GISA won't be poked by HW offline as the guys
> > without documentation can't contribute.
> 
> Just a couple of thoughts. The only reason the vfio_ap driver is
> concerned with interrupts is because it is intercepting the PQAP(AQIC)
> instruction. Shouldn't enabling and disabling interrupts, therefore, be 
> solely under the control of the guest? In other words, maybe the vfio_ap
> driver should only allocate/deallocate the interrupt controls (i.e., the
> NIB and GISA) in response to PQAP(AQIC) interception.

GISA is a 1 per guest entity in the hypervisor. The NIB is a byte of the
guest memory.

> When the guest
> shuts down, I assume that the PQAP(AQIC) will be executed to disable
> interrupts. 

I would not assume that.

> The driver can do a final cleanup if the NIB and GISA when
> the mdev fd is released by the guest if they are still hanging around.
> 

You have to also consider stuff like subsystem resets. Yes the last line
of defense should be release(). This is what we do today AFAIU.

Regards,
Halil
