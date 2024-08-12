Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DEF17BB18;
	Mon, 12 Aug 2024 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723467467; cv=none; b=i8Q8KP7aVC3ffFmZxsvnHT9+Kfcf91l7VLb7BtO9WQA6nHL5+cQF8mLz5/6bG3zlh+Gm4YBoFd/0NNAjSJW3sVbpq87zJlIxIPXsZQsEcTZBFEr9+PUwdR9hYyM+2XNPXny5uC5K9jkIVkItjGD5DJp7YrWcnRIJxoFg/E1UuE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723467467; c=relaxed/simple;
	bh=2g/zhQW0rp6RZ9HeG6f9o8eDJqSxVgyCZkdQ9aJJUHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E4KXZz/1kB914wSbA4eH6Cs9Ra9jCYAbCqWe85ftaryClkFkp525NAbAAtbpOGotbFVJd8VYCYw00sQmzSKZs+x4cJe3E6idVFiSB7mg3hTDF+uxZQFa5AWOaWXq/7rj4lCU0rACC+8f2wwEPxo+lvrfLp16UEGYTsJw5Y8ewHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KzcLaWu8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KzcLaWu8"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47C5bLWP026796;
	Mon, 12 Aug 2024 12:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=gSjtv50qxNvOzbMrUk9aAziRUo
	WhdTGl9lTdPG0ZSpM=; b=KzcLaWu8oBkyMbgOcrR3xedoQS6gawlqQd/9i4q2Ut
	YhVshOuDhr0LIcenvDap8F9NGoWhTaNkXobOlzFbbAce35Pc41W5M9xVpSmtyBNK
	VWf4zpaR/RisDncUJRDD7ky1I0THA87ttDuSmnYMIYAbCYuM7oBexZG85PS5aako
	F942l6XjxwTz00AfE/EER5ljQLy/LUTu01X10cT1HLOrhWa3Kw3/Cq5yCb9Ug2pr
	L8KloHp7ozlQ+16di5c/yGrNXPH1Fvr/YaDnVksXKaU0tgFSqW3TOz152ODX+rfY
	lUbS9EH5P+yswH/1qeaCIQHcg9ISI7QlmWD9docSz3xw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wyq8mwbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 12:57:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47CBfCH8015677;
	Mon, 12 Aug 2024 12:57:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40xm1mec1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 12:57:41 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47CCvXeT53215490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 12:57:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5F262004E;
	Mon, 12 Aug 2024 12:57:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C38AF2004D;
	Mon, 12 Aug 2024 12:57:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Aug 2024 12:57:33 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id 836F2E0443; Mon, 12 Aug 2024 14:57:33 +0200 (CEST)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 0/2] s390/dasd: fixes for data corruption and DMA alignment
Date: Mon, 12 Aug 2024 14:57:31 +0200
Message-ID: <20240812125733.126431-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TdzjEmKIK5l9XAKWwgHP2vI8DDCajKQ5
X-Proofpoint-ORIG-GUID: TdzjEmKIK5l9XAKWwgHP2vI8DDCajKQ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_03,2024-08-12_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=823 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408120095

Hi Jens,

please apply the following two patches that fix two rather severe issues.
The first reverts a DMA alignment patch leading to errors with xfs and 512b
blocksize DASDs.

The second patch fixes a possible data corruption for certain storage
server errors.

Eric Farman (1):
  s390/dasd: Remove DMA alignment

Stefan Haberland (1):
  s390/dasd: fix error recovery leading to data corruption on ESE
    devices

 drivers/s390/block/dasd.c          | 36 ++++++++++++-------
 drivers/s390/block/dasd_3990_erp.c | 10 ++----
 drivers/s390/block/dasd_eckd.c     | 55 +++++++++++++-----------------
 drivers/s390/block/dasd_genhd.c    |  1 -
 drivers/s390/block/dasd_int.h      |  2 +-
 5 files changed, 50 insertions(+), 54 deletions(-)

-- 
2.43.0

