Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B78F2DC771
	for <linux-s390@vger.kernel.org>; Thu, 11 Sep 2025 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757616648; cv=none; b=P9GNjrjXcK2uFlGLGDzw+bmDTC65CWYLHL38WuiUc4JLNvSZiPyKXkxB5+c8YB79SDzCOmUVq53MD3REGxNLX/vXbyLSXeH/nnbUVco0ktCq+ty7m/IsVShjgZJik4A6fT94wUDg31gk45SLbf8Lfn9qLAQC/iakBsgIEAitj5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757616648; c=relaxed/simple;
	bh=+4RbtZTOyuNjjlNpsnFqJqnxrccT9uu2mRYiQjqba98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UlUcND9J+3JQjYTMqT2t1pczEXEhJQdKAC334Nd5I1IWRwALyePLVa5nM4JgybbTPv7SFIcH4Y6TPqmLm6cLQgTNC4Q44NT0jrbAO69Pj0ELPmly+LD0HCYrh6v8Aju4Xm4/BirWhiFGtxN3dHug5cRlpcwjCbh0VHBqQtdJtks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPCHQTCA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPCHQTCA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757616645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=75rXashiaKSypPE7yXVIqcKrMNGsZ586vqRO26aajTA=;
	b=UPCHQTCALxcOwwNGaFS/lpmEOkR2j5Ol745YVNvZMeoUeySzrWD7j6qn31vOlD323OTXUW
	WJd3cgeZ35opT3K8rzNNkspls4O0NwaFStqWlKfygjQgzcCMH6JrD9g2G9c212PnErJ3KM
	yDLHPo8cn7XPaAMDkHqG3VRlEbl/SLE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-rfZWdusGOeeDQ6VHGBjjqQ-1; Thu, 11 Sep 2025 14:50:44 -0400
X-MC-Unique: rfZWdusGOeeDQ6VHGBjjqQ-1
X-Mimecast-MFC-AGG-ID: rfZWdusGOeeDQ6VHGBjjqQ_1757616643
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3e68a54dac2so496678f8f.1
        for <linux-s390@vger.kernel.org>; Thu, 11 Sep 2025 11:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757616643; x=1758221443;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=75rXashiaKSypPE7yXVIqcKrMNGsZ586vqRO26aajTA=;
        b=J2i0cppIUb4lahrecksL+TEXhA6FW9b9vZFSMA9FaWBlRHa9KSvowLBwJobWVPXEfL
         VRxWKc4pj1b53/bb5xrVdA4P7yDOLzYgcwpXqPujiEoiZjDr0L7i46ud1G9ewQKvo/pa
         YwhrpviVZutChulJnhUcZuo/zm2U71v97C+ljlIv30DU+3aMVf28ouH020VjTFaRWRnW
         fE70ajREQMHiOMBPY/I4UOpG1FhkQAqm7GGGh3/lXHKymbWfLxtkm5PO0sULttIvv5VC
         uFWiWPIvxZPtmUWrYt6c5+0DVPbFoud/cjnMOPelA/SO5/IKmqbi2FPqz+y2MTB5Drse
         MO3Q==
X-Gm-Message-State: AOJu0YzkRmecnl9jpPHUUyvvlYVV+zcJy5KzpNdCjBh1DEtjQgIzFR3F
	PGjOAbcOdQSKuNgTrRKuqXcxGwVIrTz3E6wfAZ8dZQ06fb88iIp24NXB+Ro2b02rcAC7/PE8Rn/
	SYdKvpkkqmHj2lBCTcsNC5A5tq5EeOeRbhQ3atA/RhhskFhEnTXOKMH8xwzCeb0o=
X-Gm-Gg: ASbGncvP/s7j5LdXlypPVl3b+aeWLZ8O/QLOWATyZNRe2iomGttTvdEHayHOWnWvM+Y
	1r3iSW31Ljy5vfU1S0x5n3E56h9HT8iw6UV9Jr/avMEsWo8NCim6zMSZlmpBhu+UM+DagxwNkYW
	cGTUFPQZPVp5Bd9PxJWlNBxm78yiIvefYiTIHcxnRjhAAeAA/XOB7aKTCaGSYTZ3DTcWMcoENzI
	MT3nX1ghIUcN0yOgD5ucCndvNF1EZDJOtMRihry8faQ4akJ8JpyYkrJcKOyWLWrXuJONERmbsvn
	ZV+qazRDwI3Qb/1BU+0EfThojhliErxwrLRkzSgJDYjaZlgUKA5fZ1zXf4Abp7nwfb6Dpc9yA3d
	+/WAZdmygktJMVqlMmQXX8MGwxT/35M2pMQqpS7xowZZIIfEl9HLX2A8TSfhvjYYabXA=
X-Received: by 2002:a5d:64e9:0:b0:3e2:3717:cce5 with SMTP id ffacd0b85a97d-3e75e16b341mr3701780f8f.30.1757616642968;
        Thu, 11 Sep 2025 11:50:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIa5vhuiI1ykuJSwXQKeFBJi+2181WGO35nRF69Fl/mSTSWBEjbLZZ8kV1vJ8X+ThIJ6dl3Q==
X-Received: by 2002:a5d:64e9:0:b0:3e2:3717:cce5 with SMTP id ffacd0b85a97d-3e75e16b341mr3701754f8f.30.1757616642485;
        Thu, 11 Sep 2025 11:50:42 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f42:b000:db8b:7655:f60f:812b? (p200300d82f42b000db8b7655f60f812b.dip0.t-ipconnect.de. [2003:d8:2f42:b000:db8b:7655:f60f:812b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607ccf93sm3506371f8f.38.2025.09.11.11.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 11:50:41 -0700 (PDT)
Message-ID: <0ab2cb14-ba8e-4436-b03d-9457137f492a@redhat.com>
Date: Thu, 11 Sep 2025 20:50:40 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] resource: Improve child resource handling in
 release_mem_region_adjustable()
To: Sumanth Korikkar <sumanthk@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>
Cc: linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20250911140004.2241566-1-sumanthk@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250911140004.2241566-1-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.09.25 16:00, Sumanth Korikkar wrote:

Hi,

> When memory block is removed via try_remove_memory(), it eventually
> reaches release_mem_region_adjustable(). The current implementation
> assumes that when a busy memory resource is split into two, all child
> resources remain in the lower address range.
> 
> This simplification causes problems when child resources actually belong
> to the upper split. For example:
> 
> * Initial memory layout:
> lsmem
> RANGE                                 SIZE   STATE REMOVABLE  BLOCK
> 0x0000000000000000-0x00000002ffffffff  12G  online       yes   0-95
> 
> * /proc/iomem
> 00000000-2dfefffff : System RAM
>    158834000-1597b3fff : Kernel code
>    1597b4000-159f50fff : Kernel data
>    15a13c000-15a218fff : Kernel bss
> 2dff00000-2ffefffff : Crash kernel
> 2fff00000-2ffffffff : System RAM
> 
> * After offlining and removing range
>    0x150000000-0x157ffffff
> lsmem
> RANGE                                  SIZE   STATE REMOVABLE  BLOCK
> 0x0000000000000000-0x000000014fffffff  5.3G  online       yes   0-41
> 0x0000000150000000-0x0000000157ffffff  128M offline               42
> 0x0000000158000000-0x00000002ffffffff  6.6G  online       yes  43-95
> 

First of all

1) How are you triggering this :)

2) Why do you say "and removing the range" when it's still listed in 
lsmem output.

lsmem will only list present memory block devices. So if it's still 
listed there, nothing was removed. Or is that prior to actually removing it.


Is this some powerpc dlpar use case?

> The iomem resource gets split into two entries, but kernel code, kernel
> data, and kernel bss remain attached to the lower resource [0–5376M]
> instead of the correct upper resource [5504M–12288M].

Yes.

> 
> As a result, WARN_ON() triggers in release_mem_region_adjustable()
> ("Usecase: split into two entries - we need a new resource")
> ------------[ cut here ]------------
> WARNING: CPU: 5 PID: 858 at kernel/resource.c:1486
> release_mem_region_adjustable+0x210/0x280
> Modules linked in:
> CPU: 5 UID: 0 PID: 858 Comm: chmem Not tainted 6.17.0-rc2-11707-g2c36aaf3ba4e
> Hardware name: IBM 3906 M04 704 (z/VM 7.3.0)
> Krnl PSW : 0704d00180000000 0000024ec0dae0e4
>             (release_mem_region_adjustable+0x214/0x280)
>             R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
> Krnl GPRS: 0000000000000000 00000002ffffafc0 fffffffffffffff0 0000000000000000
>             000000014fffffff 0000024ec2257608 0000000000000000 0000024ec2301758
>             0000024ec22680d0 00000000902c9140 0000000150000000 00000002ffffafc0
>             000003ffa61d8d18 0000024ec21fb478 0000024ec0dae014 000001cec194fbb0
> Krnl Code: 0000024ec0dae0d8: af000000            mc      0,0
>             0000024ec0dae0dc: a7f4ffc1            brc     15,0000024ec0dae05e
>            #0000024ec0dae0e0: af000000            mc      0,0
>            >0000024ec0dae0e4: a5defffd            llilh   %r13,65533
>             0000024ec0dae0e8: c04000c6064c        larl    %r4,0000024ec266ed80
>             0000024ec0dae0ee: eb1d400000f8        laa     %r1,%r13,0(%r4)
>             0000024ec0dae0f4: 07e0                bcr     14,%r0
>             0000024ec0dae0f6: a7f4ffc0            brc     15,0000024ec0dae076
> Call Trace:
>   [<0000024ec0dae0e4>] release_mem_region_adjustable+0x214/0x280
> ([<0000024ec0dadf3c>] release_mem_region_adjustable+0x6c/0x280)
>   [<0000024ec10a2130>] try_remove_memory+0x100/0x140
>   [<0000024ec10a4052>] __remove_memory+0x22/0x40
>   [<0000024ec18890f6>] config_mblock_store+0x326/0x3e0
>   [<0000024ec11f7056>] kernfs_fop_write_iter+0x136/0x210
>   [<0000024ec1121e86>] vfs_write+0x236/0x3c0
>   [<0000024ec11221b8>] ksys_write+0x78/0x110
>   [<0000024ec1b6bfbe>] __do_syscall+0x12e/0x350
>   [<0000024ec1b782ce>] system_call+0x6e/0x90
> Last Breaking-Event-Address:
>   [<0000024ec0dae014>] release_mem_region_adjustable+0x144/0x280
> ---[ end trace 0000000000000000 ]---
> 
> Also, resource adjustment doesn't happen and stale resources still cover
> [0-12288M].  Later, memory re-add fails in register_memory_resource()
> with -EBUSY.
> 
> i.e: /proc/iomem is still:
> 00000000-2dfefffff : System RAM
>    158834000-1597b3fff : Kernel code
>    1597b4000-159f50fff : Kernel data
>    15a13c000-15a218fff : Kernel bss
> 2dff00000-2ffefffff : Crash kernel
> 2fff00000-2ffffffff : System RAM
> 
> Enhance release_mem_region_adjustable() to reassign child resources
> to the correct parent after a split. Children are now assigned based on
> their actual range: If they fall within the lower split, keep them in
> the lower parent. If they fall within the upper split, move them to the
> upper parent.
> 
> Kernel code/data/bss regions are not offlined, so they will always
> reside entirely within one parent and never span across both.

Yes.

> 
> Output after the enhancement:
> * Initial state /proc/iomem (before removal of memory block):
> 00000000-2dfefffff : System RAM
>    1f94f8000-1fa477fff : Kernel code
>    1fa478000-1fac14fff : Kernel data
>    1fae00000-1faedcfff : Kernel bss
> 2dff00000-2ffefffff : Crash kernel
> 2fff00000-2ffffffff : System RAM
> 
> * Offline and remove 0x1e8000000-0x1efffffff memory range
> * /proc/iomem
> 00000000-1e7ffffff : System RAM
> 1f0000000-2dfefffff : System RAM
>    1f94f8000-1fa477fff : Kernel code
>    1fa478000-1fac14fff : Kernel data
>    1fae00000-1faedcfff : Kernel bss
> 2dff00000-2ffefffff : Crash kernel
> 2fff00000-2ffffffff : System RAM
> 

Do we need a Fixes: and CC stable?

> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>   kernel/resource.c | 44 +++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 39 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index f9bb5481501a..c329b8a4aa2f 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1388,6 +1388,41 @@ void __release_region(struct resource *parent, resource_size_t start,
>   EXPORT_SYMBOL(__release_region);
>   
>   #ifdef CONFIG_MEMORY_HOTREMOVE
> +static void append_child_to_parent(struct resource *new_parent, struct resource *new_child)
> +{
> +	struct resource *child;
> +
> +	child = new_parent->child;
> +	if (child) {
> +		while (child->sibling)
> +			child = child->sibling;
> +		child->sibling = new_child;

Shouldn't we take care of the address ordering here? I guess this works 
because we process them in left-to-right (lowest-to-highest) address.

> +	} else {
> +		new_parent->child = new_child;
> +	}
> +	new_child->parent = new_parent;
> +	new_child->sibling = NULL;
> +}
> +
> +static void move_children_to_parent(struct resource *old_parent,
> +				    struct resource *new_parent,
> +				    resource_size_t split_addr)

I'd call this "reparent_child_resources". But actually the function is 
weird. Because you only reparents some resources from old to now.

Two questions:

a) Is split_addr really required. Couldn't we derive that from "old_parent"

b) Could we somehow make it clearer (variable names etc) that we are 
only reparenting from "left" to "right" (maybe we can find better names).

Something like

/*
  * Reparent all child resources that no longer belong to "low" after
  * a split to "high". Note that "high" does not have any children,
  * because "low" is the adjusted original resource and "high" is a new
  * resource.
  */
static void reparent_children_after_split(struct resource *low,
		struct resource *high)

Again, maybe we can find better names for left/right low/high.

[...]

>    *
>    * Note:
>    * - Additional release conditions, such as overlapping region, can be
>    *   supported after they are confirmed as valid cases.
> - * - When a busy memory resource gets split into two entries, the code
> - *   assumes that all children remain in the lower address entry for
> - *   simplicity.  Enhance this logic when necessary.
> + * - When a busy memory resource gets split into two entries, its children is

s/is/are/

> + *   reassigned to the correct parent based on their range. If a child memory
> + *   resource overlaps with more than one parent, enhance the logic as needed.
>    */
>   void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
>   {
> @@ -1482,6 +1515,7 @@ void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
>   			new_res->parent = res->parent;
>   			new_res->sibling = res->sibling;
>   			new_res->child = NULL;
> +			move_children_to_parent(res, new_res, end);
>   
>   			if (WARN_ON_ONCE(__adjust_resource(res, res->start,
>   							   start - res->start)))


-- 
Cheers

David / dhildenb

