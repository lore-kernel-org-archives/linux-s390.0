Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F087C1D86F2;
	Wed, 15 Jan 2025 19:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736970944; cv=none; b=aZoZKjNIBfW0P5FYzo6ycnkx+wT0vfjB9IyoOO1v0iub9ejAkIsLaXUR3RBVGsvv3g1sLLgXBIBIN/q5iFYCHChWJn6ozOa30akFb+sf+XU0rzjdG53OF2xSErdygXejJvW8O7JeitJIwUVe3uvtm0VgWUUrWSAmcmLlp3RUvVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736970944; c=relaxed/simple;
	bh=hCjK59icEPJgQHXN30wyFrnd90eWmotLxsKPmA4AWhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eB4F4JCvsEk9fay3MRhitRjnKfG6mAWMw9i3RiVbc88vyvynQCblOp+urzivusyw34G02mSK4DM/ZnFxYIaD97NngG/bX8zkaoJ2RZv5V3B3c0B+OjXDiQkhkng9DN5DmVwnZZPIyt2m6sKaed2hckYSgDug+Pnz7aQ1hojjt48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LJJEwUug; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LJJEwUug"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHX5DG024451;
	Wed, 15 Jan 2025 19:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=o9Bod7I6wEirlR+0z
	c2JpYns0G5mDBKkE489MdQ45rk=; b=LJJEwUug/yb6YQGaWa6V80N0hOM2Cs9HY
	IudnXuJO4DcuR7ERCv2n2TlT3h3js7oICer+kdQp8lazJs60KkliMI4hKzqzaRCO
	98DZBhz1Jjcf7h7IZkZFmr7+DjBmfThID2VAKF0dpv6+pKvf9zySnOFqa/Bi3U4o
	D+zhKhdxIr4EJnic4oYRhsJ2Evg4vpWYRxIaLAHOHQ9XMMaj9fze1N+i8KwxQ+FT
	2X8hL8vDFjJo4yMPxmWrsnAn7WO/r1+050uetXyXLuInmh2XR+ot0/0D0xHOuscT
	1f40Xm0cJDV3HyqQ43XW3zs7LNbsT6FTzf9A1JpVh65EDXosiO1Kg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44622hw1qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 19:55:33 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50FJjvQk017712;
	Wed, 15 Jan 2025 19:55:32 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44622hw1qr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 19:55:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50FIqLZp016490;
	Wed, 15 Jan 2025 19:55:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4445p1su9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 19:55:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50FJtRB035782996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 19:55:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A28362004B;
	Wed, 15 Jan 2025 19:55:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A97320040;
	Wed, 15 Jan 2025 19:55:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 15 Jan 2025 19:55:27 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 48ECAE0D81; Wed, 15 Jan 2025 20:55:27 +0100 (CET)
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
Subject: [RFC net-next 2/7] net/ism: Remove dependencies between ISM_VPCI and SMC
Date: Wed, 15 Jan 2025 20:55:22 +0100
Message-ID: <20250115195527.2094320-3-wintera@linux.ibm.com>
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
X-Proofpoint-GUID: S46kHLk4hUyUIJ6M_-Mlscp471qKswDG
X-Proofpoint-ORIG-GUID: Tz712k5wofPJ9Hv6BLPoU8DCjOmORGwN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_09,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=876 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501150142

The modules ISM_VPCI and SMC should not depend on each other,
instead they should both depend on the ISM layer module.

use only ism_dmb:
Now that SMC depends on ISM, we can safely remove the
duplicate declaration of smcd_dmb and use only ism_dmb.

Move smcd_ops away from ism_drv:
move smcd_ops from drivers/s390/net/ism_drv.c to net/smc/smc_ism.c
Less exported functions, no more dependencies between ISM_VPCI and SMC.
Once ism_loopback is also moved to ism layer, a follow on patch can use
ism_ops directly and remove smcd_ops.

Now the ISM_VPCI module no longer needs to imply SMC.

Note:
- This patch temporarily moves smcd_gid to ism.h,
a follow on patch (uuid_t gid) will restore this.
- Added a comment that vlan handling in ism_drv.c and smc
is incomplete. Should be fixed by a follow-on patch.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/Kconfig   |   1 -
 drivers/s390/net/ism.h     |   1 -
 drivers/s390/net/ism_drv.c | 236 +++++++++++++------------------------
 include/linux/ism.h        | 146 +++++++++++++++++------
 include/net/smc.h          |  31 ++---
 net/smc/smc_ism.c          | 123 ++++++++++++++++++-
 net/smc/smc_loopback.c     |   6 +-
 7 files changed, 319 insertions(+), 225 deletions(-)

diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
index 2e900d3087d4..9bb3cc186510 100644
--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -103,7 +103,6 @@ config CCWGROUP
 config ISM_VPCI
 	tristate "Support for ISM vPCI Adapter"
 	depends on PCI && ISM
-	imply SMC
 	default y
 	help
 	  Select this option if you want to use the Internal Shared Memory
diff --git a/drivers/s390/net/ism.h b/drivers/s390/net/ism.h
index 047fa6101555..8b56e1d82e6b 100644
--- a/drivers/s390/net/ism.h
+++ b/drivers/s390/net/ism.h
@@ -6,7 +6,6 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 #include <linux/ism.h>
-#include <net/smc.h>
 #include <asm/pci_insn.h>
 
 #define UTIL_STR_LEN	16
diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 2eeccf5ef48d..112e0d67cdd6 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -191,11 +191,28 @@ static int ism_read_local_gid(struct ism_dev *ism)
 	if (ret)
 		goto out;
 
-	ism->local_gid = cmd.response.gid;
+	ism->gid.gid = cmd.response.gid;
+	ism->gid.gid_ext = 0;
 out:
 	return ret;
 }
 
+static int ism_query_rgid(struct ism_dev *ism, struct smcd_gid *rgid,
+			  u32 vid_valid, u32 vid)
+{
+	union ism_query_rgid cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.request.hdr.cmd = ISM_QUERY_RGID;
+	cmd.request.hdr.len = sizeof(cmd.request);
+
+	cmd.request.rgid = rgid->gid;
+	cmd.request.vlan_valid = vid_valid;
+	cmd.request.vlan_id = vid;
+
+	return ism_cmd(ism, &cmd);
+}
+
 static void ism_free_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 {
 	clear_bit(dmb->sba_idx, ism->sba_bitmap);
@@ -251,8 +268,8 @@ static int ism_alloc_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 	return rc;
 }
 
-int ism_register_dmb(struct ism_dev *ism, struct ism_dmb *dmb,
-		     struct ism_client *client)
+static int ism_register_dmb(struct ism_dev *ism, struct ism_dmb *dmb,
+			    struct ism_client *client)
 {
 	union ism_reg_dmb cmd;
 	unsigned long flags;
@@ -285,9 +302,8 @@ int ism_register_dmb(struct ism_dev *ism, struct ism_dmb *dmb,
 out:
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ism_register_dmb);
 
-int ism_unregister_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
+static int ism_unregister_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 {
 	union ism_unreg_dmb cmd;
 	unsigned long flags;
@@ -311,7 +327,6 @@ int ism_unregister_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 out:
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ism_unregister_dmb);
 
 static int ism_add_vlan_id(struct ism_dev *ism, u64 vlan_id)
 {
@@ -339,14 +354,42 @@ static int ism_del_vlan_id(struct ism_dev *ism, u64 vlan_id)
 	return ism_cmd(ism, &cmd);
 }
 
+static int ism_set_vlan_required(struct ism_dev *ism)
+{
+	return ism_cmd_simple(ism, ISM_SET_VLAN);
+}
+
+static int ism_reset_vlan_required(struct ism_dev *ism)
+{
+	return ism_cmd_simple(ism, ISM_RESET_VLAN);
+}
+
+static int ism_signal_ieq(struct ism_dev *ism, struct smcd_gid *rgid,
+			  u32 trigger_irq, u32 event_code, u64 info)
+{
+	union ism_sig_ieq cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.request.hdr.cmd = ISM_SIGNAL_IEQ;
+	cmd.request.hdr.len = sizeof(cmd.request);
+
+	cmd.request.rgid = rgid->gid;
+	cmd.request.trigger_irq = trigger_irq;
+	cmd.request.event_code = event_code;
+	cmd.request.info = info;
+
+	return ism_cmd(ism, &cmd);
+}
+
 static unsigned int max_bytes(unsigned int start, unsigned int len,
 			      unsigned int boundary)
 {
 	return min(boundary - (start & (boundary - 1)), len);
 }
 
-int ism_move(struct ism_dev *ism, u64 dmb_tok, unsigned int idx, bool sf,
-	     unsigned int offset, void *data, unsigned int size)
+static int ism_move(struct ism_dev *ism, u64 dmb_tok, unsigned int idx,
+		    bool sf, unsigned int offset, void *data,
+		    unsigned int size)
 {
 	unsigned int bytes;
 	u64 dmb_req;
@@ -368,7 +411,19 @@ int ism_move(struct ism_dev *ism, u64 dmb_tok, unsigned int idx, bool sf,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(ism_move);
+
+static int ism_supports_v2(void)
+{
+	return ism_v2_capable;
+}
+
+static u16 ism_get_chid(struct ism_dev *ism)
+{
+	if (!ism || !ism->pdev)
+		return 0;
+
+	return to_zpci(ism->pdev)->pchid;
+}
 
 static void ism_handle_event(struct ism_dev *ism)
 {
@@ -428,6 +483,20 @@ static irqreturn_t ism_handle_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static const struct ism_ops ism_vp_ops = {
+	.query_remote_gid = ism_query_rgid,
+	.register_dmb = ism_register_dmb,
+	.unregister_dmb = ism_unregister_dmb,
+	.add_vlan_id = ism_add_vlan_id,
+	.del_vlan_id = ism_del_vlan_id,
+	.set_vlan_required = ism_set_vlan_required,
+	.reset_vlan_required = ism_reset_vlan_required,
+	.signal_event = ism_signal_ieq,
+	.move_data = ism_move,
+	.supports_v2 = ism_supports_v2,
+	.get_chid = ism_get_chid,
+};
+
 static int ism_dev_init(struct ism_dev *ism)
 {
 	struct pci_dev *pdev = ism->pdev;
@@ -465,6 +534,8 @@ static int ism_dev_init(struct ism_dev *ism)
 	else
 		ism_v2_capable = false;
 
+	ism->ops = &ism_vp_ops;
+
 	ism_dev_register(ism);
 	query_info(ism);
 	return 0;
@@ -603,150 +674,3 @@ static void __exit ism_exit(void)
 
 module_init(ism_init);
 module_exit(ism_exit);
-
-/*************************** SMC-D Implementation *****************************/
-
-#if IS_ENABLED(CONFIG_SMC) // needed to avoid unused functions
-static int ism_query_rgid(struct ism_dev *ism, u64 rgid, u32 vid_valid,
-			  u32 vid)
-{
-	union ism_query_rgid cmd;
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.request.hdr.cmd = ISM_QUERY_RGID;
-	cmd.request.hdr.len = sizeof(cmd.request);
-
-	cmd.request.rgid = rgid;
-	cmd.request.vlan_valid = vid_valid;
-	cmd.request.vlan_id = vid;
-
-	return ism_cmd(ism, &cmd);
-}
-
-static int smcd_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
-			   u32 vid_valid, u32 vid)
-{
-	return ism_query_rgid(smcd->priv, rgid->gid, vid_valid, vid);
-}
-
-static int smcd_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
-			     void *client)
-{
-	return ism_register_dmb(smcd->priv, (struct ism_dmb *)dmb, client);
-}
-
-static int smcd_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
-{
-	return ism_unregister_dmb(smcd->priv, (struct ism_dmb *)dmb);
-}
-
-static int smcd_add_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
-{
-	return ism_add_vlan_id(smcd->priv, vlan_id);
-}
-
-static int smcd_del_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
-{
-	return ism_del_vlan_id(smcd->priv, vlan_id);
-}
-
-static int smcd_set_vlan_required(struct smcd_dev *smcd)
-{
-	return ism_cmd_simple(smcd->priv, ISM_SET_VLAN);
-}
-
-static int smcd_reset_vlan_required(struct smcd_dev *smcd)
-{
-	return ism_cmd_simple(smcd->priv, ISM_RESET_VLAN);
-}
-
-static int ism_signal_ieq(struct ism_dev *ism, u64 rgid, u32 trigger_irq,
-			  u32 event_code, u64 info)
-{
-	union ism_sig_ieq cmd;
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.request.hdr.cmd = ISM_SIGNAL_IEQ;
-	cmd.request.hdr.len = sizeof(cmd.request);
-
-	cmd.request.rgid = rgid;
-	cmd.request.trigger_irq = trigger_irq;
-	cmd.request.event_code = event_code;
-	cmd.request.info = info;
-
-	return ism_cmd(ism, &cmd);
-}
-
-static int smcd_signal_ieq(struct smcd_dev *smcd, struct smcd_gid *rgid,
-			   u32 trigger_irq, u32 event_code, u64 info)
-{
-	return ism_signal_ieq(smcd->priv, rgid->gid,
-			      trigger_irq, event_code, info);
-}
-
-static int smcd_move(struct smcd_dev *smcd, u64 dmb_tok, unsigned int idx,
-		     bool sf, unsigned int offset, void *data,
-		     unsigned int size)
-{
-	return ism_move(smcd->priv, dmb_tok, idx, sf, offset, data, size);
-}
-
-static int smcd_supports_v2(void)
-{
-	return ism_v2_capable;
-}
-
-static u64 ism_get_local_gid(struct ism_dev *ism)
-{
-	return ism->local_gid;
-}
-
-static void smcd_get_local_gid(struct smcd_dev *smcd,
-			       struct smcd_gid *smcd_gid)
-{
-	smcd_gid->gid = ism_get_local_gid(smcd->priv);
-	smcd_gid->gid_ext = 0;
-}
-
-static u16 ism_get_chid(struct ism_dev *ism)
-{
-	if (!ism || !ism->pdev)
-		return 0;
-
-	return to_zpci(ism->pdev)->pchid;
-}
-
-static u16 smcd_get_chid(struct smcd_dev *smcd)
-{
-	return ism_get_chid(smcd->priv);
-}
-
-static inline struct device *smcd_get_dev(struct smcd_dev *dev)
-{
-	struct ism_dev *ism = dev->priv;
-
-	return &ism->dev;
-}
-
-static const struct smcd_ops ism_ops = {
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
-const struct smcd_ops *ism_get_smcd_ops(void)
-{
-	return &ism_ops;
-}
-EXPORT_SYMBOL_GPL(ism_get_smcd_ops);
-#endif
diff --git a/include/linux/ism.h b/include/linux/ism.h
index 1462296e8ba7..ede1a40b408e 100644
--- a/include/linux/ism.h
+++ b/include/linux/ism.h
@@ -12,6 +12,7 @@
 #include <linux/device.h>
 #include <linux/workqueue.h>
 
+/* The remote peer rgid can use dmb_tok to write into this buffer. */
 struct ism_dmb {
 	u64 dmb_tok;
 	u64 rgid;
@@ -23,30 +24,9 @@ struct ism_dmb {
 	dma_addr_t dma_addr;
 };
 
-/* Unless we gain unexpected popularity, this limit should hold for a while */
-#define MAX_CLIENTS		8
-#define NO_CLIENT		0xff		/* must be >= MAX_CLIENTS */
-#define ISM_NR_DMBS		1920
-
-struct ism_dev {
-	spinlock_t lock; /* protects the ism device */
-	struct list_head list;
-	struct pci_dev *pdev;
-
-	struct ism_sba *sba;
-	dma_addr_t sba_dma_addr;
-	DECLARE_BITMAP(sba_bitmap, ISM_NR_DMBS);
-	u8 *sba_client_arr;	/* entries are indices into 'clients' array */
-	void *priv[MAX_CLIENTS];
-
-	struct ism_eq *ieq;
-	dma_addr_t ieq_dma_addr;
-
-	struct device dev;
-	u64 local_gid;
-	int ieq_idx;
-
-	struct ism_client *subs[MAX_CLIENTS];
+struct smcd_gid {
+	u64	gid;
+	u64	gid_ext;
 };
 
 struct ism_event {
@@ -57,6 +37,12 @@ struct ism_event {
 	u64 info;
 };
 
+#define ISM_EVENT_DMB	0
+#define ISM_EVENT_GID	1
+#define ISM_EVENT_SWR	2
+
+struct ism_dev;
+
 struct ism_client {
 	const char *name;
 	void (*add)(struct ism_dev *dev);
@@ -73,28 +59,116 @@ struct ism_client {
 
 int ism_register_client(struct ism_client *client);
 int  ism_unregister_client(struct ism_client *client);
-static inline void *ism_get_priv(struct ism_dev *dev,
-				 struct ism_client *client) {
-	return dev->priv[client->id];
-}
+
+/* Mandatory operations for all ism devices:
+ * int (*query_remote_gid)(struct ism_dev *dev, struct smcd_gid *rgid,
+ *	                   u32 vid_valid, u32 vid);
+ *	Query whether remote GID rgid is reachable via this device and this
+ *	vlan id. Vlan id is only checked if vid_valid != 0.
+ *
+ * int (*register_dmb)(struct ism_dev *dev, struct ism_dmb *dmb,
+ *			    void *client);
+ *	Register an ism_dmb buffer for this device and this client.
+ *
+ * int (*unregister_dmb)(struct ism_dev *dev, struct ism_dmb *dmb);
+ *	Unregister an ism_dmb buffer
+ *
+ * int (*move_data)(struct ism_dev *dev, u64 dmb_tok, unsigned int idx,
+ *			 bool sf, unsigned int offset, void *data,
+ *			 unsigned int size);
+ *	Use dev to write data of size at offset into a remote dmb
+ *	identified by dmb_tok and idx. If signal flag (sf) then signal
+ *	the remote peer that data has arrived in this dmb.
+ *
+ * int (*supports_v2)(void);
+ *
+ * u16 (*get_chid)(struct ism_dev *dev);
+ *	Returns ism fabric identifier (channel id) of this device.
+ *	Only devices on the same ism fabric can communicate.
+ *	chid is unique per HW system, except for 0xFFFF, which denotes
+ *	an ism_loopback device that can only communicate with itself.
+ *	Use chid for fast negative checks, but only query_remote_gid()
+ *	can give a reliable positive answer.
+ *
+ * struct device* (*get_dev)(struct ism_dev *dev);
+ *
+ * Optional operations:
+ * int (*add_vlan_id)(struct ism_dev *dev, u64 vlan_id);
+ * int (*del_vlan_id)(struct ism_dev *dev, u64 vlan_id);
+ * int (*set_vlan_required)(struct ism_dev *dev);
+ * int (*reset_vlan_required)(struct ism_dev *dev);
+ *	VLAN handling is broken - don't use it
+ *	Ability to assign dmbs to VLANs is missing
+ *	- do we really want / need this?
+ *
+ * int (*signal_event)(struct ism_dev *dev, struct smcd_gid *rgid,
+ *			    u32 trigger_irq, u32 event_code, u64 info);
+ *	Send a control event into the event queue of a remote gid (rgid)
+ *	with (1) or without (0) triggering an interrupt at the remote gid.
+ */
+
+struct ism_ops {
+	int (*query_remote_gid)(struct ism_dev *dev, struct smcd_gid *rgid,
+				u32 vid_valid, u32 vid);
+	int (*register_dmb)(struct ism_dev *dev, struct ism_dmb *dmb,
+			    struct ism_client *client);
+	int (*unregister_dmb)(struct ism_dev *dev, struct ism_dmb *dmb);
+	int (*move_data)(struct ism_dev *dev, u64 dmb_tok, unsigned int idx,
+			 bool sf, unsigned int offset, void *data,
+			 unsigned int size);
+	int (*supports_v2)(void);
+	u16 (*get_chid)(struct ism_dev *dev);
+	struct device* (*get_dev)(struct ism_dev *dev);
+
+	/* optional operations */
+	int (*add_vlan_id)(struct ism_dev *dev, u64 vlan_id);
+	int (*del_vlan_id)(struct ism_dev *dev, u64 vlan_id);
+	int (*set_vlan_required)(struct ism_dev *dev);
+	int (*reset_vlan_required)(struct ism_dev *dev);
+	int (*signal_event)(struct ism_dev *dev, struct smcd_gid *rgid,
+			    u32 trigger_irq, u32 event_code, u64 info);
+};
+
+/* Unless we gain unexpected popularity, this limit should hold for a while */
+#define MAX_CLIENTS		8
+#define NO_CLIENT		0xff		/* must be >= MAX_CLIENTS */
+#define ISM_NR_DMBS		1920
+
+struct ism_dev {
+	const struct ism_ops *ops;
+	spinlock_t lock; /* protects the ism device */
+	struct list_head list;
+	struct pci_dev *pdev;
+
+	struct ism_sba *sba;
+	dma_addr_t sba_dma_addr;
+	DECLARE_BITMAP(sba_bitmap, ISM_NR_DMBS);
+	u8 *sba_client_arr;	/* entries are indices into 'clients' array */
+	void *priv[MAX_CLIENTS];
+
+	struct ism_eq *ieq;
+	dma_addr_t ieq_dma_addr;
+
+	struct device dev;
+	struct smcd_gid gid;
+	int ieq_idx;
+
+	struct ism_client *subs[MAX_CLIENTS];
+};
 
 int ism_dev_register(struct ism_dev *ism);
 void ism_dev_unregister(struct ism_dev *ism);
 
+static inline void *ism_get_priv(struct ism_dev *dev,
+				 struct ism_client *client) {
+	return dev->priv[client->id];
+}
 static inline void ism_set_priv(struct ism_dev *dev, struct ism_client *client,
 				void *priv) {
 	dev->priv[client->id] = priv;
 }
 
-int  ism_register_dmb(struct ism_dev *dev, struct ism_dmb *dmb,
-		      struct ism_client *client);
-int  ism_unregister_dmb(struct ism_dev *dev, struct ism_dmb *dmb);
-int  ism_move(struct ism_dev *dev, u64 dmb_tok, unsigned int idx, bool sf,
-	      unsigned int offset, void *data, unsigned int size);
-
 #define ISM_RESERVED_VLANID	0x1FFF
 #define ISM_ERROR	0xFFFF
 
-const struct smcd_ops *ism_get_smcd_ops(void);
-
 #endif	/* _ISM_H */
diff --git a/include/net/smc.h b/include/net/smc.h
index ab732b286f91..3d20c6c05056 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -27,35 +27,20 @@ struct smc_hashinfo {
 };
 
 /* SMCD/ISM device driver interface */
-struct smcd_dmb {
-	u64 dmb_tok;
-	u64 rgid;
-	u32 dmb_len;
-	u32 sba_idx;
-	u32 vlan_valid;
-	u32 vlan_id;
-	void *cpu_addr;
-	dma_addr_t dma_addr;
-};
-
-#define ISM_EVENT_DMB	0
-#define ISM_EVENT_GID	1
-#define ISM_EVENT_SWR	2
-
 
 struct smcd_dev;
 
-struct smcd_gid {
-	u64	gid;
-	u64	gid_ext;
-};
-
+//struct smcd_gid {
+//	u64	gid;
+//	u64	gid_ext;
+//};
+//
 struct smcd_ops {
 	int (*query_remote_gid)(struct smcd_dev *dev, struct smcd_gid *rgid,
 				u32 vid_valid, u32 vid);
-	int (*register_dmb)(struct smcd_dev *dev, struct smcd_dmb *dmb,
+	int (*register_dmb)(struct smcd_dev *dev, struct ism_dmb *dmb,
 			    void *client);
-	int (*unregister_dmb)(struct smcd_dev *dev, struct smcd_dmb *dmb);
+	int (*unregister_dmb)(struct smcd_dev *dev, struct ism_dmb *dmb);
 	int (*move_data)(struct smcd_dev *dev, u64 dmb_tok, unsigned int idx,
 			 bool sf, unsigned int offset, void *data,
 			 unsigned int size);
@@ -72,7 +57,7 @@ struct smcd_ops {
 	int (*signal_event)(struct smcd_dev *dev, struct smcd_gid *rgid,
 			    u32 trigger_irq, u32 event_code, u64 info);
 	int (*support_dmb_nocopy)(struct smcd_dev *dev);
-	int (*attach_dmb)(struct smcd_dev *dev, struct smcd_dmb *dmb);
+	int (*attach_dmb)(struct smcd_dev *dev, struct ism_dmb *dmb);
 	int (*detach_dmb)(struct smcd_dev *dev, u64 token);
 };
 
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 84f98e18c7db..6fbacad02f23 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -207,7 +207,7 @@ int smc_ism_put_vlan(struct smcd_dev *smcd, unsigned short vlanid)
 
 int smc_ism_unregister_dmb(struct smcd_dev *smcd, struct smc_buf_desc *dmb_desc)
 {
-	struct smcd_dmb dmb;
+	struct ism_dmb dmb;
 	int rc = 0;
 
 	if (!dmb_desc->dma_addr)
@@ -231,7 +231,7 @@ int smc_ism_unregister_dmb(struct smcd_dev *smcd, struct smc_buf_desc *dmb_desc)
 int smc_ism_register_dmb(struct smc_link_group *lgr, int dmb_len,
 			 struct smc_buf_desc *dmb_desc)
 {
-	struct smcd_dmb dmb;
+	struct ism_dmb dmb;
 	int rc;
 
 	memset(&dmb, 0, sizeof(dmb));
@@ -263,7 +263,7 @@ bool smc_ism_support_dmb_nocopy(struct smcd_dev *smcd)
 int smc_ism_attach_dmb(struct smcd_dev *dev, u64 token,
 		       struct smc_buf_desc *dmb_desc)
 {
-	struct smcd_dmb dmb;
+	struct ism_dmb dmb;
 	int rc = 0;
 
 	if (!dev->ops->attach_dmb)
@@ -481,9 +481,122 @@ static struct smcd_dev *smcd_alloc_dev(struct device *parent, const char *name,
 	return smcd;
 }
 
+static int smcd_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
+			   u32 vid_valid, u32 vid)
+{
+	struct ism_dev *ism = smcd->priv;
+
+	return ism->ops->query_remote_gid(ism, rgid, vid_valid, vid);
+}
+
+static int smcd_register_dmb(struct smcd_dev *smcd, struct ism_dmb *dmb,
+			     void *client)
+{
+	struct ism_dev *ism = smcd->priv;
+
+	return ism->ops->register_dmb(ism, dmb, (struct ism_client *)client);
+}
+
+static int smcd_unregister_dmb(struct smcd_dev *smcd, struct ism_dmb *dmb)
+{
+	struct ism_dev *ism = smcd->priv;
+
+	return ism->ops->unregister_dmb(ism, dmb);
+}
+
+static int smcd_add_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
+{
+	struct ism_dev *ism = smcd->priv;
+
+	return ism->ops->add_vlan_id(ism, vlan_id);
+}
+
+static int smcd_del_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
+{
+	struct ism_dev *ism = smcd->priv;
+
+	return ism->ops->del_vlan_id(ism, vlan_id);
+}
+
+static int smcd_set_vlan_required(struct smcd_dev *smcd)
+{
+	struct ism_dev *ism = smcd->priv;
+
+	return ism->ops->set_vlan_required(ism);
+}
+
+static int smcd_reset_vlan_required(struct smcd_dev *smcd)
+{
+	struct ism_dev *ism = smcd->priv;
+
+	return ism->ops->reset_vlan_required(ism);
+}
+
+static int smcd_signal_ieq(struct smcd_dev *smcd, struct smcd_gid *rgid,
+			   u32 trigger_irq, u32 event_code, u64 info)
+{
+	struct ism_dev *ism = smcd->priv;
+
+	return ism->ops->signal_event(ism, rgid,
+			      trigger_irq, event_code, info);
+}
+
+static int smcd_move(struct smcd_dev *smcd, u64 dmb_tok, unsigned int idx,
+		     bool sf, unsigned int offset, void *data,
+		     unsigned int size)
+{
+	struct ism_dev *ism = smcd->priv;
+
+	return ism->ops->move_data(ism, dmb_tok, idx, sf, offset, data, size);
+}
+
+static int smcd_supports_v2(void)
+{
+	return smc_ism_v2_capable;
+}
+
+static void smcd_get_local_gid(struct smcd_dev *smcd,
+			       struct smcd_gid *smcd_gid)
+{
+	struct ism_dev *ism = smcd->priv;
+
+	smcd_gid->gid = ism->gid.gid;
+	smcd_gid->gid_ext = ism->gid.gid_ext;
+}
+
+static u16 smcd_get_chid(struct smcd_dev *smcd)
+{
+	struct ism_dev *ism = smcd->priv;
+
+	return ism->ops->get_chid(ism);
+}
+
+static inline struct device *smcd_get_dev(struct smcd_dev *dev)
+{
+	struct ism_dev *ism = dev->priv;
+
+	return &ism->dev;
+}
+
+static const struct smcd_ops ism_smcd_ops = {
+	.query_remote_gid = smcd_query_rgid,
+	.register_dmb = smcd_register_dmb,
+	.unregister_dmb = smcd_unregister_dmb,
+	.add_vlan_id = smcd_add_vlan_id,
+	.del_vlan_id = smcd_del_vlan_id,
+	.set_vlan_required = smcd_set_vlan_required,
+	.reset_vlan_required = smcd_reset_vlan_required,
+	.signal_event = smcd_signal_ieq,
+	.move_data = smcd_move,
+	.supports_v2 = smcd_supports_v2,
+	.get_local_gid = smcd_get_local_gid,
+	.get_chid = smcd_get_chid,
+	.get_dev = smcd_get_dev,
+};
+
 static void smcd_register_dev(struct ism_dev *ism)
 {
-	const struct smcd_ops *ops = ism_get_smcd_ops();
+	const struct smcd_ops *ops = &ism_smcd_ops;
 	struct smcd_dev *smcd, *fentry;
 
 	if (!ops)
@@ -499,7 +612,7 @@ static void smcd_register_dev(struct ism_dev *ism)
 	if (smc_pnetid_by_dev_port(&ism->pdev->dev, 0, smcd->pnetid))
 		smc_pnetid_by_table_smcd(smcd);
 
-	if (smcd->ops->supports_v2())
+	if (ism->ops->supports_v2())
 		smc_ism_set_v2_capable();
 	mutex_lock(&smcd_dev_list.mutex);
 	/* sort list:
diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 3c5f64ca4115..c4020653ae20 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -51,7 +51,7 @@ static int smc_lo_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
 	return 0;
 }
 
-static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
+static int smc_lo_register_dmb(struct smcd_dev *smcd, struct ism_dmb *dmb,
 			       void *client_priv)
 {
 	struct smc_lo_dmb_node *dmb_node, *tmp_node;
@@ -129,7 +129,7 @@ static void __smc_lo_unregister_dmb(struct smc_lo_dev *ldev,
 		wake_up(&ldev->ldev_release);
 }
 
-static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
+static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct ism_dmb *dmb)
 {
 	struct smc_lo_dmb_node *dmb_node = NULL, *tmp_node;
 	struct smc_lo_dev *ldev = smcd->priv;
@@ -158,7 +158,7 @@ static int smc_lo_support_dmb_nocopy(struct smcd_dev *smcd)
 	return SMC_LO_SUPPORT_NOCOPY;
 }
 
-static int smc_lo_attach_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
+static int smc_lo_attach_dmb(struct smcd_dev *smcd, struct ism_dmb *dmb)
 {
 	struct smc_lo_dmb_node *dmb_node = NULL, *tmp_node;
 	struct smc_lo_dev *ldev = smcd->priv;
-- 
2.45.2

