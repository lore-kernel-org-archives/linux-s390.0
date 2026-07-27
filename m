Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7A837EFFC;
	Mon, 27 Jul 2026 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162541; cv=none; b=rbIpkUFx8NdnullwSUawvryv89/bS0KA6zL9qYwqXAcxhd4/nw5//04YCjWXoeAs1VrC2eLjDYt95BFnkX59cWikT9FCc2PEWbi5U/shSU2relCTzq/3ejY5h5UaSKpaT7Nnbczq9lx1FUYOXz2tXEc5s/+daDTgQ+yFtKvkmqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162541; c=relaxed/simple;
	bh=BfGd7zKLm9twscX93NateSok5gG6Oqi0t8aVMYlbKqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K7YcYyPD8MwDtm3QCHXh05H/jn4i8bjhM2ogGN3oDfWgW8L/Tr/dDpijO6dBwozvKF2Nci8UKreaxY5/HyZg0etzCBJqu+Fe0Fh45l+m0iRnumd+CHpfd/HnUf2kuxwuFnnW5TXBzGayFedWx2XgjN/3FVqKUiUK9lzZvDfiKlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PlMCoWSS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PlMCoWSS"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDnWCL2292103;
	Mon, 27 Jul 2026 14:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=daJVaG
	PrvAQuxv+2ktFL9OCljrr9PH6hI6/vpb0iHfM=; b=PlMCoWSSCPl0xWGvSiikf5
	vG9m3H8EZXqy2RI5FjAYaILqHKgrTPpHMrLoZyHlF1gapoLe5xcgn+W0OgMrEWv6
	5LX3lJi03LA4gukILG9OsUOI/h3BLBPvRgRfWkMJIhSDk5t8QXHq5JneyMHpc9Js
	zbZxPlqKi92YA/ca4U0m3FnVRZPnjr0oc2YLEGX94aKDKKtbFo4uHTGpnu0r3MXX
	oKXvvXNvw9vjxB5BGjyPCW9h0sernsSC5TkGHG47ozrYCzPV3KRQxoXvfDA9IuME
	N2/Xz6fdyh8bsG3LW4oojlxnrMm9TRackACuKltmnmsGdpQDe+ktTt+OJYEpPD/A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0ng1yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 14:28:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66REQHP0005436;
	Mon, 27 Jul 2026 14:28:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xwf0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 14:28:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RESneh50331970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 14:28:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B96E3200C8;
	Mon, 27 Jul 2026 14:28:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C4FE20103;
	Mon, 27 Jul 2026 14:28:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 14:28:49 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 3/3] s390/dasd: Fix undersized format-check buffer
Date: Mon, 27 Jul 2026 16:28:40 +0200
Message-ID: <20260727142840.567286-4-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727142840.567286-1-sth@linux.ibm.com>
References: <20260727142840.567286-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfXwU4+9t3kH0XN
 ReKQwio8/MWPaSTrSWCapzfZtFLxYj7+JZ43AL5Awie71XFXyaeSG1Z0Yv9hkhCZhXjU8j5Zy+p
 nRU93wRar61GcVaIwfhwRI2DckoIJfU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX6GfQ+vA7e9Yw
 ebWZQ48yJvFlwWnaJB5hAlmYltKBXAVKq9Br6/bRYYVQDEfCO9wVdE0imYaqvQTY3nAqJDxSrAn
 T0r9hff0BFmtvyFHyogO5joiwp7nnx7w3PjEeYWOOu8rQs9lwz/vZvP7nt3U9IB1exFDNXE6XRW
 sWZurJFoz6yxkhPj2h7/86G14Q8693p0r1vb/ZLidxgH1PxzuNydxzCr4DUJFdLml0lDYGHesrl
 OtyGcVeDmvbPzd2CptPmmyrRhrtrBV7jWFQCkE021Xc0fbUeCwUFRBbKI50FfgiHGBvdyKeNeOn
 PCxrJMbfKeZFnh02g9NkST9aYVm5wkHUtUebG+5ChMuFsgRrghe+tcjfin3uUeTKjwKYIeXYNOE
 f3pIXabZSxjqRkKjSyvQ/oJz5tQOuI6szxAQjRL/nnNnOPZOYkwNMtQtvSPMgbbr3seUyCdEeCa
 2qp9OsZo9TCdRG7EZ+Q==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a676b28 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=xGc9WWtXZu7sglNFPhkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: pAP8hfn1gpfNRA9NRMiYpkoy7bia7rwJ
X-Proofpoint-ORIG-GUID: pAP8hfn1gpfNRA9NRMiYpkoy7bia7rwJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270136

fmt_buffer_size in dasd_eckd_check_device_format() is declared as
int, even though one of the multiplicands, sizeof(struct eckd_count),
is a size_t. The expression

    trkcount * rpt_max * sizeof(struct eckd_count)

is therefore correctly evaluated at 64-bit width, but the result is
silently truncated when it is stored back into the 32-bit
fmt_buffer_size variable. For a sufficiently large track range
(start_unit/stop_unit are caller-controlled) this truncation
yields a buffer size far smaller than the number of tracks actually
requested. kzalloc() then succeeds with an undersized allocation,
while the subsequent channel program build still operates on the
untruncated track count and writes past the end of that buffer.

Compute the buffer size with check_mul_overflow() and keep it in a
size_t, so that a value that no longer fits results in -EINVAL
instead of a silently truncated allocation size.

Fixes: 8fd575200db5 ("s390/dasd: Add new ioctl BIODASDCHECKFMT")
Cc: stable@vger.kernel.org #4.7
Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 74fe73b5738a..d356a9f8f016 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -20,6 +20,7 @@
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
+#include <linux/overflow.h>
 
 #include <asm/css_chars.h>
 #include <asm/machine.h>
@@ -3475,11 +3476,11 @@ static int dasd_eckd_check_device_format(struct dasd_device *base,
 {
 	struct dasd_eckd_private *private = base->private;
 	struct eckd_count *fmt_buffer;
-	struct irb irb;
+	size_t fmt_buffer_size;
+	unsigned int trkcount;
 	int rpt_max, rpt_exp;
-	int fmt_buffer_size;
+	struct irb irb;
 	int trk_per_cyl;
-	int trkcount;
 	int tpm = 0;
 	int rc;
 
@@ -3490,7 +3491,9 @@ static int dasd_eckd_check_device_format(struct dasd_device *base,
 	rpt_exp = recs_per_track(&private->rdc_data, 0, cdata->expect.blksize);
 
 	trkcount = cdata->expect.stop_unit - cdata->expect.start_unit + 1;
-	fmt_buffer_size = trkcount * rpt_max * sizeof(struct eckd_count);
+	if (check_mul_overflow(trkcount, rpt_max, &fmt_buffer_size) ||
+	    check_mul_overflow(fmt_buffer_size, sizeof(struct eckd_count), &fmt_buffer_size))
+		return -EINVAL;
 
 	fmt_buffer = kzalloc(fmt_buffer_size, GFP_KERNEL | GFP_DMA);
 	if (!fmt_buffer)
-- 
2.53.0

