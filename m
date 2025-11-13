Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B16E2727E3;
	Thu, 13 Nov 2025 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763044945; cv=none; b=NZDWr94Dga8pIq/HPfSXaqLCBK5k4gG5JDGMENrEsb3z/4wI9jPNs8s2NSq7kY5LdEaZPV3+hUAMqF9aRUdagh11QtabnBypI/T0wTduq3sbQ0mYep9C2FYJccWrSUHw+7qH1hR35cPqc2PYpEI9+gJ/0mvMvPjRC/CdDTebAzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763044945; c=relaxed/simple;
	bh=kPzkD+mzHbiOKwWpJHoXl0aqGEAPtHWrATwpYGcScts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALbdbRzDjIiG7MB/6omNAJgPhikW7GoQC7M+Rpwyf/k5BfX8nvsh68XNbJQkEwLa6kplWG1JY2U2EUuqE3EMiLTkFvWYQl/U3GQBfXvhNgNFQNHhlmj3FB/8N9d6Js0pm6zHEEJKIGwfneA3wuVEYXccUb3sVnn32VX2syCMPSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LyR4ed1O; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LyR4ed1O"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD8Rdj9014326;
	Thu, 13 Nov 2025 14:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VI42vXeFgD3OygQjD
	ahOjhajfMguSReihXy3mp+11iw=; b=LyR4ed1OLZMKvALkRkzpTi6c95jIANceq
	927QVGZtLSMkwHgiQ/NPUhy3/s2XBoDSNu/Uy5YZchstdmoAx0cLOnGuDU03w9Il
	5X5BFLCiKIjMdlApOYrbNirQ1bySwjRipaYnP3NBmghQYKUANcEBhNUlk258bxHl
	Ft4w7uILYgL2YQgyKYcA4Ra+eiLsPs6ODWZ9Qn4jsJ4oVR5F+ehXNPtWxJBu5Ee2
	mgQhA9GCatepHmPNn5Nemd7eBdHm94k78QWhykpIxHWom0MiegYJ67O7wJuDvzhC
	53xGwS5UmPb3NgGs+dfOZYrRJKPf9qEPmo+dhwY0Npc2H6mfdS/Vw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cjfav9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 14:42:15 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ADEPYdP006978;
	Thu, 13 Nov 2025 14:42:14 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cjfav6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 14:42:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADDETWf011738;
	Thu, 13 Nov 2025 14:42:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw1nyrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 14:42:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ADEgAMj42992008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 14:42:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0868720040;
	Thu, 13 Nov 2025 14:42:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4F5F20043;
	Thu, 13 Nov 2025 14:42:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 14:42:09 +0000 (GMT)
From: Aswin Karuvally <aswin@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 2/2] s390/qeth: Handle ambiguous OSA RCs in s390dbf
Date: Thu, 13 Nov 2025 15:42:09 +0100
Message-ID: <20251113144209.2140061-3-aswin@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251113144209.2140061-1-aswin@linux.ibm.com>
References: <20251113144209.2140061-1-aswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Ss+dKfO0 c=1 sm=1 tr=0 ts=6915ee47 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=ofFlFg1OaLejxKYsNrkA:9 a=IKs53RWCGyS3Mz5y:21 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5NSBTYWx0ZWRfX4zyGTRjUOmed
 2Sx96JgvIthYwDPcZztMEk8mTc9xTSwB8HwDDuTJfettfTmNp3HkVUgizoXV3b+9AMDDv6/+nN1
 mGzaGvfNLo+ieSFqyeX9HWqCyWlpZ2R2A99iebFjsB4zqk7kxMT1x1R58E3J/45eLXOxK4xlxyT
 TVFdHnurV0ai00XXDonrI1xul9SN0h6JkTyBjyulzhKQmHoVirjIhgcNqUGTFJQFT6i7RAHryEz
 KgeXvHDq5x6eP2Eo35Pqy9PdcIEXZ30gfb5/s5qKyVL0PzEZoCvTT0GLM7ADsDdPehuSYXjeBVR
 5eKftYNQqD3KvoOgH2Iq30/wxai6uz1FXfeVp9i4vNxFfQILesCgoEn+qYod9+4XnqZDz+qFSyr
 9kevsDEnY+MPYTfrkowgf41uH0uHKA==
X-Proofpoint-GUID: crj_NkADv1skKNAZDf19Z-6-tMsjgaBL
X-Proofpoint-ORIG-GUID: ZyiFWQP-pYmG3h45YDktfQISjkZ9yrgR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080095

OSA Express defines a number of return codes whose meaning is determined
by the issuing command, making them ambiguous. The important ones are
reported as debug messages through the s390 debug feature.

The qeth driver currently does not take the issuing command into account
when interpreting the return code which sometimes leads to incorrect
debug messages.

Implement a mechanism to interpret and report these return codes
properly. While at it, remove extern keyword and fix indentation for
function declarations to be in line with Linux kernel coding style.

Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Aswin Karuvally <aswin@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c |   2 +-
 drivers/s390/net/qeth_core_mpc.c  | 247 ++++++++++++++++++++++++------
 drivers/s390/net/qeth_core_mpc.h  |   5 +-
 3 files changed, 205 insertions(+), 49 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index edc0bcd46923..10b53bba373c 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -761,7 +761,7 @@ static void qeth_issue_ipa_msg(struct qeth_ipa_cmd *cmd, int rc,
 	if (rc)
 		QETH_DBF_MESSAGE(2, "IPA: %s(%#x) for device %x returned %#x \"%s\"\n",
 				 ipa_name, com, CARD_DEVID(card), rc,
-				 qeth_get_ipa_msg(rc));
+				 qeth_get_ipa_msg(com, rc));
 	else
 		QETH_DBF_MESSAGE(5, "IPA: %s(%#x) for device %x succeeded\n",
 				 ipa_name, com, CARD_DEVID(card));
diff --git a/drivers/s390/net/qeth_core_mpc.c b/drivers/s390/net/qeth_core_mpc.c
index d9266f7d8187..1add124e033b 100644
--- a/drivers/s390/net/qeth_core_mpc.c
+++ b/drivers/s390/net/qeth_core_mpc.c
@@ -139,82 +139,237 @@ struct ipa_rc_msg {
 	const char *msg;
 };
 
-static const struct ipa_rc_msg qeth_ipa_rc_msg[] = {
+static const struct ipa_rc_msg qeth_ipa_rc_def_msg[] = {
 	{IPA_RC_SUCCESS,		"success"},
 	{IPA_RC_NOTSUPP,		"Command not supported"},
-	{IPA_RC_IP_TABLE_FULL,		"Add Addr IP Table Full - ipv6"},
-	{IPA_RC_UNKNOWN_ERROR,		"IPA command failed - reason unknown"},
 	{IPA_RC_UNSUPPORTED_COMMAND,	"Command not supported"},
-	{IPA_RC_VNICC_OOSEQ,		"Command issued out of sequence"},
-	{IPA_RC_INVALID_FORMAT,		"invalid format or length"},
 	{IPA_RC_DUP_IPV6_REMOTE, "ipv6 address already registered remote"},
-	{IPA_RC_SBP_IQD_NOT_CONFIGURED,	"Not configured for bridgeport"},
 	{IPA_RC_DUP_IPV6_HOME,		"ipv6 address already registered"},
 	{IPA_RC_UNREGISTERED_ADDR,	"Address not registered"},
-	{IPA_RC_NO_ID_AVAILABLE,	"No identifiers available"},
 	{IPA_RC_ID_NOT_FOUND,		"Identifier not found"},
-	{IPA_RC_SBP_IQD_ANO_DEV_PRIMARY, "Primary bridgeport exists already"},
-	{IPA_RC_SBP_IQD_CURRENT_SECOND,	"Bridgeport is currently secondary"},
-	{IPA_RC_SBP_IQD_LIMIT_SECOND, "Limit of secondary bridgeports reached"},
-	{IPA_RC_INVALID_IP_VERSION,	"IP version incorrect"},
-	{IPA_RC_SBP_IQD_CURRENT_PRIMARY, "Bridgeport is currently primary"},
 	{IPA_RC_LAN_FRAME_MISMATCH,	"LAN and frame mismatch"},
-	{IPA_RC_SBP_IQD_NO_QDIO_QUEUES,	"QDIO queues not established"},
 	{IPA_RC_L2_UNSUPPORTED_CMD,	"Unsupported layer 2 command"},
-	{IPA_RC_L2_DUP_MAC,		"Duplicate MAC address"},
 	{IPA_RC_L2_ADDR_TABLE_FULL,	"Layer2 address table full"},
-	{IPA_RC_L2_DUP_LAYER3_MAC,	"Duplicate with layer 3 MAC"},
-	{IPA_RC_L2_GMAC_NOT_FOUND,	"GMAC not found"},
-	{IPA_RC_L2_MAC_NOT_AUTH_BY_HYP,	"L2 mac not authorized by hypervisor"},
 	{IPA_RC_L2_MAC_NOT_AUTH_BY_ADP,	"L2 mac not authorized by adapter"},
-	{IPA_RC_L2_MAC_NOT_FOUND,	"L2 mac address not found"},
-	{IPA_RC_L2_INVALID_VLAN_ID,	"L2 invalid vlan id"},
-	{IPA_RC_L2_DUP_VLAN_ID,		"L2 duplicate vlan id"},
-	{IPA_RC_L2_VLAN_ID_NOT_FOUND,	"L2 vlan id not found"},
-	{IPA_RC_VNICC_VNICBP,		"VNIC is BridgePort"},
-	{IPA_RC_SBP_OSA_NOT_CONFIGURED,	"Not configured for bridgeport"},
-	{IPA_RC_SBP_OSA_OS_MISMATCH,	"OS mismatch"},
-	{IPA_RC_SBP_OSA_ANO_DEV_PRIMARY, "Primary bridgeport exists already"},
-	{IPA_RC_SBP_OSA_CURRENT_SECOND,	"Bridgeport is currently secondary"},
-	{IPA_RC_SBP_OSA_LIMIT_SECOND, "Limit of secondary bridgeports reached"},
-	{IPA_RC_SBP_OSA_NOT_AUTHD_BY_ZMAN, "Not authorized by zManager"},
-	{IPA_RC_SBP_OSA_CURRENT_PRIMARY, "Bridgeport is currently primary"},
-	{IPA_RC_SBP_OSA_NO_QDIO_QUEUES,	"QDIO queues not established"},
 	{IPA_RC_DATA_MISMATCH,		"Data field mismatch (v4/v6 mixed)"},
 	{IPA_RC_INVALID_MTU_SIZE,	"Invalid MTU size"},
 	{IPA_RC_INVALID_LANTYPE,	"Invalid LAN type"},
 	{IPA_RC_INVALID_LANNUM,		"Invalid LAN num"},
-	{IPA_RC_DUPLICATE_IP_ADDRESS,	"Address already registered"},
-	{IPA_RC_IP_ADDR_TABLE_FULL,	"IP address table full"},
 	{IPA_RC_LAN_PORT_STATE_ERROR,	"LAN port state error"},
 	{IPA_RC_SETIP_NO_STARTLAN,	"Setip no startlan received"},
 	{IPA_RC_SETIP_ALREADY_RECEIVED,	"Setip already received"},
-	{IPA_RC_IP_ADDR_ALREADY_USED,	"IP address already in use on LAN"},
-	{IPA_RC_MC_ADDR_NOT_FOUND,	"Multicast address not found"},
 	{IPA_RC_SETIP_INVALID_VERSION,	"SETIP invalid IP version"},
 	{IPA_RC_UNSUPPORTED_SUBCMD,	"Unsupported assist subcommand"},
 	{IPA_RC_ARP_ASSIST_NO_ENABLE,	"Only partial success, no enable"},
-	{IPA_RC_PRIMARY_ALREADY_DEFINED, "Primary already defined"},
-	{IPA_RC_SECOND_ALREADY_DEFINED,	"Secondary already defined"},
-	{IPA_RC_INVALID_SETRTG_INDICATOR, "Invalid SETRTG indicator"},
-	{IPA_RC_MC_ADDR_ALREADY_DEFINED, "Multicast address already defined"},
-	{IPA_RC_LAN_OFFLINE,		"STRTLAN_LAN_DISABLED - LAN offline"},
-	{IPA_RC_VEPA_TO_VEB_TRANSITION,	"Adj. switch disabled port mode RR"},
 	{IPA_RC_INVALID_IP_VERSION2,	"Invalid IP version"},
 	/* default for qeth_get_ipa_msg(): */
 	{IPA_RC_FFFF,			"Unknown Error"}
 };
 
-const char *qeth_get_ipa_msg(enum qeth_ipa_return_codes rc)
+static const struct ipa_rc_msg qeth_ipa_rc_adp_parms_msg[] = {
+	{IPA_RC_IP_TABLE_FULL,	"Add Addr IP Table Full - ipv6"}
+};
+
+static const struct ipa_rc_msg qeth_ipa_rc_diag_ass_msg[] = {
+	{IPA_RC_INVALID_FORMAT,	"invalid format or length"}
+};
+
+static const struct ipa_rc_msg qeth_ipa_rc_addr_msg[] = {
+	{IPA_RC_UNKNOWN_ERROR,	 "IPA command failed - reason unknown"},
+	{IPA_RC_NO_ID_AVAILABLE, "No identifiers available"},
+	{IPA_RC_INVALID_IP_VERSION,	"IP version incorrect"}
+};
+
+static const struct ipa_rc_msg qeth_ipa_rc_vnicc_msg[] = {
+	{IPA_RC_VNICC_OOSEQ,	"Command issued out of sequence"},
+	{IPA_RC_VNICC_VNICBP,	"VNIC is BridgePort"}
+};
+
+static const struct ipa_rc_msg qeth_ipa_rc_sbp_iqd_msg[] = {
+	{IPA_RC_SBP_IQD_NOT_CONFIGURED,	"Not configured for bridgeport"},
+	{IPA_RC_SBP_IQD_OS_MISMATCH,	"OS mismatch"},
+	{IPA_RC_SBP_IQD_ANO_DEV_PRIMARY, "Primary bridgeport exists already"},
+	{IPA_RC_SBP_IQD_CURRENT_SECOND,	"Bridgeport is currently secondary"},
+	{IPA_RC_SBP_IQD_LIMIT_SECOND, "Limit of secondary bridgeports reached"},
+	{IPA_RC_SBP_IQD_NOT_AUTHD_BY_ZMAN, "Not authorized by zManager"},
+	{IPA_RC_SBP_IQD_CURRENT_PRIMARY, "Bridgeport is currently primary"},
+	{IPA_RC_SBP_IQD_NO_QDIO_QUEUES,	"QDIO queues not established"}
+};
+
+static const struct ipa_rc_msg qeth_ipa_rc_sbp_osa_msg[] = {
+	{IPA_RC_SBP_OSA_NOT_CONFIGURED,	"Not configured for bridgeport"},
+	{IPA_RC_SBP_OSA_OS_MISMATCH,	"OS mismatch"},
+	{IPA_RC_SBP_OSA_ANO_DEV_PRIMARY, "Primary bridgeport exists already"},
+	{IPA_RC_SBP_OSA_CURRENT_SECOND,	"Bridgeport is currently secondary"},
+	{IPA_RC_SBP_OSA_LIMIT_SECOND, "Limit of secondary bridgeports reached"},
+	{IPA_RC_SBP_OSA_NOT_AUTHD_BY_ZMAN, "Not authorized by zManager"},
+	{IPA_RC_SBP_OSA_CURRENT_PRIMARY, "Bridgeport is currently primary"},
+	{IPA_RC_SBP_OSA_NO_QDIO_QUEUES,	"QDIO queues not established"}
+};
+
+static const struct ipa_rc_msg qeth_ipa_rc_mac_msg[] = {
+	{IPA_RC_L2_DUP_MAC,	   "Duplicate MAC address"},
+	{IPA_RC_L2_DUP_LAYER3_MAC, "Duplicate with layer 3 MAC"},
+	{IPA_RC_L2_GMAC_NOT_FOUND, "GMAC not found"},
+	{IPA_RC_L2_MAC_NOT_AUTH_BY_HYP,	"L2 mac not authorized by hypervisor"},
+	{IPA_RC_L2_MAC_NOT_FOUND,  "L2 mac address not found"}
+};
+
+static const struct ipa_rc_msg qeth_ipa_rc_ip_msg[] = {
+	{IPA_RC_DUPLICATE_IP_ADDRESS,	"Address already registered"},
+	{IPA_RC_IP_ADDR_TABLE_FULL,	"IP address table full"},
+	{IPA_RC_IP_ADDR_ALREADY_USED,	"IP address already in use on LAN"},
+	{IPA_RC_MC_ADDR_NOT_FOUND,	"Multicast address not found"}
+};
+
+static const struct ipa_rc_msg qeth_ipa_rc_lan_msg[] = {
+	{IPA_RC_LAN_OFFLINE,		"STRTLAN_LAN_DISABLED - LAN offline"},
+	{IPA_RC_VEPA_TO_VEB_TRANSITION,	"Adj. switch disabled port mode RR"},
+};
+
+static const struct ipa_rc_msg qeth_ipa_rc_vlan_msg[] = {
+	{IPA_RC_L2_INVALID_VLAN_ID,	"L2 invalid vlan id"},
+	{IPA_RC_L2_DUP_VLAN_ID,		"L2 duplicate vlan id"},
+	{IPA_RC_L2_VLAN_ID_NOT_FOUND,	"L2 vlan id not found"}
+};
+
+static const struct ipa_rc_msg qeth_ipa_rc_rtg_msg[] = {
+	{IPA_RC_PRIMARY_ALREADY_DEFINED, "Primary already defined"},
+	{IPA_RC_SECOND_ALREADY_DEFINED,	"Secondary already defined"},
+	{IPA_RC_INVALID_SETRTG_INDICATOR, "Invalid SETRTG indicator"},
+	{IPA_RC_MC_ADDR_ALREADY_DEFINED, "Multicast address already defined"}
+};
+
+struct ipa_cmd_rc_map {
+	enum qeth_ipa_cmds cmd;
+	const struct ipa_rc_msg *msg_arr;
+	const size_t arr_len;
+};
+
+static const struct ipa_cmd_rc_map qeth_ipa_cmd_rc_map[] = {
+	{
+		.cmd = IPA_CMD_SETADAPTERPARMS,
+		.msg_arr = qeth_ipa_rc_adp_parms_msg,
+		.arr_len = ARRAY_SIZE(qeth_ipa_rc_adp_parms_msg)
+	},
+	{
+		.cmd = IPA_CMD_SET_DIAG_ASS,
+		.msg_arr = qeth_ipa_rc_diag_ass_msg,
+		.arr_len = ARRAY_SIZE(qeth_ipa_rc_diag_ass_msg)
+	},
+	{
+		.cmd = IPA_CMD_CREATE_ADDR,
+		.msg_arr = qeth_ipa_rc_addr_msg,
+		.arr_len = ARRAY_SIZE(qeth_ipa_rc_addr_msg)
+	},
+	{
+		.cmd = IPA_CMD_DESTROY_ADDR,
+		.msg_arr = qeth_ipa_rc_addr_msg,
+		.arr_len = ARRAY_SIZE(qeth_ipa_rc_addr_msg)
+	},
+	{
+		.cmd = IPA_CMD_VNICC,
+		.msg_arr = qeth_ipa_rc_vnicc_msg,
+		.arr_len = ARRAY_SIZE(qeth_ipa_rc_vnicc_msg)
+	},
+	{
+		.cmd = IPA_CMD_SETBRIDGEPORT_IQD,
+		.msg_arr = qeth_ipa_rc_sbp_iqd_msg,
+		.arr_len = ARRAY_SIZE(qeth_ipa_rc_sbp_iqd_msg)
+	},
+	{
+		.cmd = IPA_CMD_SETBRIDGEPORT_OSA,
+		.msg_arr = qeth_ipa_rc_sbp_osa_msg,
+		.arr_len = ARRAY_SIZE(qeth_ipa_rc_sbp_osa_msg)
+	},
+	{
+		.cmd = IPA_CMD_SETVMAC,
+		.msg_arr = qeth_ipa_rc_mac_msg,
+		.arr_len = ARRAY_SIZE(qeth_ipa_rc_mac_msg)
+	},
+	{
+		.cmd = IPA_CMD_DELVMAC,
+		.msg_arr = qeth_ipa_rc_mac_msg,
+		.arr_len = ARRAY_SIZE(qeth_ipa_rc_mac_msg)
+	},
+	{
+		.cmd = IPA_CMD_SETGMAC,
+		.msg_arr = qeth_ipa_rc_mac_msg,
+		.arr_len = ARRAY_SIZE(qeth_ipa_rc_mac_msg)
+	},
+	{
+		.cmd = IPA_CMD_DELGMAC,
+		.msg_arr = qeth_ipa_rc_mac_msg,
+		.arr_len = ARRAY_SIZE(qeth_ipa_rc_mac_msg)
+	},
+	{
+		.cmd = IPA_CMD_SETIP,
+		.msg_arr = qeth_ipa_rc_ip_msg,
+		.arr_len = ARRAY_SIZE(qeth_ipa_rc_ip_msg)
+	},
+	{
+		.cmd = IPA_CMD_SETIPM,
+		.msg_arr = qeth_ipa_rc_ip_msg,
+		.arr_len = ARRAY_SIZE(qeth_ipa_rc_ip_msg)
+	},
+	{
+		.cmd = IPA_CMD_DELIPM,
+		.msg_arr = qeth_ipa_rc_ip_msg,
+		.arr_len = ARRAY_SIZE(qeth_ipa_rc_ip_msg)
+	},
+	{
+		.cmd = IPA_CMD_STARTLAN,
+		.msg_arr = qeth_ipa_rc_lan_msg,
+		.arr_len = ARRAY_SIZE(qeth_ipa_rc_lan_msg)
+	},
+	{
+		.cmd = IPA_CMD_STOPLAN,
+		.msg_arr = qeth_ipa_rc_lan_msg,
+		.arr_len = ARRAY_SIZE(qeth_ipa_rc_lan_msg)
+	},
+	{
+		.cmd = IPA_CMD_SETVLAN,
+		.msg_arr = qeth_ipa_rc_vlan_msg,
+		.arr_len = ARRAY_SIZE(qeth_ipa_rc_vlan_msg)
+	},
+	{
+		.cmd = IPA_CMD_DELVLAN,
+		.msg_arr = qeth_ipa_rc_vlan_msg,
+		.arr_len = ARRAY_SIZE(qeth_ipa_rc_vlan_msg)
+	},
+	{
+		.cmd = IPA_CMD_SETRTG,
+		.msg_arr = qeth_ipa_rc_rtg_msg,
+		.arr_len = ARRAY_SIZE(qeth_ipa_rc_rtg_msg)
+	}
+};
+
+const char *qeth_get_ipa_msg(enum qeth_ipa_cmds cmd,
+			     enum qeth_ipa_return_codes rc)
 {
 	int x;
+	const struct ipa_rc_msg *msg_arr = NULL;
+	size_t arr_len = 0;
 
-	for (x = 0; x < ARRAY_SIZE(qeth_ipa_rc_msg) - 1; x++)
-		if (qeth_ipa_rc_msg[x].rc == rc)
-			return qeth_ipa_rc_msg[x].msg;
-	return qeth_ipa_rc_msg[x].msg;
-}
+	for (x = 0; x < ARRAY_SIZE(qeth_ipa_cmd_rc_map); x++) {
+		if (qeth_ipa_cmd_rc_map[x].cmd == cmd) {
+			msg_arr = qeth_ipa_cmd_rc_map[x].msg_arr;
+			arr_len = qeth_ipa_cmd_rc_map[x].arr_len;
+			break;
+		}
+	}
 
+	for (x = 0; x < arr_len; x++) {
+		if (msg_arr[x].rc == rc)
+			return msg_arr[x].msg;
+	}
+
+	for (x = 0; x < ARRAY_SIZE(qeth_ipa_rc_def_msg) - 1; x++) {
+		if (qeth_ipa_rc_def_msg[x].rc == rc)
+			return qeth_ipa_rc_def_msg[x].msg;
+	}
+	return qeth_ipa_rc_def_msg[x].msg;
+}
 
 struct ipa_cmd_names {
 	enum qeth_ipa_cmds cmd;
diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index e6904ca9defa..252fc84e6eca 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -857,8 +857,9 @@ enum qeth_ipa_arp_return_codes {
 	QETH_IPA_ARP_RC_Q_NO_DATA    = 0x0008,
 };
 
-extern const char *qeth_get_ipa_msg(enum qeth_ipa_return_codes rc);
-extern const char *qeth_get_ipa_cmd_name(enum qeth_ipa_cmds cmd);
+const char *qeth_get_ipa_msg(enum qeth_ipa_cmds cmd,
+			     enum qeth_ipa_return_codes rc);
+const char *qeth_get_ipa_cmd_name(enum qeth_ipa_cmds cmd);
 
 /* Helper functions */
 #define IS_IPA_REPLY(cmd) ((cmd)->hdr.initiator == IPA_CMD_INITIATOR_HOST)
-- 
2.48.1

