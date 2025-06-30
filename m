Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262EDFC1D;
	Mon, 30 Jun 2025 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751274995; cv=none; b=UB0Y4iTKN0nFI0+lnqJHTXD+8ML2ED0EpBFf1S265fbopwc9JADzR5hFM7v1SXJ/JtSK+aLSKUqk4sSKdzGHkyrD7UTcEmOv2TN9YLTAxL77w4OTvBGivaZm55DS+MVecTeCdvMds32Cui2w3iwhgglKW9SYh+F2UM7vG8k4ifE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751274995; c=relaxed/simple;
	bh=Iwck2mG1lJ5lx8e17hXJ+xo4ZCdQXb8iwMS3mtR5Btc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aKvzavNQGxtF1wA6jOxdLWs6goE6jr92mvjKZsgprTdbXpRbBbJvjyfYPcD13Y6iu1U7+QNRDGmo6U8JOpF3mql8dL8+VUdaY8kdtbJtHAeX36+rIDLsPkux33FNODJHSh9SWK017jgeT6w2PZnil77lUOiY3gQVI6jPVXGJm4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kdzla65V; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kdzla65V"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U6IQud014585;
	Mon, 30 Jun 2025 09:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=rh2Tduwrlnki1FQ5vsOskOQbINxd9zCyPRvM5+9Ga
	PE=; b=kdzla65V3Ror2Ys2/xxk9JDa81wgLJZ5N8ZS2i1mCTpNC4glAL3OnUOkW
	EU3pn63r8qwu760lzOqCgz6OyM1eRD5rO9tCKWPhem1MJj4sbvhDz4u2ptL/13/d
	HGw58qh+2ZgKlQ8WajtbxCj+Cs/+weZp44EvogwCRCNDFb4n88uqY1+lfR072XQW
	RppiZv6/RcHrlRXVMI51dmfKCK5XnFW03SvPWVcjVRVJJwbuHdTt2NN5XKVVigvT
	Z0DgtODpgsSmX5KwzEnKaO+Em5aPi9UnnRVQs1Lg0ZFBOPPNk/OnK7JDwQiZwHsk
	vZEz+FjYxHx2sT4IupApyruD2MwbA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j830gak2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 09:16:31 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55U9BS0Q016831;
	Mon, 30 Jun 2025 09:16:31 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j830gajn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 09:16:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55U8mfie021117;
	Mon, 30 Jun 2025 09:16:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jtqu5bdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 09:16:25 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55U9GL7R20447600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 09:16:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66BD62004B;
	Mon, 30 Jun 2025 09:16:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EF9C20043;
	Mon, 30 Jun 2025 09:16:21 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Jun 2025 09:16:21 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: perf header test fails on s390
Date: Mon, 30 Jun 2025 11:16:13 +0200
Message-ID: <20250630091613.3061664-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8qTbJrlhJ3epZwh0_kVLqi8Mdh4JvVIH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA3NiBTYWx0ZWRfX1Xe1QzeuC8Rk vU6GsvC8m9uymHpX3GIej5UhAmcWRDSAh54+TCN8Tx3472uvPXsyERwB8SsS31l4IA9J5k7cUcR rvYjgoGBn9uWbgdU0g1n6G0mGfaJydV8/cKVqafhZ1OwBHmvI6N6FTRZ0/Uud73yLBbF3ZqRqoM
 GF5wma/WRSNthzkyk+JFfchdr3FWCZkdXtgrSS9aAfdKIhPL9IhX42bFBoFPLxVB8rE6itg7DVU spVcgeX7b+mQInVny97QmBBTs0jnlufvt0lGlCG1HqBbI3J9rsLwR53xl2JM4qWwJtphytf1GT9 FbdnWVsVasbV0Qw/ESIlEulAUG+5lrrVOWixIJ5naD6MFZlm4RLG76kk8UoMJhIv5sDqcSr6Lq2
 n3XHuZMXmcbBlWoHrUBUbLUx/641f/Bt9EiA2fXCTiLUkdScqTw/gm3GfT7HnFJnxSxSsUo3
X-Authority-Analysis: v=2.4 cv=MOlgmNZl c=1 sm=1 tr=0 ts=686255ef cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=5pymjkY0oZ0wbNViOC4A:9
X-Proofpoint-GUID: a_82e_qKMD0E4uUXRU0oWzRasEgyyaR4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300076

commit 2d584688643fa ("perf test: Add header shell test")
introduced a new test case for perf header. It fails on s390
because call graph option -g is not supported on s390.
Also the option --call-graph dwarf is only supported for
the event cpu-clock.

Remove this option and the test succeeds.

Output after:
 # ./perf test 76
 76: perf header tests                           : Ok

Fixes: 2d584688643fa ("perf test: Add header shell test")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/header.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/header.sh b/tools/perf/tests/shell/header.sh
index 813831cff0bd..412263de6ed7 100755
--- a/tools/perf/tests/shell/header.sh
+++ b/tools/perf/tests/shell/header.sh
@@ -51,7 +51,7 @@ check_header_output() {
 test_file() {
   echo "Test perf header file"
 
-  perf record -o "${perfdata}" -g -- perf test -w noploop
+  perf record -o "${perfdata}" -- perf test -w noploop
   perf report --header-only -I -i "${perfdata}" > "${script_output}"
   check_header_output
 
@@ -61,7 +61,7 @@ test_file() {
 test_pipe() {
   echo "Test perf header pipe"
 
-  perf record -o - -g -- perf test -w noploop | perf report --header-only -I -i - > "${script_output}"
+  perf record -o - -- perf test -w noploop | perf report --header-only -I -i - > "${script_output}"
   check_header_output
 
   echo "Test perf header pipe [Done]"
-- 
2.50.0

