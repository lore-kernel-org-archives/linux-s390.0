Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27388 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727052AbgBJS4t (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 13:56:49 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01AInP7x061913
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 13:56:48 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1ucjeamc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 13:56:48 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <uweigand@de.ibm.com>;
        Mon, 10 Feb 2020 18:56:45 -0000
Subject: Re: [PATCH 02/35] KVM: s390/interrupt: do not pin adapter interrupt
Date: Mon, 10 Feb 2020 19:56:39 +0100 (CET)
From: "Ulrich Weigand" <uweigand@de.ibm.com>
In-Reply-To: <2cf62b84-8eb6-18d5-437b-7e86401b9c45@redhat.com> from "David Hildenbrand" at Feb 10, 2020 01:26:54 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20200210185639.9E05CD802E4@oc3748833570.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>

David Hildenbrand wrote:

> So, instead of pinning explicitly, look up the page address, cache it,
> and glue its lifetime to the gmap table entry. When that entry is
> changed, invalidate the cached page. On re-access, look up the page
> again and register the gmap notifier for the table entry again.

Yes, exactly.

> [...]> +static struct page *get_map_page(struct kvm *kvm,
> > +				 struct s390_io_adapter *adapter,
> > +				 u64 addr)
> >  {
> >  	struct s390_map_info *map;
> > +	unsigned long uaddr;
> > +	struct page *page;
> > +	bool need_retry;
> > +	int ret;
> > 
> >  	if (!adapter)
> >  		return NULL;
> > +retry:
> > +	page = NULL;
> > +	uaddr = 0;
> > +	spin_lock(&adapter->maps_lock);
> > +	list_for_each_entry(map, &adapter->maps, list)
> > +		if (map->guest_addr == addr) {
> 
> Could it happen, that we don't have a fitting entry in the list?

Yes, if user space tries to signal an interrupt on a page that
was not properly announced via KVM_S390_IO_ADAPTER_MAP.

In that case, the loop returns with page == NULL and uaddr == 0,
which will cause the code below to return NULL, which will cause
the caller to return an error to user space.

> > +			uaddr = map->addr;
> > +			page = map->page;
> > +			if (!page)
> > +				map->page = ERR_PTR(-EBUSY);
> > +			else if (IS_ERR(page) || !page_cache_get_speculative(page)) {
> > +				spin_unlock(&adapter->maps_lock);
> > +				goto retry;
> > +			}
> > +			break;
> > +		}
> 
> Can we please factor out looking up the list entry to a separate
> function, to be called under lock? (and e.g., use it below as well)

Good idea, I like that.  Will update the patch ...

> > +	need_retry = true;
> > +	spin_lock(&adapter->maps_lock);
> > +	list_for_each_entry(map, &adapter->maps, list)
> > +		if (map->guest_addr == addr) {
> 
> Could it happen that our entry is suddenly no longer in the list?

Yes, if user space did a KVM_S390_IO_ADAPTER_UNMAP in the meantime.
In this case we'll exit the loop with need_retry == true and will
restart from the beginning, usually then returning an error back
to user space.

> > +			if (map->page == ERR_PTR(-EBUSY)) {
> > +				map->page = page;
> > +				need_retry = false;
> > +			} else if (IS_ERR(map->page)) {
> 
> else if (map->page == ERR_PTR(-EINVAL)
> 
> or simpy "else" (every other value would be a BUG_ON, right?)

Usually yes.  I guess there's the theoretical case that we race
with user space removing the old entry with KVM_S390_IO_ADAPTER_UNMAP
and immediately afterwards installing a new entry with the same
guest address.  In that case, we'll also fall into the need_retry
case here.

> Wow, this function is ... special. Took me way to long to figure out
> what is going on here. We certainly need comments in there.

I agree.  As Christian said, it's not fully clear that all of this
is really needed.  Maybe just doing the get_user_pages_remote every
time is actually enough -- we should do the "cache" magic only if
this is really critical for performance.

> I can see that
> 
> - ERR_PTR(-EBUSY) is used when somebody is about to do the
>   get_user_pages_remote(). others have to loop until that is resolved.
> - ERR_PTR(-EINVAL) is used when the entry gets invalidated by the
>   notifier while somebody is about to set it (while still
>   ERR_PTR(-EBUSY)). The one currently processing the entry will
>   eventually set it back to NULL.

Yes, that's the intent.
 
> I think we should make this clearer by only setting ERR_PTR(-EINVAL) in
> the notifier if already ERR_PTR(-EBUSY), along with a comment.

I guess I wanted to catch the case where we get another invalidation
while we already have -EINVAL.  But given the rest of the logic, this
shouldn't actually ever happen.  (If it *did* happen, however, then
setting to -EINVAL again is safer than resetting to NULL.)

> Can we document the values for map->page and how they are to be handled
> right in the struct?

OK, will do.

Bye,
Ulrich


-- 
  Dr. Ulrich Weigand
  GNU/Linux compilers and toolchain
  Ulrich.Weigand@de.ibm.com
