Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839769;
	b=CkZgrjtBggkgwogwznJAapH8LtZfidgvwEolKFflTzpM0hZaSm8GTehqHehpg5yzB4Lx
	 BrMmy3QIv8mZVTobEmWkxgVFUkeYyGooFHRDnjHMPm5qHYCALUfnkj91YYzZUa+6XQHW+
	 IQxfeb1CpLCNaD7xCCeakI0VbmOMX4080KoaGimuRM+EcJQUhriWSTW7VRhaboBDH4mrz
	 m3kbnHFWRQTAOB3icjAxdyyy4wYLtKqBHO7+H7ajyLx3anv4qWdISnJZhz0hiMPZnqr4k
	 hpzLT9ekaDbpowoigvSKT4QRyMdimU6fATG3DnK7Pemd4vkAxtqbKnHQimbUJSMr4Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839769;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=gxq1u5Y5JvGpHDA4wbTgmg1OsEp1wv/u4aV00kvN1CQ=;
	b=KssoyVHwKmmkrpWngrCjrLIVxkW7I6vtQKXS6TjhOc5XUTe2/6T08ic6LMRPJeF4K+jI
	 yZA2i/+xVPcj/M36HD6O4R8+YrP+y6LLe7GsYVpDshB9pu+jSLfRV21vD+Ifsp/y5ZsIF
	 WEAs0mjbD2AMKjHrHLkcWrl96RE3Ft7Lua9x0XC2vJBuxzHZOS7IUv92T6v0CgBhJX4Bo
	 VK3+cUOqjN6IP8bWUMA+O36Zpbr4Wm+iZ71W1xNE71ZM4K4M2MTqkjDPxihBIrzq+f59+
	 otxkMPsFzThhF2cizCsFnq33cT24wn1yG+5+C8109hTDkEkOP5olPx7XakKQEbDzeDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZM+5CMht;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BEA606A882;
	Mon, 16 Nov 2026 14:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0BEA606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZM+5CMht
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGDuUCO3631229;
	Mon, 16 Nov 2026 14:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gxq1u5Y5JvGpHDA4w
	bTgmg1OsEp1wv/u4aV00kvN1CQ=; b=ZM+5CMhtKwEk5+hBDIEQZIwvwhM1xjey/
	b8/OiECtx1jeBDFHITazEBm9IzCH5dJZWsp9xMjvE7zWU1EsWt8f9749F13uA4uD
	nBvIjDpLRYOkMKHHW2VdAFEpanXQlfM+T1Jy/cd87y70FdHD68L8NLUwxtwzJYwc
	d4ARmSlufTyJ1tkgD1D3yfvNcC4qLnyMOKlnGhHZjGV6U/bNGuUf/FiWi1NMThgo
	o+3c+IYEmzBbchkWSMgKVTY246EyFL/FO4eKodnw2GikURgGiNnpRkebn/AgaEHc
	bJFRy/5s5xrOiYXbLX2o3GXqusHOBLnCXY8cV+Y1lNUcl3UjNUl3w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxf5665q0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 14:36:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGD54xV3095352;
	Mon, 16 Nov 2026 14:36:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j02df8edp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 14:36:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AGEZajw44302832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 14:35:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD17F20043;
	Mon, 16 Nov 2026 14:35:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 803F42005A;
	Mon, 16 Nov 2026 14:35:36 +0000 (GMT)
Received: from osiris.ibmuc.com (unknown [9.111.42.169])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Nov 2026 14:35:36 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Anastasia Eskova <anastasia.eskova@ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 05/15] s390/cert_store: Unlink before invalidate in invalidate_keyring_keys()
Date: Mon, 16 Nov 2026 15:35:24 +0100
Message-ID: <20261116143534.158375-6-hca@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116143534.158375-1-hca@linux.ibm.com>
References: <20261116143534.158375-1-hca@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1NyBTYWx0ZWRfX9DrQTFbXUAZb
 ZL5mp0bGW+E4I3rwLl8ONHNy26Bgf5MfQ2azTE5L6FdNq/E4LsKiECI8zr7/tSPA5rptbCEUKe6
 ctxBQzxqgimkgcRbj3ytsTu2tGD3SbU=
X-Proofpoint-GUID: SHNWsvpHqwyJlv2kpeq1OTLP7sc4HYGg
X-Authority-Analysis: v=2.4 cv=ROImjIi+ c=1 sm=1 tr=0 ts=6afb14d7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=x6gZxsUigiepiaJj8soA:9
X-Proofpoint-ORIG-GUID: SHNWsvpHqwyJlv2kpeq1OTLP7sc4HYGg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1NyBTYWx0ZWRfX3fjBjHUTYGiB
 F5iIpXQZ9rtF0bs/AxHmEuGb25Dhp4i06jJv5Zb8XKy/uRKffSYwbeFv0zk92QU2eiDQN9ul+zE
 GsopULU862G/9S5afyTjY2IB6C8r6wIBZw6EIdEyj1HoPQdOzTlb/qEFUwFe6l4+Q9cwG6m2QNv
 mDthtZYj8kUqc7x5SJUj4RtSWU3j14nTSx27ck0h2aatYX/UOBoeOzcAOzM7YbDXNGru7TRkmXM
 DHPB5TqWRsbW/xhHmp7fRp7v2nSVw2D2gwGOypQzfEmpzbo0DsmBAABwjw59eDN+Dblba8HwVC9
 DBx9uZg+evbp6g1lgAFjplJIwkZgXVaQo9rQ26FPLO2t/xSKt1gHeDOhjOA6o+eVeboUQTfDNKV
 Zv0TjejMZGcM+85TKA+XZ0g3cP0D0yBGLiwq09atTOlEAZ6HoZwbo3MmXZIbn2L81t9Xr1c47UN
 pLv8BfmS5Xaon5GwW4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160057

If a key is invalidated, the key garbage collector may remove its link
from the keyring at any time. If that happens the subsequent key_unlink()
fails.

invalidate_keyring_keys() would then incorrectly return an error, which
would lead to unregistering the cert_store key type.

Unlink the key first and invalidate it afterwards to avoid this race.

Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/cert_store.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
index 8eb32497ca24..a69eccf6affd 100644
--- a/arch/s390/kernel/cert_store.c
+++ b/arch/s390/kernel/cert_store.c
@@ -346,10 +346,10 @@ static int invalidate_keyring_keys(struct key *keyring)
 			continue;
 		pr_dbf_msg("Invalidating key %08x", current_key->serial);
 
-		key_invalidate(current_key);
 		rc = key_unlink(keyring, current_key);
 		if (rc)
 			pr_dbf_msg("Couldn't unlink key %08x: %ld", current_key->serial, rc);
+		key_invalidate(current_key);
 		key_put(current_key);
 		if (rc)
 			break;
-- 
2.56.1

