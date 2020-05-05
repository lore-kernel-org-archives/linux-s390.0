Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:33155 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729315AbgEEOYX (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 5 May 2020 10:24:23 -0400
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
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <6e97a4b0-df4f-90c7-a6f7-61ee52e0833e@intel.com>
Date: Tue, 5 May 2020 07:24:18 -0700
MIME-Version: 1.0
In-Reply-To: <45bc81bb-8765-ffff-6e47-8ee9702c8bcd@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Ulrich Weigand <uweigand@de.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>, viro@zeniv.linux.org.uk, david@redhat.com, akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, jack@suse.cz, kirill@shutemov.name, peterz@infradead.org, sean.j.christopherson@intel.com, Ulrich.Weigand@de.ibm.com

On 5/5/20 7:00 AM, Christian Borntraeger wrote:
> We are certainly not married to our approach. I would happily extend/change
> this to anything that works for your case and the s390 case. So can you outline
> your requirements a bit more?

For SEV, the guest define which pages are encrypted or not.  You could
theoretically do DMA to them or have the CPU access their contents, but
you'd get either get ciphertext for reads, or data corruption and loss
of cache coherency for writes.  That's not so cool.

Ideally, we would stop the CPU from ever accessing those pages by
unmapping them.  But, the pages go in and out of the encrypted state and
the host really needs to be *sure* about what's going on before it
restores its mapping and messes with the page.  That includes situations
where someone does a gup, starts an I/O to an unencrypted page, then the
guest tries to convert that page over to being encrypted.

So, the requirements are:

1. Allow host-side DMA and CPU access to shared pages
2. Stop host-side DMA and CPU access to encrypted pages
3. Allow pages to be converted between the states at the request of the
   guest

Stopping the DMA is pretty easy, even across the gazillions of drivers
in the tree because even random ethernet drivers do stuff like:

                txdr->buffer_info[i].dma =
                        dma_map_single(&pdev->dev, skb->data, skb->len,
                                       DMA_TO_DEVICE);

So the DMA can be stopped at the mapping layer.  It's a *LOT* easier to
catch there since the IOMMUs already provide isolation between the I/O
and CPU address spaces.
