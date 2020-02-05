Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52879 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728017AbgBENVE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Feb 2020 08:21:04 -0500
Subject: Re: [PATCH v6 08/10] mm/memory_hotplug: Don't check for "all holes"
 in shrink_zone_span()
References: <20191006085646.5768-1-david@redhat.com>
 <20191006085646.5768-9-david@redhat.com>
 <20200204142516.GD26758@MiWiFi-R3L-srv>
 <e0006cc4-d448-89c6-38c0-51da7fc08715@redhat.com>
 <20200205124329.GE26758@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
Message-ID: <cd353848-301a-025d-dd66-44d76e1bbc44@redhat.com>
Date: Wed, 5 Feb 2020 14:20:52 +0100
MIME-Version: 1.0
In-Reply-To: <20200205124329.GE26758@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Dan Williams <dan.j.williams@intel.com>, Wei Yang <richardw.yang@linux.intel.com>

On 05.02.20 13:43, Baoquan He wrote:
> On 02/04/20 at 03:42pm, David Hildenbrand wrote:
>> On 04.02.20 15:25, Baoquan He wrote:
>>> On 10/06/19 at 10:56am, David Hildenbrand wrote:
>>>> If we have holes, the holes will automatically get detected and remo=
ved
>>>> once we remove the next bigger/smaller section. The extra checks can
>>>> go.
>>>>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: Oscar Salvador <osalvador@suse.de>
>>>> Cc: Michal Hocko <mhocko@suse.com>
>>>> Cc: David Hildenbrand <david@redhat.com>
>>>> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>>> Cc: Wei Yang <richardw.yang@linux.intel.com>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>  mm/memory_hotplug.c | 34 +++++++---------------------------
>>>>  1 file changed, 7 insertions(+), 27 deletions(-)
>>>>
>>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>>> index f294918f7211..8dafa1ba8d9f 100644
>>>> --- a/mm/memory_hotplug.c
>>>> +++ b/mm/memory_hotplug.c
>>>> @@ -393,6 +393,9 @@ static void shrink_zone_span(struct zone *zone, =
unsigned long start_pfn,
>>>>  		if (pfn) {
>>>>  			zone->zone_start_pfn =3D pfn;
>>>>  			zone->spanned_pages =3D zone_end_pfn - pfn;
>>>> +		} else {
>>>> +			zone->zone_start_pfn =3D 0;
>>>> +			zone->spanned_pages =3D 0;
>>>>  		}
>>>>  	} else if (zone_end_pfn =3D=3D end_pfn) {
>>>>  		/*
>>>> @@ -405,34 +408,11 @@ static void shrink_zone_span(struct zone *zone=
, unsigned long start_pfn,
>>>>  					       start_pfn);
>>>>  		if (pfn)
>>>>  			zone->spanned_pages =3D pfn - zone_start_pfn + 1;
>>>> +		else {
>>>> +			zone->zone_start_pfn =3D 0;
>>>> +			zone->spanned_pages =3D 0;
>>>
>>> Thinking in which case (zone_start_pfn !=3D start_pfn) and it comes h=
ere.
>>
>> Could only happen in case the zone_start_pfn would have been "out of t=
he
>> zone already". If you ask me: unlikely :)
>=20
> Yeah, I also think it's unlikely to come here.
>=20
> The 'if (zone_start_pfn =3D=3D start_pfn)' checking also covers the cas=
e
> (zone_start_pfn =3D=3D start_pfn && zone_end_pfn =3D=3D end_pfn). So th=
is
> zone_start_pfn/spanned_pages resetting can be removed to avoid
> confusion.

At least I would find it more confusing without it (or want a comment
explaining why this does not have to be handled and why the !pfn case is
not possible).

Anyhow, that patch is already upstream and I don't consider this high
priority. Thanks :)

--=20
Thanks,

David / dhildenb
