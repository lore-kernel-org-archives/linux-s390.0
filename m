Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25222 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727127AbgBDMlP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Feb 2020 07:41:15 -0500
Subject: Re: [PATCH v6 10/10] mm/memory_hotplug: Cleanup __remove_pages()
References: <20191006085646.5768-1-david@redhat.com>
 <20191006085646.5768-11-david@redhat.com> <20200204094652.GE6494@linux>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5d698f94-af18-0714-bc97-14b6c520572c@redhat.com>
Date: Tue, 4 Feb 2020 13:41:06 +0100
MIME-Version: 1.0
In-Reply-To: <20200204094652.GE6494@linux>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Dan Williams <dan.j.williams@intel.com>, Wei Yang <richardw.yang@linux.intel.com>

On 04.02.20 10:46, Oscar Salvador wrote:
> On Sun, Oct 06, 2019 at 10:56:46AM +0200, David Hildenbrand wrote:
>> Let's drop the basically unused section stuff and simplify.
>>
>> Also, let's use a shorter variant to calculate the number of pages to
>> the next section boundary.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Wei Yang <richardw.yang@linux.intel.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>=20
> I have to confess that it took me while to wrap around my head
> with the new min() change, but looks ok:

It's a pattern commonly used in compilers and emulators to calculate the
number of bytes to the next block/alignment. (we're missing a macro
(like we have ALIGN_UP/IS_ALIGNED) for that - but it's hard to come up
with a good name (e.g., SIZE_TO_NEXT_ALIGN) .

--=20
Thanks,

David / dhildenb
