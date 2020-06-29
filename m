Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56401 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729042AbgF2TDz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 29 Jun 2020 15:03:55 -0400
Subject: Re: [PATCH RFC 2/2] s390/mm: don't set ARCH_KEEP_MEMBLOCK
References: <20200417150151.17239-1-david@redhat.com>
 <20200417150151.17239-3-david@redhat.com> <20200626163215.GA4268@osiris>
 <20200629124432.GE4468@osiris>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1d9b431a-58cb-8b5f-cb3f-5656a3032e34@redhat.com>
Date: Mon, 29 Jun 2020 15:02:30 +0200
MIME-Version: 1.0
In-Reply-To: <20200629124432.GE4468@osiris>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Philipp Rudo <prudo@linux.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>

On 29.06.20 14:44, Heiko Carstens wrote:
> On Fri, Jun 26, 2020 at 06:32:15PM +0200, Heiko Carstens wrote:
>> On Fri, Apr 17, 2020 at 05:01:51PM +0200, David Hildenbrand wrote:
>>> Commit 50be63450728 ("s390/mm: Convert bootmem to memblock") mentions
>>> 	"The original bootmem allocator is getting replaced by memblock. To
>>> 	cover the needs of the s390 kdump implementation the physical
>>> 	memory list is used."
>>>
>>> zcore was converted to use resources instead of memblocks.
>>> memblock_discard() will *not* mess with "physmem", only with "memory" and
>>> "reserved" memblocks. So, that data will stay after early boot, to be
>>> used in arch/s390/kernel/crash_dump.c to create the ELF header from
>>> inside the 2nd (a.k.a. dumping) kernel.
>>>
>>> We no longer need ARCH_KEEP_MEMBLOCK.
>>>
>>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>>> Cc: Philipp Rudo <prudo@linux.ibm.com>
>>> Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  arch/s390/Kconfig | 1 -
>>>  1 file changed, 1 deletion(-)
>>
>> Applied, thanks!
> 
> Hmm, this triggers:

Ah, I see, will have a look. Weird I didn't notice that ...

Thanks!



-- 
Thanks,

David / dhildenb
