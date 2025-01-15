Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C681D86ED;
	Wed, 15 Jan 2025 19:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736970943; cv=none; b=Z7zjf9xIot05Pj8D/q7D5GVgNITYGhS41nuNhlXyckxGWpCwvxuRd5Kr6qM2bFdK/nRFPZHys/qu5+oMbTIMmJw4x4gus+XidX/RXNsPXj3GuApc9dv8/l0XWlb2ch2pjffb9F8FpbIraiq8rDbGN+CdHB38Q/tA9TExQ9dcUOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736970943; c=relaxed/simple;
	bh=0xIbJg6ktBGbg8LQpYCIlByVKbE247d+Z8EHLMt3Ccw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ex40dfB0fpCvebgYvFCCnWsl1sOeC4VfClyFa/tQ6ak6dzrLc6KATW36Ti3ET1tPHhosSeO9dAZSbzilr0EFRAIrhoDiLP04ArCDFEV6NVmouZK8LyR25uZsj/iQpuYlF5Zyq789ROzJVZOFwc1XdXXHDd1QECMx/jnf6A7w7J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U8bWHOnk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U8bWHOnk"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHX4fp024067;
	Wed, 15 Jan 2025 19:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=z6lUahnBOLW6mWPDB
	+99h59uUIwQEQOGhnQTZ92akko=; b=U8bWHOnk6BZoycUPzQXCOGvj7+ETGdThp
	lLHISqXWUfBykD+pM6Ft0FTeD16OrQ61YN90ThhrfOeu/OWGuBON1D+Q7xzywRin
	VsJRIxA/7sQTcVKSyYUII/J3hBKBt5Ew15VD7FHLkpct+1dOSLCfVtdd16v2qr7K
	5qqb2uvSPxEstPbEVCIuV5aIQZ/WbvjLspO01a+CR9e1DIzRo6ILBS7yTaFUqNJv
	mPNtIK47uTUI4H9/IueGVMI+r51M0HVulZEttSentJhxM1TVE6qSqzAthJZocLPE
	EDIjXRnQyCH/fxH0TV8QXgQe3MeGm49pTC8g3TY1ZR/q8ctDWkGJA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4469733c40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 19:55:32 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50FJpqHk030708;
	Wed, 15 Jan 2025 19:55:32 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4469733c3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 19:55:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50FIi3YT001330;
	Wed, 15 Jan 2025 19:55:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44456k1xbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 19:55:31 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50FJtRxZ56820008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 19:55:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC2DD2004F;
	Wed, 15 Jan 2025 19:55:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B37A2004B;
	Wed, 15 Jan 2025 19:55:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 15 Jan 2025 19:55:27 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 4BB95E0D82; Wed, 15 Jan 2025 20:55:27 +0100 (CET)
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
Subject: [RFC net-next 3/7] net/ism: Use uuid_t for ISM GID
Date: Wed, 15 Jan 2025 20:55:23 +0100
Message-ID: <20250115195527.2094320-4-wintera@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: wuVzr37PZmx3A4zghoqmOg1YOekFppic
X-Proofpoint-GUID: I6TvsXNnODiI5tIOD_mL6c69h3bRzsbC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_09,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=523 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150142

SMC uses 64 Bit and 128 Bit Global Identifiers (GIDs)
that need to be sent via the SMC protocol.
When integers are used network endianness and host endianness
need to be considered.

Avoid this in the ISM layer by using uuid_t byte arrays.
Follow on patches could do the same change for SMC, for now
conversion helper functions are introduced.

ISM-vPCI devices provide 64 Bit GIDs. Map them to ISM uuid_t GIDs
like this:
 _________________________________________
| 64 Bit ISM-vPCI GID | 00000000_00000000 |
 -----------------------------------------
If interpreted as UUID, this would be interpreted as th UIID variant,
that is reserved for NCS backward compatibility. So it will not collide
with UUIDs that were generated according to the standard.

Future ISM devices, shall use real UUIDs as 128 Bit GIDs.

Note:
- In this RFC patch smcd_gid is now moved back to smc.h,
  future patchset should avoid that.
- ism_dmb and ism_event structs still contain 64 Bit rgid and info
  fields. A future patch could change them to uuid_t gids. This
  does not break anything, because ism_loopback does not use them.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/ism.h     |  9 +++++++++
 drivers/s390/net/ism_drv.c | 16 ++++++++--------
 include/linux/ism.h        | 16 ++++++----------
 include/net/smc.h          | 12 ++++++------
 net/smc/smc_ism.c          | 13 ++++++++-----
 net/smc/smc_ism.h          | 21 +++++++++++++++++++++
 6 files changed, 58 insertions(+), 29 deletions(-)

diff --git a/drivers/s390/net/ism.h b/drivers/s390/net/ism.h
index 8b56e1d82e6b..61cf10334170 100644
--- a/drivers/s390/net/ism.h
+++ b/drivers/s390/net/ism.h
@@ -64,6 +64,15 @@ union ism_reg_ieq {
 	} response;
 } __aligned(16);
 
+/* ISM-vPCI devices provide 64 Bit GIDs
+ * Map them to ISM UUID GIDs like this:
+ *  _________________________________________
+ * | 64 Bit ISM-vPCI GID | 00000000_00000000 |
+ *  -----------------------------------------
+ * This will be interpreted as a UIID variant, that is reserved
+ * for NCS backward compatibility. So it will not collide with
+ * proper UUIDs.
+ */
 union ism_read_gid {
 	struct {
 		struct ism_req_hdr hdr;
diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 112e0d67cdd6..ab70debbdd9d 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -191,14 +191,14 @@ static int ism_read_local_gid(struct ism_dev *ism)
 	if (ret)
 		goto out;
 
-	ism->gid.gid = cmd.response.gid;
-	ism->gid.gid_ext = 0;
+	memset(&ism->gid, 0, sizeof(ism->gid));
+	memcpy(&ism->gid, &cmd.response.gid, sizeof(cmd.response.gid));
 out:
 	return ret;
 }
 
-static int ism_query_rgid(struct ism_dev *ism, struct smcd_gid *rgid,
-			  u32 vid_valid, u32 vid)
+static int ism_query_rgid(struct ism_dev *ism, uuid_t *rgid, u32 vid_valid,
+			  u32 vid)
 {
 	union ism_query_rgid cmd;
 
@@ -206,7 +206,7 @@ static int ism_query_rgid(struct ism_dev *ism, struct smcd_gid *rgid,
 	cmd.request.hdr.cmd = ISM_QUERY_RGID;
 	cmd.request.hdr.len = sizeof(cmd.request);
 
-	cmd.request.rgid = rgid->gid;
+	memcpy(&cmd.request.rgid, rgid, sizeof(cmd.request.rgid));
 	cmd.request.vlan_valid = vid_valid;
 	cmd.request.vlan_id = vid;
 
@@ -364,8 +364,8 @@ static int ism_reset_vlan_required(struct ism_dev *ism)
 	return ism_cmd_simple(ism, ISM_RESET_VLAN);
 }
 
-static int ism_signal_ieq(struct ism_dev *ism, struct smcd_gid *rgid,
-			  u32 trigger_irq, u32 event_code, u64 info)
+static int ism_signal_ieq(struct ism_dev *ism, uuid_t *rgid, u32 trigger_irq,
+			  u32 event_code, u64 info)
 {
 	union ism_sig_ieq cmd;
 
@@ -373,7 +373,7 @@ static int ism_signal_ieq(struct ism_dev *ism, struct smcd_gid *rgid,
 	cmd.request.hdr.cmd = ISM_SIGNAL_IEQ;
 	cmd.request.hdr.len = sizeof(cmd.request);
 
-	cmd.request.rgid = rgid->gid;
+	memcpy(&cmd.request.rgid, rgid, sizeof(cmd.request.rgid));
 	cmd.request.trigger_irq = trigger_irq;
 	cmd.request.event_code = event_code;
 	cmd.request.info = info;
diff --git a/include/linux/ism.h b/include/linux/ism.h
index ede1a40b408e..50975847248f 100644
--- a/include/linux/ism.h
+++ b/include/linux/ism.h
@@ -11,6 +11,7 @@
 
 #include <linux/device.h>
 #include <linux/workqueue.h>
+#include <linux/uuid.h>
 
 /* The remote peer rgid can use dmb_tok to write into this buffer. */
 struct ism_dmb {
@@ -24,11 +25,6 @@ struct ism_dmb {
 	dma_addr_t dma_addr;
 };
 
-struct smcd_gid {
-	u64	gid;
-	u64	gid_ext;
-};
-
 struct ism_event {
 	u32 type;
 	u32 code;
@@ -61,7 +57,7 @@ int ism_register_client(struct ism_client *client);
 int  ism_unregister_client(struct ism_client *client);
 
 /* Mandatory operations for all ism devices:
- * int (*query_remote_gid)(struct ism_dev *dev, struct smcd_gid *rgid,
+ * int (*query_remote_gid)(struct ism_dev *dev, uuid_t *rgid,
  *	                   u32 vid_valid, u32 vid);
  *	Query whether remote GID rgid is reachable via this device and this
  *	vlan id. Vlan id is only checked if vid_valid != 0.
@@ -101,14 +97,14 @@ int  ism_unregister_client(struct ism_client *client);
  *	Ability to assign dmbs to VLANs is missing
  *	- do we really want / need this?
  *
- * int (*signal_event)(struct ism_dev *dev, struct smcd_gid *rgid,
+ * int (*signal_event)(struct ism_dev *dev, uuid_t *rgid,
  *			    u32 trigger_irq, u32 event_code, u64 info);
  *	Send a control event into the event queue of a remote gid (rgid)
  *	with (1) or without (0) triggering an interrupt at the remote gid.
  */
 
 struct ism_ops {
-	int (*query_remote_gid)(struct ism_dev *dev, struct smcd_gid *rgid,
+	int (*query_remote_gid)(struct ism_dev *dev, uuid_t *rgid,
 				u32 vid_valid, u32 vid);
 	int (*register_dmb)(struct ism_dev *dev, struct ism_dmb *dmb,
 			    struct ism_client *client);
@@ -125,7 +121,7 @@ struct ism_ops {
 	int (*del_vlan_id)(struct ism_dev *dev, u64 vlan_id);
 	int (*set_vlan_required)(struct ism_dev *dev);
 	int (*reset_vlan_required)(struct ism_dev *dev);
-	int (*signal_event)(struct ism_dev *dev, struct smcd_gid *rgid,
+	int (*signal_event)(struct ism_dev *dev, uuid_t *rgid,
 			    u32 trigger_irq, u32 event_code, u64 info);
 };
 
@@ -150,7 +146,7 @@ struct ism_dev {
 	dma_addr_t ieq_dma_addr;
 
 	struct device dev;
-	struct smcd_gid gid;
+	uuid_t gid;
 	int ieq_idx;
 
 	struct ism_client *subs[MAX_CLIENTS];
diff --git a/include/net/smc.h b/include/net/smc.h
index 3d20c6c05056..91aab1d44166 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -15,7 +15,7 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/wait.h>
-#include "linux/ism.h"
+#include <linux/ism.h>
 
 struct sock;
 
@@ -30,11 +30,11 @@ struct smc_hashinfo {
 
 struct smcd_dev;
 
-//struct smcd_gid {
-//	u64	gid;
-//	u64	gid_ext;
-//};
-//
+struct smcd_gid {
+	u64	gid;
+	u64	gid_ext;
+};
+
 struct smcd_ops {
 	int (*query_remote_gid)(struct smcd_dev *dev, struct smcd_gid *rgid,
 				u32 vid_valid, u32 vid);
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 6fbacad02f23..a49da16bafd5 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -485,8 +485,10 @@ static int smcd_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
 			   u32 vid_valid, u32 vid)
 {
 	struct ism_dev *ism = smcd->priv;
+	uuid_t ism_rgid;
 
-	return ism->ops->query_remote_gid(ism, rgid, vid_valid, vid);
+	copy_to_ismgid(&ism_rgid, rgid);
+	return ism->ops->query_remote_gid(ism, &ism_rgid, vid_valid, vid);
 }
 
 static int smcd_register_dmb(struct smcd_dev *smcd, struct ism_dmb *dmb,
@@ -536,9 +538,11 @@ static int smcd_signal_ieq(struct smcd_dev *smcd, struct smcd_gid *rgid,
 			   u32 trigger_irq, u32 event_code, u64 info)
 {
 	struct ism_dev *ism = smcd->priv;
+	uuid_t ism_rgid;
 
-	return ism->ops->signal_event(ism, rgid,
-			      trigger_irq, event_code, info);
+	copy_to_ismgid(&ism_rgid, rgid);
+	return ism->ops->signal_event(ism, &ism_rgid, trigger_irq,
+				      event_code, info);
 }
 
 static int smcd_move(struct smcd_dev *smcd, u64 dmb_tok, unsigned int idx,
@@ -560,8 +564,7 @@ static void smcd_get_local_gid(struct smcd_dev *smcd,
 {
 	struct ism_dev *ism = smcd->priv;
 
-	smcd_gid->gid = ism->gid.gid;
-	smcd_gid->gid_ext = ism->gid.gid_ext;
+	copy_to_smcdgid(smcd_gid, &ism->gid);
 }
 
 static u16 smcd_get_chid(struct smcd_dev *smcd)
diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index 6763133dd8d0..d041e5a7c459 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -12,6 +12,7 @@
 #include <linux/uio.h>
 #include <linux/types.h>
 #include <linux/mutex.h>
+#include <linux/ism.h>
 
 #include "smc.h"
 
@@ -94,4 +95,24 @@ static inline bool smc_ism_is_loopback(struct smcd_dev *smcd)
 	return (smcd->ops->get_chid(smcd) == 0xFFFF);
 }
 
+static inline void copy_to_smcdgid(struct smcd_gid *sgid, uuid_t *igid)
+{
+	__be64 temp;
+
+	memcpy(&temp, igid, sizeof(sgid->gid));
+	sgid->gid = ntohll(temp);
+	memcpy(&temp, igid + sizeof(sgid->gid), sizeof(sgid->gid_ext));
+	sgid->gid_ext = ntohll(temp);
+}
+
+static inline void copy_to_ismgid(uuid_t *igid, struct smcd_gid *sgid)
+{
+	__be64 temp;
+
+	temp = htonll(sgid->gid);
+	memcpy(igid, &temp, sizeof(sgid->gid));
+	temp = htonll(sgid->gid_ext);
+	memcpy(igid + sizeof(sgid->gid), &temp, sizeof(sgid->gid_ext));
+}
+
 #endif
-- 
2.45.2

