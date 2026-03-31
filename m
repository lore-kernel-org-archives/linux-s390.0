Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D695B3A5E61;
	Tue, 31 Mar 2026 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956268; cv=none; b=rKh0Uyk6JnvyS+UzvFBp7A5VGXBpZGoBSJPKwQj+nNqLA98o7/1NqbBhRoG1RDgwhHwKyYXS3hhxRj7f2aG1YasHf4Txa1xZ3XRWCdrz4tiWzU7+jRqDpD5dQpBbGmWqBR/Esl+PdkdvCOHIE66oTeEGKPjFyt7RaWj0OW/deYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956268; c=relaxed/simple;
	bh=sORKq767heoC4Geb0x/IC68eoLuahYEGdgjSPe/xV0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nxEELQfsmhDJ4XgQRfW+v1iZcPPPWT99WACkRfvgh4dQb9YSF+HL8u5DTwTy8TjwqoTpj0BmSvXEGTg57quMiXn1jjWLIgT7KsQ1FDTAXEwERhjcDi83bxR1MQZVk9XIjCbSihcnQ4ndkRwiIyxVZu0FvVpqgCLqmaBukF2CgD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CENKCw7k; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CENKCw7k"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V2sT6a3637263;
	Tue, 31 Mar 2026 11:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ttT2dirH3BBMuYtspmkTxLXjHzm++9hvUAWeQd6LE
	Vs=; b=CENKCw7kmsIVP5dQ2QvjvvBbxS8Y2mSpZqTP0TxWI0tld+BURJOGQGjfO
	EfuKl77pjGuPIBI8IeSXHK+5zf7IHj1nf4O1ZlIHq6Ey2BlaFwUFJZojBn4mTmRv
	kk6coYHYeLGmV7pp4laXLbfg5dG3ubt21mCmhroq0X8vOGJjjKU+Q9enPzJiQ+LI
	k34ZWbK/M8PVqa44pYJ/xl2NPW50wAhOhU1pgFFbqZ43IsEWOjht6ulxTNljzqVs
	1bo0LFat8BToRR3P6PMMRNt6VBu99uDkq6Y4UJT6puNl5tV4vd14Z9LK3G8z15qS
	wlp+YBKYXD7S3TvBXfPzGmAj0JZHQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgjnjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 11:24:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62VBGLPW005977;
	Tue, 31 Mar 2026 11:24:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spy0uy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 11:24:17 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62VBODxv39715270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 11:24:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EB5C2004D;
	Tue, 31 Mar 2026 11:24:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19B252004B;
	Tue, 31 Mar 2026 11:24:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 11:24:13 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] perf test: Skip perf data type profiling tests for s390
Date: Tue, 31 Mar 2026 13:24:04 +0200
Message-ID: <20260331112404.2167274-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDEwOSBTYWx0ZWRfX04ltFZonHWdP
 JyKQnIRiSBEcQ/foDBgYQTeCIPO7Y23R/B+YADME4oYz/SjfrmBdObHP2CwIJ/I3GnpGBk3+Xce
 4lwKHC4+jzCiLxLYN217NsjKz48u3KP+47C8ifaeFlEDysIG5+xojQZHX/nbZG6PzKzSQOy8tQz
 Eoq+IMWi+VXOBtQfj4EUyQ5inqW0b/J1qX4SY/bp9W1dwVD36yWiJbkZDQDeG4d4RT0RvMCuZ2M
 NOp/aO1hfcNiJrHe8IgsjURijMA89xAFsz+FqNlCCSnpVWe+WqP4Z9kXlVXGbRo8rl2GYtaVztu
 UmNtNKPBMSoNqnsLDpbrgkGazRVlqLNtSLmGqLsSIZ6UoNthN9Gq6mPpn7HXgt1vcnolwuJcMrV
 DVxfdSMUjJEbXAKrDOixrTPO7rxWT5Xt17igpEvmHhoF0HVkljKeB70haa33YJ4+69G/MRUtIsF
 I+gaXrXsb8TcmfTFYcg==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69cbaee2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=TYgx_xtYm0J54hvIjIkA:9
X-Proofpoint-GUID: PQLiZbw5gRIJd2dBu4ewAUChvOaJ2EtP
X-Proofpoint-ORIG-GUID: PQLiZbw5gRIJd2dBu4ewAUChvOaJ2EtP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310109

Test case 'perf data type profiling tests' fails on s390 with this
error:

  # ./perf mem record -- ./perf test -w code_with_type
  failed: no PMU supports the memory events
  # echo $?
  255
  #

because s390 does not support memory events at all. According to the
man page, perf annotate --code-with-type only works with memory
instructions only.  As command 'perf mem record ...' is not supported
on s390, skip this test for s390.

Output before:
 # ./perf test 'perf data type profiling tests'
 77: perf data type profiling tests                        : FAILED!

Output after:
 # ./perf test 'perf data type profiling tests'
 77: perf data type profiling tests                        : Skip

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 tools/perf/tests/shell/data_type_profiling.sh | 24 +++++++++++++++----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/data_type_profiling.sh b/tools/perf/tests/shell/data_type_profiling.sh
index fb47b7213b33..6eb7d96fb2b2 100755
--- a/tools/perf/tests/shell/data_type_profiling.sh
+++ b/tools/perf/tests/shell/data_type_profiling.sh
@@ -14,18 +14,26 @@ testprogs=("perf test -w code_with_type" "perf test -w datasym")
 err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 perfout=$(mktemp /tmp/__perf_test.perf.out.XXXXX)
+perferr=$(mktemp /tmp/__perf_test.perf.err.XXXXX)
 
 cleanup() {
-  rm -rf "${perfdata}" "${perfout}"
+  rm -rf "${perfdata}" "${perfout}" "${perferr}"
   rm -rf "${perfdata}".old
 
   trap - EXIT TERM INT
 }
 
 trap_cleanup() {
-  echo "Unexpected signal in ${FUNCNAME[1]}"
+  if cat "${perferr}" | grep -q 'failed: no PMU supports the memory events'
+  then
+    echo "${mode} annotate [Skip: perf mem record] not supported"
+    rc=2
+  else
+    echo "Unexpected signal in ${FUNCNAME[1]}"
+    rc=1
+  fi
   cleanup
-  exit 1
+  exit $rc
 }
 trap trap_cleanup EXIT TERM INT
 
@@ -50,12 +58,18 @@ test_basic_annotate() {
 
   if [ "x${mode}" == "xBasic" ]
   then
-    perf mem record -o "${perfdata}" ${testprogs[$index]} 2> /dev/null
+    perf mem record -o "${perfdata}" ${testprogs[$index]} 2> "${perferr}"
   else
-    perf mem record -o - ${testprogs[$index]} 2> /dev/null > "${perfdata}"
+    perf mem record -o - ${testprogs[$index]} 2> "${perferr}" > "${perfdata}"
   fi
   if [ "x$?" != "x0" ]
   then
+    if cat "${perferr}" | grep -q 'failed: no PMU supports the memory events'
+    then
+      echo "${mode} annotate [Skip: perf mem record] not supported"
+      err=2
+      return
+    fi
     echo "${mode} annotate [Failed: perf record]"
     err=1
     return
-- 
2.53.0

