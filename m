Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747290;
	b=uIZMrwR0Eud7CCHCuukCl/szQlErHwpRBfYyAP0Mt3Hg/ZVP7rSrtXlCjrLxxCPmvtNp
	 INAYw8uiJGr635F7ZIRmC34vveoW3I3DPYTQyqitWoVCxfp6XZM3ezXWFvM2oD2N0lbW+
	 c1hTxzrfN5bHZDw/q07ujGYJPxymkAyU+YhAWyb/vCJVWO8X+GzF/aiI++7ilxIsXeCVC
	 icFYSDYGkoqEJAYC33dFHKUqB90oM4gAjZEcAUuigfutZwC5MMwnsJ+ts2I/TmErLFule
	 BnNgo8EWxU6mJ5sMoAdoGxtqyohXRKe8D8vhHMTk4+OlUfHpFpgKJpoEmT3/V/dqTPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747290;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=9PZrQ5AN1wcEfiWz1+UkE0xyGHkXwgMOwYOZ40cFb8c=;
	b=KaggIpDGOvMB13Mccp7t4ToNUZFv66vLm1SQJRS9/As37DSk7lIJgx8XD5zZbbvZPCqV
	 OecHX/58R9605jFz4wgALGXHyzvdCegrpZCrs0PBdTQIc0ryqO2J8hOBd4NdJTselF1e0
	 67idsgQPI3x4v3UnUuOJypSb/+sWDbBrSslNm/9UKMW3l5tnNDc9sbHzOXBOSH+2uj0kU
	 iIYxpt4OGLDLMKLqnAaOiaExl7u/bkTTrm2RteCXskWbVPU6SK1uow45xHYNSdyEA45/J
	 Xfd8rC4n1izKvaYrUelSySfalheeCWsnSa3eiiuZr0L70kAv0UOaKj8z+4z7eM0K7JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="eXefq/rV";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AFB606A31B
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 09:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13AFB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eXefq/rV
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7EqXn2175051
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 09:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9PZrQ5
	AN1wcEfiWz1+UkE0xyGHkXwgMOwYOZ40cFb8c=; b=eXefq/rVWTR4YqhXC+AUol
	enrYdHZW7ZGioB5GD2C6s5E42ULjHtDOb+jMR/POsqyLN/KIg0NAHKqWuqPMUc3v
	7xtXGH546wCkl6SmhXkTvs1NaAn75Mxi9wyxTN1kUpydcw3XzFbwwdTQbYvG+81z
	/Blcvizf43cN2LVdqA11vjTknzSeQufO2zrcTn5DE8+d8ww4fnyNvXWcHrzbnqF2
	QNzzfnbUnD53RxN8joBiQpsWDDn0/mMQQgmBt2MrGtV1PqSt4GNalQfjBaei0Ggv
	unyKbH2IDqK5+rKHQvzBp2sNJcjfmEaEcPZJ84fdq7iYohbni4qkLOlPsKUtXLWA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5b3r5d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 09:21:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7JwNs1802314
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 09:21:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hfgck4srx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 09:21:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69N9LOu740042760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 09:21:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45AA42004B;
	Fri, 23 Oct 2026 09:21:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 306BE20043;
	Fri, 23 Oct 2026 09:21:24 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 09:21:24 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH 3/3] s390/dasd: Don't trust userspace-supplied result field in format check
Date: Fri, 23 Oct 2026 11:21:18 +0200
Message-ID: <20261023092118.3152286-4-sth@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=X63Hu2Te c=1 sm=1 tr=0 ts=6adb2718 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=T2NVWVN1rChL1tsUD_4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: VNO0QABkWX_qHJmX-CeQWUIW2Jo86HsJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNiBTYWx0ZWRfX1tYm6XhP9E0x
 tXnPoUco0jOBASkJkoWSZ/Qe2veOOLh/brSCO6YSjfsBnM+QORbmJ8w+jAqDSZ+6+KVnUh3YQ73
 5pa7NU+KdR3edOjWBDJbeRpY2C0hShxoKD9tVh8/RMYUv/rcI5Sucq3lQFVlb87kGw2wxWX0WXw
 Upu4kNLiHZS7Db7io2nYExEfVuPrPjuc0E88ZquJthMBt1ksq6o8pr/wq4pTTj8DPQBMMd6H5hE
 8asTBLqDht5vPD6DwQnq17EvvLqll2Fe7trq/PCnbVQ9GdoB9+AOihtXeC6v1jrarZAnrcYKyzq
 wuTRSa61ZMDWLsbxXKo7/Q8foj3Xtk3epL4WFGd7l5g96xLbiwV84CuB+6Wt5EYkjSDMmFXeTYS
 jCGEek/wx3racr4toKn7wajekcOzgNJSZ8/ghfa873Emp1WRuKOsYnAw7nCq+dMTNrm763Q6akk
 nuaQQ91zCNvSF67Peww==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNiBTYWx0ZWRfX0S3uRMwhQJs0
 ZMGchZrskIHdbQ7RtvP70bPwX+B+cGGNqgctuPlfm8dY5NyCRqcdayuP7shpwCmnAAdgs7C6n/o
 aamW/FtXgsnC6dsuUcUMXbqy/4Riqos=
X-Proofpoint-GUID: VNO0QABkWX_qHJmX-CeQWUIW2Jo86HsJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230036

BIODASDCHECKFMT used to copy the entire format_check_t struct from
userspace, including the result/unit/rec/num_records/blksize/
key_length fields that are output fields only.
dasd_eckd_format_evaluate_tracks() relies on cdata->result being zero
to decide whether to apply an index correction (i--/pos--) after a
successful check. A caller that pre-sets result to a non-zero value
can suppress that correction, leaving pos advanced past the last valid
entry; the (partially out-of-bounds) fmt_buffer[pos] fields are then
copied back to userspace, leaking heap contents.

Only expect is an Input field; copy just that member in and zero
the rest of cdata.

Fixes: 8fd575200db5 ("s390/dasd: Add new ioctl BIODASDCHECKFMT")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260722103704.1709668-1-sth@linux.ibm.com
Cc: stable@vger.kernel.org #4.7
Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_ioctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index e5b8b413f5ab..2f2ec2bea333 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -303,7 +303,9 @@ static int dasd_ioctl_check_format(struct block_device *bdev, void __user *argp)
 		goto out_err;
 	}
 
-	if (copy_from_user(&cdata, argp, sizeof(cdata))) {
+	/* copy only input fields, clear the rest */
+	memset(&cdata, 0, sizeof(cdata));
+	if (copy_from_user(&cdata.expect, argp, sizeof(cdata.expect))) {
 		rc = -EFAULT;
 		goto out_err;
 	}
-- 
2.53.0

