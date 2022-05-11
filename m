Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D638C4321E
	for <linux-s390@archiver.kernel.org>; Wed, 11 May 2022 17:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237350AbiEKR2H (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 11 May 2022 13:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345549AbiEKR2F (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 11 May 2022 13:28:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0BC352B10
        for <linux-s390@vger.kernel.org>; Wed, 11 May 2022 10:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652290081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cS5E6UtIkG/hFuUJaz85MfZ3xWqLO1I63lqGQCOfSNw=;
        b=h9Kkg6bxy6vsZ5MkHmLGhdoNjLqMKp0k5xsGMQWAyZL8wEgrXXK9eX34YqTfjfFletoHAx
        10tf88VX+oMKhtdyw/C2fyk0EPTowCJAglo2aNb8kqUvrKRwrw34IcFuQEXoDSSrVZTWAq
        H+BkTL9nsIB0CRdf8ZnFAjvtJzCDVHs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-AqYX-NLkNFuY9WNkpgTRMA-1; Wed, 11 May 2022 13:27:58 -0400
X-MC-Unique: AqYX-NLkNFuY9WNkpgTRMA-1
Received: by mail-wr1-f69.google.com with SMTP id s16-20020adfeb10000000b0020cc4e5e683so1104144wrn.6
        for <linux-s390@vger.kernel.org>; Wed, 11 May 2022 10:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=cS5E6UtIkG/hFuUJaz85MfZ3xWqLO1I63lqGQCOfSNw=;
        b=GsGD7YQE12ldb8s9yP+ry9l0Y5BMIo6Vy8CGPwShj9p+EKuHn0DbmDmEEco2lBOOvu
         66+QtmA3poLx1Gnd+/1WpbQlHLGMnwCv+LGh3BP+zM7W8lDenayCaeaavnQY+3TyyUQH
         pk292VoXRaNW4B397gBieF4UcljLP2k9Fm8ryB0SQuVxm3HPGVtKO41aSymYCK+tpctg
         WuZmHU9KFLp+CUgTRN4uudN9/d08dO1g1vP9xAk0rRRX+lStnN1OAIeJ2Yu/LB/Pkgl6
         jwczHmGFyf35I5QTFcFzDRkELQkGRk95vK1r/U0jN7zozLKxrVFehhZUG+egVBl02HRj
         THIQ==
X-Gm-Message-State: AOAM533hTjHkXgm8NawHiify7J7S8SxYNgSsXCBxgB2Lm0DSQmrJSSZ6
        S1xhkqhUChyk5KwBebXqXy5JndPbGH76dO/krkxBOJx2nx9yeL5H339y5UsMkaF5imKBt8WNC0X
        19rrrVs06ayPRyfJXqhjRYg==
X-Received: by 2002:a7b:c4d8:0:b0:393:fecd:2718 with SMTP id g24-20020a7bc4d8000000b00393fecd2718mr6012824wmk.23.1652290077484;
        Wed, 11 May 2022 10:27:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBTzXKBES23B3psLkzxI9cGRRJgtAEIRhBp8LvQHOEvCQMFPcLMWgEwEKr1C169Li1EVKAzw==
X-Received: by 2002:a7b:c4d8:0:b0:393:fecd:2718 with SMTP id g24-20020a7bc4d8000000b00393fecd2718mr6012790wmk.23.1652290077160;
        Wed, 11 May 2022 10:27:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:700:2393:b0f4:ef08:bd51? (p200300cbc70107002393b0f4ef08bd51.dip0.t-ipconnect.de. [2003:cb:c701:700:2393:b0f4:ef08:bd51])
        by smtp.gmail.com with ESMTPSA id r12-20020a5d694c000000b0020c5253d8c3sm2174483wrw.15.2022.05.11.10.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 10:27:55 -0700 (PDT)
Message-ID: <55e85b3e-dd6a-1dc2-719d-c6be9d5124c0@redhat.com>
Date:   Wed, 11 May 2022 19:27:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 2/3] mm: rmap: Fix CONT-PTE/PMD size hugetlb issue when
 migration
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, mike.kravetz@oracle.com
Cc:     catalin.marinas@arm.com, will@kernel.org, songmuchun@bytedance.com,
        tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
References: <cover.1652270205.git.baolin.wang@linux.alibaba.com>
 <a4baca670aca637e7198d9ae4543b8873cb224dc.1652270205.git.baolin.wang@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <a4baca670aca637e7198d9ae4543b8873cb224dc.1652270205.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11.05.22 14:04, Baolin Wang wrote:
> On some architectures (like ARM64), it can support CONT-PTE/PMD size
> hugetlb, which means it can support not only PMD/PUD size hugetlb:
> 2M and 1G, but also CONT-PTE/PMD size: 64K and 32M if a 4K page
> size specified.
> 
> When migrating a hugetlb page, we will get the relevant page table
> entry by huge_pte_offset() only once to nuke it and remap it with
> a migration pte entry. This is correct for PMD or PUD size hugetlb,
> since they always contain only one pmd entry or pud entry in the
> page table.
> 
> However this is incorrect for CONT-PTE and CONT-PMD size hugetlb,
> since they can contain several continuous pte or pmd entry with
> same page table attributes. So we will nuke or remap only one pte
> or pmd entry for this CONT-PTE/PMD size hugetlb page, which is
> not expected for hugetlb migration. The problem is we can still
> continue to modify the subpages' data of a hugetlb page during
> migrating a hugetlb page, which can cause a serious data consistent
> issue, since we did not nuke the page table entry and set a
> migration pte for the subpages of a hugetlb page.
> 
> To fix this issue, we should change to use huge_ptep_clear_flush()
> to nuke a hugetlb page table, and remap it with set_huge_pte_at()
> and set_huge_swap_pte_at() when migrating a hugetlb page, which
> already considered the CONT-PTE or CONT-PMD size hugetlb.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Makes sense to me.

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

