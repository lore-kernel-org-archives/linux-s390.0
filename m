Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54292 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728004AbfGPIqk (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 16 Jul 2019 04:46:40 -0400
Date: Tue, 16 Jul 2019 10:46:34 +0200
From: Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v3 10/11] mm/memory_hotplug: Make
 unregister_memory_block_under_nodes() never fail
Message-ID: <20190716084626.GA12394@linux>
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
Cc: Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Dan Williams <dan.j.williams@intel.com>, Wei Yang <richard.weiyang@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, "David S. Miller" <davem@davemloft.net>, Mark Brown <broonie@kernel.org>, Chris Wilson <chris@chris-wilson.co.uk>, Jonathan Cameron <Jonathan.Cameron@huawei.com>

On Mon, Jul 15, 2019 at 01:10:33PM +0200, David Hildenbrand wrote:
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
> 
> Of course, we can also just use mem_blk->nid and rest assured that it
> will never be called for memory blocks belonging to multiple nodes.

Hi David,

While it is easy to construct a scenario where a memblock belongs to multiple
nodes, I have to confess that I yet have not seen that in a real-world scenario.

Given said that, I think that the less risky way is to just drop the nodemask_t
and do not care about calling sysfs_remove_link() for already removed links.
As I said, sysfs_remove_link() will silently fail when it fails to find the
symlink, so I do not think it is a big deal.


-- 
Oscar Salvador
SUSE L3
