Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3887B46AA7C
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791295975; cv=none; b=IEl1oGesMiX+SZ1KbDiTT9DPl6WuOr/7w1jLPgnOTVLncrlf4jd9eoFu8nsag9xEtF+i2Xtxtc4eANzy0u7b6FKKFQ0MZ2gxDT9C/3UOReH4NMpp5W7VywHPMmkJe3GUtMiqnXAs3DybkheIhlBNWX4qyXHmWCOflN16OlxvbMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791295975; c=relaxed/simple;
	bh=vpdeoHAiXl3lCOolGaK35QiWQBKeEPyoPFdS7GDDrjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBC9/t9FCRoFaQNVNHgKd/WOwn6A0e/WBADYKEPqeabyOTJQA2JUg+Z5Gja1VEWd2IGR7GLOWUpNTK0Mzy65y5m+Dyb5iFOp5Ohi18hoy2l039ciWFHSYBejMjOrQnJ8s3Wq49XV31BpEKsqo+xkVkW+CLWPTEZLSCL36Tfbhv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NfIzZZBv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NfIzZZBv"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696DbJxv2059224
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 14:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=N4OSQ268PHrtSGcUc
	sdh0mgZC7dCAr7RngtkiAsEy+o=; b=NfIzZZBvWyQ5xTM/2DYURcxzCObNmZQhZ
	60+sw1RTDFF2aIxla5IVLJdn/8r20x46spbgmHISmuF04dkRyz/lV3FwZ0YjHdex
	r3vmVARJ39EqykKhbh19EBiBM06IiyHUvIpv+sQGojDT+kjECXQ0kLZAm06kZKf7
	Zv30vs4sFg4hIfossDDtycuJJ9cUuLZLcqugqOXqe86w4g90uaGDsidHt8O/DLyl
	/sIbkj3eCGN9Ph5B8EOqRBIkantLzQGJahKsThuGlmptd5dbF66VKg3e42AfXvdW
	i6kM5b23Wx+tp6n1BtMOEiShsauoT2n1Y7CnbuZTeR53t2v2sRgRA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrgcxt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 14:12:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696DWXjN337259
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 14:12:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jt7jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 14:12:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696ECm6n29557360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 14:12:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49D722004E;
	Tue,  6 Oct 2026 14:12:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 122DF2004F;
	Tue,  6 Oct 2026 14:12:48 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.134.234])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 14:12:48 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v2 1/2] s390/zcrypt: Guard domain index uses against speculative bypass
Date: Tue,  6 Oct 2026 16:12:44 +0200
Message-ID: <20261006141245.7558-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006141245.7558-1-freude@linux.ibm.com>
References: <20261006141245.7558-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1NiBTYWx0ZWRfX3jsuYNxquK/S
 vH74bW5hoWJ5g5JgZ3VdkuPjq4X0EaFXkIqn6YGMcUwN5uuWJ4p9UFgwh5qikukWQgxkUZa9dhT
 PxGBLNEYbkwmgLS6eCvTH9thCh5A8p8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1NiBTYWx0ZWRfX4I8ZYhVWUbji
 9U9oq03R8P39FUCG1+rx5y5/eRUWjZVuc47jxh3DKotsFbAJOanaQvSltTADNzdZKoP8js6pfXv
 rj/tXvT3MskoyJ8OETZlw2+64qSpOEPC9Lwe8wIS/xnx595laOuMkkyAu68wsrCgnV1Kgf+Y8+m
 rXE9i4x7E6njxm8qGR9agk6UIT1ydgB5/GoccsktveaSQzwoaWtBIQhQZNCmTDZFX0RnGKhoQtF
 ++oPnckDATHkymdpHN+R5W9hf+OZUu9dguTAjWpSbzPFSpiZJm3mQAwkwFP5HJy+avpmFdTjC0L
 oubq/e94DCuE5z4w0WVXSfyPQS9mVfGlakvZ0ryv3n1yPU4HC2e68mZyB3IG7WsvedDQab/CKom
 23Ggj7z2kVZz+BFayoq7BI5XVsLwrMbepOwxVBmFzqZ0x6ID6ItSMKwy1iKTH4eM7vAtCns2j2t
 gmTCmRoVGE6Y2qOm3IA==
X-Proofpoint-GUID: XBLVgi1Q8NAESL5zPNd4NUxmPQErp59g
X-Proofpoint-ORIG-GUID: XBLVgi1Q8NAESL5zPNd4NUxmPQErp59g
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac501e5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=ZFhTR83JHD-s5PKLmkUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060056

The previous array_index_nospec() placement only covered the admin
permission check, leaving ap_test_config_usage_domain() and
ap_test_config_ctrl_domain() in the CCA path exposed to speculative
execution.

Move the sanitization to before all permission and config checks in
both the CCA and EP11 paths so a single call covers all downstream
uses of the domain index. Before that check the domain value to be
either AUTOSEL_DOM or in range 0...AP_DOMAIN-1 and return with -EINVAL
in case this check does not pass.

Fixes: e935cd525af4 ("s390/zcrypt: Close speculative mem read possibility")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Cc: stable@vger.kernel.org
---
 drivers/s390/crypto/zcrypt_api.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index ec6a4c2f9f04..d2ff7ab54c8d 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -877,9 +877,17 @@ static long _zcrypt_send_cprb(u32 xflags, struct ap_perms *perms,
 	print_hex_dump_debug("ccareq: ", DUMP_PREFIX_ADDRESS, 16, 1,
 			     ap_msg.msg, ap_msg.len, false);
 
+	/* Make sure domain is either AUTOSEL_DOM or in range 0...AP_DOMAIN-1 */
+	if (domain != AUTOSEL_DOM) {
+		if (domain >= AP_DOMAINS) {
+			rc = -EINVAL;
+			goto out;
+		}
+		domain = array_index_nospec(domain, AP_DOMAINS);
+	}
+
 	if (perms != &ap_perms && domain < AP_DOMAINS) {
 		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
-			domain = array_index_nospec(domain, AP_DOMAINS);
 			if (!test_bit_inv(domain, perms->adm)) {
 				rc = -ENODEV;
 				goto out;
@@ -1078,9 +1086,17 @@ static long _zcrypt_send_ep11_cprb(u32 xflags, struct ap_perms *perms,
 	print_hex_dump_debug("ep11req: ", DUMP_PREFIX_ADDRESS, 16, 1,
 			     ap_msg.msg, ap_msg.len, false);
 
+	/* Make sure domain is either AUTOSEL_DOM or in range 0...AP_DOMAIN-1 */
+	if (domain != AUTOSEL_DOM) {
+		if (domain >= AP_DOMAINS) {
+			rc = -EINVAL;
+			goto out;
+		}
+		domain = array_index_nospec(domain, AP_DOMAINS);
+	}
+
 	if (perms != &ap_perms && domain < AP_DOMAINS) {
 		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
-			domain = array_index_nospec(domain, AP_DOMAINS);
 			if (!test_bit_inv(domain, perms->adm)) {
 				rc = -ENODEV;
 				goto out;
-- 
2.43.0

