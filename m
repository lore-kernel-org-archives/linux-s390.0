From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH V6 net-next 1/2] net: introduce socket family constants
Date: Mon, 14 Sep 2015 12:42:45 +0200
Message-ID: <1442227366-79236-2-git-send-email-ubraun@linux.vnet.ibm.com>
References: <1442227366-79236-1-git-send-email-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1442227366-79236-1-git-send-email-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: utz.bacher@de.ibm.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ursula.braun@de.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

The new socket family is assigned the next available address / protocol
family constant 41.

Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
---
 include/linux/socket.h |  4 +++-
 include/net/smc.h      | 12 ++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)
 create mode 100644 include/net/smc.h

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 5bf59c8..1adcbcc 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -200,7 +200,8 @@ struct ucred {
 #define AF_ALG		38	/* Algorithm sockets		*/
 #define AF_NFC		39	/* NFC sockets			*/
 #define AF_VSOCK	40	/* vSockets			*/
-#define AF_MAX		41	/* For now.. */
+#define AF_SMC		41	/* smc sockets			*/
+#define AF_MAX		42	/* For now.. */
 
 /* Protocol families, same as address families. */
 #define PF_UNSPEC	AF_UNSPEC
@@ -246,6 +247,7 @@ struct ucred {
 #define PF_ALG		AF_ALG
 #define PF_NFC		AF_NFC
 #define PF_VSOCK	AF_VSOCK
+#define PF_SMC		AF_SMC
 #define PF_MAX		AF_MAX
 
 /* Maximum queue length specifiable by listen.  */
diff --git a/include/net/smc.h b/include/net/smc.h
new file mode 100644
index 0000000..68cdaae
--- /dev/null
+++ b/include/net/smc.h
@@ -0,0 +1,12 @@
+/*
+ * SMC		Definitions for the SMC protocol.
+ *
+ * Author:	Ursula Braun <ursula.braun@de.ibm.com>
+ */
+#ifndef _SMC_H
+#define _SMC_H
+
+/* SMC socket options - disjunct with TCP socket options */
+#define SMC_KEEPALIVE		99	/* start/stop keepalives */
+
+#endif /* _SMC_H */
-- 
2.3.8
