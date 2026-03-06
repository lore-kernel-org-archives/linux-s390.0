Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F45372EC0;
	Fri,  6 Mar 2026 07:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772781092; cv=none; b=I+eM60OhdX0TjgRcBqiGwyeZ6JzthdB4/iHpeCrZltt93Qo/FyMJwGQpq2cDje8tGDwvdC0kP5gL7WK9R325XPRRXLudOZrCX13Wr7H1LrNKqFatWUyY0/dhJJjaXYoiPnmfkxhdcpwaf3ZMEmqZjL0S38kAR+IiVgQPpOpA74A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772781092; c=relaxed/simple;
	bh=wiFj7j4pR7qxDgv4rYvKxR8ko95xFtTR8gBkVau9yBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ROfL9A7zhvPCaKZTzKHXPA+GGRJESl1Ifc8eP7fp/RGZBOKpQe3zA8YbhMyGor0rbnALm68gMPJqBI1kl+BAWLtRL5kl0VTqQn9Xw4efqk2ot9lflrnYgJestqrJWR6iX/ySvw2YQepMjUBdbCsQm+jjKy5qkIgjAoqH4q3D3Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s2LAdkNS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s2LAdkNS"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6264FHnT967095;
	Fri, 6 Mar 2026 07:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=8VwO2OlSKQa5nglmkJovUp4HyJ5l
	7K3eR1lawNlfsaQ=; b=s2LAdkNSov3cxRbiRPXXyyFCKNIytZ/0WeI2AWIZLIr6
	9XHKqpqhv47JcjpKrVoU+8jLq6XFPlwlkh93C+VAL6q0Le80P2W9uYIdGsqbrr4f
	6Q9Mgj8NpOqF6R5CukMTonpMwSscvmVXFOw8o7aXlVzhmH/q4bZvUn4B0WM28KCi
	HV154DIoXbi5dDLwVA7M+tp2AfdsvWv/RbYJGOk0F0rXBjBBWlff9Q/1zTYQWK/u
	mJZ9/QyCi6GBikY0wY7U/+brf9HOaOrRtLv053wnU53AD2osAvu8a6iH57AuniNk
	nqAdCCdQEzTI+x6fWDolgo7lFlyl3e0Nk+IcfdUupA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskc6rdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 07:11:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6262rqUH011199;
	Fri, 6 Mar 2026 07:11:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cqau2ucs0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 07:11:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6267BLe362325074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Mar 2026 07:11:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46FF120084;
	Fri,  6 Mar 2026 07:11:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 203ED20083;
	Fri,  6 Mar 2026 07:11:21 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Mar 2026 07:11:21 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Fix test case 120 and 121 for s390
Date: Fri,  6 Mar 2026 08:10:02 +0100
Message-ID: <20260306071002.2526085-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: e6VTDDaK3FzjxVxSm6FlUeNaOjPId5zA
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69aa7e1e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=ruTnlWdWP5eddmxBhNYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA2NyBTYWx0ZWRfX5iA/kYohqagN
 LXIXHiXLgyV+hu3oOrOLu3UUHc34fIl5AzQuCQ7iujaJFlWvm0jjKFeZimWz2VSiMbHGbzkjXWr
 V/ZH4ahFNu0SQPeRJVEwMJqar96n8cJ4tbRZEbxuLuspyhQDwpAVUsA76YYamjpYxmwOQu3cpCZ
 qj4owCsC64k/fW/O1XOHYKVUS0fZkEam8g0tZc643/racWWuUanNn4d4CmttjP4kmJ+S2hC8mC8
 NMcjupMHu9VxIcdlMAX0iEW6sNY8cEria/L2vffEIR/phEYOufJWohJP/J58KzyQw/qIC+Ic0ek
 okiZXA0GSa3mDWCtSBBM+vNa+OrErwm2yUBlUhD4ppRLvs5GA4ZVJu03VBrm5TCxkJHGOBCQnNU
 Inmm1hzF89D+MkFG2tNJXany8Hi6pfXfPfwaPSOsKflKBC+bXo07t1/Jy3W3PJxYhkHUXIffKwR
 nax9nx1XzGcRfpRHfdA==
X-Proofpoint-GUID: dH9UPDQgfGMFP40q0b4GjZ6Vemrxvsb8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060067

Perf tests
120: 'perf data convert --to-ctf' command test
121: 'perf data convert --to-json' command test
fail on s390. It is caused by selecting the default event cycles
which does not exist on s390 z/VM. Use software event cpu-clock
and specify it explicitly on the command line.

Output before:
❯ perf test 120 121
120: 'perf data convert --to-ctf' command test       : FAILED!
121: 'perf data convert --to-json' command test      : FAILED!

Output after:
❯ perf test 120 121
120: 'perf data convert --to-ctf' command test       : Ok
121: 'perf data convert --to-json' command test      : Ok

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/test_perf_data_converter_ctf.sh  | 4 ++--
 tools/perf/tests/shell/test_perf_data_converter_json.sh | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/test_perf_data_converter_ctf.sh b/tools/perf/tests/shell/test_perf_data_converter_ctf.sh
index 334eebc9945e..1d404d404cea 100755
--- a/tools/perf/tests/shell/test_perf_data_converter_ctf.sh
+++ b/tools/perf/tests/shell/test_perf_data_converter_ctf.sh
@@ -37,7 +37,7 @@ test_ctf_converter_file()
 {
 	echo "Testing Perf Data Conversion Command to CTF (File input)"
 	# Record some data
-	if ! perf record -o "$perfdata" -F 99 -g -- perf test -w noploop
+	if ! perf record -o "$perfdata" -e cpu-clock -F 99 -g -- perf test -w noploop
 	then
 		echo "Failed to record perf data"
 		err=1
@@ -73,7 +73,7 @@ test_ctf_converter_pipe()
 	rm -rf "${ctf_dir}"
 
 	# Record to stdout and pipe to $perfdata file
-	if ! perf record -o - -F 99 -g -- perf test -w noploop > "$perfdata"
+	if ! perf record -o - -e cpu-clock -F 99 -g -- perf test -w noploop > "$perfdata"
 	then
 		echo "Failed to record perf data"
 		err=1
diff --git a/tools/perf/tests/shell/test_perf_data_converter_json.sh b/tools/perf/tests/shell/test_perf_data_converter_json.sh
index 35d81e39a26c..7ee235b84a7d 100755
--- a/tools/perf/tests/shell/test_perf_data_converter_json.sh
+++ b/tools/perf/tests/shell/test_perf_data_converter_json.sh
@@ -31,7 +31,7 @@ trap trap_cleanup exit term int
 test_json_converter_command()
 {
 	echo "Testing Perf Data Conversion Command to JSON"
-	perf record -o "$perfdata" -F 99 -g -- perf test -w noploop
+	perf record -o "$perfdata" -e cpu-clock -F 99 -g -- perf test -w noploop
 	perf data convert --to-json "$result" --force -i "$perfdata"
 	if [ "$(cat ${result} | wc -l)" -gt "0" ] ; then
 		echo "Perf Data Converter Command to JSON [SUCCESS]"
@@ -44,7 +44,7 @@ test_json_converter_command()
 test_json_converter_pipe()
 {
 	echo "Testing Perf Data Conversion Command to JSON (Pipe mode)"
-	perf record -o - -F 99 -g -- perf test -w noploop > "$perfdata"
+	perf record -o - -e cpu-clock -F 99 -g -- perf test -w noploop > "$perfdata"
 	cat "$perfdata" | perf data convert --to-json "$result" --force -i -
 	if [ "$(cat ${result} | wc -l)" -gt "0" ] ; then
 		echo "Perf Data Converter Command to JSON (Pipe mode) [SUCCESS]"
-- 
2.53.0

