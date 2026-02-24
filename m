Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280F7368285
	for <linux-s390@vger.kernel.org>; Tue, 24 Feb 2026 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924980; cv=none; b=NDorkYEKKvSqKvnReP3VWM4NwoMUH7RdvdMAQ3bK+unvixUpgNNXyi5B4HwGl6jyAE2eZQUIsSZukma+DfPe/h17dXUdYJHc9Gt6ad6hCg8Yk3HrwjsnAWreKoBnsgymjtzLMobbGa58W4wKLl+hlGfaCEJfowSyO7acbTU3ma8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924980; c=relaxed/simple;
	bh=iA1WwvmzDS5SoQjU9t8h48yCceGfEAvtxk1RGs93S9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwBM5PXzDj/fDRxaagxhrON0btB3gHRPub8FdIgYaS+hDrjHjgsXWAytdo5Y3NVhk7hPEoJvcHQ38N6U6wA3vMnFe/tTwSC7oTs1uOpNE3KAn719xDJv/mtnonbak0dczlEhVOL9KzQNalzml8N++kvOUTFMiAsCR2asrQOSYFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3Q+bRJe; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3Q+bRJe"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a9296b3926so36925245ad.1
        for <linux-s390@vger.kernel.org>; Tue, 24 Feb 2026 01:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771924977; x=1772529777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFREYxUIZ0cRYQkkmQ4UIO9hPNsMXbWBqRtIGvrYot8=;
        b=M3Q+bRJeWaj0x3+ELxz0mmwsIgrZSIyKDp3CPZQkS6PKcbBoP4u7diwN484pTO9SuS
         TrcXwuBHo/YGE2mk4OQrTRqLnS+WZcZLhGjN5D9+U2Ouoa5TUHaG6cBROiXSiw6FVC7m
         30PiTLVv2U4Rom+9AU0T/R1q9QwLCfBi1c7WSzUUMtApDFscRoXjoztuZY0hQ6eZBnIb
         op4m7i0t8O5RiJi3vHJinhgvGUGiN8ZYQXTYcMYcoU7++ARvxr4hTM1Je8HJzPHOkED2
         0Klcr75LCGdFpmA4jZfmNWcVMFD3noji7LRiIizXCDzp+ang6hdly66ipTcdLPSakO7p
         QOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771924977; x=1772529777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dFREYxUIZ0cRYQkkmQ4UIO9hPNsMXbWBqRtIGvrYot8=;
        b=ZzM0ujfU8jc308eDU708CjbqRbTuSMnFQSXoxWDSK4VyRhgvlaZwomRSLilEsSiDHK
         2bfyTvDktaSvYcEsSLWvsRoMt7vNw1WsofwCMnqMzjzu0eCVRbU57w6chEjDFrEpYhwY
         DJIWC3oSJwa+tpaEYgGzxupyxR075du+46p3+w5sUc2dCX42kjO6NtIqXkL2gkxByE6o
         x10XLG5RHmgWmch22dn3GNMH7sHTUSdUD6yb6qy6s4bjMLuEASFLb9EkM+RwDmTjqDCc
         VclzKfak7WlYWDJeur6cXD/yLn/NUfLvBovVnOYuiysLZmd/wjiB0Lb5hGqhRpdQ1kMr
         L0dw==
X-Forwarded-Encrypted: i=1; AJvYcCXLHdO3oK9/3c0/pSakpSJR19y7qyUNjpMLa06FXdQj/5R2AqarENXM3yujaxaMmEIP7CCYFdCZ2n8/@vger.kernel.org
X-Gm-Message-State: AOJu0YwsWtM8TBozgHpgOqYJL58fFrycrWiNWULmxnfKVyc40UElZ0+6
	jZCAOiu1/oCbm3cF5xj4/2xv8fIZOdpvhCYe6hLEpes3uXc5/dG4+Ea5
X-Gm-Gg: ATEYQzzeifwZIjkjm3LBV8+/VrDCCxY5BZl877zY5Ri77HiyIXBke/LCnVI2v8THp6t
	CyPyVho60fjz+TXcf/GzVNfIehDq8FZF/kDqXM9I2WvihmXAFQDRLELM77ptAVSDovJE/Lg4b/9
	ifZLmarfIIqGwas0/E2prD3LjiRAOCPoQPq0L5fQxTWgg8a9cQN212IlFEOMZ5PtqRh6KJ3tvy2
	KszEDF1V4KYMkQ9LNVIGXv4F2k3B+HRrKGNWXA0d5WVAFzIePxaAha4/S6lgH9dRUjXsLKYVMM0
	YxtxynR2bIL5j4QcxUQmgcgQR+hDgGKIb326HDHozEYB7RgefPSuKUcbugYvxXGecwEH+rNN4bS
	Jid2YhIjZvWtNFFPv9XzgEAwqezoCjS1KVSBGZzllp+twJisALR6QyEka/pVfYU4p9Ed8/TFhlc
	49/zgiD7OiWP/72sePGR3F
X-Received: by 2002:a17:902:ce81:b0:2aa:d287:6943 with SMTP id d9443c01a7336-2ad744353e0mr95407575ad.16.1771924977473;
        Tue, 24 Feb 2026 01:22:57 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7500e2b2sm97181695ad.52.2026.02.24.01.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 01:22:56 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	iii@linux.ibm.com
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	bpf@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: factor out get_func_* tests for fsession
Date: Tue, 24 Feb 2026 17:22:08 +0800
Message-ID: <20260224092208.1395085-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224092208.1395085-1-dongml2@chinatelecom.cn>
References: <20260224092208.1395085-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fsession is already supported by x86_64, arm64, riscv and s390, so we
don't need to disable it in the compile time according to the
architecture. Factor out the testings for it. Therefore, the testing can
be disabled for the architecture that doesn't support it manually.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../bpf/prog_tests/get_func_args_test.c       | 25 +++++++++++-
 .../bpf/prog_tests/get_func_ip_test.c         | 28 +++++++++++++-
 .../bpf/progs/get_func_args_fsession_test.c   | 37 ++++++++++++++++++
 .../selftests/bpf/progs/get_func_args_test.c  | 38 -------------------
 .../bpf/progs/get_func_ip_fsession_test.c     | 21 ++++++++++
 .../selftests/bpf/progs/get_func_ip_test.c    | 23 -----------
 6 files changed, 108 insertions(+), 64 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/get_func_args_fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/get_func_ip_fsession_test.c

diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
index 96b27de05524..7bf8adc41e99 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 #include "get_func_args_test.skel.h"
+#include "get_func_args_fsession_test.skel.h"
 
 void test_get_func_args_test(void)
 {
@@ -41,8 +42,30 @@ void test_get_func_args_test(void)
 	ASSERT_EQ(skel->bss->test4_result, 1, "test4_result");
 	ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
 	ASSERT_EQ(skel->bss->test6_result, 1, "test6_result");
-	ASSERT_EQ(skel->bss->test7_result, 1, "test7_result");
 
 cleanup:
 	get_func_args_test__destroy(skel);
 }
+
+void test_get_func_args_fsession_test(void)
+{
+	struct get_func_args_fsession_test *skel = NULL;
+	int err;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = get_func_args_fsession_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "get_func_args_fsession_test__open_and_load"))
+		return;
+
+	err = get_func_args_fsession_test__attach(skel);
+	if (!ASSERT_OK(err, "get_func_args_fsession_test__attach"))
+		goto cleanup;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test1), &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
+	ASSERT_EQ(skel->bss->test1_result, 1, "test1_result");
+cleanup:
+	get_func_args_fsession_test__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
index 7772a0f288d3..357fdedfea93 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
@@ -2,6 +2,7 @@
 #include <test_progs.h>
 #include "get_func_ip_test.skel.h"
 #include "get_func_ip_uprobe_test.skel.h"
+#include "get_func_ip_fsession_test.skel.h"
 
 static noinline void uprobe_trigger(void)
 {
@@ -46,8 +47,6 @@ static void test_function_entry(void)
 	ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
 	ASSERT_EQ(skel->bss->test7_result, 1, "test7_result");
 	ASSERT_EQ(skel->bss->test8_result, 1, "test8_result");
-	ASSERT_EQ(skel->bss->test9_entry_result, 1, "test9_entry_result");
-	ASSERT_EQ(skel->bss->test9_exit_result, 1, "test9_exit_result");
 
 cleanup:
 	get_func_ip_test__destroy(skel);
@@ -139,3 +138,28 @@ void test_get_func_ip_test(void)
 	test_function_entry();
 	test_function_body();
 }
+
+void test_get_func_ip_fsession_test(void)
+{
+	struct get_func_ip_fsession_test *skel = NULL;
+	int err;
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel = get_func_ip_fsession_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "get_func_ip_fsession_test__open_and_load"))
+		return;
+
+	err = get_func_ip_fsession_test__attach(skel);
+	if (!ASSERT_OK(err, "get_func_ip_fsession_test__attach"))
+		goto cleanup;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test1), &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
+	ASSERT_EQ(skel->bss->test1_entry_result, 1, "test1_entry_result");
+	ASSERT_EQ(skel->bss->test1_exit_result, 1, "test1_exit_result");
+
+cleanup:
+	get_func_ip_fsession_test__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/get_func_args_fsession_test.c b/tools/testing/selftests/bpf/progs/get_func_args_fsession_test.c
new file mode 100644
index 000000000000..bb597f24b659
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/get_func_args_fsession_test.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <errno.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 test1_result = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test1)
+{
+	__u64 cnt = bpf_get_func_arg_cnt(ctx);
+	__u64 a = 0, z = 0, ret = 0;
+	__s64 err;
+
+	test1_result = cnt == 1;
+
+	/* valid arguments */
+	err = bpf_get_func_arg(ctx, 0, &a);
+	test1_result &= err == 0 && ((int) a == 1);
+
+	/* not valid argument */
+	err = bpf_get_func_arg(ctx, 1, &z);
+	test1_result &= err == -EINVAL;
+
+	if (bpf_session_is_return(ctx)) {
+		err = bpf_get_func_ret(ctx, &ret);
+		test1_result &= err == 0 && ret == 2;
+	} else {
+		err = bpf_get_func_ret(ctx, &ret);
+		test1_result &= err == 0 && ret == 0;
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/get_func_args_test.c b/tools/testing/selftests/bpf/progs/get_func_args_test.c
index 075a1180ec26..1bf47f64d096 100644
--- a/tools/testing/selftests/bpf/progs/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_args_test.c
@@ -165,41 +165,3 @@ int BPF_PROG(tp_test2)
 
 	return 0;
 }
-
-__u64 test7_result = 0;
-#if defined(bpf_target_x86) || defined(bpf_target_arm64) || defined(bpf_target_riscv)
-SEC("fsession/bpf_fentry_test1")
-int BPF_PROG(test7)
-{
-	__u64 cnt = bpf_get_func_arg_cnt(ctx);
-	__u64 a = 0, z = 0, ret = 0;
-	__s64 err;
-
-	test7_result = cnt == 1;
-
-	/* valid arguments */
-	err = bpf_get_func_arg(ctx, 0, &a);
-	test7_result &= err == 0 && ((int) a == 1);
-
-	/* not valid argument */
-	err = bpf_get_func_arg(ctx, 1, &z);
-	test7_result &= err == -EINVAL;
-
-	if (bpf_session_is_return(ctx)) {
-		err = bpf_get_func_ret(ctx, &ret);
-		test7_result &= err == 0 && ret == 2;
-	} else {
-		err = bpf_get_func_ret(ctx, &ret);
-		test7_result &= err == 0 && ret == 0;
-	}
-
-	return 0;
-}
-#else
-SEC("fentry/bpf_fentry_test1")
-int BPF_PROG(test7)
-{
-	test7_result = 1;
-	return 0;
-}
-#endif
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_fsession_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_fsession_test.c
new file mode 100644
index 000000000000..bbeea0d512e3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_fsession_test.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 test1_entry_result = 0;
+__u64 test1_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test1, int a)
+{
+	__u64 addr = bpf_get_func_ip(ctx);
+
+	if (bpf_session_is_return(ctx))
+		test1_exit_result = (const void *) addr == &bpf_fentry_test1;
+	else
+		test1_entry_result = (const void *) addr == &bpf_fentry_test1;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index 45eaa54d1ac7..2011cacdeb18 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -103,26 +103,3 @@ int BPF_URETPROBE(test8, int ret)
 	test8_result = (const void *) addr == (const void *) uprobe_trigger;
 	return 0;
 }
-
-__u64 test9_entry_result = 0;
-__u64 test9_exit_result = 0;
-#if defined(bpf_target_x86) || defined(bpf_target_arm64) || defined(bpf_target_riscv)
-SEC("fsession/bpf_fentry_test1")
-int BPF_PROG(test9, int a)
-{
-	__u64 addr = bpf_get_func_ip(ctx);
-
-	if (bpf_session_is_return(ctx))
-		test9_exit_result = (const void *) addr == &bpf_fentry_test1;
-	else
-		test9_entry_result = (const void *) addr == &bpf_fentry_test1;
-	return 0;
-}
-#else
-SEC("fentry/bpf_fentry_test1")
-int BPF_PROG(test9, int a)
-{
-	test9_entry_result = test9_exit_result = 1;
-	return 0;
-}
-#endif
-- 
2.53.0

