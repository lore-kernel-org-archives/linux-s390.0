Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D983381E88
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733634; cv=none; b=eFsN49EHG222+3ld/GVqp5B9m0BZ8rvDF2TBM+abmVZYa5KzQHC+PaJPCXaSeT3Y9c2StqrMIxi6stbZkI9AkWrU0diiXrcW4+6eNFun39uXHjMs8YFHPOrXUYEL2MesIe89JegsJ1gh+Y9vM2/9kTa0PfW8QpAUNBRn1ku74nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733634; c=relaxed/simple;
	bh=++aNRiHnePKYPVF8aPxBUuF/AfCvo7z59aczXnehNpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUR9EhtW65EynQzlpd+gK750T2B97sffN1Ww6HK1SRUZzv1cIH5D3ehfEbXgPgLQkffTwqcytqo1cKbmP/xgxT/mTGO6eOkt4UAsHsGDkcNipYyJEXSwMuX4/uu/BQkBaYiAZy2h1Fr4oH3bSosDQeTI9jr+GFAOsbgrmQUtuAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UJ/VPtix; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UJ/VPtix"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MDfidd4182047
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PA6OC9sBmuAPp5Mbx
	LjM3NACla9IMq8qPFNvZaPce0k=; b=UJ/VPtixOUxAOA13yrAcL6J7Gszx1Ci5/
	rSxQ7aJ967z4XEGKd0UUqQoXTpOHQxpvWHx0phvuVv+gJ5+9LsJ+VRBoBYj+enjs
	aUKEL5PMvJpw8lsQdnsTDa4rrfNS3lP3UQ/tR1EoCfmJCtgr7+jVzC9hDa3xE9Vk
	LglJGZfCqwYBL8CessZ3xCyE435ujEjwBSU9a9+L4jNu/y+O5OJbqXFZixGMmSq1
	zO8wWoOh9U4qqxiAmM5EynZ5XYoDeskBEGT/vjq+OkMjSOdb19ocSwEVFznu5vga
	aA34hbgI30oM26Tk5h2FIomAlDI6qf//i+46lj5A3mkPtZtdLn0Hg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gad07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:20:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MFJb8I012726
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:20:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gfph2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 15:20:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MFKOgt60817768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 15:20:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD6D420225;
	Wed, 22 Jul 2026 15:20:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3AD020226;
	Wed, 22 Jul 2026 15:20:24 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.200.113])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 15:20:24 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH v2 1/1] s390/zcrypt: Close speculative mem read possibility
Date: Wed, 22 Jul 2026 17:20:25 +0200
Message-ID: <20260722152025.119391-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722152025.119391-1-freude@linux.ibm.com>
References: <20260722152025.119391-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE0OSBTYWx0ZWRfX9mpJ8c+yOOWZ
 YgyuHWawNDIUMliI2OJ8mHNxUW0O2MO+/pAnNNiTj8rnffL1PxgbcTn2eFTlklMbGBYKhAnf+pp
 eHYSM0420V+Vzh9/sTNKeLqsvYoOG/Rxt60oxI9IVFJPd8HWAFTN4oAKNgpdeyD7mkCl7OT/Vz0
 8Q/tSLLGhyS0nwKrFaXH09//qsc0hCeXUVfEMY7zLqqgSgL9tO3hGkwn0rf4SrN1YIwSWfj21By
 KUpR2IgMpDg/ClITDbzO4FdohWcbYZ58yEV6pmMTVFZGpO/kn+hvSJWIRNlMhKjx1oEb0BtYUqN
 bewZLc3N+KGJ+v05FFArBxuBQhqFJ4nIMiBJTp/PuKYKpaYD3cNJeAW8GaY3Bx+y1bd5vNtvlKY
 k8RAafzFizy7M+2dQa/Id/ws7/O1Tzx2AlpaqfBUVJA+hx2aDVo0X12ys/jtfSr6WqDm6Ltugir
 Kwl0YOkkPPeH149G3Iw==
X-Proofpoint-GUID: Idx0Y7f8IKVjx9sUSqGC3u5ELTzby8UM
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a60dfbd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=IZBGf3zZmU-6-mvM01AA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE0OSBTYWx0ZWRfX+RdigHU6p0x4
 4H3/U6aDV4DXE4Owkj5Y800VQqR/srGXoMIG+QcVnHOijtifKCmbRELFQEWppOjT/7zuiI4XYCj
 TJC+XeegX+2dzgJkVhFAVHKPdI+a7w0=
X-Proofpoint-ORIG-GUID: Idx0Y7f8IKVjx9sUSqGC3u5ELTzby8UM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220149

The domain value is extracted from a given CCA or EP11 ioctl struct
when a CPRB is about to be sent. Thus this is a user controlled value.
Under some special conditions (custom device node used, administrative
load) this value is used as an array index after bounds checking, but
without speculation barrier.

Add the missing array_index_nospec() call to prevent speculative
execution where this domain value is used.

Fixes: cfd68b33094e ("s390/zcrypt: Filter admin CPRBs on custom devices")
Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
Cc: stable@vger.kernel.org
---
 drivers/s390/crypto/zcrypt_api.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index f57189c2b839..593aace5fc48 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -879,6 +879,7 @@ static long _zcrypt_send_cprb(u32 xflags, struct ap_perms *perms,
 
 	if (perms != &ap_perms && domain < AP_DOMAINS) {
 		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
+			domain = array_index_nospec(domain, AP_DOMAINS);
 			if (!test_bit_inv(domain, perms->adm)) {
 				rc = -ENODEV;
 				goto out;
@@ -1079,6 +1080,7 @@ static long _zcrypt_send_ep11_cprb(u32 xflags, struct ap_perms *perms,
 
 	if (perms != &ap_perms && domain < AUTOSEL_DOM) {
 		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
+			domain = array_index_nospec(domain, AP_DOMAINS);
 			if (!test_bit_inv(domain, perms->adm)) {
 				rc = -ENODEV;
 				goto out;
-- 
2.43.0

