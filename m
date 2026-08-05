Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB87360ECF;
	Wed,  5 Aug 2026 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785941446; cv=none; b=rIHeKNecTQP0WHRCmHQ9dOhnPKHDnHBogNlZMBTuFyZa9Y7adGpgLSFo82IVaQJuXMAzJPCUYFYHaTIyQ73CxtT4qdbkx58G//OLVDLzo5IRevpQVQIbB2GXgirjBEUCFZycFaAESCvpAtoj5Zv3Iwz+JcQeR4XsfdsIet1wPc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785941446; c=relaxed/simple;
	bh=ZR63713XfvI1uJjxOSjBAzU+BokQMXbqqYeKN4uVqds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEbM0lO+BfQT5uG8b3J2JaK9S4Qza0iTTUhsh1YJWfk8i8utap/KPQbtlBDY1InahIB72T55g8z5rHoyz+u7/cTFmRo77+UfMWTcvjDQFRw/Z8rkAkO6eN9CCnUW1FnVBSOXsnL0jQxHfPeDsw5LVFjE9AEP1f+mLffS0S3BOqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FednoTr7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FednoTr7"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675CHglo3793612;
	Wed, 5 Aug 2026 14:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lIkSXwDCgto5ZM0lb
	JTDp0K0m0gB7Rz/ijlX/1s45M4=; b=FednoTr7WIL3j+pY3pcUkKfCehohdW9pf
	0KkPBErh+93vXtH/BbqL677dTmR6LSAO3Fa4apvDSO6Fy1yIkur9xxIwxYmyYpUk
	8NNDBcd4S+9lU+XKdsFT56VPLB4sslJxck15pVTGcRYNKRPQX4I85YpYKryCY3C1
	qCWH4mky8xnPm9PcKXghW3fjy85/VKmxjeFH1yqmbY2iw9Y2BDi+2jhJef2FmwyT
	cRHv7SuMjdqOWXxfC4IQ0uwe7NRHWwA+PluKWflfsBz+kULF+gli2Xz6uRbSA00V
	HYlk8A4C9HtJPPDn2I5GYpJLHSStunV6a/uA48YEIYRRPBL05m86w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a43kcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 14:50:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675EfHjn028003;
	Wed, 5 Aug 2026 14:50:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgetaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 14:50:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675EoX6j17367302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 14:50:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5BBA20043;
	Wed,  5 Aug 2026 14:50:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 751882004B;
	Wed,  5 Aug 2026 14:50:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 14:50:33 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next 2/2] drivers/s390/net: Enable CONTEXT_ANALYSIS
Date: Wed,  5 Aug 2026 16:50:32 +0200
Message-ID: <20260805145032.1409325-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805145032.1409325-1-hca@linux.ibm.com>
References: <20260805145032.1409325-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a734dbe cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=KtCAfOjNhWRM0Y9jXsoA:9
X-Proofpoint-ORIG-GUID: 0ikaczQMkfLeB8Wm-a0rlMm5cMXNW7Qt
X-Proofpoint-GUID: gD1ZQHVxKRVVkCym_U6oV9DYIA7qbfnv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEyMCBTYWx0ZWRfX+c8T1x9XApba
 jEtXIrYHUDpWbi5Ij+Uc6OeEB3maXfxZeAQInDcoroDWxt7NnWSwTaaiyXAzJD+CMvvkPDoukGO
 s12loPZPHgYUCYjeIOT1abbmHIrhcu8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEyMCBTYWx0ZWRfXy9wZBjVDX9Dw
 zCmUrvnWodNHUmJvoVURfXxiSXgDMgIzc2OpkUs9BUrCIj7MTL6LrdbqB83J7G4+ibTH2gRx7K4
 fB43LJnGiwGilwMDbwZKNFP2ucUS1TJ/S0WeNNuLYh5rpIkXttvH6aQ/97cnnRN49S0kX4F5laq
 bQFVUmtkfRPPTnwToNeNn5/+sIEIO8UjJK1Cew1diwvZYojazeNP7Goc/TqXzIk3emv9CAGiRfn
 cp19zUpicGb8a71JjH/K/Qi8FXhUJ5st1FlqnzGamE9C39AYfgj8AjlJe9ZUI1kOvgmyuDRaUIM
 m2+k0vgy8S/jNIiPy0pKW3pLgKZRKMxIeX1sff3lbrnGI8vrcbUKxY1tZdXbXhReJHtWcyboiG2
 qhw/HG+bd80YOlEjv6qYfUy13aiq3+fyXVvtNuQjvYh4uiN+qoRA7FI74QNlKiTcb29IDcVjXxC
 gIfnfz1ZNB+dphJSuoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050120

All drivers in drivers/s390/net pass clang's compile time context
analysis. Therefore enable CONTEXT_ANALYSIS.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 drivers/s390/net/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/net/Makefile b/drivers/s390/net/Makefile
index 537514cc52fb..038ba3e4005d 100644
--- a/drivers/s390/net/Makefile
+++ b/drivers/s390/net/Makefile
@@ -3,6 +3,8 @@
 # S/390 network devices
 #
 
+CONTEXT_ANALYSIS := y
+
 ctcm-y += ctcm_main.o ctcm_fsms.o ctcm_mpc.o ctcm_sysfs.o ctcm_dbug.o
 obj-$(CONFIG_CTCM) += ctcm.o fsm.o
 obj-$(CONFIG_SMSGIUCV) += smsgiucv.o
-- 
2.53.0

