Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V4 4/4] virtio-mem: check against
 mhp_get_pluggable_range() which memory we can hotplug
References: <1611543532-18698-1-git-send-email-anshuman.khandual@arm.com>
 <1611543532-18698-5-git-send-email-anshuman.khandual@arm.com>
 <a62e9474-ada3-ab80-90a7-14db87c90aa6@redhat.com>
Message-ID: <95e86a10-16db-f5ca-6aba-282ea4ead717@arm.com>
Date: Wed, 27 Jan 2021 09:12:01 +0530
MIME-Version: 1.0
In-Reply-To: <a62e9474-ada3-ab80-90a7-14db87c90aa6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, akpm@linux-foundation.org, hca@linux.ibm.com, catalin.marinas@arm.com
Cc: Oscar Salvador <osalvador@suse.de>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Wei Yang <richard.weiyang@linux.alibaba.com>, teawater <teawaterz@linux.alibaba.com>, Pankaj Gupta <pankaj.gupta@cloud.ionos.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Michal Hocko <mhocko@kernel.org>



On 1/25/21 5:31 PM, David Hildenbrand wrote:
> On 25.01.21 03:58, Anshuman Khandual wrote:
>> From: David Hildenbrand <david@redhat.com>
>>
>> Right now, we only check against MAX_PHYSMEM_BITS - but turns out there
>> are more restrictions of which memory we can actually hotplug, especially
>> om arm64 or s390x once we support them: we might receive something like
>> -E2BIG or -ERANGE from add_memory_driver_managed(), stopping device
>> operation.
>>
>> So, check right when initializing the device which memory we can add,
>> warning the user. Try only adding actually pluggable ranges: in the worst
>> case, no memory provided by our device is pluggable.
>>
>> In the usual case, we expect all device memory to be pluggable, and in
>> corner cases only some memory at the end of the device-managed memory
>> region to not be pluggable.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: catalin.marinas@arm.com
>> Cc: teawater <teawaterz@linux.alibaba.com>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Cc: hca@linux.ibm.com
>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Heiko Carstens <hca@linux.ibm.com>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  drivers/virtio/virtio_mem.c | 40 +++++++++++++++++++++++++------------
>>  1 file changed, 27 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>> index 9fc9ec4a25f5..14c17c5c1695 100644
>> --- a/drivers/virtio/virtio_mem.c
>> +++ b/drivers/virtio/virtio_mem.c
>> @@ -2222,7 +2222,7 @@ static int virtio_mem_unplug_pending_mb(struct virtio_mem *vm)
>>   */
>>  static void virtio_mem_refresh_config(struct virtio_mem *vm)
>>  {
>> -	const uint64_t phys_limit = 1UL << MAX_PHYSMEM_BITS;
>> +	const struct range pluggable_range = mhp_get_pluggable_range(true);
>>  	uint64_t new_plugged_size, usable_region_size, end_addr;
>>  
>>  	/* the plugged_size is just a reflection of what _we_ did previously */
>> @@ -2234,15 +2234,25 @@ static void virtio_mem_refresh_config(struct virtio_mem *vm)
>>  	/* calculate the last usable memory block id */
>>  	virtio_cread_le(vm->vdev, struct virtio_mem_config,
>>  			usable_region_size, &usable_region_size);
>> -	end_addr = vm->addr + usable_region_size;
>> -	end_addr = min(end_addr, phys_limit);
>> +	end_addr = min(vm->addr + usable_region_size - 1,
>> +		       pluggable_range.end);
>>  
>> -	if (vm->in_sbm)
>> -		vm->sbm.last_usable_mb_id =
>> -					 virtio_mem_phys_to_mb_id(end_addr) - 1;
>> -	else
>> -		vm->bbm.last_usable_bb_id =
>> -				     virtio_mem_phys_to_bb_id(vm, end_addr) - 1;
>> +	if (vm->in_sbm) {
>> +		vm->sbm.last_usable_mb_id = virtio_mem_phys_to_mb_id(end_addr);
>> +		if (!IS_ALIGNED(end_addr + 1, memory_block_size_bytes()))
>> +			vm->sbm.last_usable_mb_id--;
>> +	} else {
>> +		vm->bbm.last_usable_bb_id = virtio_mem_phys_to_bb_id(vm,
>> +								     end_addr);
>> +		if (!IS_ALIGNED(end_addr + 1, vm->bbm.bb_size))
>> +			vm->bbm.last_usable_bb_id--;
>> +	}
>> +	/*
>> +	 * If we cannot plug any of our device memory (e.g., nothing in the
>> +	 * usable region is addressable), the last usable memory block id will
>> +	 * be smaller than the first usable memory block id. We'll stop
>> +	 * attempting to add memory with -ENOSPC from our main loop.
>> +	 */
>>  
>>  	/* see if there is a request to change the size */
>>  	virtio_cread_le(vm->vdev, struct virtio_mem_config, requested_size,
>> @@ -2364,6 +2374,7 @@ static int virtio_mem_init_vq(struct virtio_mem *vm)
>>  
>>  static int virtio_mem_init(struct virtio_mem *vm)
>>  {
>> +	const struct range pluggable_range = mhp_get_pluggable_range(true);
>>  	const uint64_t phys_limit = 1UL << MAX_PHYSMEM_BITS;
> 
> Sorry, forgot to drop ^ (phys_limit), otherwise ther is a friendly
> warning from the compiler. We have to drop that line.

Okay sure, will drop.

> 
> 
> 
> Apart from that, at least on x86-64 it does what it's supposed to do. I
> temporarily changed MAX_PHYSMEM_BITS to 35 bits and added a virtio-mem
> device that crosses the 32 GiB address limit.
> 
> 
> [    0.572084] virtio_mem virtio1: Some device memory is not
> addressable/pluggable. This can make some memory unusable.
> [    0.573013] virtio_mem virtio1: start address: 0x740000000
> [    0.573497] virtio_mem virtio1: region size: 0x500000000
> 
> 
> And virtio-mem won't add any memory exceeding that:
> 
> (qemu) qom-set vmem0 requested-size 20G
> (qemu) info memory-devices
> Memory device [virtio-mem]: "vmem0"
> [...]
> Memory device [virtio-mem]: "vmem1"
>   memaddr: 0x740000000
>   node: 1
>   requested-size: 21474836480
>   size: 3221225472
>   max-size: 21474836480
>   block-size: 2097152
>   memdev: /objects/mem1
> 
> I adds all memory up to the 32GiB address limit (35 bits) and stops.
> 
> LGTM (arm64 to be tested in the future once supported).
> 

I will respin the series with the above minor change unless something
else comes up in the meantime. But once this virtio-mem change gets
some more reviews, I guess the series should be complete in itself.
