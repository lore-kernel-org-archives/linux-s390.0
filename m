Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F84A207A2D;
	Tue, 18 Mar 2025 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291522; cv=none; b=quA74S0ozaFyE+mugMcWfs27qRv+9hG4vfl2+bVS4DQbvFXobuD4fxH3qm4EHRVnMV8a+gThmgmLaQx7FftGI+GXPodn/40dvgdVfhdxvakMhpmmw/oPcVzr7c74PlJ+mxV5Mdht3R82QKo0fhQ/Gl+8BSrYPaRjH1Y4CHggzgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291522; c=relaxed/simple;
	bh=VctXCkRtlaipoTEQaRaTImQfkXgNUXPDt05w1Jzpwwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kUqiXAYxhX+1nA+Po4mb51zjCXoLWT7Ibx3f6Uh3V02t7/mg9zgUIGcd474Bgv7hBQND1ZEKYMdCW5EBaimvyGs4oVHdmMwd4+qGGcjolOmv+m5UHyyHnhccfQbyarf+cTZy99L1pXtt74ecQ90V6jwHVAZWUfryE4RMVAfsHjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SmGyoTIy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SmGyoTIy"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HNecN6021832;
	Tue, 18 Mar 2025 09:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=eBOmMJB3ghmaaWbjiKmKwlSAiuexcdIyFCUKTYwPn
	5E=; b=SmGyoTIyOoASelXNt10unNUwlJ5ztMum/uog7ZVW4mv30/VIC0VMSouCw
	jr8wzRWmnOKHjV3WxcR9FASQj/WYrcRsKbgpp11iASXZhUxWllZ57AWXKsDDGQVk
	JJvqA/4l96zQkwb0tIYVqWOYHUGoV9iuFSPKhp1IrqZL7e3ukW37RZcQm7iCwn8a
	m2z0yMx3FOOhj1ceJkVWGCbDjs5RbLLRM9UyA0Ftw+QzQw+64fRNBmYKdAh76eDn
	4TYk1zSjgt6Jtbr7ixTpVyWy4zjYdBt1DUNzS6akGbeDkcCcuGQqGHFTTW1baA3a
	qt7L94CTw09DSzNX/oXy4xfWMMxkA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45eks9dbsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 09:51:55 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52I9aeJZ023777;
	Tue, 18 Mar 2025 09:51:55 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45eks9dbs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 09:51:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52I7SVIH024449;
	Tue, 18 Mar 2025 09:51:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dncm32c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 09:51:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52I9pniM46530848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 09:51:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B02BD2004B;
	Tue, 18 Mar 2025 09:51:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7424220043;
	Tue, 18 Mar 2025 09:51:49 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Mar 2025 09:51:49 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com, acme@redhat.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Subject: [PATCH 0/2] perf bench: Fix core dumps on s390 z/VM
Date: Tue, 18 Mar 2025 10:51:30 +0100
Message-ID: <20250318095132.1502654-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UenzEhNHi7r26mR2mQOh2732Gm5QZi_2
X-Proofpoint-ORIG-GUID: gZDvhQU3RXmkUpbOZu9EzNk-g6Z6ONhZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_04,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=716 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503180068

On s390 z/VM command 'perf bench internals pmu-scan' dumps core,
due to a
- double free of the same memory chunck
- free of memory chunk located to read-only data segment

Thomas Richter (2):
  perf/bench: perf bench internals pmu-scan dumps core
  perf/bench: Double free of dynamic allocated memory

 tools/perf/util/cpumap.c |  7 +------
 tools/perf/util/pmu.c    | 11 +++++++----
 2 files changed, 8 insertions(+), 10 deletions(-)

-- 
2.48.1

