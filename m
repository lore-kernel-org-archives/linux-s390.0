Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15400 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbgFZRXE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 26 Jun 2020 13:23:04 -0400
Date: Fri, 26 Jun 2020 19:22:53 +0200
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH RFC] s390x/vmem: get rid of memory segment list
Message-ID: <20200626192253.2281d95d@thinkpad>
In-Reply-To: <20200625150029.45019-1-david@redhat.com>
References: <20200625150029.45019-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>

On Thu, 25 Jun 2020 17:00:29 +0200
David Hildenbrand <david@redhat.com> wrote:

> I can't come up with a satisfying reason why we still need the memory
> segment list. We used to represent in the list:
> - boot memory
> - standby memory added via add_memory()
> - loaded dcss segments
> 
> When loading/unloading dcss segments, we already track them in a
> separate list and check for overlaps
> (arch/s390/mm/extmem.c:segment_overlaps_others()) when loading segments.
> 
> The overlap check was introduced for some segments in
> commit b2300b9efe1b ("[S390] dcssblk: add >2G DCSSs support and stacked
> contiguous DCSSs support.")
> and was extended to cover all dcss segments in
> commit ca57114609d1 ("s390/extmem: remove code for 31 bit addressing
> mode").
> 
> Although I doubt that overlaps with boot memory and standby memory
> are relevant, let's reshuffle the checks in load_segment() to request
> the resource first. This will bail out in case we have overlaps with
> other resources (esp. boot memory and standby memory). The order
> is now different compared to segment_unload() and segment_unload(), but
> that should not matter.

You are right that this is ancient, but I think "overlaps with boot
memory and standby memory" were very relevant, that might actually
have been the initial reason for this in ancient times (but I do not
really remember).

With DCSS you can define a fixed start address where the segment will
be loaded into guest address space. The current code queries this address
and directly gives it to vmem_add_mapping(), at least if there is no
overlap with other DCSS segments. If there would be an overlap with
boot memory, and not checked / rejected in vmem_add_mapping(), the
following dcss_diag() would probably fail because AFAIR z/VM will
not allow loading a DCSS with guest memory overlap. So far, so good,
but the vmem_remove_mapping() on the exit path would then remove
(part of) boot memory.

That being said, I think your patch prevents this by moving
request_resource() up, so we should not call vmem_add_mapping()
for such overlaps. I still want to give it some test, but need
to find / setup systems with that ancient technology first :-)

One change introduced by this patch is that we no longer
see -ENOSPC and the corresponding error message from extmem code:
"DCSS %s overlaps with used storage and cannot be loaded"

Instead, now we would see -EBUSY and this message:
"%s needs used memory resources and cannot be loaded or queried"

That should be OK, as it is also the same message that we already
see for overlaps with other DCSSs. But you probably also should
remove that case from the segment_warning() function for
completeness.

Regards,
Gerald
