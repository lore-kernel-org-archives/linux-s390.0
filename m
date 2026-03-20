Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D9E399343;
	Fri, 20 Mar 2026 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774003283; cv=none; b=Hlb78+F31eXZJQij+wGg4zBaVpaRuSgoI7Nf60P+gZfbXt/D72klXtkfxNUrgu+U5l09yaPCUvW+Uf28wMABbZp/Z8t+MCaz4UUFDo2vCVpUEWpeOyVEiyRi6uSQ3nSh5sKS/NWMCig3Yi44Mz+JJEMSKLVF6i+W3h91e76Jorc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774003283; c=relaxed/simple;
	bh=MScY+gmT9rsuqnKns4y6+tv93ikZ6jKfqFztH3XxhI0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQlg18Eb8wtkFuaFm6Do+bSDVDJ7aM+ha73k6JPLF/xa1c6Lk5lh6Uw9DBkj03x+cIY2nEu1BSl5uHb/048Svuzdde/xVsaz9m+AirCIERoDuWBL/OB44pjPO8ZW5cgYYJ1XO91v65qMlh7Zf/dJdRID9lrwjVQf64gFkeYYtj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=OIhmm4cV; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="OIhmm4cV"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6ReFRWMNlcAIzygaQHDIHcvAfK0/APpypoLdcs/3JIQ=;
	b=OIhmm4cVECm6pCD5T5U4YorHv8ATbzN2X3DExx/zGE49puRUxFGQHuCiFEhiLBDnRJgAMdyyQ
	gmfoc0kiaRUXurBARvkaKdu6r42BwjnKaK00xZbNWyceytpd07ZhygecRBEmLKKKYI7U0HWs4jG
	4ZEquaKeLcZY35DezR59zIA=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fcf8h5fdKzLlTD;
	Fri, 20 Mar 2026 18:35:16 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 889FE40565;
	Fri, 20 Mar 2026 18:41:18 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 20 Mar
 2026 18:41:16 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <chenhuacai@kernel.org>,
	<kernel@xen0n.name>, <hca@linux.ibm.com>, <gor@linux.ibm.com>,
	<agordeev@linux.ibm.com>, <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
	<oleg@redhat.com>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <arnd@arndb.de>,
	<shuah@kernel.org>, <kevin.brodsky@arm.com>, <ruanjinjie@huawei.com>,
	<yeoreum.yun@arm.com>, <anshuman.khandual@arm.com>, <thuth@redhat.com>,
	<ryan.roberts@arm.com>, <mark.rutland@arm.com>, <song@kernel.org>,
	<ziyao@disroot.org>, <linusw@kernel.org>,
	<schuster.simon@siemens-energy.com>, <jremus@linux.ibm.com>,
	<akpm@linux-foundation.org>, <mathieu.desnoyers@efficios.com>,
	<kmal@cock.li>, <dvyukov@google.com>, <reddybalavignesh9979@gmail.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-s390@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH v14 4/4] selftests: sud_test: Support aarch64
Date: Fri, 20 Mar 2026 18:42:22 +0800
Message-ID: <20260320104222.1381274-5-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320104222.1381274-1-ruanjinjie@huawei.com>
References: <20260320104222.1381274-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)

From: kemal <kmal@cock.li>

Support aarch64 to test "Syscall User Dispatch" feature with
sud_test selftest testcase.

On qemu-kvm machine, the sud_benchmark test results are as below:

	# ./sud_benchmark
	Calibrating test set to last ~5 seconds...
	test iterations = 24500000
	Avg syscall time 208ns.
	Enabling syscall trapping.
	Caught sys_1c2
	trapped_call_count 1, native_call_count 0.
	Avg syscall time 213ns.
	Interception overhead: 2.5% (+5ns).

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: kemal <kmal@cock.li>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c | 2 +-
 tools/testing/selftests/syscall_user_dispatch/sud_test.c      | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c b/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
index 073a03702ff5..6059abe75cb3 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
@@ -41,7 +41,7 @@
  * out of the box, but don't enable them until they support syscall user
  * dispatch.
  */
-#if defined(__x86_64__) || defined(__i386__)
+#if defined(__x86_64__) || defined(__i386__) || defined(__aarch64__)
 #define TEST_BLOCKED_RETURN
 #endif
 
diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
index b855c6000287..3ffea2f4a66d 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -192,6 +192,10 @@ static void handle_sigsys(int sig, siginfo_t *info, void *ucontext)
 	((ucontext_t *)ucontext)->uc_mcontext.__gregs[REG_A0] =
 			((ucontext_t *)ucontext)->uc_mcontext.__gregs[REG_A7];
 #endif
+#ifdef __aarch64__
+	((ucontext_t *)ucontext)->uc_mcontext.regs[0] = (unsigned int)
+			((ucontext_t *)ucontext)->uc_mcontext.regs[8];
+#endif
 }
 
 int setup_sigsys_handler(void)
-- 
2.34.1

