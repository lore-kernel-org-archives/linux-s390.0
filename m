Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:14661 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbgBELsT (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 5 Feb 2020 06:48:19 -0500
Date: Wed, 5 Feb 2020 19:48:32 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH v6 10/10] mm/memory_hotplug: Cleanup __remove_pages()
Message-ID: <20200205114832.GE24162@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191006085646.5768-1-david@redhat.com>
 <20191006085646.5768-11-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006085646.5768-11-david@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Dan Williams <dan.j.williams@intel.com>, Wei Yang <richardw.yang@linux.intel.com>

On Sun, Oct 06, 2019 at 10:56:46AM +0200, David Hildenbrand wrote:
>Let's drop the basically unused section stuff and simplify.
>
>Also, let's use a shorter variant to calculate the number of pages to
>the next section boundary.
>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Oscar Salvador <osalvador@suse.de>
>Cc: Michal Hocko <mhocko@suse.com>
>Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>Cc: Dan Williams <dan.j.williams@intel.com>
>Cc: Wei Yang <richardw.yang@linux.intel.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Finally understand the code.

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

-- 
Wei Yang
Help you, Help me
