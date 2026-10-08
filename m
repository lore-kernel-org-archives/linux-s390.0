Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F4043CE65
	for <linux-s390@vger.kernel.org>; Thu,  8 Oct 2026 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446915; cv=none; b=DEkt8xYEm+Bm8ZV6BVYOAwgxoYEu0bwFyXHdu6Zt18PTWckspkBjCnphfDkCMpfuqeiiDeBigjgob/XWCVMxC7PPWatCCwFGseFagEuEaJIYp9PxpGPkyjqgcc3go2CdxxkqdsAMjK1PrJr+l/5JqUDK2zI5/A67C8I9S18XzFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446915; c=relaxed/simple;
	bh=o/KEpHaiQ9VvLC0O5ElEyiJ1D4JV5LD12jmk/6ZmAxI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E00r1sO4cEXDmdQ8g9YwbY1kDsIPW30oGSQ+gu6rafAUcIHB+FuET0q/Rv9RXkjFcGOBn7jDRupTRqMU6OeGdXxWR6cbIoJZ/RHy3a6FHk2jj98JIooCzl8nnT/S46ZR/2+eZizeHHlO2Zf1AGJIgO7uA8N5wHzidNK+6+knkC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AWuQrke0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AWuQrke0"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6987Zckt789710
	for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2026 08:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=sD9Lw7x37A5wMxAg+dxGvKGXUnF8
	hCswqBzktcEdsMQ=; b=AWuQrke0knz90wcc2/kNAdnWXTrWFf+qu+vaSpvqZ5DX
	UFPMhzFDhBrR1edZ4l0xUn7gpVEHkXopYuNxcM0lMskt4+NSPNQimLJKaknq0Sak
	LF+oh8tE6RU7zZR8W7csUA2ooBBPfaQtkn004nhLXUasVoMzgKPY58NMCFfoHG9C
	6pWu2y3tHPy4T2+uY5//ZAO7lUD8uNKB8Ss6CkaYVdrm/iKYA3HUGEKhXiB6peU9
	AaahYm/mpdEBIZOg8u6VyhjDdufgU2gPy/MwAF/Kj6q9+N2xz3P9Lxu37CZ0Xyce
	m6gFPHVM/mwdJCChiTDy2xVq7YwBhgybeufEtOHmjA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvtapb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2026 08:08:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6987IWPp3149973
	for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2026 08:08:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5a6dp6u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2026 08:08:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69888MPp34668998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 08:08:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B9D02004B;
	Thu,  8 Oct 2026 08:08:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0027620043;
	Thu,  8 Oct 2026 08:08:21 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Oct 2026 08:08:21 +0000 (GMT)
From: Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH 0/4] Introduce dibs peer bus driver, dibs console and dibs
 block device driver
Date: Thu, 08 Oct 2026 10:08:02 +0200
Message-Id: <20261008-console_server-v1-0-636b11ebf191@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XO0QqCMBTG8VeRXTfZpk3XVe8REXp2zIFusdUwx
 Hdv2kVgl/8D348zk4DeYCCnbCYeownG2RT8kBHoG3tHanRqIpiQrCgYBWeDG/CWdhE97aBqFKC
 WZc1JGj08dmbawMs1dW/C0/n35ke+Xr9UycSeipwyWgJoBaLVhWTnwdjXlJt2zMGNZOWi+BHV/
 zdRrAQqVR0V17Kt98SyLB8AznQv8wAAAA==
X-Change-ID: 20260330-console_server-fc7a9ced6481
To: schnelle@linux.ibm.com, wintera@linux.ibm.com, ts@linux.ibm.com,
        oberpar@linux.ibm.com, gbayer@linux.ibm.com
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, raspl@linux.ibm.com,
        hca@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        julianr@linux.ibm.com, linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ziYNwnHZLwy7B6enYB7vtJGLB10PlGAf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzMiBTYWx0ZWRfX0n18jiXIE4P2
 mFTZYwzfTwP6M+oyO5u5YhB30uJc0OVUUrrwRzYrIQXTTydAWYHzpVY8fN/Xrl0X5HgHP4j4QCT
 isfUvd5ITwoQf9syMKY3zMnCkw/s/r8AtmGRqw2mxWThgoIYgLBwfSOoVZfGEYUdpoJ1tHHH7Yg
 MH1K5oL9FpqOMLwcAFpEKK22iGs+7U3nJbx4MDnd1XWVQeP6ueIlOZmW/32kG05E/VWsivxvHh9
 XDT5pjem5pZ3GKz9Sy92vp+JLZVWcGudOI69eeQ6nszHVgXYfD2/FfMjqFnpiKNmVLffn+yU1/Q
 P+W64/3jK+45CaICjE4svgAhvK7QRHH8q7INiz0T2U1Nlr6wDcGbFjIs1ATtZjx6ahj4FPzYyBW
 c6Sc3q+gVCQ2LDGIgkyieqoaLFvxryST+T6NEWQY2VHRE/bBoF1sLo3QAozp2iCDUS78AmMoZb1
 4HHFMF7+YHJ/cjWj1GQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzMiBTYWx0ZWRfX872BoEYSvL2c
 qfFLhNk3UI0mxxurD549KNOxc4y6NxA/+9RSRd8rqWvlnEHUFY7czUC5QerAbqP6/sfp2nhY6g8
 ljIfWZwMN6kK/p7UL+uOsXyn2O+I7PU=
X-Proofpoint-GUID: ziYNwnHZLwy7B6enYB7vtJGLB10PlGAf
X-Authority-Analysis: v=2.4 cv=FLCOVOos c=1 sm=1 tr=0 ts=6ac74f7d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=X0EHTOvv15-Vs7lKeYAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 clxscore=1011 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080032

Hi all,

this series is based on net-next.

It introduces the concept of dibs peer devices as devices on a virtual
bus, called the dibs peer bus, implemented on top of the dibs
communication layer. These devices are based on the concept that one
peer on a dibs abstracted fabric can present virtual devices for
consumption by other peers on the same fabric. In this series two such
device drivers, a console/tty driver and a block device driver are
included. While the console/tty allows two peers to establish a virtual
TTY between them the block device driver allows read-only access to
block data, such as the contents of an image file.

This is a prerequisite for an in-development, open-source user space
driver stack (console server) that uses the s390 ISM (Internal Shared
Memory) device to implement and announce dibs peer devices to multiple
remote target systems. These peer devices are currently of type console
and block device. In addition to the console device which enables
console access, the block device support enables a target system to
access resources such as ISO images provided by the console server. Both
the console and block device functionality operate without requiring any
network connectivity. The console server is planned to be part of
s390-tools.

Thank you,
Julian and Tobias

Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
---
Julian Ruess (3):
      dibs: introduce dibs peer device bus driver
      dibs: introduce dibs console peer device driver
      dibs: introduce dibs block device peer device driver

Tobias Schumacher (1):
      dibs: introduce ring-buffer send/receive API

 arch/s390/configs/debug_defconfig |    3 +
 arch/s390/configs/defconfig       |    3 +
 drivers/dibs/Kconfig              |   32 +
 drivers/dibs/Makefile             |    5 +-
 drivers/dibs/dibs_blk.c           |  798 ++++++++++++++++++++++++
 drivers/dibs/dibs_console.c       |  388 ++++++++++++
 drivers/dibs/dibs_main.c          |  500 ++++++++++++++-
 drivers/dibs/dibs_peer_bus_drv.c  | 1220 +++++++++++++++++++++++++++++++++++++
 include/linux/dibs.h              |  177 +++++-
 9 files changed, 3122 insertions(+), 4 deletions(-)
---
base-commit: 8df0638138d3e0344fd1fb36cf2d1ca1cf5028f0
change-id: 20260330-console_server-fc7a9ced6481

Best regards,
-- 
Julian Ruess <julianr@linux.ibm.com>

