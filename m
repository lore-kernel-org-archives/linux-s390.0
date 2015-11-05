From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 3/3] s390/dma: Allow per device dma ops
Date: Thu, 5 Nov 2015 11:22:22 -0800
Message-ID: <563BAC6E.3010003@kernel.org>
References: <1446551679-33492-1-git-send-email-borntraeger@de.ibm.com>
 <1446551679-33492-4-git-send-email-borntraeger@de.ibm.com>
 <20151103132615.53002e05.cornelia.huck@de.ibm.com>
 <563B2275.3010406@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <563B2275.3010406@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, dwmw2@infradead.org, Joerg Roedel <jroedel@suse.de>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, virtualization@lists.linux-foundation.org, Michael Tsirkin <mst@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On 11/05/2015 01:33 AM, Christian Borntraeger wrote:
> Am 03.11.2015 um 13:26 schrieb Cornelia Huck:
>> On Tue,  3 Nov 2015 12:54:39 +0100
>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>
>>> As virtio-ccw now has dma ops, we can no longer default to the PCI ones.
>>> Make use of dev_archdata to keep the dma_ops per device. The pci devices
>>> now use that to override the default, and the default is changed to use
>>> the noop ops for everything that is not PCI. To compile without PCI
>>> support we also have to enable the DMA api with virtio.
>>
>> Not only with virtio, but generally, right?
>
> Yes, will update the patch description.
>>
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> Reviewed-by: Joerg Roedel <jroedel@suse.de>
>>> Acked-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
>>> ---
>>>   arch/s390/Kconfig                   | 3 ++-
>>>   arch/s390/include/asm/device.h      | 6 +++++-
>>>   arch/s390/include/asm/dma-mapping.h | 6 ++++--
>>>   arch/s390/pci/pci.c                 | 1 +
>>>   arch/s390/pci/pci_dma.c             | 4 ++--
>>>   5 files changed, 14 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
>>> index 1d57000..04f0e02 100644
>>> --- a/arch/s390/Kconfig
>>> +++ b/arch/s390/Kconfig
>>> @@ -113,6 +113,7 @@ config S390
>>>   	select GENERIC_FIND_FIRST_BIT
>>>   	select GENERIC_SMP_IDLE_THREAD
>>>   	select GENERIC_TIME_VSYSCALL
>>> +	select HAS_DMA
>>>   	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
>>>   	select HAVE_ARCH_AUDITSYSCALL
>>>   	select HAVE_ARCH_EARLY_PFN_TO_NID
>>> @@ -124,6 +125,7 @@ config S390
>>>   	select HAVE_CMPXCHG_DOUBLE
>>>   	select HAVE_CMPXCHG_LOCAL
>>>   	select HAVE_DEBUG_KMEMLEAK
>>> +	select HAVE_DMA_ATTRS
>>>   	select HAVE_DYNAMIC_FTRACE
>>>   	select HAVE_DYNAMIC_FTRACE_WITH_REGS
>>>   	select HAVE_FTRACE_MCOUNT_RECORD
>>> @@ -580,7 +582,6 @@ config QDIO
>>>
>>>   menuconfig PCI
>>>   	bool "PCI support"
>>> -	select HAVE_DMA_ATTRS
>>>   	select PCI_MSI
>>>   	help
>>>   	  Enable PCI support.
>>
>> Hm. Further down in this file, there's
>>
>> config HAS_DMA
>>          def_bool PCI
>>          select HAVE_DMA_API_DEBUG
>>
>> Should we maybe select HAVE_DMA_API_DEBUG above, drop the HAS_DMA
>> config option and rely on not defining NO_DMA instead?
>
> Hmm, yes. That would simplify things a lot.  Right now we include
> lib/Kconfig (which defines HAS_DMA) and define it ourselfes in
> arch/s390/Kconfig. WHoever comes first wins. Adding a select statement
> would make this even more complicated.
>
> Andy, I will simply send you a respin of this patch.
>

I'm slightly concerned that I'm going to screw this all up and apply the 
wrong version.  Could you resend the whole series with git format-patch 
-vN for some appropriate N (or similar)?

Thanks,
Andy
