Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44597 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726070AbfLFKVP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Dec 2019 05:21:15 -0500
Date: Fri, 6 Dec 2019 11:21:07 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v1 08/10] vfio-ccw: Wire up the CRW irq and CRW
 region
Message-ID: <20191206112107.63fb37a1.cohuck@redhat.com>
In-Reply-To: <02d98858-ddac-df7e-96a6-7c61335d3cee@linux.ibm.com>
References: <20191115025620.19593-1-farman@linux.ibm.com>
        <20191115025620.19593-9-farman@linux.ibm.com>
        <20191119195236.35189d5b.cohuck@redhat.com>
        <02d98858-ddac-df7e-96a6-7c61335d3cee@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>

On Thu, 5 Dec 2019 15:43:55 -0500
Eric Farman <farman@linux.ibm.com> wrote:

> On 11/19/19 1:52 PM, Cornelia Huck wrote:
> > On Fri, 15 Nov 2019 03:56:18 +0100
> > Eric Farman <farman@linux.ibm.com> wrote:
> >   
> >> From: Farhan Ali <alifm@linux.ibm.com>
> >>
> >> Use an IRQ to notify userspace that there is a CRW
> >> pending in the region, related to path-availability
> >> changes on the passthrough subchannel.  
> > 
> > Thinking a bit more about this, it feels a bit odd that a crw for a
> > chpid ends up on one subchannel. What happens if we have multiple
> > subchannels passed through by vfio-ccw that use that same chpid?  
> 
> Yeah...  It doesn't end up on one subchannel, it ends up on every
> affected subchannel, based on the loops in (for example)
> chsc_chp_offline().  This means that "let's configure off a CHPID to the
> LPAR" translates one channel-path CRW into N channel-path CRWs (one each
> sent to N subchannels).  It would make more sense if we just presented
> one channel-path CRW to the guest, but I'm having difficulty seeing how
> we could wire this up.  What we do here is use the channel-path event
> handler in vfio-ccw also create a channel-path CRW to be presented to
> the guest, even though it's processing something at the subchannel level.

Yes, it's a bit odd that we need to do 1 -> N -> 1 conversion here, but
we can't really avoid it without introducing a new way to report
information that is relevant for more than one subchannel. The thing we
need to make sure is that userspace gets the same information,
regardless of which affected subchannel it looks at.

> 
> The actual CRW handlers are in the base cio code, and we only get into
> vfio-ccw when processing the individual subchannels.  Do we need to make
> a device (or something?) at the guest level for the chpids that exist?
> Or do something to say "hey we got this from a subchannel, put it on a
> global queue if it's unique, or throw it away if it's a duplicate we
> haven't processed yet" ?  Thoughts?

The problem is that you can easily get several crws that look identical
(consider e.g. a chpid that is set online and offline in a tight loop).
The only entity that should make decisions as to what to process here
is the guest.

(...)

> >> @@ -312,6 +334,11 @@ static int vfio_ccw_chp_event(struct subchannel *sch,
> >>  	case CHP_ONLINE:
> >>  		/* Path became available */
> >>  		sch->lpm |= mask & sch->opm;
> >> +		private->crw.rsc = CRW_RSC_CPATH;
> >> +		private->crw.rsid = 0x0 | (link->chpid.cssid << 8) |
> >> +				    link->chpid.id;
> >> +		private->crw.erc = CRW_ERC_INIT;
> >> +		queue_work(vfio_ccw_work_q, &private->crw_work);  
> > 
> > Isn't that racy? Imagine you get one notification for a chpid and queue
> > it. Then, you get another notification for another chpid and queue it
> > as well. Depending on when userspace reads, it gets different chpids.
> > Moreover, a crw may be lost... or am I missing something obvious?  
> 
> Nope, you're right on.  If I start thrashing config on/off chpids on the
> host, I eventually fall down with all sorts of weirdness.
> 
> > 
> > Maybe you need a real queue for the generated crws?  
> 
> I guess this is what I'm wrestling with...  We don't have a queue for
> guest-wide work items, as it's currently broken apart by subchannel.  Is
> adding one at the vfio-ccw level right?  Feels odd to me, since multiple
> guests could use devices connected via vfio-ccw, which may or may share
> common chpids.

One problem is that the common I/O layer already processes the crws and
translates them into different per-subchannel events. We don't even
know what the original crw was: IIUC, we translate both a crw for a
chpid and a link incident event (reported by a crw with source css and
event information via chsc) concerning the concrete link to the same
event. That *probably* doesn't matter too much, but it makes things
harder. Access to the original crw queue would be nice, but hard to
implement without stepping on each others' toes.

> 
> I have a rough hack that serializes things a bit, while still keeping
> the CRW duplication at the subchannel level.  Things improve
> considerably, but it still seems odd to me.  I'll keep working on that
> unless anyone has any better ideas.

The main issue is that we're trying to report a somewhat global event
via individual devices...

...what about not reporting crws at all, but something derived from the
events we get at the subchannel driver level? Have four masks that
indicate online/offline/vary on/vary off for the respective chpids, and
have userspace decide how they want to report these to the guest? A
drawback (?) would be that a series of on/off events would only be
reported as one on and one off event, though. Feasible, or complete
lunacy?
