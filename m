Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF3D2571C9;
	Fri, 15 Aug 2025 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755261553; cv=none; b=DAIxO6QxgQKi6fDxSBuQNH+Gqn7l5t/034kNkN0W0l+Rmdsh6t7Ts4PsKd4CZaduoCULxLlmO+178XUdFgwrUtP3TwQUe3a21DB50ZrvKQt2BzAyKKpB/ZV8JHYfaZvajxMxjWdvUwh1riZ5vh2VB69Fk7EBwZlU0rXMDXSeZbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755261553; c=relaxed/simple;
	bh=UY/L2tRKcOALJRVQf2k9KAYHGNaFT19Gm20vR020zPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AOxEipGyfTRoEjV6+rvgql50q9iS7JVxODc1aJsuoKUcPehrd83yORVS3R72LKcwRCzx/yeh/Imltve45pPC6XJeYvzRaMbYg2JDKamMNvMdFdkIUnSTOBefpDhAotfjZ+uw7j88qhBbHMKvCLv7LlFjOGBc3TOwees3Lj1DYB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kZnsp9eN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kZnsp9eN"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57F2Lfmo008486;
	Fri, 15 Aug 2025 12:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=HJ26CL98BAEdjjPC26V3xabEO8vZWHtSFpQwDNtDX
	ak=; b=kZnsp9eNR7fW/fSp5UaUlHst9E11INJ5PE+ylB5LwbwvvZOGsC2e8TAmw
	AbQQdbouyBnPnwIQwuIiaOu9FepFjWwK5i/5sJ1peSfpmo+FVonmJzRA+nw7F+HP
	nLtBkeFgpxYELw5B8X+13yigq4RrvzsHbork+cHbNH6BwmezJAOqFMqmY/x70thd
	iy/mOOkdZyEDWbnDVl1yeEfT665V3z8TY5bgq6DJeQCd58BNooAqs+igyltqdIT4
	f/U9ac5LmVUXQSzHVE5ZEYC6/0ETwF4AorqsyPGyuk52in3OeoDxUoKhf+0Qi5Or
	LDkboselH3URuyCI9DaRWbA4OnXAw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48ehaakgx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 12:39:08 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57FCa3AQ019986;
	Fri, 15 Aug 2025 12:39:07 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48ehaakgx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 12:39:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57F7rKmh028585;
	Fri, 15 Aug 2025 12:39:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ej5ngs4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 12:39:07 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57FCd3wD49611252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 12:39:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0447720043;
	Fri, 15 Aug 2025 12:39:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2DDF20040;
	Fri, 15 Aug 2025 12:39:02 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Aug 2025 12:39:02 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        blakejones@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Checking BPF metadata collection fails on version string
Date: Fri, 15 Aug 2025 14:38:49 +0200
Message-ID: <20250815123849.935274-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KPRaDEFo c=1 sm=1 tr=0 ts=689f2a6c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=UquQ6J-m-umW9Fh778UA:9
X-Proofpoint-ORIG-GUID: SCST5W-sIl6xC2R9346ZXrtI4WkpVVAt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX6BLwN84Zxhex
 hP/Vxn9BfyJhdwU3TO7VR9I2aDYoS7ZrhQqcQFeM0zf9GWssaz6/s5JAwo1A9ztjbe4FZiD+iYy
 2Xn66mSyvqWqfo4rDf4S3o0Ckt+n02KZiaZXTA4gJYq8XHemKyUeoO10Htak83A2suEU8Z5Cdno
 i/un78sDsZauW0Ig4fbBUnvG0aOiYk0q+HEKu+cAq8BaJzO/oQu1as7yKNL2aZF7ZlDqcemsMVS
 wgI1c2F4HTEOH4qxMxnu+rNUuuJUJOMK/+EYM9AOzR+FMBrxBamsSH1kSVH4Aa5URGWLvr5jCNq
 DYoJlclMdvgsSipfsTGL9buEKl0NOPqUgIpjVSDvT+OjAbBzwcMJMsc96kkygnKNY4cgPXwPJZ8
 vQ63wqT4
X-Proofpoint-GUID: CO206c7FNn2KiZsjmKqB0bqsvHKdsvEe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120224

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

