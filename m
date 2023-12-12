Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8AACF;
	Tue, 12 Dec 2023 00:52:39 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VyLq2zW_1702371156;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VyLq2zW_1702371156)
          by smtp.aliyun-inc.com;
          Tue, 12 Dec 2023 16:52:37 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wintera@linux.ibm.com,
	wenjia@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kgraul@linux.ibm.com,
	jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	raspl@linux.ibm.com,
	schnelle@linux.ibm.com,
	guangguan.wang@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	lzinux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 02/10] net/smc: introduce sub-functions for smc_clc_send_confirm_accept()
Date: Tue, 12 Dec 2023 16:52:23 +0800
Message-Id: <1702371151-125258-3-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702371151-125258-1-git-send-email-guwen@linux.alibaba.com>
References: <1702371151-125258-1-git-send-email-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

There is a large if-else block in smc_clc_send_confirm_accept() and it
is better to split it into two sub-functions.

Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_clc.c | 197 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 115 insertions(+), 82 deletions(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 0fcb035..1a230d8 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -998,6 +998,112 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 	return reason_code;
 }
 
+static void
+smcd_clc_prep_confirm_accept(struct smc_connection *conn,
+			     struct smc_clc_msg_accept_confirm_v2 *clc_v2,
+			     int first_contact, u8 version,
+			     u8 *eid, struct smc_init_info *ini,
+			     int *fce_len,
+			     struct smc_clc_first_contact_ext_v2x *fce_v2x,
+			     struct smc_clc_msg_trail *trl)
+{
+	struct smcd_dev *smcd = conn->lgr->smcd;
+	struct smc_clc_msg_accept_confirm *clc;
+	int len;
+
+	/* SMC-D specific settings */
+	clc = (struct smc_clc_msg_accept_confirm *)clc_v2;
+	memcpy(clc->hdr.eyecatcher, SMCD_EYECATCHER,
+	       sizeof(SMCD_EYECATCHER));
+	clc->hdr.typev1 = SMC_TYPE_D;
+	clc->d0.gid = htonll(smcd->ops->get_local_gid(smcd));
+	clc->d0.token = htonll(conn->rmb_desc->token);
+	clc->d0.dmbe_size = conn->rmbe_size_comp;
+	clc->d0.dmbe_idx = 0;
+	memcpy(&clc->d0.linkid, conn->lgr->id, SMC_LGR_ID_SIZE);
+	if (version == SMC_V1) {
+		clc->hdr.length = htons(SMCD_CLC_ACCEPT_CONFIRM_LEN);
+	} else {
+		clc_v2->d1.chid = htons(smc_ism_get_chid(smcd));
+		if (eid && eid[0])
+			memcpy(clc_v2->d1.eid, eid, SMC_MAX_EID_LEN);
+		len = SMCD_CLC_ACCEPT_CONFIRM_LEN_V2;
+		if (first_contact) {
+			*fce_len = smc_clc_fill_fce_v2x(fce_v2x, ini);
+			len += *fce_len;
+		}
+		clc_v2->hdr.length = htons(len);
+	}
+	memcpy(trl->eyecatcher, SMCD_EYECATCHER,
+	       sizeof(SMCD_EYECATCHER));
+}
+
+static void
+smcr_clc_prep_confirm_accept(struct smc_connection *conn,
+			     struct smc_clc_msg_accept_confirm_v2 *clc_v2,
+			     int first_contact, u8 version,
+			     u8 *eid, struct smc_init_info *ini,
+			     int *fce_len,
+			     struct smc_clc_first_contact_ext_v2x *fce_v2x,
+			     struct smc_clc_fce_gid_ext *gle,
+			     struct smc_clc_msg_trail *trl)
+{
+	struct smc_clc_msg_accept_confirm *clc;
+	struct smc_link *link = conn->lnk;
+	int len;
+
+	/* SMC-R specific settings */
+	clc = (struct smc_clc_msg_accept_confirm *)clc_v2;
+	memcpy(clc->hdr.eyecatcher, SMC_EYECATCHER,
+	       sizeof(SMC_EYECATCHER));
+	clc->hdr.typev1 = SMC_TYPE_R;
+	memcpy(clc->r0.lcl.id_for_peer, local_systemid,
+	       sizeof(local_systemid));
+	memcpy(&clc->r0.lcl.gid, link->gid, SMC_GID_SIZE);
+	memcpy(&clc->r0.lcl.mac, &link->smcibdev->mac[link->ibport - 1],
+	       ETH_ALEN);
+	hton24(clc->r0.qpn, link->roce_qp->qp_num);
+	clc->r0.rmb_rkey =
+		htonl(conn->rmb_desc->mr[link->link_idx]->rkey);
+	clc->r0.rmbe_idx = 1; /* for now: 1 RMB = 1 RMBE */
+	clc->r0.rmbe_alert_token = htonl(conn->alert_token_local);
+	switch (clc->hdr.type) {
+	case SMC_CLC_ACCEPT:
+		clc->r0.qp_mtu = link->path_mtu;
+		break;
+	case SMC_CLC_CONFIRM:
+		clc->r0.qp_mtu = min(link->path_mtu, link->peer_mtu);
+		break;
+	}
+	clc->r0.rmbe_size = conn->rmbe_size_comp;
+	clc->r0.rmb_dma_addr = conn->rmb_desc->is_vm ?
+		cpu_to_be64((uintptr_t)conn->rmb_desc->cpu_addr) :
+		cpu_to_be64((u64)sg_dma_address
+			    (conn->rmb_desc->sgt[link->link_idx].sgl));
+	hton24(clc->r0.psn, link->psn_initial);
+	if (version == SMC_V1) {
+		clc->hdr.length = htons(SMCR_CLC_ACCEPT_CONFIRM_LEN);
+	} else {
+		if (eid && eid[0])
+			memcpy(clc_v2->r1.eid, eid, SMC_MAX_EID_LEN);
+		len = SMCR_CLC_ACCEPT_CONFIRM_LEN_V2;
+		if (first_contact) {
+			*fce_len = smc_clc_fill_fce_v2x(fce_v2x, ini);
+			len += *fce_len;
+			fce_v2x->fce_v2_base.v2_direct =
+				!link->lgr->uses_gateway;
+			if (clc->hdr.type == SMC_CLC_CONFIRM) {
+				memset(gle, 0, sizeof(*gle));
+				gle->gid_cnt = ini->smcrv2.gidlist.len;
+				len += sizeof(*gle);
+				len += gle->gid_cnt * sizeof(gle->gid[0]);
+			}
+		}
+		clc_v2->hdr.length = htons(len);
+	}
+	memcpy(trl->eyecatcher, SMC_EYECATCHER, sizeof(SMC_EYECATCHER));
+}
+
 /* build and send CLC CONFIRM / ACCEPT message */
 static int smc_clc_send_confirm_accept(struct smc_sock *smc,
 				       struct smc_clc_msg_accept_confirm_v2 *clc_v2,
@@ -1006,11 +1112,10 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
 {
 	struct smc_clc_first_contact_ext_v2x fce_v2x;
 	struct smc_connection *conn = &smc->conn;
-	struct smcd_dev *smcd = conn->lgr->smcd;
 	struct smc_clc_msg_accept_confirm *clc;
 	struct smc_clc_fce_gid_ext gle;
 	struct smc_clc_msg_trail trl;
-	int i, len, fce_len;
+	int i, fce_len;
 	struct kvec vec[5];
 	struct msghdr msg;
 
@@ -1019,86 +1124,14 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
 	clc->hdr.version = version;	/* SMC version */
 	if (first_contact)
 		clc->hdr.typev2 |= SMC_FIRST_CONTACT_MASK;
-	if (conn->lgr->is_smcd) {
-		/* SMC-D specific settings */
-		memcpy(clc->hdr.eyecatcher, SMCD_EYECATCHER,
-		       sizeof(SMCD_EYECATCHER));
-		clc->hdr.typev1 = SMC_TYPE_D;
-		clc->d0.gid = htonll(smcd->ops->get_local_gid(smcd));
-		clc->d0.token = htonll(conn->rmb_desc->token);
-		clc->d0.dmbe_size = conn->rmbe_size_comp;
-		clc->d0.dmbe_idx = 0;
-		memcpy(&clc->d0.linkid, conn->lgr->id, SMC_LGR_ID_SIZE);
-		if (version == SMC_V1) {
-			clc->hdr.length = htons(SMCD_CLC_ACCEPT_CONFIRM_LEN);
-		} else {
-			clc_v2->d1.chid = htons(smc_ism_get_chid(smcd));
-			if (eid && eid[0])
-				memcpy(clc_v2->d1.eid, eid, SMC_MAX_EID_LEN);
-			len = SMCD_CLC_ACCEPT_CONFIRM_LEN_V2;
-			if (first_contact) {
-				fce_len = smc_clc_fill_fce_v2x(&fce_v2x, ini);
-				len += fce_len;
-			}
-			clc_v2->hdr.length = htons(len);
-		}
-		memcpy(trl.eyecatcher, SMCD_EYECATCHER,
-		       sizeof(SMCD_EYECATCHER));
-	} else {
-		struct smc_link *link = conn->lnk;
-
-		/* SMC-R specific settings */
-		memcpy(clc->hdr.eyecatcher, SMC_EYECATCHER,
-		       sizeof(SMC_EYECATCHER));
-		clc->hdr.typev1 = SMC_TYPE_R;
-		clc->hdr.length = htons(SMCR_CLC_ACCEPT_CONFIRM_LEN);
-		memcpy(clc->r0.lcl.id_for_peer, local_systemid,
-		       sizeof(local_systemid));
-		memcpy(&clc->r0.lcl.gid, link->gid, SMC_GID_SIZE);
-		memcpy(&clc->r0.lcl.mac, &link->smcibdev->mac[link->ibport - 1],
-		       ETH_ALEN);
-		hton24(clc->r0.qpn, link->roce_qp->qp_num);
-		clc->r0.rmb_rkey =
-			htonl(conn->rmb_desc->mr[link->link_idx]->rkey);
-		clc->r0.rmbe_idx = 1; /* for now: 1 RMB = 1 RMBE */
-		clc->r0.rmbe_alert_token = htonl(conn->alert_token_local);
-		switch (clc->hdr.type) {
-		case SMC_CLC_ACCEPT:
-			clc->r0.qp_mtu = link->path_mtu;
-			break;
-		case SMC_CLC_CONFIRM:
-			clc->r0.qp_mtu = min(link->path_mtu, link->peer_mtu);
-			break;
-		}
-		clc->r0.rmbe_size = conn->rmbe_size_comp;
-		clc->r0.rmb_dma_addr = conn->rmb_desc->is_vm ?
-			cpu_to_be64((uintptr_t)conn->rmb_desc->cpu_addr) :
-			cpu_to_be64((u64)sg_dma_address
-				    (conn->rmb_desc->sgt[link->link_idx].sgl));
-		hton24(clc->r0.psn, link->psn_initial);
-		if (version == SMC_V1) {
-			clc->hdr.length = htons(SMCR_CLC_ACCEPT_CONFIRM_LEN);
-		} else {
-			if (eid && eid[0])
-				memcpy(clc_v2->r1.eid, eid, SMC_MAX_EID_LEN);
-			len = SMCR_CLC_ACCEPT_CONFIRM_LEN_V2;
-			if (first_contact) {
-				fce_len = smc_clc_fill_fce_v2x(&fce_v2x, ini);
-				len += fce_len;
-				fce_v2x.fce_v2_base.v2_direct =
-					!link->lgr->uses_gateway;
-				if (clc->hdr.type == SMC_CLC_CONFIRM) {
-					memset(&gle, 0, sizeof(gle));
-					gle.gid_cnt = ini->smcrv2.gidlist.len;
-					len += sizeof(gle);
-					len += gle.gid_cnt * sizeof(gle.gid[0]);
-				}
-			}
-			clc_v2->hdr.length = htons(len);
-		}
-		memcpy(trl.eyecatcher, SMC_EYECATCHER, sizeof(SMC_EYECATCHER));
-	}
-
+	if (conn->lgr->is_smcd)
+		smcd_clc_prep_confirm_accept(conn, clc_v2, first_contact,
+					     version, eid, ini, &fce_len,
+					     &fce_v2x, &trl);
+	else
+		smcr_clc_prep_confirm_accept(conn, clc_v2, first_contact,
+					     version, eid, ini, &fce_len,
+					     &fce_v2x, &gle, &trl);
 	memset(&msg, 0, sizeof(msg));
 	i = 0;
 	vec[i].iov_base = clc_v2;
-- 
1.8.3.1

