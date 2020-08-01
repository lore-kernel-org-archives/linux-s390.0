Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgHATqY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 1 Aug 2020 15:46:24 -0400
From: Peilin Ye <yepeilin.cs@gmail.com>
Subject: [Linux-kernel-mentees] [PATCH net] net/smc: Prevent kernel-infoleak in __smc_diag_dump()
Date: Sat,  1 Aug 2020 15:44:40 -0400
Message-Id: <20200801194440.246747-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>
Cc: Peilin Ye <yepeilin.cs@gmail.com>, Hans Wippel <hwippel@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org

__smc_diag_dump() is potentially copying uninitialized kernel stack memory
into socket buffers, since the compiler may leave a 4-byte hole near the
beginning of `struct smcd_diag_dmbinfo`. Fix it by initializing `dinfo`
with memset().

Cc: stable@vger.kernel.org
Fixes: 4b1b7d3b30a6 ("net/smc: add SMC-D diag support")
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
Reference: https://lwn.net/Articles/417989/

$ pahole -C "smcd_diag_dmbinfo" net/smc/smc_diag.o
struct smcd_diag_dmbinfo {
	__u32                      linkid;               /*     0     4 */

	/* XXX 4 bytes hole, try to pack */

	__u64                      peer_gid __attribute__((__aligned__(8))); /*     8     8 */
	__u64                      my_gid __attribute__((__aligned__(8))); /*    16     8 */
	__u64                      token __attribute__((__aligned__(8))); /*    24     8 */
	__u64                      peer_token __attribute__((__aligned__(8))); /*    32     8 */

	/* size: 40, cachelines: 1, members: 5 */
	/* sum members: 36, holes: 1, sum holes: 4 */
	/* forced alignments: 4, forced holes: 1, sum forced holes: 4 */
	/* last cacheline: 40 bytes */
} __attribute__((__aligned__(8)));
$ _

 net/smc/smc_diag.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index e1f64f4ba236..da9ba6d1679b 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -170,13 +170,15 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 	    (req->diag_ext & (1 << (SMC_DIAG_DMBINFO - 1))) &&
 	    !list_empty(&smc->conn.lgr->list)) {
 		struct smc_connection *conn = &smc->conn;
-		struct smcd_diag_dmbinfo dinfo = {
-			.linkid = *((u32 *)conn->lgr->id),
-			.peer_gid = conn->lgr->peer_gid,
-			.my_gid = conn->lgr->smcd->local_gid,
-			.token = conn->rmb_desc->token,
-			.peer_token = conn->peer_token
-		};
+		struct smcd_diag_dmbinfo dinfo;
+
+		memset(&dinfo, 0, sizeof(dinfo));
+
+		dinfo.linkid = *((u32 *)conn->lgr->id);
+		dinfo.peer_gid = conn->lgr->peer_gid;
+		dinfo.my_gid = conn->lgr->smcd->local_gid;
+		dinfo.token = conn->rmb_desc->token;
+		dinfo.peer_token = conn->peer_token;
 
 		if (nla_put(skb, SMC_DIAG_DMBINFO, sizeof(dinfo), &dinfo) < 0)
 			goto errout;
-- 
2.25.1
