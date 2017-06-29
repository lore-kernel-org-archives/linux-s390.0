From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Thu, 29 Jun 2017 19:24:43 +0000
Subject: [CRIU][PATCH v2 15/17] zdtm/static/sk-netlink: Fix endian issue
Message-Id: <20170629192445.55580-16-holzheu@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On x86 sk->groups[1] contains the most significant bits. On s390 it
contains the least significant bits. Therefore on x86 for groups below 32
sk->groups[1] is zero and on s390 it contains 0x80000000 for the testcase.

As workaround swap sk->groups[0/1] for big-endian systems.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 criu/sk-netlink.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/criu/sk-netlink.c b/criu/sk-netlink.c
index 44982a1..bfa6831 100644
--- a/criu/sk-netlink.c
+++ b/criu/sk-netlink.c
@@ -107,6 +107,22 @@ static int dump_one_netlink_fd(int lfd, u32 id, const struct fd_parms *p)
 		 * On 64-bit sk->gsize is multiple to 8 bytes (sizeof(long)),
 		 * so remove the last 4 bytes if they are empty.
 		 */
+#ifdef __ORDER_BIG_ENDIAN__
+		/*
+		 * Big endian swap: Ugly hack for zdtm/static/sk-netlink
+		 *
+		 * For big endian systems:
+		 *
+		 * - sk->groups[0] are bits 32-64
+		 * - sk->groups[1] are bits 0-32
+		 */
+		if (ne.n_groups == 2) {
+			uint32_t tmp = sk->groups[1];
+
+			sk->groups[1] = sk->groups[0];
+			sk->groups[0] = tmp;
+		}
+#endif
 		if (ne.n_groups && sk->groups[ne.n_groups - 1] == 0)
 			ne.n_groups -= 1;
 
-- 
2.7.4
