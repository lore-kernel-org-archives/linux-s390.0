Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Sun, 7 Oct 2018 18:35:11 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
Subject: [RFC PATCH net 3/3] uapi, net/smc: provide socket state constants in
 UAPI
Message-ID: <c79442704c63498b0d910f832ea8260faa53bebf.1538929504.git.esyr@redhat.com>
References: <cover.1538929504.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1538929504.git.esyr@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Hans Wippel <hwippel@linux.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

As socket state itself is already exposed via sock_diag interface.

Fixes: ac7138746e14 ("smc: establish new socket family")
Fixes: b38d732477e4 ("smc: socket closing and linkgroup cleanup")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 include/uapi/linux/smc_diag.h | 17 +++++++++++++++++
 net/smc/smc.h                 | 18 +-----------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/smc_diag.h b/include/uapi/linux/smc_diag.h
index 8cb3a6f..6798ec0 100644
--- a/include/uapi/linux/smc_diag.h
+++ b/include/uapi/linux/smc_diag.h
@@ -31,6 +31,23 @@ struct smc_diag_msg {
 	__aligned_u64	diag_inode;
 };
 
+enum smc_state {		/* possible states of an SMC socket */
+	SMC_ACTIVE	= 1,
+	SMC_INIT	= 2,
+	SMC_CLOSED	= 7,
+	SMC_LISTEN	= 10,
+	/* normal close */
+	SMC_PEERCLOSEWAIT1	= 20,
+	SMC_PEERCLOSEWAIT2	= 21,
+	SMC_APPFINCLOSEWAIT	= 24,
+	SMC_APPCLOSEWAIT1	= 22,
+	SMC_APPCLOSEWAIT2	= 23,
+	SMC_PEERFINCLOSEWAIT	= 25,
+	/* abnormal close */
+	SMC_PEERABORTWAIT	= 26,
+	SMC_PROCESSABORT	= 27,
+};
+
 /* Mode of a connection */
 enum {
 	SMC_DIAG_MODE_SMCR,
diff --git a/net/smc/smc.h b/net/smc/smc.h
index f5ff2ee..16bfd64 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -16,6 +16,7 @@
 #include <linux/compiler.h> /* __aligned */
 #include <net/sock.h>
 #include <linux/smc.h>
+#include <linux/smc_diag.h>
 
 #include "smc_ib.h"
 
@@ -26,23 +27,6 @@ extern struct proto smc_proto6;
 #define KERNEL_HAS_ATOMIC64
 #endif
 
-enum smc_state {		/* possible states of an SMC socket */
-	SMC_ACTIVE	= 1,
-	SMC_INIT	= 2,
-	SMC_CLOSED	= 7,
-	SMC_LISTEN	= 10,
-	/* normal close */
-	SMC_PEERCLOSEWAIT1	= 20,
-	SMC_PEERCLOSEWAIT2	= 21,
-	SMC_APPFINCLOSEWAIT	= 24,
-	SMC_APPCLOSEWAIT1	= 22,
-	SMC_APPCLOSEWAIT2	= 23,
-	SMC_PEERFINCLOSEWAIT	= 25,
-	/* abnormal close */
-	SMC_PEERABORTWAIT	= 26,
-	SMC_PROCESSABORT	= 27,
-};
-
 struct smc_link_group;
 
 struct smc_wr_rx_hdr {	/* common prefix part of LLC and CDC to demultiplex */
-- 
2.1.4
