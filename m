From: Ursula Braun <ursula.braun@de.ibm.com>
Date: Mon, 01 Dec 2008 09:09:21 +0000
Subject: [patch 2/3] af_iucv: New error return codes for connect()
Message-Id: <20081201091056.605868000@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

If the iucv_path_connect() call fails then return an error code that
corresponds to the iucv_path_connect() failure condition; instead of
returning -ECONNREFUSED for any failure.

This helps to improve error handling for user space applications
(e.g.  inform the user that the z/VM guest is not authorized to
connect to other guest virtual machines).

The error return codes are based on those described in connect(2).

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
---

 net/iucv/af_iucv.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

Index: net-2.6-uschi/net/iucv/af_iucv.c
===================================================================
--- net-2.6-uschi.orig/net/iucv/af_iucv.c
+++ net-2.6-uschi/net/iucv/af_iucv.c
@@ -514,7 +514,21 @@ static int iucv_sock_connect(struct sock
 		iucv_path_free(iucv->path);
 		iucv->path = NULL;
 		debug_sprintf_event(afiucv_dbf, 6, "connect error %d\n", err);
-		err = -ECONNREFUSED;
+		switch (err) {
+		case 0x0b:	/* Target communicator is not logged on */
+			err = -ENETUNREACH;
+			break;
+		case 0x0d:	/* Max connections for this guest exceeded */
+		case 0x0e:	/* Max connections for target guest exceeded */
+			err = -EAGAIN;
+			break;
+		case 0x0f:	/* Missing IUCV authorization */
+			err = -EACCES;
+			break;
+		default:
+			err = -ECONNREFUSED;
+			break;
+		}
 		goto done;
 	}
 

-- 
