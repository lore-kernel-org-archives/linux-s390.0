Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMU7IBS4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B37BE
	for <linux-s390@vger.kernel.org>; Mon, 27 Nov 2023 07:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701100264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/MW6fXJWJVxOzUmBSa6MQ4ghqr1tOYYSz5WWxvHituE=;
	b=fMU7IBS4LCDhIuAPbF9AlRZKuIC8WwzAIRkK70t4KhzlgAXhIpDXWzZZ9UkMfvkwqXodMX
	tJ2Y5wOLVJnrtZFXClJvoWw8gRU7A9A79Y/tFIUi/di9SZ++t/nYLu+mBSXXLjyD/bT9rR
	2PQtweuXS08D5s0YduKBdL7PtrcA9lU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-e8T84GHSMxqsmcdcz07cuA-1; Mon, 27 Nov 2023 10:51:03 -0500
X-MC-Unique: e8T84GHSMxqsmcdcz07cuA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-332f5ff511aso1681968f8f.2
        for <linux-s390@vger.kernel.org>; Mon, 27 Nov 2023 07:51:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701100261; x=1701705061;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MW6fXJWJVxOzUmBSa6MQ4ghqr1tOYYSz5WWxvHituE=;
        b=Oryla7+3stII4RGuznISLomq2sSYmwuWKCDWmqMWwqd9/k2WClJw3PE+h13e4c5Xde
         Ap6Ps3yccivFTCHL0nWbh2F+j0zL1EjE9DlHyEyEVsvqgpejwTeDMQuiIWsYbDin9UTJ
         QzDcRwViX5E3cAlEUCd4bKtg9G1L585ATY0Xv0rk87vhRHSsc2j8pgMrENt0kSQ3T6zc
         942fz6mEonNsdlnQRMDXR76dWsuS3Pm7ZXYaqLQLfVgJxwMHslcRO5mgnhGBSM8o5m4p
         FvKEjMoDQTlM/+ZZMdFlL8E0bccWLDbaaomC/e57sZT0wihBOxJVISRT6Kz0VM89+b/G
         XGAA==
X-Gm-Message-State: AOJu0YxyYu2p6RONXRzQdIl7g9wSnLeDbM7+wT6AWZ+2QqMGQ4b9ZJfi
	cxAWLkTt03sj5iFlY0dU8VLQ2I85FSCeQ7bp7+8KLizcKqKebx7QQLLry1Frh4XSvNwYzleYIe4
	i7njh18blr4x/OgggpuGRmw==
X-Received: by 2002:a5d:42c6:0:b0:32f:8248:e00 with SMTP id t6-20020a5d42c6000000b0032f82480e00mr7904610wrr.51.1701100260863;
        Mon, 27 Nov 2023 07:51:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5k3ZLyNQccZYzbu69giOSq0M2cyfy1n30nyrdFyJPfJRDUajhMqkhfxcoHUzqMx+PKELWtQ==
X-Received: by 2002:a5d:42c6:0:b0:32f:8248:e00 with SMTP id t6-20020a5d42c6000000b0032f82480e00mr7904593wrr.51.1701100260472;
        Mon, 27 Nov 2023 07:51:00 -0800 (PST)
Received: from ?IPV6:2003:cb:c745:2a00:d74a:a8c5:20b6:3ec3? (p200300cbc7452a00d74aa8c520b63ec3.dip0.t-ipconnect.de. [2003:cb:c745:2a00:d74a:a8c5:20b6:3ec3])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d594f000000b00332fda15055sm4434889wri.111.2023.11.27.07.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 07:51:00 -0800 (PST)
Message-ID: <afb4a0ca-3f5d-4fd2-9bde-3c8dbc16d2a5@redhat.com>
Date: Mon, 27 Nov 2023 16:50:59 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] mm/memory_hotplug: introduce
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
References: <20231127082023.2079810-1-sumanthk@linux.ibm.com>
 <20231127082023.2079810-2-sumanthk@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231127082023.2079810-2-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.11.23 09:20, Sumanth Korikkar wrote:
> Introduce  MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE memory notifiers to
> prepare the transition of memory to and from a physically accessible
> state. This enhancement is crucial for implementing the "memmap on
> memory" feature for s390 in a subsequent patch.
> 
> Platforms such as x86 can support physical memory hotplug via ACPI. When
> there is physical memory hotplug, ACPI event leads to the memory
> addition with the following callchain:
> acpi_memory_device_add()
>    -> acpi_memory_enable_device()
>       -> __add_memory()
> 
> After this, the hotplugged memory is physically accessible, and altmap
> support prepared, before the "memmap on memory" initialization in
> memory_block_online() is called.
> 
> On s390, memory hotplug works in a different way. The available hotplug
> memory has to be defined upfront in the hypervisor, but it is made
> physically accessible only when the user sets it online via sysfs,
> currently in the MEM_GOING_ONLINE notifier. This is too late and "memmap
> on memory" initialization is performed before calling MEM_GOING_ONLINE
> notifier.
> 
> During the memory hotplug addition phase, altmap support is prepared and
> during the memory onlining phase s390 requires memory to be physically
> accessible and then subsequently initiate the "memmap on memory"
> initialization process.
> 
> The memory provider will handle new MEM_PREPARE_ONLINE /
> MEM_FINISH_OFFLINE notifications and make the memory accessible.
> 
> The mhp_flag MHP_OFFLINE_INACCESSIBLE is introduced and is relevant when
> used along with MHP_MEMMAP_ON_MEMORY, because the altmap cannot be
> written (e.g., poisoned) when adding memory -- before it is set online.
> This allows for adding memory with an altmap that is not currently made
> available by a hypervisor. When onlining that memory, the hypervisor can
> be instructed to make that memory accessible via the new notifiers and
> the onlining phase will not require any memory allocations, which is
> helpful in low-memory situations.
> 
> All architectures ignore unknown memory notifiers.  Therefore, the
> introduction of these new notifiers does not result in any functional
> modifications across architectures.
> 
> Suggested-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>   drivers/base/memory.c          | 21 +++++++++++++++++++--
>   include/linux/memory.h         |  2 ++
>   include/linux/memory_hotplug.h | 18 +++++++++++++++++-
>   include/linux/memremap.h       |  1 +
>   mm/memory_hotplug.c            | 30 ++++++++++++++++++++++++++++--
>   mm/sparse.c                    |  3 ++-
>   6 files changed, 69 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 8a13babd826c..5c6b2af75db4 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -188,6 +188,7 @@ static int memory_block_online(struct memory_block *mem)
>   	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
>   	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
>   	unsigned long nr_vmemmap_pages = 0;
> +	struct memory_notify arg;
>   	struct zone *zone;
>   	int ret;
>   
> @@ -197,6 +198,14 @@ static int memory_block_online(struct memory_block *mem)
>   	zone = zone_for_pfn_range(mem->online_type, mem->nid, mem->group,
>   				  start_pfn, nr_pages);
>   
> +	arg.start_pfn = start_pfn;
> +	arg.nr_pages = nr_pages;


Thinking about it, it's possibly cleanest to send the altmap range along 
here.

Later memory onlining notifiers will only be notified about the actual 
!altmap part.

arg.altmap_start_pfn = start_pfn;
arg.altmap_nr_pages = nr_vmemmap_pages;
arg.start_pfn = start_pfn + nr_vmemmap_pages;
arg.nr_pages = nr_pages - nr_vmemmap_pages;

Use that for the two new notifiers only and document it. Thoughts?

-- 
Cheers,

David / dhildenb

