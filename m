Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06B3403AF6;
	Tue, 30 Jun 2026 10:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816116; cv=none; b=Gyji8pS2Z5Fzb3fBPtkvzNOCS6YFG/RmW4DRng0gxCxr/jBjlhCCYhfWy9ABQ0qKm/9ptR7sIg/C+J81J3wbJe2I5uQvWxhRnGe3gUZpXnf3T6iBWMSWd5nQPlmKJ3/CRVGGb5KtwXcad1dCNrq+W4AYnOF4ppexnbgmkFkBiek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816116; c=relaxed/simple;
	bh=CnwfUShl+781YewdbyFQPMzLuUGHF67C2kz1wc2KhA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvdCTd87gYW+FTEigUUpiXRolF5Sfj5QbGfLtQViZuYqe7fCBcqs4vI6t0qW92w8RuwbkKFa17ZuS02VPYMrEgW8tAai4bUIjyed441J03lN7rVg0F6he+ybq5cHxBOn+WQys6cAFc7CmBalcpVuTZgjnU0bqPuAlSC6vmkQIjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ILJCurHq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ILJCurHq"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9nPkn1535460;
	Tue, 30 Jun 2026 10:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Lq2lBdNqeG6w9qTJ4
	7KsHV9Y/unReGP2HgotJX811z0=; b=ILJCurHq6Ifu9E7zGFmjIEEyCpHj+yynt
	Zgl/rKKFeLJtl8WGvgBMdNy67EglpTSJVtlci/LQoLdQ+Y1twWoGWwA9D1p4xDCp
	mWgMNHZr8WedjNLtdek1vY48f5YOMAemOfi1VLd57Eb+gUV84w8cQyYKrYgjHjeH
	WDoxfk7jUkMLndZ8JBgLAgQkC05+2Ah2MJwEpJuPpjS9tMazMBoIazl9+MRtw40n
	Xa01j4HbkNXYTJ/2rwe8y+twGP7olqQV+aueBX7j19y3lOI+V1poCiSDnJfly1cC
	8S55FoKaMBQm6O7HSpiiMozzK6xxb8GvE4oQmozKoYDKLAROop2/w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjnwxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:41:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UAYcTO031369;
	Tue, 30 Jun 2026 10:41:48 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2g9j4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:41:48 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UAfkcI2491350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 10:41:47 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE7DA58056;
	Tue, 30 Jun 2026 10:41:46 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF85A5805D;
	Tue, 30 Jun 2026 10:41:45 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.135.84])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 10:41:45 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v3 11/15] s390/vfio-ap: Transition device migration state to STOP
Date: Tue, 30 Jun 2026 06:41:21 -0400
Message-ID: <20260630104132.1598851-12-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
References: <20260630104132.1598851-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfXyuCTRkvV6tjI
 U/tj+8/YJeVHuVzaNDbmxTH/y5I+yrQa5CcljvaUbpPu+ih8fm3wElsaDYHwi5477ZuKXkWTjd9
 hLPFKlMwnuswbKg3WxFaoBXyeqevzFuB+zGVz8O9fprqjmXlHTEE1/8eQkaPmanTjfLGWTrhKuX
 igmTivC83/kdq1RAx6sj8J4R1cf7w7rsncvPo1xgyvoxgd4Ldp9b1wo4LXDJdXkEZwSE3m/zy03
 gDu6Yb6mYhGmeY59Q5cf3fbK7znCj70XlbFHSV0Ol1QO3Bh92Ppx7Oy4bstoRHmJ/oOrXTKKzQN
 BfBKCDIfG0XFPAC6nDrK/854r7xaD9Sj/jtQftjYUOx4fBxBoPmZIPqCYWlZROA28YvpWhSa0yz
 x9e/hwSsI5Ee/UBCmBLCXcMFS/vdIqsiczataZ4ahDJq91Anm1vzPz3b4jEYjVtT/9YAFv43g1J
 hiHvmw8qytaW1UKEkCA==
X-Proofpoint-GUID: UoaD777yejg-0P3CK_iraZ_LlgqXuzbo
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a439d6d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=LlGlNFsFWGapDO07ubkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX1DASEbjXDHAq
 cCDAe07gww7upT0qMul9nQ9dpnSlKdaOYsG422bnN1spQMFy+lEy7PLeqBCFs46+oPzDaZkkb+7
 7ZOuUysSZYV0g7t+Ws7wb5dF0ydYByk=
X-Proofpoint-ORIG-GUID: UoaD777yejg-0P3CK_iraZ_LlgqXuzbo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300093

Typically at this point, interrupt processing for the device, DMA and other
changes to the device's external state must be prohibited. For VFIO AP,
there is no physical DMA device virtualized by the vfio-ap device . It
merely manages the guest's AP configuration that identifies the devices
passed through to the guest, but does not have access to any of them. Those
AP devices are passed through and controlled exclusively by the SIE program
used to start the guest. There  only thing to do at this point is return
NULL to the caller since the file streams and associated data will get
cleaned up as a result of the VFIO migration framework releasing the files.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 9cd1e7a3f743..1b526b743ad0 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -1159,12 +1159,17 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 		return filp;
 	}
 
+	/*
+	 * Terminates the data transfer session of the vfio-ap device state
+	 * between the source and target hosts. Since the vfio-ap device does
+	 * not virtualize a DMA device, there is no internal device state to
+	 * incorporate into the vfio-ap device on the target.
+	 */
 	if ((cur_state == VFIO_DEVICE_STATE_RESUMING &&
 	     new_state == VFIO_DEVICE_STATE_STOP) ||
 	    (cur_state == VFIO_DEVICE_STATE_STOP_COPY &&
 	     new_state == VFIO_DEVICE_STATE_STOP)) {
-		/* TODO */
-		return ERR_PTR(-EOPNOTSUPP);
+		return NULL;
 	}
 
 	if ((cur_state == VFIO_DEVICE_STATE_STOP &&
-- 
2.53.0

