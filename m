Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AAEC433FE
	for <linux-s390@archiver.kernel.org>; Thu, 17 Mar 2022 10:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbiCQKFl (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 17 Mar 2022 06:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiCQKFk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 17 Mar 2022 06:05:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F1AADCA8A
        for <linux-s390@vger.kernel.org>; Thu, 17 Mar 2022 03:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647511463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MBNPObCUCYNtALaMx9Iaf80ooxBHklxdAF9RYy04dD0=;
        b=RMMKCscrOlXKZuztnOOW1WZCy+D7pbLNJo0axR/zFvOa7s1beHNskoh7xjHzwix201L3E9
        4y4g9o+3XDL77JmJQyjZPl+MMBoLsCQ1y15+JCvnD7n13Q8fCEAtQR3c1fVQp3u3smhoXz
        C0GSEyeanGDNXoz/cJuEWZTZ8DYY9mA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-WCL-X3loOdOAfDN8ccivfg-1; Thu, 17 Mar 2022 06:04:21 -0400
X-MC-Unique: WCL-X3loOdOAfDN8ccivfg-1
Received: by mail-wm1-f71.google.com with SMTP id r9-20020a1c4409000000b0038c15a1ed8cso2060460wma.7
        for <linux-s390@vger.kernel.org>; Thu, 17 Mar 2022 03:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=MBNPObCUCYNtALaMx9Iaf80ooxBHklxdAF9RYy04dD0=;
        b=a5vrSn3u9JK9h2bDjYHQL+xI7s/NYQkx0YD0Vz0YMppwgIVnuvBA5RFA2jugWLUDJC
         6CdaGHOgakiDyPXfIOLP6A3bmAu9T6xR+IG9Jhjvqjw2kMSs1qRIm4AlTZ23JP1XsMFi
         k/k5MKgNU2MRDUiSYw1/2jyp0cVp24ZjCoC7FAF3Y0hdnBLXk73EXARyI/aywxgZFmgU
         e1JV4Rfgd2HaV80R54ct0rkbZmd/4AQYJPGKKjsHvreOOYu97IgkKh1bCEjVBKfE9Pdw
         Xg9+DcQZqv1gTvnMnss94CYL6/rGygo8eGvJwoVG/pyfYddeclFqATwlyZ6pnUvF9xsR
         zMlA==
X-Gm-Message-State: AOAM5317rSjbBvI9hWeRNhruycKQPqapegqRv3mUCC8PYxpj3+1600RM
        iRO2AS5hapS/+dF7AqRl6PisJumGwsAz04OnUYg7u4WVJyKFJ7EInzg+4cu/RnhLpuHTvgMQwRT
        b018HAMje4LddMbhSXrgfMg==
X-Received: by 2002:a05:600c:a4a:b0:389:e8fd:54b4 with SMTP id c10-20020a05600c0a4a00b00389e8fd54b4mr3151333wmq.168.1647511460552;
        Thu, 17 Mar 2022 03:04:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqDnOUQ38GHBC7qxykUWE5EEPAwQFTum3x+dhkpMIFZaDI62UNmCzA1x1kIEv/0vMQ4ejNKg==
X-Received: by 2002:a05:600c:a4a:b0:389:e8fd:54b4 with SMTP id c10-20020a05600c0a4a00b00389e8fd54b4mr3151270wmq.168.1647511460156;
        Thu, 17 Mar 2022 03:04:20 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id g13-20020a05600c4ecd00b0038a0165f2fbsm4412271wmq.17.2022.03.17.03.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 03:04:19 -0700 (PDT)
Message-ID: <c3d39666-52ae-42ba-eaa2-7a0ca489f766@redhat.com>
Date:   Thu, 17 Mar 2022 11:04:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 4/7] arm64/pgtable: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE
In-Reply-To: <YjIr9f9qaz4xITVd@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 16.03.22 19:27, Catalin Marinas wrote:
> On Tue, Mar 15, 2022 at 03:18:34PM +0100, David Hildenbrand wrote:
>> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
>> index b1e1b74d993c..62e0ebeed720 100644
>> --- a/arch/arm64/include/asm/pgtable-prot.h
>> +++ b/arch/arm64/include/asm/pgtable-prot.h
>> @@ -14,6 +14,7 @@
>>   * Software defined PTE bits definition.
>>   */
>>  #define PTE_WRITE		(PTE_DBM)		 /* same as DBM (51) */
>> +#define PTE_SWP_EXCLUSIVE	(_AT(pteval_t, 1) << 2)	 /* only for swp ptes */
> 
> I think we can use bit 1 here.
> 
>> @@ -909,12 +925,13 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>>  /*
>>   * Encode and decode a swap entry:
>>   *	bits 0-1:	present (must be zero)
>> - *	bits 2-7:	swap type
>> + *	bits 2:		remember PG_anon_exclusive
>> + *	bits 3-7:	swap type
>>   *	bits 8-57:	swap offset
>>   *	bit  58:	PTE_PROT_NONE (must be zero)
> 
> I don't remember exactly why we reserved bits 0 and 1 when, from the
> hardware perspective, it's sufficient for bit 0 to be 0 and the whole
> pte becomes invalid. We use bit 1 as the 'table' bit (when 0 at pmd
> level, it's a huge page) but we shouldn't check for this on a swap
> entry.

You mean

arch/arm64/include/asm/pgtable-hwdef.h:#define PTE_TABLE_BIT            (_AT(pteval_t, 1) << 1)

right?

I wonder why it even exists, for arm64 I only spot:

arch/arm64/include/asm/pgtable.h:#define pte_mkhuge(pte)                (__pte(pte_val(pte) & ~PTE_TABLE_BIT))

I don't really see code that sets PTE_TABLE_BIT.

Similarly, I don't see code that sets PMD_TABLE_BIT/PUD_TABLE_BIT/P4D_TABLE_BIT.
Most probably setting code is not using the defines,  that's why I'm not finding it.

-- 
Thanks,

David / dhildenb

