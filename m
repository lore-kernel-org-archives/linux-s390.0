Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233687;
	b=HUfEqXB2JIwS4m/hhCmfK3d78mhI2L718Q4/wgvrCB8W67vfguhtuN6IBCe3ATVEhCjC
	 yO9Z3b8h9UPYU+jWfcBAwEHv2715YYShdZn8/biYQLHpZh3723lRSMQLRLxTwvbFaMeMB
	 jDPbeNtd/yE1+qV/wn0BZJ0ArjHn0XgOFglqW/PjQgC5kKyLpmZPP8Fyp+mVKaghaXb0j
	 2TH8M22rwUybc5LSWdwjzf2k0d0Iyx8W9vS5Mi4ZMTzC8bH6SJ/hLqQuwgTSB4xf8vKG5
	 V0Bl7gdSyZmjbxyeAqdqIs0ssdAHXcAEs0sTkYfEyEU8ew/j0b2yt3/7NbUp+hpgFdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233687;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0NnuZXZ0EDkso7UKWFxA1UC22xPJ1cUbt0qhAl3H2pM=;
	b=un52pG2zfyuoB6EMwN45276d40XG3OMexc5TQ+u9Mq31eOTg8eIDied+tNz4g+sVMa/1
	 ex6uygy996dcJtYbLCLyiNL0Og7nP4RKI/snaToR/ZgHm0oa+ZUhejtV/yBudG0vE0Mu2
	 D1bvWIhYTCWNyx1ndbyMJJx17qQbWZSLQdDTRO0OuthIM70gzPKHgOzyM6188562NDYfw
	 otvFL70NR5dzChXCQrtDp7t1UGlGZ+Q+bzWBYgrugKji87UFuIVb6zdS7SO5B+QBgBQJD
	 4BewMUPrBASAxkFsqrsbb7RMPpjK56+I2bGNSZ+Mgo0BtQ+3EyDogqbs8LKDX6W9gVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z2zFGg5n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A505F606D83E;
	Mon,  9 Nov 2026 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z2zFGg5n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06B41F008A1;
	Mon,  9 Nov 2026 14:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794233686;
	bh=0NnuZXZ0EDkso7UKWFxA1UC22xPJ1cUbt0qhAl3H2pM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z2zFGg5nuA9/Gzs189f2IpYMO5j6cgYlurq5HLtd/RMXSFsS3b2glM7EktRik+9/5
	 mJ0eKKIU02VrdknWvUvX+mKT4cDENdjtT9TBNhBpKv5ucM/8m6cAKKL9lgnxjs/mck
	 UrfUNPnPz1gRNN3y+dFSn7rgjzfTYdMyvt1Sp7XbUpcFxmjEajj5F+f+1x0kqdmT2S
	 HW5HZ9MV4PB7Fz+ET5x0NYxa86B8EjQZ9CnagnchN1ccJiH83+rVDzKlMO1kvVk1Q/
	 Cs82z05jwXnYYoKJgIS8dtjleuTASrwLxhgTiWxLcfamwQDSsCLhFyeI2RzvO1XI/R
	 zQtN45ss9Sb2w==
From: Sasha Levin <sashal@kernel.org>
To: Nicolas Schier <nsc@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kbuild@vger.kernel.org,
	linux-s390@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"kernelci.org bot" <bot@kernelci.org>
Subject: [PATCH 2/2] devicetable-offsets: Get struct cpu_feature from a device-id header
Date: Mon,  9 Nov 2026 09:14:41 -0500
Message-ID: <f610c07f39df15f3e7ebdc63bfcd759ca7a687a8.1794233316.git.sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <66e4ee9c7f9b4bc48fcee92a94b6bb6d92fe1ad2.1794233316.git.sashal@kernel.org>
References: <cover.1792144769.git.u.kleine-koenig@baylibre.com> <179416565740.60865.16102443399828949110.b4-review@b4> <66e4ee9c7f9b4bc48fcee92a94b6bb6d92fe1ad2.1794233316.git.sashal@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit cdfdbc11552b ("Move struct cpu_feature to
<linux/cpufeature.h>"), devicetable-offsets.c includes
<linux/cpufeature.h>, which includes <asm/cpufeature.h> on architectures
that select GENERIC_CPU_AUTOPROBE. On loongarch and mips that header
pulls in <asm/elf.h>, and from there <linux/fs.h> and <linux/mmzone.h>,
which need <generated/bounds.h>. devicetable-offsets.c is built before
that header is generated, so even defconfig fails on both:

  include/linux/page-flags-layout.h:6:10: fatal error: generated/bounds.h: No such file or directory

Move struct cpu_feature to <linux/device-id/cpu_feature.h>, next to the
other device id types, and include that from <linux/cpufeature.h>,
devicetable-offsets.c and file2alias.c.

Reported-by: kernelci.org bot <bot@kernelci.org>
Closes: https://d.kernelci.org/i/maestro:7473c68181d97f248d2541b3b91d105111c36f97
Closes: https://d.kernelci.org/i/maestro:9b122468fe2be859df134b78bb35a907e6f99ba7
Fixes: cdfdbc11552b ("Move struct cpu_feature to <linux/cpufeature.h>")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/cpufeature.h            | 18 +-----------------
 include/linux/device-id/cpu_feature.h | 18 ++++++++++++++++++
 scripts/mod/devicetable-offsets.c     |  2 +-
 scripts/mod/file2alias.c              |  2 +-
 4 files changed, 21 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/device-id/cpu_feature.h

diff --git a/include/linux/cpufeature.h b/include/linux/cpufeature.h
index 7b22a536542d5..cd470987777f3 100644
--- a/include/linux/cpufeature.h
+++ b/include/linux/cpufeature.h
@@ -6,23 +6,7 @@
 #ifndef __LINUX_CPUFEATURE_H
 #define __LINUX_CPUFEATURE_H
 
-/*
- * This file is included by scripts/mod/file2alias.c which is compiled
- * using the host compiler which might not have <linux/types.h> but the
- * __u{8,16,32} types are defined there locally.
- */
-#ifdef __KERNEL__
-#include <linux/types.h>
-#endif
-
-/*
- * Generic table type for matching CPU features.
- * @feature:	the bit number of the feature (0 - 65535)
- */
-
-struct cpu_feature {
-	__u16	feature;
-};
+#include <linux/device-id/cpu_feature.h>
 
 #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
 
diff --git a/include/linux/device-id/cpu_feature.h b/include/linux/device-id/cpu_feature.h
new file mode 100644
index 0000000000000..937fbe00dcd55
--- /dev/null
+++ b/include/linux/device-id/cpu_feature.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LINUX_DEVICE_ID_CPU_FEATURE_H
+#define LINUX_DEVICE_ID_CPU_FEATURE_H
+
+#ifdef __KERNEL__
+#include <linux/types.h>
+#endif
+
+/*
+ * Generic table type for matching CPU features.
+ * @feature:	the bit number of the feature (0 - 65535)
+ */
+
+struct cpu_feature {
+	__u16	feature;
+};
+
+#endif /* ifndef LINUX_DEVICE_ID_CPU_FEATURE_H */
diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index 875eafeb743de..2b5217edf6389 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #define COMPILE_OFFSETS
-#include <linux/cpufeature.h>
 #include <linux/kbuild.h>
 
 #include <linux/device-id/acpi.h>
@@ -12,6 +11,7 @@
 #include <linux/device-id/ccw.h>
 #include <linux/device-id/cdx.h>
 #include <linux/device-id/coreboot.h>
+#include <linux/device-id/cpu_feature.h>
 #include <linux/device-id/css.h>
 #include <linux/device-id/dfl.h>
 #include <linux/device-id/dmi.h>
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index f848b39145d97..08b45e096c164 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -121,7 +121,6 @@ typedef struct {
 /* Big exception to the "don't include kernel headers into userspace, which
  * even potentially has different endianness and word sizes, since
  * we handle those differences explicitly below */
-#include "../../include/linux/cpufeature.h"
 #include "../../include/linux/device-id/acpi.h"
 #include "../../include/linux/device-id/amba.h"
 #include "../../include/linux/device-id/ap.h"
@@ -131,6 +130,7 @@ typedef struct {
 #include "../../include/linux/device-id/ccw.h"
 #include "../../include/linux/device-id/cdx.h"
 #include "../../include/linux/device-id/coreboot.h"
+#include "../../include/linux/device-id/cpu_feature.h"
 #include "../../include/linux/device-id/css.h"
 #include "../../include/linux/device-id/dfl.h"
 #include "../../include/linux/device-id/dmi.h"
-- 
2.53.0

