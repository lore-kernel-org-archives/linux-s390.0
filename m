Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEADC48BE6
	for <linux-s390@archiver.kernel.org>; Mon, 14 Jun 2021 13:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5CBA611EE
	for <linux-s390@archiver.kernel.org>; Mon, 14 Jun 2021 13:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbhFNNq5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 14 Jun 2021 09:46:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55819 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234028AbhFNNq4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Jun 2021 09:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623678293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WB47Pni+nWnZCpL3j99qdXOV/pBIAB8A+KnYUYN28RA=;
        b=IA58C7pvf4dGyL9Vt89mklcGWVzHiP9PGQTAR7XSo5YmbgRe18d4N/MnEaN9iEX19EWT1v
        /UGPcJqIF58MzIAfsFwsBngPM6wQ9Ji1sH6opxxcELRunrsteWucEvA5/2CEB9Mxo7Oc/g
        TNjqolFNI0ru+vFh3YkUlfi50/uMuqI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-iJaAFyY4PimGFwu3gi_OSQ-1; Mon, 14 Jun 2021 09:44:52 -0400
X-MC-Unique: iJaAFyY4PimGFwu3gi_OSQ-1
Received: by mail-wm1-f69.google.com with SMTP id f22-20020a1c6a160000b029018f49a7efb7so6701150wmc.1
        for <linux-s390@vger.kernel.org>; Mon, 14 Jun 2021 06:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WB47Pni+nWnZCpL3j99qdXOV/pBIAB8A+KnYUYN28RA=;
        b=hjo9SZlTWPjZYQORAdxOzYYTXSbI3nVSdohE8h6tAw7J9B+k/bQJUxzmTTzJrY2ghp
         vPxhBehfcRhaqgOdXZMZIFaXJx1sa35XPK0bOJWQ96OPLqIUvXGJfuGInQNie47QTvXd
         EL3B0HD4/QHNea5kg6zMlBRftfFY+v+JHaWA9vR84rgXmDsHSxKaBDjl043h/h+KJBy8
         IoEhv0gF0qTpSXpSFfBCLKFyUSGMtAkeQchNrl1Y1GOns8F66XwriRbRug6bmgnBw4Tg
         Yp9IlZ0bYboB85WZ9gDYU9TdlPF+jDiusY4KDD69VIYjszZ+D+Ud3TYmX/Oh5fjrOGrP
         eafQ==
X-Gm-Message-State: AOAM531eEWQq9fRcl1xO6ujZYo7pt6FYK5Zh0N6I8D6acdy/erD7z0mf
        yygQ2h6mwa4qVqXb93AmRsIgcD6VenWtaPLwdW5vFSsDpYBI/0Wf0bTFIZd9JIMjP7po6yyKH/b
        BeospZ3oQAleygyqwdL8gzQ==
X-Received: by 2002:a1c:4e12:: with SMTP id g18mr28719063wmh.101.1623678290831;
        Mon, 14 Jun 2021 06:44:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWpm7VHBHg5E8TavVz/PqtB9z7c94nrDgE5PFAe0bmP/4EluavDGqNCHfZLyv6MB54rYIebA==
X-Received: by 2002:a1c:4e12:: with SMTP id g18mr28719035wmh.101.1623678290649;
        Mon, 14 Jun 2021 06:44:50 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c66ca.dip0.t-ipconnect.de. [91.12.102.202])
        by smtp.gmail.com with ESMTPSA id 125sm21656180wmb.34.2021.06.14.06.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 06:44:50 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] mm/vmalloc: add vmalloc_no_huge
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        frankja@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        linux-mm@kvack.org, Uladzislau Rezki <urezki@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20210614132357.10202-1-imbrenda@linux.ibm.com>
 <20210614132357.10202-2-imbrenda@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <8f24292e-e8c9-9b9b-0429-2ac984a01611@redhat.com>
Date:   Mon, 14 Jun 2021 15:44:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210614132357.10202-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 14.06.21 15:23, Claudio Imbrenda wrote:
> Commit 121e6f3258fe3 ("mm/vmalloc: hugepage vmalloc mappings") added
> support for hugepage vmalloc mappings, it also added the flag
> VM_NO_HUGE_VMAP for __vmalloc_node_range to request the allocation to
> be performed with 0-order non-huge pages.  This flag is not accessible
> when calling vmalloc, the only option is to call directly
> __vmalloc_node_range, which is not exported.
> 
> This means that a module can't vmalloc memory with small pages.
> 
> Case in point: KVM on s390x needs to vmalloc a large area, and it needs
> to be mapped with non-huge pages, because of a hardware limitation.
> 
> This patch adds the function vmalloc_no_huge, which works like vmalloc,
> but it is guaranteed to always back the mapping using small pages. This
> new function is exported, therefore it is usable by modules.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Acked-by: Nicholas Piggin <npiggin@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> ---
>   include/linux/vmalloc.h |  1 +
>   mm/vmalloc.c            | 16 ++++++++++++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 4d668abb6391..bfaaf0b6fa76 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -135,6 +135,7 @@ extern void *__vmalloc_node_range(unsigned long size, unsigned long align,
>   			const void *caller);
>   void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
>   		int node, const void *caller);
> +void *vmalloc_no_huge(unsigned long size);
>   
>   extern void vfree(const void *addr);
>   extern void vfree_atomic(const void *addr);
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a13ac524f6ff..296a2fcc3fbe 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2998,6 +2998,22 @@ void *vmalloc(unsigned long size)
>   }
>   EXPORT_SYMBOL(vmalloc);
>   
> +/**
> + * vmalloc_no_huge - allocate virtually contiguous memory using small pages
> + * @size:    allocation size
> + *
> + * Allocate enough non-huge pages to cover @size from the page level
> + * allocator and map them into contiguous kernel virtual space.
> + *
> + * Return: pointer to the allocated memory or %NULL on error
> + */
> +void *vmalloc_no_huge(unsigned long size)
> +{
> +	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END, GFP_KERNEL, PAGE_KERNEL,
> +				    VM_NO_HUGE_VMAP, NUMA_NO_NODE, __builtin_return_address(0));
> +}
> +EXPORT_SYMBOL(vmalloc_no_huge);
> +
>   /**
>    * vzalloc - allocate virtually contiguous memory with zero fill
>    * @size:    allocation size
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

