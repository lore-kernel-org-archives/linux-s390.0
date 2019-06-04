Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v3 05/11] drivers/base/memory: Pass a block_id to
 init_memory_block()
References: <20190527111152.16324-1-david@redhat.com>
 <20190527111152.16324-6-david@redhat.com>
 <20190603214932.3xsvxwiiutcve4tz@master>
From: David Hildenbrand <david@redhat.com>
Message-ID: <cd708cec-f369-4176-16c9-93a3c8ab6947@redhat.com>
Date: Tue, 4 Jun 2019 08:56:40 +0200
MIME-Version: 1.0
In-Reply-To: <20190603214932.3xsvxwiiutcve4tz@master>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Dan Williams <dan.j.williams@intel.com>, Igor Mammedov <imammedo@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>

On 03.06.19 23:49, Wei Yang wrote:
> On Mon, May 27, 2019 at 01:11:46PM +0200, David Hildenbrand wrote:
>> We'll rework hotplug_memory_register() shortly, so it no longer consumes
>> pass a section.
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>> drivers/base/memory.c | 15 +++++++--------
>> 1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>> index f180427e48f4..f914fa6fe350 100644
>> --- a/drivers/base/memory.c
>> +++ b/drivers/base/memory.c
>> @@ -651,21 +651,18 @@ int register_memory(struct memory_block *memory)
>> 	return ret;
>> }
>>
>> -static int init_memory_block(struct memory_block **memory,
>> -			     struct mem_section *section, unsigned long state)
>> +static int init_memory_block(struct memory_block **memory, int block_id,
>> +			     unsigned long state)
>> {
>> 	struct memory_block *mem;
>> 	unsigned long start_pfn;
>> -	int scn_nr;
>> 	int ret = 0;
>>
>> 	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
>> 	if (!mem)
>> 		return -ENOMEM;
>>
>> -	scn_nr = __section_nr(section);
>> -	mem->start_section_nr =
>> -			base_memory_block_id(scn_nr) * sections_per_block;
>> +	mem->start_section_nr = block_id * sections_per_block;
>> 	mem->end_section_nr = mem->start_section_nr + sections_per_block - 1;
>> 	mem->state = state;
>> 	start_pfn = section_nr_to_pfn(mem->start_section_nr);
>> @@ -694,7 +691,8 @@ static int add_memory_block(int base_section_nr)
>>
>> 	if (section_count == 0)
>> 		return 0;
>> -	ret = init_memory_block(&mem, __nr_to_section(section_nr), MEM_ONLINE);
>> +	ret = init_memory_block(&mem, base_memory_block_id(base_section_nr),
>> +				MEM_ONLINE);
> 
> If my understanding is correct, section_nr could be removed too.

Yes you are, this has already been addressed in linux-next.


-- 

Thanks,

David / dhildenb
