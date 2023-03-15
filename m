Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6E8C6FD1D
	for <linux-s390@archiver.kernel.org>; Wed, 15 Mar 2023 03:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjCODF3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Mar 2023 23:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCODF2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Mar 2023 23:05:28 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D3E574F7
        for <linux-s390@vger.kernel.org>; Tue, 14 Mar 2023 20:05:27 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id ja10so8976052plb.5
        for <linux-s390@vger.kernel.org>; Tue, 14 Mar 2023 20:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678849526;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPLiCKdxpc2r5PKNkHmqRCNmdb24wQijBhgYpLkC43U=;
        b=hZOWobSL1PKWIUT7UWS9tniLiB9mdfLQVx/Z/9zPgZaqvjnOteqzCtEB9HjY6uDm5Z
         iih9EdmkZVUeQo0xOfl1VcnfVacdcLCd8AJJAPxhyA2sm6Xke46e1e2rJ7Rh0BSVXkF8
         LPvQJyzonpQFWDXt2SUjjq9ID4+tvuPP8BALY8prYRlpppPYUlsITVn79fdnaiUXQEF1
         deb+t9btxFOPW+9acEXIhNbZp2doaKT5YgC3FtBNm79vfC3LW+6mWJ6+9PBqPIyH0Kic
         Coc17KHtjWazt5MqaHhgFOTwgQhPQ0N0ANZIoSAUsfoul0ONsbg8PSj+Y8JcyFTwqcEL
         HRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678849526;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPLiCKdxpc2r5PKNkHmqRCNmdb24wQijBhgYpLkC43U=;
        b=woUlbd6RSbQcw5BMOzGHU6DiGuAKysiNe2yvfw0ziE/zwxAmcrS95Z3NmcsZEsohZ0
         fvfFpLAX+Q1o6TOujs+GesCJT0JAqrt9KgbzLtOpVcsRe4wp7thHswhsQc1e1EY1gwE9
         VHe37csQA3wAmiKx4zW1mtpq2o6i4W6WdBqkRJS9XWjMCTtXRNUKYxi2+32yiCYHCqx8
         LpN/VypFMibGOeomsLMNvzTMU/IySenVVter3cikSQjTxjo3VgDgGq6MMMWP/96dymPQ
         LZ0nQAuXu/FTtAhjbgVJUS+0fo82Wnhp93hipJb9M1o0ylCpLx5bqTKEf9L1mD27Y29k
         SSNQ==
X-Gm-Message-State: AO0yUKU8fEZOg0VZU7/UAOJ+qx1A5pai1c+79pejBC/Sj6pVxscI5kn/
        4teI/rOd6fjRyKVf5Fsm5w5xFQ==
X-Google-Smtp-Source: AK7set9vypcudDyWo/h8khv9E95mQjVI9aZbPGtfY3t0wFWv20PLrTeh2GiFiqI+9gk8Y0mpUagQ+Q==
X-Received: by 2002:a17:902:ec8a:b0:19e:416e:abf5 with SMTP id x10-20020a170902ec8a00b0019e416eabf5mr1078987plg.34.1678849526457;
        Tue, 14 Mar 2023 20:05:26 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id s30-20020a63451e000000b0050300a7c8c2sm2194674pga.89.2023.03.14.20.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 20:05:26 -0700 (PDT)
Subject: [PATCH v2 1/6] riscv/mm/fault: simplify code for do_page_fault()
Date:   Tue, 14 Mar 2023 20:03:54 -0700
Message-Id: <20230315030359.14162-2-palmer@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315030359.14162-1-palmer@rivosinc.com>
References: <20230315030359.14162-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tong Tiangen <tongtiangen@huawei.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     akpm@linux-foundation.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Tong Tiangen <tongtiangen@huawei.com>

To make the code more hierarchical and readable, we fold vma related
judgments into __do_page_fault(). And to simplify the code, move the
tsk->thread.bad_cause's setting into bad_area(). No functional change
intended.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/mm/fault.c | 77 +++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 36 deletions(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 460f785f6e09..0a8c9afeee22 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -85,6 +85,8 @@ static inline void mm_fault_error(struct pt_regs *regs, unsigned long addr, vm_f
 
 static inline void bad_area(struct pt_regs *regs, struct mm_struct *mm, int code, unsigned long addr)
 {
+	current->thread.bad_cause = regs->cause;
+
 	/*
 	 * Something tried to access memory that isn't in our memory map.
 	 * Fix it, but check if it's kernel or user first.
@@ -200,6 +202,38 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
 	return false;
 }
 
+#define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
+#define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
+
+static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
+				unsigned int mm_flags, struct pt_regs *regs)
+{
+	struct vm_area_struct *vma = find_vma(mm, addr);
+
+	if (unlikely(!vma))
+		return VM_FAULT_BADMAP;
+
+	if (unlikely(vma->vm_start > addr)) {
+		if (unlikely(!(vma->vm_flags & VM_GROWSDOWN) ||
+				expand_stack(vma, addr)))
+			return VM_FAULT_BADMAP;
+	}
+
+	/*
+	 * Ok, we have a good vm_area for this memory access, so
+	 * we can handle it.
+	 */
+	if (unlikely(access_error(regs->cause, vma)))
+		return VM_FAULT_BADACCESS;
+
+	/*
+	 * If for any reason at all we could not handle the fault,
+	 * make sure we exit gracefully rather than endlessly redo
+	 * the fault.
+	 */
+	return handle_mm_fault(vma, addr, mm_flags, regs);
+}
+
 /*
  * This routine handles page faults.  It determines the address and the
  * problem, and then passes it off to one of the appropriate routines.
@@ -207,7 +241,6 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
 asmlinkage void do_page_fault(struct pt_regs *regs)
 {
 	struct task_struct *tsk;
-	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 	unsigned long addr, cause;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
@@ -282,44 +315,16 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 		flags |= FAULT_FLAG_INSTRUCTION;
 retry:
 	mmap_read_lock(mm);
-	vma = find_vma(mm, addr);
-	if (unlikely(!vma)) {
-		tsk->thread.bad_cause = cause;
-		bad_area(regs, mm, code, addr);
-		return;
-	}
-	if (likely(vma->vm_start <= addr))
-		goto good_area;
-	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN))) {
-		tsk->thread.bad_cause = cause;
-		bad_area(regs, mm, code, addr);
-		return;
-	}
-	if (unlikely(expand_stack(vma, addr))) {
-		tsk->thread.bad_cause = cause;
-		bad_area(regs, mm, code, addr);
-		return;
-	}
 
-	/*
-	 * Ok, we have a good vm_area for this memory access, so
-	 * we can handle it.
-	 */
-good_area:
-	code = SEGV_ACCERR;
+	fault = __do_page_fault(mm, addr, flags, regs);
 
-	if (unlikely(access_error(cause, vma))) {
-		tsk->thread.bad_cause = cause;
-		bad_area(regs, mm, code, addr);
-		return;
-	}
+	if (unlikely(fault & VM_FAULT_BADMAP))
+		return bad_area(regs, mm, code, addr);
 
-	/*
-	 * If for any reason at all we could not handle the fault,
-	 * make sure we exit gracefully rather than endlessly redo
-	 * the fault.
-	 */
-	fault = handle_mm_fault(vma, addr, flags, regs);
+	if (unlikely(fault & VM_FAULT_BADACCESS)) {
+		code = SEGV_ACCERR;
+		return bad_area(regs, mm, code, addr);
+	}
 
 	/*
 	 * If we need to retry but a fatal signal is pending, handle the
-- 
2.39.2

