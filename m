Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C94207A1A;
	Wed, 16 Oct 2024 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079453; cv=none; b=jjw4G5/754yk1WWRXUk7hIxZLFEsRPTkig2vffWbkMlJFnnRJxscYrwQHwFRDhGCHhXys4YijwHxV7NAXIMosdlFZTbgzl8nRKzBmUF1bo9CRgjEkex0dHj+/ONdlXNpdEXIRVHmuqIE6y6pJgFNUOa6f/Azn9lGX1WNEhg9XCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079453; c=relaxed/simple;
	bh=AX30tUD6dKOkQQBmFEEpg1NhT/sQin54YAyP7K2bkRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jppENS1K8wwuK19ZkZ5zEb9nFOED/2WuTETn+wTfkkDsn9btfQYQXXd3eNu/dqnmK15xjSMLWcErfODgRg7FA7JD1ozlkhF4V3hLROeI5HRmRJI/PQBX6kbNC4/8eg1JO4VZoTncJNFR07Ppd4lMjGXVdT1n+NhIZWs3c2eISDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VpOvVWWc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VpOvVWWc"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G9P1tP023751;
	Wed, 16 Oct 2024 11:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=2iEKv6VzLgvZF9EE2zsOh7qrMnIjPazyMscKpQ65L
	5Y=; b=VpOvVWWcWiCUyrF8JH4Qe6/LgUbE2ffkQ3/wOW4mxL8EA/ZPtcaTLs4l0
	djiUSNGZrW2kfOLcbYA06FlCF4mnk02RvJ95ZcoC9CgORPAjCvCwpweF2fqBjaaL
	n5+/gkr9+a16OYoyidSJW3HQe8qPvcBsS0LSE0bW6XRq4Ugyt7cZOEPBvWsLHBDe
	W1UAQK07e5xb/gmo6zLXCHB7FwZIImPNreAxAnPA0dIuIWEA3jD9K0hpthCtEXUF
	UkzE/vYL5ked/U062pGSmrMNGFOyXB68aQ/NokU9xKFUU4Kq3eGArB2p2v0H2oMN
	yCC9vi5+VmvtsK/Ou+YOWXhOLZ1lw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aau5rrg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 11:50:40 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49GBoe05026734;
	Wed, 16 Oct 2024 11:50:40 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aau5rrg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 11:50:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49GATBRT002452;
	Wed, 16 Oct 2024 11:50:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284ems70h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 11:50:38 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49GBoZO653608790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 11:50:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3D122004E;
	Wed, 16 Oct 2024 11:50:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D178C2004D;
	Wed, 16 Oct 2024 11:50:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Oct 2024 11:50:34 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 8FB92E069D; Wed, 16 Oct 2024 13:50:34 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        "Ricardo B. Marliere" <ricardo@marliere.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 0/2] PtP driver for s390 clocks
Date: Wed, 16 Oct 2024 13:50:28 +0200
Message-ID: <20241016115030.2653675-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: y2DgTJzREa8t7SWzXBIzwFMUk93jmmA9
X-Proofpoint-GUID: GbgkTQxseAY5nFGDhbu6YQncIuqXBD1x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=864
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410160073

Hi,

these patches add support for using the s390 physical and TOD clock as ptp
clock. To do so, the first patch adds a clock id to the s390 TOD clock,
while the second patch adds the PtP driver itself.

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

