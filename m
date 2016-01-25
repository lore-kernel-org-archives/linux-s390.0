From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 5/5] all: introduce COMPAT_WRAPPER option and enable it for s390
Date: Mon, 25 Jan 2016 19:57:27 +0300
Message-ID: <1453741047-5498-6-git-send-email-ynorov@caviumnetworks.com>
References: <1453741047-5498-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <1453741047-5498-1-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: arnd@arndb.de, catalin.marinas@arm.com, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Prasun.Kapoor@caviumnetworks.com, pinskia@gmail.com, agraf@suse.de, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, Nathan_Lynch@mentor.com, klimov.linux@gmail.com, Yury Norov <ynorov@caviumnetworks.com>
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/Kconfig      | 4 ++++
 arch/s390/Kconfig | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 4e949e5..ab7692e 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -518,6 +518,10 @@ config HAVE_COPY_THREAD_TLS
 	  normal C parameter passing, rather than extracting the syscall
 	  argument from pt_regs.
 
+config COMPAT_WRAPPER
+	bool
+	depends on COMPAT
+
 #
 # ABI hall of shame
 #
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 3a55f49..88f48b0 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -336,6 +336,7 @@ config COMPAT
 	select COMPAT_BINFMT_ELF if BINFMT_ELF
 	select ARCH_WANT_OLD_COMPAT_IPC
 	select COMPAT_OLD_SIGACTION
+	select COMPAT_WRAPPER
 	depends on MULTIUSER
 	help
 	  Select this option if you want to enable your system kernel to
-- 
2.5.0
