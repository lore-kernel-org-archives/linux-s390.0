Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503BE2586C9;
	Tue,  5 Aug 2025 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754384653; cv=none; b=Q48YTQ/wdDY9SQfRPQHf/TZJvOb5PeavU/LXXwEywUng5n+nFAo103dMd2NXx6gP3ReDRlXQCPLKs8U1N2vTfvu2aPaNXM9zvsvjjvuHEBEVA3IeUtDNIUSUWm1dm+Aq2r3vjfmDEbKp0gvGhXNrTY2umygq70L9kziU0zoUW7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754384653; c=relaxed/simple;
	bh=NUpfptKkWuTZM/PifetKSGfcOkDvXHVifVwI0o/vcLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ODohm3mpm3yJcZCbeGfKQ1tfkK2YZjKml6wDBmEQcyr1k8X4747i7S3pnYaQ2vsnJBqJLhoxFGBBz79FKl2S8fvBHDurFyCF/jpZhe4AYdwWF3FMOXXnDAzji4f4V4fLp+sB2WAXx4mrK+jD+Yo3ea85A6Tbvy29BygMq8zl0OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qXyRG3ax; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qXyRG3ax"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5758xqeG010877;
	Tue, 5 Aug 2025 09:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=elaOjrB2plLMfQbXE+Lk2N8XqtfoumlKiKpuacXIZ
	T8=; b=qXyRG3axLn6MB64VBggkMfnvWGsQ5aPk3W67GG7j+E720EK6GtAceARBc
	K/DesLC19CSpY5CdFamZ4d5RPz+egwEF6aN3gqC+0/zh9uRgydBHPNhiCPlKpynN
	3HVGkxKrgJ9R/70KAVxT7Ca8TGxjOSYBkrHPQuzn3fvBmASZFGtqU0DUyMLqrSN2
	7lka0wvr2tmmJR4jdpeJhU1HwKD0dE4h24GwIdYukHfAj4oPBx+LsGiS9XpYcRpl
	o3fovVrshK/9AP2rWIAbsDHBkvstPLyTr/mvPn0k9eES5WSFaSklA+N7hIiOGYdo
	9b2HkEXX+FZv5DUm93s29ZhaGM4VA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48a4aa1h8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 09:04:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5754T3FZ006823;
	Tue, 5 Aug 2025 09:04:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 489xgmhm8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 09:04:06 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 575942mX53805552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 09:04:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB8B920043;
	Tue,  5 Aug 2025 09:04:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C40D120040;
	Tue,  5 Aug 2025 09:04:01 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Aug 2025 09:04:01 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/docu: Update header documentation on BPF_PROG_INFO
Date: Tue,  5 Aug 2025 11:03:49 +0200
Message-ID: <20250805090349.361730-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ea2xIgP8pp8XjclC_aBc8dnKKfSInHZn
X-Authority-Analysis: v=2.4 cv=dNummPZb c=1 sm=1 tr=0 ts=6891c907 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=85rDWHBjpAYECwts9QIA:9
X-Proofpoint-ORIG-GUID: Ea2xIgP8pp8XjclC_aBc8dnKKfSInHZn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA2NCBTYWx0ZWRfX6D9stS0W+OII
 dujpK4omHQstZqeXjAQ8DMFWnaRldKju8W5dguMn8Fu8ENkO0uK6FRqi100K22IRZKQNR9f0Rrr
 riXOGpXT7Pm7C+u2xuwzojGOYUYrMTllh6Mapl2JAvQ4Fawggtc+92RfSr1zJBU+wSUMgHQYza7
 K9IBPHMJpn9Cp+QKU7Rq634EChjYwwzTIb9ac39/nGaVGuzwA55FtgrF52a7s6tUhO7eZyujXWo
 z4BCoT6yvUdGPlMOZl9KVC/wtokcXdzMtMJLEBRPU6UJQrjjYLHMaj0zDHnqNLs9xNpMnG7okHA
 pqG3yFrUi3cLsYeCaXr03lGNKnrGdpC9fCn5NLqpK41p42E50eoKrc12dZ1W2DUOiCrZ4xc0Zbp
 OC86lAqKncb7hwl7Sw0Ig7Vbf1MF9NhAup7N5yyCvX2vv43lKn2OzB97GOM9sg78VRsayneG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=908
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050064

Update the perf.data file format description on header
section HEADER_BPF_PROG_INFO.
The information is taken from process_bpf_prog_info()
and write_bpf_prog_info() from file util/header.c.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Reviewed-by: Jan Polensky <japo@linux.ibm.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index cd95ba09f727..0437eb5d9188 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -348,6 +348,16 @@ to special needs.
 
 struct perf_bpil, which contains detailed information about
 a BPF program, including type, id, tag, jited/xlated instructions, etc.
+The format of data in HEADER_BPF_PROG_INFO is as follows:
+	u32 count
+
+	struct perf_bpil {
+		u32 info_len;	/* size of struct bpf_prog_info, when the tool is compiled */
+		u32 data_len;	/* total bytes allocated for data, round up to 8 bytes */
+		u64 arrays;	/* which arrays are included in data */
+		struct bpf_prog_info info;
+		u8  data[];
+	}[count];
 
         HEADER_BPF_BTF = 26,
 
-- 
2.48.1

