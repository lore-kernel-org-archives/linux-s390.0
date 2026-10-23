Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747289;
	b=B2kwCjQD6iPdnvpwl5XB+5K/JHbXwBk7sfLfmD1Ws8RmNS8o2esNejzepxPM3BhrdWNt
	 uadUt44Qs+z6FS32zK2TDOR1tFPmQHdM4KRYbyiDQHL41/yNNsBOeD4ur5ngfaaCnPxqg
	 I4lmJqHE0atRonU8eIA64S++2HbOsSfrSxdlPjDKTh3Y6S7I9iU1iPwu+7U4v9pAHiQ6j
	 ZqmIrElM5a6Fh028Lc8/1NphbyTScyW0DKamSfhyduqUez/jINlZ+XNgtPK6f8+Dgolx9
	 t3wNfXQ5bPKVVYVYcMGmHUBL+GR/xahGzgux1Dawc0rXlC+Qb9qGvsPjZlAOLryqdDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747289;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=VOSC57FWK6sIt0B+McD6/+QZIG/HyjTDvquflYLJZYo=;
	b=H3q1fTQRjz4yuQbfgPUGaIUdU7on/2GUr7aKYm08dfGsb/CaXybnu5iuSsuixvQslZeE
	 QjFZlqWNdDfLGV8DBElYBh7BK8PtziMgihPz93UINQc9TJxj/ezb3470GivGEW3CpW9Sk
	 jGhg6IUXq0JIhX7D3mptp2IPl6nAvYnfF7DLSpQwEwWMcvM2mIGSOaoJuiF4WoyjPfV9O
	 ThST1FBIvfpOsQPuIuulPzmxLMnPKbNDA3P8nRE4SALdZI/w3au9VQC3xVHmR3t4Yws2T
	 dNPNS/Q7NMYq1jPEkDFkWDkyzABNE71iGzMd8vgFUt2FFrEe4IgLAguSnd1W50JXIzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=G5TSZkbb;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7F9606A31A
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 09:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F7F9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=G5TSZkbb
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7EjRg2174937
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 09:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VOSC57
	FWK6sIt0B+McD6/+QZIG/HyjTDvquflYLJZYo=; b=G5TSZkbbIQeHh90Bb7Yhzm
	xFNS5871fY/8TrVni1j5TM6oNONsS9gcyWNw+rEVjj8lKz5bYEuJKLnDzb/vSAdV
	Gk/mYmdcMUXL9AD4OijSsXU4YNVe4IMR5E5h1hyw8mWkPYXqqxW6wUVLu2xtz2RQ
	yIJro03D4L5o6tSovU1sLOR/BKFzgzigriOiteGZWrIa9PfRk7Db447RE5TaBAp0
	+Riv6ro1Tg/v/1zQRn2kxrYa3+D5WCHvZ0H6stGt5zOhp9/6wo/j9Hmr6v2oOPGx
	EOcFmsO7K4LiO6d7N9YdOOOYwuhI2Q3h9FfPjd7NDuhJOmx5jBgx4yD3EHVmXrEw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5b3r5c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 09:21:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7Jutj1800653
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 09:21:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfmpn3tcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 09:21:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69N9LMwE41353478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 09:21:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEADA2004D;
	Fri, 23 Oct 2026 09:21:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99DEB20040;
	Fri, 23 Oct 2026 09:21:22 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 09:21:22 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH 2/3] s390/dasd: Fix wrong free and refcount leak in build_check_tcw error path
Date: Fri, 23 Oct 2026 11:21:17 +0200
Message-ID: <20261023092118.3152286-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023092118.3152286-1-sth@linux.ibm.com>
References: <20261023092118.3152286-1-sth@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X63Hu2Te c=1 sm=1 tr=0 ts=6adb2717 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=5Urbv5Un5dQKbQTN73gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: PHe-t2vgh6alWUpgpjqeJz5etyDo7zf8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNiBTYWx0ZWRfX7s51zMGcMTfL
 oaWExt4VvSPoLJDxYd91YJchfi18MvH/SVDZ1fyQVvxSYJkPpoKxc8aYh9wgX6SVBSXpJaK1Vo8
 BFBigGFw9WR4YWnGp8QIdhoIF6KiJU86sZG3MQBV70K+3i55ZqHLCfapTquhAW7NZkv/PYfFcNh
 OgIY2AWcEt2fZ7y6rwLP7jFlnUEV/Sc7Mltj8PVyPT1UmbJ7uzXc8i1QqzfMvR4821y6vx4zvHH
 ZhGewz2Sl9LGoHoTyYjtHVvgG2clClHASgdQP0OiBHmht33nf2J24qqLUDZXsEFUzNsM/TM8Po+
 w5T7xKTccUbmoG9+bjXrSJfl+xrorzN2jcSQ+U/LddCOuddT2Ik+uLcEhLCBkJ7eYvg50RwFxnq
 7LtBluzAZW7RxFO1l8EenCWCCVd8+/pzDAKzGz59Jh5A3dchW0Uu87Cv/Qy3zO/gA5eJzzNe4Ra
 /Dd4gLPszgSkvU5boVg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNiBTYWx0ZWRfX64tVKqwhXnOR
 IqA2E9GeKeNjWTh8frQlKPXdLYnZxYVT9RXFk7/gHyf8eJXMJV/lUesFrhLOfSih4TnhEbbh03t
 axwUWzvXko762V26E18sQhF6gm02Ox8=
X-Proofpoint-GUID: PHe-t2vgh6alWUpgpjqeJz5etyDo7zf8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230036

dasd_eckd_build_check_tcw() allocates its request with
dasd_fmalloc_request(), but its out_err path frees it with
dasd_sfree_request(). The latter uses a different pool and therefor,
leading to invalid pointer arithmetic and a crash.
Use the matching dasd_ffree_request() instead.

The same error path also leaves start_priv->count incremented
without ever decrementing it again.
This leaks a permanent reference on every build failure.
Decrement it before freeing the request.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260722103704.1709668-1-sth@linux.ibm.com
Fixes: 8fd575200db5 ("s390/dasd: Add new ioctl BIODASDCHECKFMT")
Cc: stable@vger.kernel.org #4.7
Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index e910d6b35f0f..687350504c3e 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2764,7 +2764,8 @@ dasd_eckd_build_check_tcw(struct dasd_device *base, struct format_data_t *fdata,
 	return cqr;
 
 out_err:
-	dasd_sfree_request(cqr, startdev);
+	start_priv->count--;
+	dasd_ffree_request(cqr, startdev);
 
 	return ERR_PTR(rc);
 }
-- 
2.53.0

