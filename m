Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299E7C77B78
	for <linux-s390@archiver.kernel.org>; Sat, 22 Apr 2023 21:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjDVVET (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 22 Apr 2023 17:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjDVVEP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 22 Apr 2023 17:04:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F860173B
        for <linux-s390@vger.kernel.org>; Sat, 22 Apr 2023 14:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682197411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/CVWL6KZbwiyfGCJe2ZhJdYm/T0Tfz0MO2xrMQw1s4A=;
        b=AqGzissetMk5D2uhbRDxKmsL5ULqsrdjHJGF1lTcB92C8VpHx2+cPOLM2naWjGSCKAIvig
        rktt23yJ03PiKZHv46fO5S2N+CPtbVpfphwUz65fbQL1EZTN6vDxASA5M8eJ1I2QzUAmSX
        5yKJsKYMWPt2nv/XcEsRU0X6xQSyWRE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-546-1Vn2ezJ4Ofek4Z8PatTQEA-1; Sat, 22 Apr 2023 17:02:09 -0400
X-MC-Unique: 1Vn2ezJ4Ofek4Z8PatTQEA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 915FB85A5B1;
        Sat, 22 Apr 2023 21:02:08 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CFA2A2023163;
        Sat, 22 Apr 2023 21:01:58 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefan Roesch <shr@devkernel.io>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH mm-stable v2 3/3] mm/ksm: move disabling KSM from s390/gmap code to KSM code
Date:   Sat, 22 Apr 2023 23:01:56 +0200
Message-Id: <20230422210156.33630-1-david@redhat.com>
In-Reply-To: <20230422205420.30372-1-david@redhat.com>
References: <20230422205420.30372-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Let's factor out actual disabling of KSM. The existing
"mm->def_flags &= ~VM_MERGEABLE;" was essentially a NOP and can be dropped,
because def_flags should never include VM_MERGEABLE. Note that we don't
currently prevent re-enabling KSM.

This should now be faster in case KSM was never enabled, because we only
conditionally iterate all VMAs. Further, it certainly looks cleaner.

Acked-by: Janosch Frank <frankja@linux.ibm.com>
Acked-by: Stefan Roesch <shr@devkernel.io>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/gmap.c | 20 +-------------------
 include/linux/ksm.h |  6 ++++++
 mm/ksm.c            | 11 +++++++++++
 3 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 0949811761e6..dfe905c7bd8e 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2585,30 +2585,12 @@ EXPORT_SYMBOL_GPL(s390_enable_sie);
 
 int gmap_mark_unmergeable(void)
 {
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	unsigned long vm_flags;
-	int ret;
-	VMA_ITERATOR(vmi, mm, 0);
-
 	/*
 	 * Make sure to disable KSM (if enabled for the whole process or
 	 * individual VMAs). Note that nothing currently hinders user space
 	 * from re-enabling it.
 	 */
-	clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
-
-	for_each_vma(vmi, vma) {
-		/* Copy vm_flags to avoid partial modifications in ksm_madvise */
-		vm_flags = vma->vm_flags;
-		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
-				  MADV_UNMERGEABLE, &vm_flags);
-		if (ret)
-			return ret;
-		vm_flags_reset(vma, vm_flags);
-	}
-	mm->def_flags &= ~VM_MERGEABLE;
-	return 0;
+	return ksm_disable(current->mm);
 }
 EXPORT_SYMBOL_GPL(gmap_mark_unmergeable);
 
diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 429efa6ff4ae..899a314bc487 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -22,6 +22,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 void ksm_add_vma(struct vm_area_struct *vma);
 int ksm_enable_merge_any(struct mm_struct *mm);
 int ksm_disable_merge_any(struct mm_struct *mm);
+int ksm_disable(struct mm_struct *mm);
 
 int __ksm_enter(struct mm_struct *mm);
 void __ksm_exit(struct mm_struct *mm);
@@ -80,6 +81,11 @@ static inline void ksm_add_vma(struct vm_area_struct *vma)
 {
 }
 
+static inline int ksm_disable(struct mm_struct *mm)
+{
+	return 0;
+}
+
 static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
 	return 0;
diff --git a/mm/ksm.c b/mm/ksm.c
index 823bb3475a68..0156bded3a66 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2628,6 +2628,17 @@ int ksm_disable_merge_any(struct mm_struct *mm)
 	return 0;
 }
 
+int ksm_disable(struct mm_struct *mm)
+{
+	mmap_assert_write_locked(mm);
+
+	if (!test_bit(MMF_VM_MERGEABLE, &mm->flags))
+		return 0;
+	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
+		return ksm_disable_merge_any(mm);
+	return ksm_del_vmas(mm);
+}
+
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, unsigned long *vm_flags)
 {
-- 
2.40.0

