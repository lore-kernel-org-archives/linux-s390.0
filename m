Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46059 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727205AbgBDNjC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Feb 2020 08:39:02 -0500
Subject: Re: [PATCH v6 10/10] mm/memory_hotplug: Cleanup __remove_pages()
References: <20191006085646.5768-1-david@redhat.com>
 <20191006085646.5768-11-david@redhat.com> <20200204094652.GE6494@linux>
 <5d698f94-af18-0714-bc97-14b6c520572c@redhat.com>
 <20200204131353.GJ22482@gate.crashing.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0e2f700c-b01b-8c16-99c2-2648967fc203@redhat.com>
Date: Tue, 4 Feb 2020 14:38:51 +0100
MIME-Version: 1.0
In-Reply-To: <20200204131353.GJ22482@gate.crashing.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Oscar Salvador <osalvador@suse.de>, linux-s390@vger.kernel.org, Michal Hocko <mhocko@suse.com>, linux-ia64@vger.kernel.org, Pavel Tatashin <pasha.tatashin@soleen.com>, linux-sh@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Wei Yang <richardw.yang@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org

On 04.02.20 14:13, Segher Boessenkool wrote:
> On Tue, Feb 04, 2020 at 01:41:06PM +0100, David Hildenbrand wrote:
>> On 04.02.20 10:46, Oscar Salvador wrote:
>>> I have to confess that it took me while to wrap around my head
>>> with the new min() change, but looks ok:
>>
>> It's a pattern commonly used in compilers and emulators to calculate t=
he
>> number of bytes to the next block/alignment. (we're missing a macro
>> (like we have ALIGN_UP/IS_ALIGNED) for that - but it's hard to come up
>> with a good name (e.g., SIZE_TO_NEXT_ALIGN) .
>=20
> You can just write the easy to understand
>=20
>   ...  ALIGN_UP(x) - x  ...

you mean

ALIGN_UP(x, PAGES_PER_SECTION) - x

but ...

>=20
> which is better *without* having a separate name.  Does that not
> generate good machine code for you?

1. There is no ALIGN_UP. "SECTION_ALIGN_UP(x) - x" would be possible
2. It would be wrong if x is already aligned.

e.g., let's use 4096 for simplicity as we all know that value by heart
(for both x and the block size).

a) -(4096 | -4096) -> 4096

b) #define ALIGN_UP(x, a) ((x + a - 1) & -(a))

ALIGN_UP(4096, 4096) - 4096 -> 0

Not as easy as it seems ...

--=20
Thanks,

David / dhildenb
