Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D18537F8C2;
	Tue,  7 Apr 2026 20:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595089; cv=none; b=X8hPn/TTAhs7PZVPNnAVxOQav//TvrcE8IT/xOTMSYC477PA2tpe+XtbzzsejBysMCfiurFv9/6a3tndr9ehTejTb2/fy7Og1Zn3qJ1XrZrq8cDiXagVfvVmTTPpswL1M84KGWk6dLWf963lv7c3Ut6g3p7/EefeAl37ZKkPZu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595089; c=relaxed/simple;
	bh=dxWlG9nzFIojmVMOR+NO1WSb4P+thGLUK1He2jMgkzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbQIvChi1MudDHfgmHx/Cmvag6yptzAeHsOaiC40SYENNzAh5/nFcdWQPxRzWO6DDhrvp2L8wbCeCfwX4FnNGrDTglmJmKInbZ3fjfGKvOFvDU4rfFXhyqpvV+u1SN2mizHGpW5nziijFhAflLhIgd43dsSj305GMHTegr0aWKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UnKma/UX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UnKma/UX"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637EPVUH2592689;
	Tue, 7 Apr 2026 20:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5C/9OTAX4rQEp5N0R
	0Y1TjeKjQLGhzauG7mVwMkO0Yg=; b=UnKma/UX3SHOhJISgny2Vv4Z2krws/P8w
	r8+m0+habVLsJTNlEqh0KvLY4kAGa3bdFTAtXziIo8Mo+IpQm2fLhOXZ616uhTzq
	2Pqn2OI8uR0fasnAKuykA895eqbsjjjgpfmCMgwv601BNU96/3fvZve0pc7vyda6
	+pyIbO6y9qHKgC6BC60iEC0iyWGyuTbHvAXERGrelgTL05902iHV0eYl+JA7Zaxn
	sEEVqbmw37m9iVi/4WqEle5bBhrvW+KQmdu4OVxnTOlGcZyiJ76J4rldEgXAgQfp
	QRQIOekxdfHHshOVOsNpXdEVXNnpnfICVdO/DtmmhtzZcXQ5339+g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2e53bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637Ir575014345;
	Tue, 7 Apr 2026 20:51:21 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg4mtjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:21 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637KpK676685338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 20:51:20 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 756935805B;
	Tue,  7 Apr 2026 20:51:20 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED68F58059;
	Tue,  7 Apr 2026 20:51:18 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.101.194])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 20:51:18 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v2 10/16] s390/vfio-ap: Transition device migration state from RESUMING to STOP
Date: Tue,  7 Apr 2026 16:50:26 -0400
Message-ID: <20260407205100.331150-11-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407205100.331150-1-akrowiak@linux.ibm.com>
References: <20260407205100.331150-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qX07h-KZQGDpP7cOAFIKzD3fk-B0n2ax
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE4OSBTYWx0ZWRfX/co2uADbOYr+
 3lXAbs1mGpe8UvaIJA2KXy/UDfWlmSBQeIEpgetXTxn3YxkV9EssULaoCIAsddX8/71TEYN+hTG
 zs/Rq4cg4CDu515tgQdWCJFnIRk92sWyQhzfa5STPNB+EBaLs373tmR569fCioVHaJ8on8FxFaz
 HG/deWAFmNUxpGxf0J3SPRzvdNF9iuuQkmSRKo4Yy4rH5jvq6uRjiTZgFoYnCxb2ZrV7CfvA8Ox
 XqNn8a+TE0jLpRKcaDh54DwmGSbpRzhXPkgnUNzVYNwzpdVtr/+S0Ysu50vIgitmQmL9+4wnYNF
 dqUUFH5X5BSCPKN63s4BIwS0wkmuzjdk20wcdd6op6oKxisQlMXl8o1viD9bQ/NzPYSOeqoFnbq
 58Jtv31dRcPCutgNrKDO64es/qZUZksWF9V0B5ze/oqXHeRux1IJCTs7i/lsvGVPvAdjOWm3o6v
 Kv1mMdooTsHL3sMakCg==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d56e4a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=15JG798O9DgAUossVzIA:9
X-Proofpoint-GUID: qX07h-KZQGDpP7cOAFIKzD3fk-B0n2ax
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070189

Leaving the RESUMING state terminates a data transfer of the internal
state of the vfio-ap device on the source host to the vfio-ap device on the
target host. This state transition indicates the vfio_ap driver should
complete the incorporation of data written to the data transfer FD into the
into the vfio-ap device. Since a vfio-ap device does not virtualize a
physical device, there is no internal device state to
incorporate; so, the only thing left to do is release the migration files
used to help facilitate the migration process.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index ce16028e50a4..ebb3b78b1e19 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -915,10 +915,20 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 		return migf->filp;
 	}
 
+	/*
+	 * Terminates the data transfer session of the vfio-ap device state
+	 * between the source and target hosts. Since the vfio-ap device does
+	 * not virtualize a DMA device, there is no internal device state to
+	 * incorporate into the vfio-ap device on the target; so, the only
+	 * thing left to do is release the migration files used to process
+	 * the vfio device migration. Note that this state transition is for
+	 * the vfio-ap device on the target host.
+	 */
 	if (cur_state == VFIO_DEVICE_STATE_RESUMING &&
 	    new_state == VFIO_DEVICE_STATE_STOP) {
-		/* TODO */
-		return ERR_PTR(-EOPNOTSUPP);
+		vfio_ap_release_mig_files(matrix_mdev);
+
+		return NULL;
 	}
 
 	if (cur_state == VFIO_DEVICE_STATE_STOP_COPY &&
-- 
2.52.0

