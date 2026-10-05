Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CF137F732
	for <linux-s390@vger.kernel.org>; Mon,  5 Oct 2026 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791200428; cv=none; b=bshE7d2PBGSvqjrDHBkAmN78oGIaMx8cxWKpOiCjECuXCljNIPjVr8borza089gxWOyvELYYXVOn5UTHltFwKtZrSYeHRW5mYX9hIA8a4vRXoTCXDmvLPUL4m+Iaw8XrLaJKqLgYpVZfyLgIbKbiEyuNaFKBMSB1aX5+p19EWB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791200428; c=relaxed/simple;
	bh=iP/yIsnRUuhKdApGMDofjXMg4kiSZNfwOx9JWmNYwlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMgE+7vHYtGh9NJg1b4PcX4+iB+Lmttob8J+6xA3hozoyFAj0vqg/AihMCLfjCZLa0grJZvkQzdukPqD5OWA+Ua3GWZaVppryfm2MguGKfUoKHGbx7JOtUp809xpUI7v/pa8qQxhvCVxadBaokhiv6lkagrT8Kng8xmH8+R33Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lEw1YCvR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lEw1YCvR"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695BZmIm3499876
	for <linux-s390@vger.kernel.org>; Mon, 5 Oct 2026 11:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sJKU4+vYJm3TaIKlS
	vAKb9Pft/lEsQbY3nYKRQUWJGo=; b=lEw1YCvRAOIP1cDJZOu0wJkrlynl+NSPA
	7upehW6xRl+Df6MPogVwTrevL1Ek7Yk6Z8khiM7lSIygWk2moRtzuVB58JVh52ls
	oEC5ik4VaTCeM7h4ilAbG3S9dFWb3yKoylMJ+5DcBYi9vttSLzwPecjSRhCBdSVV
	3NYTOU7YxD/HOcm9fQYB3T14dT5sg5NQoyPbx/lmFq4JoNViE359k8OObn7/4mFZ
	CvWVBxOpyJL2zE+X4P4Lwx8101qCO64/YNhATGHqLeKfB86MshwGuwSGG8aUyKYg
	JT7ZUoVu7FUDUf3EFZK5s9pGC0N2kY1vi5WaDpjD328hfSmM9F40A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4fscfp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 05 Oct 2026 11:40:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695BWYcw2850564
	for <linux-s390@vger.kernel.org>; Mon, 5 Oct 2026 11:40:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1pndqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 05 Oct 2026 11:40:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695BeItx46072236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 11:40:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D98832004B;
	Mon,  5 Oct 2026 11:40:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B86BC2005A;
	Mon,  5 Oct 2026 11:40:18 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.167.168])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 11:40:18 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v1 1/2] s390/zcrypt: Guard domain index uses against speculative bypass
Date: Mon,  5 Oct 2026 13:40:17 +0200
Message-ID: <20261005114018.62489-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005114018.62489-1-freude@linux.ibm.com>
References: <20261005114018.62489-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac38caa cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=gTyDRliXog5sL88zAt0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0NSBTYWx0ZWRfX78bDEkSXY696
 iaDgAPt8112JqzsFQQs9HOwDcD02qEmyRqSbVD+5HydjqOVk2O1GdAnbai93P/O4UZECb5GtsTk
 w/xNIUlzmu121JT1sAIUDCWX2mJFutDX/uAQ64lGyxrIcJx8fl7N/YaZRa+UkY7NhZ3fVXrq9UR
 Aly4oVANHCgaf+jtFv4uNcwnPStADe8Zk7G/G2VxfGlQAjtlyU4yE8lKnmdb2FMllFxAKfQU4ix
 QVp3I6Il8EcamCAV5leK+I+Kdqq4KGZMw5eJ1SzQVfCDqlq4I1OvSCbWZeZ6y8pkxEilBMzlaNE
 +Ii70sWgu5Wd+nAQEdSXyC80fjC3AZDx7C/sYdiIVt7lsc9ErP2Pu0ZMZAVk1vywKdRiZVuXSur
 5cd4VLJ2W21isU0YDUfL4N4amJZmLhMQ8qOftjRJJTb0abTGnzsdpNDX+FzOSOWjStmXMYi3euF
 keXiyUHoNkm1goWhN3Q==
X-Proofpoint-GUID: lBbZTvTvlqcCS5YYH8ksGt6nwzQ5F9DF
X-Proofpoint-ORIG-GUID: lBbZTvTvlqcCS5YYH8ksGt6nwzQ5F9DF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0NSBTYWx0ZWRfXzBfwMrN9AbyR
 jQBPUlFpE4GLNLZy/GMMwOigLDPLVCTh7XrDdR2uAI+fbe52SFYOyMaPI8un5TJb/6UlvfDtm9a
 JUeUGYq1Qn5h5x/D2GK0BH0D9KOyIPo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050045

The previous array_index_nospec() placement only covered the admin
permission check, leaving ap_test_config_usage_domain() and
ap_test_config_ctrl_domain() in the CCA path exposed to speculative
execution.

Move the sanitization to before all permission and config checks in
both the CCA and EP11 paths so a single call covers all downstream
uses of the domain index.

Fixes: e935cd525af4 ("s390/zcrypt: Close speculative mem read possibility")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Cc: stable@vger.kernel.org
---
 drivers/s390/crypto/zcrypt_api.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index ec6a4c2f9f04..c9d6f4539235 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -877,9 +877,12 @@ static long _zcrypt_send_cprb(u32 xflags, struct ap_perms *perms,
 	print_hex_dump_debug("ccareq: ", DUMP_PREFIX_ADDRESS, 16, 1,
 			     ap_msg.msg, ap_msg.len, false);
 
+	/* Make sure domain is either AUTOSEL_DOM or in range 0...AP_DOMAIN-1 */
+	if (domain != AUTOSEL_DOM)
+		domain = array_index_nospec(domain, AP_DOMAINS);
+
 	if (perms != &ap_perms && domain < AP_DOMAINS) {
 		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
-			domain = array_index_nospec(domain, AP_DOMAINS);
 			if (!test_bit_inv(domain, perms->adm)) {
 				rc = -ENODEV;
 				goto out;
@@ -1078,9 +1081,12 @@ static long _zcrypt_send_ep11_cprb(u32 xflags, struct ap_perms *perms,
 	print_hex_dump_debug("ep11req: ", DUMP_PREFIX_ADDRESS, 16, 1,
 			     ap_msg.msg, ap_msg.len, false);
 
+	/* Make sure domain is either AUTOSEL_DOM or in range 0...AP_DOMAIN-1 */
+	if (domain != AUTOSEL_DOM)
+		domain = array_index_nospec(domain, AP_DOMAINS);
+
 	if (perms != &ap_perms && domain < AP_DOMAINS) {
 		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
-			domain = array_index_nospec(domain, AP_DOMAINS);
 			if (!test_bit_inv(domain, perms->adm)) {
 				rc = -ENODEV;
 				goto out;
-- 
2.43.0

