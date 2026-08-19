Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854CE424D64;
	Wed, 19 Aug 2026 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129477; cv=none; b=le/QiPw9e3a13pDHC4q2FoGPWm6aD11rbaY9mj2rAlPs8biBFW0lVFxyiN7WHzC4hOKawCfSWEenieDphKJGPQwYMPnY/akMPd9LvGeGaJgfI42ZnWWNWCZ/lADQ9uvonS//74/SIP4dp9xxS1D0JKFgYvI2Yl4WwpY91sd0MWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129477; c=relaxed/simple;
	bh=lrb+OrxV8ahIGAoh56p1bDqAKZpF+iq6sJcJkP85Tnk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fepkYUFLkPReCXk5gaZlf10/nQIas+2GLfLo0aiF9AGPkFVnDXGKAEdeDNSPin0MCDJrcfmN/3pbGmC0Qj9AU3NDPFkQXbP8V/V35u6R4Gs5KrqraoCZ7jNLzC054yBZ1yICIffgrrqsglgTIc9ifIn8ptpX/4M9+61U+BQjFHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Nflerk8x; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Nflerk8x"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6VkdI2621747;
	Wed, 19 Aug 2026 08:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dVlfP1
	aKWDc1w4MU8JTuxultFGKrT+Ma/XA7z29gKRE=; b=Nflerk8xvIdnMq8iNKrrFT
	nVgR/Xp748XrV6+4GhChnDIk91lqKBxiaILe+kIJjjRhOvFcOKhKhkE0GMOH5lUi
	CysX2j1UGpAeP2RwJlEhR8gdBzFsNc4dWjWbMpjAKBh8Aq6OTFB+YUevT5pNUWeJ
	4O66gshLUGKj4cs1rqxV91/1fD74bJZPw75XarBEW9udDNcVqUPMnYnBiD+At1Le
	At6at09coG/k4WP3i1N9iKdIiDbHq3PW3YSSihQ0wyWOTds0PcBWvXr566gpPyPf
	651VlUGMbs/LMWqMIfTnzy6GucUe2XMOIIV+deVpKUZCpnHVVWk+bKTKgGtPQxOQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1amfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 08:51:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J8fM2r028855;
	Wed, 19 Aug 2026 08:51:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw84v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 08:51:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J8p9oQ43450740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 08:51:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AF6D20040;
	Wed, 19 Aug 2026 08:51:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AE6C2004E;
	Wed, 19 Aug 2026 08:51:09 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 08:51:09 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Wed, 19 Aug 2026 10:50:59 +0200
Subject: [PATCH 6/7] s390/pci: add error cleanup in zpci_directed_irq_init
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-s390_irq_domain_fixes-v1-6-826ff27b6e97@linux.ibm.com>
References: <20260819-s390_irq_domain_fixes-v1-0-826ff27b6e97@linux.ibm.com>
In-Reply-To: <20260819-s390_irq_domain_fixes-v1-0-826ff27b6e97@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tobias Schumacher <ts@linux.ibm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a856e82 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=bp1g5Iz1D7c7guLF1_8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: truLiIf-91VheaJFWK3F7nB2USbP94Lq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA2MyBTYWx0ZWRfX3EyZ8VmSD9uM
 Ey3aYwOpJpRasO9MVw44e/rEYF+wU5eo1nMP8NtL1gmzYy309E8YTZM0y+FtJU+C3FFSAFWzyX0
 IAhG18jn5WSA9e7AaisaDYfoncTqWWY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA2MyBTYWx0ZWRfX1k2tBKE+wjXg
 v4hAQtJLUXFQ+V3rv0EwLaueDT1Vt9a4ZVz22gauNPwHB5tOMqzw+48Zp+OoZv1JRJmrYAWL8Jd
 Ww2NSRbRLYKDmOwMVVLtC8o4EBNcRqgtTQmwLEKt0skmMj8OjwSY+QIprUXOTmwt8Wp537AotwY
 G8xb4TEk1MnjhGSjEXgKhcJRxwt6Y4OyAp8RolnDgum808dP60VL1QUSd+1XNVobF1nVQmro9Qr
 2LdNALMUAWQNYi23c5K8dloU/GjAm9IZVwSW0AsU1A3Vqpq3hwmz3mrovygAnJ2Qg+yF+WgrS4k
 1a06KlNk1X9KqoSPbBqhl+4ly1fdJijbQEgzvQjdqgsZ5mHN62scVuE/JoDJcOJwFhdEx7fYIgI
 MLGw0fkQ7jfUJx47jDUK+SBIgmrfx6NNVcQJhf+vzy7fpWZu515kxwF6t53qZGGs0E3uYxI7qMo
 /3fEdf9RzlZYVx+pEfg==
X-Proofpoint-ORIG-GUID: truLiIf-91VheaJFWK3F7nB2USbP94Lq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190063

If per-CPU airq_iv allocation fails in the loop, previously allocated
vectors and arrays leak. Add proper error path to release all resources
on failure.

Fixes: f770950a4709 ("s390/pci: Migrate s390 IRQ logic to IRQ domain API")
Cc: stable@vger.kernel.org
Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
 arch/s390/pci/pci_irq.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 1515d8d7460e..1ddf6b3625a2 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -586,7 +586,7 @@ static int __init zpci_directed_irq_init(void)
 
 	zpci_ibv = kzalloc_objs(*zpci_ibv, num_possible_cpus());
 	if (!zpci_ibv)
-		return -ENOMEM;
+		goto out_free_sbv;
 
 	for_each_possible_cpu(cpu) {
 		/*
@@ -599,13 +599,25 @@ static int __init zpci_directed_irq_init(void)
 					       AIRQ_IV_CACHELINE |
 					       (!cpu ? AIRQ_IV_ALLOC : 0), NULL);
 		if (!zpci_ibv[cpu])
-			return -ENOMEM;
+			goto out_free_ibv;
 	}
 	on_each_cpu(cpu_enable_directed_irq, NULL, 1);
 
 	zpci_irq_chip.irq_set_affinity = zpci_set_irq_affinity;
 
 	return 0;
+
+out_free_ibv:
+	for_each_possible_cpu(cpu) {
+		if (zpci_ibv[cpu])
+			airq_iv_release(zpci_ibv[cpu]);
+	}
+	kfree(zpci_ibv);
+	zpci_ibv = NULL;
+out_free_sbv:
+	airq_iv_release(zpci_sbv);
+	zpci_sbv = NULL;
+	return -ENOMEM;
 }
 
 static int __init zpci_floating_irq_init(void)

-- 
2.53.0

