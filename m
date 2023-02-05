Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEA3C636CD
	for <linux-s390@archiver.kernel.org>; Sun,  5 Feb 2023 23:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjBEXRy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 5 Feb 2023 18:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBEXRx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 5 Feb 2023 18:17:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A1619690
        for <linux-s390@vger.kernel.org>; Sun,  5 Feb 2023 15:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675639031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qONcW0u0rSlhga0NbKyxqeLooMqDqXOYmnEPrTgV3J4=;
        b=NwDki4L4KmNw56uC3T+KTFhy26MfFO7pFMDgpqZtfkPNZZ/Uf0iIJLklJ9vw5yAu4+yDm+
        V1Asiql4ffUcNrn7YQAjI0BRhyBhN0ClDDTVcFzb5koS7Bn8Cz8S3EqxPoxGjmu1Fz7orJ
        zbDYJVmlr5+zN8xdxEkZ/fEts25UJUE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-437--xFCoOU6Mjex0ydaso9lsA-1; Sun, 05 Feb 2023 18:17:09 -0500
X-MC-Unique: -xFCoOU6Mjex0ydaso9lsA-1
Received: by mail-qk1-f199.google.com with SMTP id u10-20020a05620a0c4a00b00705e77d6207so6761712qki.5
        for <linux-s390@vger.kernel.org>; Sun, 05 Feb 2023 15:17:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qONcW0u0rSlhga0NbKyxqeLooMqDqXOYmnEPrTgV3J4=;
        b=AQ4teJ9ZWjF00v/UjBnpo8xmOvrudBjg16pA2SDxoiuu9l3S2YO7ZBID9dRRLcW5lV
         vEgnxw3ykVEkP1XaOygy2LGMJjzqLz7RfDayK4+LLRK2XZ6bHiR90j6r0CAVlSoQexMH
         Wc1vqZTDMKSU4WhaHBUj8Nwt0DtMX8/oYsnxqEBJPEchbzXqgU4qQMqqKq1bMQJCBH3m
         STZJpklS8wJP0Ief2ERLuXerxgmtGdHlMTB1eq99b9iT2f7dsBBwX5d0xRYCoh3oYJe2
         Jt8N4pIdaDn7NAZOefcE1FhVulXC7GGSpx41KtQZVccn9Sh/Wd71NVBlFtNXJQ5kZaO2
         ZVyA==
X-Gm-Message-State: AO0yUKXFPKYJkH2LFq9pWmnkzlqvhP3VCJFdeBxCzWtNvAiDzsxHtiJY
        vxkaTHIUdWiAOW+dYLm/O1lv8FHnttiwcE+MZF+uHsXtsVHGCpTHL/6uiGXxsvi1/z6rfLZ5cYn
        WeQmJrahgNOSPN6Vp+fAUOw==
X-Received: by 2002:ac8:5a0c:0:b0:3b5:87db:f979 with SMTP id n12-20020ac85a0c000000b003b587dbf979mr36967896qta.5.1675639028663;
        Sun, 05 Feb 2023 15:17:08 -0800 (PST)
X-Google-Smtp-Source: AK7set9kqgEL6o3t7eGoOILoA6rSeOClso5mcvRwdEtgXNoCUXmYbAoESbFf+GAMsxjDlz50rZUFyQ==
X-Received: by 2002:ac8:5a0c:0:b0:3b5:87db:f979 with SMTP id n12-20020ac85a0c000000b003b587dbf979mr36967876qta.5.1675639028460;
        Sun, 05 Feb 2023 15:17:08 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id h26-20020ac8515a000000b003b82cb8748dsm5986545qtn.96.2023.02.05.15.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 15:17:07 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
Subject: [PATCH 1/3] mm/arm: Define private VM_FAULT_* reasons from top bits
Date:   Sun,  5 Feb 2023 18:17:02 -0500
Message-Id: <20230205231704.909536-2-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230205231704.909536-1-peterx@redhat.com>
References: <20230205231704.909536-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The current definition already collapse with the generic definition of
vm_fault_reason.  Move the private definitions to allocate bits from the
top of uint so they won't collapse anymore.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm/mm/fault.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 2418f1efabd8..67879d995835 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -216,8 +216,12 @@ void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 }
 
 #ifdef CONFIG_MMU
-#define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
-#define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
+/*
+ * Allocate private vm_fault_reason from top.  Please make sure it won't
+ * collide with vm_fault_reason.
+ */
+#define VM_FAULT_BADMAP		((__force vm_fault_t)0x80000000)
+#define VM_FAULT_BADACCESS	((__force vm_fault_t)0x40000000)
 
 static inline bool is_permission_fault(unsigned int fsr)
 {
-- 
2.37.3

