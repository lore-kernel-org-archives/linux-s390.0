Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB6E18A6A8;
	Tue, 15 Oct 2024 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982061; cv=none; b=GvwY9LPjinRNrEESKqUpG/nDHmIpd1tPDqwBu2saWhBYQZIfhvoJFFylcm/BKGF32/zwSPWeVNB7+UsEcDIDXnNw5sLjWZWPLxbXKNXhzXVMBAnq0SEWH+UFpxfUQcuk1oWBuO/bjwaBCF1h/V4pYekqiCR8SWUfCYfQG4RE74U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982061; c=relaxed/simple;
	bh=0GjnuafM8+MuY524RzRyuybMbh2e1W5adOorLwp9ITw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A0Oyb54spfEYtz3KyhhWCyDC14vy+6B5Vx1yJMwM9oO3V8836IQEOoOFberTo1PaMh4nPRlW5Lu/0oXpaXl+5maE4wg03+GYWTw6VEUkkYYziNLntsyVfl1cva3V1WyzA6WIhGp0ew7KmDBFfFtb0m+uIRMb4fiiis5JSnJD8iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CEVn5g1x; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CEVn5g1x"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F7Kbt2031164;
	Tue, 15 Oct 2024 08:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=6fsOagLG+nDf85J5DatB5patV9Oe55a8JmOALUnjE
	80=; b=CEVn5g1xMXUjKWApJlqq7D4ZwJnqgy23NXqyGBRNJTLWsoHz4zO5S4tHR
	V3Qnme21Cjp5cYYqZk4hrkQITwDkzLPt7luj+p46uZaTR3HvMSrFiByI7wn6P6dO
	qxIdLdYw0e+xtEDFEbZrZcfR0XZrUpag1mwAZZ3aqgul2+235+npzchU0zkBFHeL
	f8XeX72ds0pD9LwkuzZMuo96fPv/6LAZQo+feedV1ala9cVmp/juSHVvHRea6Bpp
	bJo4dMSF8xxyWhieztfe7+LPX1P9HBnrbjcbTsROhbWbrBl9rgOJB0UpgjdJEFFp
	s9PzEoTY2TAoLzhV0+wk51vELlBUA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429kwvrdjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 08:47:37 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49F8lah2009516;
	Tue, 15 Oct 2024 08:47:36 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429kwvrdjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 08:47:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49F7P3qJ002426;
	Tue, 15 Oct 2024 08:47:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284emju6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 08:47:36 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49F8lY6G33686252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 08:47:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36EE220049;
	Tue, 15 Oct 2024 08:47:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2535420040;
	Tue, 15 Oct 2024 08:47:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 15 Oct 2024 08:47:34 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id A7BEAE0125; Tue, 15 Oct 2024 10:47:33 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: linux-s390@vger.kernel.org, Yangbo Lu <yangbo.lu@nxp.com>,
        netdev@vger.kernel.org
Subject: [PATCH 0/3] PtP driver for s390 clocks
Date: Tue, 15 Oct 2024 10:47:22 +0200
Message-ID: <20241015084728.1833876-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 99e0W36bAQMCMypwZlpMCm8VJpb6uAtd
X-Proofpoint-ORIG-GUID: K4z_3DYBc6rgJKWxkAathn-aYJkywmaC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1011 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=425 lowpriorityscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150056

Hi,

these patches add support for using the s390 physical and TOD clock as ptp
clock. To do so, the first patch adds a clock id to the s390 TOD clock. The
second patch adds sending a udev event when a ptp device is added, so that
userspace is able to generate stable device names for virtual ptp devices.
The last patch adds the PtP driver itself.

Sven Schnelle (3):
  s390/time: Add clocksource id to TOD clock
  ptp: Add clock name to uevent
  s390/time: Add PtP driver

 MAINTAINERS                     |   6 ++
 arch/s390/include/asm/timex.h   |   8 ++
 arch/s390/kernel/time.c         |   8 ++
 drivers/ptp/Kconfig             |  11 +++
 drivers/ptp/Makefile            |   1 +
 drivers/ptp/ptp_clock.c         |  11 ++-
 drivers/ptp/ptp_s390.c          | 127 ++++++++++++++++++++++++++++++++
 include/linux/clocksource_ids.h |   1 +
 8 files changed, 172 insertions(+), 1 deletion(-)
 create mode 100644 drivers/ptp/ptp_s390.c

-- 
2.43.0

