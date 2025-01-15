Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F441D8E01;
	Wed, 15 Jan 2025 19:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736970946; cv=none; b=OHr8Pr4pbsbgSn8LSNZ29v2ul6DY+UNoLTktndpnTVUgLbct1CiK0MswnTU0qbiKQJxpL5Fb8pwXD55tgQav+/H//PZaa5ZqERJUaaqi9MwU/U9h9FWGZ7BDkB0c+HkQELWW3Mm4Bk0+zIS2wiET7wRurSSGCYhdxTaWeb/W5eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736970946; c=relaxed/simple;
	bh=1Qx6dmW2ZxwoHVOgTN1cEe5+zZiPmfPpc44tF6HIa1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kM+Tut7Rozh1bMv3dHEBbgF2Xa9M2yliBrZ+pg7wq+vDWPLXjmWJ/9zR6E1GMga+9lCAPVuxjGt0FcE9Mfqc9kzkiJJv41npoun0EI8XAyyY7jGzcR9/C6yN3Je+SNgiitq9tpdBysi+u903q0Lay/oZlATzAswenHirfolCaec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C6WAAa8K; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C6WAAa8K"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHX5ri024175;
	Wed, 15 Jan 2025 19:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+mOFwOsB0j3fAlYuj
	JfsCgnZG9nq6oG0Z5EBWll6+M4=; b=C6WAAa8KPZhfRSsDXdRGwlaDkI9tv6L6Y
	antppcrPaUQ4K2W68y1j9Qoc4ddQ8PSM/RVO1HJsLIBvyVKFMZYdjz/vb/dOIJKC
	mcAmTiPx5+2JvT7OeQ9Vzvk4pKnDhfMVbyr1HZxmEaw2WjFyAEWwZZaCfEqms6j7
	BJvA6X+xLLXMofxh6mdQlJyFK54JbF23vXs/ujOQcBQ3lOUaDDeig6dlTJSnaUTX
	o4xJu0ptJIl/6eDvPHLYuYkX4yYfyi3SVd83OLwcxJM7pk9YSa+HjQFNEe3m/E8O
	w8S6StFJSi0f/FoC9HZ2xAFqFKCciVPQwl9AJAqxKpnxPuxJsOf/A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4469733c43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 19:55:33 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50FJtW6J005240;
	Wed, 15 Jan 2025 19:55:32 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4469733c3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 19:55:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHhO1v007371;
	Wed, 15 Jan 2025 19:55:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443yna6rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 19:55:31 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50FJtSrO52363766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 19:55:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 012C120040;
	Wed, 15 Jan 2025 19:55:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF71220063;
	Wed, 15 Jan 2025 19:55:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 15 Jan 2025 19:55:27 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 57EB3E0D9D; Wed, 15 Jan 2025 20:55:27 +0100 (CET)
From: Alexandra Winter <wintera@linux.ibm.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: [RFC net-next 7/7] net/smc: Use only ism_ops
Date: Wed, 15 Jan 2025 20:55:27 +0100
Message-ID: <20250115195527.2094320-8-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250115195527.2094320-1-wintera@linux.ibm.com>
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: f1Pl9saKixFg9Y1_SUTAAa0jQE7yCL3Z
X-Proofpoint-GUID: ytb2mwGGoBK4zm63BuNwsGPQ_Wi_Z-td
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_09,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150142

Replace smcd_ops by using ism_ops directly.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 include/linux/ism.h |   1 +
 include/net/smc.h   |  30 ------
 net/smc/smc_clc.c   |   6 +-
 net/smc/smc_core.c  |   6 +-
 net/smc/smc_diag.c  |   2 +-
 net/smc/smc_ism.c   | 222 ++++++++------------------------------------
 net/smc/smc_ism.h   |   8 +-
 net/smc/smc_pnet.c  |   8 +-
 8 files changed, 55 insertions(+), 228 deletions(-)

diff --git a/include/linux/ism.h b/include/linux/ism.h
index f28238fb5d74..c11de3931722 100644
--- a/include/linux/ism.h
+++ b/include/linux/ism.h
@@ -30,6 +30,7 @@ struct ism_dmb {
 	 */
 	u64 dmb_tok;
 	/* rgid - GID of designated remote sending device */
+	//TODO: Change to uuid_t GID. Ok for now, because loopback ignores it.
 	u64 rgid;
 	u32 dmb_len;
 	/* sba_idx - Index of this DMB on this receiving device */
diff --git a/include/net/smc.h b/include/net/smc.h
index 7a96ed2ae20c..a8235de6cf0a 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -28,43 +28,13 @@ struct smc_hashinfo {
 
 /* SMCD/ISM device driver interface */
 
-struct smcd_dev;
-
 struct smcd_gid {
 	u64	gid;
 	u64	gid_ext;
 };
 
-struct smcd_ops {
-	int (*query_remote_gid)(struct smcd_dev *dev, struct smcd_gid *rgid,
-				u32 vid_valid, u32 vid);
-	int (*register_dmb)(struct smcd_dev *dev, struct ism_dmb *dmb,
-			    void *client);
-	int (*unregister_dmb)(struct smcd_dev *dev, struct ism_dmb *dmb);
-	int (*move_data)(struct smcd_dev *dev, u64 dmb_tok, unsigned int idx,
-			 bool sf, unsigned int offset, void *data,
-			 unsigned int size);
-	int (*supports_v2)(void);
-	void (*get_local_gid)(struct smcd_dev *dev, struct smcd_gid *gid);
-	u16 (*get_chid)(struct smcd_dev *dev);
-	struct device* (*get_dev)(struct smcd_dev *dev);
-
-	/* optional operations */
-	int (*add_vlan_id)(struct smcd_dev *dev, u64 vlan_id);
-	int (*del_vlan_id)(struct smcd_dev *dev, u64 vlan_id);
-	int (*set_vlan_required)(struct smcd_dev *dev);
-	int (*reset_vlan_required)(struct smcd_dev *dev);
-	int (*signal_event)(struct smcd_dev *dev, struct smcd_gid *rgid,
-			    u32 trigger_irq, u32 event_code, u64 info);
-	int (*support_dmb_nocopy)(struct smcd_dev *dev);
-	int (*attach_dmb)(struct smcd_dev *dev, struct ism_dmb *dmb);
-	int (*detach_dmb)(struct smcd_dev *dev, u64 token);
-};
-
 struct smcd_dev {
-	const struct smcd_ops *ops;
 	struct ism_dev *ism;
-	struct ism_client *client;
 	struct list_head list;
 	spinlock_t lock;
 	struct smc_connection **conn;
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 33fa787c28eb..b546999f83a4 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -900,7 +900,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 		/* add SMC-D specifics */
 		if (ini->ism_dev[0]) {
 			smcd = ini->ism_dev[0];
-			smcd->ops->get_local_gid(smcd, &smcd_gid);
+			copy_to_smcdgid(&smcd_gid, &smcd->ism->gid);
 			pclc_smcd->ism.gid = htonll(smcd_gid.gid);
 			pclc_smcd->ism.chid =
 				htons(smc_ism_get_chid(ini->ism_dev[0]));
@@ -950,7 +950,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 		if (ini->ism_offered_cnt) {
 			for (i = 1; i <= ini->ism_offered_cnt; i++) {
 				smcd = ini->ism_dev[i];
-				smcd->ops->get_local_gid(smcd, &smcd_gid);
+				copy_to_smcdgid(&smcd_gid, &smcd->ism->gid);
 				gidchids[entry].chid =
 					htons(smc_ism_get_chid(ini->ism_dev[i]));
 				gidchids[entry].gid = htonll(smcd_gid.gid);
@@ -1043,7 +1043,7 @@ smcd_clc_prep_confirm_accept(struct smc_connection *conn,
 	/* SMC-D specific settings */
 	memcpy(clc->hdr.eyecatcher, SMCD_EYECATCHER,
 	       sizeof(SMCD_EYECATCHER));
-	smcd->ops->get_local_gid(smcd, &smcd_gid);
+	copy_to_smcdgid(&smcd_gid, &smcd->ism->gid);
 	clc->hdr.typev1 = SMC_TYPE_D;
 	clc->d0.gid = htonll(smcd_gid.gid);
 	clc->d0.token = htonll(conn->rmb_desc->token);
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index d489b80a4503..dca43edfc6be 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -555,7 +555,7 @@ static int smc_nl_fill_smcd_lgr(struct smc_link_group *lgr,
 
 	if (nla_put_u32(skb, SMC_NLA_LGR_D_ID, *((u32 *)&lgr->id)))
 		goto errattr;
-	smcd->ops->get_local_gid(smcd, &smcd_gid);
+	copy_to_smcdgid(&smcd_gid, &smcd->ism->gid);
 	if (nla_put_u64_64bit(skb, SMC_NLA_LGR_D_GID,
 			      smcd_gid.gid, SMC_NLA_LGR_D_PAD))
 		goto errattr;
@@ -919,7 +919,7 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 	if (ini->is_smcd) {
 		/* SMC-D specific settings */
 		smcd = ini->ism_dev[ini->ism_selected];
-		get_device(smcd->ops->get_dev(smcd));
+		get_device(ism_get_dev(smcd->ism));
 		lgr->peer_gid.gid =
 			ini->ism_peer_gid[ini->ism_selected].gid;
 		lgr->peer_gid.gid_ext =
@@ -1469,7 +1469,7 @@ static void smc_lgr_free(struct smc_link_group *lgr)
 	destroy_workqueue(lgr->tx_wq);
 	if (lgr->is_smcd) {
 		smc_ism_put_vlan(lgr->smcd, lgr->vlan_id);
-		put_device(lgr->smcd->ops->get_dev(lgr->smcd));
+		put_device(ism_get_dev(lgr->smcd->ism));
 	}
 	smc_lgr_put(lgr); /* theoretically last lgr_put */
 }
diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index 6fdb2d96777a..5e79345108d4 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -175,7 +175,7 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
 		dinfo.linkid = *((u32 *)conn->lgr->id);
 		dinfo.peer_gid = conn->lgr->peer_gid.gid;
 		dinfo.peer_gid_ext = conn->lgr->peer_gid.gid_ext;
-		smcd->ops->get_local_gid(smcd, &smcd_gid);
+		copy_to_smcdgid(&smcd_gid, &smcd->ism->gid);
 		dinfo.my_gid = smcd_gid.gid;
 		dinfo.my_gid_ext = smcd_gid.gid_ext;
 		dinfo.token = conn->rmb_desc->token;
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 22c1cfb2ad09..9d14aef52283 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -68,8 +68,12 @@ static void smc_ism_create_system_eid(void)
 int smc_ism_cantalk(struct smcd_gid *peer_gid, unsigned short vlan_id,
 		    struct smcd_dev *smcd)
 {
-	return smcd->ops->query_remote_gid(smcd, peer_gid, vlan_id ? 1 : 0,
-					   vlan_id);
+	struct ism_dev *ism = smcd->ism;
+	uuid_t ism_rgid;
+
+	copy_to_ismgid(&ism_rgid, peer_gid);
+	return ism->ops->query_remote_gid(ism, &ism_rgid, vlan_id ? 1 : 0,
+					  vlan_id);
 }
 
 void smc_ism_get_system_eid(u8 **eid)
@@ -82,7 +86,7 @@ void smc_ism_get_system_eid(u8 **eid)
 
 u16 smc_ism_get_chid(struct smcd_dev *smcd)
 {
-	return smcd->ops->get_chid(smcd);
+	return smcd->ism->ops->get_chid(smcd->ism);
 }
 
 /* HW supports ISM V2 and thus System EID is defined */
@@ -131,7 +135,7 @@ int smc_ism_get_vlan(struct smcd_dev *smcd, unsigned short vlanid)
 
 	if (!vlanid)			/* No valid vlan id */
 		return -EINVAL;
-	if (!smcd->ops->add_vlan_id)
+	if (!smcd->ism->ops->add_vlan_id)
 		return -EOPNOTSUPP;
 
 	/* create new vlan entry, in case we need it */
@@ -154,7 +158,7 @@ int smc_ism_get_vlan(struct smcd_dev *smcd, unsigned short vlanid)
 	/* no existing entry found.
 	 * add new entry to device; might fail, e.g., if HW limit reached
 	 */
-	if (smcd->ops->add_vlan_id(smcd, vlanid)) {
+	if (smcd->ism->ops->add_vlan_id(smcd->ism, vlanid)) {
 		kfree(new_vlan);
 		rc = -EIO;
 		goto out;
@@ -178,7 +182,7 @@ int smc_ism_put_vlan(struct smcd_dev *smcd, unsigned short vlanid)
 
 	if (!vlanid)			/* No valid vlan id */
 		return -EINVAL;
-	if (!smcd->ops->del_vlan_id)
+	if (!smcd->ism->ops->del_vlan_id)
 		return -EOPNOTSUPP;
 
 	spin_lock_irqsave(&smcd->lock, flags);
@@ -196,7 +200,7 @@ int smc_ism_put_vlan(struct smcd_dev *smcd, unsigned short vlanid)
 	}
 
 	/* Found and the last reference just gone */
-	if (smcd->ops->del_vlan_id(smcd, vlanid))
+	if (smcd->ism->ops->del_vlan_id(smcd->ism, vlanid))
 		rc = -EIO;
 	list_del(&vlan->list);
 	kfree(vlan);
@@ -219,7 +223,8 @@ int smc_ism_unregister_dmb(struct smcd_dev *smcd, struct smc_buf_desc *dmb_desc)
 	dmb.cpu_addr = dmb_desc->cpu_addr;
 	dmb.dma_addr = dmb_desc->dma_addr;
 	dmb.dmb_len = dmb_desc->len;
-	rc = smcd->ops->unregister_dmb(smcd, &dmb);
+
+	rc = smcd->ism->ops->unregister_dmb(smcd->ism, &dmb);
 	if (!rc || rc == ISM_ERROR) {
 		dmb_desc->cpu_addr = NULL;
 		dmb_desc->dma_addr = 0;
@@ -231,6 +236,7 @@ int smc_ism_unregister_dmb(struct smcd_dev *smcd, struct smc_buf_desc *dmb_desc)
 int smc_ism_register_dmb(struct smc_link_group *lgr, int dmb_len,
 			 struct smc_buf_desc *dmb_desc)
 {
+	struct ism_dev *ism;
 	struct ism_dmb dmb;
 	int rc;
 
@@ -239,7 +245,9 @@ int smc_ism_register_dmb(struct smc_link_group *lgr, int dmb_len,
 	dmb.sba_idx = dmb_desc->sba_idx;
 	dmb.vlan_id = lgr->vlan_id;
 	dmb.rgid = lgr->peer_gid.gid;
-	rc = lgr->smcd->ops->register_dmb(lgr->smcd, &dmb, lgr->smcd->client);
+
+	ism = lgr->smcd->ism;
+	rc = ism->ops->register_dmb(ism, &dmb, &smc_ism_client);
 	if (!rc) {
 		dmb_desc->sba_idx = dmb.sba_idx;
 		dmb_desc->token = dmb.dmb_tok;
@@ -256,8 +264,8 @@ bool smc_ism_support_dmb_nocopy(struct smcd_dev *smcd)
 	 * merging sndbuf with peer DMB to avoid
 	 * data copies between them.
 	 */
-	return (smcd->ops->support_dmb_nocopy &&
-		smcd->ops->support_dmb_nocopy(smcd));
+	return (smcd->ism->ops->support_dmb_nocopy &&
+		smcd->ism->ops->support_dmb_nocopy(smcd->ism));
 }
 
 int smc_ism_attach_dmb(struct smcd_dev *dev, u64 token,
@@ -266,12 +274,12 @@ int smc_ism_attach_dmb(struct smcd_dev *dev, u64 token,
 	struct ism_dmb dmb;
 	int rc = 0;
 
-	if (!dev->ops->attach_dmb)
+	if (!dev->ism->ops->attach_dmb)
 		return -EINVAL;
 
 	memset(&dmb, 0, sizeof(dmb));
 	dmb.dmb_tok = token;
-	rc = dev->ops->attach_dmb(dev, &dmb);
+	rc = dev->ism->ops->attach_dmb(dev->ism, &dmb);
 	if (!rc) {
 		dmb_desc->sba_idx = dmb.sba_idx;
 		dmb_desc->token = dmb.dmb_tok;
@@ -284,10 +292,10 @@ int smc_ism_attach_dmb(struct smcd_dev *dev, u64 token,
 
 int smc_ism_detach_dmb(struct smcd_dev *dev, u64 token)
 {
-	if (!dev->ops->detach_dmb)
+	if (!dev->ism->ops->detach_dmb)
 		return -EINVAL;
 
-	return dev->ops->detach_dmb(dev, token);
+	return dev->ism->ops->detach_dmb(dev->ism, token);
 }
 
 static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
@@ -412,6 +420,8 @@ static void smcd_handle_sw_event(struct smc_ism_event_work *wrk)
 	struct smcd_gid peer_gid = { .gid = wrk->event.tok,
 				     .gid_ext = 0 };
 	union smcd_sw_event_info ev_info;
+	struct ism_dev *ism = wrk->smcd->ism;
+	uuid_t ism_rgid;
 
 	ev_info.info = wrk->event.info;
 	switch (wrk->event.code) {
@@ -420,14 +430,14 @@ static void smcd_handle_sw_event(struct smc_ism_event_work *wrk)
 		break;
 	case ISM_EVENT_CODE_TESTLINK:	/* Activity timer */
 		if (ev_info.code == ISM_EVENT_REQUEST &&
-		    wrk->smcd->ops->signal_event) {
+		    ism->ops->signal_event) {
 			ev_info.code = ISM_EVENT_RESPONSE;
-			wrk->smcd->ops->signal_event(wrk->smcd,
-						     &peer_gid,
-						     ISM_EVENT_REQUEST_IR,
-						     ISM_EVENT_CODE_TESTLINK,
-						     ev_info.info);
-			}
+			copy_to_ismgid(&ism_rgid, &peer_gid);
+			ism->ops->signal_event(ism, &ism_rgid,
+					       ISM_EVENT_REQUEST_IR,
+					       ISM_EVENT_CODE_TESTLINK,
+					       ev_info.info);
+		}
 		break;
 	}
 }
@@ -453,9 +463,7 @@ static void smc_ism_event_work(struct work_struct *work)
 	kfree(wrk);
 }
 
-static struct smcd_dev *smcd_alloc_dev(const char *name,
-				       const struct smcd_ops *ops,
-				       int max_dmbs)
+static struct smcd_dev *smcd_alloc_dev(const char *name, int max_dmbs)
 {
 	struct smcd_dev *smcd;
 
@@ -472,8 +480,6 @@ static struct smcd_dev *smcd_alloc_dev(const char *name,
 	if (!smcd->event_wq)
 		goto free_conn;
 
-	smcd->ops = ops;
-
 	spin_lock_init(&smcd->lock);
 	spin_lock_init(&smcd->lgr_lock);
 	INIT_LIST_HEAD(&smcd->vlan);
@@ -488,176 +494,22 @@ static struct smcd_dev *smcd_alloc_dev(const char *name,
 	return NULL;
 }
 
-static int smcd_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
-			   u32 vid_valid, u32 vid)
-{
-	struct ism_dev *ism = smcd->ism;
-	uuid_t ism_rgid;
-
-	copy_to_ismgid(&ism_rgid, rgid);
-	return ism->ops->query_remote_gid(ism, &ism_rgid, vid_valid, vid);
-}
-
-static int smcd_register_dmb(struct smcd_dev *smcd, struct ism_dmb *dmb,
-			     void *client)
-{
-	struct ism_dev *ism = smcd->ism;
-
-	return ism->ops->register_dmb(ism, dmb, (struct ism_client *)client);
-}
-
-static int smcd_unregister_dmb(struct smcd_dev *smcd, struct ism_dmb *dmb)
-{
-	struct ism_dev *ism = smcd->ism;
-
-	return ism->ops->unregister_dmb(ism, dmb);
-}
-
-static int smcd_add_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
-{
-	struct ism_dev *ism = smcd->ism;
-
-	return ism->ops->add_vlan_id(ism, vlan_id);
-}
-
-static int smcd_del_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
-{
-	struct ism_dev *ism = smcd->ism;
-
-	return ism->ops->del_vlan_id(ism, vlan_id);
-}
-
-static int smcd_set_vlan_required(struct smcd_dev *smcd)
-{
-	struct ism_dev *ism = smcd->ism;
-
-	return ism->ops->set_vlan_required(ism);
-}
-
-static int smcd_reset_vlan_required(struct smcd_dev *smcd)
-{
-	struct ism_dev *ism = smcd->ism;
-
-	return ism->ops->reset_vlan_required(ism);
-}
-
-static int smcd_signal_ieq(struct smcd_dev *smcd, struct smcd_gid *rgid,
-			   u32 trigger_irq, u32 event_code, u64 info)
-{
-	struct ism_dev *ism = smcd->ism;
-	uuid_t ism_rgid;
-
-	copy_to_ismgid(&ism_rgid, rgid);
-	return ism->ops->signal_event(ism, &ism_rgid, trigger_irq,
-				      event_code, info);
-}
-
-static int smcd_move(struct smcd_dev *smcd, u64 dmb_tok, unsigned int idx,
-		     bool sf, unsigned int offset, void *data,
-		     unsigned int size)
-{
-	struct ism_dev *ism = smcd->ism;
-
-	return ism->ops->move_data(ism, dmb_tok, idx, sf, offset, data, size);
-}
-
-static int smcd_supports_v2(void)
-{
-	return smc_ism_v2_capable;
-}
-
-static void smcd_get_local_gid(struct smcd_dev *smcd,
-			       struct smcd_gid *smcd_gid)
-{
-	struct ism_dev *ism = smcd->ism;
-
-	copy_to_smcdgid(smcd_gid, &ism->gid);
-}
-
-static u16 smcd_get_chid(struct smcd_dev *smcd)
-{
-	struct ism_dev *ism = smcd->ism;
-
-	return ism->ops->get_chid(ism);
-}
-
-static inline struct device *smcd_get_dev(struct smcd_dev *dev)
-{
-	return ism_get_dev(dev->ism);
-}
-
-static const struct smcd_ops ism_smcd_ops = {
-	.query_remote_gid = smcd_query_rgid,
-	.register_dmb = smcd_register_dmb,
-	.unregister_dmb = smcd_unregister_dmb,
-	.add_vlan_id = smcd_add_vlan_id,
-	.del_vlan_id = smcd_del_vlan_id,
-	.set_vlan_required = smcd_set_vlan_required,
-	.reset_vlan_required = smcd_reset_vlan_required,
-	.signal_event = smcd_signal_ieq,
-	.move_data = smcd_move,
-	.supports_v2 = smcd_supports_v2,
-	.get_local_gid = smcd_get_local_gid,
-	.get_chid = smcd_get_chid,
-	.get_dev = smcd_get_dev,
-};
-
-static inline int smcd_support_dmb_nocopy(struct smcd_dev *smcd)
-{
-	struct ism_dev *ism = smcd->ism;
-
-	return ism->ops->support_dmb_nocopy(ism);
-}
-
-static inline int smcd_attach_dmb(struct smcd_dev *smcd,
-				  struct ism_dmb *dmb)
-{
-	struct ism_dev *ism = smcd->ism;
-
-	return ism->ops->attach_dmb(ism, dmb);
-}
-
-static inline int smcd_detach_dmb(struct smcd_dev *smcd, u64 token)
-{
-	struct ism_dev *ism = smcd->ism;
-
-	return ism->ops->detach_dmb(ism, token);
-}
-
-static const struct smcd_ops lo_ops = {
-	.query_remote_gid = smcd_query_rgid,
-	.register_dmb = smcd_register_dmb,
-	.unregister_dmb = smcd_unregister_dmb,
-	.support_dmb_nocopy = smcd_support_dmb_nocopy,
-	.attach_dmb = smcd_attach_dmb,
-	.detach_dmb = smcd_detach_dmb,
-	.move_data = smcd_move,
-	.supports_v2 = smcd_supports_v2,
-	.get_local_gid = smcd_get_local_gid,
-	.get_chid = smcd_get_chid,
-	.get_dev = smcd_get_dev,
-};
-
 static void smcd_register_dev(struct ism_dev *ism)
 {
-	const struct smcd_ops *ops;
 	struct smcd_dev *smcd, *fentry;
 	int max_dmbs;
 
 	if (ism->ops->get_chid(ism) == ISM_LO_RESERVED_CHID) {
 		max_dmbs = ISM_LO_MAX_DMBS;
-		ops = &lo_ops;
 	} else {
 		max_dmbs = ISM_NR_DMBS;
-		ops = &ism_smcd_ops;
 	}
 
-	smcd = smcd_alloc_dev(dev_name(&ism->dev), ops, max_dmbs);
+	smcd = smcd_alloc_dev(dev_name(&ism->dev), max_dmbs);
 	if (!smcd)
 		return;
 
 	smcd->ism = ism;
-	smcd->client = &smc_ism_client;
 	ism_set_priv(ism, &smc_ism_client, smcd);
 
 	if (smc_pnetid_by_dev_port(ism->dev.parent, 0, smcd->pnetid))
@@ -760,16 +612,18 @@ int smc_ism_signal_shutdown(struct smc_link_group *lgr)
 	int rc = 0;
 #if IS_ENABLED(CONFIG_ISM)
 	union smcd_sw_event_info ev_info;
+	uuid_t ism_rgid;
 
 	if (lgr->peer_shutdown)
 		return 0;
-	if (!lgr->smcd->ops->signal_event)
+	if (!lgr->smcd->ism->ops->signal_event)
 		return 0;
 
 	memcpy(ev_info.uid, lgr->id, SMC_LGR_ID_SIZE);
 	ev_info.vlan_id = lgr->vlan_id;
 	ev_info.code = ISM_EVENT_REQUEST;
-	rc = lgr->smcd->ops->signal_event(lgr->smcd, &lgr->peer_gid,
+	copy_to_ismgid(&ism_rgid, &lgr->peer_gid);
+	rc = lgr->smcd->ism->ops->signal_event(lgr->smcd->ism, &ism_rgid,
 					  ISM_EVENT_REQUEST_IR,
 					  ISM_EVENT_CODE_SHUTDOWN,
 					  ev_info.info);
diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index d041e5a7c459..e2e8cfba2575 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -68,7 +68,9 @@ static inline int smc_ism_write(struct smcd_dev *smcd, u64 dmb_tok,
 {
 	int rc;
 
-	rc = smcd->ops->move_data(smcd, dmb_tok, idx, sf, offset, data, len);
+	rc = smcd->ism->ops->move_data(smcd->ism, dmb_tok, idx, sf, offset,
+				       data, len);
+
 	return rc < 0 ? rc : 0;
 }
 
@@ -85,14 +87,14 @@ static inline bool __smc_ism_is_emulated(u16 chid)
 
 static inline bool smc_ism_is_emulated(struct smcd_dev *smcd)
 {
-	u16 chid = smcd->ops->get_chid(smcd);
+	u16 chid = smcd->ism->ops->get_chid(smcd->ism);
 
 	return __smc_ism_is_emulated(chid);
 }
 
 static inline bool smc_ism_is_loopback(struct smcd_dev *smcd)
 {
-	return (smcd->ops->get_chid(smcd) == 0xFFFF);
+	return (smcd->ism->ops->get_chid(smcd->ism) == ISM_LO_RESERVED_CHID);
 }
 
 static inline void copy_to_smcdgid(struct smcd_gid *sgid, uuid_t *igid)
diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 716808f374a8..397557f4b7d4 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -169,7 +169,7 @@ static int smc_pnet_remove_by_pnetid(struct net *net, char *pnet_name)
 			pr_warn_ratelimited("smc: smcd device %s "
 					    "erased user defined pnetid "
 					    "%.16s\n",
-					    dev_name(smcd->ops->get_dev(smcd)),
+					    dev_name(ism_get_dev(smcd->ism)),
 					    smcd->pnetid);
 			memset(smcd->pnetid, 0, SMC_MAX_PNETID_LEN);
 			smcd->pnetid_by_user = false;
@@ -332,7 +332,7 @@ static struct smcd_dev *smc_pnet_find_smcd(char *smcd_name)
 
 	mutex_lock(&smcd_dev_list.mutex);
 	list_for_each_entry(smcd_dev, &smcd_dev_list.list, list) {
-		if (!strncmp(dev_name(smcd_dev->ops->get_dev(smcd_dev)),
+		if (!strncmp(dev_name(ism_get_dev(smcd_dev->ism)),
 			     smcd_name, IB_DEVICE_NAME_MAX - 1))
 			goto out;
 	}
@@ -431,7 +431,7 @@ static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
 	if (smcd) {
 		smcddev_applied = smc_pnet_apply_smcd(smcd, pnet_name);
 		if (smcddev_applied) {
-			dev = smcd->ops->get_dev(smcd);
+			dev = ism_get_dev(smcd->ism);
 			pr_warn_ratelimited("smc: smcd device %s "
 					    "applied user defined pnetid "
 					    "%.16s\n", dev_name(dev),
@@ -1190,7 +1190,7 @@ int smc_pnetid_by_table_ib(struct smc_ib_device *smcibdev, u8 ib_port)
  */
 int smc_pnetid_by_table_smcd(struct smcd_dev *smcddev)
 {
-	const char *ib_name = dev_name(smcddev->ops->get_dev(smcddev));
+	const char *ib_name = dev_name(ism_get_dev(smcddev->ism));
 	struct smc_pnettable *pnettable;
 	struct smc_pnetentry *tmp_pe;
 	struct smc_net *sn;
-- 
2.45.2

