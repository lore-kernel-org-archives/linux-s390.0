Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C2E286D4D;
	Tue,  7 Apr 2026 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595091; cv=none; b=TFyZBWSaMmUPY/ocJ63usYb+YRfCA+0r/WONlX/XwHd22Qt9OPhRoz4e22HITArQQoW7bhajt1LkbFO4oJBa8RXyj/UXS3hzOSUZoMn0ZVQGVIDiTPa+i7dR/UW38F868Jca1ImHdP1cHplzwBAa86ZhJ1pquUGs967ZMpkcl+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595091; c=relaxed/simple;
	bh=1ftjp1UiPSoywMP1xO5jmomk3NGtbVk8SZxVn9F2KNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bv3Kx5WlEgs2eZP4uC5RP6tYUcMImyP9eeuaICeOCb5otjKlBEdIG4WCFYtL3kqT4gUegvKmZbV45kvXFkvaPL5kwUP33+xVyOf9fqTuXevFgZrsawVGLZF+/0BRA0gALsoWeRWk6AWJWaXLsEyH6wBc/ID4B9Eah/MmP5gF03Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AaAM5QyJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AaAM5QyJ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637EFaN52297870;
	Tue, 7 Apr 2026 20:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qQ+gZZyZHOA8RbcxY
	gUFWtxBvzqxNDfzHRglKgaly5Y=; b=AaAM5QyJsU+AJZoyaN++XJHA4C1bNjp06
	gokvbwFeuo51RTsWSM1wcL0mtiuOmKTU28OOgqM+/4kyWygLg8aafgqQc2BA/GkT
	wXLG0ZqHmxIXv98RjQmd0Quz4wP/q6LQYBEVa6IPHE3TXvxiVX71OtZQCbJXBH77
	U1QfubZN3xFfiDv4uGu826mNyZiT8pg2tEvW0mGw3iDxaOV1pt0MOfeMYo47DLlA
	OP2h6Bany+QxATwr/H7tJfSBay2J+Ae4N+FnMVO2XmHWei3xWEDyReOoFch29p45
	VWPmzUlUcVcUmMrZdWV35xOSdRMZJbinv4idtapnf1jTtU126RlsQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fvp5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637IfJjk019113;
	Tue, 7 Apr 2026 20:51:24 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9cuq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 20:51:24 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637KpMjU21692982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 20:51:22 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A56358059;
	Tue,  7 Apr 2026 20:51:22 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E5B65805C;
	Tue,  7 Apr 2026 20:51:20 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.101.194])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 20:51:20 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v2 11/16] s390/vfio-ap: Transition device migration state from STOP_COPY to STOP
Date: Tue,  7 Apr 2026 16:50:27 -0400
Message-ID: <20260407205100.331150-12-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d56e4c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=W1q30hmNGJXHcFJiBUoA:9
X-Proofpoint-ORIG-GUID: Ky-8rS-0upgiHMfnOP3Orivsms0f8fGg
X-Proofpoint-GUID: Ky-8rS-0upgiHMfnOP3Orivsms0f8fGg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE4OSBTYWx0ZWRfX9jy0EpjHf/8n
 Yss/JK2PzlJ44X4xUCz0Z0P1+t3vaA+LEO0W7g1yUeJBzm0vT8wC8nKljEz3T1aNtVDTP7TVAwY
 H7y7weqj7kqIn9dBJt84sdsDlOQfJ3jKr7m5krc90NtgMy1O/pDRpQm1OmBwuaio22W6RkP4enA
 MEAk8ppks1bRHnAKMeakB7eUWFHnN/GFQPVWrdHlmDv/Ls8l14R1So1VTiZGvR2TTAcn44QKgXm
 Y+A3GYQfacdLe0LJbdznzY3GPxM0zFRhE3bPRXJKPUfEv9Ah1rI7QSpFpjFZuZsdCa+wiNsRP1U
 FQpkwhyDzH7u1iNT+/ejsXSr3+fWD6F+Ez0g81PTRf7xFpfIs7l+zwJSxqMTAaukBTYWDlb3w/B
 hMRuA3OnaRkV/rsCfYzsFe/FmIMoeXx6DqByIKUQ5OsvZPpcE750/lpyngbbqhaO5W6JFGNOraW
 tsnQ0HZ77gJt6B23PVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070189

Typically at this point, interrupt processing for the device, DMA and other
changes to the device's external state must be prohibited. For VFIO AP,
there is no physical DMA device virtualized by the vfio-ap device . It
merely manages the guest's AP configuration that identifies the devices
passed through to the guest, but does not have access to any of them. Those
AP devices are passed through and controlled exclusively by the SIE program
used to start the guest. The only thing to do at this point is release all
migration objects used to manage migration of the guest.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index ebb3b78b1e19..6074ccfb9240 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -931,10 +931,18 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 		return NULL;
 	}
 
+	/*
+	 * Stop the operation of the vfio-ap device. Since the vfio-ap device
+	 * does not virtualize a DMA device, there is no physical device to
+	 * stop; so, the only thing left to do is release the migration files
+	 * used to process the vfio device migration. Note that this state
+	 * transition is for the vfio-ap device on the source host.
+	 */
 	if (cur_state == VFIO_DEVICE_STATE_STOP_COPY &&
 	    new_state == VFIO_DEVICE_STATE_STOP) {
-		/* TODO */
-		return ERR_PTR(-EOPNOTSUPP);
+		vfio_ap_release_mig_files(matrix_mdev);
+
+		return NULL;
 	}
 
 	if ((cur_state == VFIO_DEVICE_STATE_STOP &&
-- 
2.52.0

