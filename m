Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:47294 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbgAHT32 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 8 Jan 2020 14:29:28 -0500
References: <CAPcyv4hdpMs5om4_VrYUz98aWDJ9eRhj7WJr312Jwn6LCmAm9Q@mail.gmail.com>
 <5D5ED235-EB67-4072-8CCA-C046B7EC031C@redhat.com>
 <CAPcyv4jJgBm6rhLn2685HN3DnBKB1FO2ONXC1=Aftspu1hiqmA@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <1786a855-de7e-f9f9-d9b1-9dbe081e7360@deltatee.com>
Date: Wed, 8 Jan 2020 12:29:00 -0700
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jJgBm6rhLn2685HN3DnBKB1FO2ONXC1=Aftspu1hiqmA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 2/8] mm/memory_hotplug: Rename mhp_restrictions to
 mhp_modifiers
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-ia64@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh <linux-sh@vger.kernel.org>, platform-driver-x86@vger.kernel.org, Linux MM <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Eric Badger <ebadger@gigaio.com>



On 2020-01-08 12:13 p.m., Dan Williams wrote:
> On Wed, Jan 8, 2020 at 11:08 AM David Hildenbrand <david@redhat.com> wrote:
>>
>>
>>
>>> Am 08.01.2020 um 20:00 schrieb Dan Williams <dan.j.williams@intel.com>:
>>>
>>> ﻿On Wed, Jan 8, 2020 at 9:17 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>>>>
>>>>
>>>>
>>>>> On 2020-01-08 5:28 a.m., David Hildenbrand wrote:
>>>>> On 07.01.20 21:59, Logan Gunthorpe wrote:
>>>>>> The mhp_restrictions struct really doesn't specify anything resembling
>>>>>> a restriction anymore so rename it to be mhp_modifiers.
>>>>>
>>>>> I wonder if something like "mhp_params" would be even better. It's
>>>>> essentially just a way to avoid changing call chains rough-out all archs
>>>>> whenever we want to add a new parameter.
>>>>
>>>> Sure, that does sound a bit nicer to me. I can change it for v3.
>>>
>>> Oh, I was just about to chime in to support "modifiers" because I
>>> would expect all parameters to folded into a "params" struct. The
>>> modifiers seem to be limited to the set of items that are only
>>> considered in a non-default / expert memory hotplug use cases.

>>
>> It‘s a set of extended parameters I‘d say.

> Sure, we can call them "mhp_params" and just clarify that they are
> optional / extended in the kernel-doc.

Well pgprot isn't going to be optional... But I'll add something to the
kernel_doc.

Logan
