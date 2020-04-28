Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33113 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726180AbgD1UEI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 28 Apr 2020 16:04:08 -0400
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
 <a6b8728d-7382-9316-412d-dd48b5e7c41a@intel.com>
 <20200416183431.7216e1d1@p-imbrenda>
 <396a4ece-ec66-d023-2c7e-f09f84b358bc@intel.com>
 <cbaddd28-c5d3-61a2-84d8-c883fb3d6290@intel.com>
 <42fccd01-7e16-b18f-cd81-4040857d80d4@intel.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <929f7d1f-0cc8-e140-6f74-4797704e5185@de.ibm.com>
Date: Tue, 28 Apr 2020 22:02:38 +0200
MIME-Version: 1.0
In-Reply-To: <42fccd01-7e16-b18f-cd81-4040857d80d4@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, linux-next@vger.kernel.org, akpm@linux-foundation.org, jack@suse.cz, kirill@shutemov.name, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, Sean Christopherson <sean.j.christopherson@intel.com>, david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Will Deacon <will@kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>


On 28.04.20 21:43, Dave Hansen wrote:
> On 4/21/20 2:31 PM, Dave Hansen wrote:
>> On 4/16/20 12:02 PM, Dave Hansen wrote:
>>> On 4/16/20 9:34 AM, Claudio Imbrenda wrote:
>>>>> Ahh, so this is *just* intended to precede I/O done on the page, when
>>>>> a non-host entity is touching the memory?
>>>> yep
>>> OK, so we've got to do an action that precedes *all* I/O to a page.
>>> That's not too bad.
>>>
>>> I still don't understand how this could work generally, though  There
>>> are lots of places where I/O is done to a page without either going
>>> through __test_set_page_writeback() or gup() with FOLL_PIN set.
>>>
>>> sendfile() is probably the best example of this:
>>>
>>> 	fd = open("/normal/ext4/file", O_RDONLY);
>>> 	sendfile(socket_fd, fd, &off, count);
>>>
>>> There's no gup in sight since the file doesn't have an address and it's
>>> not being written to so there's no writeback.
>>>
>>> How does sendfile work?
>>
>> Did you manage to see if sendfile works (or any other operation that
>> DMAs file-backed data without being preceded by a gup)?
> 
> It's been a couple of weeks with no response on this.
> 
> From where I'm standing, we have a hook in the core VM that can't
> possibly work with some existing kernel functionality and has virtually
> no chance of getting used on a second architecture.
> 
> It sounds like there may need to be some additional work here, but
> should these hooks stay in for 5.7?  Or, should we revert this patch and
> try again for 5.8?

We have something and Claudio is going to send out an addon patch soon. 
Reverting would be harmful basically allowing for I/O errors on a valid
path that can happen with normal use. The sendfile case is also valid, but
it only triggers for a handcrafted cases (you have to change QEMU to use
MAP_SHARED and you have to use a file as memory backing and you have to
splice this file then to another file that is using DIRECT_IO). Those cases
then run into an I/O error case that is recovered by the driver. the same
would not work for a swap backing.

It is also not trivial (or doable) to change all device drivers that exist
on s390 to use the DMA API. In the long run we might be able to get the 
necessary changes into the DMA api.

Claudio will send the details tomorrow. 
