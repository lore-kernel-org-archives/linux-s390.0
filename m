Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FDD13CFA8;
	Mon, 15 Jul 2024 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042691; cv=none; b=UcamSFF+Ds8NabhZ/v7iVtG403DVB6QYgbpjBIAQvhfs3bRwAvNYjZx22d4/g+IAvVDRNTBrOXUUyW50wlyzY9GDT7XeDk067Upfs6teQoVyNX8dVD+5ovB1bk4htdbLtnG1YmKf7HsoEBcHOwc6y+v+nqh6Ls4VD9ZiHycK5oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042691; c=relaxed/simple;
	bh=XxyW/Lklq/erjB5VkVr1RtQGFcMCEYYOZP7/nlOQMSo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=V0RJhbv0I+uPE4ttz3M7L1kF3fecZBB49buvWXWpc+Q+qKfzCqaQcbua75J9Rcj1QeTze3nku7tnus2VKf1zHVf8E2OtiDSZdxwJQLPSFC6OBsTPMavvuUUeCDr576/AInOrX6R1AwkvvQjHHB2hS8N5vVmMFadlVMM7qPhffWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jo8n90X1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jo8n90X1"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FAv5a7012807;
	Mon, 15 Jul 2024 11:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=pp1; bh=1UP+w5pa7K/ih6taYpcXuk/3kz
	B/X2RfAkDh+m22zfw=; b=jo8n90X1YXuKV2xvK/pm5ws3HLltOSZoF4wbc9okZe
	0G8nsGaezQv48OaYh0vtWCVLS1mTHNdnL7BMgU0oTZK6iX7o55bcj1iZ7LKWhysT
	49dOed+FFJrHr8Td/2Sti6dGW/FdZUv7hZ8Ljr/7IQJQw941N3i4+PEbm4vCohlC
	M1U+m4cXcR7HHsU8/qZgkv1uFj8s2vBPtrVI/JqmtPhgrlwUoJWlT64gMtYev1Ie
	nVVRsP0NtYki1in46B7gCjJl0PNEi1hTxMqL8Pv6t6erHOE1sKlGjVGJd/d3bYmv
	MHN85wTLfviw7sOVV/9qZOlyTIDNmbMY4wpg/QgnK3eg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40d161r860-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 11:24:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46FAYM3q023107;
	Mon, 15 Jul 2024 11:24:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40c64kxbj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 11:24:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46FBOZEF7733508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 11:24:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 520DB20076;
	Mon, 15 Jul 2024 11:24:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 402CF20067;
	Mon, 15 Jul 2024 11:24:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 15 Jul 2024 11:24:35 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id D205DE0968; Mon, 15 Jul 2024 13:24:34 +0200 (CEST)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Carlos Lopez <clopez@suse.de>
Subject: [PATCH 0/2] s390/dasd: module warning and error check fix
Date: Mon, 15 Jul 2024 13:24:32 +0200
Message-Id: <20240715112434.2111291-1-sth@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: yafNn-mo7B3IAQos3X5_zuKaARWK4Xtu
X-Proofpoint-GUID: yafNn-mo7B3IAQos3X5_zuKaARWK4Xtu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_06,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 phishscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=783
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407150090

Hi Jens,

please apply the following two patches for the merge window.
They fix module description warnings and an error check in a dasd function.

Carlos López (1):
  s390/dasd: fix error checks in dasd_copy_pair_store()

Jeff Johnson (1):
  s390/dasd: add missing MODULE_DESCRIPTION() macros

 drivers/s390/block/dasd_devmap.c | 10 ++++++++--
 drivers/s390/block/dasd_diag.c   |  1 +
 drivers/s390/block/dasd_eckd.c   |  1 +
 drivers/s390/block/dasd_fba.c    |  1 +
 4 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.40.1

