Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0F83CF022
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789121108; cv=none; b=UmkGUXMIqxe6+brMgXhZpXB91dypkz8AqYy5jZtmJCrQOh0iYGvguxhpsRTO4RWKh37BJ90xDENeYkIbTME8BgC2hHbLE8E96bVuCwRXw3CQ2oGk15pGSbxmc7ftEBbN66F9jBmhmjGImV6nvNLV6STuKoGkDM6nUTjQYFBKJhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789121108; c=relaxed/simple;
	bh=vYiD8VGLXE7VOYUz5qja2kJr1R93//8BulXYCD/ylfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OCE7JtiMViS5wYcP97iA2PAwAByL2TfasW/uEOPZzGpZhTwRbi/9dYkHfVv3p1OpCB169slNp597kXhKVedDpEUWTdiRZuYPAeQ4RwlizzJzn98nOC5OXXDzIxas3XwxboRKBl2XWyVjbEBGaE/ps03v5purtchSDJJdm7WW++s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IR0oQusc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IR0oQusc"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B81b88079996
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 10:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=SsbHVbSJjdeinSvoGu7TwK/2xG13pBNX8RVSYS1dp
	wQ=; b=IR0oQuscTAd7aoTkc1WWcq++LeQzTM6wjMIPMqce3QemeDzYk01EpAo/e
	ZJ4ywHaeDHpGvzHe2+jZHIuozBefZJ+tv72JLZYEIRxHKb+xsu1DSdgo4WNYuxVu
	VfKWy44d+gbC1Bq+ZnB+eLlbiLWFU17xgGR5sSclVPsXiHheESXZp1L72NlbkTPu
	zaRgQhmTU6ulHxY6iUTz5UJ4CS0xkxjdTfg9kDJM4moXediZbAm3Yw64j6jFzcVO
	XqhTFPDgQ33Ja0MmUlGCLGR3XeCQjgFImV42jpJVhevPRujF0KCw8bLTBd2QgG5z
	ZSOeTZh7VtHPWT4Yx0VkBWUPz5MIQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8qanj9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 10:05:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68B7o4sN1317942
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 10:05:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvtfdngm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 10:05:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68BA51oj43974916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Sep 2026 10:05:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 765592004F;
	Fri, 11 Sep 2026 10:05:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50F232004E;
	Fri, 11 Sep 2026 10:05:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Sep 2026 10:05:01 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org, sumanthk@linux.ibm.com, japo@linux.ibm.com
Cc: agordeev@linux.ibm.com, iii@linux.ibm.com, hca@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH ping2 linux-next] perf test: probe_vfs_getname add do_getname() probing fallback
Date: Fri, 11 Sep 2026 12:04:55 +0200
Message-ID: <20260911100455.2131629-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PZNd-pBydO9Sc0NFaYz_yDWcwVBuF4Pp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE0MCBTYWx0ZWRfXyBuYLnDzOPbY
 OwslMuOnu7qUUweP+AqNVsGVTGZOODRIhs7GYOKZK8PJpxqmcsYspHqU8bj4PuOnm2HAeDa7Q9q
 8LHP+K0CTloBDFxOuMDb6o2SPlBKhxY=
X-Authority-Analysis: v=2.4 cv=E/dYNqdl c=1 sm=1 tr=0 ts=6aa3d252 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=HWmUBIJd22lZSy0K-CsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE0MCBTYWx0ZWRfX04UQwoH1xM5F
 Gx7fxoy5BoXmx6ncDGhCfGGSfxRMT8Y5PRIPcXfBbbeGHcUimfXDmRPTQ3ZfV7DnFVXbwChFmyc
 +9v3ju4Ogw0Hb2knHk4EzAgPXhUCmpsPPf9YbvEHabzcYEUjwhueOv/qs88PRgMzNZKqruXPfcr
 DtD3oRvZgz5d9rsps3ZuyWjeSu28RuG1IsHhQozPrLKLIItsMHXwNACh9BaFJkUw+SHz/rxU/N6
 KQ4wltVtqpprd4nrIzUt9inHWzaPezNjzQAiNBxjJHHnTzeKhPG4ldFwQHTM9j4RM0hoBOwaoPE
 OBrU6MKLVQX/a1k68f1ol1CD7ITQcFykGLycjZYucfT+9SNpiOUWFRGE6gjyIQSX758+TA3QWE1
 OzRwSzep4WuvPH6AxhvA7s1t08VWXtEG+4Q15yaH+gs/jM6qxbweW9MNhcYze92zScEYSNsFB3q
 nFw2eZmnoBob/Ja735A==
X-Proofpoint-GUID: PZNd-pBydO9Sc0NFaYz_yDWcwVBuF4Pp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110140

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

