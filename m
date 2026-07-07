Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AEE3B7B99;
	Tue,  7 Jul 2026 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414973; cv=none; b=BjqNKip4R5CMr1OV2cOF72mVD6NvnwiLr+8CFsShxluMprnPW5xW8OO5u9+5JyiqNaZohlD9u3pLFqUoeVZ4fFhdZpKUG9MUduyIsDSf6PvOuGTvVkoWJ3XjxunKZGx2RGZIKBOrRZauMoCMH1XvL6Ll/OEvtaTNsn0n8UEC8Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414973; c=relaxed/simple;
	bh=xB3GgYxsOVHpsRHzGPLrssNJvgNJgiFQHSO0Wi+PH2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5AhxKhrTKKg0H4fZZkCSFpQlClCzG73a1VKMkI3mSFG7uE4mx7DYFlEHuYTjKm4bp9qIwF9NS0e6EaIkRGnOSFxwlqbXCtep+vIr3hze9CUj9/DcyAUnV06FoRGXg5Xwca2mPd4K7mwMm77gTGe38hiyo8fNIpjwOQTz0J1ep8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a1nN/HKa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a1nN/HKa"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678IOpG3011794;
	Tue, 7 Jul 2026 09:02:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Z+YLtARUaaC/uHSzj
	T7Z5DdhWlNW16W/feL157is7pE=; b=a1nN/HKaBbcA3Ev0Vlr1eukJGS9zHsUg+
	YkI+/9pwg1oBAb/i/opHAySUm7cKnQsNQnBD/F5qz8myFaF/dzxfUMgnn3PpRrS/
	wLOO+vRbVKFEU0I/sdHcMs1Rp89M9Xa9m2dgNysl+zPjfYhTvbL0NS44BpF356cm
	cVsmMRh5eBceHYkQbiZMANDJhxLKQWul75gZKPlmjKEFfBDCvMqz99VeS49d3sSy
	us38N00GAHJzs6TxfcM/Ilo6681FZjNy1F9sXRfPoLOHwLvtncTcEZ7gBOvDuQjo
	tV7TmOAjd9AHgYDgtk5y5HRgZDuxYbHIIhvRNvByADPRYT9sAqCfA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3p8st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6678wngo024249;
	Tue, 7 Jul 2026 09:02:45 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvw23fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:45 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66792h5N10355214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 09:02:43 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86E5858063;
	Tue,  7 Jul 2026 09:02:43 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63C9758056;
	Tue,  7 Jul 2026 09:02:42 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.160.85])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 09:02:42 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v4 12/15] s390/vfio-ap: Transition device migration state from STOP to RUNNING and vice versa
Date: Tue,  7 Jul 2026 05:02:14 -0400
Message-ID: <20260707090226.3206695-13-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
References: <20260707090226.3206695-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4cc0b6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=YI3AHy_hWZklpQ5N57sA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX2lRYIt3n1fNY
 LIPaXnfttVpjj8GOoVj5m7a8gwWccKl4pmZKRR2m7/jAKt35rwqNqssJSw5yaOznbLbxe+7mvH0
 Bl0yG2dZ2VN2mPuCXN5kpt8qykBZjZk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX5N2TrZygGqRZ
 us0EXMNkLXvDaKoXXzgFjI+nfKZnvxbstEuHZOjCGEgSFm08hqFb1uIbQj4KOc53Y5j3rHAvdXe
 Fp0AYu3j3l5wcVRPow10XsPsPuNIbVMnA10ccaFW2J+CKc8qsn9QWMXz78qhU0hDrDZvoHCA9kc
 okzk+Cd2jdAKD9rzVJrhr5G7IsK2MlY8zSWQSt1sWLJqxVe1GkUTAq4DilNU5oUcUz8exyDsyge
 83xDPYudY+gW+1phSTZV26QXyTQbmA2iMvh2x4thTmWtgzKrzLw0exjrmGSSItzGIDADtI6z9R6
 /oXCn6IataB7C+MdJcv/TkwYR97WCBdoZlVgsmR6ZmqelvgUEEQRpVO9Ej3mNugO/CQvkya5pqE
 fK6ci3dMnL2DXQ4ymP0xU6Bb3OqqrU+fK3OIzKm65f+3qIwo9izvM5DUYfy6EpFAsZsbffHa1KP
 Y9ihmj0uplLr7gn9sTA==
X-Proofpoint-ORIG-GUID: qxh62qnMhquOVfCrJ7Zr-xdi-7mXYJ7o
X-Proofpoint-GUID: qxh62qnMhquOVfCrJ7Zr-xdi-7mXYJ7o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070084

The transition from STOP to RUNNING and vice versa indicates that
the vfio device is operating normally and migration is not
currently taking place. In this case, just set the new state.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index 1b526b743ad0..572db04c4ac1 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -1172,12 +1172,17 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 		return NULL;
 	}
 
+	/*
+	 * These states indicate migration has either not been initiated or
+	 * has completed and the vfio-ap device is operating normally.Since the
+	 * vfio-ap device does not virtualize a DMA device, there is no internal
+	 * device state to incorporate into the vfio-ap device on the target.
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
2.53.0

