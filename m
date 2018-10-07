Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Sun, 7 Oct 2018 18:35:02 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
Subject: [RFC PATCH net 1/3] uapi, net/smc: move protocol constant
 definitions to UAPI
Message-ID: <adaa2e4d22f78b36c8d84bdd97c9c3c582eb4dc6.1538929504.git.esyr@redhat.com>
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

SMCPROTO_* constants are expected to be used by userspace[1],
but they were defined in a private header instead.

[1] http://manpages.ubuntu.com/manpages/cosmic/man7/af_smc.7.html

Fixes: ac7138746e14 ("smc: establish new socket family")
Fixes: aaa4d33f6da1 ("net/smc: enable ipv6 support for smc")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 include/uapi/linux/smc.h | 7 ++++++-
 net/smc/smc.h            | 4 +---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/smc.h b/include/uapi/linux/smc.h
index 0e11ca4..10561f8 100644
--- a/include/uapi/linux/smc.h
+++ b/include/uapi/linux/smc.h
@@ -2,7 +2,8 @@
 /*
  *  Shared Memory Communications over RDMA (SMC-R) and RoCE
  *
- *  Definitions for generic netlink based configuration of an SMC-R PNET table
+ *  Definitions for SMC protocol and generic netlink based configuration
+ *  of an SMC-R PNET table
  *
  *  Copyright IBM Corp. 2016
  *
@@ -12,6 +13,10 @@
 #ifndef _UAPI_LINUX_SMC_H_
 #define _UAPI_LINUX_SMC_H_
 
+/* AF_SMC socket protocols */
+#define SMCPROTO_SMC		0	/* SMC protocol, IPv4 */
+#define SMCPROTO_SMC6		1	/* SMC protocol, IPv6 */
+
 /* Netlink SMC_PNETID attributes */
 enum {
 	SMC_PNETID_UNSPEC,
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 08786ac..f5ff2ee 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -15,12 +15,10 @@
 #include <linux/types.h>
 #include <linux/compiler.h> /* __aligned */
 #include <net/sock.h>
+#include <linux/smc.h>
 
 #include "smc_ib.h"
 
-#define SMCPROTO_SMC		0	/* SMC protocol, IPv4 */
-#define SMCPROTO_SMC6		1	/* SMC protocol, IPv6 */
-
 extern struct proto smc_proto;
 extern struct proto smc_proto6;
 
-- 
2.1.4
