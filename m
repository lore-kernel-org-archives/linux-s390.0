Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbfGAMqa (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 1 Jul 2019 08:46:30 -0400
Date: Mon, 1 Jul 2019 14:46:28 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v3 02/11] s390x/mm: Fail when an altmap is used for
 arch_add_memory()
Message-ID: <20190701124628.GT6376@dhcp22.suse.cz>
References: <20190527111152.16324-1-david@redhat.com>
 <20190527111152.16324-3-david@redhat.com>
 <20190701074306.GC6376@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701074306.GC6376@dhcp22.suse.cz>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Dan Williams <dan.j.williams@intel.com>, Wei Yang <richard.weiyang@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Oscar Salvador <osalvador@suse.com>

On Mon 01-07-19 09:43:06, Michal Hocko wrote:
> On Mon 27-05-19 13:11:43, David Hildenbrand wrote:
> > ZONE_DEVICE is not yet supported, fail if an altmap is passed, so we
> > don't forget arch_add_memory()/arch_remove_memory() when unlocking
> > support.
> 
> Why do we need this? Sure ZONE_DEVICE is not supported for s390 and so
> might be the case for other arches which support hotplug. I do not see
> much point in adding warning to each of them.

I would drop this one. If there is a strong reason to have something
like that it should come with a better explanation and it can be done on
top.
-- 
Michal Hocko
SUSE Labs
