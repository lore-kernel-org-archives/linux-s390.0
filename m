Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF62AC77B7C
	for <linux-s390@archiver.kernel.org>; Wed, 10 May 2023 05:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbjEJFKA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 May 2023 01:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235899AbjEJFJ6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 May 2023 01:09:58 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A61D4EE7
        for <linux-s390@vger.kernel.org>; Tue,  9 May 2023 22:09:55 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-55a76ed088aso101755637b3.2
        for <linux-s390@vger.kernel.org>; Tue, 09 May 2023 22:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683695395; x=1686287395;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UmemeLuI+WpEQXgz9TQT0mwehV8FTU9BDTa5EhoH+Rw=;
        b=ceZayvLcQzK/jEmDGFktdiBeLmAfZAcJomtj6b8LZ7UVBhK1PGvRLGtv3raaIkoA69
         8du4wIfy3LTg4noNW6T56a8rTdYN7Kpn5/bm4yjB4emMMTggN1PcgpP7ET0zc6Ogox7V
         PacpXMb40YNuRMAqf3IboaGbQzDmk/4AhKXM1jLiRZe7o3tGAOJ6z3OSnXWDEM8MmOjy
         leDcr9V/CMd1mPfM2iHPwMwcuDGyHWo5yaj5bkj6ZD28Zg+yk0+3HzvQJBuo9qxnWea2
         qCcGWwBxF4a0/bB7X0FeLhxKH1U3vpEQVW9dVdnIidnAwcXxE3l++8L3bRK0NJ7IyPS8
         JZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683695395; x=1686287395;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmemeLuI+WpEQXgz9TQT0mwehV8FTU9BDTa5EhoH+Rw=;
        b=CXLMIMVKxrHWfmuSVKURlFyQxbF2jfczv6S1CqE3lVhZh29KMsV0JKn7zsuEJD5vBE
         ix3V6GVMGvekKTdm/QjsFnkiE7agOf526aK5XDnDiJcVb5ctatvsG57xHEmuznley6vx
         wDrHczofPQrFO0Cs3yZ3bgiLq0apI+0k0SXQzoqN52salPgIIooRin7B+VgIpdUq4mUH
         fLDNOeFDi7mtKP+vhLs4uK4te9Dt0zh8xkHRBdruixPWvGy15pixBQ8OoeDtQ3AZkWOY
         yRxf+kJv90dx7Ro9RqGj63nO9uGYRNMTahUCIMJ9ROmC+5Fvptzzffzb0MsIIv3agiKo
         Tjvg==
X-Gm-Message-State: AC+VfDwjgi6W1JcdRo1v/ir35QOl6ddumnbXCPRr42MetJ60hDG1/hqA
        c1113RxsBzc11DUJ0t5OtyJ+1A==
X-Google-Smtp-Source: ACHHUZ6AHFxady081B2wan1G2AdvRI+je11F7XC2fK+PaWqaZjZVH5+mul53az7NeaRbK79eLrDOFQ==
X-Received: by 2002:a81:92d7:0:b0:55a:4828:182a with SMTP id j206-20020a8192d7000000b0055a4828182amr18309481ywg.36.1683695394676;
        Tue, 09 May 2023 22:09:54 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l64-20020a0dc943000000b0055aad7d3f34sm3766659ywd.142.2023.05.09.22.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 22:09:54 -0700 (PDT)
Date:   Tue, 9 May 2023 22:09:50 -0700 (PDT)
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
Subject: [PATCH 22/23] x86: sme_populate_pgd() use pte_offset_kernel()
In-Reply-To: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
Message-ID: <6d75e7f-2266-1dda-8a70-c52c27f44da7@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

sme_populate_pgd() is an __init function for sme_encrypt_kernel():
it should use pte_offset_kernel() instead of pte_offset_map(), to avoid
the question of whether a pte_unmap() will be needed to balance.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/x86/mm/mem_encrypt_identity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index c6efcf559d88..a1ab542bdfd6 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -188,7 +188,7 @@ static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 	if (pmd_large(*pmd))
 		return;
 
-	pte = pte_offset_map(pmd, ppd->vaddr);
+	pte = pte_offset_kernel(pmd, ppd->vaddr);
 	if (pte_none(*pte))
 		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
 }
-- 
2.35.3

