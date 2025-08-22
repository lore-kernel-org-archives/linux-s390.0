Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009A72D7DC5;
	Fri, 22 Aug 2025 12:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755865573; cv=none; b=iXjJBYlq/m5cRkEtg67OUl3fAG60bjmRBJwsYVMxeaSLwKRWyx/IWbHd7NAZVGh4jcChYPIoUdPAY+Jsr197dljRlFpV/ibufrw48nKtPs6e/dB+ehHvVxjlvWsrblrR0HGSaNCuj+/oNUhZWKGyeWf7Tv+TJNgwl3Ko0mz/MCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755865573; c=relaxed/simple;
	bh=UY/L2tRKcOALJRVQf2k9KAYHGNaFT19Gm20vR020zPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ri9Vy0XaRzJUkrIVChAje805+1P4Bm4Z8Zsh2zUKOA6y9hT0sTwn40j9ssUHnuWVWX+8jMtRtw6AjXRY1CFfsSY8+2B0cXgCYxnLtFMEIAxcy6yYBR5PlREZudnVz45vl/3XOkWJUTA+5i8YpDkZDpi4cmQFEt2nhFUs4P75eIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RxWGqOSz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RxWGqOSz"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M7pStI012363;
	Fri, 22 Aug 2025 12:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=HJ26CL98BAEdjjPC26V3xabEO8vZWHtSFpQwDNtDX
	ak=; b=RxWGqOSz0te8m2Ixjfu8QPZNIpaQoJ9DP8fJ0JUbvkCrSfPZDTVmqXgcn
	x0WPMoaTGlOyoFzxXcsi2+VNOPbmMVp28nk51ic0E/JiVXC0V/uSCQyuV1EzQn7Z
	RVcMAj3dyb9u0EdYsS3K7CB+lX99PvXd2ulxMrz+2I3mhboINUkaCVA3C66uIEf0
	Nlm6U3HbXNefzW6xrYwn4hJ+ybhkXxudSkk7S5KOqXSxuoloAhga3pM4XO7uhZ+D
	wUufm2nsVFauFZC8rGvneuZ2d9NM1JykWQ/tlW7tIwnFsZdgxRk9Pokhz0ggF4r2
	b9F84fkK6hvj+RQe2HcFty1FZ4+Qw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vx7fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 12:25:54 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57MCMVGQ001349;
	Fri, 22 Aug 2025 12:25:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vx7fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 12:25:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57MCIWUt024740;
	Fri, 22 Aug 2025 12:25:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48my5w56ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 12:25:53 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57MCPn1P29557460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 12:25:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53A6B20043;
	Fri, 22 Aug 2025 12:25:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 272C020040;
	Fri, 22 Aug 2025 12:25:49 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Aug 2025 12:25:49 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        blakejones@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [Ping][PATCH] perf test: Checking BPF metadata collection fails on version string
Date: Fri, 22 Aug 2025 14:25:39 +0200
Message-ID: <20250822122540.4104658-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX4+kIeLuQeUpb
 AYE7fZ5YQTv9hAJyu3bCTEMDboH12QuNBZCgV5WgLb5S9Sy5hvGLVIPl8eHlyFEePLc1HpvOYjQ
 evb1cDMa23OG4IGAvk/watRqAJNRc1GCabnl5QaeuCxbL1KfRw90wJ7odrdSJRX2QTMZGju801w
 DERruEWBzs5iaWBzljbL71q9UTC7Xf0UxV+hcoF0nbHl3jVLWCivL4WhqziC54MOdWcmHP59gvm
 gcVFmJwG0nFGVkfi/yo+LqCKnTLnJR6UZX32owU4Yb31yv7iuxFw0mY8oP5+OI//ubuUz+y4NRj
 lqfearS11BCeY9zgBB8NNXATFrAbfuB9wG4F+VKBNKBRSfztIqJYY3K7xvQuGcQ+J8YC3OpmnYn
 HjRZ+ZoA61Zn71oDZ7mfR4HpBckFPA==
X-Proofpoint-ORIG-GUID: KisYOD35_syNFIe_H5JHe_L_1NJm5-wu
X-Authority-Analysis: v=2.4 cv=T9nVj/KQ c=1 sm=1 tr=0 ts=68a861d2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=UquQ6J-m-umW9Fh778UA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 9vGB0RlN6JaLlk2fVT6EpBrqly0DtsSl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222

commit edf2cadf01e8f ("perf test: add test for BPF metadata collection")

fails consistently on the version string check. The perf version
string on some of the constant integration test machines contains
characters with special meaning in grep's extended regular expression
matching algorithm. The output of perf version is:

 # perf version
 perf version 6.17.0-20250814.rc1.git20.24ea63ea3877.63.fc42.s390x+git
 #

and the '+' character has special meaning in egrep command.
Also the use of egrep is deprecated.

Change the perf version string check to fixed character matching
and get rid of egrep's warning being deprecated. Use grep -F instead.

Output before:
 # perf test -F 102
 Checking BPF metadata collection
 egrep: warning: egrep is obsolescent; using grep -E
 Basic BPF metadata test [Failed invalid output]
 102: BPF metadata collection test             : FAILED!
 #

Output after:
 # perf test -F 102
 Checking BPF metadata collection
 Basic BPF metadata test [Success]
 102: BPF metadata collection test             : Ok
 #

Fixes: edf2cadf01e8f ("perf test: add test for BPF metadata collection")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Blake Jones <blakejones@google.com>
---
 tools/perf/tests/shell/test_bpf_metadata.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_bpf_metadata.sh b/tools/perf/tests/shell/test_bpf_metadata.sh
index 69e3c2055134..be67d56e0f09 100755
--- a/tools/perf/tests/shell/test_bpf_metadata.sh
+++ b/tools/perf/tests/shell/test_bpf_metadata.sh
@@ -61,7 +61,7 @@ test_bpf_metadata() {
 		/perf_version/ {
 			if (entry) print $NF;
 		}
-	' | egrep "$VERS" > /dev/null
+	' | grep -qF "$VERS"
 	then
 		echo "Basic BPF metadata test [Failed invalid output]"
 		err=1
-- 
2.50.1

