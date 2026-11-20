Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795206441;
	b=5ExFDnUO/4/Fl3eHuUqWNOiIWUoQFmM69EQBxoYKt8zGMP2tG/rtZlQbc18vk+JWMhfE
	 mDW7xqSY63lvshxyJoHpwvstouAGjFtuO5hNnJvIe5315HYcREu9aYWh1oJqJRzjQAMQo
	 tDRlcuY5SURrxbTQ81GKNvAgKdNLRju4v/bklhTGlIo4aJzJ87hZuvORCJUisHetMqCgr
	 h7lP0W3ePA62wH+TEYMeMwf93KfTBr9mD530QRaSkt0mIe3AnzoS8a6x8b33QxSSxI4nN
	 z9Rh7ltVg9xwN7kENlNzOQ+VpX44YYgG0BZKkJCJPT3ADr3kD4PPn8hHGafG1z0vZqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795206441;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WqSlxQyh/dRBNidv695WpWTljoCnNVjA21ZydepqoMA=;
	b=di8FUR0lRjT+ZHrFkYrAtmbLU2uAxxtq5aDy2Ll8aNCJgwoB3qnvZayAX2aF88XqZVqz
	 OSW3IsQlilAK5XUkCE/uJYPjCPxvbS6ChIocJ/XEjCry6AYN7XDT0Hmb/iBC2ck2xtN6k
	 l5L1VTEBaB0ip61Wh/l8dnpXhYlbNCHvcryKOhVjdVwwS6A5RIy1moI5pHmOMmSaLkZSx
	 pe0B+kSQeXFFqOUmh12N9ESuIn+yfI7MBz8acPLZFB0wjEot6H3pSLd1D3lQ2GxnaEH2G
	 wnx5zdzwHK3fS31ZGrdEwXbAqfs7XFte/lko2y2kXTZhZN6IBV62aHgDqeYlS/Iqgug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAh0JewX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 859A6606A334;
	Fri, 20 Nov 2026 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAh0JewX
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 482A51F0093C;
	Fri, 20 Nov 2026 20:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795206440;
	bh=WqSlxQyh/dRBNidv695WpWTljoCnNVjA21ZydepqoMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aAh0JewXcORIykTJumZLPOgBhpU1O1hlpDrce6ow61FXnF/Whwv+JbEvYmfeAxVLt
	 v6rAqCv5Omd54azLHfA9A9qlfwC2DRIAUFmsNvPSd7uRg2nqMCUtg+94d610TpC10p
	 D3DrDk81X3mmt4wyu9EL6fPHJZs+l5fYufbCZ05kABLisAkfOM1xcVVxYUG9yvCM6/
	 iB1FXeQQgb5NIrwC7n+wq13jtreBzqEt3D+0MEkHW1mfrZWGgIjXECzPAZrxR+A4/Q
	 35jrfBasep83+NQWsREqh2dh7YkvFSaUt2n4dftk9h7bUxxGCgQVaSApJzOK4uxtmL
	 BDZsEikzLY0qQ==
From: Nicolas Schier <nsc@kernel.org>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>,
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
	"kernelci.org bot" <bot@kernelci.org>,
	Nicolas Schier <n.schier@fritz.com>
Subject: [PATCH] Move struct cpu_feature to a <linux/device-id/cpu_feature.h>
Date: Fri, 20 Nov 2026 21:27:11 +0100
Message-ID: <20261120202712.3377691-1-nsc@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <awCruYkI2TkxJfPC@levanger>
References: <awCruYkI2TkxJfPC@levanger>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Nicolas Schier <n.schier@fritz.com>

struct cpu_feature used to be defined in <linux/mod_devicetable.h>. Move
it to <linux/device-id/cpu_feature.h> to let users of mod_devicetable.h
that only need struct cpu_feature switch to the new include file, and
to reduce the number of users of mod_devicetable.h.

While moving struct cpu_feature to <linux/cpufeature.h> instead sounds
reasonable, it would break defconfig on loongarch and mips [1].

Link: https://lore.kernel.org/r/f610c07f39df15f3e7ebdc63bfcd759ca7a687a8.1794233316.git.sashal@kernel.org # [1]
Original-patch-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Original-patch-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Nicolas Schier <n.schier@fritz.com>
---
This patch is a combination of [1] and [2]; both patches have been
merged to prevent failures during bisecting.

Acked-by, Reported-by and Closes tags have been dropped due to the
rewrite.

Thanks to Uwe and Sasha!

[2]: https://patch.msgid.link/bc9fbf5784f6788e10c749a05d56c42bdb68f3d9.1792144769.git.u.kleine-koenig@baylibre.com
---
 arch/loongarch/kvm/main.c             |  2 +-
 include/linux/cpufeature.h            |  3 ++-
 include/linux/device-id/cpu_feature.h | 23 +++++++++++++++++++++++
 include/linux/mod_devicetable.h       | 14 +-------------
 4 files changed, 27 insertions(+), 15 deletions(-)
 create mode 100644 include/linux/device-id/cpu_feature.h

diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index c65ae2fa4c4b..fb3dc8237499 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -5,7 +5,7 @@
 
 #include <linux/err.h>
 #include <linux/module.h>
-#include <linux/mod_devicetable.h>
+#include <linux/device-id/cpu_feature.h>
 #include <linux/kvm_host.h>
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
diff --git a/include/linux/cpufeature.h b/include/linux/cpufeature.h
index 6aff540ee9e5..cd470987777f 100644
--- a/include/linux/cpufeature.h
+++ b/include/linux/cpufeature.h
@@ -6,10 +6,11 @@
 #ifndef __LINUX_CPUFEATURE_H
 #define __LINUX_CPUFEATURE_H
 
+#include <linux/device-id/cpu_feature.h>
+
 #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
 
 #include <linux/init.h>
-#include <linux/mod_devicetable.h>
 #include <asm/cpufeature.h>
 
 /*
diff --git a/include/linux/device-id/cpu_feature.h b/include/linux/device-id/cpu_feature.h
new file mode 100644
index 000000000000..e14fe8bba85a
--- /dev/null
+++ b/include/linux/device-id/cpu_feature.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LINUX_DEVICE_ID_CPU_FEATURE_H
+#define LINUX_DEVICE_ID_CPU_FEATURE_H
+
+/*
+ * This file is included by scripts/mod/file2alias.c which is compiled
+ * using the host compiler which might not have <linux/types.h> but the
+ * __u{8,16,32} types are defined there locally.
+ */
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
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index d1581bb64729..a69947f2c1dc 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -8,10 +8,6 @@
 #ifndef LINUX_MOD_DEVICETABLE_H
 #define LINUX_MOD_DEVICETABLE_H
 
-#ifdef __KERNEL__
-#include <linux/types.h>
-#endif
-
 #include "device-id/acpi.h"
 #include "device-id/amba.h"
 #include "device-id/ap.h"
@@ -21,6 +17,7 @@
 #include "device-id/ccw.h"
 #include "device-id/cdx.h"
 #include "device-id/coreboot.h"
+#include "device-id/cpu_feature.h"
 #include "device-id/css.h"
 #include "device-id/dfl.h"
 #include "device-id/dmi.h"
@@ -69,13 +66,4 @@
 #include "device-id/x86_cpu.h"
 #include "device-id/zorro.h"
 
-/*
- * Generic table type for matching CPU features.
- * @feature:	the bit number of the feature (0 - 65535)
- */
-
-struct cpu_feature {
-	__u16	feature;
-};
-
 #endif /* LINUX_MOD_DEVICETABLE_H */
-- 
2.47.3

