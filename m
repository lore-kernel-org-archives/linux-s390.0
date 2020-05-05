Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10117 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729142AbgEEOep (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 5 May 2020 10:34:45 -0400
Subject: Re: [PATCH v2 1/1] fs/splice: add missing callback for inaccessible
 pages
References: <20200430143825.3534128-1-imbrenda@linux.ibm.com>
 <1a3f5107-9847-73d4-5059-c6ef9d293551@de.ibm.com>
 <e3e95a35-b0e3-b733-92f4-98bcccbe7ca5@intel.com>
 <3d379d9e-241c-ef3b-dcef-20fdd3b8740d@de.ibm.com>
 <a10ec7ad-2648-950e-7f30-07c08e400e7b@intel.com>
 <20200504134154.GA21001@oc3748833570.ibm.com>
 <231da2f1-a6ef-0cf9-7f57-95e8b925997b@intel.com>
 <45bc81bb-8765-ffff-6e47-8ee9702c8bcd@de.ibm.com>
 <6e97a4b0-df4f-90c7-a6f7-61ee52e0833e@intel.com>
 <da6bc7cb-ef13-08cd-f162-663b4a66043b@de.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <fcc9adea-598f-f882-c3e3-09d190cd5d52@intel.com>
Date: Tue, 5 May 2020 07:34:39 -0700
MIME-Version: 1.0
In-Reply-To: <da6bc7cb-ef13-08cd-f162-663b4a66043b@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Ulrich Weigand <uweigand@de.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>, viro@zeniv.linux.org.uk, david@redhat.com, akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, jack@suse.cz, kirill@shutemov.name, peterz@infradead.org, sean.j.christopherson@intel.com, Ulrich.Weigand@de.ibm.com

On 5/5/20 7:31 AM, Christian Borntraeger wrote:
>> So, the requirements are:
>>
>> 1. Allow host-side DMA and CPU access to shared pages
>> 2. Stop host-side DMA and CPU access to encrypted pages
>> 3. Allow pages to be converted between the states at the request of the
>>    guest
>>
>> Stopping the DMA is pretty easy, even across the gazillions of drivers
>> in the tree because even random ethernet drivers do stuff like:
>>
>>                 txdr->buffer_info[i].dma =
>>                         dma_map_single(&pdev->dev, skb->data, skb->len,
>>                                        DMA_TO_DEVICE);
>>
>> So the DMA can be stopped at the mapping layer.  It's a *LOT* easier to
>> catch there since the IOMMUs already provide isolation between the I/O
>> and CPU address spaces.
> And your problem is that the guest could convert this after the dma_map?
> So you looked into our code if this would help?

Yep, it seemed like a close-enough problem.
