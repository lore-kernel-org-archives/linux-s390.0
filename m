Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F21355F2B;
	Wed, 25 Mar 2026 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472543; cv=none; b=HuvYCx84NZPdgumhKEXX58S14RCtB3/1RUhCDDIj+uZSQkuY6KQctfxjpP8HRNLLN243FtO694NlE0prIRXQDSVbBtfcjth4BfEEm8XopTHoEFy9YzuXQDt9xX7x2X7WzeZ6T90XJGA9xD4eyKXsvUV/2lcyafGlALbhxqvF/qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472543; c=relaxed/simple;
	bh=x49gUmg84nIcGNbnNC5PiOP5Js5LVwr7I1FeTIDRsbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZK5Zjdshhh6CrhiahpQnlCjXftR6bVstGUUi68aaL6cDz+ZB5TReqxpCzj22ozmtQCI/vw6N+rfR2q+bWKq0HWTgwj6lsk7v/WGp4nWLxvlBzxEHupwLaZ4JM42UePxj7HtPeZprWTTSUEdht2vH9G5WiaFiz3Z7hjBhWr27KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MMT/cPF5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MMT/cPF5"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PJdd563640057;
	Wed, 25 Mar 2026 21:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Nni1PDFaVHOEzEMnd
	wcVSod1HhhJR6TPsjMs/h4ArZk=; b=MMT/cPF5jNjRj8HhhoRb2sBnvg4A1ugOB
	uVf+H/a+Wp2yXY0bTCS19H+EaHhxmy0cg8V1Zt133nzphBjpGUqYdP3sDxdeloZc
	P6SijME42Mrml5TFZc2QQQZJk7+YrluSY79LCJLnTBoSvFxLQOzvrRTtNcpD0hiK
	BCrIhDz+c/XbleM1NuiXliV5z2ZDOIITyBQGxCrmoYmaIUWmZ17IkpY/6FO6dVh0
	a81fv5J3e7FnQZ/sdU+5BdDMAtqJ6lIR46+N0lHW4JU7A+m8oo+kLy7a7acaBM7X
	yzEvC2QM7GPBoHw3K6PW2h8b+Vsad8/sS6m+Y8vphIcMzwxD7DU1A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky09fev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PKTq4v012203;
	Wed, 25 Mar 2026 21:02:13 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk817m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:13 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PL2BWE26608350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 21:02:11 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CAF558052;
	Wed, 25 Mar 2026 21:02:11 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75BAC58056;
	Wed, 25 Mar 2026 21:02:10 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.136.69])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 21:02:10 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Subject: [PATCH v1 18/24] s390/vfio-ap: Transition device migration state from STOP_COPY to STOP
Date: Wed, 25 Mar 2026 17:01:05 -0400
Message-ID: <20260325210149.888028-19-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0OSBTYWx0ZWRfXxqEHYLvW1yFe
 VNTfXNyUMFxdYoSbSsfZBVxIIoJeYItQY3oxCW0zu1FhMYGAmJvzGfY6aaYr1xhPfme51GxF0Km
 ONNmRb3H1pE0Ewb5oSdvhBT7jj3w268xXDR1Xdn50EWdN+hUl6nUGWz6p6E7/3ULC7RxSIUNb2L
 ymxBrNaqsRcK9NjYQxxr5+ArUokM7FxqC6rzeykcOiobGmppLyNURfjPZcoDKNIskLKI152iiEr
 wXbC96+TNb8u0fuKG005FMAXOHrKK4t2GGsLyrLprY2UC4SKUNmRvi+M6NNdmObJ0mjK7lyVZeP
 Ryf91uHlrrTBywxm9tDnUAL+agciQXIe1ol2Dz7l7c3NRZLiGWjDzMhospSiU4vRMGVdP0tRYbw
 SVeAHSHyJs85nLeY8D0BBRMnXBPWw3p5DZs4wK4pt3aGnOufenqp8D5dGnACOMZxuvYYm+H5flJ
 9TX5/6QWvtm03TzJlaA==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c44d55 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=W1q30hmNGJXHcFJiBUoA:9
X-Proofpoint-ORIG-GUID: hCPrI2gEIW6PbHJp5mMwdPSwfCLAuZ6h
X-Proofpoint-GUID: hCPrI2gEIW6PbHJp5mMwdPSwfCLAuZ6h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250149

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
index 71cae26eab96..c6e01294be7f 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -937,10 +937,18 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
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

