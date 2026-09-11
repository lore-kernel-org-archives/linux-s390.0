Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CBD2E92BA
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119710; cv=none; b=cRDLaBAhfC0S4oVV9wYM3HMf8mmKOdwhJePBKsLMezMzP7rvVvMMyKUOU2tMN7XYUpuTDBr28iXusK8acDNstdWfSxryxAJl1UdSF0hK4FRt7Vj10IMdZHAhDMMZAONeJaIO+1RWVz3nkUrLyVrjxkjT3iwCUMyV5OQEAheKG3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119710; c=relaxed/simple;
	bh=g4rxMaFto/Yqd1ICo2H1ySwJd3KrvXZaqvRdKoYoiD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rPHvNVUOvI75et/Wcnanrfh3ubfrocOkqG99+O6FMrxVlQPx0a5nigC+WeP7jJG+3nCBBdd4szxZL6bjsZg3sKjfRh4Xvp5+aGupFXMPE1sH+iGdd/q7ObJJ/iOt1B5nwpbpNdFM1Wq1v7X/Thax0lsF4L8fxP+Hpo1PvDAmWpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YZ/4CKdy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YZ/4CKdy"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B81fnm3536939
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 09:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=bhDxHG1jGgSplN3OCZXoPzJkO+OqCkW4mNVlcee+4
	+k=; b=YZ/4CKdyluEw9iEkugQwgx0PXR8KbWeel3AAkUi/vtGT1S/I2I8WTBfxO
	F3ujI0r/Lb00DtIS2A4I6+iylfB9VpFEEBN13Z5kBgS/uiFBuVA76hsR3JxBN9IP
	mx/+JkEmQD8IrrGI2t475DzIbAzFasfD4b8WGhmOXuuiERard6G91QwxPrnpUVvh
	10/d525HYydhs+5d0qQLtsqCqIqxPevyO88oKZmfA2SegJMsLdYuBF57STrRAEEi
	m2eRGu7CaawPMYeLyy0NEUAN0o4snGgQOccSHn1CkImyZunW0+OPfN1BWMblfqxc
	QXapzAilz3W4zl1kWvycUNDov4sqg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8naku1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 09:41:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68B7o33V1318582
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 09:41:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkvq2wjf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 09:41:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68B9fgc752232490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Sep 2026 09:41:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0A0F2004B;
	Fri, 11 Sep 2026 09:41:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2DB520043;
	Fri, 11 Sep 2026 09:41:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Sep 2026 09:41:42 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org, sumanthk@linux.ibm.com, japo@linux.ibm.com
Cc: agordeev@linux.ibm.com, iii@linux.ibm.com, hca@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf header: Fix HEADER_CPU_DOMAIN_INFO feature
Date: Fri, 11 Sep 2026 11:41:29 +0200
Message-ID: <20260911094129.2032815-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NMVAaE6g c=1 sm=1 tr=0 ts=6aa3ccdb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=zd2uoN0lAAAA:8
 a=DEORY9iXo61j9Pv1aocA:9
X-Proofpoint-GUID: ZurtrX9TGVLoUXiKY6B2fvREIo-NT3e1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDEzMiBTYWx0ZWRfX9sFkKSmeHKn9
 IAd0X7rG/zJIKcXzEAPBag5BTNZfMRhMT1woCd/UZp3e/FBWvj1dpuDGM8VzC1NIUMakurBtmmv
 NJGraXWkoeKa+5c3ohZ/9gsw8mv0/8fNwDuJCP4PBgCyKKEukaN6ZMN+XXySPZjXs3HZmeQoOhx
 /Hsa5K7pe7NhodkTtq/0a0zFdZAGAnxeoYypguRMEDrI0qIf7n70qipJIkvvBLCUq95uR94BPX5
 XgzpZ43a5SxwtT5jfe+UwzIIQgjtyKYrZtmBLCeXZZPSmI7oOLh2DYUb1YpMutP/OR+K0BNiznU
 pmgaI4RBIAt9cGGf9ciUXCOIeXp8UL1NaKAns5tsXZDV2Yz7bzNgEg9ugqwVC2H+E/QY99MWqOc
 ps+vrfknRWIVm73TnnGlqOemSR8nw0YtLX+yxzjS+fyujtb+Fjxc+0q2LDFBYSbrhRnpDyFZfHh
 b7sVDet8ogvQBgHH3VA==
X-Proofpoint-ORIG-GUID: ZurtrX9TGVLoUXiKY6B2fvREIo-NT3e1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDEzMiBTYWx0ZWRfX1gXGOl3gYSKi
 s5uyy+kYjFoIhwGBDltDzms13hfXAwFr8GXAjrYXLse1BUBPAlIQfQrLzf9i6MjxVsRTEnHtSbh
 aQyWX9QPefAdhRPTaHkpwEfTLIdHwfM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110132

commit d40c68a49f69 ("perf header: Support CPU DOMAIN relation info")
introduced the HEADER_CPU_DOMAIN_INFO feature and the necessary data
into the perf.data file.

The documentation differs from the data actually written by
write_cpu_domain_info(). The first two values written to the header
section are schedstat_version and max_sched_domains. They are missing
in the documentation. Add them to the documentation.

Also structure cpu_domain_info actually contains an array of
struct domain_info. It is very important for the reader to know
how many array elements have been written to that file section,
especially when the member domain_info::dname is optional and
only present when schedstat_version >= 17.
Add the number of CPUs which have been saved into that file section
so the reader knows in advance how many array elements to read.
This is also in sync with other perf.data file sections which always
have the number of elements before the array data.

Fixes: d40c68a49f69 ("perf header: Support CPU DOMAIN relation info")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
 # Cc: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 11 +++++++++--
 tools/perf/util/header.c                           | 11 ++++++++++-
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index b90cba9168f8..e37f7484487b 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -453,7 +453,7 @@ List of cpu-domain relation info. The format of the data is as below.
 
 struct domain_info {
 	int domain;
-	char dname[];
+	char dname[];	if schedstat_version >= 17
 	char cpumask[];
 	char cpulist[];
 };
@@ -461,7 +461,14 @@ struct domain_info {
 struct cpu_domain_info {
 	int cpu;
 	int nr_domains;
-	struct domain_info domains[];
++	int schedstat_version;
++	int max_sched_domains;
++	int nr_cpus;
++	struct {
++	       int cpu;
++	       int nr_domains;
++	       struct domain_info domains[nr_domains];
++	} [nr_cpus]
 };
 
 	HEADER_E_MACHINE = 33,
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 7db7da090a1e..770fd21eb1a5 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1836,7 +1836,7 @@ struct cpu_domain_map **build_cpu_domain_map(u32 *schedstat_version, u32 *max_sc
 static int write_cpu_domain_info(struct feat_fd *ff,
 				 struct evlist *evlist __maybe_unused)
 {
-	u32 max_sched_domains = 0, schedstat_version = 0;
+	u32 max_sched_domains = 0, schedstat_version = 0, nr_cpus = 0;
 	struct cpu_domain_map **cd_map;
 	u32 i, j, nr, ret;
 
@@ -1855,6 +1855,15 @@ static int write_cpu_domain_info(struct feat_fd *ff,
 	if (ret < 0)
 		goto out;
 
+	for (i = 0; i < nr; i++) {
+		if (!cd_map[i])
+			continue;
+		++nr_cpus;
+	}
+	ret = do_write(ff, &nr_cpus, sizeof(u32));
+	if (ret < 0)
+		goto out;
+
 	for (i = 0; i < nr; i++) {
 		if (!cd_map[i])
 			continue;
-- 
2.55.0

