Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262613B19B2;
	Tue,  7 Jul 2026 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414970; cv=none; b=qYUcIA1WnzBc7CEgA0N36cas5IWBsNTrUEYFI0bOsi3RNYD7wWAifvdripH7e7tazFH3QSzg+LCm3ts2r8P7f3w/8+kdcQb4vzAHc8xgg3YiOeEL/fcpp9fzieyhzGAZHRG0M0SWG0TlFCIyo8u+oBiU+DgMf5LisDlksIhrJXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414970; c=relaxed/simple;
	bh=CnwfUShl+781YewdbyFQPMzLuUGHF67C2kz1wc2KhA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUGKLKYWz8Zmcqb0Mj46sEGTkmPS8kAVxAL9xIkdCBAIONG5g0tr1v7GsMFgAQb2Z/8ZsJTBElrHOick2BCkRsZ8e0S/tW1eK0xsDEr3cq8exsNtFi8MGNn2qNwllq52MtXIXObf6LMytY/o1OlRDi8sP8zLhnT21FHJYJXBwoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TY6G/jnw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TY6G/jnw"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678IRKS2273672;
	Tue, 7 Jul 2026 09:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Lq2lBdNqeG6w9qTJ4
	7KsHV9Y/unReGP2HgotJX811z0=; b=TY6G/jnw7JWFdxzBFE7Or5Cd7VJoHcPC3
	7ZILyqRzD/jm1lxZ9xuCbo++N0bUAqD+xS9fC4JvSExK9spOdUlyhIVnHBBzTGGm
	dk84+1bJUTri6X+FUC4AXbMwkwfzVCRmBh0pyfUOefUkHI1ZYpZW6J456rnLZ4VH
	SFYLE73vYdYWFdxQNFnOybRVqs3EHqThmzPxUEoM1GNbbgOl0tBlwJWx8pvlRZQO
	BDalqFmCJEd2q/EfAAIaONr39wdNogpgbWOru+gsPh/1c/18vSgq9aAAb9TIsfpt
	tE0RtP9ORPBkMxfOjzGMSs7iaQdMiZowMNjB/NZmB8sW5tz0weBIA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdprt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6678ncu9004379;
	Tue, 7 Jul 2026 09:02:43 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6y1m6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 09:02:43 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66792gVR8061674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 09:02:42 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4509D58061;
	Tue,  7 Jul 2026 09:02:42 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FA8858060;
	Tue,  7 Jul 2026 09:02:41 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.160.85])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 09:02:41 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v4 11/15] s390/vfio-ap: Transition device migration state to STOP
Date: Tue,  7 Jul 2026 05:02:13 -0400
Message-ID: <20260707090226.3206695-12-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4cc0b4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=LlGlNFsFWGapDO07ubkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX9EaiZTbEZu7O
 muOQM6KSAty6PKMAiyho2y9iGsziBHbSvd3IU6m8rCtH1QoH+V0MsVpSQJ9zO28hf+tBQ3WqhKu
 SH6ceHGYEwSABlRV/eoj8RmD/Q5Z/F3uQxyOfxwhvO61i2W+BZYXd8K+LXb7PAGj1x7l7dTriHC
 CPwiUJYNA0PMURdqZGSHh8iKeieiRt12dITfr0WwTkJro8KeHxvyzEKWCMy+09kzP3l98QBOCT7
 thv6Bu76l2YsyEBX941a5oorjsU3EDtyCbJ+es2vfkcMUMY38bSeVu7/M//xYu7xi47HWNCaNKC
 yqZm4+Glsd2GSNuFuT9UYP2LRwZ5Ya3htEyYkybYb891eZO5aI1SGlgM8YNSb552mJRshJDaKc0
 IcR+YUmkpXmz5xbOEvlcRXfHl82UCixit81GHOk+l0anLoiTGNNNYgqhCJtFb/M1n3oXzhHinnw
 PHawmamaMhRfv29iQ5Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4NCBTYWx0ZWRfX+ceW7KRT/Xp9
 We2PECLUFM7WIyRgtO7dGaDv+I8+EcwODwQoBPLLB5sH2X9z+8HP2aUJN/XqNUwIBSK/aSf2Raa
 ByploufJfoZmqQnOlLwsZAHeNdbkaHI=
X-Proofpoint-GUID: WiUejZH4gn7hLNFgntqxba_PR0r4XdAI
X-Proofpoint-ORIG-GUID: WiUejZH4gn7hLNFgntqxba_PR0r4XdAI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070084

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

