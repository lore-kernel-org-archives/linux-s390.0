Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Steffen Maier <maier@linux.vnet.ibm.com>
Subject: [PATCH] docs-rst: fix broken links to dynamic-debug-howto in kernel-parameters
Date: Wed, 14 Jun 2017 12:24:12 +0200
Message-Id: <20170614102412.82379-1-maier@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jason Baron <jbaron@akamai.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Steffen Maier <maier@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Another place in lib/Kconfig.debug was already fixed in commit f8998c226587
("lib/Kconfig.debug: correct documentation paths").

Fixes: 9d85025b0418 ("docs-rst: create an user's manual book")
Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index facc20a3f962..774569e02959 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -721,7 +721,8 @@
 			See also Documentation/input/joystick-parport.txt
 
 	ddebug_query=   [KNL,DYNAMIC_DEBUG] Enable debug messages at early boot
-			time. See Documentation/dynamic-debug-howto.txt for
+			time. See
+			Documentation/admin-guide/dynamic-debug-howto.rst for
 			details.  Deprecated, see dyndbg.
 
 	debug		[KNL] Enable kernel debugging (events log level).
@@ -875,7 +876,8 @@
 	dyndbg[="val"]		[KNL,DYNAMIC_DEBUG]
 	module.dyndbg[="val"]
 			Enable debug messages at boot time.  See
-			Documentation/dynamic-debug-howto.txt for details.
+			Documentation/admin-guide/dynamic-debug-howto.rst
+			for details.
 
 	nompx		[X86] Disables Intel Memory Protection Extensions.
 			See Documentation/x86/intel_mpx.txt for more
-- 
2.11.2
