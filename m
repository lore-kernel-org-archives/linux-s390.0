Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84471348C44;
	Mon, 13 Jul 2026 17:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963568; cv=none; b=t91dOpbSfU/V5GaqV8oyRHgBo/umwNKEuLKvwyrLhXZqQ8Hf38EAo4O4C/OdgRgXc+VFWvFMRAanSZpyvNC6Ym/668Ge2wiAiIvB+zxUYe7zqjMtl0iNXilxO+AkYPQQja3b8MOP/EwxdE7zOvbgu5aFtSNYadlLYNjSWcCVKlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963568; c=relaxed/simple;
	bh=4EieKZfEDF1R1N5oWYhDubPwLX2+zTAOr7B76VLnq/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUAqUlKum8ZT0e9CtYqEyLdy/afO2cava9kHtmeRTnYJogxMxlpz3o7cetwXbN5q+KGkOOUT1a9kH/Xafu1IotX+2ihfrdQg3wrPxxCqwfwhouyDHPoP9/A/sVDh5EJKyhRPsp7UskntK6kVEHX6gA2DjAHu+IWAOoCN0bkF1ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ij66BgD7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ij66BgD7"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DFEKAc2855620;
	Mon, 13 Jul 2026 17:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eTLGx59kqxdpeE2Ak
	MJ5sLNuv5UWVWNy5zsCrnXSbqA=; b=Ij66BgD7pYjuWu3Wz+HZe4ETdDPpMjUar
	ON305rrcqiZU6OfVmr2UvwTbRlbh00MHYUe8sWhJghFBMLoIT5ICON2EQhTUm7Fl
	gylA0jxfq+u8lIw9K0Cgf6P40qCU8FdBLml5shKoe+5sWnSOYwpiyo1TIcLoz8gV
	560Z/DOU63zWi+F93KiPDJSOJuWco1ICtWohIi1gQLD1JSIgpg8Z2eW5/yNYDHC+
	w8IB+3zVFWBJbB8fikeXjQcClZaB+t8/ePAgkO99CY/BcGUwOIx5qsh7zR3uwD9x
	cRIVLYcr9BQXEiF7SHplkqARlUD8ELoC+K3Su2TioiIegEOFqVT3w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegt20w1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 17:26:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DH4YZ2023791;
	Mon, 13 Jul 2026 17:26:05 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cg6m51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 17:26:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DHQ4Vj33227426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 17:26:05 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D049F58051;
	Mon, 13 Jul 2026 17:26:04 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D83C5805A;
	Mon, 13 Jul 2026 17:26:04 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.249.24])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 17:26:04 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com
Subject: [PATCH v1 4/5] KVM: s390: pci: Fix resource leak on IRQ registration failure
Date: Mon, 13 Jul 2026 10:25:59 -0700
Message-ID: <20260713172600.1284-5-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713172600.1284-1-alifm@linux.ibm.com>
References: <20260713172600.1284-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uoDhW9JGHI5uQuBX4T1lpn_33zrq547n
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE3OCBTYWx0ZWRfXzfZ2eN4r9zwn
 TYk5CIvRJIkA6ZVO2svZI+LHfY2iQR4dRQY/52gI/jc6gZP9HZ8uIVCIdcopuyr+dQeo+F+Yquf
 fJxhMyylDFnbAG3mfpB8wkhoFQSnAF4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE3OCBTYWx0ZWRfX/SrRJVialYng
 3aq/zKw93BzRUIWCJNlGu0wzoLGwLpDRLaEO1GrL1Jonsu3O/Gokm8XPYtI/Ql4K0Q3JhMTkbmT
 /3bASTUMmyxqhohxkYc1+0ngXYMIJMBqAu9ZcP9wkn8mgJ9AshktPuq/e4QPkQQhTNICfs5pJu/
 WQ1rfiwRX6j6UdC5xmq7twvQZhJDN/A3WEHoDx95HfHyfqcwSbA1gm9PfuqKGKSgyFSUMhHuD7d
 yN1TP/MqzxFlT3zppq3Q8WyUsz1eZyQHRKeNMCRuZpY852RfK6GvABRKuZcVRrE2cMlp4ALkr5h
 8H+1u5MR3T1iqq89aY2dEKshsMLKiWv3rBF9xO0Pmj9YopbcDXsogMxKpwv1bjzFvabDRx/nplV
 ZTfOCeiwCsb+sxNMzP0SbCtuF1frqeXcNyu9tLWN2llrGUAB08SsNMA+BLIWsx3FunG4wLxBrGW
 D46Do05mjiYRaMGVMvQ==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a551fae cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=S3gQTLpqa8hfpVGigeQA:9
X-Proofpoint-GUID: uoDhW9JGHI5uQuBX4T1lpn_33zrq547n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130178

Currently if kvm_zpci_set_airq() fails, kvm_s390_pci_aif_enable() returns
the error code but doesn't do any resource cleanup thus leaking resources.
Fix this by cleaning up all the resources such as the GAITE, AIBV, AISB and
unpinning any pinned pages.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index b3ffb8c25510..9a16a2eac65b 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -334,11 +334,29 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	/* Save some guest fib values in the host for later use */
 	zdev->kzdev->fib.fmt0.isc = fib->fmt0.isc;
 	zdev->kzdev->fib.fmt0.aibv = fib->fmt0.aibv;
-	mutex_unlock(&aift->aift_lock);
 
 	/* Issue the clp to setup the irq now */
 	rc = kvm_zpci_set_airq(zdev);
-	return rc;
+	if (!rc) {
+		mutex_unlock(&aift->aift_lock);
+		return rc;
+	}
+
+	/* Start cleanup */
+	zdev->kzdev->fib.fmt0.isc = 0;
+	zdev->kzdev->fib.fmt0.aibv = 0;
+
+	spin_lock_irq(&aift->gait_lock);
+	gaite->count--;
+	gaite->aisb = 0;
+	gaite->gisc = 0;
+	gaite->aisbo = 0;
+	gaite->gisa = 0;
+	aift->kzdev[zdev->aisb] = NULL;
+	spin_unlock_irq(&aift->gait_lock);
+
+	airq_iv_release(zdev->aibv);
+	zdev->aibv = NULL;
 
 free_aisb:
 	airq_iv_free_bit(aift->sbv, zdev->aisb);
-- 
2.43.0

