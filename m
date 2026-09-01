Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710F543D4FE;
	Tue,  1 Sep 2026 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278040; cv=none; b=HlajUzr1Lz3kngPSYTz7VJ+8BxkkSLImPQde2+GuD6kc3GQP3AM2xUUK7frfrZPvmwZI5/zP86MGixAMBhe57xA8yERotC4SXR1Y7Ae4s9+ODpu51/IbKwbFSP9Fo4wOJiKBV5TrDQ+8ARscsUonxuQhbcxw+P9I8xSE+u6j2M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278040; c=relaxed/simple;
	bh=D9K9rUaHU5Ntv+qgCkH68mUA8L7kD97agGHAlGkWj0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eF7/HOxTUcOH1o1XYjb0PoiFj9MXslSBpkRhDwhu2bb0V6t8Gbj1fC6rrtClPoblr0XGHkYwehSGg40HrjRf6g/KrxpOV270WomUcoRQJfhJZIehhRRbvfr2VjS6SkrzX1Wpkxce5mbTrfXHI7JmPH6I8WslkhSeWiBgPJiVj6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rmv+tiH0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rmv+tiH0"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681EVinf1462414;
	Tue, 1 Sep 2026 15:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=zi21NaMcvyQBlOpcSU1kjAxKwrJ51JcIsyzbbAht5
	34=; b=rmv+tiH0wu7SyExtFqJjh5/b9NiwQiootnGDfRh0fbQqKwxPZtjZ1Nu6C
	fYnyFzv+avALYroy5GQLH75ETPbMAVLlfs6X9S7BHM6kcLefeZA9FyodY5v7H1y/
	OwSDkdpAXgwKEqo2we05mrBDsCCcPdPxpa/zeqSBK1GQjToKUL2XvmwZHx4eg8VJ
	1jyxT6hFp1FN0/9JDUaSnv5/nTUGs5VyW5+lIxg0Y9hj41M0gUaVQpJk+QcHJ3iG
	mTdggndexbpuj4uZGXNqr1bI929k4GNI5Yecwfl+iJUFce2UlX8zg2jsR/kqobB8
	64+fY7ItRmYnFOMwFp7Xij2CNAWvA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5gwy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 15:53:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 681Ffe9q029048;
	Tue, 1 Sep 2026 15:53:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hcgf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 15:53:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 681Frj7848431520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 15:53:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2978D2004D;
	Tue,  1 Sep 2026 15:53:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D282C2004B;
	Tue,  1 Sep 2026 15:53:44 +0000 (GMT)
Received: from t83lp71.lnxne.boe (unknown [9.87.84.240])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Sep 2026 15:53:44 +0000 (GMT)
From: Nagamani PV <nagamani@linux.ibm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: wintera@linux.ibm.com, pasic@linux.ibm.com, aswin@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        Eugene.Crosser@ru.ibm.com, ubraun@linux.vnet.ibm.com,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH net] s390/qeth: allow bridgeport queries despite OS_MISMATCH
Date: Tue,  1 Sep 2026 17:53:44 +0200
Message-ID: <20260901155344.3561483-1-nagamani@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a96f50f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=etSfBHcFTwiMQAIEi6YA:9
X-Proofpoint-GUID: 8rCF-BgCzlouFX6B1TNtTCR1hbYQm1ca
X-Proofpoint-ORIG-GUID: RsZIeUJ5aMq8cOnYhJBM1PnF0_n-xcQU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEzNyBTYWx0ZWRfX/zKN8bJncDai
 H4u9dlHPgb70tB7+5zpHrfoUhFFl+jGC30W/OQSHQo2Wguznm9jLF+Yx1vlWDhyNrO4GTQAIea5
 fIY0YmvVjItWX4+jSedaBU2WrF4tnRg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEzNyBTYWx0ZWRfX4IaKs4Xe9Pt0
 eB1SpcBopYAiiPz16sBUKC5fGCUAN2teP86E7DV0ZIIhnci2lKhy/+utrb978t4x0JpLvfVoHQe
 Iwe9Y6RYO82mu/kVNK58n4hP82306yTEWRGYLL/McTz1qSGthgUsBKIUEWOXqSXwOhaeYcPq7W6
 0UiaP75qYfIDj7/Qmv2fRrRSMyZ/1dLCi8fjmdTRrMx5ABRAfxQqgQGp4r4UIdYoAk+W3liP0h4
 i6ehx8qOkDYhTQiM2IlCjCh2MNWN6U/krn6JAUpBgSXISpWf980vylNFqPNrzyNyrHW0akT+nXv
 V1DP6brvX43/ekI+GsKW4Y/i1GnS4mllXFEskkTEapcCa++D0Ao9Zd81Fdg7hM+SLHYnRoQCXlo
 s3h2lTij66w2T4wyHB6o9cLxjYs9EUD0gbuWLz2Gf9Svmxz9oOTT7712aP9jpa1c7VzhXNBNcQV
 A8UVodqJEnNQHLPmr/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010137

When HiperSockets interfaces on the same VCHID span different OS
families, reads of the sysfs attributes bridge_role and bridge_state
fail with -EPERM if bridge port ownership belongs to another OS family.

As a result, userspace tools such as 'lszdev -ii' cannot retrieve
bridge_role and bridge_state, even though firmware returns valid bridge
port data for QUERY_BRIDGE_PORTS requests.

The firmware reports IPA_RC_SBP_IQD_OS_MISMATCH (0x0010) to indicate
that bridge port ownership belongs to a different OS family. For
QUERY_BRIDGE_PORTS operations, firmware still returns valid bridge port
data (role=none, state=inactive) together with a primary return code of
0x0000 (success).

Allow QUERY_BRIDGE_PORTS requests to return the bridge port data
provided by the firmware despite OS_MISMATCH. To make the OS family
mismatch visible to userspace, represent the firmware-reported role
"none" as "none (OS family mismatch)" while preserving the reported
bridge_state.

The behavior for non-QUERY bridge port commands is unchanged; SET
operations continue to return -EPERM when another OS family owns the
bridge port.

This restores readability of bridge_role and bridge_state.

Fixes: 1b05cf6285c1 ("qeth: Include error message for "OS Mismatch"")
Cc: stable@vger.kernel.org
Suggested-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Nagamani PV <nagamani@linux.ibm.com>
---
 drivers/s390/net/qeth_l2.h      |  3 ++-
 drivers/s390/net/qeth_l2_main.c | 26 ++++++++++++++++++++++----
 drivers/s390/net/qeth_l2_sys.c  |  7 ++++++-
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/net/qeth_l2.h b/drivers/s390/net/qeth_l2.h
index 7c646e2fed7e..f94975e970ca 100644
--- a/drivers/s390/net/qeth_l2.h
+++ b/drivers/s390/net/qeth_l2.h
@@ -13,7 +13,8 @@ extern const struct attribute_group *qeth_l2_attr_groups[];
 
 int qeth_bridgeport_query_ports(struct qeth_card *card,
 				enum qeth_sbp_roles *role,
-				enum qeth_sbp_states *state);
+				enum qeth_sbp_states *state,
+				bool *os_mismatch);
 int qeth_bridgeport_setrole(struct qeth_card *card, enum qeth_sbp_roles role);
 int qeth_bridgeport_an_set(struct qeth_card *card, int enable);
 
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index a9e7d1d637a2..2935c2ecc314 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1158,7 +1158,7 @@ static void qeth_l2_setup_bridgeport_attrs(struct qeth_card *card)
 		qeth_bridgeport_setrole(card, card->options.sbp.role);
 		/* Let the callback function refresh the stored role value. */
 		qeth_bridgeport_query_ports(card, &card->options.sbp.role,
-					    NULL);
+					    NULL, NULL);
 	}
 	if (card->options.sbp.hostnotification) {
 		if (qeth_bridgeport_an_set(card, 1))
@@ -1545,6 +1545,7 @@ struct _qeth_sbp_cbctl {
 		struct {
 			enum qeth_sbp_roles *role;
 			enum qeth_sbp_states *state;
+			bool *os_mismatch;
 		} qports;
 	} data;
 };
@@ -1721,10 +1722,19 @@ static int qeth_bridgeport_query_ports_cb(struct qeth_card *card,
 	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
 	struct _qeth_sbp_cbctl *cbctl = (struct _qeth_sbp_cbctl *)reply->param;
 	struct qeth_sbp_port_data *qports;
+	u16 sbp_rc;
 	int rc;
 
 	QETH_CARD_TEXT(card, 2, "brqprtcb");
-	rc = qeth_bridgeport_makerc(card, cmd);
+	sbp_rc = cmd->data.sbp.hdr.return_code;
+
+	/* on OS family mismatch, query still returns valid port data;
+	 * treat as success
+	 */
+	if (sbp_rc == IPA_RC_SBP_IQD_OS_MISMATCH && !cmd->hdr.return_code)
+		rc = 0;
+	else
+		rc = qeth_bridgeport_makerc(card, cmd);
 	if (rc)
 		return rc;
 
@@ -1740,6 +1750,9 @@ static int qeth_bridgeport_query_ports_cb(struct qeth_card *card,
 		if (cbctl->data.qports.state)
 			*cbctl->data.qports.state = qports->entry[0].state;
 	}
+	if (cbctl->data.qports.os_mismatch)
+		*cbctl->data.qports.os_mismatch =
+			(sbp_rc == IPA_RC_SBP_IQD_OS_MISMATCH);
 	return 0;
 }
 
@@ -1748,13 +1761,17 @@ static int qeth_bridgeport_query_ports_cb(struct qeth_card *card,
  * @card:			   qeth_card structure pointer.
  * @role:   Role of the port: 0-none, 1-primary, 2-secondary.
  * @state:  State of the port: 0-inactive, 1-standby, 2-active.
+ * @os_mismatch: if non-NULL, set to true when firmware reports
+ *		 OS family mismatch.
  *
  * Returns negative errno-compatible error indication or 0 on success.
  *
- * 'role' and 'state' are not updated in case of hardware operation failure.
+ * 'role', 'state' and 'os_mismatch' are not updated in case of
+ * hardware operation failure.
  */
 int qeth_bridgeport_query_ports(struct qeth_card *card,
-	enum qeth_sbp_roles *role, enum qeth_sbp_states *state)
+	enum qeth_sbp_roles *role, enum qeth_sbp_states *state,
+	bool *os_mismatch)
 {
 	struct qeth_cmd_buffer *iob;
 	struct _qeth_sbp_cbctl cbctl = {
@@ -1762,6 +1779,7 @@ int qeth_bridgeport_query_ports(struct qeth_card *card,
 			.qports = {
 				.role = role,
 				.state = state,
+				.os_mismatch = os_mismatch,
 			},
 		},
 	};
diff --git a/drivers/s390/net/qeth_l2_sys.c b/drivers/s390/net/qeth_l2_sys.c
index 7f592f912517..7101be62eb1d 100644
--- a/drivers/s390/net/qeth_l2_sys.c
+++ b/drivers/s390/net/qeth_l2_sys.c
@@ -15,6 +15,7 @@ static ssize_t qeth_bridge_port_role_state_show(struct device *dev,
 {
 	struct qeth_card *card = dev_get_drvdata(dev);
 	enum qeth_sbp_states state = QETH_SBP_STATE_INACTIVE;
+	bool os_mismatch = false;
 	int rc = 0;
 	char *word;
 
@@ -25,7 +26,7 @@ static ssize_t qeth_bridge_port_role_state_show(struct device *dev,
 	if (qeth_card_hw_is_reachable(card) &&
 					card->options.sbp.supported_funcs)
 		rc = qeth_bridgeport_query_ports(card,
-			&card->options.sbp.role, &state);
+			&card->options.sbp.role, &state, &os_mismatch);
 	if (!rc) {
 		if (show_state)
 			switch (state) {
@@ -52,6 +53,10 @@ static ssize_t qeth_bridge_port_role_state_show(struct device *dev,
 		if (rc)
 			QETH_CARD_TEXT_(card, 2, "SBP%02x:%02x",
 				card->options.sbp.role, state);
+		else if (!show_state &&
+			 card->options.sbp.role == QETH_SBP_ROLE_NONE &&
+			 os_mismatch)
+			rc = sysfs_emit(buf, "%s (OS family mismatch)\n", word);
 		else
 			rc = sysfs_emit(buf, "%s\n", word);
 	}
-- 
2.53.0

