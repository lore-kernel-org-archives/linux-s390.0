Return-Path: <SRS0=9P2n=T3=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: mimu@linux.ibm.com
Subject: Re: [PATCH v2 2/8] s390/cio: introduce DMA pools to cio
References: <20190523162209.9543-1-mimu@linux.ibm.com>
 <20190523162209.9543-3-mimu@linux.ibm.com>
 <20190527085718.10494ee2.cohuck@redhat.com>
From: Michael Mueller <mimu@linux.ibm.com>
Date: Mon, 27 May 2019 14:00:38 +0200
MIME-Version: 1.0
In-Reply-To: <20190527085718.10494ee2.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <347a8be1-7db7-f9c9-4755-e02ee4c58e17@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S . Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 27.05.19 08:57, Cornelia Huck wrote:
> On Thu, 23 May 2019 18:22:03 +0200
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
>> From: Halil Pasic <pasic@linux.ibm.com>
>>
>> To support protected virtualization cio will need to make sure the
>> memory used for communication with the hypervisor is DMA memory.
>>
>> Let us introduce one global cio, and some tools for pools seated
> 
> "one global pool for cio"?

changed in v3

> 
>> at individual devices.
>>
>> Our DMA pools are implemented as a gen_pool backed with DMA pages. The
>> idea is to avoid each allocation effectively wasting a page, as we
>> typically allocate much less than PAGE_SIZE.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>> ---
>>   arch/s390/Kconfig           |   1 +
>>   arch/s390/include/asm/cio.h |  11 +++++
>>   drivers/s390/cio/css.c      | 110 ++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 122 insertions(+)
>>
> 
> (...)
> 
>> @@ -1018,6 +1024,109 @@ static struct notifier_block css_power_notifier = {
>>   	.notifier_call = css_power_event,
>>   };
>>   
>> +#define POOL_INIT_PAGES 1
>> +static struct gen_pool *cio_dma_pool;
>> +/* Currently cio supports only a single css */
> 
> This comment looks misplaced.

gone in v3

> 
>> +#define  CIO_DMA_GFP (GFP_KERNEL | __GFP_ZERO)
>> +
>> +
>> +struct device *cio_get_dma_css_dev(void)
>> +{
>> +	return &channel_subsystems[0]->device;
>> +}
>> +
>> +struct gen_pool *cio_gp_dma_create(struct device *dma_dev, int nr_pages)
>> +{
>> +	struct gen_pool *gp_dma;
>> +	void *cpu_addr;
>> +	dma_addr_t dma_addr;
>> +	int i;
>> +
>> +	gp_dma = gen_pool_create(3, -1);
>> +	if (!gp_dma)
>> +		return NULL;
>> +	for (i = 0; i < nr_pages; ++i) {
>> +		cpu_addr = dma_alloc_coherent(dma_dev, PAGE_SIZE, &dma_addr,
>> +					      CIO_DMA_GFP);
>> +		if (!cpu_addr)
>> +			return gp_dma;
> 
> So, you may return here with no memory added to the pool at all (or
> less than requested), but for the caller that is indistinguishable from
> an allocation that went all right. May that be a problem?

Halil,

can you pls. bring some light into the intention of this part of
the code. To me this seems to be odd as well!
Currently cio_gp_dma_create() might succeed with a successful
gen_pool_create() and an initially failing dma_alloc_coherent().

> 
>> +		gen_pool_add_virt(gp_dma, (unsigned long) cpu_addr,
>> +				  dma_addr, PAGE_SIZE, -1);
>> +	}
>> +	return gp_dma;
>> +}
>> +
> 
> (...)
> 
>> +static void __init cio_dma_pool_init(void)
>> +{
>> +	/* No need to free up the resources: compiled in */
>> +	cio_dma_pool = cio_gp_dma_create(cio_get_dma_css_dev(), 1);
> 
> Does it make sense to continue if you did not get a pool here? I don't
> think that should happen unless things were really bad already?

cio_gp_dma_create() will be evaluated and css_bus_init() will fail
in v3 in the NULL case.

> 
>> +}
>> +
>> +void *cio_gp_dma_zalloc(struct gen_pool *gp_dma, struct device *dma_dev,
>> +			size_t size)
>> +{
>> +	dma_addr_t dma_addr;
>> +	unsigned long addr;
>> +	size_t chunk_size;
>> +
>> +	addr = gen_pool_alloc(gp_dma, size);
>> +	while (!addr) {
>> +		chunk_size = round_up(size, PAGE_SIZE);
>> +		addr = (unsigned long) dma_alloc_coherent(dma_dev,
>> +					 chunk_size, &dma_addr, CIO_DMA_GFP);
>> +		if (!addr)
>> +			return NULL;
>> +		gen_pool_add_virt(gp_dma, addr, dma_addr, chunk_size, -1);
>> +		addr = gen_pool_alloc(gp_dma, size);
>> +	}
>> +	return (void *) addr;
>> +}
>> +
>> +void cio_gp_dma_free(struct gen_pool *gp_dma, void *cpu_addr, size_t size)
>> +{
>> +	if (!cpu_addr)
>> +		return;
>> +	memset(cpu_addr, 0, size);
>> +	gen_pool_free(gp_dma, (unsigned long) cpu_addr, size);
>> +}
>> +
>> +/**
>> + * Allocate dma memory from the css global pool. Intended for memory not
>> + * specific to any single device within the css. The allocated memory
>> + * is not guaranteed to be 31-bit addressable.
>> + *
>> + * Caution: Not suitable for early stuff like console.
>> + *
>> + */
>> +void *cio_dma_zalloc(size_t size)
>> +{
>> +	return cio_gp_dma_zalloc(cio_dma_pool, cio_get_dma_css_dev(), size);
> 
> Ok, that looks like the failure I mentioned above should be
> accommodated by the code. Still, I think it's a bit odd.

This code will be reached in v3 only when cio_dma_pool is *not* NULL.

> 
>> +}
> 

Michael
