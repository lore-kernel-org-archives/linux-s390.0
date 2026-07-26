Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BF02F8EA1;
	Sun, 26 Jul 2026 04:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785038500; cv=none; b=ikGfb2P/8sojfi7wJhTQ/PibVzwiDgQNG1DSRhQ//wQDHeZXPQSnbmdrf5beZjeR9SxdlU+benKJ3yZmBlXoYT37RmkRnthYuwR0RcX38MBnuFdHO8mC9iN36g1w37nAP1ynBBcHKtlZ02v/yZGPyiCAY/X4DNj/rnyS7rebiS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785038500; c=relaxed/simple;
	bh=eMlejfZUBSlNBzFgb3SweQJBV0sNnY39er5kEIZ15GI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxIHBRueDsqU4dkVIi1ZuuTt+rYqnF9hzHymEbm+/Z3+7tSGUXWZo1ONNZ3SR2zmQq5PyLHE43AbJbfChPL6gcfruJ0z66rXUl/zySVFEzSryHE31531SIPU9GCvZQ+TesLcu9iBSJt4gJ5p07F4fR1NZ10EcejZT9LaOxVsXzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sM/ASxmc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sM/ASxmc"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PNHgiB1833315;
	Sun, 26 Jul 2026 04:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PpZ0z+oArriQBYnzx
	T5+eDsZxftArVXvzUwtV8YMvYg=; b=sM/ASxmcyf8Kwe+J9hYoitXtte9jssn1V
	1mSTsPviBDDyDts1syHsQkC7WsvehpIHm+jEFrMxEnZIxVfzz+Ki+WyJW8Y9v3Q5
	LffRUmj18WSZx1k7934SFdpiJzO5lGwbws5my+4mO4dCx+CdtaKeDJLPiO9tE5HQ
	xcJ1RNer/nQUJnZmf5/SG3ks6pY00NFkIe1DfnH2g/oRT2rc+PnEyuwhJ4FfXYUP
	p99JtFiLVg3QuOHeok6ZxndBstXq5/TwtrDw6QmEAyPiyPfOdzBzq0/yHdwkBO7N
	lLwTggpxWQ4h2FNE7pDxXZR3VVdRJKbIArLk2I/+zmO4Blf7ggong==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyht7ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 04:01:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66Q3uarp006056;
	Sun, 26 Jul 2026 04:01:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg054k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 04:01:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66Q41WDj51773950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jul 2026 04:01:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 910A0200C9;
	Sun, 26 Jul 2026 04:01:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B9F2200C8;
	Sun, 26 Jul 2026 04:01:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sun, 26 Jul 2026 04:01:32 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 29CDF16281B; Sun, 26 Jul 2026 06:01:32 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v5 07/10] s390/vfio_ccw: cancel existing workqueues
Date: Sun, 26 Jul 2026 06:01:26 +0200
Message-ID: <20260726040129.2946151-8-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726040129.2946151-1-farman@linux.ibm.com>
References: <20260726040129.2946151-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDAzMyBTYWx0ZWRfX0aiej5NT6QEw
 SOQGkEoPNXxkBE3Lv5vB33HyufLg4hLkOPfWQIsxnRbRNprH3NA3vhShCiXYSGCnBSVTPp5qyxT
 /RPAwDB+PhwR/a9fdyGeVu9xEfL6kCg=
X-Proofpoint-GUID: VsHHRTlkPTuCiRM004Mi6BCeXdQgzCdP
X-Proofpoint-ORIG-GUID: VsHHRTlkPTuCiRM004Mi6BCeXdQgzCdP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDAzMyBTYWx0ZWRfX3oqOTLmmry4d
 3g7vR52OZm6l6IoZH5aTXgfIJ2ZIrndg0flynpHP7QcA2bc6rF0X1JpOMyksfZqPGCJzyoT5mzF
 FhmbEnvXD7DLfxXbByfuGcaPZP5RoGFt5SAI4Bw+kN5CbPlLphe+Mf8DuXqgit2Qud6leczchyD
 BmGEsJmPm/QeJsSusR2ttQbOxOTKsRPBUg8GwBN6N2QZIgWuc7AkdItyzsadH42F4WtjdKnLg03
 q4iIaZsxW7BFv7hwQDTDJPn+Yu0ZnRqaZgdxgOtoPuZLu2YToNy7PsK9tt+jrBoq0ut5L7v6Kv9
 IbcuY9hyS8gGhvH06Uqfqr6yppWqoIJlFbEloH2Xi8hylND+w/Ko5g5qJyKfwuPydyoHdah5TOc
 G5W0ffyfCZtDd4ZpHk5wDT0Pj0Iufeh+dg55aBXFj2UoxYcDKUyENieLctILAFF94QHPymkm98S
 mTUO3CNT09I7ZHH+USw==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6586a1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=xt5PtEg-49noLGkpZzoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_07,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607260033

The initialization of the io_work and crw_work workqueues begs the
question of whether they should be un-initialized. Add the corresponding
cleanup tags in _release_dev to ensure work isn't dispatched after
the private struct is free'd.

Suggested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Fixes: e5f84dbaea59 ("vfio: ccw: return I/O results asynchronously")
Fixes: 3f02cb2fd9d2 ("vfio-ccw: Wire up the CRW irq and CRW region")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_ops.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
index 032a1cdf4df7..9048c1e6e7f0 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -136,6 +136,9 @@ static void vfio_ccw_mdev_release_dev(struct vfio_dev=
ice *vdev)
 		kfree(crw);
 	}
=20
+	cancel_work_sync(&private->io_work);
+	cancel_work_sync(&private->crw_work);
+
 	kmem_cache_free(vfio_ccw_crw_region, private->crw_region);
 	kmem_cache_free(vfio_ccw_schib_region, private->schib_region);
 	kmem_cache_free(vfio_ccw_cmd_region, private->cmd_region);
--=20
2.53.0

