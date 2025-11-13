Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194A52C3259;
	Thu, 13 Nov 2025 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763044945; cv=none; b=LJfjBJKPMw1XDpeouRn+IVAHDEg8hPitlZ8fGWmur5n/lxbyWB1zhAbdc6YRQUmIGV3U186wxcq0BMwr4W1NpGAfA/0jlHpqT8SSn+cJ8PP9JIz9pLdC7Sw02720LMIV4X4JuvVQwK6UlYZqhMI0IjI9KYalEtRfZyv6jmfjdzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763044945; c=relaxed/simple;
	bh=D0aqRgPoutuLd/MVZ48B2N6nlTOoNGeSJJx8tBosWRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lyJGctq9uryZUAFFx86z7LEe9Qp2FdyWp+V4e2RnBzB35fjjeho4DGBoBnAmvb4D+u8X1Alwf4Ici3K8O8CToKkOuU66SSvJQKeJ1XG/7/T8NsORs9abCbwkgWN9k5K+QQGSl7wVsvP0g7Bd+8zRDb29ycr/MuMlnYvrPTsiJjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nGXJ9F/2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nGXJ9F/2"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD4vnFS015833;
	Thu, 13 Nov 2025 14:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=h30PpLUtX+D1ouqX+
	Md0blivBDL2gFFHz5vz7mC71NA=; b=nGXJ9F/2cZ+aCVIBsiQV7KjpNSt5i1Ojo
	/2363OZaVSkt9vNW8Ar/NLuhZ8e/pkNQJrRxxFZGvh3k8f62ao3Bzh/nLj+1i20C
	MPQqh0HCSa6+jmTqeK9Ltdr2YCbkAXysHlBv0H+6Z6LEMy0jytpkB8Cx9i9vu5aL
	LtJatfZCwv/mQ2S/jcicXjf58It6UbZNQ+ioPJ9eoS4RUolPSC/RJXyICGtyY3Di
	w72D5mdVvYTSBs73tqMaQk8zR9EyxpV5m69HVcQeheVwTjYeD3T5/mgdKrqtRjGj
	GTcAykl/pjSB/3ZEJz78qn4gkGfkOOddKfhE2U/syIveeS53eQ19w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m8e328-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 14:42:14 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ADEYAJq025829;
	Thu, 13 Nov 2025 14:42:14 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m8e323-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 14:42:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADCwVHx004748;
	Thu, 13 Nov 2025 14:42:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aagjy6e0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 14:42:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ADEg9cY23069278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 14:42:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF09820040;
	Thu, 13 Nov 2025 14:42:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DBC72004B;
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
Subject: [PATCH net-next 1/2] s390/qeth: Move all OSA RCs to single enum
Date: Thu, 13 Nov 2025 15:42:08 +0100
Message-ID: <20251113144209.2140061-2-aswin@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=MtZfKmae c=1 sm=1 tr=0 ts=6915ee46 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=awsv23SRf-3ci0mn4f0A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 8ABjLT_K1KzqOhxypaLjWwyMp7UnhDtn
X-Proofpoint-ORIG-GUID: 9rGGauYnxVRxPwTyqDjHnMT8rlsOltJ0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3OSBTYWx0ZWRfX4TnU5zQTzTiF
 N7doIQvwBiIzvdxvvVEfE1UfAUg+DPjWZOUbSEN5SBpLUMqhYR7sl9bQGdGuW9lHsuc8m1H5m48
 25epfX6E4DamEu+hDUni3NDkLPLr6hRJdUtV6PhEDcfHYYC2f7UCfWVWGa1b5xMPsUjBETS0Ush
 Ivj0Sxigld1JGA/byv1PO5lsvJ9y781VG4xfaf7kSxLGZr/USyiYRRfTvV4wFSpxoMVteRiXvBp
 8L6DXKCAVTCD9Lbeem/kwqYobra6lI0PCDcH2TWBGdJsJaGWCz8pn8OnZpsLOH9EOMWAdtUDffj
 orkXhP8vtIGFcH55UxPz6/bSyBFWzOmY8pf8NUAogNc78+nYaS2CmrVvtEIVbFqh8VcGYLgdPoy
 4aJ7Nx2cdusFirkBMFhlYGS+SdItrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080079

OSA Express defines a number of return codes whose meaning is
determined by the issuing command, making them ambiguous. Move
definitions of all return codes including the ambiguous ones to a single
enum block to aid readability and maintainability.

Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Aswin Karuvally <aswin@linux.ibm.com>
---
 drivers/s390/net/qeth_core_mpc.h | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index 6257f00786b3..e6904ca9defa 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -159,13 +159,17 @@ enum qeth_ipa_return_codes {
 	IPA_RC_SUCCESS			= 0x0000,
 	IPA_RC_NOTSUPP			= 0x0001,
 	IPA_RC_IP_TABLE_FULL		= 0x0002,
+	IPA_RC_INVALID_SUBCMD		= 0x0002,
 	IPA_RC_UNKNOWN_ERROR		= 0x0003,
+	IPA_RC_HARDWARE_AUTH_ERROR	= 0x0003,
 	IPA_RC_UNSUPPORTED_COMMAND	= 0x0004,
 	IPA_RC_TRACE_ALREADY_ACTIVE	= 0x0005,
+	IPA_RC_VNICC_OOSEQ		= 0x0005,
 	IPA_RC_INVALID_FORMAT		= 0x0006,
 	IPA_RC_DUP_IPV6_REMOTE		= 0x0008,
 	IPA_RC_SBP_IQD_NOT_CONFIGURED	= 0x000C,
 	IPA_RC_DUP_IPV6_HOME		= 0x0010,
+	IPA_RC_SBP_IQD_OS_MISMATCH	= 0x0010,
 	IPA_RC_UNREGISTERED_ADDR	= 0x0011,
 	IPA_RC_NO_ID_AVAILABLE		= 0x0012,
 	IPA_RC_ID_NOT_FOUND		= 0x0013,
@@ -173,6 +177,7 @@ enum qeth_ipa_return_codes {
 	IPA_RC_SBP_IQD_CURRENT_SECOND	= 0x0018,
 	IPA_RC_SBP_IQD_LIMIT_SECOND	= 0x001C,
 	IPA_RC_INVALID_IP_VERSION	= 0x0020,
+	IPA_RC_SBP_IQD_NOT_AUTHD_BY_ZMAN = 0x0020,
 	IPA_RC_SBP_IQD_CURRENT_PRIMARY	= 0x0024,
 	IPA_RC_LAN_FRAME_MISMATCH	= 0x0040,
 	IPA_RC_SBP_IQD_NO_QDIO_QUEUES	= 0x00EB,
@@ -220,16 +225,6 @@ enum qeth_ipa_return_codes {
 	IPA_RC_INVALID_IP_VERSION2	= 0xf001,
 	IPA_RC_FFFF			= 0xffff
 };
-/* for VNIC Characteristics */
-#define IPA_RC_VNICC_OOSEQ 0x0005
-
-/* for SET_DIAGNOSTIC_ASSIST */
-#define IPA_RC_INVALID_SUBCMD		IPA_RC_IP_TABLE_FULL
-#define IPA_RC_HARDWARE_AUTH_ERROR	IPA_RC_UNKNOWN_ERROR
-
-/* for SETBRIDGEPORT (double occupancies) */
-#define IPA_RC_SBP_IQD_OS_MISMATCH	 IPA_RC_DUP_IPV6_HOME
-#define IPA_RC_SBP_IQD_NOT_AUTHD_BY_ZMAN IPA_RC_INVALID_IP_VERSION
 
 /* IPA function flags; each flag marks availability of respective function */
 enum qeth_ipa_funcs {
-- 
2.48.1

