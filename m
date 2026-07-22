Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D9E33937A
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784716637; cv=none; b=n9Lq2is4J2XdJ1tRxYy86KvoRpDRAiDWg3rltd/NN7vPCLFM7jwN7RcRwudiKURr38liVBCFoOjra/WSLzioxS6VU3fiOnuk2SaiwFFvnY+hQmt0/r9KFXbfzeGz2jt5SeDgddvm6Fb5/W6XryrL4t3InwKnm+Rvi1Fi6q/QPnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784716637; c=relaxed/simple;
	bh=PLpplZRRhoYvEBDy51pa13/g0H+x38gqhrlrCYxtue4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BthL4Xp3hgTuOlkyQnFQ0Z8e2YXMBaOD++1WdKM9VlIdeshElCHd6qMaJ//Zvd16BZS9xKM7ibE0kvTlydfLtNdPMQ9DquC2Nit1B/tCBauZXWp9n+YjGOBo0HHfaPqBDzaaOj7CMN9AqUMDxxNfd7mhf4kzqsubDS3/yofcR+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MrvglKuj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MrvglKuj"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M9Bo7n3591158
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 10:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=78TKohvqWrrbbMb+7FLzePGDDMwt
	foMebtHaS0ocecA=; b=MrvglKujlKGQWN+xXDbB4xRAdGEtHsYl+nQz3BIOLxbb
	i1YmzdMot/YJUjtEozAJ+L9hEqKwA/w4cSG+kLVLVx55G4Gu3sBmh/LXnJYWglN0
	X7oKOWpf9MM+m3KdnTVezUrH1dF0TNfNMM+SWAX5wnOQYMl8X1YcdbK1nhDZnL3D
	7hhC19NqxEbOAEYU+H3Tzltm+jHsxmW8RWao1l+hjt9Rt84kqP4V7X4t0i76Ctn4
	gKAscQ1pIn56mHL4RogPHRhMlKKPLLKy8fqwL0tPOIhlS81A34LUJVqN+X5/5L69
	a/WRTPjdCO0v67EaESWFrS8xjbu9/GzJGaPF/M9IpA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77k97tw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 10:37:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MAYfXo011183
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 10:37:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtjxvtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 10:37:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MAb93O16712138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 10:37:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D1B320074;
	Wed, 22 Jul 2026 10:37:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 761442004D;
	Wed, 22 Jul 2026 10:37:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 10:37:09 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH] s390/dasd: Fix undersized format-check buffer
Date: Wed, 22 Jul 2026 12:37:04 +0200
Message-ID: <20260722103704.1709668-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a609d5a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=xGc9WWtXZu7sglNFPhkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA5OCBTYWx0ZWRfXxP6J99WqegXd
 iGnb31neM0T3QnXikXVy5XnY1uWMiLCXoO/oV8e7yulTa7hrrDl+ba08cGpIp3n4XQzUptLus/W
 0eaDZYshKOcl6ROS0MqVHJmJePx5APcME5r7BmmnageCLxQewdAbQHGC6unCUnMvGxin0qr072G
 Y1Uf4P7axVvX3IuuxUoh8nkQZy3Tt9ozfUClWOfZeDl5uUsV8m5+yR8Tt3EMCKuxpqRuy+KTUYc
 G608oSse3V6Vp4mh31xU7l2nZl7nRXoLvnbqSCYDCwrLj85ZWk/3ow66AKD6miZ1bVM0RIBZpSa
 JD5FuYPxePiAC3bicYu6JpZxLXDGjhBwYvrTVwXBXZk9OEw4PY4b+wbxlPu2Mh2N+o4PQJQuB7E
 VctN3MiK6Ao21zwqD+bbEKUbTF5QQkTCmvOJGVlA4qr686klMXReFm/M1w/71hrh556ekVCrkFV
 iZTKO+5z80Eo2hj9Pgg==
X-Proofpoint-ORIG-GUID: LwwD5kFH-cKElaP2srie2IcaqhV0dAAx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA5OCBTYWx0ZWRfX+FSPpmxs3PuH
 rrl7lRI32UG+nYZVgvUp6u7zhSYOlo0wFVeD/TmtuAkekzCyU9mCfGXNWFiKs+3yfQAhZTvat76
 IozL1jLESfhPGJFzO9mZy0/18vl9zGg=
X-Proofpoint-GUID: LwwD5kFH-cKElaP2srie2IcaqhV0dAAx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220098

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
index 073795ea7cd0..3d015ef48d2c 100644
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

