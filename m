Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FD5C7EE2A
	for <linux-s390@archiver.kernel.org>; Wed, 10 May 2023 14:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbjEJOB7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 May 2023 10:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbjEJOB6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 May 2023 10:01:58 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E247535A0
        for <linux-s390@vger.kernel.org>; Wed, 10 May 2023 07:01:55 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64115e652eeso50447582b3a.0
        for <linux-s390@vger.kernel.org>; Wed, 10 May 2023 07:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1683727315; x=1686319315;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8O+Xva6SSKUOzu8cD6VykU+fN8y+E0NtB9pirvzzQ9U=;
        b=xm7Lt7K+fM4a6fbPP7MIva3KYIsdEH2pn6NhTnqMZWDxfwMmfjfuC2iA7TIUgSp9X7
         iapnslzabTi/3hpYysj/Y+Qpo/U+trS4YUbBrAymZCbRPQc2GdzYMvfSXRt75xnkQ7HH
         9YmGcBzN1XGEnBnDnk4hqc6szvJ0vnbRYHR7DYbbDIfxitLJRxJHVDjlkZx/sb2Dalmd
         NMN9fv1UEU3MEvWMv2OyK363gty+uPi7R5tqnoKyXja1AZDDzs7OuMx+xXPfQOPl3EBu
         5ahAyXiN9ZWDD9X3LQrrN5sPj7Sd7WcMwJ/uvJSD2iG4PimTEA2R4mrq6SpEbr7//1lB
         gm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683727315; x=1686319315;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8O+Xva6SSKUOzu8cD6VykU+fN8y+E0NtB9pirvzzQ9U=;
        b=Uh+RMchU3dxaJEMEvPAhPbHu5PmHr+aGdcD3agx00H+5QtTPxmwtxo+lpuRRaoFzpC
         jpbsgtGq8QId4jxRIPCqneOtM55zg2e1knbuiTjase9Eae42jfoPLpSn7JohDa23qPap
         xF8Jng5AmOE8opLQnXgg6HyVrQvn+UZ+WjSDJRv42vQ2yV1skioDkfb5y3Y66nzg6XHM
         +0ZxQWo5eExnFsMlF/O1mzYNhoGoeLpDj7wPx+2h4tNi93gRJbJvk/dkl6tlsWL/ljO1
         5UoaQ21jgOgzbpjNSkDUa80Qf4DhxutTaHuAaF/EHyko77kDeWadXQPZA1yrQF/Ot+gP
         akRA==
X-Gm-Message-State: AC+VfDzy7hxLkHVBDRmwenPyp2pccGUON1kX4UTyJ8SaGWb5JmE39rWr
        bvqvzDu7a3/M60CxcOXafBKS6A==
X-Google-Smtp-Source: ACHHUZ5DO6A5G9Iwzn4Bquam+4PsWMq7WswXOCHPFyT+gtbX2VPfleyC7b8WGb0kQumaiIfRAr9lsw==
X-Received: by 2002:a17:902:9a03:b0:1ad:1be7:2a76 with SMTP id v3-20020a1709029a0300b001ad1be72a76mr1572089plp.10.1683727315241;
        Wed, 10 May 2023 07:01:55 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902dac600b001ac55a5e5eesm3819212plx.121.2023.05.10.07.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 07:01:54 -0700 (PDT)
Date:   Wed, 10 May 2023 07:01:54 -0700 (PDT)
X-Google-Original-Date: Wed, 10 May 2023 07:01:48 PDT (-0700)
Subject:     Re: [PATCH 14/23] riscv/hugetlb: pte_alloc_huge() pte_offset_huge()
In-Reply-To: <d1e54510-9ea2-edf-3851-fa7635ce1e5e@google.com>
CC:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        rppt@kernel.org, kirill.shutemov@linux.intel.com,
        willy@infradead.org, david@redhat.com, surenb@google.com,
        zhengqi.arch@bytedance.com, linux@armlinux.org.uk,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, geert@linux-m68k.org,
        gerg@linux-m68k.org, monstr@monstr.eu, tsbogend@alpha.franken.de,
        deller@gmx.de, dave.anglin@bell.net, aneesh.kumar@linux.ibm.com,
        mpe@ellerman.id.au, alexghiti@rivosinc.com, hca@linux.ibm.com,
        borntraeger@linux.ibm.com, imbrenda@linux.ibm.com,
        glaubitz@physik.fu-berlin.de, davem@davemloft.net,
        chris@zankel.net, jcmvbkbc@gmail.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     hughd@google.com
Message-ID: <mhng-fa58638c-1b42-4264-8bf1-55d4bc42a5e2@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 09 May 2023 21:59:57 PDT (-0700), hughd@google.com wrote:
> pte_alloc_map() expects to be followed by pte_unmap(), but hugetlb omits
> that: to keep balance in future, use the recently added pte_alloc_huge()
> instead; with pte_offset_huge() a better name for pte_offset_kernel().
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  arch/riscv/mm/hugetlbpage.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
> index a163a3e0f0d4..80926946759f 100644
> --- a/arch/riscv/mm/hugetlbpage.c
> +++ b/arch/riscv/mm/hugetlbpage.c
> @@ -43,7 +43,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
>
>  	for_each_napot_order(order) {
>  		if (napot_cont_size(order) == sz) {
> -			pte = pte_alloc_map(mm, pmd, addr & napot_cont_mask(order));
> +			pte = pte_alloc_huge(mm, pmd, addr & napot_cont_mask(order));
>  			break;
>  		}
>  	}
> @@ -90,7 +90,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
>
>  	for_each_napot_order(order) {
>  		if (napot_cont_size(order) == sz) {
> -			pte = pte_offset_kernel(pmd, addr & napot_cont_mask(order));
> +			pte = pte_offset_huge(pmd, addr & napot_cont_mask(order));
>  			break;
>  		}
>  	}

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
