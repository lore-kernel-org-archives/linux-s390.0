Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A413148D0;
	Tue, 12 May 2026 06:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778568880; cv=none; b=QRpRYtvaJlnmXs5jog4SPyp7+Wh7lRvnGWfRbfAspeTqhRrT5gsYPBAlBG9SnE3dv++7qhCKAQplPmAprkiOuegtqwEMDUHwrZ/6/v3eK78bAm4rGwgLIkjPGtpKmKiXebWweicYnUnG0srWsOFawpXrXOteHoaZ33vm13go460=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778568880; c=relaxed/simple;
	bh=hSRNnVvjy42ucTL9yDNc9f+MiLC49s8FoJCJcX9mH2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLB8EM9RQGi6LA3l9s1XpPh1EwTmn03RpxJkbR3Wzx/lgbrGdtmG9vSMIDyGITooKLJLMt/Rfdt5pBayAbtoq9nifim/zOb7IMQvnmzKDDHzDwSUq+xsjLOR4altDtUHX9hDNdyZtTEfRYBA5JVNdFRc7134oBV7Z6n3tfTdQ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=idBAtUjK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="idBAtUjK"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK71hk3186917;
	Tue, 12 May 2026 06:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=z8usfq
	o9ZjJvq3jCjiATXiyRq9FwkYThylveTQxP7xU=; b=idBAtUjK87nQIqhxp+mR93
	toYfFRwiCplGnCPzgQjH0OfRbw4LUmTaQJh0QsBN+bZQRstGw4lmkIIki6EPYSOg
	yHkpLP2EvJxEb/CXXGFyLKcaPGCI6SH8jdQN33FhswioIq9YS+rBZKModMM4jokb
	FhS7+PN8/pX64O4iGWjWRBmhVI+3t/X8nj0Lx/ZxSRkEw/2kBDBxOuqPNcim8X51
	9kKaKtiE3xcLetwbTOTqdlYf4NB49fQe/EcDWTF4tSFrlOyzfK3IGLS8JNDvUwKe
	+DXMdAFi7wS7tx5zp3mAULIABQx0NCOX5XtRWAnRJa0BVqg5YRL6hB9Q5K3oCXAw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv59tv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 06:53:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64C6dKxq015426;
	Tue, 12 May 2026 06:53:07 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgj10c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 06:53:07 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64C6r69V58851702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 06:53:06 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D0DB58053;
	Tue, 12 May 2026 06:53:06 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EB2E58043;
	Tue, 12 May 2026 06:52:57 +0000 (GMT)
Received: from [9.123.6.34] (unknown [9.123.6.34])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 06:52:56 +0000 (GMT)
Message-ID: <943c5cd9-0796-45f5-9f8d-cb7e44457961@linux.ibm.com>
Date: Tue, 12 May 2026 12:22:55 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/base/memory: make memory block get/put explicit
To: Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-mm@kvack.org,
        driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        muchun.song@linux.dev
References: <20260511111800.2181785-1-songmuchun@bytedance.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20260511111800.2181785-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=cPHQdFeN c=1 sm=1 tr=0 ts=6a02ce55 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=968KyxNXAAAA:8 a=VnNF1IyMAAAA:8 a=celaVYaThZoO3EmEkQQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3iXNAsZwJoh2-sRW5JrH5NVNDGiEvKfW
X-Proofpoint-GUID: 9-jgzV9kmWIieloOmYHSmmkqUMDM_L1h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA2MyBTYWx0ZWRfX6QWOWos8A3ve
 yaW+QAsAFoV0hzBslnPAGPSeVL6eU8SzDYftGBeUKOx7QDzmAy2et8+mLvYh1gXbmySUXYjsHXn
 QDafr0DriHgltGnffCMNhXa0hM+Vt4eIJ8tLFt+OKfysQ1AOTYIQ68xAcJHZFsECeN4x6zh/mET
 U1x2SwzpIwBzX0DPKtZrSBbiJk9fwwAV1LvzrMLCfzF0asgf4HQoWzoD5AqlczGN6QOJOzsyTAi
 otzDzyHftRkMB0SbIsax97vPwIlPl/HbwvJRih44vvO7vgaAH4jNKA1IPigtMmdrTMd+o7R5GYV
 Ot1WvkgdeVC1+waMINGAjft00XDW7NGd491lqxzILsKqTwAxa0rSTSOGElk0G1Hmw1bW3WPrEL9
 /7WroWUFk1CfSA/oF/uDLyie0+0VCXFxC9/lvawCFlvKS3iGuVsmn2wzBKvd3LQXd+YxyR6c/65
 4XtbCooWpUgXv+noiOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1011 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120063

On 5/11/26 4:48 PM, Muchun Song wrote:

> Rename the memory block lookup helper to make the acquired reference
> explicit, add memory_block_put() to wrap put_device(), and collapse the
> redundant section-number wrapper into a single block-id based lookup
> interface.
>
> This makes it clearer to callers that a successful lookup holds a
> reference that must be dropped, reducing the chance of forgetting the
> matching put and leaking the memory block device reference.
>
> Link: https://lore.kernel.org/linux-mm/7887915D-E598-42B3-9AFE-BFFBACE8DE2D@linux.dev/#t
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   .../platforms/pseries/hotplug-memory.c        | 14 ++-----
>   drivers/base/memory.c                         | 38 +++++++------------
>   drivers/base/node.c                           |  4 +-
>   drivers/s390/char/sclp_mem.c                  | 17 ++++-----
>   include/linux/memory.h                        |  7 +++-
>   mm/memory_hotplug.c                           |  5 +--
>   6 files changed, 35 insertions(+), 50 deletions(-)



Hi

I did some basic DLPAR memory add/remove tests on PowerPC with this 
patch, and it is working fine.

Initial memory
==============
[]# cat /proc/meminfo |grep -i MemTotal
MemTotal:       205169920 kB

After Add
=========
[]# cat /proc/meminfo |grep -i MemTotal
MemTotal:       247112960 kB

After Remove
============
[]# cat /proc/meminfo |grep -i MemTotal
MemTotal:       173729024 kB
[]#

Tested-by: Donet Tom <donettom@linux.ibm.com>


> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 75f85a5da981..94f3b57054b6 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -164,13 +164,7 @@ static int update_lmb_associativity_index(struct drmem_lmb *lmb)
>   
>   static struct memory_block *lmb_to_memblock(struct drmem_lmb *lmb)
>   {
> -	unsigned long section_nr;
> -	struct memory_block *mem_block;
> -
> -	section_nr = pfn_to_section_nr(PFN_DOWN(lmb->base_addr));
> -
> -	mem_block = find_memory_block(section_nr);
> -	return mem_block;
> +	return memory_block_get(phys_to_block_id(lmb->base_addr));
>   }
>   
>   static int get_lmb_range(u32 drc_index, int n_lmbs,
> @@ -220,7 +214,7 @@ static int dlpar_change_lmb_state(struct drmem_lmb *lmb, bool online)
>   	else
>   		rc = 0;
>   
> -	put_device(&mem_block->dev);
> +	memory_block_put(mem_block);
>   
>   	return rc;
>   }
> @@ -319,12 +313,12 @@ static int dlpar_remove_lmb(struct drmem_lmb *lmb)
>   
>   	rc = dlpar_offline_lmb(lmb);
>   	if (rc) {
> -		put_device(&mem_block->dev);
> +		memory_block_put(mem_block);
>   		return rc;
>   	}
>   
>   	__remove_memory(lmb->base_addr, memory_block_size);
> -	put_device(&mem_block->dev);
> +	memory_block_put(mem_block);
>   
>   	/* Update memory regions for memory remove */
>   	memblock_remove(lmb->base_addr, memory_block_size);
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 11d57cfa8d72..5b5d41089e81 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -649,7 +649,7 @@ int __weak arch_get_memory_phys_device(unsigned long start_pfn)
>    *
>    * Called under device_hotplug_lock.
>    */
> -struct memory_block *find_memory_block_by_id(unsigned long block_id)
> +struct memory_block *memory_block_get(unsigned long block_id)
>   {
>   	struct memory_block *mem;
>   
> @@ -659,16 +659,6 @@ struct memory_block *find_memory_block_by_id(unsigned long block_id)
>   	return mem;
>   }
>   
> -/*
> - * Called under device_hotplug_lock.
> - */
> -struct memory_block *find_memory_block(unsigned long section_nr)
> -{
> -	unsigned long block_id = memory_block_id(section_nr);
> -
> -	return find_memory_block_by_id(block_id);
> -}
> -
>   static struct attribute *memory_memblk_attrs[] = {
>   	&dev_attr_phys_index.attr,
>   	&dev_attr_state.attr,
> @@ -701,7 +691,7 @@ static int __add_memory_block(struct memory_block *memory)
>   
>   	ret = device_register(&memory->dev);
>   	if (ret) {
> -		put_device(&memory->dev);
> +		memory_block_put(memory);
>   		return ret;
>   	}
>   	ret = xa_err(xa_store(&memory_blocks, memory->dev.id, memory,
> @@ -795,9 +785,9 @@ static int add_memory_block(unsigned long block_id, int nid, unsigned long state
>   	struct memory_block *mem;
>   	int ret = 0;
>   
> -	mem = find_memory_block_by_id(block_id);
> +	mem = memory_block_get(block_id);
>   	if (mem) {
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>   		return -EEXIST;
>   	}
>   	mem = kzalloc_obj(*mem);
> @@ -845,8 +835,8 @@ static void remove_memory_block(struct memory_block *memory)
>   		memory->group = NULL;
>   	}
>   
> -	/* drop the ref. we got via find_memory_block() */
> -	put_device(&memory->dev);
> +	/* drop the ref. we got via memory_block_get() */
> +	memory_block_put(memory);
>   	device_unregister(&memory->dev);
>   }
>   
> @@ -880,7 +870,7 @@ int create_memory_block_devices(unsigned long start, unsigned long size,
>   		end_block_id = block_id;
>   		for (block_id = start_block_id; block_id != end_block_id;
>   		     block_id++) {
> -			mem = find_memory_block_by_id(block_id);
> +			mem = memory_block_get(block_id);
>   			if (WARN_ON_ONCE(!mem))
>   				continue;
>   			remove_memory_block(mem);
> @@ -908,7 +898,7 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
>   		return;
>   
>   	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
> -		mem = find_memory_block_by_id(block_id);
> +		mem = memory_block_get(block_id);
>   		if (WARN_ON_ONCE(!mem))
>   			continue;
>   		num_poisoned_pages_sub(-1UL, memblk_nr_poison(mem));
> @@ -1015,12 +1005,12 @@ int walk_memory_blocks(unsigned long start, unsigned long size,
>   		return 0;
>   
>   	for (block_id = start_block_id; block_id <= end_block_id; block_id++) {
> -		mem = find_memory_block_by_id(block_id);
> +		mem = memory_block_get(block_id);
>   		if (!mem)
>   			continue;
>   
>   		ret = func(mem, arg);
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>   		if (ret)
>   			break;
>   	}
> @@ -1228,22 +1218,22 @@ int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
>   void memblk_nr_poison_inc(unsigned long pfn)
>   {
>   	const unsigned long block_id = pfn_to_block_id(pfn);
> -	struct memory_block *mem = find_memory_block_by_id(block_id);
> +	struct memory_block *mem = memory_block_get(block_id);
>   
>   	if (mem) {
>   		atomic_long_inc(&mem->nr_hwpoison);
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>   	}
>   }
>   
>   void memblk_nr_poison_sub(unsigned long pfn, long i)
>   {
>   	const unsigned long block_id = pfn_to_block_id(pfn);
> -	struct memory_block *mem = find_memory_block_by_id(block_id);
> +	struct memory_block *mem = memory_block_get(block_id);
>   
>   	if (mem) {
>   		atomic_long_sub(i, &mem->nr_hwpoison);
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>   	}
>   }
>   
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 126f66aa2c3e..b3333ca92090 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -847,13 +847,13 @@ static void register_memory_blocks_under_nodes(void)
>   		for (block_id = start_block_id; block_id <= end_block_id; block_id++) {
>   			struct memory_block *mem;
>   
> -			mem = find_memory_block_by_id(block_id);
> +			mem = memory_block_get(block_id);
>   			if (!mem)
>   				continue;
>   
>   			memory_block_add_nid_early(mem, nid);
>   			do_register_memory_block_under_node(nid, mem);
> -			put_device(&mem->dev);
> +			memory_block_put(mem);
>   		}
>   
>   	}
> diff --git a/drivers/s390/char/sclp_mem.c b/drivers/s390/char/sclp_mem.c
> index 78c054e26d17..6df1926d4c62 100644
> --- a/drivers/s390/char/sclp_mem.c
> +++ b/drivers/s390/char/sclp_mem.c
> @@ -204,7 +204,7 @@ static ssize_t sclp_config_mem_store(struct kobject *kobj, struct kobj_attribute
>   	addr = sclp_mem->id * block_size;
>   	/*
>   	 * Hold device_hotplug_lock when adding/removing memory blocks.
> -	 * Additionally, also protect calls to find_memory_block() and
> +	 * Additionally, also protect calls to memory_block_get() and
>   	 * sclp_attach_storage().
>   	 */
>   	rc = lock_device_hotplug_sysfs();
> @@ -231,20 +231,19 @@ static ssize_t sclp_config_mem_store(struct kobject *kobj, struct kobj_attribute
>   			sclp_mem_change_state(addr, block_size, 0);
>   			goto out_unlock;
>   		}
> -		mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(addr)));
> -		put_device(&mem->dev);
> +		mem = memory_block_get(phys_to_block_id(addr));
> +		memory_block_put(mem);
>   		WRITE_ONCE(sclp_mem->config, 1);
>   	} else {
>   		if (!sclp_mem->config)
>   			goto out_unlock;
> -		mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(addr)));
> +		mem = memory_block_get(phys_to_block_id(addr));
>   		if (mem->state != MEM_OFFLINE) {
> -			put_device(&mem->dev);
> +			memory_block_put(mem);
>   			rc = -EBUSY;
>   			goto out_unlock;
>   		}
> -		/* drop the ref just got via find_memory_block() */
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>   		sclp_mem_change_state(addr, block_size, 0);
>   		__remove_memory(addr, block_size);
>   #ifdef CONFIG_KASAN
> @@ -294,11 +293,11 @@ static ssize_t sclp_memmap_on_memory_store(struct kobject *kobj, struct kobj_att
>   		return rc;
>   	block_size = memory_block_size_bytes();
>   	sclp_mem = container_of(kobj, struct sclp_mem, kobj);
> -	mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(sclp_mem->id * block_size)));
> +	mem = memory_block_get(phys_to_block_id(sclp_mem->id * block_size));
>   	if (!mem) {
>   		WRITE_ONCE(sclp_mem->memmap_on_memory, value);
>   	} else {
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>   		rc = -EBUSY;
>   	}
>   	unlock_device_hotplug();
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index 5bb5599c6b2b..29edef1f975c 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -158,7 +158,11 @@ int create_memory_block_devices(unsigned long start, unsigned long size,
>   void remove_memory_block_devices(unsigned long start, unsigned long size);
>   extern void memory_dev_init(void);
>   extern int memory_notify(enum memory_block_state state, void *v);
> -extern struct memory_block *find_memory_block(unsigned long section_nr);
> +extern struct memory_block *memory_block_get(unsigned long block_id);
> +static inline void memory_block_put(struct memory_block *mem)
> +{
> +	put_device(&mem->dev);
> +}
>   typedef int (*walk_memory_blocks_func_t)(struct memory_block *, void *);
>   extern int walk_memory_blocks(unsigned long start, unsigned long size,
>   			      void *arg, walk_memory_blocks_func_t func);
> @@ -171,7 +175,6 @@ struct memory_group *memory_group_find_by_id(int mgid);
>   typedef int (*walk_memory_groups_func_t)(struct memory_group *, void *);
>   int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
>   			       struct memory_group *excluded, void *arg);
> -struct memory_block *find_memory_block_by_id(unsigned long block_id);
>   #define hotplug_memory_notifier(fn, pri) ({		\
>   	static __meminitdata struct notifier_block fn##_mem_nb =\
>   		{ .notifier_call = fn, .priority = pri };\
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 462d8dcd636d..890c6453e887 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1417,14 +1417,13 @@ static void remove_memory_blocks_and_altmaps(u64 start, u64 size)
>   		struct vmem_altmap *altmap = NULL;
>   		struct memory_block *mem;
>   
> -		mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(cur_start)));
> +		mem = memory_block_get(phys_to_block_id(cur_start));
>   		if (WARN_ON_ONCE(!mem))
>   			continue;
>   
>   		altmap = mem->altmap;
>   		mem->altmap = NULL;
> -		/* drop the ref. we got via find_memory_block() */
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>   
>   		remove_memory_block_devices(cur_start, memblock_size);
>   
>
> base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
