Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A492288E6;
	Wed,  5 Feb 2025 10:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738750722; cv=none; b=azkmG1eF6hgJANRgPQw76fC56Aa5/XfCBPeu7EDjx40YRNgf11U3TwcvvT31t6PfxyDVh71zgjWf+li7tgLbKm+9l2EtZB5JLMO8ctZxsrNEs+PQutbZmO/r13NcNVo1L966gMWIjSTc1lau3WOqWxQujLovkhjFUaTCR8G8MJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738750722; c=relaxed/simple;
	bh=k8Na3h4hLlnpst5EP/4mrdz5kkWyZB/QFtQWoRkzrg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rACC/P0whKSS9jwbDNJZZ7u7Gcma1XgHoicrPjxXoOi8AiemILIrZfzUga4VzRKAd1UH1yDIvTcbGwIvVI39NHS0vluPLD5bbR/mo0ItigsfaDULakirr7DanfrDHkWFIq5UEkfWQIA14aSG6CwqYUnjlwOWcgVO4JuLpqdTEUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DzUwVkmY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DzUwVkmY"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5157Wr1a000888;
	Wed, 5 Feb 2025 10:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=XxjPXjrd6nfWBEoAPONChfjAIGljPbm7P8j7q3XJg
	RQ=; b=DzUwVkmYwP99KUrAwFi53yZvPAnPJ5JK5Q3cj1iepUwBGGOx5dyFR0QCa
	uQkVOCixru8RwlhhkO5avXhEfYXoCJt8SC91lb/gdZwCrWv+SOP8D6SLl4doNV0S
	X6Y01IQ2bSC5VlELwuZNHzpgOlh53lyooznK8Uugj/72V4h3IMxpo+Uv+ljv4Q1F
	MUpV2fCFi4QeqPaoC81Ui9qioV4h0z1s85nhsItSZP7Ve5fxpyQHz7Q0JQ1o4UNP
	eFbNQodnCoqZ285dCGNGnfNzse75rcfIUExyDnn9Jgqnc6JV48Bf9qQ0C3TXSh0p
	Wn2SQH/TlNswm/meup09nrkz0fKYA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44m3pnrr9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 10:18:30 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 515AEaKJ025440;
	Wed, 5 Feb 2025 10:18:29 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44m3pnrr9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 10:18:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 515947ge006543;
	Wed, 5 Feb 2025 10:18:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hyekg5bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 10:18:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 515AIO7k48300450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 10:18:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0B0A20073;
	Wed,  5 Feb 2025 10:18:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84FB420072;
	Wed,  5 Feb 2025 10:18:24 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Feb 2025 10:18:24 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Subject: [PATCH 0/2 v2] perf test: Fix endianess issue in hwmon test on
Date: Wed,  5 Feb 2025 11:18:12 +0100
Message-ID: <20250205101814.2801701-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aFxsIYj2YwVm5QoDLRokzZ1d_A4aSiQL
X-Proofpoint-GUID: AMtOQSh2ImI5-3TJPcR19Eh-0Dp5J3hd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_04,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxlogscore=627 spamscore=0
 mlxscore=0 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050080

Fix endianess issue on s390 with union containing a
structure with bit fields. Bit field representation differs
between big endian and little endian architectures.

Thomas Richter (2):
  perf test: Fix perf test 11 hwmon endianess issue
  perf test: Hwmon align structure on boundary in union

 tools/perf/tests/hwmon_pmu.c | 16 +++++++++++-----
 tools/perf/util/hwmon_pmu.c  | 14 --------------
 tools/perf/util/hwmon_pmu.h  | 20 ++++++++++++++++++++
 3 files changed, 31 insertions(+), 19 deletions(-)

-- 
2.48.1

