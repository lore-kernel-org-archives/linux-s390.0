Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF683B3BE1;
	Thu, 16 Apr 2026 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776344137; cv=none; b=PozfoyzfUkjzjYk9DEWF2SayFCHixDHf/Z1+29yNZqqF5c9QoSy6oSTw+HsTF9Ain7wBF+uj79b10nWX3VjgxQd83JdhXT/HP50uZLg/KgeySlPOuoRV4du74BjBCVzWiPynkWmsPgB0ibSVZDpqTmz193qlBzOftoHcHoe2Gvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776344137; c=relaxed/simple;
	bh=vYiD8VGLXE7VOYUz5qja2kJr1R93//8BulXYCD/ylfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I8jllMr/Sa9fnu0NJpv/d8r3Z5QXe6Nuhzv/+Q4g98NvQ480h8PhB+OUuW+7Xh2cevO2lSricKuExu5A5dHeztEqRYtAItdcn1wH+1z8bigxMKkyIOZmQ9X31syqH7BEz1nTnNyoqCBjJbhe8dT+BMt/Hl4W9/RK9rTokHgl1v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=opaYVXmc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="opaYVXmc"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G5gjst1602772;
	Thu, 16 Apr 2026 12:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=SsbHVbSJjdeinSvoGu7TwK/2xG13pBNX8RVSYS1dp
	wQ=; b=opaYVXmcGg1bHBrQ0frboxHuqKx1AexQW9I+rXlZ99UhFNWEQOrVgw9rj
	r+Dy0d7SpWe5Njo7A6NNVXWJumwJBAf3YQ9KSwrazV8qPWGMP/tcyYNL5kdjw/Pe
	5ZV/Iq3yzNIdx4oR44PGFTuRVpABO0c0T2C7ZHju8nFkxhOhDCqgfFKlX3TsCnMd
	0yVqNc6XRHZ2/I0M30P5innzQRsbJ1Hila8vPNP/d2/Zh4zjli3XodUBMztcPZBd
	yuwr/XFQju6RNuXtU+8LV31DP0lw9Uq+sGPqvPDs1CT56DQKcBs3qDhoH6oKPiLe
	b5dqZiaqsixE5sqYlHyrCM/6PHfxw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89nng6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 12:55:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63GC5kBk003557;
	Thu, 16 Apr 2026 12:55:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mnjvs2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 12:55:28 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63GCtOm228770756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 12:55:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB3ED20043;
	Thu, 16 Apr 2026 12:55:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8536920040;
	Thu, 16 Apr 2026 12:55:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Apr 2026 12:55:24 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: probe_vfs_getname add do_getname() probing fallback
Date: Thu, 16 Apr 2026 14:55:15 +0200
Message-ID: <20260416125515.3481495-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gyvE8of4aQDg-GWbH3GnPWzTCnmEu_qf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDEyMiBTYWx0ZWRfX/mOgm/HaM4mX
 6CKENiJgHswpE1+nwr2917e7V8yS8UK1TFJYUP3GNHKcC9zreACb1OZKDT+kQtemTh6DLiYifD4
 poHWx1wwClOFvoLEiSZ0np12JBXssBs5cVuoBm1jIG8FcNR0PtbvjIkgSJU041BpTrvXKLQ3mrS
 xFeTI/ubNxWdW6VmjB+3JUfZ6vbyWywpzyAdtB7NNLJZ3yUXuGaBh27A22ER748SIiViiv5M5Cz
 458XoIzSSmDQIGBJ2R5Yn8x5GDkj6FBOkRzZsmJVCHmnsuzdoTJFjheIHaHBSwxVIatdYTZveHm
 TUrIH1e/9Avki+XtybdZ4h3558frjbxBIqmhx4UxWl3Y4T/4WaGE0blXS/FMHX0mHcOk5X5mm6Q
 jXDF7EnXz51cvmcpNlBVb75rzTYS5551mr9uPpaqCla0yGv0wZNDg63XM0Tuiknbu/IVgyt91mu
 VTVm1Jiqblabk4Y05Cw==
X-Proofpoint-ORIG-GUID: gyvE8of4aQDg-GWbH3GnPWzTCnmEu_qf
X-Authority-Analysis: v=2.4 cv=FY4HAp+6 c=1 sm=1 tr=0 ts=69e0dc41 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=HWmUBIJd22lZSy0K-CsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160122

The following tests are skipped for some time now on platforms
s390 and x86_64:

 # perf test vfs_getname
 138: Add vfs_getname probe to get syscall args filenames    : Skip
 140: Use vfs_getname probe to get syscall args filenames    : Skip
 154: Check open filename arg using perf trace + vfs_getname : Skip
 #

This is caused by a change in kernel code of function
getname_flags(), see
  commit 9fa3ec84587c ("allow incomplete imports of filenames")
This commit changed the function getname_flags() implementation.

Now the perf probe 'vfs_getname parameter=xxx' does not match any
more. Extend the test logic to fall back to probing do_getname().
This reflects the updated kernel code.

Output after:
 # perf test vfs_getname
 138: Add vfs_getname probe to get syscall args filenames    : Ok
 140: Use vfs_getname probe to get syscall args filenames    : Ok
 154: Check open filename arg using perf trace + vfs_getname : Ok
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 tools/perf/tests/shell/lib/probe_vfs_getname.sh | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 88cd0e26d5f6..9156a79212b9 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -12,6 +12,8 @@ cleanup_probe_vfs_getname() {
 
 add_probe_vfs_getname() {
 	add_probe_verbose=$1
+	do_getname=0
+
 	if [ $had_vfs_getname -eq 1 ] ; then
 		result_initname_re="[[:space:]]+([[:digit:]]+)[[:space:]]+initname.*"
 		line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_initname_re" | sed -r "s/$result_initname_re/\1/")
@@ -28,12 +30,24 @@ add_probe_vfs_getname() {
 			line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re" | sed -r "s/$result_aname_re/\1/")
 		fi
 
+		if [ -z "$line" ] ; then
+			do_getname=1
+			result_iname_re="[[:space:]]+([[:digit:]]+)[[:space:]]+initname\(result\);"
+			line=$(perf probe -L do_getname 2>&1 | grep -E "$result_iname_re" | sed -r "s/$result_iname_re/\1/")
+		fi
+
 		if [ -z "$line" ] ; then
 			echo "Could not find probeable line"
 			return 2
 		fi
 
-		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
+		if [ "$do_getname" -eq 1 ]
+		then
+			param="vfs_getname=do_getname:${line} pathname=result->iname:string"
+			perf probe -q "$param" || perf probe $add_probe_verbose "$param" || return 1
+			return 0
+		fi
+		perf probe -q "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
 		perf probe $add_probe_verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring" || return 1
 	fi
 }
-- 
2.53.0

