Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479183;
	b=KP0z0Hi64jEK3nGh/WRIpfxVCP1IzIiuh+P0Kc8ceoMTGrf4mpdqZGHPGLHqoNkxWznu
	 BKPo6JMRB8kMQ+ZMXbVK99VsiGeh6eBm5TPBmyfZXlBp2srIg/yIUMGydqyTh/VFOJxkw
	 YejWrrcBnOc39KPyZvOVKcoK5uPYqIwnb8+cDK1bP1SaX4nP3eO7ld2ol6+Hao6N61xXd
	 Vz0CV26tfqBHw6BeAi+CFx6FN3rHshpW16s3c0i4J6Rgi5eRpgOnO97q7DOYoS1hGI1p6
	 aYPGFr39SJ9CTfeqfo7IBTf1qYpZuK++uV06BthSkp+TkhjDjFrKOuF8sfHJqsd4z2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479183;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=9PZrQ5AN1wcEfiWz1+UkE0xyGHkXwgMOwYOZ40cFb8c=;
	b=G9kXiA5HetYphCG+zirNuvNuu9agh8Wqs9RDeD0Ic5RH5Fd8a1J03JR/sro1N806S3BZ
	 Pg7RUeCUQC7RHADHfuKe2Al6HsKXIE4NT+dnPEA49n1TW9Amo6SnRnaV/2iqNTXv5+OeU
	 o+Nrjjb42J9vPBMqhmwGE/gsiy7dxI/U4H1kOp1xAM+yEAv297oDMErJ/l1tcFM5AehJm
	 RWWsipD/XJEXnNbysJ9OEyd+uHfkgr0hLEeqf6tOlBAhJOfbws0/VCw0jMNh+JAoLYDPH
	 SPPQkQ2M4/fzcsWG44DUME2CSl6ujX+4MQPVBRRkEbltBouYFRoWZRkm/a+2GAqUP4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fG7Fn300;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CB0606A881;
	Thu, 12 Nov 2026 10:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04CB0606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fG7Fn300
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2ipml2858327;
	Thu, 12 Nov 2026 10:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9PZrQ5
	AN1wcEfiWz1+UkE0xyGHkXwgMOwYOZ40cFb8c=; b=fG7Fn3000Hha3yguBdb07/
	NEpjy6meCav9pM/dlV9jVWnzR5PS01V8fwKxCC2x7334xTOwo1qoHrrhlP7YIAHN
	Wy27/RxMGP9gh9JuxGi8u5rGACpQwg8EUi408QJIiG5oGOUrHrhdqFRWGlmZTsjb
	N98KqlC4/gt4fb8Yr7YiNvAtE30meI29oxzSPQtTIWfhlp5pCbjISrSEnkEBFVnF
	DW9HHJXN2Vb/A7AkCo3R3QIClOhZs6reUfoAOT5xPpbydsL/kHvhaikDVl9u5yWj
	yzI2O5sjI51Qh4ZUPQZCKt72RAIHPPcwKNcPCXXsY1Z3g2Ia7flkA0l7DTl5PmQA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumv5r85-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 10:26:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC8M6GB097830;
	Thu, 12 Nov 2026 10:26:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hvkq0vv4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 10:26:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACAQFlr28443112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 10:26:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10E042004E;
	Thu, 12 Nov 2026 10:26:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEE302004D;
	Thu, 12 Nov 2026 10:26:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 10:26:14 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4/4] s390/dasd: Don't trust userspace-supplied result field in format check
Date: Thu, 12 Nov 2026 11:26:08 +0100
Message-ID: <20261112102608.1057852-5-sth@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0MCBTYWx0ZWRfXy3JHZTpzA6Za
 SKTlQ9gm++TZDjSj2qeuaDcLxWBrAEowCNi+RDxKU5Tym0EPR3R5mEDRiF4R0YzdwVh9eozWdZG
 gZotciR08l13mKgMEnAe/ae+HM991Qo=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af5944d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=T2NVWVN1rChL1tsUD_4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: JKYcDduqh8i70yitUUG2GBeA7JFhD47U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0MCBTYWx0ZWRfXwqcR11pChrO/
 RtpNk4PiMpT4k83V0eEjjD9sVo+DKVjwOHjSlaPmARHCZaDOQ3mf/5dsoU3DRCOr/DzlQVwn182
 AtZO1DuLV14kR0JOeJSfq61oc5eqrZnGxM6IFt8bL2MMp+vpqxXZUQq55+8XNX9iQZfWh6QYxAO
 1f7y/DttUUzC7+E700xwof53zA7VwmsgnHZsTs15OvsOPNxUF/Uh4t3XMHka+viRxQskN30IcPV
 /sCKz8HY+iHk/tUtfvIlmupH1b4nSXXIggmj6RJ1F76tv1vE/FgnBnRTjoGKhfFDtd+YNuAC4mP
 FcdwYhIMuLtJ++fGoGlPTvUwb4Kv3oY5D9xj2KrctTtFkg0T5lGRyyRvE3EYaBD3KwiyuJ7Vfos
 HCEyy5ZsCaj5SYJf/UOmB2Ek88R0Fg3cQOOX2KiFylKKY1cc4D9Pd38aaNFFR4djT5oYzpMNDCa
 A2VIltoII15mmo+oghw==
X-Proofpoint-ORIG-GUID: JKYcDduqh8i70yitUUG2GBeA7JFhD47U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120040

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

