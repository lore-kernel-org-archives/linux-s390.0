Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B70A2D948A;
	Tue, 10 Mar 2026 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773152620; cv=none; b=EcwLJHOcaC6FTll39Y5eHb1Oy923niKvLsFfHoneujj++uLHtOY9HOCWCsGWzmP/lsxlmW6TCrWksTNOng2D6OO3TJ/knxXn94fCGJiJJS4LWglVsO/1c7hKGmUy5FVdPm+RR4YjAxZbJsXYSPGMqaJYPOUP70La4oNkWfvNC5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773152620; c=relaxed/simple;
	bh=QwEIEhdlx5D7ikNi2BOxa5xBwJBHw4pM2I6/2nrsJHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnllDhdVapUPCk1Iv6iUaQCDz6im9ZuQVujKU8ApJrHbgEPnwX1cgGK6MJwGdxf/rR4lI2NipuwiavQFlM4w5p0OjzH8pX+Q4KkyNnY6otsm9I+zr6PVJihmuWmHLQcFAXVZuUXkwJjP7W4CBSI6KFdddYDJIiQ5DpARVQOJZJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H2b2jaH6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H2b2jaH6"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A29dhe219709;
	Tue, 10 Mar 2026 14:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ss6Kwy02HFsVELzfb
	60PjFOA2t8v2FxQCHDMAtQYc+U=; b=H2b2jaH6G8FVel92ru7uYBtJpijDtnwzp
	Wj72ls2EkiFwXZWVJu52rDgV2EQ5zJLtmM0AA9+xPuBY64IydjrRZv2OALdp678x
	4YKWtiVOOmeWU1hULbH+vLWB8uoN51893wBhLv5oaAhlMjdzDKIPo/GXM4FQM3gY
	GlsGUA7f9Kxw4IvQ+3hwqKIR7GUd/dEpYVlsQVXq0w0PV9/5wK8yixt8Ew3Kv6H0
	/L7Yhh1OtPgPN2+0N4ucBqhmUC3QlW786uURBX7TgdeURBIcuw/usE36bH/2rhi2
	VJ4ewtgw1NHL/bgTRaSY4t+7j/XIsngItCBOmlAWFlwdLTa8B0qfw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvmba1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 14:23:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62AAF7bB021168;
	Tue, 10 Mar 2026 14:23:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4crxbssk7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 14:23:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62AENVWk60358940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 14:23:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FC2620040;
	Tue, 10 Mar 2026 14:23:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF65A2004B;
	Tue, 10 Mar 2026 14:23:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 10 Mar 2026 14:23:30 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id D18E4E09C9; Tue, 10 Mar 2026 15:23:30 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/2] s390/dasd: Move quiesce state with pprc swap
Date: Tue, 10 Mar 2026 15:23:29 +0100
Message-ID: <20260310142330.4080106-2-sth@linux.ibm.com>
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
X-Proofpoint-GUID: LdnE6s2kXcB4sS6ij0PnsL1bVUnJM1hd
X-Proofpoint-ORIG-GUID: LdnE6s2kXcB4sS6ij0PnsL1bVUnJM1hd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEyMiBTYWx0ZWRfXw9Pw98jySUVv
 9hkAM6nWoGpi1jfrbcab1YTFuvbMbhF+JkWBb0U2cTlQjPt8gRci8LyDHR7AmWuO6zEuB70Ohj9
 6YrmKYkJ6XvOiUbuPUyQ8GSKeXGl5BoRH4Tzce/6kvub9UkeQ2tjZB5XK8WNPStoMC/JPFX+cMY
 87/VIew6rdg2cXIQYuX2IhuiO0GWn7X6GhZxQvBJOztI/glVr8VfQfcIjoikAVdqVzy/7zw0D7k
 wj7vHUUIR4ImgsjEa7GE5QXsWNaSrNj6rTLUCMz6KjJGE2Nz3yz8yoV1pPQ2zRa22oLft5TIsve
 xLiM0fuYqlxDfkbLp198IPVFG13om56qHaRqFhNkq7p9zg2ESAkD3N1jwFtikUhoPXjAFxW3Vwe
 WuXvm2TI+XSle+TMAkiuf1ukXiJz+PcP4Caodk/SwWP5Kt2rVhtDZ8HvS2/Jh7WuXNycckrIyca
 bNK24vCQO8njSpU13Iw==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69b02969 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=h-oDuFz59Vw_3O1lSLIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100122

Quiesce and resume is a mechanism to suspend operations on DASD devices.
In the context of a controlled copy pair swap operation, the quiesce
operation is usually issued before the actual swap and a resume
afterwards.

During the swap operation, the underlying device is exchanged. Therefore,
the quiesce flag must be moved to the secondary device to ensure a
consistent quiesce state after the swap.

The secondary device itself cannot be suspended separately because there
is no separate block device representation for it.

Fixes: 413862caad6f ("s390/dasd: add copy pair swap capability")
Cc: stable@vger.kernel.org #6.1
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
index cb068d5e2145..2b9a8dd3ea89 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -6182,6 +6182,11 @@ static int dasd_eckd_copy_pair_swap(struct dasd_de=
vice *device, char *prim_busid
 			dev_name(&secondary->cdev->dev), rc);
 	}
=20
+	if (primary->stopped & DASD_STOPPED_QUIESCE) {
+		dasd_device_set_stop_bits(secondary, DASD_STOPPED_QUIESCE);
+		dasd_device_remove_stop_bits(primary, DASD_STOPPED_QUIESCE);
+	}
+
 	/* re-enable device */
 	dasd_device_remove_stop_bits(primary, DASD_STOPPED_PPRC);
 	dasd_device_remove_stop_bits(secondary, DASD_STOPPED_PPRC);
--=20
2.51.0

