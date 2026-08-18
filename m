Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FA1343D86;
	Tue, 18 Aug 2026 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081642; cv=none; b=HjFzhJM0pTNROP+KpsfapHwqK6f85p1e6AGgFs73Bpr5VjJlreOhSitWVMPh90blcz5gbfHYmd5jCDZL4Y9uBvsfo+0v3ZqfDGx4Q6q3+vnvL8Tf+HWMjR0HnO+08g/ISJ2W/okNbI6WDllSEscPRhdG8g9Xgs10gVaJ/Snieec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081642; c=relaxed/simple;
	bh=8c9p02hWrIDyoJFv682PjjXSgB3B4wh2QzoQJCT4GGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WT+7UvNOUNEYDU9zT2C5Lb/t7CgcZ34VtmXw3PVymTL9UYz+KwSyA8+WmrcFZKmUBOLDjSalEqh4pAXwVDI3R9hGzTiozeekQjnwKjJeBVjhwkJhdnaWIfqkFZylWEb+JpL4+LTAGryQlpo2N9xt+S8WdFG4aZ+MmOegbpJKApU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EAF5yAct; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EAF5yAct"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IJWBGe1151937;
	Tue, 18 Aug 2026 19:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Rqg1vnLkTla3CXE39CQpDg70Tqk6WPykVLx04/I7M
	lQ=; b=EAF5yAct8lVWfdlcka5pMigSznZJ+TfPRASm4XeczbduAyYSEa69iPBMu
	v4uMef00KLgUgT5d+4UzIu3gP1r2UeXegboSH3zIPzn/UmJNOv8HztDRYGW+9hHo
	JI4a9kGT4IhAtLwfLbIglk6LEjNv1Scq52yL6opgNeztgwKxuOD02Q98/f9T6Hpb
	1YRX4835DIUCQ+bqtDpiyzc/5gtN58gsVVibwUox/7LcIC2NrfGliW/zjwPDy8fW
	bzKXO8+6BIYuuJjI4IgXKw/gX5KlzL6r3Q+7OG9H5hhDz46tKQ1/5VPHLDjKo+yA
	GOFESpalfiUzt/HLMAcK4h3ZX/2MQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhm2933-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 19:33:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IJV9B8026236;
	Tue, 18 Aug 2026 19:33:53 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ycuxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 19:33:53 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IJXpsr8586044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 19:33:51 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9726758060;
	Tue, 18 Aug 2026 19:33:51 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B3C45803F;
	Tue, 18 Aug 2026 19:33:50 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.26.94])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 19:33:50 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v6 0/1] Fix leak of KVM GISC resources
Date: Tue, 18 Aug 2026 15:33:48 -0400
Message-ID: <20260818193349.1877940-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MyBTYWx0ZWRfX+6vkP5tItVZ7
 bgQ35+HSfYhK8q/dqJ1p5LJIeicRCPiYCwk5xvePL5pFztSmhbutgcBeYx6NvyD/CmSZpcFgE8b
 9CKusXYZFxEW7izvb+lPvgPJViq0ZyukKUXP40xPCrBMUCe8x2ynswf1qq30SmfYdd8m55iOww7
 4OiBEslRmd1d89/GYWC34gLCw3iPJliR5QhjvNEnz2anvu6BWelbLnc1sFkqVoRclR3UVXkYEfL
 VVu0J+NJvQ6CNJ62xa06RD1C6Y77uP0IhbPms6FO5TXXyOS9AOuL+CyjnX8S5JjPUgq41wQ4Ltk
 t/Ki8m/fQLeVuLkFDqqlSqV0eS+vKmONhqMPG79/wYTHDvjsMME44+FM1LjTtwPr6RI/OL3KKJ5
 1YkUfbWd3hpUnsUk9eZfysZo2kjo1Jzwcd08dDg32FU85I/NQvXA4rZcYiyWfz3tpO/aRGHM2id
 HXDv/p4F85jjiICagUA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MyBTYWx0ZWRfX2ezgjfYEkEJ2
 rXdFrxdnN/7Gv1OfaRDhIT9/ZFPXQ4KyEMHnH2TiDJmUSnF9MJ9rxCd0IhTot6vjVt3zBQOiytn
 cQBX/kPFooaYM5Avq49XgDRTel9XQWw=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a84b3a2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=QoL0vgGQN9Co89mwoscA:9
X-Proofpoint-ORIG-GUID: KcGM6Mi1isJQHnAzc8ch2HkWbXc2QkeM
X-Proofpoint-GUID: KcGM6Mi1isJQHnAzc8ch2HkWbXc2QkeM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180143

This is a continuation of the following patch:
[PATCH v5 9/9] s390/vfio-ap: Fix memory leak when queue removed from host
               AP config

https://lore.kernel.org/linux-s390/20260812200240.818004-10-akrowiak@linux.ibm.com/

That patch was posted with a series of patches, but was no part of the pull
request for the series due to some code review comments that needed to be
addressed. The first 8/9 patches were part of a pull request to make the
merge window which was about to close; so the referenced patch is posted on
its own for review.

Anthony Krowiak (1):
  s390/vfio-ap: fix KVM GISC and page leak when queue removed from host
    config

 drivers/s390/crypto/vfio_ap_ops.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

-- 
2.53.0

