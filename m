Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFD71A3154;
	Tue, 10 Jun 2025 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749566739; cv=none; b=k7PqCrRJjqIG89wf/jgrw8x9liuMiX01RU/wUcRgMqLBQScWVqBD8bDul2BG11LRlKJ8IcxNAmPy3ZY1aYSZXVvEnd9onMXQkpw+e4lOK+Us8XU6NlL0FmQ0CJTvNAHDoxcD2/RqELjwUqmPoUkwuFKvLPz6vCzsn3EcPdZxufQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749566739; c=relaxed/simple;
	bh=h4BXOA8m9IzkD8xuRE/hKW1UduicT/oYQq3M+0Z1/W8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FdcpC9QBAIyuCG2hrCBaPvVfFrGli71pcRoZdNHB+5e+sGG3mvfif5dbGMyIohKSRdM56c0OESKHolxipPvhFsHjo1Y4MaAl4nrc86a8zFjuAjpoARO242KSe2qcWNa+1iVn9OcNatxCWE3v5nLJZwROxbBw6gs4+dtkhPm6mZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=owW6zf2d; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="owW6zf2d"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A8w8MO010507;
	Tue, 10 Jun 2025 14:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=AVzjx8YcOGkcDa5cp1k9DlHp09myGhb7fHCMAy89p
	6Y=; b=owW6zf2dgP8XWwIJeeRC+lO5Mt1wgivi1W/eHIY4vKlwelcKX/Y9ERBsu
	3QmeXUPEQvMUfDi09e8AYU+MlP1iHL+aS4KoL2rsIm0iGG5aSkMQj7zQpPM3brHU
	A0Hqjm1NW2XczaYCGA4YuqfN3kRm88ZqpKLtGBsL0PEGGR1qsbgjRnVf+i2xt+TK
	LhEhwuR2pb+rc4rWdN9GRcGGI3DrE7/NOVR4Vzqeb2jgRVh2vgAkLuTBwNA0n6MS
	xVvYaVbYKlXMBWmlXoDw7QyRLMTYUIWssWF5r78IcaAZAap6LigbeuZJYdyfPd/I
	+K1zPm+OeFtf8tRszsO2AsZTu69/A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474dv7eu44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 14:45:35 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55AEdkZc029977;
	Tue, 10 Jun 2025 14:45:35 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474dv7eu40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 14:45:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55AArRUC019575;
	Tue, 10 Jun 2025 14:45:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4752f2ah6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 14:45:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55AEjUSC47251906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 14:45:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9E2020043;
	Tue, 10 Jun 2025 14:45:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C59B20040;
	Tue, 10 Jun 2025 14:45:29 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Jun 2025 14:45:29 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        ctshao@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Skip stat uniquifying test if unavailable
Date: Tue, 10 Jun 2025 16:45:07 +0200
Message-ID: <20250610144507.2839326-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DkYUqJIahu_RGpeAuuxtmsYUEbkv42jW
X-Proofpoint-GUID: Yigdxh6nR7NsuaXdm_z6wpJANY5wzi_t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEwOSBTYWx0ZWRfX4PkCIA420wi4 ovwIQJwhxIosc2SFiyw38L7Ym9/HSQQC3xaMG0v6uYsFq8/ikFlPPU0HC3aK6pYm/qpYPEExnOy plfB+O80vBHt5tYOiWYR4p/iSjqlb+WpadlhPveTk6zlYwOk7C4ryGOjQ6UpqTDDD3Vh/LXmM0y
 ROxXRfJHK307hPhJrDCXZD8fhm2DQoUR01Lo7KApSdB0SGYmzzdIOevF4fDK+UGQv/1r008jYkb 7uOZMXemgW5k/cjkWq3wutiAUsHoDa3zAdSiZpfJAOa3T5JVNc1nMjgYz0PzX7oIynV5YJ9lMOf 0Qa7qpZBjpTxoeEv48iFWHpaSzSqifxFLwZv6/2vPaY5TRV3/eh6J25HfrWM6EKHPXcn2uC9vVU
 dmzFg/oCD6oiqz6efvfHUDE9Fteh2BiAIf/Z8Tgmy1+7UuQ7VWVcSC2xReGZFOFwxFRuzSh5
X-Authority-Analysis: v=2.4 cv=CfMI5Krl c=1 sm=1 tr=0 ts=6848450f cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=TZVNMe80M5Pr-4RzpDkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1011 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100109

Commit cb422594d6206 ("perf test: Add stat uniquifying test")
introduced a new test case which uses an event named clockticks
which is exported as sysfs file .../uncore_imc_0/clockticks.
This file does not exist on s390 and causes the test case to
always fail.

Check for the existence of file clockticks and skip this
test if the event does not exist.

Output before:
 #  perf test 87
 87: perf stat events uniquifying       : FAILED!
 # ./perf stat -e clockticks -A
   event syntax error: 'clockticks'
                        \___ Bad event name
   ...
 #

Output after:
 #  perf test 87
 87: perf stat events uniquifying       : Skip
 #

Fixes: cb422594d6206 ("perf test: Add stat uniquifying test")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/tests/shell/stat+event_uniquifying.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/tests/shell/stat+event_uniquifying.sh b/tools/perf/tests/shell/stat+event_uniquifying.sh
index 5ec35c52b7d9..485ee6e8f574 100755
--- a/tools/perf/tests/shell/stat+event_uniquifying.sh
+++ b/tools/perf/tests/shell/stat+event_uniquifying.sh
@@ -49,6 +49,11 @@ test_event_uniquifying() {
     uniquified_event_array+=("${uniquified_event}")
   done < <(${perf_tool} list -v ${event} | grep "\[Kernel PMU event\]")
 
+  if [ -z "$uniquified_event" ]
+  then
+    err=2
+    return
+  fi
   perf_command="${perf_tool} stat -e $event -A -o ${stat_output} -- true"
   $perf_command
 
-- 
2.49.0

