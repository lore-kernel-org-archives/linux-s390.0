Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0582DC6FD1D
	for <linux-s390@archiver.kernel.org>; Tue,  4 Apr 2023 10:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbjDDK0d (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 4 Apr 2023 06:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbjDDK01 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Apr 2023 06:26:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F4D3C1E
        for <linux-s390@vger.kernel.org>; Tue,  4 Apr 2023 03:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680603884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BW1HK9igOGgwKIWqcc3OoofMFA0ceQlTc5kcDELJdh8=;
        b=O5dEsJFU/MwU9bF5Bdm4W5cHLVwIH4y94Ydpn7+yihszH3jlSfLmkAMtGSMUM3ud8hvGtm
        fCkA4Li/RCjtytXrXmYoBabeG5GqadmG/4VUdwjdmaRSWX1/EtGv4M1SvWUw6Jilft50XQ
        2F+FDrzubTzPJDaBBn3IaxdlSIdZN8Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-T0ze6xBzMFePbBg9MkR63Q-1; Tue, 04 Apr 2023 06:24:41 -0400
X-MC-Unique: T0ze6xBzMFePbBg9MkR63Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A649B101A550;
        Tue,  4 Apr 2023 10:24:40 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83BE5140EBF4;
        Tue,  4 Apr 2023 10:24:39 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     kvm@vger.kernel.org, Nico Boehr <nrb@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: [kvm-unit-tests PATCH] s390x: Use the right constraints in intercept.c
Date:   Tue,  4 Apr 2023 12:24:37 +0200
Message-Id: <20230404102437.174404-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

stpx, spx, stap and stidp use addressing via "base register", i.e.
if register 0 is used, the base address will be 0, independent from
the value of the register. Thus we must not use the "r" constraint
here to avoid register 0. This fixes test failures when compiling
with Clang instead of GCC, since Clang apparently prefers to use
register 0 in some cases where GCC never uses register 0.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 s390x/intercept.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/s390x/intercept.c b/s390x/intercept.c
index 9e826b6c..faa74bbb 100644
--- a/s390x/intercept.c
+++ b/s390x/intercept.c
@@ -36,16 +36,16 @@ static void test_stpx(void)
 
 	expect_pgm_int();
 	low_prot_enable();
-	asm volatile(" stpx 0(%0) " : : "r"(8));
+	asm volatile(" stpx 0(%0) " : : "a"(8));
 	low_prot_disable();
 	check_pgm_int_code(PGM_INT_CODE_PROTECTION);
 
 	expect_pgm_int();
-	asm volatile(" stpx 0(%0) " : : "r"(1));
+	asm volatile(" stpx 0(%0) " : : "a"(1));
 	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
 
 	expect_pgm_int();
-	asm volatile(" stpx 0(%0) " : : "r"(-8L));
+	asm volatile(" stpx 0(%0) " : : "a"(-8L));
 	check_pgm_int_code(PGM_INT_CODE_ADDRESSING);
 }
 
@@ -70,13 +70,13 @@ static void test_spx(void)
 
 	report_prefix_push("operand not word aligned");
 	expect_pgm_int();
-	asm volatile(" spx 0(%0) " : : "r"(1));
+	asm volatile(" spx 0(%0) " : : "a"(1));
 	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
 	report_prefix_pop();
 
 	report_prefix_push("operand outside memory");
 	expect_pgm_int();
-	asm volatile(" spx 0(%0) " : : "r"(-8L));
+	asm volatile(" spx 0(%0) " : : "a"(-8L));
 	check_pgm_int_code(PGM_INT_CODE_ADDRESSING);
 	report_prefix_pop();
 
@@ -113,16 +113,16 @@ static void test_stap(void)
 
 	expect_pgm_int();
 	low_prot_enable();
-	asm volatile ("stap 0(%0)\n" : : "r"(8));
+	asm volatile ("stap 0(%0)\n" : : "a"(8));
 	low_prot_disable();
 	check_pgm_int_code(PGM_INT_CODE_PROTECTION);
 
 	expect_pgm_int();
-	asm volatile ("stap 0(%0)\n" : : "r"(1));
+	asm volatile ("stap 0(%0)\n" : : "a"(1));
 	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
 
 	expect_pgm_int();
-	asm volatile ("stap 0(%0)\n" : : "r"(-8L));
+	asm volatile ("stap 0(%0)\n" : : "a"(-8L));
 	check_pgm_int_code(PGM_INT_CODE_ADDRESSING);
 }
 
@@ -138,16 +138,16 @@ static void test_stidp(void)
 
 	expect_pgm_int();
 	low_prot_enable();
-	asm volatile ("stidp 0(%0)\n" : : "r"(8));
+	asm volatile ("stidp 0(%0)\n" : : "a"(8));
 	low_prot_disable();
 	check_pgm_int_code(PGM_INT_CODE_PROTECTION);
 
 	expect_pgm_int();
-	asm volatile ("stidp 0(%0)\n" : : "r"(1));
+	asm volatile ("stidp 0(%0)\n" : : "a"(1));
 	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
 
 	expect_pgm_int();
-	asm volatile ("stidp 0(%0)\n" : : "r"(-8L));
+	asm volatile ("stidp 0(%0)\n" : : "a"(-8L));
 	check_pgm_int_code(PGM_INT_CODE_ADDRESSING);
 }
 
-- 
2.31.1

