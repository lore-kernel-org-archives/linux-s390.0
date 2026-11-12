Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479182;
	b=W+Y0rps8pc7RhNOkV3EKXVIx1Zhx0oxBVfFAjBYkf+0GBWy+XrGvU1HtSiCPbSTgE03i
	 jPfuCao8Gyc2qxBIZdtPyuiLrhwhRDMkNagrxyXbHRB/HbaQYXKCW+kTJ9zdLusCptiJh
	 hAy1QiMBL0CBpvot5q1ZvIm4eXV3GpIrzDXNxVgCvBu5cJPZzqAjGiqePW5w5V+h3es+n
	 KqBFba9PC3U4VutuiqGCbxfZWAScaCCxxx5JDBkDIolWpIqkemMw0mQxL9dqWvMt6FLOl
	 TkfJWrdWhBgNC0GrAMiLFVCMMtdKbOaxTCCqKHL/DRP9xY2G4x7om6iviE/5kJWZ7GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479182;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=JKyu0xCOfVZO4huzsfwrZUM5LUgJeujPjGfKxhCa334=;
	b=0A7hAgM7KZ8uB3MtNqsGLngr+lAXdjPHShlR1zCiOap5xP4fuKcExlTAvQcULqZ/gY5a
	 hV+F6CgL6mXEv2wp20S8pK4nN4Dloj+O4p75EeLYKELkp6vvFKYjddZsHjpxlEJtEUDTK
	 MfxtMwHPY4UXo4tsqyq7DqJMg/XZ/0o1ROivkE2yHYclM8BKTMrhCe04UMx9A4ywwsF0N
	 kW5GfMs3IqjpWULspmQ6jpLHzzdrPkiMzEZ6AIZQcmTXC7UokrJsz7ey/7fbSDvYDD96x
	 xy8JY69/em7ZMvJ4v0VgmH+XtgkgxpspAp5vynme7KifMCI7oOgNR7loF9iQK67Inyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Q8pyN5Jh;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5223F606A334;
	Thu, 12 Nov 2026 10:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5223F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Q8pyN5Jh
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2iETf2795605;
	Thu, 12 Nov 2026 10:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JKyu0x
	COfVZO4huzsfwrZUM5LUgJeujPjGfKxhCa334=; b=Q8pyN5JhwyEeVD/nmzTk2h
	ES1Tt9kflKzubW4rKNmFUDyhTinx0nm5YwO9ZzyMiM2dbV7LeWkfgwMTEvVy+hHx
	eQH5j2URJ2iyuMhw75asUHRrNxTc/EezZubjgsLFnl+s/4fHOWpmzhz4MyHQHCnh
	umMslLESdZGTpDj2ehnVQax2S9obE41O227PZebqsTOPTVoqMdw9sEfzU0KpKVnL
	I18PLP+EOf4Pw7hUkYNmbLFQBd5jKN90q6W3LHqgIyk9aQELFlCdDO6XQR/N4SMx
	hGZRSg1heZlYKpO8c96eszlzdO9yh6GchV/HlWO8XTSwKWbF73mYe8ojFnTM94+w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkxh5y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 10:26:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC8AEY0016709;
	Thu, 12 Nov 2026 10:26:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hv3328c4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 10:26:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACAQEwV12321106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 10:26:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 001772005A;
	Thu, 12 Nov 2026 10:26:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEEE22004E;
	Thu, 12 Nov 2026 10:26:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 10:26:13 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 3/4] s390/dasd: Fix wrong free and refcount leak in build_check_tcw error path
Date: Thu, 12 Nov 2026 11:26:07 +0100
Message-ID: <20261112102608.1057852-4-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112102608.1057852-1-sth@linux.ibm.com>
References: <20261112102608.1057852-1-sth@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af5944c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=5Urbv5Un5dQKbQTN73gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0MCBTYWx0ZWRfXzjQt/6xYmL8o
 KaEUy8DQiqB5zmIoJRKaF+qFQ8t7OccTdUmr5y6jLuBDeUPfjJD9+umOZYJt4klFDZIRTl4XjBM
 UC7lLs07bS0m9vsOv5VQsqZjtdKc5n+8pHLA3MDUHtX3riNCvWenU8M6AV3Cs1GYJUWfVRCUDoV
 tocV1ikH2YkHLmTl/g/NyRGq5IsC+PdZSSkKL7kw9q9/Rii39N2kkSAcEFP2Nlxbt37DnQ+uECW
 AR1hKCmbFhyW+HAz5A8R22srZzSEMmQx8c7AJYMboCTGu0Ooj0ugCRZuBtPswHuMFUbFuMM1R4B
 qKWhhC4r2HE9OpzJ+nEp5xzVIfiQN0QM95lAcs9FqSLMFT5FdU8WzEsBKgKd/WuKlzjB9JKKR37
 ihEB+Rumr3QNpv48pxvs2AtapJ8s2fWoqIse7cB105xwi3MDiRGHbI2TZV/epMtxE3qp3u8keJ4
 K478+URVhy8/kAmznkg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0MCBTYWx0ZWRfX+t7L/OWMDm7c
 dLLRPPGbW31XCCbJ2XpokJueNai/RYp1NMyig9YUu8qbBBcXtPhNen0yXKg+Yx4uZF42k9558Rp
 k/iF9Et0R3nUuYjGohwwiUp984NYHUw=
X-Proofpoint-ORIG-GUID: caj-PLkO0LQRR_iFXMlsNmGEIn6G1vjO
X-Proofpoint-GUID: caj-PLkO0LQRR_iFXMlsNmGEIn6G1vjO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120040

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
index efaf117e39f4..7e60d5b3b343 100644
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

