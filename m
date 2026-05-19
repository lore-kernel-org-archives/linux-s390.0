Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303BB480340;
	Tue, 19 May 2026 11:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188825; cv=none; b=dIL8QAU76MOEsywULIHbYqdwuY3RlujbtxxpF/Ee0lEs7Wbsu4DQhfPYnOtRIf7SVcH/8Y1Nfr83AiK/aYg+hRj2Sm6atLdwr+wga6p/0QFZros6uQlKS+6IyfWhJ2MULIURFheW1w6EJWOeFGi9gBg0UwDuod3myPcf4hICgPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188825; c=relaxed/simple;
	bh=vYiD8VGLXE7VOYUz5qja2kJr1R93//8BulXYCD/ylfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aq2iJrBbx57niriRbfqWu7Jtr0/HT2DTSXiRje32C+5Nkg1a3xn1LWnWvAa2xxpg//sg64uBMGP3sCxDmh0BVJqZeB+C6SdGw/QJ0R4Cw+Oo5JWLFo2BTNo8+w3DcM1w9WOP0DgEUsRLe/EYJEGF5ZFDEH6ietKB1p8Gputris4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Eq+78REA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Eq+78REA"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JAeAw4620482;
	Tue, 19 May 2026 11:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=SsbHVbSJjdeinSvoGu7TwK/2xG13pBNX8RVSYS1dp
	wQ=; b=Eq+78REAyvAHf1UdEmH4jOsKr7Y8iJmcwRL36ToEnUmzowBX/iLv0T6KV
	5sPOGGI/E0psmV2PHmOuC7e5hHoyaWsbRFJx9qSOJPh4zvJYFzDk31tLkBX7uJmc
	QIR5su73tUZS9B5FJllId6l/twBXkp19fuKUG6Avs0vqYiO83A0E10xjcCRZC9jU
	DiLpXRTKKJeumZScixV7CRHKI5VBMHte8jFnq17OvZhgz65GQvECb0hLsUx9S97A
	NpLiwAjR7LCPM9wZ+jNP0u1BqJYuR36s9L/2JsRBrPgSFODSXi/qgHkYkklpbFkL
	k/nCBbzpoSHMegu/LvGfGLbAHdMZQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88bvp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 11:07:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JAs9We016041;
	Tue, 19 May 2026 11:07:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhj60n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 11:07:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JB6uWp51315192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 11:06:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DE162004B;
	Tue, 19 May 2026 11:06:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF4A220043;
	Tue, 19 May 2026 11:06:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 11:06:55 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH ping2 linux-next] perf test: probe_vfs_getname add do_getname() probing fallback
Date: Tue, 19 May 2026 13:06:43 +0200
Message-ID: <20260519110643.1424411-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AEvfqtFt4-rpdQTosVdG1aH3vSpxF_Cx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEwOSBTYWx0ZWRfX3w6JapXKPXNl
 7JBZPSDblCrClzQSymbppP6Y+NoQDbUflXEoRzCSIo5QgGwrMFpDuyrLG3Cr8uFip5fnBkRMl2p
 NL16dbc7sFAzC+v/Hc1XwAHDrj1Xd9czhC/DYIe2Mc7xNKVfyKNcnOrxLFv18+/6rcuYfv2XJGQ
 5z9h7FsPuptoIZKAu47EUQy3YqOyXDOkAmSeUSLAGRwAMs0psZiS+/xKm+M16NQwuMTmX14QuJD
 5UoSyfu0kAAEQIKl7kxFysNp8kwgDqBxEUbOgErqvFrGVJTAum80q/orEN1bK56UVFi1G/+Q9AB
 OYbWVYMWrLAtecNiP48rjkRP1mxOb59+GbSM4UwVHd/3yFVW9wsyzGMiUYAIr+19OvIQn0Q3lxD
 9bXm7Pe14xlIdkLbwGjmufxLgMD9cM4AYeIH4nzA8cNOWFAwrAaMj+j1AJo9sM6O4Ibzc25ZtRs
 +2s/ansb3fiN0nWruyQ==
X-Proofpoint-GUID: AEvfqtFt4-rpdQTosVdG1aH3vSpxF_Cx
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0c4454 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=HWmUBIJd22lZSy0K-CsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605190109

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

