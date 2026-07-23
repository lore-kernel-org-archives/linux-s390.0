Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0691E430CC1
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 09:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800500; cv=none; b=cJxiDfblcZsQgZV1uezHnwx1gzCLz/WH38KSSFXCvMU1MdX1jxOBhc3E736LbCvziS/hnYBIn+3Lg7etc2w9pXTP1n1/DuT6Kplzb2aPZC8Qv/Iw2bIIFc2GZQfLSVoK3dcCQY2XxLoJrf9nKaQxMmVQkjns8HMC8eRni/32dWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800500; c=relaxed/simple;
	bh=RAXXFLU7+MPc656O//gEe3Ck5VxMy7HLYjJONQduGnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hd/sICPjspr+0Kt8HSwVM4s7uVtnMu2v8Fn/G5uwYvEF4X1C4VnUVXfBaG4BttTG4uXUIKp2rV6o+otqmxnzKngpr3hQV17nT0BQNLpzqB/gJCUymZ1mE0Y5NuGBMYq0ka6eFCnm88km1S2ZQHdOWjSFJ1bvCpTTOBicdgojHsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BWPakTTD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BWPakTTD"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N9Blb92585831
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 09:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AyXmNvDivWDoSm4i0
	YWAd5RHXJwelS9rPzCbGeDTTJ0=; b=BWPakTTDdu7Uok8p/Sv4Re9Txv4//nqrd
	kBUgM2FczOjSuDCRq9AC5tSNLjlOqMs37QVxxW21pprTrsRmvvFM4ghWc/wNJ1sb
	QUZF8FtF46s4av8uTx5Z1JG/+sC0HOHnvdCvaB7aAt0mlvIXdm2MfVgtsNOr9Clx
	RjGTIWiOpmflrjSKaxjdCpMjJ0ogGGSpucBzGNsEzjJ7UD8qj/27NIbLDKO9n/9G
	r2M1w0KRBre68A4Gs9DaRZFBG2QH8qmKRATs6/KEAZjvKgQlLqPhLLskPvTtg6f8
	iDANZNV9jeiQUZBr/k1N/RaEDRk/a6e7IdK29Vfd9WYkGPLltLLCQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahe9ry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 09:54:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66N9nckx013324
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 09:54:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wbnqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 09:54:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N9srf642729934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 09:54:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 387F0200F4;
	Thu, 23 Jul 2026 09:54:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DD4A200F6;
	Thu, 23 Jul 2026 09:54:53 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.142.235])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 09:54:53 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH v3 1/2] s390/zcrypt: Fix wrong domain value verification with EP11 CPRBs
Date: Thu, 23 Jul 2026 11:54:52 +0200
Message-ID: <20260723095453.127322-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723095453.127322-1-freude@linux.ibm.com>
References: <20260723095453.127322-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yQETi0JiUyozO9_CSkUEkPQ1Kxtpy3oC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA5NiBTYWx0ZWRfX0vmKbDTk4Iqp
 /5kp3yDuNucP+Cd/BPI2lXMiCF+ImAuOJBatJCG19s/uJ85ThNrD12pjy/f18lWfgBMJUsgg9fI
 lvYxnNEBKcZMqaX9NWL8Zai3mY2W3Ucjd7sE/92RV0qYGKe2qvpyk406t41evt9Kho84ucWABRI
 ZdUd9iS+MxbzWRKfProF05g7TiCWeqV8NAWuV6mKWpdc1AUU5cdL5xExHG9B4y8I0BjQPjhtOmj
 tC1qxxkoiImVjr7CzkfnXgq9cui71GcwG9G1qISMrpLxGyUu5fkyxPqgnny9GeQMglctZRsFfTS
 wmKSxKt59QfUgpipARGE7qRlksdK2jn6rHdaDjL11dF8SYb64WiJoqfcPeVxG7wSRLXOAo1Ofv7
 4TNMP5cKA/RCCfveG0zzEo5NrFNYOWFUCZR7gNeYB0tr0DN/s1hdZVXRPehLz1AA0Zo+XL8L7y2
 bVR3a3NzFXbitZ6NXHQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA5NiBTYWx0ZWRfXz+J9z9k0TWMs
 tVfDSTouC+1rY/66dYl8YPWX/2bmDvgzMcI94ZZA+MNPkofBCJWFkctQOUix06USUH/iB5f/l6l
 cVwZHJgNsZTj3Y0WPWXaJeLb7r4JbDQ=
X-Proofpoint-GUID: yQETi0JiUyozO9_CSkUEkPQ1Kxtpy3oC
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a61e4f1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=Pa6B3iQwBwFtng1MImYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230096

There is a wrong upper limit check for the domain value when an EP11
CPRB is processed for sending to a crypto card. This check is only
active on custom device nodes but may lead to access heap memory
behind perms->adm when an administrative CPRB is sent.
Add correct limit (AP_DOMAINS = 256) checking to fix this.

Fixes: cfd68b33094e ("s390/zcrypt: Filter admin CPRBs on custom devices")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
Cc: stable@vger.kernel.org
---
 drivers/s390/crypto/zcrypt_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index f57189c2b839..81eefdeae248 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -1077,7 +1077,7 @@ static long _zcrypt_send_ep11_cprb(u32 xflags, struct ap_perms *perms,
 	print_hex_dump_debug("ep11req: ", DUMP_PREFIX_ADDRESS, 16, 1,
 			     ap_msg.msg, ap_msg.len, false);
 
-	if (perms != &ap_perms && domain < AUTOSEL_DOM) {
+	if (perms != &ap_perms && domain < AP_DOMAINS) {
 		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
 			if (!test_bit_inv(domain, perms->adm)) {
 				rc = -ENODEV;
-- 
2.43.0

