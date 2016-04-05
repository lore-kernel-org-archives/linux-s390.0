From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 10/25] arm64: rename COMPAT to AARCH32_EL0 in Kconfig
Date: Wed, 6 Apr 2016 01:08:32 +0300
Message-ID: <1459894127-17698-11-git-send-email-ynorov@caviumnetworks.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ynorov@caviumnetworks.com, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, Nathan_Lynch@mentor.com, agraf@suse.de, klimov.linux@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Andrew Pinski <apinski@cavium.com>, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
List-ID: <linux-s390.vger.kernel.org>

From: Andrew Pinski <apinski@cavium.com>

In this patchset  ILP32 ABI support is added. Additionally to AARCH32,
which is binary-compatible with ARM, ILP32 is (mostly) ABI-compatible.

From now, AARCH32_EL0 (former COMPAT) config option means the support of
AARCH32 userspace, ARM64_ILP32 - support of ILP32 ABI (see next patches),
and COMPAT indicates that one of them, or both, is enabled.

Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Reviewed-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/arm64/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4f43622..f923687 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -925,6 +925,10 @@ menu "Userspace binary formats"
 source "fs/Kconfig.binfmt"
 
 config COMPAT
+	def_bool y
+	depends on AARCH32_EL0
+
+config AARCH32_EL0
 	bool "Kernel support for 32-bit EL0"
 	depends on ARM64_4K_PAGES || EXPERT
 	select COMPAT_BINFMT_ELF
-- 
2.5.0
