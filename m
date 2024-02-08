Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327DB8174B;
	Thu,  8 Feb 2024 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410580; cv=none; b=UmoKSkTXpCBuquqhO9SZ0YFZ9+hfJT/Yl0JsCJ591U27rEzt6XLKubjFE5qP5YPgWzqzMSbWmHaeaAZZZBCCAoJuc9/7ZXQuiVtMvjb1QjLB1Ifb6Y5vtJXdvfg4/k3QFOatmnEyLAbGtsDcOflXcoDbO1t0a8iEXnmMlWW8T2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410580; c=relaxed/simple;
	bh=gY+FnzB2PEWYZMvkUXtPXArk1ePvc2Wh+kwwYZMFS5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KZPtD1up1CPYfMan+vrKwwOhfCGc0ssZziQGg/ot1XRaAG4bqlVNhmj3MIXwRmO3ovwVIQztUFie8djRXvd/AVOD5dB4YmQkD3KOohNqwl3Eddg4AWL7qjHpz/25qityMvH1gD/psm4Rkbmm7C+pwmK1g2LYnNIqALL5BPCK3aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cex9P3aY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cex9P3aY"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418GccjY028693;
	Thu, 8 Feb 2024 16:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=V47vFoCh+TY/xfKaRSqzsP+vsHJ4FMcCdHFv8uTutq0=;
 b=cex9P3aYzOR1VKXYw3E0YnSVal/cuspC4dAzMMxk8/QmlFfozjW40zoS/csVipaAryHL
 Tx2ac+0usMJlCN1TErZO+hvavWhm8FX20PF7gGqo51DHp3sFa7Gwkrnv1D97RumzldZR
 fmmUVxTJbcVQYHMtNqeaVoLHyYtUCYImqpw8eHeC8OdKwWZzzx2ERbYZZSSBAetCd/he
 hj33yUvj+HW1WBQjA+0bxTWFZGM+SrsFFydkCO4vLrkKJjNeii7GJGUd6sAhgyGCXTsj
 yepOk5LQV7+1NnjAtjPP6+djCZYlWvYEVJtEwc4op+QbatjdFoJ323M1OATWDw4e6Uui hg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w52n8r38d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 16:42:54 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418Eqd6f008758;
	Thu, 8 Feb 2024 16:42:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w206ywsyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 16:42:53 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418Ggmt020054776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 16:42:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AEF32004B;
	Thu,  8 Feb 2024 16:42:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AED520049;
	Thu,  8 Feb 2024 16:42:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  8 Feb 2024 16:42:48 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id 3E035E0361; Thu,  8 Feb 2024 17:42:48 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Miroslav Franc <mfranc@suse.cz>
Subject: [PATCH RESEND 00/11] s390/dasd: string handling cleanups
Date: Thu,  8 Feb 2024 17:42:39 +0100
Message-Id: <20240208164248.540985-1-sth@linux.ibm.com>
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
X-Proofpoint-GUID: hMktxmx5Fteqt0vQVIKBuuwkD6OUYE6y
X-Proofpoint-ORIG-GUID: hMktxmx5Fteqt0vQVIKBuuwkD6OUYE6y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_07,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=648
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 clxscore=1011 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402080088

Hi Jens,

looks like the patchset was not applied for the last merge window.
So I am resending it rebased to the current for-next branch.
Please apply the patches for the upcomming merge window.
They clean up the string handling in the DASD driver.

In addition there is a patch that fixes double module refcount decrement.


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

Miroslav Franc (1):
  s390/dasd: fix double module refcount decrement

 drivers/s390/block/dasd.c          | 106 +++++++------------
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
 13 files changed, 154 insertions(+), 351 deletions(-)

-- 
2.40.1

