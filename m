Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH RFC] virtio-mem: check against memhp_get_pluggable_range()
 which memory we can hotplug
References: <1610975582-12646-1-git-send-email-anshuman.khandual@arm.com>
 <1610975582-12646-5-git-send-email-anshuman.khandual@arm.com>
 <a1644ce0-427f-7a5c-b90a-547e61341a75@arm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <630a8785-222d-26ed-a57a-ac5b58d7a04d@redhat.com>
Date: Tue, 19 Jan 2021 13:27:53 +0100
MIME-Version: 1.0
In-Reply-To: <a1644ce0-427f-7a5c-b90a-547e61341a75@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org, akpm@linux-foundation.org, hca@linux.ibm.com, catalin.marinas@arm.com
Cc: Oscar Salvador <osalvador@suse.de>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Michal Hocko <mhocko@kernel.org>, Wei Yang <richard.weiyang@linux.alibaba.com>, teawater <teawaterz@linux.alibaba.com>, Pankaj Gupta <pankaj.gupta@cloud.ionos.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>

On 18.01.21 14:21, Anshuman Khandual wrote:
> 
> 
> On 1/18/21 6:43 PM, Anshuman Khandual wrote:
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
>> Cc: Michal Hocko <mhocko@kernel.org>
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
> 
> Hello David,
> 
> As your original patch was in the RFC state, I have just maintained
> the same here as well. But once you test this patch along with the
> new series, please do let me know if this needs to be converted to
> a normal PATCH instead. Thank you.

I'll give it a churn on x86-64, where not that much should change. It
will be interesting to test with arm64 in such corner cases in the future.

Thanks

-- 
Thanks,

David / dhildenb
