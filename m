Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E880E403B08;
	Tue, 30 Jun 2026 10:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816116; cv=none; b=eobOF8Z7El6Lv5xalxgyYtFFHexZ9wJqn0H85nbXoFxSnZvkNshPgjsyCa+Mv2zGjwqk404EwhsNNXZ1KbtUy1cszsRaJot1KvEXUuDUM15LhwNGq8zpIsU9CS2kl2quQYc7Kv95WtsUsW1ib5tMkyHcBEj0w0IwDs6R3iaYwO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816116; c=relaxed/simple;
	bh=xB3GgYxsOVHpsRHzGPLrssNJvgNJgiFQHSO0Wi+PH2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZChXC6NxH41yH+BSDSsULyHfedBvxZGGUD8TBaVwMmj4xpQRYDpeK6JfqD0VJsSOmvEVBwm/fZdJOYDGoH28CmzuvfRxH9GdeTS5RsoNdofdmaQr8ioRvD2yWaXFgHtt+1NFUPO/tDmFpsy2pVVMhTihTPy6GTNI8NjxCkNJlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MYQhK9Qm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MYQhK9Qm"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9nVoN1582469;
	Tue, 30 Jun 2026 10:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Z+YLtARUaaC/uHSzj
	T7Z5DdhWlNW16W/feL157is7pE=; b=MYQhK9QmMcre7l/MqJyhYq/yNU6hkmfQd
	S+YC4YQMaP8yJkQ4JRB3Co2nTMAEnRf4IgdXxJ+HU4Qj6hTj9rU8mf5gEgzCGygp
	MbsaWq4URQEZuUj6F5loJPM0i8gNIr0FvHFaVJzeG6aWeoGw8XivEnvCnDdUxDlZ
	ZrjC6vnLoograJTQyNqQqP5xfMLueX1eHtZJB6Tu80xeTTn7Xz4H63mNukbCfVWD
	l9KAZRO7CQVpQ5RvtsCa5pdflQbD24vH4VESely6yiHUZR/8SykJLIx+QJSg9OjO
	xhjo4i2/BhuGb4rMDgDOyM25dIjlgY9Xgk81ogjXf9fDfOwmv9mdw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26q9wwwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:41:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UA4cGC005983;
	Tue, 30 Jun 2026 10:41:49 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhy9f6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 10:41:49 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UAflBX50987326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 10:41:48 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7AA158052;
	Tue, 30 Jun 2026 10:41:47 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D82FD5805D;
	Tue, 30 Jun 2026 10:41:46 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.135.84])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 10:41:46 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v3 12/15] s390/vfio-ap: Transition device migration state from STOP to RUNNING and vice versa
Date: Tue, 30 Jun 2026 06:41:22 -0400
Message-ID: <20260630104132.1598851-13-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX1KSU2ZnGmth1
 ivrHGYhwj8QCxWcWUCwvN22l408ItYqNT6KvEwUdeDHgfuTemj8meE4v+ESk4V+F8xLwbvpZ16t
 048j+PfJWUPmHTujxXh31MEnJlcQr35uEE7Ga8Be7vifd82LYRLx3WENhm0epq8/4tjqdCNEU1F
 A6bglWeTsLjeFYDHaZXRnMl4k0fbTMcx+WtZ5la8hbg+ylq04YmRUMpHrsZy0jUxHJOxAIYdyfA
 8DrVmmpTeU6GFay7Wa276AoSlbWzipKHapPe5nyF+sr0sRLIkys+Yx2ufle1pOmi7C2qY4x+7Ol
 fPlU5FWKHpndrh5hwiCChif1a/NZwmbhx9vHLI/vQMVlknhXBp5Ju1z4tP32UV0VBzlXBbWRHb9
 Ib2OwS4VZUjiD+etLyo25sM4FNo1GSoWhCsspRjpTkLqH4KjLSuwk4W6QiQi7am1rhLum/yfOMW
 q8kmlqsNDaMmCaM3gbA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX+kEADIV2oZNm
 O2rBRVsYinl0OrJSeW5+MyAGVLXNIQT/2e2uWiK8ZrUXiq9VDyS9I3RHKaguMCK/awWDCHCdfyg
 cCgRB9KbkOwC9R+Q1oCiVauWYeEsjJg=
X-Proofpoint-GUID: sLAXhW2P69rnVLrauSHGWy8ljBrVwW9Q
X-Proofpoint-ORIG-GUID: sLAXhW2P69rnVLrauSHGWy8ljBrVwW9Q
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a439d6e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=YI3AHy_hWZklpQ5N57sA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300093

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

