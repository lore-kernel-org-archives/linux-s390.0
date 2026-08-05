Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259F3434E25;
	Wed,  5 Aug 2026 11:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928590; cv=none; b=m0X5J9WnIV1pTtJ6HNjH9UlHUBW+N3XYq6gWGCDfhvkdKJ1XlmWWEzlv3byzCVYMx5ShWoaiU+lUvRJTwEVwK/eVj22pk2h8MHgZZbBK+rovxSk4Nt0q4VlBYnv3LbohSDQ7hxJkmf7CbcTQgRt8RznyFPi3RIeKTLcNGXB+uqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928590; c=relaxed/simple;
	bh=NhEX7f66FAvbY4nTjLsE6Vk37mp65EnNLqH9l90oSlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mSsiSC6l8YDoWIkGCFdE59kGR2QkDV1ySJpOyt6PgX58Yhnih4oFatGZOIwzy6q/YrBXdhAUn+9h14vX8SSHK0ZzT4/1aVxd9JbPwGidboEdHLiKsXVhalPY2VOOgka7GV8mIhOzZ5Jf4EX6AlL75ZSXmC4x7B/mjKuni6P1KXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gjd0OIoP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gjd0OIoP"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758ldIB3288595;
	Wed, 5 Aug 2026 11:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=dQ6BneGn+PwJ+ou7Tmk+glhU0Kra
	bKXkLhOmrx6hQQo=; b=gjd0OIoPNYfTt/QxqxLfOUIEpOn68b1nmZ99NFfl+ejG
	+fsZfcUTP9c0WPKTosZFds0J9EXavTw0NoPgjitK5HqSbEky64lb+aCufv7Ur1Yh
	7jPxM1RaqoZYCfvhy07gs7aIgr6KVuhqyuuzLst/E/KS5T9Pu+l7ZrA/4bCq7l8X
	Ay50uXWDA74QTRvpXYrgBed4mg26953Cyd21q+fgodoytp7OPg97guAeEySSPo0u
	xvSecaOjmivzOjrzNd8x6sr/VG1njzx28z/DZWwHaqhUxj3gf1EN8hpPo6SqHMKd
	XD9oGKGXS5SjZbkiJaKr9lCgBjHR4+dGQpCSgHLVUw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67htg7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675AfUsS006267;
	Wed, 5 Aug 2026 11:16:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k685e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675BGGj414614818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:16:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB0E02004B;
	Wed,  5 Aug 2026 11:16:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8931C20043;
	Wed,  5 Aug 2026 11:16:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:16:16 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 00/19] s390/dasd: ESE Performance improvements
Date: Wed,  5 Aug 2026 13:15:53 +0200
Message-ID: <20260805111612.1285190-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX5nDwAASN9dEy
 EWQ4E3qcQ1hxphnoQbtfOPGedskJ9JudEDi54V35x42QiZQgZLmaES5ukpAdrA+MkMzo4f30vDG
 T3AfDz5Ywsr3yy4NRBNvnRcnp5woyN4=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a731b87 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=t28pj-9J3ZLch6uOkvsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX28hoe/45jKgE
 54gz/fOWCVyfhstofR/JkIBOPahmQtzSEHFURQpS5+Nv1/NcsqtyIMydvcKJaLgqI9h6syetqbF
 o7bWfHTg3SZzrkwThFLHRt71vgnKjCGJXPZAYhNqfWLfzqmGpCE6v8yKCgfXtO4xmTY3an1YORF
 Pwi7XSj2Y3K3LneosWYeTI3iC5S/rEpoojPDB7FBbANNIPtg8nmmhIY+6UxoAfQWAUlcn/Gjfc4
 /8Ir/XkX86Su37hFAFgwC4msd4XK4OpKEzpcmU/8sqqxRgodshCuzfv/4QRzqO6t6pfmDd6gIsj
 A1T+r9VK/ukVL9NLMeVuzIUQJkE1YYd1WEY8rePkV3wZeu4DTgthqU2X1bmmMrzamnfvNZyG+Ih
 zMizw6hRss7Y7b+623zAslzh34iUC2RpQ91SGG8oWUe1AsD5ZO7HVlfPSRsCjBgso9Q9X7eWes+
 OJD0DInyOQW0wqzmd5w==
X-Proofpoint-ORIG-GUID: ZpDV9ITBhx8CayN_f8hhgz1MkYo6Lg7N
X-Proofpoint-GUID: ZpDV9ITBhx8CayN_f8hhgz1MkYo6Lg7N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050086

Hello Jens,

please apply the patch series for the upcoming merge window.
It applies onto your for-next branch.

The series significantly improves the performance and overall usability of
Extent Space Efficient (ESE, aka thin provisioned) DASD devices.

On a freshly provisioned ESE volume I get the following throughput
improvements, depending on workload and setup:

    workload                        change
    raw seq 1 MiB writes             ~53x
    fs bulk-load (xfs, buffered)     ~49x
    raw seq full-track (48k)        ~3.7x
    raw random 4k writes            ~1.3x
    control: fully-allocated vol      ~0% (no regression)
(fresh quick-formatted ESE volume, 4 jobs, iodepth 16, median of 3)

The first 4 patches are fixes for existing bugs in this area, afterwards
the infrastructure for and usage of Full Track Writes is added to the
driver as well as an improved collision detection. The other patches add
some tuning parameters and output as well as a new on disk format label.

FWIW: The series has been reviewed by Sashiko before. The remaining
findings are pre existing bugs that will be assessed and addressed
separately, false positives that are not a bug or not valid for ECKD
DASD devices, in-between-patch findings that are resolved at the tip
of the series, or accepted limitations.

Thanks,
Stefan

Stefan Haberland (19):
  s390/dasd: Do not complete a failed ESE read as successful
  s390/dasd: Propagate partial completion length across ERP recovery
  s390/dasd: Guard sysfs discipline callbacks against unallocated
    private data
  s390/dasd: Snapshot intrc before freeing the request block
  s390/dasd: Optimize max blocks per request for track alignment
  s390/dasd: Use GFP_KERNEL in dasd_alloc_device()
  s390/dasd: Add defines for the Extended Address Volume track address
  s390/dasd: Add infrastructure for ESE full-track write
  s390/dasd: Add range-based format-track collision detection
  s390/dasd: Extend prepare_itcw() to support WRITE_FULL_TRACK
  s390/dasd: Add dasd_eckd_build_cp_tpm_writefulltrack()
  s390/dasd: Use WRITE_FULL_TRACK in ESE format handler
  s390/dasd: Add full_track_bias to control fulltrack write mode
  s390/dasd: Derive adaptive ESE fulltrack heuristic from ft_bias
  s390/dasd: Stamp a format label into newly formatted volumes
  s390/dasd: Detect ESE volumes from the on-disk format label
  s390/dasd: Report ESE capability and format mode at device online
  s390/dasd: Re-enable discard support for ESE volumes
  s390/dasd: Read cached unit address and LSS in the CCW build path

 drivers/s390/block/dasd.c          |  242 ++++--
 drivers/s390/block/dasd_3990_erp.c |    1 +
 drivers/s390/block/dasd_devmap.c   |   90 +-
 drivers/s390/block/dasd_eckd.c     | 1263 +++++++++++++++++++++++++---
 drivers/s390/block/dasd_eckd.h     |   68 +-
 drivers/s390/block/dasd_erp.c      |   11 +-
 drivers/s390/block/dasd_int.h      |  149 +++-
 7 files changed, 1625 insertions(+), 199 deletions(-)

-- 
2.53.0

