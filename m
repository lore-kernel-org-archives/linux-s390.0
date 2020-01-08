Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33705 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729516AbgAHTAC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jan 2020 14:00:02 -0500
Received: by mail-ot1-f68.google.com with SMTP id b18so4677902otp.0
        for <linux-s390@vger.kernel.org>; Wed, 08 Jan 2020 11:00:02 -0800 (PST)
MIME-Version: 1.0
References: <20200107205959.7575-1-logang@deltatee.com> <20200107205959.7575-3-logang@deltatee.com>
 <3e432695-e3a9-2aae-e9f5-1b6454886c06@redhat.com> <eef4ec73-8823-9f20-93ed-5c09f18c437a@deltatee.com>
In-Reply-To: <eef4ec73-8823-9f20-93ed-5c09f18c437a@deltatee.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 8 Jan 2020 10:59:51 -0800
Message-ID: <CAPcyv4hdpMs5om4_VrYUz98aWDJ9eRhj7WJr312Jwn6LCmAm9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] mm/memory_hotplug: Rename mhp_restrictions to mhp_modifiers
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: David Hildenbrand <david@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-ia64@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh <linux-sh@vger.kernel.org>, platform-driver-x86@vger.kernel.org, Linux MM <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Eric Badger <ebadger@gigaio.com>

On Wed, Jan 8, 2020 at 9:17 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2020-01-08 5:28 a.m., David Hildenbrand wrote:
> > On 07.01.20 21:59, Logan Gunthorpe wrote:
> >> The mhp_restrictions struct really doesn't specify anything resembling
> >> a restriction anymore so rename it to be mhp_modifiers.
> >
> > I wonder if something like "mhp_params" would be even better. It's
> > essentially just a way to avoid changing call chains rough-out all archs
> > whenever we want to add a new parameter.
>
> Sure, that does sound a bit nicer to me. I can change it for v3.

Oh, I was just about to chime in to support "modifiers" because I
would expect all parameters to folded into a "params" struct. The
modifiers seem to be limited to the set of items that are only
considered in a non-default / expert memory hotplug use cases.
