Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59594 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbfGSGFG (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 19 Jul 2019 02:05:06 -0400
Date: Fri, 19 Jul 2019 08:05:02 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v3 10/11] mm/memory_hotplug: Make
 unregister_memory_block_under_nodes() never fail
Message-ID: <20190719060502.GG30461@dhcp22.suse.cz>
References: <20190527111152.16324-1-david@redhat.com>
 <20190527111152.16324-11-david@redhat.com>
 <20190701085144.GJ6376@dhcp22.suse.cz>
 <20190701093640.GA17349@linux>
 <20190701102756.GO6376@dhcp22.suse.cz>
 <d450488d-7a82-f7a9-c8d3-b69a0bca48c6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d450488d-7a82-f7a9-c8d3-b69a0bca48c6@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Dan Williams <dan.j.williams@intel.com>, Wei Yang <richard.weiyang@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, "David S. Miller" <davem@davemloft.net>, Mark Brown <broonie@kernel.org>, Chris Wilson <chris@chris-wilson.co.uk>, Jonathan Cameron <Jonathan.Cameron@huawei.com>

On Mon 15-07-19 13:10:33, David Hildenbrand wrote:
> On 01.07.19 12:27, Michal Hocko wrote:
> > On Mon 01-07-19 11:36:44, Oscar Salvador wrote:
> >> On Mon, Jul 01, 2019 at 10:51:44AM +0200, Michal Hocko wrote:
> >>> Yeah, we do not allow to offline multi zone (node) ranges so the current
> >>> code seems to be over engineered.
> >>>
> >>> Anyway, I am wondering why do we have to strictly check for already
> >>> removed nodes links. Is the sysfs code going to complain we we try to
> >>> remove again?
> >>
> >> No, sysfs will silently "fail" if the symlink has already been removed.
> >> At least that is what I saw last time I played with it.
> >>
> >> I guess the question is what if sysfs handling changes in the future
> >> and starts dropping warnings when trying to remove a symlink is not there.
> >> Maybe that is unlikely to happen?
> > 
> > And maybe we handle it then rather than have a static allocation that
> > everybody with hotremove configured has to pay for.
> > 
> 
> So what's the suggestion? Dropping the nodemask_t completely and calling
> sysfs_remove_link() on already potentially removed links?

Yes. In a follow up patch.
-- 
Michal Hocko
SUSE Labs
