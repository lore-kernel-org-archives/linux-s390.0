From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 1/2] net: fix AF_SMC related typo
Date: Thu, 12 Jan 2017 14:57:14 +0100
Message-ID: <20170112135715.64242-2-ubraun@linux.vnet.ibm.com>
References: <20170112135715.64242-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170112135715.64242-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

When introducing the new socket family AF_SMC in
commit ac7138746e14 ("smc: establish new socket family"),
a typo in af_family_clock_key_strings has slipped in.
This patch repairs it.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Fixes: ac7138746e14 ("smc: establish new socket family")
Reported-by: Andrew Morton <akpm@linux-foundation.org>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index dbbdc4f..8b35debf 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -256,7 +256,7 @@ static const char *const af_family_clock_key_strings[AF_MAX+1] = {
   "clock-AF_RXRPC" , "clock-AF_ISDN"     , "clock-AF_PHONET"   ,
   "clock-AF_IEEE802154", "clock-AF_CAIF" , "clock-AF_ALG"      ,
   "clock-AF_NFC"   , "clock-AF_VSOCK"    , "clock-AF_KCM"      ,
-  "clock-AF_QIPCRTR", "closck-AF_smc"    , "clock-AF_MAX"
+  "clock-AF_QIPCRTR", "clock-AF_SMC"     , "clock-AF_MAX"
 };
 
 /*
-- 
2.8.4
