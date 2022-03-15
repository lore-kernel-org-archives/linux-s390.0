Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44159C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 15 Mar 2022 17:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350372AbiCORNg (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 15 Mar 2022 13:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350364AbiCORNf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 15 Mar 2022 13:13:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F487583B1
        for <linux-s390@vger.kernel.org>; Tue, 15 Mar 2022 10:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647364342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IDMoM6GQW/ashfKW/MEVa2kq3WdnPXUbjIFcEa4dk9o=;
        b=bBYlYExDE8d6Imp+lpsyWWJgZe+iBh+RR4N1KWXIFTXv1bi/g3adgTFlLXrYXGpsglWLwU
        a60ejQgt7bfEZXSWvHCrji/50r6dF0dJ2vSWnAzyr0o6nvtw2MJYUYeCqUL+80zWHLWKXA
        miOlVC32VgoRzTj51pYo+oK6qHzpzFE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-VHkSVA8dMVmpx5ce9_zdZg-1; Tue, 15 Mar 2022 13:12:20 -0400
X-MC-Unique: VHkSVA8dMVmpx5ce9_zdZg-1
Received: by mail-wr1-f70.google.com with SMTP id f18-20020adf9f52000000b00203d86759beso625257wrg.11
        for <linux-s390@vger.kernel.org>; Tue, 15 Mar 2022 10:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:organization:in-reply-to
         :content-transfer-encoding;
        bh=IDMoM6GQW/ashfKW/MEVa2kq3WdnPXUbjIFcEa4dk9o=;
        b=evjJu0MT4WJw4Ys8XBxvS6Ns6whbEd8+2PU/QUEc1xKTyJReDVlYIFiWVUuBrWTXop
         kvdwYOVK4HD8aBsidjOrApcyP2Tf2C7u28TeLcJzMHr5O23e8Dri/npwNWt/m7AeCHz/
         RhZkiMQHFNL3mFCNkMqD0PhRqkcEV888qlNGKUxwL8DI9LIIKU7U1BUFxqCNh4KM6Id7
         0TbrwO/iLR/P1tvMarEaqf3xc/mxyX3d/o762L19w/7pux0TKiayeA8CGQjxEpL1U8Ln
         ezKwTK9yD5aKKKvhTB1n8XfaXWIvj7rInoyWFSZ+x5+zF04v/z2L9f1mYDCoNqUTHCvA
         YtyQ==
X-Gm-Message-State: AOAM530xUk6/g9bL9F6QaUYoEUaNS7nFhYJnmvMQqdbHWw4eAJ6NzyU0
        QkH8a1EPhQa04oq4AsDjuEkhGTteOoR5L8mJ/b+KbsUDZGYyf1wR1JMVPwtZVQJJePP6eKOCf1y
        t2TuuJ/GvQv6xSwu1ADGFqw==
X-Received: by 2002:a1c:29c3:0:b0:350:9797:b38f with SMTP id p186-20020a1c29c3000000b003509797b38fmr4263073wmp.22.1647364339720;
        Tue, 15 Mar 2022 10:12:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRo6lxRuqE6aanoJAKbCAqJh0bxhE/UJ0/yn9fJg724PQPYvjcnNj2cfHsSRmdNHPQTYNmsA==
X-Received: by 2002:a1c:29c3:0:b0:350:9797:b38f with SMTP id p186-20020a1c29c3000000b003509797b38fmr4263013wmp.22.1647364339387;
        Tue, 15 Mar 2022 10:12:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:1800:42bd:3cac:d22a:3c62? (p200300cbc708180042bd3cacd22a3c62.dip0.t-ipconnect.de. [2003:cb:c708:1800:42bd:3cac:d22a:3c62])
        by smtp.gmail.com with ESMTPSA id i8-20020a1c5408000000b00389bf11ba0csm2759190wmb.38.2022.03.15.10.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 10:12:18 -0700 (PDT)
Message-ID: <55b6b582-51ca-b869-2055-674fe4c563e6@redhat.com>
Date:   Tue, 15 Mar 2022 18:12:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v1 5/7] s390/pgtable: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
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
        Catalin Marinas <catalin.marinas@arm.com>,
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
 <20220315141837.137118-6-david@redhat.com> <20220315172102.771bd2cf@thinkpad>
 <c8229082-e8f1-e605-25c2-0ec9d23efd9e@redhat.com>
 <8b13b6c0-78d4-48e3-06f0-ec0680d013a9@redhat.com>
Organization: Red Hat
In-Reply-To: <8b13b6c0-78d4-48e3-06f0-ec0680d013a9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 15.03.22 17:58, David Hildenbrand wrote:
> 
>>> This would mean that it is not OK to have bit 52 not zero for swap PTEs.
>>> But if I read the POP correctly, all bits except for the DAT-protection
>>> would be ignored for invalid PTEs, so maybe this comment needs some update
>>> (for both bits 52 and also 55).
>>>
>>> Heiko might also have some more insight.
>>
>> Indeed, I wonder why we should get a specification exception when the
>> PTE is invalid. I'll dig a bit into the PoP.
> 
> SA22-7832-12 6-46 ("Translation-Specification Exception") is clearer
> 
> "The page-table entry used for the translation is
> valid, and bit position 52 does not contain zero."
> 
> "The page-table entry used for the translation is
> valid, EDAT-1 does not apply, the instruction-exe-
> cution-protection facility is not installed, and bit
> position 55 does not contain zero. It is model
> dependent whether this condition is recognized."
> 

I wonder if the following matches reality:

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 008a6c856fa4..6a227a8c3712 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1669,18 +1669,16 @@ static inline int has_transparent_hugepage(void)
 /*
  * 64 bit swap entry format:
  * A page-table entry has some bits we have to treat in a special way.
- * Bits 52 and bit 55 have to be zero, otherwise a specification
- * exception will occur instead of a page translation exception. The
- * specification exception has the bad habit not to store necessary
- * information in the lowcore.
  * Bits 54 and 63 are used to indicate the page type.
  * A swap pte is indicated by bit pattern (pte & 0x201) == 0x200
- * This leaves the bits 0-51 and bits 56-62 to store type and offset.
- * We use the 5 bits from 57-61 for the type and the 52 bits from 0-51
- * for the offset.
- * |                     offset                        |01100|type |00|
+ * |                     offset                        |XX1XX|type |S0|
  * |0000000000111111111122222222223333333333444444444455|55555|55566|66|
  * |0123456789012345678901234567890123456789012345678901|23456|78901|23|
+ *
+ * Bits 0-51 store the offset.
+ * Bits 57-62 store the type.
+ * Bit 62 (S) is used for softdirty tracking.
+ * Bits 52, 53, 55 and 56 (X) are unused.
  */
 
 #define __SWP_OFFSET_MASK      ((1UL << 52) - 1)


I'm not sure why bit 53 was indicated as "1" and bit 55 was indicated as
"0". At least for 52 and 55 there was a clear description.

-- 
Thanks,

David / dhildenb

