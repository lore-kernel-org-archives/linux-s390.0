Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27528 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726597AbgBEO0c (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Feb 2020 09:26:32 -0500
Date: Wed, 5 Feb 2020 22:26:18 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v6 08/10] mm/memory_hotplug: Don't check for "all holes"
 in shrink_zone_span()
Message-ID: <20200205142618.GE8965@MiWiFi-R3L-srv>
References: <20191006085646.5768-1-david@redhat.com>
 <20191006085646.5768-9-david@redhat.com>
 <20200204142516.GD26758@MiWiFi-R3L-srv>
 <e0006cc4-d448-89c6-38c0-51da7fc08715@redhat.com>
 <20200205124329.GE26758@MiWiFi-R3L-srv>
 <cd353848-301a-025d-dd66-44d76e1bbc44@redhat.com>
 <20200205133442.GC8965@MiWiFi-R3L-srv>
 <2868343a-745b-e2b6-7e78-d5649c00ee31@redhat.com>
 <20200205141254.GD8965@MiWiFi-R3L-srv>
 <be8b9c0e-0929-4ea4-9c25-15e1f221dfb1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be8b9c0e-0929-4ea4-9c25-15e1f221dfb1@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Dan Williams <dan.j.williams@intel.com>, Wei Yang <richardw.yang@linux.intel.com>

On 02/05/20 at 03:16pm, David Hildenbrand wrote:
> >>>> Anyhow, that patch is already upstream and I don't consider this high
> >>>> priority. Thanks :)
> >>>
> >>> Yeah, noticed you told Wei the status in another patch thread, I am fine
> >>> with it, just leave it to you to decide. Thanks.
> >>
> >> I am fairly busy right now. Can you send a patch (double-checking and
> >> making this eventually unconditional?). Thanks!
> > 
> > Understood, sorry about the noise, David. I will think about this.
> > 
> 
> No need to excuse, really, I'm very happy about review feedback!
> 

Glad to hear it, thanks.

> The review of this series happened fairly late. Bad, because it's not
> perfect, but good, because no serious stuff was found (so far :) ). If
> you also don't have time to look into this, I can put it onto my todo
> list, just let me know.

Both is OK to me, as long as thing is clear to us. I will discuss with
Wei Yang for now. You can post patch anytime if you make one.
