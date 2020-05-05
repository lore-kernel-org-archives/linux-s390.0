Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26414 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725766AbgEEJg0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 05:36:26 -0400
Subject: Re: linux-next: Tree for May 4 --> mm: free_area_init: allow defining
 max_zone_pfn in descending order does increase memory use
References: <20200504173547.2cdd83bf@canb.auug.org.au>
 <9e9edd1e-6653-a585-0e22-69930a07dce1@de.ibm.com>
 <20200504154410.GF342687@linux.ibm.com>
 <20200505070828.20fd21af@canb.auug.org.au>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <1631771e-371b-c233-ec0f-056646694c85@de.ibm.com>
Date: Tue, 5 May 2020 11:36:14 +0200
MIME-Version: 1.0
In-Reply-To: <20200505070828.20fd21af@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Mike Rapoport <rppt@linux.ibm.com>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Marc Hartmayer <mhartmay@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>



On 04.05.20 23:08, Stephen Rothwell wrote:
> Hi Mike,
> 
> On Mon, 4 May 2020 18:44:10 +0300 Mike Rapoport <rppt@linux.ibm.com> wrote:
>>
>> Ho Christian,
>>
>> On Mon, May 04, 2020 at 04:50:06PM +0200, Christian Borntraeger wrote:
>>> Mike,
>>> commit 51a2f644fd020d5f090044825c388444d11029d ("mm: free_area_init: allow defining max_zone_pfn in descending order")
>>> does increase the memory use on s390 (e.g. 700 MB vs.1.8 GB).
>>>
>>> Something is odd in this patch. Any idea?  
>>
>> Yeah, this patch is buggy. In short, it breaks zone size calculation on
>> s390 and some other architectures.
>>
>> I've just replied at [1] with more details and a fix.
>>
>> [1] https://lore.kernel.org/linux-mm/20200504153901.GM14260@kernel.org/
> 
> I have added that to linux-next for today.
> 

Ack, 5.7.0-rc4-next-20200505 seems to work fine. 
