Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1007327C09
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233839; cv=none; b=QF1x3GxCHBT8ng+ckXQLTM4BpJN1W0whYs9MEj5dfF4ZropOcH4VuPok3h1zT+ejCmDUnws+D8eRJJzpMZLgfiQAVZh6QWj/lxSr+8lMZfNERl+Rx9wL6hZOZ92wX3bXtfMDPmQyTB0+c0jV4hw3FXqyHHUSbGaUhj66+b+TmUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233839; c=relaxed/simple;
	bh=2Libw6KIY63E/cRbmsTRYAvTOBxB751xEhwB7AHT4T0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ozgY9C0IfJt0oauALWa9f9wpYnls/1BTFFZaS3zlTQIjosxZm7iovDDw7K7LPA9EULFi+XUjyO2l1dmzRqhOF+5HXn9HGs700RJ/b07WSkrcNULJNCmWr4W7b0PQMRBD12N7OpJPtEaupNhKzpzPv1mYaERuxNHwsHFG3ZXtu/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FjTNWVCA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FjTNWVCA"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmLGW1914448
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 16:57:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ANtoRrH9O1WLVmrBPmLIEQqUonzbQuqJyw4BmNkuH
	K0=; b=FjTNWVCA2gDauLDjt9UvGAq01QSbmppvsB062hlv3VGjF6pgq9d3CSLJy
	qKtBql+rzmZRmwT5F5R45aHM/IJ1U+jdbT68qREWAgdBR9mEBANbfTmtwqsk3G/o
	c79JLEd7BMWD4eenNq1loyfJITYN+LKv3sbq5EO2RJVPhyvAS2jTuTkwBI8NmJ3R
	EmbvA4v/psYzr8+mehrWUpuMultMH9koBgLn3tdtqtpZBMezDI4ZE0Lx+8HVMDOf
	N0UeFY7LOAruLfhsnLjeJGZZlZ9pQx1Z1ruUpRIkBqdl3A9u+sf12J6oUm1tZ5a4
	U2comwoRMzGHY9AOWcRXNLJ/C0RxQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4fspk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 16:57:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NGYe2a026609
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 16:57:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phc9pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 16:57:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NGvBd753477818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 16:57:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C013C20043;
	Tue, 23 Jun 2026 16:57:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A41E920040;
	Tue, 23 Jun 2026 16:57:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 16:57:11 +0000 (GMT)
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: linux-s390 <linux-s390@vger.kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH] s390/monwriter: Reject buffer reuse with different data length
Date: Tue, 23 Jun 2026 18:57:00 +0200
Message-ID: <20260623165700.3548070-1-gerald.schaefer@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEzOCBTYWx0ZWRfXzRnRv2sMjP4y
 bH92nV2FxwklK6RTXh50xYHWdaAa8OalIHEaW5jWLrbkOnKVO6n7cnt2FmzEKscF20fIG2NjvOG
 ZwnrEL0hX8E8uLt6PVPN8i69Tenk/JU=
X-Proofpoint-ORIG-GUID: Zl9tr3V0UmUDYckvqc5NPMA-wVUjiDIP
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3abaed cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=rDSoTJiU-zr-nubo3I4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEzOCBTYWx0ZWRfX0nREuJLruha6
 iMSSeshbjolCBVAMKKAqmC4l7q44b50pSR+kydRjIdwOYrnm7L4tPnRzn9dYve7c/PF3YheqvlP
 WmFoC7cht/WxlZ/vfCZNARS0RpEGGxOQS4f6WfQyvygEjJK8KMPcPPxQ6EebbUm90tlS4l9xgJO
 vayZQT6FzIOhDlTFuD1DBAWxeAlJw6JnVS6UWq33JYvQkcwMUpzK6l2aAD30Jgj1wG16V9ql+cl
 X48kC4I000Po+meqMNKCJjvmSJHwgbSoWTfcTVMcuiFO6O3XDbgZFxXTLsF5FtUACTumoMWcc8K
 wf5UOM3MpD7RaUeKRpLoJ2KNLn5Nk3uBaiZxsWLPRuW/3hCifnNFz7XakVLu/kWtW3FH6rIy9ma
 /wsBl5SoE1CcdULlAUge3zGoYRxACFHvJuL5W+HmVaBwp26CryDrgQFnzB+Mx7BFgYiyT1ECHg4
 66tKk6CHLQvOEzCdwEw==
X-Proofpoint-GUID: Zl9tr3V0UmUDYckvqc5NPMA-wVUjiDIP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230138

When data buffers are reused, e.g. for interval sample records, the
first record determines the data length, and the size of the buffer for
user copy. Current monwriter code does not check if the data length was
changed for subsequent records, which also would never happen for valid
user programs.

However, a malicious user could change the data length, resulting in out
of bounds user copy to the kernel buffer, and memory corruption. By
default, the monwriter misc device is created with root-only permissions,
so practical impact is typically low.

Fix this by checking for changed data length and rejecting such records.

Cc: stable@vger.kernel.org
Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
---
 drivers/s390/char/monwriter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/s390/char/monwriter.c b/drivers/s390/char/monwriter.c
index eaeb4a6384d1..84e6deed4913 100644
--- a/drivers/s390/char/monwriter.c
+++ b/drivers/s390/char/monwriter.c
@@ -123,6 +123,9 @@ static int monwrite_new_hdr(struct mon_private *monpriv)
 			kfree(monbuf);
 			monbuf = NULL;
 		}
+		/* Data with buffer reuse must not change its length */
+		if (monbuf->hdr.datalen != monhdr->datalen)
+			return -EINVAL;
 	} else if (monhdr->mon_function != MONWRITE_STOP_INTERVAL) {
 		if (mon_buf_count >= mon_max_bufs)
 			return -ENOSPC;

base-commit: f31c00c377ccf07c85442712f7c940a855cb3371
-- 
2.53.0

