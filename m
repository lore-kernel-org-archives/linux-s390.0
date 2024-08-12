Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AC017C7B1;
	Mon, 12 Aug 2024 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723467468; cv=none; b=YYfkz6rNLw9jFYLR9oDD1Zhk0l2K5qO7cxcpClpthyitoayZOo2oXgvDpTYfHAu/pqfndXHjKn5Eh5hSFmw+T8HZF9R4GBrHHkkW+yQBalrYoRd4XxN0EYH46kwTbNlukXC/UyucmkaleKqe7LdKcdwesXGfQNtp9LMarFUhH2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723467468; c=relaxed/simple;
	bh=gX/vHQeDBJlfXCl5aTRNy4T8+8JUeBGT4K0joi2PjkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cs31PC3Bn7ztT7lu9DnD+SMJlgQbb7iQ8nMNNTff2W5l5WunDsELcNk4cV0AGzk+U4yav/9KePG++dlNNZaENg598QeSeCVuZIu8K8SfAjV10ikTlmjS9ZpKJrjGhjjQqbljW8U5pbpRYNA3r0rM8kP6Fxr4mWxL5wNcq6ZRueM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tVB6kiGc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tVB6kiGc"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CBuK3M003046;
	Mon, 12 Aug 2024 12:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=cdELfOJH54nQ3
	edHTABLEUX3OsbNhMl81VRezeLq49o=; b=tVB6kiGcbj9WyGB1ESzlKezoWC7dE
	GzhhOri6Q6k4VG+gQ0KZ3zC3nXMFo+nQzcmogBGNhZP+2qqsFfXvqzjE0ymfqxSe
	0/ZCwcgLTiR8EFr5xZT1AxT32Ppy5KhT9Eo4P+h6hnPFdDmks7aAkZX4dDO7l4fJ
	aV5gJKKVTpL+8Wb4WbZavbSA6s8W8uUhpLsGkAkw2NZW+uWiFcnkzN/q65Xx7zFL
	JaU22s9kcq2ur0X96bFvXhCZpjXmvD73RlIg/fB7vh9XYezrvooZlUgQJPNGr5jW
	bDSgCk1Jc+1tNA/tHuf3RPz4PAPuK5ETS28ptBwjBrJzKZS+AXoDTJcfA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wyvvvuxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 12:57:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47CAi9af010055;
	Mon, 12 Aug 2024 12:57:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40xjx0ekm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 12:57:41 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47CCvXcB44695980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 12:57:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF50B2004D;
	Mon, 12 Aug 2024 12:57:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE8D72004B;
	Mon, 12 Aug 2024 12:57:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Aug 2024 12:57:33 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id 85D42E0445; Mon, 12 Aug 2024 14:57:33 +0200 (CEST)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 1/2] s390/dasd: Remove DMA alignment
Date: Mon, 12 Aug 2024 14:57:32 +0200
Message-ID: <20240812125733.126431-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812125733.126431-1-sth@linux.ibm.com>
References: <20240812125733.126431-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cPkXvuv9UDpuzcWbjsFDO85rVgDh5KDx
X-Proofpoint-GUID: cPkXvuv9UDpuzcWbjsFDO85rVgDh5KDx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_03,2024-08-12_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408120095

From: Eric Farman <farman@linux.ibm.com>

This reverts commit bc792884b76f ("s390/dasd: Establish DMA alignment").

Quoting the original commit:
    linux-next commit bf8d08532bc1 ("iomap: add support for dma aligned
    direct-io") changes the alignment requirement to come from the block
    device rather than the block size, and the default alignment
    requirement is 512-byte boundaries. Since DASD I/O has page
    alignments for IDAW/TIDAW requests, let's override this value to
    restore the expected behavior.

I mentioned TIDAW, but that was wrong. TIDAWs have no distinct alignment
requirement (per p. 15-70 of POPS SA22-7832-13):

   Unless otherwise specified, TIDAWs may designate
   a block of main storage on any boundary and length
   up to 4K bytes, provided the specified block does not
   cross a 4 K-byte boundary.

IDAWs do, but the original commit neglected that while ECKD DASD are
typically formatted in 4096-byte blocks, they don't HAVE to be. Formatting
an ECKD volume with smaller blocks is permitted (dasdfmt -b xxx), and the
problematic commit enforces alignment properties to such a device that
will result in errors, such as:

   [test@host ~]# lsdasd -l a367 | grep blksz
     blksz:				512
   [test@host ~]# mkfs.xfs -f /dev/disk/by-path/ccw-0.0.a367-part1
   meta-data=/dev/dasdc1            isize=512    agcount=4, agsize=230075 blks
            =                       sectsz=512   attr=2, projid32bit=1
            =                       crc=1        finobt=1, sparse=1, rmapbt=1
            =                       reflink=1    bigtime=1 inobtcount=1 nrext64=1
   data     =                       bsize=4096   blocks=920299, imaxpct=25
            =                       sunit=0      swidth=0 blks
   naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
   log      =internal log           bsize=4096   blocks=16384, version=2
            =                       sectsz=512   sunit=0 blks, lazy-count=1
   realtime =none                   extsz=4096   blocks=0, rtextents=0
   error reading existing superblock: Invalid argument
   mkfs.xfs: pwrite failed: Invalid argument
   libxfs_bwrite: write failed on (unknown) bno 0x70565c/0x100, err=22
   mkfs.xfs: Releasing dirty buffer to free list!
   found dirty buffer (bulk) on free list!
   mkfs.xfs: pwrite failed: Invalid argument
   ...snipped...

The original commit omitted the FBA discipline for just this reason,
but the formatted block size of the other disciplines was overlooked.
The solution to all of this is to revert to the original behavior,
such that the block size can be respected. There were two commits [1]
that moved this code in the interim, so a straight git-revert is not
possible, but the change is straightforward.

But what of the original problem? That was manifested with a direct-io
QEMU guest, where QEMU itself was changed a month or two later with
commit 25474d90aa ("block: use the request length for iov alignment")
such that the blamed kernel commit is unnecessary.

[1] commit 0127a47f58c6 ("dasd: move queue setup to common code")
    commit fde07a4d74e3 ("dasd: use the atomic queue limits API")

Fixes: bc792884b76f ("s390/dasd: Establish DMA alignment")
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_genhd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 1aa426b1dedd..6da47a65af61 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -41,7 +41,6 @@ int dasd_gendisk_alloc(struct dasd_block *block)
 		 */
 		.max_segment_size = PAGE_SIZE,
 		.seg_boundary_mask = PAGE_SIZE - 1,
-		.dma_alignment = PAGE_SIZE - 1,
 		.max_segments = USHRT_MAX,
 	};
 	struct gendisk *gdp;
-- 
2.43.0

