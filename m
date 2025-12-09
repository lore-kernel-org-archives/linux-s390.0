Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD8726F2B8;
	Tue,  9 Dec 2025 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765277453; cv=none; b=ZC14mkZGvGf4e3USFNLtFA4b68JZVdwqFJfr1rK6/Kh9WxoEJNCY6SabrSxxPV7sTpgqfsN3rsfKoFb7iIbfjQ4dIsw7+8EGuBA3Wf7iHNaXtr2y3ZyhQmc9Iv3IUA29rR0q8z8CP+27MA4v2/oNASN+m6ND4MKghLOgEH6wfRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765277453; c=relaxed/simple;
	bh=aCrM7W3CAPC+RMSQJtvAyAkXY4Lv9Ztd5W/fhfzFdE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=htxHtw2QF5TJvmtK82TNCmZbdLjT2bPT9l+DKo2rYjMozsY1G2tZT0O6RYohhmukiUGuBIrFsNFNKNCDx0VxadbmP/l++DTS7/mDYmUrzUnaqPXB4I6TvpWHyZRf66wQxqpPUha34u35gt4fqgwoWendpjIhTlZWfxi7m0GiYTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ernw37wm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ernw37wm"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B91bTbx025102;
	Tue, 9 Dec 2025 10:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=MPau5gDSQFiMBBpgwuXuFOr8iUJjmIgZg9W3uk7X5
	1Q=; b=ernw37wmJShN38TK5bmJLM1JjIekW24SxL8AeIFAmp38IL9tAED9YduyD
	TPUG/DYHmD3C3UHnnpWvLwrL5Xe7VtqagwdFB5yIPYoJLtGY1QT2pE/ea4o+DPYI
	DamNpIdpSKJlZPAEZYEDk7VVilu7+SW764UqVg5iZE3HZf0oljJu1SzUzH7lUWKN
	35eoq4SDAL5P7dQ3raTWZUGJPimH+Rnf3nX04q+z09eDGlEDQKpwUcZ7eV9+BOHD
	9jbLrL/oRYVAiyVuhLmBGQI5NgTOxXVhy521ur4cICKR6Lwv8idbb0IbOTXop2QG
	CMtJVg1KqjCM6oJE4XRZlD78sAs6A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc53bss6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 10:50:39 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B9AhltK021706;
	Tue, 9 Dec 2025 10:50:39 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc53bsry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 10:50:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B985uoK012807;
	Tue, 9 Dec 2025 10:50:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aw0ajtbpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 10:50:38 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B9AoYaF47120818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Dec 2025 10:50:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29ABF2004D;
	Tue,  9 Dec 2025 10:50:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9A4E2004F;
	Tue,  9 Dec 2025 10:50:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Dec 2025 10:50:33 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Fix test case perf evlist tests for s390x
Date: Tue,  9 Dec 2025 11:50:29 +0100
Message-ID: <20251209105029.142517-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX5qDVLO0xxN/1
 fcQLW2VIdIygrEyzLmzLLjHKjWYtQ2g4H3HOIyiJdy2d3siw1ZMnaDoBUwN+Lvtcti03tCAfO09
 atAD5PqbwK/JmVAGRX8MmCaBELPy9BvZw4OBIXwR/gpytv+feAfGd5lrNj7vPeF6qkh6y+2GKV7
 504sShwWlO0qJ2t9/kyxXg+7byWdOFUR9Wf5mhv7adNdh7I6t4r7G9gfW9uhPselcr7C2oKrcMj
 0DUcSOvVg+BLd3a4iRO3BNiXOQyaMBfnzSgF1OYO5540zjiUfaMGXmaSGmXcDyb1zbHVg2ncVae
 3qcLsFGMTCb7k3ooSqV8EMr4ZTifJfyOhAplG7X6Fq7TS5MefzSYK2nVgcLsmy+BCkFdlCVGlfu
 pO7BNF2xe+wOe7YNWjcedHy+y+xO+A==
X-Authority-Analysis: v=2.4 cv=S/DUAYsP c=1 sm=1 tr=0 ts=6937feff cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=GOdL-N95vH2p3EwyxFsA:9
X-Proofpoint-ORIG-GUID: z12NeC_F6pmhYRex77wjbLnfNkWsjx8C
X-Proofpoint-GUID: FHXIwJL86uDMQ8Yq1-8HLGl44y92M6UK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020

Perf test case 78: perf evlist tests fails on s390. The failure
is causes by grouping events cycles and instructions because
sampling does only support event cycles.
Change the group to -e '{cycles,cycles}' to fix this.

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
 tools/perf/tests/shell/evlist.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/evlist.sh b/tools/perf/tests/shell/evlist.sh
index 140f099e75c1..80f808b3059d 100755
--- a/tools/perf/tests/shell/evlist.sh
+++ b/tools/perf/tests/shell/evlist.sh
@@ -38,13 +38,13 @@ test_evlist_simple() {
 
 test_evlist_group() {
 	echo "Group evlist test"
-	if ! perf record -e "{cycles,instructions}" -o "${perfdata}" true 2> /dev/null
+	if ! perf record -e "{cycles,cycles}" -o "${perfdata}" true 2> /dev/null
 	then
 		echo "Group evlist [Skipped event group recording failed]"
 		return
 	fi
 
-	if ! perf evlist -i "${perfdata}" -g | grep -q "{.*cycles.*,.*instructions.*}"
+	if ! perf evlist -i "${perfdata}" -g | grep -q "{.*cycles.*,.*cycles.*}"
 	then
 		echo "Group evlist [Failed to list event group]"
 		err=1
-- 
2.52.0

