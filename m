Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB63B49E5DD
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301573; cv=none; b=SN6dvOnliifBB7dyfBgYRVI/qOpPJB438+cE/FyImsjpsd2xiN3yZHd1Mg8nk0WATtl5TUBaOWhhiS9M4TAe3Q+/DNUfpWQRT/NE1Yybi+eoHWPZ4rqomsmbeUP3I0rwlRLjatY4Hqmlrxa2x3Rdr0KY4rzlPCtkPQuYzApD8/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301573; c=relaxed/simple;
	bh=IbKycEAbtKsSTmwkEo1WbnfFKysyAGd4PxoNFcKDvTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7h2d9LwTTa3nZWqlfTPeQ2wVkCEagFOPXkrCCQhA/6lGiseKyjH8TwJW5qrwFzPjc3t/6CW9HyA01MGfHUuHxPfUGx5hRoPdbt4NLv5G8dfhu+wqJ3fbbsOVS6Hu6mV69dT73/ARR0iZDRUiu4MWTpFBJc3lYXK6Tsnjh5xV1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WZLZCCJr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WZLZCCJr"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696EZPwa3974610
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 15:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wMDvpHIFsgsZFrfFr
	WocNmPCGWOXJKkM/VGP4eU+2tg=; b=WZLZCCJryARfPvRJyo0T4qCz81/EmEW2F
	5S0LeeymkqjWS04iiD6DRNWzHttKmu+v86vMEzsm+y4YhPKlbYzRa8J810hs7gya
	qHVEWIDY97UpPVJKog61CehdHX39Y7InRY13PL7HmmpCfB7vjfcySZuAatzjFXAO
	rA+6mvmOgsucWitzWNfZoIeiRv1ndlIqjVTCZiCSk1tK9PjFtWoZvUVA+GeB0EDG
	kLe/9rNN0wzQet5cop8SDC98eMIglEIVCTBfOe3qbuKznvpwj7vweoBQ+muo/Ld5
	i7D1+oUfOVX9exPCUd4mreo6f8ATWmEqaEqKK47fwFTpmYRjddNJQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5gum6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 15:46:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696EHUtF410985
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 15:46:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1ptr9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 15:46:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696Fk4jx39846348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 15:46:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 185802004B;
	Tue,  6 Oct 2026 15:46:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4D642005A;
	Tue,  6 Oct 2026 15:46:03 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.134.234])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 15:46:03 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v3 1/2] s390/zcrypt: Guard domain index uses against speculative bypass
Date: Tue,  6 Oct 2026 17:46:02 +0200
Message-ID: <20261006154603.9699-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006154603.9699-1-freude@linux.ibm.com>
References: <20261006154603.9699-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA2MiBTYWx0ZWRfX8GOxYaMh76Lv
 etz2gmWRd/Dy6p032MEKtlcr5Q09sQU5cvCgKNCtzBO4yPdNotG6A9vKfJEZ7oGfu0g6R7+lL94
 7y8UE/ws345J0f5h+9B9dMMY89MLWRk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA2MiBTYWx0ZWRfXyh/aC9PappIW
 YDrsLYALwEzYURmlb3up9n65c3QL4YFNf7N28V3EE9E4thtX5Xt5937yx/LuiysyAL9PIdayBiN
 F0KoSvT0w0n9qmyg1Sfmik3tycA6DTMnkS+yTJyIqPco36wyURh+JRG/CIw1lR6s9sG9cdwvrug
 IljLgvQESZGETwSBTojy6Euej5ay1N5Rl/6KmK5NnkWpUaLV4arWFQ41BtpWqb60TQyfrSQ9+9+
 x98rpGEk47frDh7F8sb2kbTg7aX47+yp76zjDERDU/XE3eMWabzF8TCZxbS6ZEhphtaU5nhxd8Y
 VxNAlGXlFchVmluD2CEANldGhf8VE6nPtA5XXirrXrc0WDdkwP3HfI1JFfZKvvv2ifh0llAnyYh
 QYY2F0XqFUg/QKUFwXd7TUG6vg4c82b2cmXlGHpR4Zr7+dqBUtY/9Sp2o9qNf49tazer/G4Dm/A
 nZX0bS0sQrU79eRqGyA==
X-Proofpoint-GUID: CF6BzAowXAWecyq3VLcg7TGdvXuAwt37
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac517c0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=FiyR26EWrxCE38RX3ZUA:9
X-Proofpoint-ORIG-GUID: CF6BzAowXAWecyq3VLcg7TGdvXuAwt37
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060062

The previous array_index_nospec() placement only covered the admin
permission check, leaving ap_test_config_usage_domain() and
ap_test_config_ctrl_domain() in the CCA path exposed to speculative
execution.

Move the sanitization to before all permission and config checks in
both the CCA and EP11 paths. Hold the sanitized domain value in
another variable so that the later use can choose to use either the
original value (subject to speculative execution) or the sanitized
value (which may in case of AUTOSEL_DOM reflect the wrong
value). Before that, check the domain value to be either AUTOSEL_DOM
or in range 0...AP_DOMAIN-1 and return with -EINVAL in case this check
does not pass.

Fixes: e935cd525af4 ("s390/zcrypt: Close speculative mem read possibility")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Cc: stable@vger.kernel.org
---
 drivers/s390/crypto/zcrypt_api.c | 35 +++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index ec6a4c2f9f04..625578b3fabe 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -854,7 +854,7 @@ static long _zcrypt_send_cprb(u32 xflags, struct ap_perms *perms,
 			      struct ica_xcRB *xcrb)
 {
 	bool userspace = xflags & ZCRYPT_XFLAG_USERSPACE;
-	unsigned int card, domain, func_code = 0;
+	unsigned int card, domain, _dom, func_code = 0;
 	unsigned int wgt = 0, pref_wgt = 0;
 	struct zcrypt_queue *zq, *pref_zq;
 	struct zcrypt_card *zc, *pref_zc;
@@ -877,10 +877,17 @@ static long _zcrypt_send_cprb(u32 xflags, struct ap_perms *perms,
 	print_hex_dump_debug("ccareq: ", DUMP_PREFIX_ADDRESS, 16, 1,
 			     ap_msg.msg, ap_msg.len, false);
 
+	/* Check domain for either AUTOSEL_DOM or in range 0...AP_DOMAIN-1 */
+	if (domain != AUTOSEL_DOM && domain >= AP_DOMAINS) {
+		rc = -EINVAL;
+		goto out;
+	}
+	/* Spectre-v1: sanitize domain unconditionally for later use */
+	_dom = array_index_nospec(domain, AP_DOMAINS);
+
 	if (perms != &ap_perms && domain < AP_DOMAINS) {
 		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
-			domain = array_index_nospec(domain, AP_DOMAINS);
-			if (!test_bit_inv(domain, perms->adm)) {
+			if (!test_bit_inv(_dom, perms->adm)) {
 				rc = -ENODEV;
 				goto out;
 			}
@@ -893,10 +900,11 @@ static long _zcrypt_send_cprb(u32 xflags, struct ap_perms *perms,
 	 * If a valid target domain is set and this domain is NOT a usage
 	 * domain but a control only domain, autoselect target domain.
 	 */
-	if (domain < AP_DOMAINS &&
-	    !ap_test_config_usage_domain(domain) &&
-	    ap_test_config_ctrl_domain(domain))
-		domain = AUTOSEL_DOM;
+	if (domain < AP_DOMAINS) {
+		if (!ap_test_config_usage_domain(_dom) &&
+		    ap_test_config_ctrl_domain(_dom))
+			domain = AUTOSEL_DOM;
+	}
 
 	pref_zc = NULL;
 	pref_zq = NULL;
@@ -1041,7 +1049,7 @@ static long _zcrypt_send_ep11_cprb(u32 xflags, struct ap_perms *perms,
 	struct ep11_target_dev *targets = NULL;
 	unsigned short target_num;
 	unsigned int wgt = 0, pref_wgt = 0;
-	unsigned int func_code = 0, domain;
+	unsigned int func_code = 0, domain, _dom;
 	struct ap_message ap_msg;
 	int cpen, qpen, qid = 0, rc;
 	struct module *mod;
@@ -1078,10 +1086,17 @@ static long _zcrypt_send_ep11_cprb(u32 xflags, struct ap_perms *perms,
 	print_hex_dump_debug("ep11req: ", DUMP_PREFIX_ADDRESS, 16, 1,
 			     ap_msg.msg, ap_msg.len, false);
 
+	/* Check domain for either AUTOSEL_DOM or in range 0...AP_DOMAIN-1 */
+	if (domain != AUTOSEL_DOM && domain >= AP_DOMAINS) {
+		rc = -EINVAL;
+		goto out;
+	}
+	/* Spectre-v1: sanitize domain unconditionally for later use */
+	_dom = array_index_nospec(domain, AP_DOMAINS);
+
 	if (perms != &ap_perms && domain < AP_DOMAINS) {
 		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
-			domain = array_index_nospec(domain, AP_DOMAINS);
-			if (!test_bit_inv(domain, perms->adm)) {
+			if (!test_bit_inv(_dom, perms->adm)) {
 				rc = -ENODEV;
 				goto out;
 			}
-- 
2.43.0

