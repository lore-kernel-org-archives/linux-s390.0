Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8CBC3A5A7
	for <linux-s390@archiver.kernel.org>; Thu,  8 Dec 2022 08:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiLHI5M (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 8 Dec 2022 03:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiLHI47 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Dec 2022 03:56:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A657463D5C
        for <linux-s390@vger.kernel.org>; Thu,  8 Dec 2022 00:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670489755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qZzQND0XXn/ac1VVVRiwKzVF2wPIGejtH8QPoB1hHfA=;
        b=QPFkG++A/8JL5La+pALQpMxgOwAt4ktwVCkc0B7GKmSOmsQdJwO6bUe02qtZHfivaxVdc3
        G9Wjgdcy6CTAaGzTr8Cckc2sdx+1EbdNMrC++y5ZAPBbYS5RMOrBZy9yOPYliW8bDkf1S/
        1Ay3qqX5PGov4onlFtRbv5LxaYRg05Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-5-BDpcF1z4NRigwDmjrVLSQA-1; Thu, 08 Dec 2022 03:55:54 -0500
X-MC-Unique: BDpcF1z4NRigwDmjrVLSQA-1
Received: by mail-wm1-f69.google.com with SMTP id x10-20020a05600c420a00b003cfa33f2e7cso517148wmh.2
        for <linux-s390@vger.kernel.org>; Thu, 08 Dec 2022 00:55:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZzQND0XXn/ac1VVVRiwKzVF2wPIGejtH8QPoB1hHfA=;
        b=JdXeBu5c49BzjvjaiSJ/ZP3ZrWN4C62kjXcJEgLa+hSh5PqylCETpZHechU+ry4+hx
         UehvCjNc4ip6E+ofWA3ExbTgbbnslR7Lf4bIdJ9WYw4x2pmWcB+SqDgvjREfYHNprjH/
         TxdmeAR+hUwCNh2PG4G9q4dOLYo94WbKy7Q3+oECXqw6gXi/diF4VnLUBEi9rD/2kpzX
         lvZYAPeLu5utw1xc9fIFco3Zr07vrjc+Hcr1synWYf4/1u2iY5lemkY8gjWLV0q+l6Eb
         AYv56RNLgmDH6YKpyZDybCm5globyz2UYGpBSon9ZLYTVfUpkMjSsjInlsOALTov8FBs
         0HXA==
X-Gm-Message-State: ANoB5plZwFc//lZvhJPV6ext1gz7RwftiPFK3mxqVYaAOS+OWYpcdIS2
        mEd6cSoUBtB/bnt+Yh8ExBms5ta9zmRL2ViIrH0REAmq62O6ScMuwcwFwZ5HfEqkJQJKy4DJP3L
        LDnWoTjDzBuGJ76umyChioQ==
X-Received: by 2002:a5d:504d:0:b0:242:246c:2f89 with SMTP id h13-20020a5d504d000000b00242246c2f89mr22919602wrt.108.1670489752976;
        Thu, 08 Dec 2022 00:55:52 -0800 (PST)
X-Google-Smtp-Source: AA0mqf668NfxbMXQWSDBD6iCzqqUG4mJSCJROvTfbJs0ERpg3lPeZTVH/8wev7o0MHbpIs1xArxqSg==
X-Received: by 2002:a5d:504d:0:b0:242:246c:2f89 with SMTP id h13-20020a5d504d000000b00242246c2f89mr22919565wrt.108.1670489752626;
        Thu, 08 Dec 2022 00:55:52 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id o29-20020adfa11d000000b0024278304ef6sm6288982wro.13.2022.12.08.00.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 00:55:52 -0800 (PST)
Message-ID: <c904aa67-1add-119c-162f-e35d8243a11a@redhat.com>
Date:   Thu, 8 Dec 2022 09:55:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH mm-unstable RFC 17/26] powerpc/mm: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE on 32bit book3s
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
References: <20221206144730.163732-1-david@redhat.com>
 <20221206144730.163732-18-david@redhat.com>
 <8be167b6-3836-25c3-9f69-b8b3916ee5b4@csgroup.eu>
 <0b5b1303-8bcb-c19d-5f63-0e4a3517fea5@redhat.com>
Organization: Red Hat
In-Reply-To: <0b5b1303-8bcb-c19d-5f63-0e4a3517fea5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 08.12.22 09:52, David Hildenbrand wrote:
> On 07.12.22 14:55, Christophe Leroy wrote:
>>
>>
>> Le 06/12/2022 à 15:47, David Hildenbrand a écrit :
>>> We already implemented support for 64bit book3s in commit bff9beaa2e80
>>> ("powerpc/pgtable: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE for book3s")
>>>
>>> Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE also in 32bit by reusing yet
>>> unused LSB 2 / MSB 29. There seems to be no real reason why that bit cannot
>>> be used, and reusing it avoids having to steal one bit from the swap
>>> offset.
>>>
>>> While at it, mask the type in __swp_entry().
>>>
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>> Cc: Nicholas Piggin <npiggin@gmail.com>
>>> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>     arch/powerpc/include/asm/book3s/32/pgtable.h | 38 +++++++++++++++++---
>>>     1 file changed, 33 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
>>> index 75823f39e042..8107835b38c1 100644
>>> --- a/arch/powerpc/include/asm/book3s/32/pgtable.h
>>> +++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
>>> @@ -42,6 +42,9 @@
>>>     #define _PMD_PRESENT_MASK (PAGE_MASK)
>>>     #define _PMD_BAD	(~PAGE_MASK)
>>>     
>>> +/* We borrow the _PAGE_USER bit to store the exclusive marker in swap PTEs. */
>>> +#define _PAGE_SWP_EXCLUSIVE	_PAGE_USER
>>> +
>>>     /* And here we include common definitions */
>>>     
>>>     #define _PAGE_KERNEL_RO		0
>>> @@ -363,17 +366,42 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
>>>     #define pmd_page(pmd)		pfn_to_page(pmd_pfn(pmd))
>>>     
>>>     /*
>>> - * Encode and decode a swap entry.
>>> - * Note that the bits we use in a PTE for representing a swap entry
>>> - * must not include the _PAGE_PRESENT bit or the _PAGE_HASHPTE bit (if used).
>>> - *   -- paulus
>>> + * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
>>> + * are !pte_none() && !pte_present().
>>> + *
>>> + * Format of swap PTEs (32bit PTEs):
>>> + *
>>> + *                         1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3
>>> + *   0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
>>> + *   E H P <- type --> <----------------- offset ------------------>
>>
>> That's in reversed order. _PAGE_HASHPTE is bit 30 and should be on the
>> right hand side. Etc ...
> 
> Ugh, messed it up while converting back and forth between LSB 0 and MSB 0.
> 
> /*
>    * Format of swap PTEs (32bit PTEs):
>    *
>    *                         1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3
>    *   0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
>    *   <----------------- offset ------------------> <- type --> E H P
> 
> 

Still wrong, the type is only 5 bits:

+ * Format of swap PTEs (32bit PTEs):
+ *
+ *                         1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3
+ *   0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+ *   <----------------- offset --------------------> < type -> E H P
+ *


-- 
Thanks,

David / dhildenb

