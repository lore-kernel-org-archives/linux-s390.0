From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net 1/3] s390/netiucv: get rid of one memcpy in netiucv_printuser
Date: Wed, 12 Oct 2016 12:38:49 +0200
Message-ID: <fc9696091325573020c1417c9d4ed010108f2172.1476263985.git.ursula.braun@de.ibm.com>
References: <cover.1476263985.git.ursula.braun@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <cover.1476263985.git.ursula.braun@de.ibm.com>
In-Reply-To: <cover.1476263985.git.ursula.braun@de.ibm.com>
References: <cover.1476263985.git.ursula.braun@de.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Save a memcpy in netiucv_printuser().

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Reported-by: David Binderman <dcb314@hotmail.com>
---
 drivers/s390/net/netiucv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/net/netiucv.c b/drivers/s390/net/netiucv.c
index b0e8ffd..88b6e9c 100644
--- a/drivers/s390/net/netiucv.c
+++ b/drivers/s390/net/netiucv.c
@@ -302,8 +302,7 @@ static char *netiucv_printuser(struct iucv_connection *conn)
 	if (memcmp(conn->userdata, iucvMagic_ebcdic, 16)) {
 		tmp_uid[8] = '\0';
 		tmp_udat[16] = '\0';
-		memcpy(tmp_uid, conn->userid, 8);
-		memcpy(tmp_uid, netiucv_printname(tmp_uid, 8), 8);
+		memcpy(tmp_uid, netiucv_printname(conn->userid, 8), 8);
 		memcpy(tmp_udat, conn->userdata, 16);
 		EBCASC(tmp_udat, 16);
 		memcpy(tmp_udat, netiucv_printname(tmp_udat, 16), 16);
-- 
2.8.4
