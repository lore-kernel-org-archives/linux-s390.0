Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:26893 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727178AbgBEOyL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Feb 2020 09:54:11 -0500
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v6 08/10] mm/memory_hotplug: Don't check for "all holes"
 in shrink_zone_span()
Date: Wed, 5 Feb 2020 14:54:07 +0000
Message-ID: <b8f142b9d569459d84b71949cb5efc27@AcuMS.aculab.com>
References: <20191006085646.5768-1-david@redhat.com>
 <20191006085646.5768-9-david@redhat.com> <20200205095924.GC24162@richard>
In-Reply-To: <20200205095924.GC24162@richard>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: 'Wei Yang' <richardw.yang@linux.intel.com>, David Hildenbrand <david@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Dan Williams <dan.j.williams@intel.com>

From: Wei Yang
> Sent: 05 February 2020 09:59
...
> If it is me, I would like to take out these two similar logic out.
> 
> For example:
> 
> 	if () {
> 	} else if () {
> 	} else {
> 		goto out;
> 	}

I'm pretty sure the kernel layout rules disallow 'else if'.
It is also pretty horrid unless the conditionals are all related
(so it is almost a switch statement).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
