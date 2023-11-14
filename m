Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41D8C4332F
	for <linux-s390@archiver.kernel.org>; Tue, 14 Nov 2023 09:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjKNJVB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Nov 2023 04:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjKNJVA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Nov 2023 04:21:00 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE7B132;
        Tue, 14 Nov 2023 01:20:56 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AE8qHCE019234;
        Tue, 14 Nov 2023 09:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=Ks2hsF7gZAH/CA2oPifrySYvXDbnvpyOc24DwlQLRRI=;
 b=bgWiz2oJ6ZZlvNaRfX/eoFNWpxEFkmlmCuh2oAPoECxKyakiM7d2ZaogY37d4da01QWP
 rl+REUqEpwaV+nRZZNgcp0NTQXJI5pb5zo/lJmFFXgWBlDUZxke3Rn0ucNkA0mmctpIC
 X1OVAYkli5k4uD7NhumW4xVoMsSeOlmMoK45VrpM2n1Fmdebtxxn1tXbNtjQvsS16A3U
 J/8MU9kARcnxHPMx7jVB2OzY4ux/sirPFbh56ntNrAXU9qvSsDMPlfDSChp5akA2DspC
 f1U/lhGOEZDstJTMh27uQmtcxs1WirDLqAIAvWw6bXi3wh066ULTHfJkLjTAtM+n/OsY pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uc5rtgs02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 09:20:42 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AE99XZ0013503;
        Tue, 14 Nov 2023 09:20:42 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uc5rtgrx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 09:20:42 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AE8HBML029383;
        Tue, 14 Nov 2023 09:17:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uakxsq44v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 09:17:22 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AE9HJPo45089462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 09:17:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BB6C20043;
        Tue, 14 Nov 2023 09:17:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1ED720040;
        Tue, 14 Nov 2023 09:17:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Nov 2023 09:17:18 +0000 (GMT)
From:   Gerd Bayer <gbayer@linux.ibm.com>
To:     Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Simon Horman <horms@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, dust.li@linux.alibaba.com,
        Gerd Bayer <gbayer@linux.ibm.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH net] s390/ism: ism driver implies smc protocol
Date:   Tue, 14 Nov 2023 10:17:18 +0100
Message-Id: <20231114091718.3482624-1-gbayer@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <b152ec7c0e690027da1086b777a3ec512001ba1f.camel@linux.ibm.com>
References: <b152ec7c0e690027da1086b777a3ec512001ba1f.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p6faRSdtuUaeLj9kgRrzykTDpW0F4nCP
X-Proofpoint-ORIG-GUID: ApJWhliNsGoyPriNAESks3LX29EEEAZF
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_08,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 mlxscore=0 clxscore=1011 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311140072
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Since commit a72178cfe855 ("net/smc: Fix dependency of SMC on ISM")
you can build the ism code without selecting the SMC network protocol.
That leaves some ism functions be reported as unused. Move these
functions under the conditional compile with CONFIG_SMC.

Also codify the suggestion to also configure the SMC protocol in ism's
Kconfig - but with an "imply" rather than a "select" as SMC depends on
other config options and allow for a deliberate decision not to build
SMC. Also, mention that in ISM's help.

Fixes: a72178cfe855 ("net/smc: Fix dependency of SMC on ISM")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/netdev/afd142a2-1fa0-46b9-8b2d-7652d41d3ab8@infradead.org/
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
---

Hi Randy,

sorry for the long wait. We had some internal discussions about how to 
tackle this and decided to send out the short-term solution first and 
work on better isolating the ISM device and SMC protocol together 
with the work to extend ISM,
e.g. at https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/

Cheers, Gerd

 drivers/s390/net/Kconfig   |  3 +-
 drivers/s390/net/ism_drv.c | 92 +++++++++++++++++++-------------------
 2 files changed, 48 insertions(+), 47 deletions(-)

diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
index 4902d45e929c..c61e6427384c 100644
--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -103,10 +103,11 @@ config CCWGROUP
 config ISM
 	tristate "Support for ISM vPCI Adapter"
 	depends on PCI
+	imply SMC
 	default n
 	help
 	  Select this option if you want to use the Internal Shared Memory
-	  vPCI Adapter.
+	  vPCI Adapter. The adapter can be used with the SMC network protocol.
 
 	  To compile as a module choose M. The module name is ism.
 	  If unsure, choose N.
diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 6df7f377d2f9..ec112a00b135 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -289,22 +289,6 @@ static int ism_read_local_gid(struct ism_dev *ism)
 	return ret;
 }
 
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
 static void ism_free_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 {
 	clear_bit(dmb->sba_idx, ism->sba_bitmap);
@@ -429,23 +413,6 @@ static int ism_del_vlan_id(struct ism_dev *ism, u64 vlan_id)
 	return ism_cmd(ism, &cmd);
 }
 
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
 static unsigned int max_bytes(unsigned int start, unsigned int len,
 			      unsigned int boundary)
 {
@@ -503,14 +470,6 @@ u8 *ism_get_seid(void)
 }
 EXPORT_SYMBOL_GPL(ism_get_seid);
 
-static u16 ism_get_chid(struct ism_dev *ism)
-{
-	if (!ism || !ism->pdev)
-		return 0;
-
-	return to_zpci(ism->pdev)->pchid;
-}
-
 static void ism_handle_event(struct ism_dev *ism)
 {
 	struct ism_event *entry;
@@ -569,11 +528,6 @@ static irqreturn_t ism_handle_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static u64 ism_get_local_gid(struct ism_dev *ism)
-{
-	return ism->local_gid;
-}
-
 static int ism_dev_init(struct ism_dev *ism)
 {
 	struct pci_dev *pdev = ism->pdev;
@@ -774,6 +728,22 @@ module_exit(ism_exit);
 /*************************** SMC-D Implementation *****************************/
 
 #if IS_ENABLED(CONFIG_SMC)
+static int ism_query_rgid(struct ism_dev *ism, u64 rgid, u32 vid_valid,
+			  u32 vid)
+{
+	union ism_query_rgid cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.request.hdr.cmd = ISM_QUERY_RGID;
+	cmd.request.hdr.len = sizeof(cmd.request);
+
+	cmd.request.rgid = rgid;
+	cmd.request.vlan_valid = vid_valid;
+	cmd.request.vlan_id = vid;
+
+	return ism_cmd(ism, &cmd);
+}
+
 static int smcd_query_rgid(struct smcd_dev *smcd, u64 rgid, u32 vid_valid,
 			   u32 vid)
 {
@@ -811,6 +781,23 @@ static int smcd_reset_vlan_required(struct smcd_dev *smcd)
 	return ism_cmd_simple(smcd->priv, ISM_RESET_VLAN);
 }
 
+static int ism_signal_ieq(struct ism_dev *ism, u64 rgid, u32 trigger_irq,
+			  u32 event_code, u64 info)
+{
+	union ism_sig_ieq cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.request.hdr.cmd = ISM_SIGNAL_IEQ;
+	cmd.request.hdr.len = sizeof(cmd.request);
+
+	cmd.request.rgid = rgid;
+	cmd.request.trigger_irq = trigger_irq;
+	cmd.request.event_code = event_code;
+	cmd.request.info = info;
+
+	return ism_cmd(ism, &cmd);
+}
+
 static int smcd_signal_ieq(struct smcd_dev *smcd, u64 rgid, u32 trigger_irq,
 			   u32 event_code, u64 info)
 {
@@ -830,11 +817,24 @@ static int smcd_supports_v2(void)
 		SYSTEM_EID.type[0] != '0';
 }
 
+static u64 ism_get_local_gid(struct ism_dev *ism)
+{
+	return ism->local_gid;
+}
+
 static u64 smcd_get_local_gid(struct smcd_dev *smcd)
 {
 	return ism_get_local_gid(smcd->priv);
 }
 
+static u16 ism_get_chid(struct ism_dev *ism)
+{
+	if (!ism || !ism->pdev)
+		return 0;
+
+	return to_zpci(ism->pdev)->pchid;
+}
+
 static u16 smcd_get_chid(struct smcd_dev *smcd)
 {
 	return ism_get_chid(smcd->priv);
-- 
2.39.2

