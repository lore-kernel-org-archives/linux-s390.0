Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9264B1509A0;
	Wed, 23 Oct 2024 06:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666593; cv=none; b=HJcnlHFMQPiK+wBZuav8Yx141rh2rYr+KxEKnNbeWwZJAPEbV2rGOX5ka0IjNi5VxCK+Uf8Um10N4gas5lx9tPQp1b0oBX/kFgIP33O28d5IsGtBNGzChKPS8oi6sPnEuAgkB3ec6eJJP1dyDS73mQ5725KXbmEAVrx5W8DVNl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666593; c=relaxed/simple;
	bh=FBdH48WS+IvGD8WYTKIx5RamtptdbVy8DoUvR1LlUls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OI9QS4BXsSQYNU4Ei8utqvwD18/1hToV0i0USr9poRq9ge2hSwy+vqhezC+FjEa2SUe+MgtyshVmGiw5yJGyw7m8h0d2DK3sO9z4KY7bMxDLnfEnHAeUmHKzHlsgMycAeZInxKgrJ6w39I4P5fWaooVUrutSlYksPRZ9SXmJEq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SVr1xglj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SVr1xglj"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N0N2Qb014739;
	Wed, 23 Oct 2024 06:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=YvwiCkNvSHTkSF26CAop+OGG4ER7uIdT4mf9Hw7W7
	wg=; b=SVr1xgljcQ0AfBS7PhTzO7JRfyYHek15TcGw1+OXwmLEKOuupB4/AsMC3
	mI0H1RKntBAu2wVVkRMuSaxh1bL4y2laE8666xbUmGk1sSe5GB4CVdon69Hobx02
	U1SfGPBiu0vg91Egv7zTJr+xG/B+vHo/B66YS37wWneKLwWjxcS2owEiXU6lJnDz
	thDjst9mn23HU3H5SbyH/GF9U8DEP/SVtm/XX7OnyMxQhRk26EVJHT4Pjj+/JYhp
	NmLoYSaXWNUxrCvBLW2r3p2/A6rtQg8iCjsus5kZIm0IUY3wcNyvn917vBW3R3gW
	BqW8IWAwh5RZwoV/ExFyW0UQsbEGQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emadspvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 06:56:21 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49N6uK8J032083;
	Wed, 23 Oct 2024 06:56:20 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emadspvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 06:56:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49N2rh3h012615;
	Wed, 23 Oct 2024 06:56:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emhf9mgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 06:56:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49N6uGSe52429098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 06:56:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C7202004D;
	Wed, 23 Oct 2024 06:56:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CB122004B;
	Wed, 23 Oct 2024 06:56:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 23 Oct 2024 06:56:16 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 400D8E04B3; Wed, 23 Oct 2024 08:56:16 +0200 (CEST)
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
Subject: [PATCH net-next v4 0/2] PtP driver for s390 clocks
Date: Wed, 23 Oct 2024 08:55:59 +0200
Message-ID: <20241023065601.449586-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: X0Vmp7ex288DEA4M4p9y0MzayYJUejOc
X-Proofpoint-GUID: eYFR-xYEoYC28xUczqRz8kqDN0cs-Ryx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=985 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230041

Hi,

these patches add support for using the s390 physical and TOD clock as ptp
clock. To do so, the first patch adds a clock id to the s390 TOD clock,
while the second patch adds the PtP driver itself.

Changes in v4:
- Add Acked-by to patches

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
2.45.2

