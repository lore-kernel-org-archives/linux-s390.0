Return-Path: <netdev-owner@vger.kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 1/1] net/smc: remove unneeded include for smc.h
Date: Tue, 29 Oct 2019 12:43:46 +0100
Message-Id: <20191029114346.73418-1-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, gor@linux.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com, jakub.kicinski@netronome.com

The only smc-related reference in net/sock.h is struct smc_hashinfo.
But just its address is refered to. Thus there is no need for the
include of net/smc.h. Remove it.

Suggested-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 include/net/sock.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 380312cc67a9..09c26a5ecbff 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -66,7 +66,6 @@
 #include <net/checksum.h>
 #include <net/tcp_states.h>
 #include <linux/net_tstamp.h>
-#include <net/smc.h>
 #include <net/l3mdev.h>
 
 /*
-- 
2.17.1
