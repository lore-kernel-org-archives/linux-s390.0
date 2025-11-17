Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761CE25C809;
	Mon, 17 Nov 2025 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763383462; cv=none; b=QwfJGEH2hkq0sYIuyC9GjICwn4YsQseIieQQmj9o2C0b4hdO0UYOFN2wqqWZXTvGy3Eb2reMlBQqVDFMFcl2Yl70/B6z9orTmPw9JPfyEd31fvdYp8DQuHydhuOsq1SYXUuOL+ywE3Hp35L6+CTE7jUM8viGvfDG+ysRrh9w8N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763383462; c=relaxed/simple;
	bh=8PDAnJk6WH4f/3qIHfmmkBDbls1uefXstReD35OmbZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PRVYLoTWcW/z2Cch4kt/BIkkpYd9YVeZ5eor+wUf3FvTyuvPbJZv0qFSFWRnoRHW8YJiT9CVcdeHdHF8gZ4u8nz5349RQb34/PUa59SCr2EnCFXEQHS5Rwxj+mlRgQxhJJjMyLzfIdQ5Eagv95VQI/GVXMdClXMAjO6wOQEdn8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DQDplR9K; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DQDplR9K"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AGLkrta028553;
	Mon, 17 Nov 2025 12:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=4Ra3UxIEkfX4GgtTKQoU0u4MuRSb
	YUN5xsmp1GXqy2w=; b=DQDplR9KgRmEw42a7pmo5F63+KFz3a0maRNIYSWk/pJF
	dgK5Pv/VC5BzDCRF03CvHpWfiHhLhQD/Jby9tYY423HLo6lSN19GH7p1FLFmxW+e
	gI8HaeI6bKkbHpz0KbQgC1pNTxSZOS0iGrQCFKJkmCTVMxD1UcObrZH8I0IfncDl
	CbRtbFZGYBa/j2Gs744LA9jx72m8KoPgfocMJbSJo73+ei/ZjTLMtx84aUHgfjm9
	M87ox4S+TyaocDqjtdjDEHr4jgYlyq6oeuNjb1hkaLhFDhoNuJ5fADulZaryHQii
	SPO8aewcWA5e1X0610NU0JnOZZNdJTZ5Uh0csxwuZw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmsdyfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 12:44:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHCQisr017319;
	Mon, 17 Nov 2025 12:44:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af6j1dgsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 12:44:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AHCiAav50266486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 12:44:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91A192004E;
	Mon, 17 Nov 2025 12:44:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F34620040;
	Mon, 17 Nov 2025 12:44:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Nov 2025 12:44:10 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH Linux-next] perf test: Fix test case perf trace BTF general tests
Date: Mon, 17 Nov 2025 13:43:59 +0100
Message-ID: <20251117124359.75604-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WRcxZaszag8ZbLruvg_Zw7TIoVSPIIYa
X-Authority-Analysis: v=2.4 cv=Rv3I7SmK c=1 sm=1 tr=0 ts=691b18a1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=sPw9hx6KFaplCOXBBoQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: WRcxZaszag8ZbLruvg_Zw7TIoVSPIIYa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX7ShlJNmyk7GY
 0WQA69BHDbkaRq2lPV965fIwcqoy5J1P8Gc/w2oWqh5sBesvZSuyO90m1jij2R10mK7ygLHGQ2s
 RRsocjGOhw6gOlAOD2by0yj/E4TIZ6CxWy2iXewDDe9AyHTKfXQDXsBFcl7q2O9qGL4khqTzblo
 oi/BcBErFrj/l/Yev12t9fSWtlPRE7wN5qUf9fbK2dNyUhTtp6wr/k80weH3lBNtsiICF7NSNpf
 nMCvxk+lAwDcCRlCEPorLbGYzwrDNrxm3PNUP7hks2mv90sd9Z3HPjKhsSN5xoZd83SHlVD5Z9P
 lbB+IXR+JKIRaX2iK4i6/smxtfFb/j2+G669xPqV1yhbCpaI1n8xuXxefVJzTP27lBJ0sIk9HLq
 Z8jhmEvh4R2JY5VEGmxBl4wVptkI0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

The following test case fails on linux-next repo:

 ❯ uname -a
 Linux s83lp47.lnxne.boe 6.18.0-20251116.rc5.git0.0f2995693867.63.\
      fc42.s390x+next #1 SMP Sun Nov 16 20:05:28 CET 2025 s390x GNU/Linux

 # perf test -Fv 109
 --- start ---
 Checking if vmlinux BTF exists
 Testing perf trace's string augmentation
 Testing perf trace's buffer augmentation
 Buffer augmentation test failed, output:
 buffer content
 echo/23281 write(1, buffer conten, 15, "") = 15
 ---- end ----
 109: perf trace BTF general tests            : FAILED!
 #

The root case is a changed output format on linux-next.
There is an addional "" string as forth parameter in the write()
line. Here is the detailed output on linux-repo.
Please note that this depends on the kernel and not on the perf tool.

Output on linux next kernel:
 # uname -a
 Linux f43 6.18.0-rc5-next-20251114tmr-n #1 SMP PREEMPT_DYNAMIC ...
 # perf config trace.show_arg_names=false trace.show_duration=false \
	trace.show_timestamp=false trace.args_alignment=0
 # ./perf trace --sort-events -e write --max-events=1 \
	-- echo 'buffer content' 1>/dev/null
 echo/7676 write(1, buffer content\10, 15, "") = 15
 #

Output on linux kernel:
 # uname -a
 Linux b3560002.lnxne.boe 6.18.0-rc5m-perf #6 ....
 # perf config trace.show_arg_names=false trace.show_duration=false \
	trace.show_timestamp=false trace.args_alignment=0
 # ./perf trace --sort-events -e write --max-events=1 \
	-- echo 'buffer content' 1>/dev/null
 echo/36932 write(1, buffer content\10, 15) = 15
 #

Add the optional forth parameter in the extented regular expression to
accept both output formats.

Output after:
 # ./perf test -Fv 'perf trace BTF general tests'
 --- start ---
 Checking if vmlinux BTF exists
 Testing perf trace's string augmentation
 Testing perf trace's buffer augmentation
 Testing perf trace's struct augmentation
 ---- end ----
 115: perf trace BTF general tests            : Ok
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/trace_btf_general.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
index ef2da806be6b..9cd6180062d8 100755
--- a/tools/perf/tests/shell/trace_btf_general.sh
+++ b/tools/perf/tests/shell/trace_btf_general.sh
@@ -39,7 +39,7 @@ trace_test_buffer() {
   echo "Testing perf trace's buffer augmentation"
   # echo will insert a newline (\10) at the end of the buffer
   output="$(perf trace --sort-events -e write --max-events=1 -- echo "${buffer}" 2>&1)"
-  if ! echo "$output" | grep -q -E "^echo/[0-9]+ write\([0-9]+, ${buffer}.*, [0-9]+\) += +[0-9]+$"
+  if ! echo "$output" | grep -qE "^echo/[0-9]+ write\([0-9]+, ${buffer}\\\\10, [0-9]+(, ..)?\) += +[0-9]+$"
   then
     printf "Buffer augmentation test failed, output:\n$output\n"
     err=1
-- 
2.51.1

