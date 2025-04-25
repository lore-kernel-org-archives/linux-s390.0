Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E036C2472A6
	for <linux-s390@vger.kernel.org>; Fri, 25 Apr 2025 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745591997; cv=none; b=V7PpsrNCMEbc6yBYzE/jlmb8glKImIZb2uE1BKK5Mp60CkEYu2NVYy7ly8p/5ResqrzGKMVZhBz6KMHEbTC7r9ZLDTsjN6oCrA5riKK+9c1pj/z6w/l3PbaTC6zXiztZ2xscwP/HuAZUcIT7xBI7O+DQdAPyUrARTKeyNS8cNwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745591997; c=relaxed/simple;
	bh=6/5mzL7yT2Vl0mm8W2cEM4v3axGtaDQFZwLHZ4sb6Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=umeQ4tqild92GksozueEw5y4ybiEd5LjIWAb4zoXtIaUnWwipYnbnKxTR0zl5PK1R2+jPVplH/mBjeJndI/zpck6t/j6kKqTAWEhdLKfmWcUK7L+jgUhyAg9N7MdmjKA7N6kE32sAoaZYwfZusDQCaB6CpYmznMaeteMZCoY7Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NmjcrCJk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NmjcrCJk"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PBNjkZ005251
	for <linux-s390@vger.kernel.org>; Fri, 25 Apr 2025 14:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=3Q23sv5ZDKNor3mmUuysGBfIsSwivvgS3mnX0ebB2
	l4=; b=NmjcrCJkjFD7Lq00r4veKUwWCthTu743FuIPBMGn5+Skbx+BPVBhQxnUZ
	AH3v3Dlcl/gnqQTSxcS+zjPRgM0CIEHEmxV7/4j/hezI2w8iJ/CqA/jjhqQHNs7R
	v5xzH25jy+NLi6mztgJQgB+qDKXAX57BQniBMSl1+iuWeXjKQxFs6uN6kCegO8gk
	P2IILfauUFgLE53Vg5e63u0u+QOB1rVtFBWrioYKuwG3vcF/MfZvFZfI0KPKP1xU
	cgvKnJzBet35ALG/HaT2zMDOJa5fYLa+BwnCUqHhUAFKlfhymL91ARIvB71W2Ut5
	052Bx8w0DQHmJyrWPTDJJz8VHaKMw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467wd9ku9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 25 Apr 2025 14:39:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53PCvoaM005884
	for <linux-s390@vger.kernel.org>; Fri, 25 Apr 2025 14:39:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxnm7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 25 Apr 2025 14:39:53 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53PEdn5t46006536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 14:39:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A68A420043;
	Fri, 25 Apr 2025 14:39:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A62820040;
	Fri, 25 Apr 2025 14:39:49 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.111.1.157])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Apr 2025 14:39:49 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, dengler@linux.ibm.com, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, seiden@linux.ibm.com
Subject: [PATCH] fixup! s390/zcrypt: Rework cca findcard() implementation and callers
Date: Fri, 25 Apr 2025 16:39:47 +0200
Message-ID: <20250425143947.31249-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xZZ49GixITBwETZJFGlZQDcXzKpqYQVa
X-Proofpoint-ORIG-GUID: xZZ49GixITBwETZJFGlZQDcXzKpqYQVa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEwNCBTYWx0ZWRfX3FWtM5NmYCBu 683CRbD6SyzEMInS31/lWXo3aU9G6OvOo30bOpvOQLVIcwrT3IAfuL7koThXLQohFXuD82L5ekv X441UBU2fPNgo7GVRjfOAs0N+o/P7FXFgGf8pRboH0fqzl2QI6ijTg+Wole5cCN/C5cJjpauJb1
 iKcVHp6o2WI9qtenzO8bCk279VO1qSdqXwO2bdIuTNxaH5/5k59NL8GwiUScTWxewZMV1Uo2f38 71fVQdvXBJAUTFg/pl/NVCbHZ5rY1J1bb5X4ykJ7VrFC1pASp5x6xh1+C0+vmQpOZkQy2OzNd/I tXhPoBDeVmcrDAOIk36QSUv9XI2OVCKkRDx72YKpmIruCx9sntLDQLbK0VKo8VH+4IgflPll/W6
 PK/ePnYqb51CXfEyDNvRBWJun5a9raQLQj3vE0qDZ3PZyYKCjhVDvG6+V72H2RJAKeaXnWD+
X-Authority-Analysis: v=2.4 cv=M5lNKzws c=1 sm=1 tr=0 ts=680b9eba cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=hr-ovdYsTRzapwpkf0UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=726 lowpriorityscore=0
 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250104

Ci run of the night showed that a CCA secure key which maches
to an old MK on the HSM is not correctly verified. The code
builds up an array with a given apqn array with a fixed arraysize
and calls findcard2() for the CURRENT MK which fails as expected.
So next attempt is made with trying to match the OLD MK with same
apqn array and same arraysize variable. But the previous call hat
set this arraysize variable to 0 and so the 2nd invocation finds
a valid apqn but the arraysize variable tells there is no space
in the array. Fixed and tested.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reported-by: Ingo Franzki ifranzki@linux.ibm.com
---
 drivers/s390/crypto/pkey_cca.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/crypto/pkey_cca.c b/drivers/s390/crypto/pkey_cca.c
index fe67946edc9d..6c7897a93f27 100644
--- a/drivers/s390/crypto/pkey_cca.c
+++ b/drivers/s390/crypto/pkey_cca.c
@@ -487,6 +487,7 @@ static int cca_verifykey(const u8 *key, u32 keylen,
 		if (!rc)
 			*flags = PKEY_FLAGS_MATCH_CUR_MKVP;
 		if (rc == -ENODEV) {
+			nr_apqns = ARRAY_SIZE(apqns);
 			rc = cca_findcard2(apqns, &nr_apqns, *card, *dom,
 					   ZCRYPT_CEX3C, AES_MK_SET,
 					   0, t->mkvp, xflags);
@@ -520,6 +521,7 @@ static int cca_verifykey(const u8 *key, u32 keylen,
 		if (!rc)
 			*flags = PKEY_FLAGS_MATCH_CUR_MKVP;
 		if (rc == -ENODEV) {
+			nr_apqns = ARRAY_SIZE(apqns);
 			rc = cca_findcard2(apqns, &nr_apqns, *card, *dom,
 					   ZCRYPT_CEX6, AES_MK_SET,
 					   0, t->mkvp0, xflags);
-- 
2.43.0

