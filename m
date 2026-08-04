Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A7F43CEEB
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785841103; cv=none; b=qRSOqETUZrzeV7brhCGmLXRg21v6Z56YE3oHndMb2bZGCSIoXwI6WRs4wxvHLvDUOccRQKVkLAG2d9ESfeej02p59sqA9JlOcAN4KnHqtotsARKnjSgLbWRLR2Lf9O0eYEMCT2BnM5k9jqMp6x/8K7h0ttWWEUo7u40DJh1FBWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785841103; c=relaxed/simple;
	bh=REVxMUKkZFHUkoYJ3kcKFFymfNIsyM8v/bbcBZoJWd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQUjrCILvXdR3iIrhJjwo90u3tfTXYAl/ivax6yk+AvC5gwGAOewm0uEvEGptXjBLuHSfz4J5j0RofYjKCmIEDFz6vMuMJpBQNa8F4XRaWrapetytDJqky2KUbKYPaWgjzi4d/psXUEJVGhvoSRz2goNPFffsaNo1VaD58yOSBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dzv18sS8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dzv18sS8"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748Hpmm383165
	for <linux-s390@vger.kernel.org>; Tue, 4 Aug 2026 10:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DqwiulcE/P75XnQ0F
	5142Tph/IHG6v+l8t3J1BfQUrI=; b=dzv18sS8vMaCXOeKOidDCE578oK4JWMBz
	py5CvVpeoKRyfTt92e+9wKR0aceHCku3tEh6qYqGUCFZK1J5iA/olRgwcXRErWJb
	xQ1LTLr89vbQlDt0/B+6Tboz+8ebal0pVc+aBVD5iKMHqjxV27luYaXr/+Pt2Y5V
	X5sAueV+IPzSuR0jbqQ2hRza/27Rg6Pl7cK/1csZ9D+VxDd6o5djriH24sBgEK8q
	czYizbjF4zjlBXv2GAgqzKjXY7SdGVB+SOj8Q8pKNAEKlJufFrxM3FsS/HISLx8G
	bVnt/wF3ID+iJAjdPPm4GyYW29t5m4FORGfITQVhZ86wyB9mwBuzw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eun11k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 10:58:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674AuG1t020366
	for <linux-s390@vger.kernel.org>; Tue, 4 Aug 2026 10:58:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyhc56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 10:58:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674AwC9E16056608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 10:58:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3505320049;
	Tue,  4 Aug 2026 10:58:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A7342004D;
	Tue,  4 Aug 2026 10:58:12 +0000 (GMT)
Received: from ibm.com (unknown [9.224.87.205])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 10:58:11 +0000 (GMT)
From: Finn Callies <fcallies@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, fcallies@linux.ibm.com, freude@linux.ibm.com
Subject: [PATCH v1 1/1] s390/ap: Fix MAPML computation
Date: Tue,  4 Aug 2026 12:58:11 +0200
Message-ID: <20260804105811.17744-2-fcallies@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260804105811.17744-1-fcallies@linux.ibm.com>
References: <20260804105811.17744-1-fcallies@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Zp05cclXG3j_Z3nJA9Y9hoP5od5GGQKQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA4NSBTYWx0ZWRfXy/OMbOw/6BP3
 e46gXQARKPOoI9xpe+lh5v92Z6ek1AwsU3pYB7yKlikimAokReb8JIWEPY7chqZFfcTRfaM+Oxf
 oZfTxJx7uR5Aoj5cAbBR8SX34tqbCf0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA4NSBTYWx0ZWRfX9U5tu1O0UdcN
 4OPdu7pwu8PfWBJ60ROpKw/epcyKuXnYR7fWMyXV2jgxWK0foaNsqcuyCA6DTAlxoP7VjcMACjV
 nlvwY+pOGYsaeWN8l0P89DqHDzr3f/bmDq7vY/7AmEeIe96w8yEgatQGcgPYwjx6MW2EYYANmMl
 8ofpi0PJvIU5TbjDkrg34XJ+oSOzviMKRUob4KNC0xWIPSJNy4LSpDXALYWDpLEhJJbCB24lDtC
 Kkp9RSVXx86wpn07/7BZmjPfpSNBxgc85X4x5ca0TquL5BV1WVVtCiXFnFndH/QWq2UmXvFEhjF
 bF23koSm70A3Peeu7JD+jxV/6SyssdOFF8lUkpNWqiwrE0s1MFiDFAN8XQxg8jIleD6zBMK9GAe
 P6oW1Qpu+5P/QLGWUqmvOU1H6Ed16TgEnCf+v4BnGZaU3LaKqr6rEDfHXdcKTv/Y2U/SzgxHkZz
 hAM7A7ciSXoJivSevdA==
X-Proofpoint-GUID: Zp05cclXG3j_Z3nJA9Y9hoP5od5GGQKQ
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a71c5c9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=I0pAIdpgsTTtS-INlSUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040085

When the TAPQ subfunction of PQAP returns a value between 0 and 3 in the
ml field the Principles of Operation states that the MAPML size is to be
12k bytes.

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Finn Callies <fcallies@linux.ibm.com>
---
 drivers/s390/crypto/ap_card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/ap_card.c b/drivers/s390/crypto/ap_card.c
index e827fbeb76fb..c86397f4ddcd 100644
--- a/drivers/s390/crypto/ap_card.c
+++ b/drivers/s390/crypto/ap_card.c
@@ -241,7 +241,7 @@ struct ap_card *ap_card_create(int id, struct ap_tapq_hwinfo hwinfo,
 	ac->ap_dev.device_type = comp_type;
 	ac->hwinfo = hwinfo;
 	ac->id = id;
-	ac->maxmsgsize = hwinfo.ml > 0 ?
+	ac->maxmsgsize = hwinfo.ml > 3 ?
 		hwinfo.ml * AP_TAPQ_ML_FIELD_CHUNK_SIZE : AP_DEFAULT_MAX_MSG_SIZE;
 
 	return ac;
-- 
Finn Callies <fcallies@linux.ibm.com>
Linux on Z - crypto

