Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52788374D2;
	Fri, 15 Dec 2023 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dLlIestx"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFFMVvg023383;
	Fri, 15 Dec 2023 15:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=PxYIW+Ogv+PRcGpjhTc5X4FzqAIej9t4x6k7OOZnM8k=;
 b=dLlIestxLK85Ko/z0sn6PKONGGyFeTXspOhtGhVFNFmz4PHoikYWXp1PaRCaZzgkgb6d
 mEmE8I9uaIto6kRvWd8HYvb5foaEsCBKzxFjcLjlLBqlHXrGLId65nbeDs1f9ZHq1ASu
 xoRfClebTQTuIaNkXS65+yNunMXRydCEDqRS0HvJ4UKtXbuHiePKJBtNXnSNFSHaQw5d
 KsEhXTLaWVOnKe45LxS50XH9kFUKHRkMg3f1gm+WA8wnCCvEDzzvxpDyCgUPQYrcQjWh
 E9idAKCxwYpOiO3VbRL1zkayn+njNlFD99e3XwKc/S5yxr+aMYHiFdbNSmNAKEUuibUE zQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0scm07cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 15:28:15 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFDILiQ008491;
	Fri, 15 Dec 2023 15:28:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw2ju14x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 15:28:14 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BFFSAhJ12452598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 15:28:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAC562004D;
	Fri, 15 Dec 2023 15:28:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8A7920040;
	Fri, 15 Dec 2023 15:28:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 15 Dec 2023 15:28:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id 8F987E01C6; Fri, 15 Dec 2023 16:28:09 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 00/10] s390/dasd: string handling cleanups
Date: Fri, 15 Dec 2023 16:28:00 +0100
Message-Id: <20231215152809.882602-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K9Aaod1dwIGqO9A6f6wCAeZdr6NUAUNX
X-Proofpoint-ORIG-GUID: K9Aaod1dwIGqO9A6f6wCAeZdr6NUAUNX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=741 mlxscore=0 spamscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312150106

Hi Jens,

please apply the following patches for the next merge window.
They clean up the string handling in the DASD driver.

Jan Höppner (10):
  s390/dasd: Simplify uid string generation
  s390/dasd: Use sysfs_emit() over sprintf()
  s390/dasd: Remove unnecessary errorstring generation
  s390/dasd: Move allocation error message to DBF
  s390/dasd: Remove unused message logging macros
  s390/dasd: Use dev_err() over printk()
  s390/dasd: Remove %p format specifier from error messages
  s390/dasd: Remove PRINTK_HEADER and KMSG_COMPONENT definitions
  s390/dasd: Use dev_*() for device log messages
  s390/dasd: Improve ERP error messages

 drivers/s390/block/dasd.c          | 101 +++++++------------
 drivers/s390/block/dasd_3990_erp.c |  80 ++++-----------
 drivers/s390/block/dasd_alias.c    |   8 --
 drivers/s390/block/dasd_devmap.c   |  34 +++----
 drivers/s390/block/dasd_diag.c     |   4 -
 drivers/s390/block/dasd_eckd.c     | 157 +++++++++++------------------
 drivers/s390/block/dasd_eer.c      |   7 --
 drivers/s390/block/dasd_erp.c      |   9 +-
 drivers/s390/block/dasd_fba.c      |  55 ++++------
 drivers/s390/block/dasd_genhd.c    |   5 -
 drivers/s390/block/dasd_int.h      |  29 ------
 drivers/s390/block/dasd_ioctl.c    |   6 --
 drivers/s390/block/dasd_proc.c     |   5 -
 13 files changed, 153 insertions(+), 347 deletions(-)

-- 
2.40.1

