Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD1F1EF39E;
	Wed, 10 Dec 2025 07:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765351095; cv=none; b=kZ6fPLaeTuzwut7jBRxI3zvHgzigsM0lKG7ZL5gZKeVl2Fs84dxMN4JuPfNj8z+6x8yaUFzZxKpAv54rOL81f5B31mZDzw7rWqvgSMObKJz5/N95e2E+CAqrUy2rFk4GlAkSeZHgiey5P3xc55HUo4HKdbcgfLXxk7VPONEXk4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765351095; c=relaxed/simple;
	bh=7mbZgvZzbMi1K298uwM/RXpYz/zNeo2REWlUfA+j1JU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ao3lnfUlWvlMdX4p6Zd0AQzB4TPaPCm+YurdwwX66oIG/XtsfQAtrNwPF4p6EYLslqUVCj0i2xkryPWyh1lH4oJZQVbH6UWGy1vDLAQ666EyhJ69KHKrTjGrTQ4lsVDdM3qAxVskXi2/GWiVWnpcBDnx5nc2MzxcgV90QaGHBKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QZQMwsWo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QZQMwsWo"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BA2jbOn027211;
	Wed, 10 Dec 2025 07:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=oUcwrDXdEDroh90YnMHd2PpfOg3zgyPKDYVcDR6xS
	5E=; b=QZQMwsWoeuA8Fho6a+pHf8G1V+eZd0Sc97MqVqrNd0fEsN1chCWRsdMH4
	7qGz/iEa0shFbJopq0YTNgMO71lO09gxqZR19Y/NTg1kwbXdk+BhOCsdGcNloBBf
	Z36mSUgMv3GCDFieRSi3CydDJ5YYJcqKPJQ3E1nrRIUGw/n8MP626FpUBWeGIiUw
	jKAk6jOOojraYKBT15brgSLfvBG5f9zI1LzS+f38eQGs4KYtnWOhGtVoOXij4qH7
	q2QTyraNrhErRApf2BCnh0olgapOQ3ZLD++Pn3oK05qpgkc36y5roHmq3KTs2Vx9
	tGDyYs+Gepl1Cgy5DXk34RcnAgRWw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wvrqqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 07:18:10 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BA76Ebj029087;
	Wed, 10 Dec 2025 07:18:09 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wvrqqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 07:18:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BA68F4M002053;
	Wed, 10 Dec 2025 07:18:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw11jf63g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 07:18:08 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BA7I49r53150048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 07:18:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDD5620040;
	Wed, 10 Dec 2025 07:18:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA2B42004F;
	Wed, 10 Dec 2025 07:18:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Dec 2025 07:18:04 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] perf test: Fix test case perf evlist tests for s390x
Date: Wed, 10 Dec 2025 08:17:52 +0100
Message-ID: <20251210071752.4160369-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HmIPfMruhVbtd2jA0Tk_oIBDjfyTvqJx
X-Proofpoint-ORIG-GUID: TesyQIDUV2ESurBxaTY3A3URG9H9AYR-
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=69391eb2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=LDFJ_rGeWCfCHBBpOA4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfX0lco75CXU4r1
 lSuLjktW0i99R+EJWyImIUp77YTnpaFGRMC5tp6JwExnDRXDJ/+whNS0r0WlgEm8Oh0CEPobh8Z
 kLeJwI+xakO1Ij60LsjT8G4CQnDuS7dNXLe5yIRyYHoxNScrpJ5ZpOZz6hv+U7IUu6gliaUTSSB
 qgtO2+4GvDbuJ//ukl9TQpRK0v+dFKnGP2ET4WJFGWOUKV9Dt0nSEmd18kga6MYoNPp0S/jokkZ
 Q365CMfqP1RWnPuL0b4EovgiTXwvsnujWxvLhlj6j/Nj3vKRVYTvWKhTlDYCl/AWOd+ibf5q6cD
 perRjSfYW2/W22bRLPbcgsMvduMKDF+imLQoJYjxM/671FcnwUM+gVuEaP8hAsIcD8e3RKLyCQP
 Gotg8OR7BTWYOK7mDMgZAlk0wdPlUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000

Perf test case 78: perf evlist tests fails on s390. The failure
is causes by grouping events cycles and instructions because
sampling does only support event cycles.
Change the group to software events to fix this.

Output before:
  # ./perf test 78
  78: perf evlist tests              : FAILED!
  #

Output after:
  # ./perf test 78
  78: perf evlist tests              : Ok
  #

Fixes: db452961de939 ("perf tests evlist: Add basic evlist test")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/evlist.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/evlist.sh b/tools/perf/tests/shell/evlist.sh
index 140f099e75c1..5632be391710 100755
--- a/tools/perf/tests/shell/evlist.sh
+++ b/tools/perf/tests/shell/evlist.sh
@@ -38,13 +38,14 @@ test_evlist_simple() {
 
 test_evlist_group() {
 	echo "Group evlist test"
-	if ! perf record -e "{cycles,instructions}" -o "${perfdata}" true 2> /dev/null
+	if ! perf record -e "{cpu-clock,task-clock}" -o "${perfdata}" \
+		-- perf test -w noploop 2> /dev/null
 	then
 		echo "Group evlist [Skipped event group recording failed]"
 		return
 	fi
 
-	if ! perf evlist -i "${perfdata}" -g | grep -q "{.*cycles.*,.*instructions.*}"
+	if ! perf evlist -i "${perfdata}" -g | grep -q "{.*cpu-clock.*,.*task-clock.*}"
 	then
 		echo "Group evlist [Failed to list event group]"
 		err=1
-- 
2.52.0

