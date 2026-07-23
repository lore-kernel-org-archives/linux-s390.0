Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6217D3BD22F;
	Thu, 23 Jul 2026 18:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831693; cv=none; b=nWrW/20RMQMMxr/SvS1TjVepeTWhPEwPTxsEMeuGoVzqvByvPdTJAA5EOHQBhgqXQVzJlBxO/HMAQHTJm7rnHCygAlmC9in2ar0yR7QDwLTLSfC59fHXoIcgrssPncdnAbJm9EW+HtrdHM03kkzg4KdJ6dac1ybg2oLEwy8oPro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831693; c=relaxed/simple;
	bh=SbKNcsHNuuvpmBhdUM5aPMA2TeC7kEeDkvO2AnWU1DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzIL2dPbU3DkgR+s0VTK1pAGWuYdf9nyBOi3215y0CXLVt00vNjzq9b9qUYWzJ50D+ewmA8TQCfFHucl4qP8OHR1FQOXwwySMdO0HOgS9sj1tdzeKcZ32Bm+LdXIKFalHFmNIjkj4YWRp7mAHozvLy5IMXxSVe9pcBkW44M3f2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iToDj3vq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iToDj3vq"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NHff1i3699134;
	Thu, 23 Jul 2026 18:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9BSAswjPgsFB3mwS+
	9M8RqhlvouBeOd1JU81W/D8CTc=; b=iToDj3vqcxnqSXrSUnYlqGttG/0T+enUr
	3T4WKfteZNjL/vyqc/5VDDLdHXSN0hFLQfGsgTHh1HtXez30m0gDp6D7nR9fjeV8
	MDb9c5suHQQdoq9d4rbaSV0YuB5v9Gvn7SAodggMuNFNwBhHvo09kXfxZM8PXWWR
	jV7Us+umV7dWMJTNkxS0rsqY187tN5ChZRP3C1RFQRas4KSPy1W8hGrhurXRYLmR
	cxgwY1xYkTBGwkx2nRGKvBLod1J0ffRZchbjWPTdacHeYl8Lob2twt3ZeM2RZw38
	2XmlrjvOqjQqx7MGldslFfsina4Wl+QhFdG4VbKysoDnxMsqEsZMw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7919363-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 18:34:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NIYdBS019032;
	Thu, 23 Jul 2026 18:34:46 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gnb4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 18:34:46 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NIYj3w26018504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 18:34:45 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B6E658054;
	Thu, 23 Jul 2026 18:34:45 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94ACE58050;
	Thu, 23 Jul 2026 18:34:44 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.118])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 18:34:44 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH v5 4/6] KVM: s390: pci: Fix NULL dereference on AIBV allocation failure
Date: Thu, 23 Jul 2026 11:34:38 -0700
Message-ID: <20260723183440.3271-5-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723183440.3271-1-alifm@linux.ibm.com>
References: <20260723183440.3271-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -1cZzAMJ8ixisMy2Y7ilB0APxuyYWrNP
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a625ec7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=VpFnpj6RERqEfYQjrFkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE3OCBTYWx0ZWRfXzmEmo/Ruz7xw
 IwLFeJaPTnVnNQcbBAUcaDT5JbWHFbWhWiq1dV/6/A9DKyxqJm3yH+h7lv1yY57Iuj+Bah3MJ3o
 efjQEzc36VKGeA5aRxAmc2xZdsMWAGw=
X-Proofpoint-GUID: -1cZzAMJ8ixisMy2Y7ilB0APxuyYWrNP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE3OCBTYWx0ZWRfXyIkHyfiFDh5t
 13Ru8FM+gHu6idFgXPL0NUU6fR7Nd53DXq40pVB6btzOpEEPu+NHiJygh6Adbtv15E8386nqE7N
 KpyEvdwYdmLiOzpk/zKkNMT2YIFkN031K9xsCWQz1c7IolOXFFh5Dn0N2+4F03kJEzuRhcjIL2y
 SgYTcaVTVPV7kVDJyC7rXrG9zFtcrLU8Uz4v0crUOHcgIXwp9keL59pmgrGm7a/kgMJCM8MlHxb
 /YjrrBCnOLvzFGb1FZclNDgPBhReILWr/9Tixf4y1h/kjNdBSNqyjPIVB1vylifSJdfJDlrSMMB
 Umfxg+4DrwcBk3nWYa9bX9+WXM4xfkV+p8iy8lYh+9NgUDcALI5//LEv+aDoGt5zVOkv2MYY/hj
 6A8kGtu43g1aiBuflQJmZohtCXesHZMycDpRWuBE1I6L4g5JiQBLvaFs60BTa3J1JsmDVF64NAi
 f7hHJ11C58pzowUnxRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230178

The airq_iv_create() can return NULL on failure, but the return value was
never checked. If it fails, zdev->aibv will be NULL and fail when
dereferenced in kvm_zpci_set_airq(). Add a NULL check and free the
previously allocated AISB bit and zdev->aisb on failure.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Cc: stable@vger.kernel.org
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index f58d7ec0bc7e..602534e3cc10 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -317,6 +317,11 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 				    AIRQ_IV_GUESTVEC,
 				    phys_to_virt(fib->fmt0.aibv));
 
+	if (!zdev->aibv) {
+		rc = -ENOMEM;
+		goto free_aisb;
+	}
+
 	spin_lock_irq(&aift->gait_lock);
 	gaite = aift->gait + zdev->aisb;
 
@@ -353,6 +358,9 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	rc = kvm_zpci_set_airq(zdev);
 	return rc;
 
+free_aisb:
+	airq_iv_free_bit(aift->sbv, zdev->aisb);
+	zdev->aisb = 0;
 unlock:
 	if (pcount > 0)
 		unaccount_mem(zdev->kzdev, pcount);
-- 
2.43.0

