Return-Path: <SRS0=A7Pw=TP=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: mimu@linux.ibm.com
Subject: Re: [PATCH 04/10] s390/mm: force swiotlb for protected virtualization
References: <20190426183245.37939-1-pasic@linux.ibm.com>
 <20190426183245.37939-5-pasic@linux.ibm.com>
 <20190508151540.14ba1d90@p-imbrenda.boeblingen.de.ibm.com>
 <20190510003401.4254f200.pasic@linux.ibm.com>
From: Michael Mueller <mimu@linux.ibm.com>
Date: Wed, 15 May 2019 16:15:03 +0200
MIME-Version: 1.0
In-Reply-To: <20190510003401.4254f200.pasic@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <cfb14388-15ed-afe3-f0a7-6cb384e73995@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 10.05.19 00:34, Halil Pasic wrote:
> On Wed, 8 May 2019 15:15:40 +0200
> Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:
> 
>> On Fri, 26 Apr 2019 20:32:39 +0200
>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>
>>> On s390, protected virtualization guests have to use bounced I/O
>>> buffers.  That requires some plumbing.
>>>
>>> Let us make sure, any device that uses DMA API with direct ops
>>> correctly is spared from the problems, that a hypervisor attempting
>>> I/O to a non-shared page would bring.
>>>
>>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>>> ---
>>>   arch/s390/Kconfig                   |  4 +++
>>>   arch/s390/include/asm/mem_encrypt.h | 18 +++++++++++++
>>>   arch/s390/mm/init.c                 | 50
>>> +++++++++++++++++++++++++++++++++++++ 3 files changed, 72
>>> insertions(+) create mode 100644 arch/s390/include/asm/mem_encrypt.h
>>>
>>> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
>>> index 1c3fcf19c3af..5500d05d4d53 100644
>>> --- a/arch/s390/Kconfig
>>> +++ b/arch/s390/Kconfig
>>> @@ -1,4 +1,7 @@
>>>   # SPDX-License-Identifier: GPL-2.0
>>> +config ARCH_HAS_MEM_ENCRYPT
>>> +        def_bool y
>>> +
>>>   config MMU
>>>   	def_bool y
>>>   
>>> @@ -191,6 +194,7 @@ config S390
>>>   	select ARCH_HAS_SCALED_CPUTIME
>>>   	select VIRT_TO_BUS
>>>   	select HAVE_NMI
>>> +	select SWIOTLB
>>>   
>>>   
>>>   config SCHED_OMIT_FRAME_POINTER
>>> diff --git a/arch/s390/include/asm/mem_encrypt.h
>>> b/arch/s390/include/asm/mem_encrypt.h new file mode 100644
>>> index 000000000000..0898c09a888c
>>> --- /dev/null
>>> +++ b/arch/s390/include/asm/mem_encrypt.h
>>> @@ -0,0 +1,18 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +#ifndef S390_MEM_ENCRYPT_H__
>>> +#define S390_MEM_ENCRYPT_H__
>>> +
>>> +#ifndef __ASSEMBLY__
>>> +
>>> +#define sme_me_mask	0ULL
>>
>> This is rather ugly, but I understand why it's there
>>
> 
> Nod.
> 
>>> +
>>> +static inline bool sme_active(void) { return false; }
>>> +extern bool sev_active(void);
>>> +
>>> +int set_memory_encrypted(unsigned long addr, int numpages);
>>> +int set_memory_decrypted(unsigned long addr, int numpages);
>>> +
>>> +#endif	/* __ASSEMBLY__ */
>>> +
>>> +#endif	/* S390_MEM_ENCRYPT_H__ */
>>> +
>>> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
>>> index 3e82f66d5c61..7e3cbd15dcfa 100644
>>> --- a/arch/s390/mm/init.c
>>> +++ b/arch/s390/mm/init.c
>>> @@ -18,6 +18,7 @@
>>>   #include <linux/mman.h>
>>>   #include <linux/mm.h>
>>>   #include <linux/swap.h>
>>> +#include <linux/swiotlb.h>
>>>   #include <linux/smp.h>
>>>   #include <linux/init.h>
>>>   #include <linux/pagemap.h>
>>> @@ -29,6 +30,7 @@
>>>   #include <linux/export.h>
>>>   #include <linux/cma.h>
>>>   #include <linux/gfp.h>
>>> +#include <linux/dma-mapping.h>
>>>   #include <asm/processor.h>
>>>   #include <linux/uaccess.h>
>>>   #include <asm/pgtable.h>
>>> @@ -42,6 +44,8 @@
>>>   #include <asm/sclp.h>
>>>   #include <asm/set_memory.h>
>>>   #include <asm/kasan.h>
>>> +#include <asm/dma-mapping.h>
>>> +#include <asm/uv.h>
>>>   
>>>   pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
>>>   
>>> @@ -126,6 +130,50 @@ void mark_rodata_ro(void)
>>>   	pr_info("Write protected read-only-after-init data: %luk\n",
>>> size >> 10); }
>>>   
>>> +int set_memory_encrypted(unsigned long addr, int numpages)
>>> +{
>>> +	int i;
>>> +
>>> +	/* make all pages shared, (swiotlb, dma_free) */
>>
>> this is a copypaste typo, I think? (should be UNshared?)
>> also, it doesn't make ALL pages unshared, but only those specified in
>> the parameters
> 
> Right a copy paste error. Needs correction. The all was meant like all
> pages in the range specified by the arguments. But it is better changed
> since it turned out to be confusing.
> 
>>
>> with this fixed:
>> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>>
> 
> Thanks!
> 
>>> +	for (i = 0; i < numpages; ++i) {
>>> +		uv_remove_shared(addr);
>>> +		addr += PAGE_SIZE;
>>> +	}
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(set_memory_encrypted);
>>> +
>>> +int set_memory_decrypted(unsigned long addr, int numpages)
>>> +{
>>> +	int i;
>>> +	/* make all pages shared (swiotlb, dma_alloca) */
>>
>> same here with ALL
>>
>>> +	for (i = 0; i < numpages; ++i) {
>>> +		uv_set_shared(addr);
>>> +		addr += PAGE_SIZE;
>>> +	}
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(set_memory_decrypted);
>>> +
>>> +/* are we a protected virtualization guest? */
>>> +bool sev_active(void)
>>
>> this is also ugly. the correct solution would be probably to refactor
>> everything, including all the AMD SEV code.... let's not go there
>>
> 
> Nod. Maybe later.
> 
>>> +{
>>> +	return is_prot_virt_guest();
>>> +}
>>> +EXPORT_SYMBOL_GPL(sev_active);
>>> +
>>> +/* protected virtualization */
>>> +static void pv_init(void)
>>> +{
>>> +	if (!sev_active())
>>
>> can't you just use is_prot_virt_guest here?
>>
> 
> Sure! I guess it would be less confusing. It is something I did not
> remember to change when the interface for this provided by uv.h went
> from sketchy to nice.

integrated in v2

Michael

> 
> Thanks again!
> 
> Regards,
> Halil
> 
>>> +		return;
>>> +
>>> +	/* make sure bounce buffers are shared */
>>> +	swiotlb_init(1);
>>> +	swiotlb_update_mem_attributes();
>>> +	swiotlb_force = SWIOTLB_FORCE;
>>> +}
>>> +
>>>   void __init mem_init(void)
>>>   {
>>>   	cpumask_set_cpu(0, &init_mm.context.cpu_attach_mask);
>>> @@ -134,6 +182,8 @@ void __init mem_init(void)
>>>   	set_max_mapnr(max_low_pfn);
>>>           high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
>>>   
>>> +	pv_init();
>>> +
>>>   	/* Setup guest page hinting */
>>>   	cmma_init();
>>>   
>>
> 

-- 
Mit freundlichen Grüßen / Kind regards
Michael Müller

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
