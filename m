From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/4] Provide simple noop dma ops
Date: Fri, 30 Oct 2015 13:55:56 +0100
Message-ID: <563368DC.3080606@de.ibm.com>
References: <1445986131-239566-1-git-send-email-borntraeger@de.ibm.com>
 <1445986131-239566-2-git-send-email-borntraeger@de.ibm.com>
 <20151028004132.GC2805@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20151028004132.GC2805@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Joerg Roedel <jroedel@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Andy Lutomirski <luto@kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, dwmw2@infradead.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Am 28.10.2015 um 01:41 schrieb Joerg Roedel:
> Hi Christian,
> 
> On Tue, Oct 27, 2015 at 11:48:48PM +0100, Christian Borntraeger wrote:
>> +static dma_addr_t dma_noop_map_page(struct device *dev, struct page *page,
>> +				      unsigned long offset, size_t size,
>> +				      enum dma_data_direction dir,
>> +				      struct dma_attrs *attrs)
>> +{
>> +	return page_to_phys(page) + offset;
>> +}
> 
> X86 also has its own version of these noop dma_ops, see
> arch/x86/kernel/pci-nommu.c. This one also checks the dma_mask and
> prints a warning if the physical address doesn't fit into the mask.
> 
> I think this would make sense here too, and that we can also make x86
> use the same generic noop-dma-ops your are introducing.

It not trivial without understanding the dma mask details. Do I read the x86
implementation right, that it limits the dma to 32 bit? Then we cannot collapse
both implementations. Or maybe we can hide this in dma_capable. Dont know

So I would prefer to keep it as is and let someone with x86 test environment do
the unification. Christoph, I think you wanted to do that anyway, are you willing
to do that?


Christian
