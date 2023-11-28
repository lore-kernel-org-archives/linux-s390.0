Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+HqiyIJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C162BE
	for <linux-s390@vger.kernel.org>; Tue, 28 Nov 2023 03:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701169924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/6EcAvtYDLBpeQOlEKiIKhoqHpmw/0Z5fvLXvKnOSs0=;
	b=N+HqiyIJ3zPpXr69X1yo1GbHbq/CDINKbR+0gUQJdv2TZaJ2Z/0cT/YbgmXNVjgi9FFHgS
	krflttbSY4up0yPxb3gTNJgyHz5ej7e9AGjG6Vky55EdzD5nNy1fNuZzugnlX852ptnMD+
	ZHDU2/wgA7R/UPe9WdOyyTG9v7VvMS0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-3Tyt1GjBMK-l-5MXEeJwsg-1; Tue, 28 Nov 2023 06:12:03 -0500
X-MC-Unique: 3Tyt1GjBMK-l-5MXEeJwsg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-332fab597afso1702534f8f.3
        for <linux-s390@vger.kernel.org>; Tue, 28 Nov 2023 03:12:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701169922; x=1701774722;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6EcAvtYDLBpeQOlEKiIKhoqHpmw/0Z5fvLXvKnOSs0=;
        b=VIwJDtNkeRugN6Be+ursfK1g644cG7VUnvxYNb6M+akdJiexIjC6fORYAJmVGx4nD8
         B+x5xPYdOuIQSgSe7Pq51ghvPX7H8gK9BgxIdoXg1BQqzYHlZjBxDiIJo1ZUKr9J8wjx
         UWCIeMNjDmgMiFToiwi2M4ochHaXgHaz2bNMXSWCgm1FQwoqo9suq2m+4tuNCS5p/rKv
         egqMmEoYj0w6r05W2cR0G1NlsxmiPGcG/mjwjmxF0rn/KmHm4ilcx+J6Hwg5scfnF2es
         GafqfgSk5WD0i87YfDWFMCRqxhTPIwt9tsSGbqnHU0T+zYVf7NA7bI6f1UHDOvkMKznA
         IyeA==
X-Gm-Message-State: AOJu0YwEuhhUAWebziWPrq8ck959ZUXzan0sdaQhJ9lEqpVgKn0Rfn7b
	CO4LAkBPl0e97HZaf50mlu+U2UXwbNFP6XMMWmkzha9EyqR7a/4ecLr0GWc/0N31SPhgE4VF1jR
	J3vpuXqQiMuvTOOoyq1JEoQ==
X-Received: by 2002:a5d:4746:0:b0:32d:9df1:6f6d with SMTP id o6-20020a5d4746000000b0032d9df16f6dmr9748049wrs.17.1701169921888;
        Tue, 28 Nov 2023 03:12:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhuO5Lo7ldTBgGm66tE+kfERizFh+qrL4iqFiKGnrDsYw/cPbZZVkHr304XlgRsIQrP6HEZA==
X-Received: by 2002:a5d:4746:0:b0:32d:9df1:6f6d with SMTP id o6-20020a5d4746000000b0032d9df16f6dmr9748036wrs.17.1701169921524;
        Tue, 28 Nov 2023 03:12:01 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:1d00:99ec:9656:7475:678d? (p200300cbc7081d0099ec96567475678d.dip0.t-ipconnect.de. [2003:cb:c708:1d00:99ec:9656:7475:678d])
        by smtp.gmail.com with ESMTPSA id a11-20020adff7cb000000b00332fda15056sm6670744wrq.110.2023.11.28.03.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 03:12:01 -0800 (PST)
Message-ID: <b915799f-663f-4deb-9ba8-3a7410cb5a31@redhat.com>
Date: Tue, 28 Nov 2023 12:12:00 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] s390/mm: implement
 MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers
Content-Language: en-US
To: Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-mm <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-s390 <linux-s390@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20231128110342.102096-1-sumanthk@linux.ibm.com>
 <20231128110342.102096-5-sumanthk@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231128110342.102096-5-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.11.23 12:03, Sumanth Korikkar wrote:
> MEM_PREPARE_ONLINE memory notifier makes memory block physical
> accessible via sclp assign command. The notifier ensures self-contained
> memory maps are accessible and hence enabling the "memmap on memory" on
> s390.
> 
> MEM_FINISH_OFFLINE memory notifier shifts the memory block to an
> inaccessible state via sclp unassign command.
> 
> Implementation considerations:
> * When MHP_MEMMAP_ON_MEMORY is disabled, the system retains the old
>    behavior. This means the memory map is allocated from default memory.
> * If MACHINE_HAS_EDAT1 is unavailable, MHP_MEMMAP_ON_MEMORY is
>    automatically disabled. This ensures that vmemmap pagetables do not
>    consume additional memory from the default memory allocator.
> * The MEM_GOING_ONLINE notifier has been modified to perform no
>    operation, as MEM_PREPARE_ONLINE already executes the sclp assign
>    command.
> * The MEM_CANCEL_ONLINE/MEM_OFFLINE notifier now performs no operation, as
>    MEM_FINISH_OFFLINE already executes the sclp unassign command.
> 
> Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>   drivers/s390/char/sclp_cmd.c | 47 +++++++++++++++++++++++++++++++-----
>   1 file changed, 41 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
> index 355e63e44e95..c551dc6734fe 100644
> --- a/drivers/s390/char/sclp_cmd.c
> +++ b/drivers/s390/char/sclp_cmd.c
> @@ -18,6 +18,7 @@
>   #include <linux/mm.h>
>   #include <linux/mmzone.h>
>   #include <linux/memory.h>
> +#include <linux/memory_hotplug.h>
>   #include <linux/module.h>
>   #include <asm/ctlreg.h>
>   #include <asm/chpid.h>
> @@ -26,6 +27,7 @@
>   #include <asm/sclp.h>
>   #include <asm/numa.h>
>   #include <asm/facility.h>
> +#include <asm/page-states.h>
>   
>   #include "sclp.h"
>   
> @@ -319,6 +321,7 @@ static bool contains_standby_increment(unsigned long start, unsigned long end)
>   static int sclp_mem_notifier(struct notifier_block *nb,
>   			     unsigned long action, void *data)
>   {
> +	unsigned long altmap_start, altmap_size;
>   	unsigned long start, size;
>   	struct memory_notify *arg;
>   	unsigned char id;
> @@ -340,13 +343,43 @@ static int sclp_mem_notifier(struct notifier_block *nb,
>   		if (contains_standby_increment(start, start + size))
>   			rc = -EPERM;
>   		break;
> -	case MEM_GOING_ONLINE:
> +	case MEM_PREPARE_ONLINE:
> +		/*
> +		 * Access the altmap_start_pfn and altmap_nr_pages fields
> +		 * within the struct memory_notify specifically when dealing
> +		 * with only MEM_PREPARE_ONLINE/MEM_PREPARE_OFFLINE notifiers.
> +		 */
> +		altmap_start = arg->altmap_start_pfn << PAGE_SHIFT;
> +		altmap_size = arg->altmap_nr_pages << PAGE_SHIFT;

PFN_PHYS(), maybe you can directly do:

if (arg->altmap_start_pfn) {
	start = PFN_PHYS(arg->altmap_start_pfn);
	size += PFN_PHYS(arg->altmap_nr_pages);
}

...

and avoid the variables completely.

Reviewed-by: David Hildenbrand <david@redhat.com>

>   	default:
> @@ -397,7 +430,9 @@ static void __init add_memory_merged(u16 rn)
>   	if (!size)
>   		goto skip_add;
>   	for (addr = start; addr < start + size; addr += block_size)
> -		add_memory(0, addr, block_size, MHP_NONE);
> +		add_memory(0, addr, block_size,
> +			   MACHINE_HAS_EDAT1 ?
> +			   MHP_MEMMAP_ON_MEMORY | MHP_OFFLINE_INACCESSIBLE : MHP_NONE);
>   skip_add:
>   	first_rn = rn;
>   	num = 1;

That hunk is likely better moved to the last enabling patch.

-- 
Cheers,

David / dhildenb

