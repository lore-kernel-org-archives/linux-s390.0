Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28380 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726175AbfJ3PHU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 30 Oct 2019 11:07:20 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9UF5GSq142159
        for <linux-s390@vger.kernel.org>; Wed, 30 Oct 2019 11:07:18 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vyc7r2spx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 30 Oct 2019 11:07:18 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <iii@linux.ibm.com>;
        Wed, 30 Oct 2019 15:07:13 -0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH] mm/sparse.c: mark populate_section_memmap as __meminit
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20191030081359.GA11931@linux>
Date: Wed, 30 Oct 2019 16:07:09 +0100
Content-Transfer-Encoding: 8BIT
References: <20191028165549.14478-1-iii@linux.ibm.com>
 <20191030081359.GA11931@linux>
Message-Id: <EA4FBE3A-13D4-4ECF-A2FC-64CBACEA9A87@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

> Am 30.10.2019 um 09:14 schrieb Oscar Salvador <osalvador@suse.de>:
> 
> On Mon, Oct 28, 2019 at 05:55:49PM +0100, Ilya Leoshkevich wrote:
>> Building the kernel on s390 with -Og produces the following warning:
>> 
>> WARNING: vmlinux.o(.text+0x28dabe): Section mismatch in reference from the function populate_section_memmap() to the function .meminit.text:__populate_section_memmap()
>> The function populate_section_memmap() references
>> the function __meminit __populate_section_memmap().
>> This is often because populate_section_memmap lacks a __meminit
>> annotation or the annotation of __populate_section_memmap is wrong.
>> 
>> While -Og is not supported, in theory this might still happen with
>> another compiler or on another architecture. So fix this by using the
>> correct section annotations.
>> 
>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> ---
>> mm/sparse.c | 6 +++---
>> 1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/mm/sparse.c b/mm/sparse.c
>> index f6891c1992b1..0f1f36443a96 100644
>> --- a/mm/sparse.c
>> +++ b/mm/sparse.c
>> @@ -448,7 +448,7 @@ static unsigned long __init section_map_size(void)
>> 	return PAGE_ALIGN(sizeof(struct page) * PAGES_PER_SECTION);
>> }
>> 
>> -struct page __init *__populate_section_memmap(unsigned long pfn,
>> +struct page __meminit *__populate_section_memmap(unsigned long pfn,
>> 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>> {
>> 	unsigned long size = section_map_size();
>> @@ -647,7 +647,7 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
>> #endif
>> 
>> #ifdef CONFIG_SPARSEMEM_VMEMMAP
>> -static struct page *populate_section_memmap(unsigned long pfn,
>> +static struct page * __meminit populate_section_memmap(unsigned long pfn,
>> 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>> {
>> 	return __populate_section_memmap(pfn, nr_pages, nid, altmap);
>> @@ -669,7 +669,7 @@ static void free_map_bootmem(struct page *memmap)
>> 	vmemmap_free(start, end, NULL);
>> }
>> #else
>> -struct page *populate_section_memmap(unsigned long pfn,
>> +struct page * __meminit populate_section_memmap(unsigned long pfn,
>> 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap)
>> {
>> 	struct page *page, *ret;
> 
> I did not really check deep, but I __think__ you only need to add __meminit in
> populate_section_memmap functions.
> 
> __populate_section_memmap for SPARSE case is only used at init phase.

You are absolutely right, and this is what must be causing the problem
on sh4.

With CONFIG_SPARSEMEM_VMEMMAP, populate_section_memmap calls
__populate_section_memmap version from mm/sparse-vmemmap.c, which is
already marked as __meminit.

Without CONFIG_SPARSEMEM_VMEMMAP, populate_section_memmap does not
call __populate_section_memmap (which is then defined in mm/sparse.c).
Like you said, in this case the latter is called only during the init
phase (by sparse_init_nid), so it should keep the __init annotation.

I think it still makes sense to mark the !CONFIG_SPARSEMEM_VMEMMAP
version of populate_section_memmap as __meminit, since it's only called
from __meminit section_activate.

I will send a v2.
