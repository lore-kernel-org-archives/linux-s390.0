Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BDB2D24B7;
	Tue, 10 Mar 2026 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773152620; cv=none; b=PiB5KIro8ADYMwoz2N7oruuow0qVN+iMvteFBNlSb6E5Vx8xmkJLZIbj3sZ4gWXRE+5BTtWMPAqo84fFa4d2Zi9j9dWUqUuIxYrbSo5E90CsyLW9i9gUx25Rqxn9ypTHNIrwOI8VZIeqb8UbvkxbnwhFcfUhnapGHrP8q/W+1wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773152620; c=relaxed/simple;
	bh=HNjtuV4XL1ZPZ7Nq/NPAdowqCWZHTVH33YV3PbOJ0FE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olpUDyqWuWr75O/IoGwjM0vCV5qT4bRYc/eNuuNbrh95S1mQl+iByOa6iFf6snr4X5ONf+2rXLcoanDf7T235hgOWJROmcDMtUu+iFniR8VSa44DH/LLF3K1a71d8mImNXK6SWqE9d3Y7B0BW6xHbWV8icVL5Lq3KukZxrY2obU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gfmbYNI+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gfmbYNI+"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A7sRSX1487567;
	Tue, 10 Mar 2026 14:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BPnM7RyR8G4z/GVx8
	bPsr7dWzR0ueXSHMMFCknkoS0E=; b=gfmbYNI+z7Viau5xhir8yd2HtME3PuF3B
	IaoWRB79IFhau+toMI38Xwv/zkWeNty01exiTjDvHhzY7dEo/DheLiUMqY4pOAB8
	sLiWSISwLLVlYDx4U3dd8bvX+E7PeK1SECS+RVmK1ADbSdbbaw7TO7vrr13qzCLs
	udc+WTxrGiNu7rm7+YKKFh+LYeMzfx37+erCVCLdZBIbzg1Bbb+wY6ndGS9IeYHL
	uqlwEOOQ2p0HeJahufl9QkCCHOMYml3kr+5C9qNtK0omb5pXClpKvyt+LbZ+wBNC
	urxP0iqPbAmyjhkURdtKK7io+tVS/N2hpRlv393u/sk5dqZTeM4Xw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcunax58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 14:23:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62ABlHuU015629;
	Tue, 10 Mar 2026 14:23:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4crybn9f5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 14:23:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62AENVTc42533294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 14:23:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C73320043;
	Tue, 10 Mar 2026 14:23:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFCD920040;
	Tue, 10 Mar 2026 14:23:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 10 Mar 2026 14:23:30 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id D5905E09DC; Tue, 10 Mar 2026 15:23:30 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/2] s390/dasd: Copy detected format information to secondary device
Date: Tue, 10 Mar 2026 15:23:30 +0100
Message-ID: <20260310142330.4080106-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310142330.4080106-1-sth@linux.ibm.com>
References: <20260310142330.4080106-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nSH-0CzbScHoqt6YdEF4ECXG72ZdqntZ
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69b02969 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=goixDsshJ461wDGVvzYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEyMiBTYWx0ZWRfX/Z7SNh11hrxn
 bhJJVL5cdjTU+heCQTrEOwW7txWPZqh6XS9VE1w5ZvQu/G/eBoAg6rF3GGJmMRMYUVg5uZ9z97y
 XxxSFuo7dbqW+K1bcN+316nOtAUaEBG4NFT3otsfj7/1KEdlmIxVQR6wcK7pOo80xBl2i9NreRk
 /JQLsCWE8IjVfvyH/YSi/+avrEYK1z2OP2pMhpNFglWGiZLS44aWMfWGvoa3oJfEpSaHfeeYIUH
 Bjo1fswkHk42qVlfn+wOSibWChXoQs0Sg9UoxbWpwcCYPs0hcQOw2RJgfYpRaS0CUuYqIu2Ee/1
 CE1Eja+nVP+4HcObEqPyZLmX/xlOmqxdMIXMFJEAHxKTIMWPgZgjOe6+NidDEBdH7RNMUQMhXOe
 zLV3avhudG617FJ+O1pkfisIZXqyDnd/kljdAPFMs9MfjCnQ1hvnXcK+vGCZyZzhjAZth/dbsn+
 iD3ZTPWj9WQ6mN5o7zg==
X-Proofpoint-ORIG-GUID: nSH-0CzbScHoqt6YdEF4ECXG72ZdqntZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100122

During online processing for a DASD device an IO operation is started to
determine the format of the device. CDL format contains specifically
sized blocks at the beginning of the disk.

For a PPRC secondary device no real IO operation is possible therefore
this IO request can not be started and this step is skipped for online
processing of secondary devices. This is generally fine since the
secondary is a copy of the primary device.

In case of an additional partition detection that is run after a swap
operation the format information is needed to properly drive partition
detection IO.

Currently the information is not passed leading to IO errors during
partition detection and a wrongly detected partition table which in turn
might lead to data corruption on the disk with the wrong partition table.

Fix by passing the format information from primary to secondary device.

Fixes: 413862caad6f ("s390/dasd: add copy pair swap capability")
Cc: stable@vger.kernel.org #6.1
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Acked-by: Eduard Shishkin <edward6@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
index 2b9a8dd3ea89..14e58c336baa 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -6135,6 +6135,7 @@ static void copy_pair_set_active(struct dasd_copy_r=
elation *copy, char *new_busi
 static int dasd_eckd_copy_pair_swap(struct dasd_device *device, char *pr=
im_busid,
 				    char *sec_busid)
 {
+	struct dasd_eckd_private *prim_priv, *sec_priv;
 	struct dasd_device *primary, *secondary;
 	struct dasd_copy_relation *copy;
 	struct dasd_block *block;
@@ -6155,6 +6156,9 @@ static int dasd_eckd_copy_pair_swap(struct dasd_dev=
ice *device, char *prim_busid
 	if (!secondary)
 		return DASD_COPYPAIRSWAP_SECONDARY;
=20
+	prim_priv =3D primary->private;
+	sec_priv =3D secondary->private;
+
 	/*
 	 * usually the device should be quiesced for swap
 	 * for paranoia stop device and requeue requests again
@@ -6187,6 +6191,13 @@ static int dasd_eckd_copy_pair_swap(struct dasd_de=
vice *device, char *prim_busid
 		dasd_device_remove_stop_bits(primary, DASD_STOPPED_QUIESCE);
 	}
=20
+	/*
+	 * The secondary device never got through format detection, but since i=
t
+	 * is a copy of the primary device, the format is exactly the same;
+	 * therefore, the detected layout can simply be copied.
+	 */
+	sec_priv->uses_cdl =3D prim_priv->uses_cdl;
+
 	/* re-enable device */
 	dasd_device_remove_stop_bits(primary, DASD_STOPPED_PPRC);
 	dasd_device_remove_stop_bits(secondary, DASD_STOPPED_PPRC);
--=20
2.51.0

