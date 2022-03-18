Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B1CC433F5
	for <linux-s390@archiver.kernel.org>; Fri, 18 Mar 2022 14:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbiCROPv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 18 Mar 2022 10:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236992AbiCROPu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 18 Mar 2022 10:15:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C5ED2467F5
        for <linux-s390@vger.kernel.org>; Fri, 18 Mar 2022 07:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647612870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vrk5fX2xWSdP9n1bkww7mSZRBCrjbbAY4wpRt0kMGOs=;
        b=EZixjensjCoS1i3P6C0cotlk/+x6xjvwmasAkqgB+Fns7ko9zd9etxqF1E1St75QWEbV7L
        mLKiTTBJ8BwRu6sSK9IQorGedlYTS4ZyJrCNpc6VvTQ8bRmPQNyGKohR1UFd62hE3F0Eo/
        XcMAcZ9MHB2ygqkj+PszN4/r97GikKk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-IaQ8v5jTOmKZkqUPt0sRvQ-1; Fri, 18 Mar 2022 10:14:29 -0400
X-MC-Unique: IaQ8v5jTOmKZkqUPt0sRvQ-1
Received: by mail-wm1-f71.google.com with SMTP id h127-20020a1c2185000000b0038c6f7e22a4so3885572wmh.9
        for <linux-s390@vger.kernel.org>; Fri, 18 Mar 2022 07:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Vrk5fX2xWSdP9n1bkww7mSZRBCrjbbAY4wpRt0kMGOs=;
        b=AsdnGxz9JQiGsLbMdUHlnaG/o6vZ7JhXWfgf/XoCyN7/gK0V/JQARihpBL5vowzVqL
         nNFWLZORZdiu9RNQoY/uFBtqNtFih31ye8w1voOU1MvCkOluVasFg3O4ueNYqBVJXd77
         NUXIoQzOtevlxw1/XaKVW0ixDolg2hBy4fY8imqUEm6vkNdKVKT6PAxebf/jN1IN35dT
         h/AN5umPmQPH2DBvpGY8CBEq08t3qsjZBmVuyODkd5awDTgzzIWQf2sz8T/0bp/pADNb
         DrUNXZk2AoI336LJfpAUUtXn5MFGk3Lb87lVfE2p/6midkoEypIGrvD2PnUsVWFJDuW1
         Y2yA==
X-Gm-Message-State: AOAM530KvBkNcDDe7ZzmeP4rHd5MCfCmYo2l8o+7qzTA/77eDSBxlMGE
        WpvnQkUWdMdOwV3/sY2LToTXRRhMuvs5efG1lK4Cbajso9codtQgUioA99K2Vm+/A27rtM5QyJI
        x+Q+mgTd16F092Z6mN+ysHg==
X-Received: by 2002:adf:f604:0:b0:203:d9ca:bccf with SMTP id t4-20020adff604000000b00203d9cabccfmr8306947wrp.331.1647612868269;
        Fri, 18 Mar 2022 07:14:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjLDR4x76jQT8vPKbt5WCkwgszEYzxfTTeJzEyGuYsFFC95N5UVyBJYkEnjUBvTDuYOItNow==
X-Received: by 2002:adf:f604:0:b0:203:d9ca:bccf with SMTP id t4-20020adff604000000b00203d9cabccfmr8306914wrp.331.1647612867962;
        Fri, 18 Mar 2022 07:14:27 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f24:9200:124e:f0bf:6f8c:cbd8? (p200300d82f249200124ef0bf6f8ccbd8.dip0.t-ipconnect.de. [2003:d8:2f24:9200:124e:f0bf:6f8c:cbd8])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c228700b00389865c646dsm9066181wmf.14.2022.03.18.07.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 07:14:27 -0700 (PDT)
Message-ID: <c4fcedf1-22a9-c912-824d-644a21b2fcfd@redhat.com>
Date:   Fri, 18 Mar 2022 15:14:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v1 4/7] arm64/pgtable: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
References: <20220315141837.137118-1-david@redhat.com>
 <20220315141837.137118-5-david@redhat.com> <YjIr9f9qaz4xITVd@arm.com>
 <c3d39666-52ae-42ba-eaa2-7a0ca489f766@redhat.com> <YjN2qsXkmlEUTg4u@arm.com>
 <8989a07b-3a5b-0c81-983f-b35403d19579@redhat.com> <YjRt7DqDFJRZA7Gt@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YjRt7DqDFJRZA7Gt@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 18.03.22 12:33, Catalin Marinas wrote:
> On Fri, Mar 18, 2022 at 10:59:10AM +0100, David Hildenbrand wrote:
>> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
>> index b1e1b74d993c..fd6ddf14c190 100644
>> --- a/arch/arm64/include/asm/pgtable-prot.h
>> +++ b/arch/arm64/include/asm/pgtable-prot.h
>> @@ -14,6 +14,7 @@
>>   * Software defined PTE bits definition.
>>   */
>>  #define PTE_WRITE		(PTE_DBM)		 /* same as DBM (51) */
>> +#define PTE_SWP_EXCLUSIVE	(PTE_TABLE_BIT)		 /* only for swp ptes */
>>  #define PTE_DIRTY		(_AT(pteval_t, 1) << 55)
>>  #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
>>  #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 94e147e5456c..c78994073cd0 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -402,6 +402,22 @@ static inline pgprot_t mk_pmd_sect_prot(pgprot_t prot)
>>  	return __pgprot((pgprot_val(prot) & ~PMD_TABLE_BIT) | PMD_TYPE_SECT);
>>  }
>>  
>> +#define __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>> +static inline pte_t pte_swp_mkexclusive(pte_t pte)
>> +{
>> +	return set_pte_bit(pte, __pgprot(PTE_SWP_EXCLUSIVE));
>> +}
>> +
>> +static inline int pte_swp_exclusive(pte_t pte)
>> +{
>> +	return pte_val(pte) & PTE_SWP_EXCLUSIVE;
>> +}
>> +
>> +static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>> +{
>> +	return clear_pte_bit(pte, __pgprot(PTE_SWP_EXCLUSIVE));
>> +}
>> +
>>  #ifdef CONFIG_NUMA_BALANCING
>>  /*
>>   * See the comment in include/linux/pgtable.h
>> @@ -908,7 +924,8 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>>  
>>  /*
>>   * Encode and decode a swap entry:
>> - *	bits 0-1:	present (must be zero)
>> + *	bits 0:		present (must be zero)
>> + *	bits 1:		remember PG_anon_exclusive
> 
> It looks fine to me.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 

Great, thanks!

-- 
Thanks,

David / dhildenb

