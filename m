Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9A41E0B66;
	Fri,  8 Nov 2024 13:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073907; cv=none; b=tEhOohRMzUWBJpRVQEW7aP/ys963ZYVpwtKcxIb5oGbN4w4wQn80tfLRNaphjCPLw41hkOaHi/bDM0QSbFmEZl8A+wRPEj72rZsEtzwxS/2a/Juf8ODGNV56z3cNESVlGjnJ+/FMMyLcwJcAAYDb1gr8FgrmQpfGfA0mnz/cgwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073907; c=relaxed/simple;
	bh=3/5nmr5NBbioTwgKYO0EQACI+Yl3205RM+UAMkwZXx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cFnbmQJR4DDDiXdxgvwgdd3Btd0sRAMuPpiICGxRWxkUilrtKeCqSOQ8eB9MwgQZyNqjsiBuiA7s02pri9J3mvEUIoO8yyvRoMDgt1QB/rfKDIpzI8o7HTOIWTfhMNP/qhalNVJ2VSp0uEoHleanUOMP5MPRg9/a9ArPZxN9mow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=anAFhAZm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="anAFhAZm"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8DAbJA032765;
	Fri, 8 Nov 2024 13:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=eFQPU7rxNgHWF8Lid+E/gHU5NgoPhsn8T1OLodKsF
	OY=; b=anAFhAZmZ4YbPbw62a098nClzQYfB6H3smcADkufRFnVJ0YmdwEhGuFfs
	ZxYdvc/XTI3NSs++SwAKDhB3nOsmNfXhNp80an9wJF9GM9GoDVeyDyyPWLauP+18
	7zMwJihFuj853+rglGpp2pEKz7Q0tsEXbqLy+hYMAO9u/uUTi+P1Dh0z+YkoT2Ot
	DH54EgzamNZVjmvmuaDFVfsXJPdUIqwA40FeTr3trTKInUigAod1mXxVtdVPbtwQ
	+wBu4I+60g3wjCZSsUPXD2ECPja4UmP26dOevXUManiRlNmTt3P2DMLjsJBEVYZf
	f+vDd3wuykDakivjJrXRGOgvPE15A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42sk9s85n5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 13:51:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8BHupx019503;
	Fri, 8 Nov 2024 13:39:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p0mja6kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 13:39:20 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A8DdE9k16056792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Nov 2024 13:39:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 608A520040;
	Fri,  8 Nov 2024 13:39:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D7A52004B;
	Fri,  8 Nov 2024 13:39:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  8 Nov 2024 13:39:14 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id E904CE03BB; Fri, 08 Nov 2024 14:39:13 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Miroslav Franc <mfranc@suse.cz>, Yu Jiaoliang <yujiaoliang@vivo.com>
Subject: [PATCH 0/2] s390/dasd: two small fixes
Date: Fri,  8 Nov 2024 14:39:11 +0100
Message-ID: <20241108133913.3068782-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZQars5CAWD4e7SjG7yVMAT9qkwXkZlIt
X-Proofpoint-ORIG-GUID: ZQars5CAWD4e7SjG7yVMAT9qkwXkZlIt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxlogscore=507 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411080113

Hi Jens,

please apply the following two small fixes for the upcoming merge window.
Thanks.

Miroslav Franc (1):
  s390/dasd: fix redundant /proc/dasd* entries removal

Yu Jiaoliang (1):
  s390/dasd: Fix typo in comment

 drivers/s390/block/dasd.c        | 2 +-
 drivers/s390/block/dasd_devmap.c | 2 +-
 drivers/s390/block/dasd_eckd.c   | 2 +-
 drivers/s390/block/dasd_proc.c   | 5 +++++
 4 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.45.2

