Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98823146017;
	Tue, 22 Oct 2024 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729589125; cv=none; b=h2hgGWYXrWgeQEBzBeSgL8JY21idkoqqj1rPe4O7KRQj7VnhU4iCxoEqHhfyd8oyks/5FV+Z99Iv3l7xgu5itrigLRWrSrLAezOmJmlE3EZeUJriZMoGHPjg5LQLSdJBrpanpKu2+KwINb2dqCYYE7KwBg/NXfOadAIsVVAjpkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729589125; c=relaxed/simple;
	bh=rAuyPr2cU6+++tAkhBZnCcAnNxu7b2cgu47Ggioiw44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NnhVHltVrwaXKNChqIc1V6s9I3MY1wMZfwy2GrTLYem/nsZpffB8uI5mr5VUm/iE/ol8F5YbmUYCqJr3euVpR+3qca7ySDZU6LCjppzYrMjQ10sfE8KvDJl/zyDyhU+jFeF1LMjL9idD81AKuVGClYxW+pP4Vye4B8xysFDKxBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XocN0tUl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XocN0tUl"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M4MGGG008286;
	Tue, 22 Oct 2024 09:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=RknAiKzQML312t9LVvS8jFmWO33Sb6NWhE5vNMHCU
	A8=; b=XocN0tUls/MWEYzXQGNxPBZ5YtaIp8Zvb5V5jsJysd+z6u8+fXiR+TY3c
	vLV5lfPRBoEn0AnbLUjhyLd9QxB1UMRQ6xJzArNIuwuaxOdCeSQQuPlzMHNLsRBF
	0ARoXpkXlMcEaigzPOojlEV39rr4fejLKv++MLO4p6DeQiRf//lhhpce8QTgAOuk
	T22+MReaOk05VnJH0V4UAXGZn0+ZjT81MrtAFRbalgoHh1HzmWx63y7nQyhtFOOH
	JggTo46b7QTmDXdL5LlqJUHBDucieTbHOxWart1K/RhFVuHOWYFjs5a1ZD0aInKs
	ixDn2gFPH8nGQGFXr2j2ldWpDsXCA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42e4xfh1nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 09:25:12 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49M9PBPB029632;
	Tue, 22 Oct 2024 09:25:11 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42e4xfh1n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 09:25:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49M9I6nj009296;
	Tue, 22 Oct 2024 09:25:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42cr3mthb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 09:25:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49M9P77Y22216980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 09:25:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 073F12004D;
	Tue, 22 Oct 2024 09:25:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7E0820043;
	Tue, 22 Oct 2024 09:25:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 22 Oct 2024 09:25:06 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 7E152E04BB; Tue, 22 Oct 2024 11:25:06 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH net-next v3 0/2] PtP driver for s390 clocks
Date: Tue, 22 Oct 2024 11:24:56 +0200
Message-ID: <20241022092458.2793331-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LxYvC16q5DK5fCGxYCjH2SdjX4SZEfCM
X-Proofpoint-ORIG-GUID: 3dxSI1RSc6N0lZPaORDFdzN7dDz0JQge
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 mlxlogscore=994 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410220057

Hi,

these patches add support for using the s390 physical and TOD clock as ptp
clock. To do so, the first patch adds a clock id to the s390 TOD clock,
while the second patch adds the PtP driver itself.

Changes in v3:
- drop 'IBM' from clock names
- use u128 as return type of eitod_to_ns()
- fix calculation in eitod_to_timespec64()

Changes in v2:
- add missing MODULE_DESCRIPTION()
- drop udev event patch
- simplify eitod_to_ns()
- use store_tod_clock_ext() instead of store_tod_clock_ext_cc()
- move stp_enabled() declaration to stp.h
- use s390 instead of 'Z' in clock names
- defconfig symbol should be default-n

Sven Schnelle (2):
  s390/time: Add clocksource id to TOD clock
  s390/time: Add PtP driver

 MAINTAINERS                     |   6 ++
 arch/s390/include/asm/stp.h     |   1 +
 arch/s390/include/asm/timex.h   |   6 ++
 arch/s390/kernel/time.c         |   7 ++
 drivers/ptp/Kconfig             |  11 +++
 drivers/ptp/Makefile            |   1 +
 drivers/ptp/ptp_s390.c          | 129 ++++++++++++++++++++++++++++++++
 include/linux/clocksource_ids.h |   1 +
 8 files changed, 162 insertions(+)
 create mode 100644 drivers/ptp/ptp_s390.c

-- 
2.43.0

