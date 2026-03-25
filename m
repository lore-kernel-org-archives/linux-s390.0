Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A2432FA29;
	Wed, 25 Mar 2026 21:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472549; cv=none; b=bNrS/ThTNuoMkDWSbOASyQr69K9RhMNpi3uN1PQodHS44ypHdzK7goBEWlF7UZoUR+aYHi+llEAb2dJ2i9ufPCCUw+ZJ2RjW3ydhz0T2j+KL6SOF5ydCTihBOkvubk75XCCKjlJFp7abv9eI2b8eNIFyEeHJqpynXiGeS6UYt0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472549; c=relaxed/simple;
	bh=ZWgq5gmFkF1ib2CmNhxe/VmwrHzB9PgL6nHBhck+q2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nti1dQoRvNxrbqQE5IwPPUDT1kUtEEtbTTKPyYSZ6wLgtYuBdIOiIV9/NvdHWT/u94aQQCjDzVfzNaRLgFp2iPK1UU4T102Yr5DFlpqPw+cJJtjYxaIR3J22Rq8tQoySQ6CDF+nFO6/s2tsZBJZdDdOnwhdlhGAok/jJ+goxHl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kwmfNCn2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kwmfNCn2"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PAbRUv657177;
	Wed, 25 Mar 2026 21:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qswCz1UpnVnJiDCZx
	7upZEgt/WaJPR3f9D8fTs/6+uI=; b=kwmfNCn2JdA4AInKmozCifMeFCzCunFmd
	i0i0KVnZscwDRsYOSNUDkELEn832YY9Kz4nAALs7RLI8EZQGMnxoPzfBsU3ouHEr
	0K2irE3bvIBsNB4PljsGCkkKTMbrTaoIz6KV5TjXZcdnzjYx3XbAMrD6A22a4Xh8
	66gOvLu1R9HcmNzKs2VS7RtotQ5mItqNaXq/D3IY/kbmi0L2EQTb4LiQie7uApf6
	+oTMcQYmQcPSa68cvGkhlNrwfsakLH8vfwvApy7gBP2M83arlTHRGrw2ObEX9os9
	El2c6zSEjN8I45nBLwPDxsM7seVxrptC8nSW2ZQt33v46ToDON42A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kty2cbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PKBGnE012213;
	Wed, 25 Mar 2026 21:02:14 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk817s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:14 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PL2CkH11207256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 21:02:12 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82DF458052;
	Wed, 25 Mar 2026 21:02:12 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B2FF5805D;
	Wed, 25 Mar 2026 21:02:11 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.136.69])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 21:02:11 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Subject: [PATCH v1 19/24] s390/vfio-ap: Transition device migration state from STOP to RUNNING and vice versa
Date: Wed, 25 Mar 2026 17:01:06 -0400
Message-ID: <20260325210149.888028-20-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260325210149.888028-1-akrowiak@linux.ibm.com>
References: <20260325210149.888028-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c44d56 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=YI3AHy_hWZklpQ5N57sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0OSBTYWx0ZWRfXywJyEeAcBpGx
 9Eadaszmxj0guwYSQjWsE+uMmiLBlBmL94Z0SHSgQHf2pMPW8iMesknOESbu1HjmqmlUZc89q4g
 aivNdbZRhPWzd1GlrkS30xgLgg39bsSiIHH1s9w+OUIEvXsDIXbp574Od/hVHOqAlDSp08cjqx1
 wzTfjEgTk8YXsYJntlq0fz75YMxVmBlH9SEXcNLJu8zJdRTgvT8fW3oGrb6cDCJGN34+EhcUAzU
 0NQvkM13vi2mubJvvAhEewySMNeEt5dU6R0AY79+lkiOtqtp1uYwevUcOQ70bmOEDXtLvrQiN3B
 +uxQUOrn1Zz+ep7KXQ/ir0QXcPEp0MpClOCzF2plVXQfsYR+h9vrlC8bpW3psJzAOqCrbzNgH/S
 SjskK0Dk0D32xbz+oOhFe16GbSMldb2xlTlv3f4Vpapgd4oIX9oISfMwl2PB3CovrWxqbPGuTwO
 ibHtyIIy2hw5u8TkE5g==
X-Proofpoint-GUID: tdCv9LbScMba0AP546GH4Q_aJ_-0vGFx
X-Proofpoint-ORIG-GUID: tdCv9LbScMba0AP546GH4Q_aJ_-0vGFx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250149

The transition from STOP to RUNNING and vice versa indicates that
the vfio device is operating normally and migration is not
currently taking place. In this case, just set the new state and
if there are any migrations files used to help facilitate migration
hanging around, release them.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index c6e01294be7f..750299fb1a84 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -951,12 +951,18 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 		return NULL;
 	}
 
+	/*
+	 * These states indicates migration has either not been initiated or
+	 * has completed and the vfio-ap device is operating normally; so
+	 * just set the new migration state. Just in case, release the
+	 * migration files used to facilitate migration if any are hanging
+	 * around.
+	 */
 	if ((cur_state == VFIO_DEVICE_STATE_STOP &&
 	     new_state == VFIO_DEVICE_STATE_RUNNING) ||
 	    (cur_state == VFIO_DEVICE_STATE_RUNNING &&
 	     new_state == VFIO_DEVICE_STATE_STOP)) {
-		/* TODO */
-		return ERR_PTR(-EOPNOTSUPP);
+		return NULL;
 	}
 
 	/* vfio_mig_get_next_state() does not use arcs other than the above */
-- 
2.52.0

