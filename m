Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731602AbfLKPOO (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Dec 2019 10:14:14 -0500
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 130/134] s390: disable preemption when switching to nodat stack with CALL_ON_STACK
Date: Wed, 11 Dec 2019 10:11:46 -0500
Message-Id: <20191211151150.19073-130-sashal@kernel.org>
In-Reply-To: <20191211151150.19073-1-sashal@kernel.org>
References: <20191211151150.19073-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 7f28dad395243c5026d649136823bbc40029a828 ]

Make sure preemption is disabled when temporary switching to nodat
stack with CALL_ON_STACK helper, because nodat stack is per cpu.

Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/machine_kexec.c |  2 ++
 arch/s390/mm/maccess.c           | 12 +++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
index 444a19125a815..dcaadceaf6efc 100644
--- a/arch/s390/kernel/machine_kexec.c
+++ b/arch/s390/kernel/machine_kexec.c
@@ -164,7 +164,9 @@ static bool kdump_csum_valid(struct kimage *image)
 #ifdef CONFIG_CRASH_DUMP
 	int rc;
 
+	preempt_disable();
 	rc = CALL_ON_STACK(do_start_kdump, S390_lowcore.nodat_stack, 1, image);
+	preempt_enable();
 	return rc == 0;
 #else
 	return false;
diff --git a/arch/s390/mm/maccess.c b/arch/s390/mm/maccess.c
index 1864a8bb9622f..88d5fcf67a2f1 100644
--- a/arch/s390/mm/maccess.c
+++ b/arch/s390/mm/maccess.c
@@ -115,9 +115,15 @@ static unsigned long _memcpy_real(unsigned long dest, unsigned long src,
  */
 int memcpy_real(void *dest, void *src, size_t count)
 {
-	if (S390_lowcore.nodat_stack != 0)
-		return CALL_ON_STACK(_memcpy_real, S390_lowcore.nodat_stack,
-				     3, dest, src, count);
+	int rc;
+
+	if (S390_lowcore.nodat_stack != 0) {
+		preempt_disable();
+		rc = CALL_ON_STACK(_memcpy_real, S390_lowcore.nodat_stack, 3,
+				   dest, src, count);
+		preempt_enable();
+		return rc;
+	}
 	/*
 	 * This is a really early memcpy_real call, the stacks are
 	 * not set up yet. Just call _memcpy_real on the early boot
-- 
2.20.1
