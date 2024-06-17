Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51B11B010D;
	Mon, 17 Jun 2024 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631829; cv=none; b=Y3HQsT3X5z37UbQ7rzUFXsiJlTrm7nxQ/DjeYmHGDu78KDKGYV0NZGNMn/gJsY48idYB4KHJ/hygv41BkX/cJNmwRZ8/S0lfSq79fpNba23XEk0Q/Wv9jTdszmxXYZsaUcvEBPuYXYhu/ZOQ0aFBHgSbRx6vG1TtERznT0gr4Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631829; c=relaxed/simple;
	bh=JMXBprBeRODOlE2SRHNAbkZsK7FOxhmKNe4tTfTgEFo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rJX/zsYyyDLQBvM5DvIMjpFnvuvTQa4w5qxsZJMay1pN94m5pgtMOhojGMBb0++oMfkukkhW6GqwPQjbFEVxVtb9GHPquKOCHOqU5KlAKQ2FAmhyRp59jvoH4AAd6MjLWZC4n61q6OPswEsMGfaW4fsCX/zh6IoLInh2zSq6lNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W2rb91jzhzxRtT;
	Mon, 17 Jun 2024 21:39:33 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C31814011B;
	Mon, 17 Jun 2024 21:43:43 +0800 (CST)
Received: from huawei.com (10.67.174.76) by dggpemd100004.china.huawei.com
 (7.185.36.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 17 Jun
 2024 21:43:42 +0800
From: Yuntao Liu <liuyuntao12@huawei.com>
To: <x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <hca@linux.ibm.com>,
	<gor@linux.ibm.com>, <agordeev@linux.ibm.com>, <borntraeger@linux.ibm.com>,
	<svens@linux.ibm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<kees@kernel.org>, <gustavoars@kernel.org>, <arnd@arndb.de>,
	<leobras@redhat.com>, <broonie@kernel.org>, <mark.rutland@arm.com>,
	<imbrenda@linux.ibm.com>, <pawan.kumar.gupta@linux.intel.com>,
	<liuyuntao12@huawei.com>
Subject: [PATCH] remove AND operation in choose_random_kstack_offset()
Date: Mon, 17 Jun 2024 13:37:21 +0000
Message-ID: <20240617133721.377540-1-liuyuntao12@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemd100004.china.huawei.com (7.185.36.20)

Since the offset would be bitwise ANDed with 0x3FF in
add_random_kstack_offset(), so just remove AND operation here.

Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
---
 arch/arm64/kernel/syscall.c          | 2 +-
 arch/s390/include/asm/entry-common.h | 2 +-
 arch/x86/include/asm/entry-common.h  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index ad198262b981..43f555f7cd2d 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -63,7 +63,7 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 	 *
 	 * The resulting 5 bits of entropy is seen in SP[8:4].
 	 */
-	choose_random_kstack_offset(get_random_u16() & 0x1FF);
+	choose_random_kstack_offset(get_random_u16());
 }
 
 static inline bool has_syscall_work(unsigned long flags)
diff --git a/arch/s390/include/asm/entry-common.h b/arch/s390/include/asm/entry-common.h
index 7f5004065e8a..35555c944630 100644
--- a/arch/s390/include/asm/entry-common.h
+++ b/arch/s390/include/asm/entry-common.h
@@ -54,7 +54,7 @@ static __always_inline void arch_exit_to_user_mode(void)
 static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 						  unsigned long ti_work)
 {
-	choose_random_kstack_offset(get_tod_clock_fast() & 0xff);
+	choose_random_kstack_offset(get_tod_clock_fast());
 }
 
 #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 7e523bb3d2d3..b28a307f2014 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -85,7 +85,7 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 	 * Therefore, final stack offset entropy will be 5 (x86_64) or
 	 * 6 (ia32) bits.
 	 */
-	choose_random_kstack_offset(rdtsc() & 0xFF);
+	choose_random_kstack_offset(rdtsc());
 }
 #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
 
-- 
2.34.1

