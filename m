Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33189 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727070AbgBEO4D (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Feb 2020 09:56:03 -0500
Subject: Re: [PATCH v6 08/10] mm/memory_hotplug: Don't check for "all holes"
 in shrink_zone_span()
References: <20191006085646.5768-1-david@redhat.com>
 <20191006085646.5768-9-david@redhat.com> <20200205095924.GC24162@richard>
 <b8f142b9d569459d84b71949cb5efc27@AcuMS.aculab.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <00d040ca-1885-1b38-e3da-54276c37bc8e@redhat.com>
Date: Wed, 5 Feb 2020 15:55:52 +0100
MIME-Version: 1.0
In-Reply-To: <b8f142b9d569459d84b71949cb5efc27@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Laight <David.Laight@ACULAB.COM>, 'Wei Yang' <richardw.yang@linux.intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Dan Williams <dan.j.williams@intel.com>

On 05.02.20 15:54, David Laight wrote:
> From: Wei Yang
>> Sent: 05 February 2020 09:59
> ...
>> If it is me, I would like to take out these two similar logic out.
>>
>> For example:
>>
>> 	if () {
>> 	} else if () {
>> 	} else {
>> 		goto out;
>> 	}
> 
> I'm pretty sure the kernel layout rules disallow 'else if'.

Huh?

git grep "else if" | wc -l
49336

I'm afraid I don't get what you mean :)

-- 
Thanks,

David / dhildenb
