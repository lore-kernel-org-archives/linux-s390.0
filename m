Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBFABA49;
	Sat, 14 Sep 2024 23:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726355581; cv=none; b=KLRDmbhX+qSSIXa515C+z3Rlo7s6g7PQNoe9hxtZjOos/+RxrRRuwZFsYwofqPslqokM8uwx6x3VKcfrLKexQoGH5n1X0h/HqUTPhiLDuB25ZP/iVS6a1Gld+QFlq8yBAJUpPmFjvlbY9tdpbZbnchVEZeoUShlkEKa+PJ73WSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726355581; c=relaxed/simple;
	bh=CEC7RN0B5w1xqsJTGdHiOY4tqCCfiGcaoCNmL8DPmKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PyT/vnMR3MXXIVK6sj4nGOj+G1ft8N9taHi7pT9ivWMmaE2bh+DXW6sAxSuti/vi+Js6GOYOIKLKuyzc2nkXKNcf2NzSHRXvF7LGvFc3IGXmpMPftVnSsrebyGw3xmSckL+5QxFd2VPkdQNL2abASvdAEd0f4BApazckElJqr4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=HJ03Jggc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HJ03Jggc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299A8C4CEC0;
	Sat, 14 Sep 2024 23:13:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="HJ03Jggc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1726355578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0ueAadqJ0a2VP4CG9KHXIr9pglWdZ+iXYjZUiUzCC0=;
	b=HJ03JggcwrXs/u9NMtUhmWC2pKJO7DM2k3nvEU92yL4huRT6A5dGQxzTwCrBdPHX8+uy75
	9hfrg9Ym/UXzFFWQLxw4427b7zM2movQxC7vM6uq48R1M+vHJwRdYSP+H3XEYWKwwYltDv
	fblEuxs7Zkqxcf/GjfqIGX01eFPYITk=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fc74ac9b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 14 Sep 2024 23:12:57 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	hca@linux.ibm.com
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] selftests: vDSO: check cpu caps before running chacha test
Date: Sun, 15 Sep 2024 01:11:32 +0200
Message-ID: <20240914231241.3647749-1-Jason@zx2c4.com>
In-Reply-To: <20240914174246.8394-A-hca@linux.ibm.com>
References: <20240914174246.8394-A-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some archs -- arm64 and s390x -- implemented chacha using instructions
that are available most places, but aren't always available. The kernel
handles this just fine, but the selftest does not. Check the hwcaps
before running, and skip the test if the cpu doesn't support it. As
well, on s390x, always emit the fallback instructions of an alternative
block, to ensure maximum compatibility.

Co-authored-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 tools/include/asm/alternative.h               | 10 ++++++++++
 .../testing/selftests/vDSO/vdso_test_chacha.c | 20 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/tools/include/asm/alternative.h b/tools/include/asm/alternative.h
index 7ce02a223732..8e548ac8f740 100644
--- a/tools/include/asm/alternative.h
+++ b/tools/include/asm/alternative.h
@@ -2,8 +2,18 @@
 #ifndef _TOOLS_ASM_ALTERNATIVE_ASM_H
 #define _TOOLS_ASM_ALTERNATIVE_ASM_H
 
+#if defined(__s390x__)
+#ifdef __ASSEMBLY__
+.macro ALTERNATIVE oldinstr, newinstr, feature
+	\oldinstr
+.endm
+#endif
+#else
+
 /* Just disable it so we can build arch/x86/lib/memcpy_64.S for perf bench: */
 
 #define ALTERNATIVE #
 
 #endif
+
+#endif
diff --git a/tools/testing/selftests/vDSO/vdso_test_chacha.c b/tools/testing/selftests/vDSO/vdso_test_chacha.c
index e81d72c9882e..b1ea532c5996 100644
--- a/tools/testing/selftests/vDSO/vdso_test_chacha.c
+++ b/tools/testing/selftests/vDSO/vdso_test_chacha.c
@@ -5,11 +5,29 @@
 
 #include <tools/le_byteshift.h>
 #include <sys/random.h>
+#include <sys/auxv.h>
 #include <string.h>
 #include <stdint.h>
 #include <stdbool.h>
 #include "../kselftest.h"
 
+#if defined(__aarch64__)
+static bool cpu_has_capabilities(void)
+{
+	return getauxval(AT_HWCAP) & HWCAP_ASIMD;
+}
+#elif defined(__s390x__)
+static bool cpu_has_capabilities(void)
+{
+	return getauxval(AT_HWCAP) & HWCAP_S390_VXRS;
+}
+#else
+static bool cpu_has_capabilities(void)
+{
+	return true;
+}
+#endif
+
 static uint32_t rol32(uint32_t word, unsigned int shift)
 {
 	return (word << (shift & 31)) | (word >> ((-shift) & 31));
@@ -67,6 +85,8 @@ int main(int argc, char *argv[])
 	uint8_t output1[BLOCK_SIZE * BLOCKS], output2[BLOCK_SIZE * BLOCKS];
 
 	ksft_print_header();
+	if (!cpu_has_capabilities())
+		ksft_exit_skip("Required CPU capabilities missing\n");
 	ksft_set_plan(1);
 
 	for (unsigned int trial = 0; trial < TRIALS; ++trial) {
-- 
2.46.0

