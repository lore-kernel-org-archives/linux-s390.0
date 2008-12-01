From: Ursula Braun <ursula.braun@de.ibm.com>
Date: Mon, 01 Dec 2008 09:09:22 +0000
Subject: [patch 3/3] afiucv: avoid left over IUCV connections from failing connects
Message-Id: <20081201091057.290850000@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

For certain types of AFIUCV socket connect failures IUCV connections
are left over. Add some cleanup-statements to avoid cluttered IUCV
connections.

Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
---

 net/iucv/af_iucv.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: net-2.6-uschi/net/iucv/af_iucv.c
===================================================================
--- net-2.6-uschi.orig/net/iucv/af_iucv.c
+++ net-2.6-uschi/net/iucv/af_iucv.c
@@ -540,6 +540,13 @@ static int iucv_sock_connect(struct sock
 	if (sk->sk_state == IUCV_DISCONN) {
 		err = -ECONNREFUSED;
 	}
+
+	if (err) {
+		iucv_path_sever(iucv->path, NULL);
+		iucv_path_free(iucv->path);
+		iucv->path = NULL;
+	}
+
 done:
 	release_sock(sk);
 	debug_sprintf_event(afiucv_dbf, 6, "connect - end, error %d\n", err);

-- 
