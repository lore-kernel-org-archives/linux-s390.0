From: Christof Schmitt <christof.schmitt@de.ibm.com>
Subject: [patch 05/13] zfcp: Use unchained mode for small ct and els requests
Date: Mon, 13 Jul 2009 15:06:06 +0200
Message-ID: <20090713131043.315770000@de.ibm.com>
References: <20090713130601.304914000@de.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline; filename=710-zfcp-unchained-mode.diff
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Christof Schmitt <christof.schmitt@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christof Schmitt <christof.schmitt@de.ibm.com>

The ELS ADISC and the GID_PN requests sent from zfcp fit into
unchained FSF requests. Change the FSF allocation logic to use
unchained requests whenever possible where everything fits in one
SBAL. This avoids acquiring more SBALs than necessary, especially
during zfcp recovery when things might be stalled.

Reviewed-by: Swen Schillig <swen@vnet.ibm.com>
Signed-off-by: Christof Schmitt <christof.schmitt@de.ibm.com>
---

 drivers/s390/scsi/zfcp_fsf.c |   33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

--- a/drivers/s390/scsi/zfcp_fsf.c	2009-07-13 13:17:49.000000000 +0200
+++ b/drivers/s390/scsi/zfcp_fsf.c	2009-07-13 13:17:55.000000000 +0200
@@ -1010,6 +1010,23 @@ skip_fsfstatus:
 		send_ct->handler(send_ct->handler_data);
 }
 
+static void zfcp_fsf_setup_ct_els_unchained(struct qdio_buffer_element *sbale,
+					    struct scatterlist *sg_req,
+					    struct scatterlist *sg_resp)
+{
+	sbale[0].flags |= SBAL_FLAGS0_TYPE_WRITE_READ;
+	sbale[2].addr   = sg_virt(sg_req);
+	sbale[2].length = sg_req->length;
+	sbale[3].addr   = sg_virt(sg_resp);
+	sbale[3].length = sg_resp->length;
+	sbale[3].flags |= SBAL_FLAGS_LAST_ENTRY;
+}
+
+static int zfcp_fsf_one_sbal(struct scatterlist *sg)
+{
+	return sg_is_last(sg) && sg->length <= PAGE_SIZE;
+}
+
 static int zfcp_fsf_setup_ct_els_sbals(struct zfcp_fsf_req *req,
 				       struct scatterlist *sg_req,
 				       struct scatterlist *sg_resp,
@@ -1020,16 +1037,16 @@ static int zfcp_fsf_setup_ct_els_sbals(s
 	int bytes;
 
 	if (!(feat & FSF_FEATURE_ELS_CT_CHAINED_SBALS)) {
-		if (sg_req->length > PAGE_SIZE || sg_resp->length > PAGE_SIZE ||
-		    !sg_is_last(sg_req) || !sg_is_last(sg_resp))
+		if (!zfcp_fsf_one_sbal(sg_req) || !zfcp_fsf_one_sbal(sg_resp))
 			return -EOPNOTSUPP;
 
-		sbale[0].flags |= SBAL_FLAGS0_TYPE_WRITE_READ;
-		sbale[2].addr   = sg_virt(sg_req);
-		sbale[2].length = sg_req->length;
-		sbale[3].addr   = sg_virt(sg_resp);
-		sbale[3].length = sg_resp->length;
-		sbale[3].flags |= SBAL_FLAGS_LAST_ENTRY;
+		zfcp_fsf_setup_ct_els_unchained(sbale, sg_req, sg_resp);
+		return 0;
+	}
+
+	/* use single, unchained SBAL if it can hold the request */
+	if (zfcp_fsf_one_sbal(sg_req) && zfcp_fsf_one_sbal(sg_resp)) {
+		zfcp_fsf_setup_ct_els_unchained(sbale, sg_req, sg_resp);
 		return 0;
 	}
 
