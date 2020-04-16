Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:10233 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438042AbgDPPgw (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Apr 2020 11:36:52 -0400
Subject: Re: [PATCH v4 2/2] mm/gup/writeback: add callbacks for inaccessible
 pages
References: <20200306132537.783769-1-imbrenda@linux.ibm.com>
 <20200306132537.783769-3-imbrenda@linux.ibm.com>
 <3ae46945-0c7b-03cd-700a-a6fe8003c6ab@intel.com>
 <20200415221754.GM2483@worktop.programming.kicks-ass.net>
 <a7c2eb84-94c2-a608-4b04-a740fa9a389d@intel.com>
 <20200416141547.29be5ea0@p-imbrenda>
 <de56aa8e-9035-4b68-33cb-15682d073e26@intel.com>
 <20200416165900.68bd4dba@p-imbrenda>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <a6b8728d-7382-9316-412d-dd48b5e7c41a@intel.com>
Date: Thu, 16 Apr 2020 08:36:50 -0700
MIME-Version: 1.0
In-Reply-To: <20200416165900.68bd4dba@p-imbrenda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, linux-next@vger.kernel.org, akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Sean Christopherson <sean.j.christopherson@intel.com>, borntraeger@de.ibm.com, david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Will Deacon <will@kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>

On 4/16/20 7:59 AM, Claudio Imbrenda wrote:
> On Thu, 16 Apr 2020 07:20:48 -0700
> Dave Hansen <dave.hansen@intel.com> wrote:
>> On 4/16/20 5:15 AM, Claudio Imbrenda wrote:
>>>> I assumed that this was all anonymous-only so it's always dirty
>>>> before writeback starts.  
>>> it could also be mmapped  
>>
>> Let's say you have a mmap()'d ramfs file.  Another process calls which
>> doesn't have it mapped calls sys_write() and writes to the file.
...
>> Where is the arch_make_page_accessible() in this case on the ramfs
>> page?
> 
> it's in the fault handler for the exception the CPU will get when
> attempting to write the data to the protected page

Ahh, so this is *just* intended to precede I/O done on the page, when a
non-host entity is touching the memory?

That seems inconsistent with the process_vm_readv/writev() paths which
set FOLL_PIN on their pin_remote_user_pages() requests, but don't do I/O
to the memory.
