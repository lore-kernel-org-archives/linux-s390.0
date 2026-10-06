Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3892746C4DD
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791295976; cv=none; b=MZnSy+O6U7SPT4X0qjpumgQ1eyqRZGQPEMPIvdRtwMKZLAQ63Iv448TSmZ1TN7ehASS2PvhEmtLOl4qs5c9WsIo0Wt1QduqCmd5g5iPQDZjkVp5dvcRsBqgL16iiZ+7HZHWp2MdD4CajPDzBcBaQTVulyRS4O1wE06VznrhsKjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791295976; c=relaxed/simple;
	bh=miBV3HgQ8dHwB0y9Wu8rCKU3sUM0Q2NGxnnivOLYA8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFB566ld/SIBFO1YGy/+97Gpg/eooLOqgbR5JoaEggZP42/RaECoG6oGRkYLEBWrCzwPmvQdXbpyNLtmCWzgtcK5Ui/E4/Q8MF71S3m7/d9m08Xk3vwHbsA/9SJbXfaYeMpbziVQcEsoiE9hcGSJ7jh5exeDqO2PPub29EjN0i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c3W9Y6Xx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c3W9Y6Xx"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696DZXR93867939
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 14:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=G+tYCDmb3ieiwZmkZ
	s5e/WzVWn10mYhtU0Ip3wArjnU=; b=c3W9Y6XxukEjyNIHkl8Sr33EXYJ6PkUDm
	C58VDlvEDgQ3XruTbBgReZ4bZaCAMvOnM63TQrFONpuSMm4Rn05TKqXtjxhqwlwM
	TeQ7T0KwaxZoo8RPxRPbmAJIAUyNQNwArnhEV/kd61U8D1QOsQ0IdLeQ/WDuewjs
	FdcyTA0YubyXxYvA2+/xzUOOVOaVQjjjguCKCxXAWXEUSkr1o5lz+0RuXR9OI5TY
	Iw9FpfFz+b9EPdRIUVlKCTEAU1skWpX6xuLXEQ1RX849uC41WniOjOZ9JRY+C7c4
	0DEAefNPhVGAvQNDzMHRTCYa2+Di0ZUAqRMoJwIcNkwmBO+spb2vg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbv7djv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 14:12:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696DWapk3293838
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 14:12:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3e8ga1vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 14:12:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696ECmMu15401300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 14:12:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9234A20040;
	Tue,  6 Oct 2026 14:12:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5922020043;
	Tue,  6 Oct 2026 14:12:48 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.134.234])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 14:12:48 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v2 2/2] s390/zcrypt: Fix out-of-bounds ptr advance in cca_query_crypto_facility()
Date: Tue,  6 Oct 2026 16:12:45 +0200
Message-ID: <20261006141245.7558-3-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: bu70cUFPEdyqNwRu402SmE2dltNoilVF
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac501e5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=WRuNL78x4yoRP3YN28cA:9
X-Proofpoint-GUID: bu70cUFPEdyqNwRu402SmE2dltNoilVF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1NiBTYWx0ZWRfX6ykEHE38Jmo3
 IQreFOlx+JCbgL1EMjnYPfHE9Ik9veyN/PLWInU5dVbOwLu+bgLpYD7klxvvkvLxQzVjJFf7876
 GqX6rLieWJRY4BvCHwIYC/BGlbEhv2Z5cRB5YcpKvKPbVYEWnQx4YMjsBNIQKUTcC08AORPVy2R
 tUX9vQxWmcVpyS4bRNZKVHGSJyZIXZV4MQkeLvQIeEi22g8f2RUaQmWz4Ci/+uGnN3PSaFPUcIG
 zHfUNTkGRZECej9bVvkVNdPLkiOFMXLewATVp26wpizn3ku532dnaL7dlQdZtLW+D3duntkJjbN
 BkNtd/dceM6iebGV1/GfWwD/1SY4a++Qgl8gbFgQGB+yhTiXMDnKOMW5Xm+cwVIMasB1sJTtEdc
 kCMdgT6+HsW1o3NiWlna8RKg8LPBNE/l8AUDp4Pc7Int6s8L0iN9vXc/mnBzq7EhbJkeW1zjrPY
 LL7kji+2XRu+v26Dt3A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1NiBTYWx0ZWRfX+CoobKYwetiK
 FxRhuIgqVAmqFmFgv9NyvPycL3Qbak4BPGuRVpKChpbd2ZT5aSZB30IiybrJUFhri0WXnlgequ1
 wiXXb+JCDZPO77hMjP0cJQ2b83LUSs0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060056

The FQ reply parser code blindly advanced the walk pointer by a length
value read directly from the hardware reply payload without checking
that the advance stayed within the allocated reply buffer. A corrupt
or malicious device response could push ptr beyond the cprbmem region,
causing an out-of-bounds dereference or kernel memory exposure via the
subsequent memcpy().

Fix this by tracking the remaining reply buffer space in a variable
and validating each device-supplied length field against it before
advancing or dereferencing the pointer.

Fixes: 2004b57cde6b ("s390/zcrypt: code cleanup")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Cc: stable@vger.kernel.org
---
 drivers/s390/crypto/zcrypt_ccamisc.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 19909bf43dc9..862947431164 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1627,6 +1627,7 @@ int cca_query_crypto_facility(u16 cardnr, u16 domain,
 		u8  subfunc_code[2];
 		u8  lvdata[];
 	} __packed * prepparm;
+	size_t datalen;
 
 	/* get already prepared memory for 2 cprbs with param block each */
 	rc = alloc_and_prep_cprbmem(parmbsize, &mem,
@@ -1673,27 +1674,44 @@ int cca_query_crypto_facility(u16 cardnr, u16 domain,
 	prepcblk->rpl_parmb = (u8 __user *)ptr;
 	prepparm = (struct fqrepparm *)ptr;
 	ptr = prepparm->lvdata;
+	datalen = parmbsize - 2 * sizeof(u8);
 
 	/* check and possibly copy reply rule array */
 	len = *((u16 *)ptr);
+	if (len > datalen) {
+		ZCRYPT_DBF_ERR("%s reply rule array len %u exceeds datalen %zu\n",
+			       __func__, len, datalen);
+		rc = -EIO;
+		goto out;
+	}
+	datalen -= sizeof(u16);
+	ptr += sizeof(u16);
 	if (len > sizeof(u16)) {
-		ptr += sizeof(u16);
 		len -= sizeof(u16);
 		if (rarray && rarraylen && *rarraylen > 0) {
 			*rarraylen = (len > *rarraylen ? *rarraylen : len);
 			memcpy(rarray, ptr, *rarraylen);
 		}
+		datalen -= len;
 		ptr += len;
 	}
 	/* check and possible copy reply var array */
 	len = *((u16 *)ptr);
+	if (len > datalen) {
+		ZCRYPT_DBF_ERR("%s reply var array len %u exceeds datalen %zu\n",
+			       __func__, len, datalen);
+		rc = -EIO;
+		goto out;
+	}
+	datalen -= sizeof(u16);
+	ptr += sizeof(u16);
 	if (len > sizeof(u16)) {
-		ptr += sizeof(u16);
 		len -= sizeof(u16);
 		if (varray && varraylen && *varraylen > 0) {
 			*varraylen = (len > *varraylen ? *varraylen : len);
 			memcpy(varray, ptr, *varraylen);
 		}
+		datalen -= len;
 		ptr += len;
 	}
 
-- 
2.43.0

