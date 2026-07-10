Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430BD4229C3
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783690027; cv=none; b=hUuYaCkYgFntlDLrxzD28ygScKhGHoM5IZ+xgOhOuqzbKsFRm7fp7zKWzX2mx1kyqKkF8SgmTdV7wMlwjS00yEE9hUnciOQazXi4WDXQNk5Lc97DDP8LkJ9hKfFjQ1mfXlLNBSbNLnxBfXD/WimSR0dxnyhSJTcgdkAdj5mZIIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783690027; c=relaxed/simple;
	bh=kjOBPepPmeTxH6xgMJGyMYAADZGABRBbBJVhhFZKMlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkKKE5S7iYMvwBT95tRPAirJxkAzyx13XOmPUdJ/iSU8OhhX6sPWzFfp/s3uHfqQrjW5jfu1Q9kuQFjN27WvVVowKlvRe5g3eaDRNyOvFJI2v+EhrUYrFq1vIm7fxusZ7bqXw3+KWrq631Nx7PDOsod8s5+qTt2rVKAJOhAzPF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CuRdptRB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CuRdptRB"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ADIM6f297227
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 13:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3/lqs4laJY6c1Oyd+
	QrJ35CfdL6lVbiSaOE0k2yMQn0=; b=CuRdptRBRX5O+uqWOX/GAoonlsiVLFJ64
	ERA8veXHUmo2xWZza0FH2R4aD9Z5Wa+NHjTx/TxVnxS53xyEorQJcSMgAf+Gfhxi
	U5Jm+lridk2HM2sJ4Nh5y5qfJByZKtwEzIgJ6RDg4F0kdHpMdv8i42iK9SdE2A9H
	RWbhVJnjVagrsYMlNIZb4FztIvaiQxjzhYV21VvgOnKlgCOtMb5dqVV2z6oNUt2R
	Sj51tmsARBMHVrxlmdAbuKSukGBTxnP5FyOTpSeYo4sOv4Yzk7bMw7pJNQ2yZTMn
	4TDKF1KQzwVqBG9VM0EnrD8dj/oAjiO4oVEDgtN58gVIDoqqvy69g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stt72mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 13:27:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ADJcFO006879
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 13:27:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvwjccn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 13:27:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ADR0b716777706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 13:27:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 387A120040;
	Fri, 10 Jul 2026 13:27:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B9E62004B;
	Fri, 10 Jul 2026 13:27:00 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.196.135])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 13:27:00 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v1 1/1] s390/zcrypt: Fix missing mem scrub at clear key import in cca_clr2cipherkey()
Date: Fri, 10 Jul 2026 15:26:58 +0200
Message-ID: <20260710132658.77231-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710132658.77231-1-freude@linux.ibm.com>
References: <20260710132658.77231-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LDjkga_GpMp4844OAWP3ZrlDrGmleXPZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEzMiBTYWx0ZWRfX+ujGdoWnY2j/
 zeRooWnYEUQdGY5n9nn7yi4tClKtG+cHaJTk8IVnwKdjwy7f3j6krDhUXoW205+KJyWqQt50fk4
 d4LpYdHzd/cCOHqH47Dw6j0m+FRzC58=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a50f329 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=l_XADsiG0JAIV5gd_FcA:9
X-Proofpoint-GUID: LDjkga_GpMp4844OAWP3ZrlDrGmleXPZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEzMiBTYWx0ZWRfXyy9j/iE9sU6i
 aL0tkHYzsGSQSD2dMpsWReBeKbY0sJqoRIzgzugOek2BF//kVTWh9g5NwdDVDmimeq8v1BwHF07
 XJbJASxD/quYdHh/fAuxsosEwz/RhBXvqtzbS/ax0y2/GSiipHWsg701minOlpiGoTjVxExOVvk
 j+3uBcjb/peyL6JcdNm2dJ3KmPQYg9o3+PnTxnDDW3ApGVzjIAjcHPDC2vM7g/J2xWFw/KZ0fbT
 C1aWKgVlHE0CveYOsQGlBF/G7tm4ZmrJ4uN+a0WX5kuWIQPamVE+pyr30xs1BacIm+KXbYZQX3d
 GggGy+MqaraowoR/jHg54IkyRUG+iljPHvtKcuH7CfCchZlz+xPkadrFEHlwdkSsIdmz/+hBWJI
 dl3JQKsYtjhyZ0n85Io15btJ3XqVsgipeLt0e0Y40CGL4uB5SsZXnJGS0NRxNISVAR1W2yezaa0
 DG3+yh47RCitEdkRHag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100132

The helper function _ip_cprb_helper() uses internal buffer memory for
building and processing CPRBs. After use this buffer was never
scrubbed which could lead to leaving for example clear key material in
memory which could be exposed via tricky reuse of this same memory.

Extent the _ip_cprb_helper() function with another parameter 'scrub'
used to steer scrubbing of this buffer. So now the caller has the
opportunity to decide if scrubbing is needed or not.

Extent the clear key to secure key token import process in function
cca_clr2cipherkey() to tell the helper function from above to scrub
the cprb buffer when the clear key value is part of the request data.

Overall this cleans the internal used buffer in case of clear key
import to prevent sensitive data to get exposed.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Cc: stable@vger.kernel.org
---
 drivers/s390/crypto/zcrypt_ccamisc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 84936a795b95..6a237e880b40 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -971,7 +971,8 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 			   int clr_key_bit_size,
 			   u8 *key_token,
 			   int *key_token_size,
-			   u32 xflags)
+			   u32 xflags,
+			   bool scrub)
 {
 	int rc, n;
 	u8 *mem, *ptr;
@@ -1111,7 +1112,7 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 	*key_token_size = t->len;
 
 out:
-	free_cprbmem(mem, PARMBSIZE, false, xflags);
+	free_cprbmem(mem, PARMBSIZE, scrub, xflags);
 	return rc;
 }
 
@@ -1162,28 +1163,32 @@ int cca_clr2cipherkey(u16 card, u16 dom, u32 keybitsize, u32 keygenflags,
 	 * 4/4 COMPLETE the secure cipher key import
 	 */
 	rc = _ip_cprb_helper(card, dom, "AES     ", "FIRST   ", "MIN3PART",
-			     exorbuf, keybitsize, token, &tokensize, xflags);
+			     exorbuf, keybitsize, token, &tokensize,
+			     xflags, false);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s clear key import 1/4 with CSNBKPI2 failed, rc=%d\n",
 			       __func__, rc);
 		goto out;
 	}
 	rc = _ip_cprb_helper(card, dom, "AES     ", "ADD-PART", NULL,
-			     clrkey, keybitsize, token, &tokensize, xflags);
+			     clrkey, keybitsize, token, &tokensize,
+			     xflags, true);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s clear key import 2/4 with CSNBKPI2 failed, rc=%d\n",
 			       __func__, rc);
 		goto out;
 	}
 	rc = _ip_cprb_helper(card, dom, "AES     ", "ADD-PART", NULL,
-			     exorbuf, keybitsize, token, &tokensize, xflags);
+			     exorbuf, keybitsize, token, &tokensize,
+			     xflags, false);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s clear key import 3/4 with CSNBKPI2 failed, rc=%d\n",
 			       __func__, rc);
 		goto out;
 	}
 	rc = _ip_cprb_helper(card, dom, "AES     ", "COMPLETE", NULL,
-			     NULL, keybitsize, token, &tokensize, xflags);
+			     NULL, keybitsize, token, &tokensize,
+			     xflags, false);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s clear key import 4/4 with CSNBKPI2 failed, rc=%d\n",
 			       __func__, rc);
-- 
2.43.0

