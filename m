Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FCD3783BB
	for <linux-s390@vger.kernel.org>; Mon, 11 May 2026 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505863; cv=none; b=CNIYcMv6367Ioz/hld5DBAxAOP2iWhWZpnSKw6ujTzoVKTx9TlCIU4ZTjqeDUY5mFiCjsSeOOHLYV/38OmFqusRf/O1IZQhT6RlUpL0SPj8JPXQpxmNRqP05H5poK1S2eFfFQ50Q8JqCQNem79Y7u28nyuVbdnKYaPm4HGWfixM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505863; c=relaxed/simple;
	bh=4Oty7p29C8oNyyH72Iy8dxZZ6HAi9idSJYItIxPswfs=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=WxqJPGsu4exhQhG5xHSl4nytteXCNUFNA7Cs7BX7k4JehB9v083XENF+QTA2E/qG4+caueAnwZ8asPnk3mlpoopHOr3YUT8WzPnJXHmi5zPQGx9E7BS46KwRjtenbj/qRLGr0/lrRofWrkOrNzumgJT1nHJR78BlDqtbXKhAELI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tR6uiK4v; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tR6uiK4v"
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778505849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5z8Lm7PbYzdvsHr44p/Kq/5LGVMLu1AFqGqWWK02nUg=;
	b=tR6uiK4vEp5eioru6Ipra4Az/BhAvo1kWF1fPx6I9XeodPF8HIrBISmioNv7imWa3B6iiI
	/VEPQtEj82FsW6aw7jq/5BB4OkswlViDVjO+jJucIVX6gDAj4r/773nRMQen1GTVH5A6RO
	KhzO5EEzI5sjkIVCHpA+MgQlMRr49rQ=
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] drivers/base/memory: make memory block get/put explicit
Date: Mon, 11 May 2026 21:23:18 +0800
Message-Id: <3234B4D3-8202-4E79-B85B-8B6373BB76F6@linux.dev>
References: <2841f424-580c-48c6-bb26-de30e4397b7f@kernel.org>
Cc: Muchun Song <songmuchun@bytedance.com>,
 Oscar Salvador <osalvador@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, linux-mm@kvack.org,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
In-Reply-To: <2841f424-580c-48c6-bb26-de30e4397b7f@kernel.org>
To: David Hildenbrand <david@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On May 11, 2026, at 20:22, David Hildenbrand (Arm) <david@kernel.org> wrot=
e:
>=20
> =EF=BB=BFOn 5/11/26 13:18, Muchun Song wrote:
>> Rename the memory block lookup helper to make the acquired reference
>> explicit, add memory_block_put() to wrap put_device(), and collapse the
>> redundant section-number wrapper into a single block-id based lookup
>> interface.
>>=20
>> This makes it clearer to callers that a successful lookup holds a
>> reference that must be dropped, reducing the chance of forgetting the
>> matching put and leaking the memory block device reference.
>=20
> Better mention some of the other changes here, like removing find_memory_b=
lock().

Will do.

>=20
> [...]
>=20
>>    unlock_device_hotplug();
>> diff --git a/include/linux/memory.h b/include/linux/memory.h
>> index 5bb5599c6b2b..29edef1f975c 100644
>> --- a/include/linux/memory.h
>> +++ b/include/linux/memory.h
>> @@ -158,7 +158,11 @@ int create_memory_block_devices(unsigned long start,=
 unsigned long size,
>> void remove_memory_block_devices(unsigned long start, unsigned long size)=
;
>> extern void memory_dev_init(void);
>> extern int memory_notify(enum memory_block_state state, void *v);
>> -extern struct memory_block *find_memory_block(unsigned long section_nr);=

>> +extern struct memory_block *memory_block_get(unsigned long block_id);
>=20
> While at it, please drop the "extern".

OK.

>=20
>> +static inline void memory_block_put(struct memory_block *mem)
>> +{
>> +    put_device(&mem->dev);
>> +}
>> typedef int (*walk_memory_blocks_func_t)(struct memory_block *, void *);
>> extern int walk_memory_blocks(unsigned long start, unsigned long size,
>>                  void *arg, walk_memory_blocks_func_t func);
>> @@ -171,7 +175,6 @@ struct memory_group *memory_group_find_by_id(int mgid=
);
>> typedef int (*walk_memory_groups_func_t)(struct memory_group *, void *);
>> int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
>>                   struct memory_group *excluded, void *arg);
>> -struct memory_block *find_memory_block_by_id(unsigned long block_id);
>> #define hotplug_memory_notifier(fn, pri) ({        \
>>    static __meminitdata struct notifier_block fn##_mem_nb =3D\
>>        { .notifier_call =3D fn, .priority =3D pri };\
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 462d8dcd636d..890c6453e887 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1417,14 +1417,13 @@ static void remove_memory_blocks_and_altmaps(u64 s=
tart, u64 size)
>>        struct vmem_altmap *altmap =3D NULL;
>>        struct memory_block *mem;
>>=20
>> -        mem =3D find_memory_block(pfn_to_section_nr(PFN_DOWN(cur_start))=
);
>> +        mem =3D memory_block_get(phys_to_block_id(cur_start));
>>        if (WARN_ON_ONCE(!mem))
>>            continue;
>>=20
>>        altmap =3D mem->altmap;
>>        mem->altmap =3D NULL;
>> -        /* drop the ref. we got via find_memory_block() */
>> -        put_device(&mem->dev);
>> +        memory_block_put(mem);
>=20
> Would guards come in handy here?

You mean to introduce something like:

scoped_guard(memory_block, id) {
}

Right? If yes, I will give it a try.

>=20
> In general
>=20
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks.

Muchun

>=20
> --
> Cheers,
>=20
> David
