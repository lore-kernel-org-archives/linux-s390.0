Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:6255 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgDUVb2 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Apr 2020 17:31:28 -0400
Subject: Re: [PATCH v4 2/2] mm/gup/writeback: add callbacks for inaccessible
 pages
From: Dave Hansen <dave.hansen@intel.com>
References: <20200306132537.783769-1-imbrenda@linux.ibm.com>
 <20200306132537.783769-3-imbrenda@linux.ibm.com>
 <3ae46945-0c7b-03cd-700a-a6fe8003c6ab@intel.com>
 <20200415221754.GM2483@worktop.programming.kicks-ass.net>
 <a7c2eb84-94c2-a608-4b04-a740fa9a389d@intel.com>
 <20200416141547.29be5ea0@p-imbrenda>
 <de56aa8e-9035-4b68-33cb-15682d073e26@intel.com>
 <20200416165900.68bd4dba@p-imbrenda>
 <a6b8728d-7382-9316-412d-dd48b5e7c41a@intel.com>
 <20200416183431.7216e1d1@p-imbrenda>
 <396a4ece-ec66-d023-2c7e-f09f84b358bc@intel.com>
Message-ID: <cbaddd28-c5d3-61a2-84d8-c883fb3d6290@intel.com>
Date: Tue, 21 Apr 2020 14:31:28 -0700
MIME-Version: 1.0
In-Reply-To: <396a4ece-ec66-d023-2c7e-f09f84b358bc@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, linux-next@vger.kernel.org, akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Sean Christopherson <sean.j.christopherson@intel.com>, borntraeger@de.ibm.com, david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Will Deacon <will@kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>

On 4/16/20 12:02 PM, Dave Hansen wrote:
> On 4/16/20 9:34 AM, Claudio Imbrenda wrote:
>>> Ahh, so this is *just* intended to precede I/O done on the page, when
>>> a non-host entity is touching the memory?
>> yep
> OK, so we've got to do an action that precedes *all* I/O to a page.
> That's not too bad.
> 
> I still don't understand how this could work generally, though  There
> are lots of places where I/O is done to a page without either going
> through __test_set_page_writeback() or gup() with FOLL_PIN set.
> 
> sendfile() is probably the best example of this:
> 
> 	fd = open("/normal/ext4/file", O_RDONLY);
> 	sendfile(socket_fd, fd, &off, count);
> 
> There's no gup in sight since the file doesn't have an address and it's
> not being written to so there's no writeback.
> 
> How does sendfile work?

Did you manage to see if sendfile works (or any other operation that
DMAs file-backed data without being preceded by a gup)?

I suspect it's actually not that hard to fix.  As long as you have a
dma_ops for the devices in question either via dev->dma_ops or you add
an s390 get_arch_vm_ops(), you can fix *all* the DMA sites, sendfile()
included.

BTW, device drivers do need to know how to use the DMA mapping API.  If
s390 has drivers that need to be updated, I think that's vastly
preferable to incomplete hooks in core mm code.
