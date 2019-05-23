Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Mathieu Malaterre <malat@debian.org>
Subject: [PATCH] powerpc/power: Expose pfn_is_nosave prototype
Date: Thu, 23 May 2019 13:47:36 +0200
Message-Id: <20190523114736.30268-1-malat@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

The declaration for pfn_is_nosave is only available in
kernel/power/power.h. Since this function can be override in arch,
expose it globally. Having a prototype will make sure to avoid warning
(sometime treated as error with W=1) such as:

  arch/powerpc/kernel/suspend.c:18:5: error: no previous prototype for 'pfn_is_nosave' [-Werror=missing-prototypes]

This moves the declaration into a globally visible header file and add
missing include to avoid a warning in powerpc.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/suspend.c | 1 +
 include/linux/suspend.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/suspend.c b/arch/powerpc/kernel/suspend.c
index a531154cc0f3..9e1b6b894245 100644
--- a/arch/powerpc/kernel/suspend.c
+++ b/arch/powerpc/kernel/suspend.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/suspend.h>
 #include <asm/page.h>
 #include <asm/sections.h>
 
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 3f529ad9a9d2..2660bbdf5230 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -395,6 +395,7 @@ extern bool system_entering_hibernation(void);
 extern bool hibernation_available(void);
 asmlinkage int swsusp_save(void);
 extern struct pbe *restore_pblist;
+int pfn_is_nosave(unsigned long pfn);
 #else /* CONFIG_HIBERNATION */
 static inline void register_nosave_region(unsigned long b, unsigned long e) {}
 static inline void register_nosave_region_late(unsigned long b, unsigned long e) {}
-- 
2.20.1
