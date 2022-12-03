Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56CBC4708E
	for <linux-s390@archiver.kernel.org>; Sat,  3 Dec 2022 03:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbiLCDFx (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 2 Dec 2022 22:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiLCDFt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Dec 2022 22:05:49 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16AFF7A1E
        for <linux-s390@vger.kernel.org>; Fri,  2 Dec 2022 19:05:47 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id x13-20020a17090a46cd00b00218f611b6e9so6733865pjg.1
        for <linux-s390@vger.kernel.org>; Fri, 02 Dec 2022 19:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSVgH09qEnpbMDCTLASqX2OMVKXLGyPI/rjfeHRIKu4=;
        b=wrC9Di4g/FkQry/CsUbIzu4ShoQtDm632rHMb1y98183Vkm7GE+1KgGiQeiqPRu746
         EpOqc9dOuSYQ+KgbsAL0f0eaO3YxXVARb1Qy/aZlLGx5xT8FJkymkARbubJV3UJhsZIH
         X0s2m87BWl0Nk7Bcfhw39dO5P0B7WZR3xG8jCR7ylvOfUZJOlQHN0djD0b5b36wlrQxo
         jgkGiA62CEcQWD//xV7j8pXqM1WcnxGbE2honL5gHULuNRyMkT1dxPj0xOx1vMDLAewW
         AXdhismtJx65svzL/lahWs98kLQcqmbFwviKntKjqxOCAmGqWokX22ZxG9BANL1F6/V3
         RqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSVgH09qEnpbMDCTLASqX2OMVKXLGyPI/rjfeHRIKu4=;
        b=qySs82pAEqgoL+/hEevUzAyW1EULNBQjTd5owmhHohh2Q7Sjo6WJQfetouKHGTagUv
         0rgiyWtH90Jbe2JuM9PrwCw5SuweA09GNRjorbmbtCg1X+3REU+cb1oQTf/JP2yI7F0G
         dDja00l0qkJZ98qknsIoK3WUN/2Eh2FIf6eFYtN8Ui5pW4dWK2TfTDVdyuJopJZFWhrt
         lpQGbHwVQmnPdah8iB5K9AzQJDT2yVpRyQ9UM98LrC25LACyNj623zLquij9DYLeq4oH
         BNJI0hF5BE66MvMu9BgJ3XDwHnAsRzEsZVJbVsO1Dv+DMIueKlisWFQ7YyaZCbYsvHUB
         Mh/w==
X-Gm-Message-State: ANoB5pnrcOAYCNv7UdZE01nPDvrlykt1ulezfzn5l0Th/+Chk1OPjhuM
        1WwjrrKmGVmXJfY+whTqR8FALg==
X-Google-Smtp-Source: AA0mqf4XSUxHT34o8cfUz81MqLg2uR3iZhKmjmdLNRSRwmN3btpX4jv5Kh1mNew10ARt+0Rl1idwLg==
X-Received: by 2002:a17:90a:2b88:b0:219:a1e4:20e2 with SMTP id u8-20020a17090a2b8800b00219a1e420e2mr2146067pjd.182.1670036747139;
        Fri, 02 Dec 2022 19:05:47 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id z27-20020aa7949b000000b00575fbe1cf31sm4894634pfk.67.2022.12.02.19.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 19:05:46 -0800 (PST)
Subject: [PATCH 5/5] RISC-V: fault: Convert to VM_FAULT_ARCH_* codes
Date:   Fri,  2 Dec 2022 19:03:56 -0800
Message-Id: <20221203030356.3917-6-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221203030356.3917-1-palmer@rivosinc.com>
References: <20221203030356.3917-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
           linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

These conflict with VM_FAULT_HINDEX_MASK, so move to some designated
arch-specific values.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/mm/fault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 3fdc2eebdd36..bd990735aa90 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -202,8 +202,8 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
 	return false;
 }
 
-#define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
-#define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
+#define VM_FAULT_BADMAP		VM_FAULT_ARCH_0
+#define VM_FAULT_BADACCESS	VM_FAULT_ARCH_1
 
 static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
 				unsigned int mm_flags, struct pt_regs *regs)
-- 
2.38.1

