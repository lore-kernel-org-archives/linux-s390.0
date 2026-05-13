Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816F037F747
	for <linux-s390@vger.kernel.org>; Wed, 13 May 2026 01:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778636560; cv=none; b=E4I3jGQqf6t9V1NLgYet7Y+bqcUmSnUcTpTPYYNABclqTPwHgOTkzBMGSRhSDi+uGDMG8Cssb2VqAGSSlmiEmXjc9mckCq3zpjY69I2r3TRYzdxtueP0twr9QHKjP3M8oWgEXgSzngqsqrlWtRrFQmcuDkHMMy3pne2gsFuBl+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778636560; c=relaxed/simple;
	bh=nfyv1LmuT66aBw8oe9Cw7xXi42xxaAH6r5UJGdnqEs0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZeCTOP1TAvsnj3j/VjCAid5c/UQ8MIt0GyKPxkZ9M7D3v9d8CHWtzsQOG+WG4bni3dvCEbCHqbIonF6adqa+3ocPDa6Fg6s7T6rU++S/dFikuQpxJE02OnjlkWBfpPg0pDRUsFnBsBCCnbB3hzfw+XMUMa/05mmg6nc1g07iPOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G+4UjxhM; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G+4UjxhM"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778636542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fhvTYmzHBJF0Uy2iUIqRc2sMKqrtzRCDZRsnolCJW14=;
	b=G+4UjxhMuR07b1wvtvS6rFSIFCLeBeV0PTrTb930Igb2yqCO6sGi3cGOms8uKKb2mtUcT3
	4uJfSpJciYXosRJ7A1RirFXphlg+tJTVg5sbiTMn94I6cgh7JeQtiYGE5xqL1CzEHZjSdJ
	3hn3WfT3ZwzRVzkfVB2JN1kp7awPMV8=
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v2] drivers/base/memory: make memory block get/put
 explicit
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <agMVtO5QPGYVb48D@MWDK4CY14F>
Date: Wed, 13 May 2026 09:41:23 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-mm@kvack.org,
 driver-core@lists.linux.dev,
 Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Danilo Krummrich <dakr@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Sumanth Korikkar <sumanthk@linux.ibm.com>,
 Kees Cook <kees@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Donet Tom <donettom@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3EE08C93-F28D-4363-AC1C-C9B99F8ABB7C@linux.dev>
References: <20260512072635.3969576-1-songmuchun@bytedance.com>
 <agMVtO5QPGYVb48D@MWDK4CY14F>
To: Richard Cheng <icheng@nvidia.com>
X-Migadu-Flow: FLOW_OUT



> On May 12, 2026, at 20:03, Richard Cheng <icheng@nvidia.com> wrote:
>=20
> On Tue, May 12, 2026 at 03:26:35PM +0800, Muchun Song wrote:
>> Rename the memory block lookup helper to make the acquired reference
>> explicit, add memory_block_put() to wrap put_device(), remove
>> find_memory_block(), and use memory_block_get() as the single =
block-id
>> based lookup interface.
>>=20
>> This makes it clearer to callers that a successful lookup holds a
>> reference that must be dropped, reducing the chance of forgetting the
>> matching put and leaking the memory block device reference.
>>=20
>> Link: =
https://lore.kernel.org/linux-mm/7887915D-E598-42B3-9AFE-BFFBACE8DE2D@linu=
x.dev/#t
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Acked-by: Oscar Salvador <osalvador@suse.de>
>> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>> Acked-by: Michal Hocko <mhocko@suse.com>
>> Tested-by: Donet Tom <donettom@linux.ibm.com>
>> Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
>> ---
>> Changes in v2:
>> - mention the removal of find_memory_block() in the commit message
>> - drop the redundant extern from the memory_block_get() declaration
>> ---
>> .../platforms/pseries/hotplug-memory.c        | 14 ++-----
>> drivers/base/memory.c                         | 38 =
+++++++------------
>> drivers/base/node.c                           |  4 +-
>> drivers/s390/char/sclp_mem.c                  | 17 ++++-----
>> include/linux/memory.h                        |  7 +++-
>> mm/memory_hotplug.c                           |  5 +--
>> 6 files changed, 35 insertions(+), 50 deletions(-)
>>=20
>> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c =
b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> index 75f85a5da981..94f3b57054b6 100644
>> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
>> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> @@ -164,13 +164,7 @@ static int update_lmb_associativity_index(struct =
drmem_lmb *lmb)
>>=20
>> static struct memory_block *lmb_to_memblock(struct drmem_lmb *lmb)
>> {
>> - unsigned long section_nr;
>> - struct memory_block *mem_block;
>> -
>> - section_nr =3D pfn_to_section_nr(PFN_DOWN(lmb->base_addr));
>> -
>> - mem_block =3D find_memory_block(section_nr);
>> - return mem_block;
>> + return memory_block_get(phys_to_block_id(lmb->base_addr));
>> }
>>=20
>> static int get_lmb_range(u32 drc_index, int n_lmbs,
>> @@ -220,7 +214,7 @@ static int dlpar_change_lmb_state(struct =
drmem_lmb *lmb, bool online)
>> else
>> rc =3D 0;
>>=20
>> - put_device(&mem_block->dev);
>> + memory_block_put(mem_block);
>>=20
>> return rc;
>> }
>> @@ -319,12 +313,12 @@ static int dlpar_remove_lmb(struct drmem_lmb =
*lmb)
>>=20
>> rc =3D dlpar_offline_lmb(lmb);
>> if (rc) {
>> - put_device(&mem_block->dev);
>> + memory_block_put(mem_block);
>> return rc;
>> }
>>=20
>> __remove_memory(lmb->base_addr, memory_block_size);
>> - put_device(&mem_block->dev);
>> + memory_block_put(mem_block);
>>=20
>> /* Update memory regions for memory remove */
>> memblock_remove(lmb->base_addr, memory_block_size);
>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>> index 11d57cfa8d72..5b5d41089e81 100644
>> --- a/drivers/base/memory.c
>> +++ b/drivers/base/memory.c
>> @@ -649,7 +649,7 @@ int __weak arch_get_memory_phys_device(unsigned =
long start_pfn)
>>  *
>>  * Called under device_hotplug_lock.
>>  */
>> -struct memory_block *find_memory_block_by_id(unsigned long block_id)
>> +struct memory_block *memory_block_get(unsigned long block_id)
>> {
>> struct memory_block *mem;
>>=20
>> @@ -659,16 +659,6 @@ struct memory_block =
*find_memory_block_by_id(unsigned long block_id)
>> return mem;
>> }
>>=20
>> -/*
>> - * Called under device_hotplug_lock.
>> - */
>> -struct memory_block *find_memory_block(unsigned long section_nr)
>> -{
>> - unsigned long block_id =3D memory_block_id(section_nr);
>> -
>> - return find_memory_block_by_id(block_id);
>> -}
>> -
>> static struct attribute *memory_memblk_attrs[] =3D {
>> &dev_attr_phys_index.attr,
>> &dev_attr_state.attr,
>> @@ -701,7 +691,7 @@ static int __add_memory_block(struct memory_block =
*memory)
>>=20
>> ret =3D device_register(&memory->dev);
>> if (ret) {
>> - put_device(&memory->dev);
>> + memory_block_put(memory);
>> return ret;
>> }
>> ret =3D xa_err(xa_store(&memory_blocks, memory->dev.id, memory,
>> @@ -795,9 +785,9 @@ static int add_memory_block(unsigned long =
block_id, int nid, unsigned long state
>> struct memory_block *mem;
>> int ret =3D 0;
>>=20
>> - mem =3D find_memory_block_by_id(block_id);
>> + mem =3D memory_block_get(block_id);
>> if (mem) {
>> - put_device(&mem->dev);
>> + memory_block_put(mem);
>> return -EEXIST;
>> }
>> mem =3D kzalloc_obj(*mem);
>> @@ -845,8 +835,8 @@ static void remove_memory_block(struct =
memory_block *memory)
>> memory->group =3D NULL;
>> }
>>=20
>> - /* drop the ref. we got via find_memory_block() */
>> - put_device(&memory->dev);
>> + /* drop the ref. we got via memory_block_get() */
>> + memory_block_put(memory);
>> device_unregister(&memory->dev);
>> }
>>=20
>> @@ -880,7 +870,7 @@ int create_memory_block_devices(unsigned long =
start, unsigned long size,
>> end_block_id =3D block_id;
>> for (block_id =3D start_block_id; block_id !=3D end_block_id;
>>      block_id++) {
>> - mem =3D find_memory_block_by_id(block_id);
>> + mem =3D memory_block_get(block_id);
>> if (WARN_ON_ONCE(!mem))
>> continue;
>> remove_memory_block(mem);
>> @@ -908,7 +898,7 @@ void remove_memory_block_devices(unsigned long =
start, unsigned long size)
>> return;
>>=20
>> for (block_id =3D start_block_id; block_id !=3D end_block_id; =
block_id++) {
>> - mem =3D find_memory_block_by_id(block_id);
>> + mem =3D memory_block_get(block_id);
>> if (WARN_ON_ONCE(!mem))
>> continue;
>> num_poisoned_pages_sub(-1UL, memblk_nr_poison(mem));
>> @@ -1015,12 +1005,12 @@ int walk_memory_blocks(unsigned long start, =
unsigned long size,
>> return 0;
>>=20
>> for (block_id =3D start_block_id; block_id <=3D end_block_id; =
block_id++) {
>> - mem =3D find_memory_block_by_id(block_id);
>> + mem =3D memory_block_get(block_id);
>> if (!mem)
>> continue;
>>=20
>> ret =3D func(mem, arg);
>> - put_device(&mem->dev);
>> + memory_block_put(mem);
>> if (ret)
>> break;
>> }
>> @@ -1228,22 +1218,22 @@ int walk_dynamic_memory_groups(int nid, =
walk_memory_groups_func_t func,
>> void memblk_nr_poison_inc(unsigned long pfn)
>> {
>> const unsigned long block_id =3D pfn_to_block_id(pfn);
>> - struct memory_block *mem =3D find_memory_block_by_id(block_id);
>> + struct memory_block *mem =3D memory_block_get(block_id);
>>=20
>> if (mem) {
>> atomic_long_inc(&mem->nr_hwpoison);
>> - put_device(&mem->dev);
>> + memory_block_put(mem);
>> }
>> }
>>=20
>> void memblk_nr_poison_sub(unsigned long pfn, long i)
>> {
>> const unsigned long block_id =3D pfn_to_block_id(pfn);
>> - struct memory_block *mem =3D find_memory_block_by_id(block_id);
>> + struct memory_block *mem =3D memory_block_get(block_id);
>>=20
>> if (mem) {
>> atomic_long_sub(i, &mem->nr_hwpoison);
>> - put_device(&mem->dev);
>> + memory_block_put(mem);
>> }
>> }
>>=20
>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>> index 126f66aa2c3e..b3333ca92090 100644
>> --- a/drivers/base/node.c
>> +++ b/drivers/base/node.c
>> @@ -847,13 +847,13 @@ static void =
register_memory_blocks_under_nodes(void)
>> for (block_id =3D start_block_id; block_id <=3D end_block_id; =
block_id++) {
>> struct memory_block *mem;
>>=20
>> - mem =3D find_memory_block_by_id(block_id);
>> + mem =3D memory_block_get(block_id);
>> if (!mem)
>> continue;
>>=20
>> memory_block_add_nid_early(mem, nid);
>> do_register_memory_block_under_node(nid, mem);
>> - put_device(&mem->dev);
>> + memory_block_put(mem);
>> }
>>=20
>> }
>> diff --git a/drivers/s390/char/sclp_mem.c =
b/drivers/s390/char/sclp_mem.c
>> index 78c054e26d17..6df1926d4c62 100644
>> --- a/drivers/s390/char/sclp_mem.c
>> +++ b/drivers/s390/char/sclp_mem.c
>> @@ -204,7 +204,7 @@ static ssize_t sclp_config_mem_store(struct =
kobject *kobj, struct kobj_attribute
>> addr =3D sclp_mem->id * block_size;
>> /*
>>  * Hold device_hotplug_lock when adding/removing memory blocks.
>> -  * Additionally, also protect calls to find_memory_block() and
>> +  * Additionally, also protect calls to memory_block_get() and
>>  * sclp_attach_storage().
>>  */
>> rc =3D lock_device_hotplug_sysfs();
>> @@ -231,20 +231,19 @@ static ssize_t sclp_config_mem_store(struct =
kobject *kobj, struct kobj_attribute
>> sclp_mem_change_state(addr, block_size, 0);
>> goto out_unlock;
>> }
>> - mem =3D find_memory_block(pfn_to_section_nr(PFN_DOWN(addr)));
>> - put_device(&mem->dev);
>> + mem =3D memory_block_get(phys_to_block_id(addr));
>> + memory_block_put(mem);
>> WRITE_ONCE(sclp_mem->config, 1);
>> } else {
>> if (!sclp_mem->config)
>> goto out_unlock;
>> - mem =3D find_memory_block(pfn_to_section_nr(PFN_DOWN(addr)));
>> + mem =3D memory_block_get(phys_to_block_id(addr));
>> if (mem->state !=3D MEM_OFFLINE) {
>> - put_device(&mem->dev);
>> + memory_block_put(mem);
>> rc =3D -EBUSY;
>> goto out_unlock;
>> }
>> - /* drop the ref just got via find_memory_block() */
>> - put_device(&mem->dev);
>> + memory_block_put(mem);
>> sclp_mem_change_state(addr, block_size, 0);
>> __remove_memory(addr, block_size);
>> #ifdef CONFIG_KASAN
>> @@ -294,11 +293,11 @@ static ssize_t =
sclp_memmap_on_memory_store(struct kobject *kobj, struct kobj_att
>> return rc;
>> block_size =3D memory_block_size_bytes();
>> sclp_mem =3D container_of(kobj, struct sclp_mem, kobj);
>> - mem =3D find_memory_block(pfn_to_section_nr(PFN_DOWN(sclp_mem->id * =
block_size)));
>> + mem =3D memory_block_get(phys_to_block_id(sclp_mem->id * =
block_size));
>> if (!mem) {
>> WRITE_ONCE(sclp_mem->memmap_on_memory, value);
>> } else {
>> - put_device(&mem->dev);
>> + memory_block_put(mem);
>> rc =3D -EBUSY;
>> }
>> unlock_device_hotplug();
>> diff --git a/include/linux/memory.h b/include/linux/memory.h
>> index 5bb5599c6b2b..463dc02f6cff 100644
>> --- a/include/linux/memory.h
>> +++ b/include/linux/memory.h
>> @@ -158,7 +158,11 @@ int create_memory_block_devices(unsigned long =
start, unsigned long size,
>> void remove_memory_block_devices(unsigned long start, unsigned long =
size);
>> extern void memory_dev_init(void);
>> extern int memory_notify(enum memory_block_state state, void *v);
>> -extern struct memory_block *find_memory_block(unsigned long =
section_nr);
>> +struct memory_block *memory_block_get(unsigned long block_id);
>> +static inline void memory_block_put(struct memory_block *mem)
>> +{
>> + put_device(&mem->dev);
>> +}
>=20
> Hi Muchun,

Hi,

>=20
> Thanks for the work, I have a small suggestion if that fits your =
thought.
>=20
> I think we should at least add a comment  above memory_block_put() to =
remind the caller to check
> for the availabitliy of "mem" before calling this function.
> We perform the check in memory_block_get() inside the function body, I =
see different usage pattern
> across the caller when they're dealing with "mem =3D=3D NULL" and =
avoid to call memory_block_put(),=20
> I can understand we should leverage the check to caller, not inside =
memory_block_put().
> But just in case the next caller might forgot to do the check or think =
the behavior might be symmetric
> bettween memory_block_get() and memory_block_put(), a comment above =
the function would be nice.

Thanks for the suggestion!

Regarding the additional comment, I feel they might not be strictly =
necessary.
If a user passes a NULL pointer, the issue would be exposed immediately
before memory_block_put() is even called. It's unlikely a user would =
obtain
mem and not perform any read/write operations; any such attempt would =
trigger
a NULL pointer dereference right away.

As for adding comments to memory_block_get(), I=E2=80=99m wondering if =
it=E2=80=99s truly
essential. The function is quite straightforward=E2=80=94anyone looking =
at the
definition would see the implementation alongside the comments. It=E2=80=99=
s very
clear from the code that mem must be non-NULL to be "gotten."

Overall, I=E2=80=99m concerned the extra comments might not add much =
value. What do
you think?

Thanks,
Muchun
>=20
> Best regards,
> Richard Cheng.
>=20
>> typedef int (*walk_memory_blocks_func_t)(struct memory_block *, void =
*);
>> extern int walk_memory_blocks(unsigned long start, unsigned long =
size,
>>       void *arg, walk_memory_blocks_func_t func);
>> @@ -171,7 +175,6 @@ struct memory_group *memory_group_find_by_id(int =
mgid);
>> typedef int (*walk_memory_groups_func_t)(struct memory_group *, void =
*);
>> int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t =
func,
>>        struct memory_group *excluded, void *arg);
>> -struct memory_block *find_memory_block_by_id(unsigned long =
block_id);
>> #define hotplug_memory_notifier(fn, pri) ({ \
>> static __meminitdata struct notifier_block fn##_mem_nb =3D\
>> { .notifier_call =3D fn, .priority =3D pri };\
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 462d8dcd636d..890c6453e887 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1417,14 +1417,13 @@ static void =
remove_memory_blocks_and_altmaps(u64 start, u64 size)
>> struct vmem_altmap *altmap =3D NULL;
>> struct memory_block *mem;
>>=20
>> - mem =3D find_memory_block(pfn_to_section_nr(PFN_DOWN(cur_start)));
>> + mem =3D memory_block_get(phys_to_block_id(cur_start));
>> if (WARN_ON_ONCE(!mem))
>> continue;
>>=20
>> altmap =3D mem->altmap;
>> mem->altmap =3D NULL;
>> - /* drop the ref. we got via find_memory_block() */
>> - put_device(&mem->dev);
>> + memory_block_put(mem);
>>=20
>> remove_memory_block_devices(cur_start, memblock_size);
>>=20
>>=20
>> base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
>> --=20
>> 2.54.0


