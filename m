From: Swen Schillig <swen@vnet.ibm.com>
Date: Tue, 28 Aug 2007 07:30:14 +0000
Subject: [PATCH 2/10] zfcp: allocate gid_pn_data objects from gid_pn_cache.
Message-Id: <200708280930.15300.swen@vnet.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Allocate gid_pn_data objects from the corresponding cache which ensures
proper alignment.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Swen Schillig <swen@vnet.ibm.com>
---

 drivers/s390/scsi/zfcp_aux.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/drivers/s390/scsi/zfcp_aux.c linux-2.6-patched/drivers/s390/scsi/zfcp_aux.c
--- linux-2.6/drivers/s390/scsi/zfcp_aux.c	2007-08-27 13:21:50.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_aux.c	2007-08-27 13:22:18.000000000 +0200
@@ -1503,7 +1503,7 @@ zfcp_gid_pn_buffers_alloc(struct zfcp_gi
 			data->ct.pool = pool;
 		}
 	} else {
-		data = kmalloc(sizeof(struct zfcp_gid_pn_data), GFP_ATOMIC);
+		data = kmem_cache_alloc(zfcp_data.gid_pn_cache, GFP_ATOMIC);
 	}
 
         if (NULL == data)
@@ -1531,7 +1531,7 @@ static void zfcp_gid_pn_buffers_free(str
 	if (gid_pn->ct.pool)
 		mempool_free(gid_pn, gid_pn->ct.pool);
 	else
-		kfree(gid_pn);
+		kmem_cache_free(zfcp_data.gid_pn_cache, gid_pn);
 }
 
 /**
