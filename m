Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39183 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726308AbgBEOQP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Feb 2020 09:16:15 -0500
Subject: Re: [PATCH v6 08/10] mm/memory_hotplug: Don't check for "all holes"
 in shrink_zone_span()
References: <20191006085646.5768-1-david@redhat.com>
 <20191006085646.5768-9-david@redhat.com>
 <20200204142516.GD26758@MiWiFi-R3L-srv>
 <e0006cc4-d448-89c6-38c0-51da7fc08715@redhat.com>
 <20200205124329.GE26758@MiWiFi-R3L-srv>
 <cd353848-301a-025d-dd66-44d76e1bbc44@redhat.com>
 <20200205133442.GC8965@MiWiFi-R3L-srv>
 <2868343a-745b-e2b6-7e78-d5649c00ee31@redhat.com>
 <20200205141254.GD8965@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
Message-ID: <be8b9c0e-0929-4ea4-9c25-15e1f221dfb1@redhat.com>
Date: Wed, 5 Feb 2020 15:16:04 +0100
MIME-Version: 1.0
In-Reply-To: <20200205141254.GD8965@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Dan Williams <dan.j.williams@intel.com>, Wei Yang <richardw.yang@linux.intel.com>

>>>> Anyhow, that patch is already upstream and I don't consider this high
>>>> priority. Thanks :)
>>>
>>> Yeah, noticed you told Wei the status in another patch thread, I am fine
>>> with it, just leave it to you to decide. Thanks.
>>
>> I am fairly busy right now. Can you send a patch (double-checking and
>> making this eventually unconditional?). Thanks!
> 
> Understood, sorry about the noise, David. I will think about this.
> 

No need to excuse, really, I'm very happy about review feedback!

The review of this series happened fairly late. Bad, because it's not
perfect, but good, because no serious stuff was found (so far :) ). If
you also don't have time to look into this, I can put it onto my todo
list, just let me know.

Thanks!

-- 
Thanks,

David / dhildenb
