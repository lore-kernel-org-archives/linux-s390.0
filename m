Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E017FC77B7C
	for <linux-s390@archiver.kernel.org>; Wed, 10 May 2023 04:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbjEJE4x (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 May 2023 00:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjEJE4v (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 May 2023 00:56:51 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E583A1FC2
        for <linux-s390@vger.kernel.org>; Tue,  9 May 2023 21:56:48 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-55b7630a736so101758457b3.1
        for <linux-s390@vger.kernel.org>; Tue, 09 May 2023 21:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683694608; x=1686286608;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VvuiwGfmHxTbGTIrjZEu2Atjrxfj5l7d/xiFwRLchQg=;
        b=r94LQDZtq2Ahs+pJ02XRyENxJHGD3oe8r85F2aY3lvsikc/je1Po6VKiCqGzvG34y8
         kIuRE1yIIechhFDgP3aPNUwpsvddbLpTk1K5K+zsi9h4zTnxpk/JVyiDuMs9BN+OFeXh
         nh4AqDsTEXGceRxF3pEZTvbfDGAiIr5yaqLJ7E2ZoOdKC1Zkn5Abo0ezT8CCDEe5hzan
         c+lECJHpRVibRO6qY89AP62g051JuNBSBft2ut/t1eSbSZxO5Og6LOCNCOMTH+prHdN+
         QRgICMzswpXaaxM5lmYItFqDFDCHtHoD+lRFcRdM6eNSSTq3389JYb3eyyNp72I0hHaA
         zjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683694608; x=1686286608;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvuiwGfmHxTbGTIrjZEu2Atjrxfj5l7d/xiFwRLchQg=;
        b=f/0yZtd2ge2CIhUOnuIl3cSIWS9iYo/VwnpryT8Ayz3GkEFMoxUSkqDHU2cL22oXnG
         fcv3MnJ1y8MV5kRYKj/k7ST9YWT0PE39Besrs4wpa+/PdVvzb3vPO/WqmshcGMm7smvZ
         V68Dse5zwvsZXy3gG/lQEsGNxEdnRum4z6ieIHb1T+Zkc18UjVRe7kHEUlV/7cJIjG8R
         MoMDJrbLdNi1PM5RBaTRWFGHFjbq8sarOAzX45ZAniKsO8IvUGTy8K0s4mfr0iL4/09G
         sEBrRZgiR5q41t+EEGO4exZbF8Tb+Pyw1FzLFcRZfqmXlE+BEaP8X1VOcnZr3+SwbMls
         jIkA==
X-Gm-Message-State: AC+VfDwv9TenP5Y21cdWsg/L1MPGQkxMySJbkkO2x81sou/UlH50Agl1
        ipoz5rqprQmpE+HoCq5kLybfEw==
X-Google-Smtp-Source: ACHHUZ7AyL+rmns/Ft/OH9KHX6GHbff2/XDcrKV9m3YxNF0ibK6GlQcG44pT8V6Ez5OWany7qS8Crw==
X-Received: by 2002:a0d:db49:0:b0:55a:314d:afdc with SMTP id d70-20020a0ddb49000000b0055a314dafdcmr18425257ywe.37.1683694608059;
        Tue, 09 May 2023 21:56:48 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f206-20020a816ad7000000b00559fb950d9fsm3842735ywc.45.2023.05.09.21.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 21:56:47 -0700 (PDT)
Date:   Tue, 9 May 2023 21:56:44 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 11/23] powerpc: kvmppc_unmap_free_pmd() pte_offset_kernel()
In-Reply-To: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
Message-ID: <8bc72262-3771-4fbf-8738-44d9a8a1ba6a@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

kvmppc_unmap_free_pmd() use pte_offset_kernel(), like everywhere else
in book3s_64_mmu_radix.c: instead of pte_offset_map(), which will come
to need a pte_unmap() to balance it.

But note that this is a more complex case than most: see those -EAGAINs
in kvmppc_create_pte(), which is coping with kvmppc races beween page
table and huge entry, of the kind which we are expecting to address
in pte_offset_map() - this might want to be revisited in future.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 461307b89c3a..572707858d65 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -509,7 +509,7 @@ static void kvmppc_unmap_free_pmd(struct kvm *kvm, pmd_t *pmd, bool full,
 		} else {
 			pte_t *pte;
 
-			pte = pte_offset_map(p, 0);
+			pte = pte_offset_kernel(p, 0);
 			kvmppc_unmap_free_pte(kvm, pte, full, lpid);
 			pmd_clear(p);
 		}
-- 
2.35.3

