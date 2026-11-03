Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718107;
	b=pVAbMW6a+QlEZp+RCke221oGTzyQZaGg6/8qJehFQy1tzqeBMSIkKiMU/ywObhXT5yuF
	 M2OdpJPkwinZxEB7r4sHCA60QZMS6Zfz1sFBHIt+nRXCse43AtQOX95Tni+FGGmxSV+q9
	 HDvwSiLBmjRSgT/22QjiYt/qWAfnSxTNpVW5q12osue+yjFb8VaORfl16MrVwHf18yd42
	 Jieo+9WYBSAJitfYBwf1Qjr/U12+VBclqRpVLKZIv0Lj5IIAp+7xseLJpzclLm9I2DP95
	 zY5Db1osl4KBK4fov9ID0IV22UOF+gnCRhbVLZ3OcnYNJnEvAEqUEZicglm7wuSpdOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718107;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Ugy1MPPX4rX1hKJ3Iu+kcccg2ZINH127EjdwX5suMt0=;
	b=JriAAsjDLhd1CMkXm/2LxmchaTQ5GxkPVl+DxTldwcHxB1EXWZcLw4/lJEyHJgr+LpnY
	 W71WzukN4YQXhb+aTMx+a4+DQPbaqs5gtHVjC+4n0uheYVCKA9aOt7nOzWsB6o4PFd4a0
	 7OhymasEYikEyw2cOIxzP14IED76+NUm1u3eo2yuyfYjlpbW7yS5jy1UnrPc+cpy9lNWP
	 Gw1fKNY7FYm2cx01JP7jYgTIdSgOy4O/EIlkfMb02BZWjVhXhTuYguQVKZCUv0SdtTBRj
	 /huXE1wz3mcmmReNnJUIqnyJ7phAnOBlAkSdjK+SrTAjWHkqQA8g8FlAKYc1gNEhq3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M728LnHB;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C305606FCF9;
	Tue,  3 Nov 2026 15:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C305606FCF9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M728LnHB
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EELLD407376;
	Tue, 3 Nov 2026 15:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ugy1MPPX4rX1hKJ3I
	u+kcccg2ZINH127EjdwX5suMt0=; b=M728LnHBnnWB09/22bRj2V/w4zKsOfapB
	FiNp8PNOVKkUcEkcLHIWLxcfayeXX3/vJQZ0DmKjhIPytuZLyH7UbswX27W03jwb
	IZsbBe+0IhK1jODG6jTNBPyFn9tsFsO90zg1eGLrNRuvhEFhK411fHcqwSyLIv69
	pjvLQB5MPIUQnAgNE6fLP0R5c6zhxOItxzvnH3G3y85bkK585WLmlYHZTl0p3zyB
	p6yzFNDZ9fBMU4haf+le1WLQM0HqrFgEXCluP7GhE32BnI6ceJwKXGIwDCpJ24km
	9cspIyClhnIB3IbdEptSW6B9stRxLwwpyyL4WFD72eCfQeaG3/orA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn80spd7x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 15:01:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EK0us1451557;
	Tue, 3 Nov 2026 15:01:25 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hnvvfttjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 15:01:25 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A3F1Lc530278240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 15:01:21 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 319C85806F;
	Tue,  3 Nov 2026 15:01:21 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A97E358068;
	Tue,  3 Nov 2026 15:01:19 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.243.67])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 15:01:19 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com, alex@shazbot.org,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v12 1/5] s390/pci: Hold fmb_lock when enabling or disabling PCI devices
Date: Tue,  3 Nov 2026 10:01:10 -0500
Message-ID: <20261103150114.68873-2-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103150114.68873-1-oelghoul@linux.ibm.com>
References: <20261103150114.68873-1-oelghoul@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1OCBTYWx0ZWRfXxI9tfknrkXRv
 MUTgbKcQX7p4OtS2m/iUpxQ1W5GwsGI1pQCm77Dv1zS4LTnac6UH+2pc0YKe/XhFCbLsxt5cLUR
 2npcFpBmmu8ECcugLphU29IS8XWf5RnOxRgFZ2K5wDhsRcRu9cb1UDzVpUZA2nPKZBeHNYjpRve
 Qbs/rdxmHAOwjhOG5s9SGZ2Fa0+tMZmBNn9djDYy4MGNuV8qdfKeW7/+As/CeHrbAC9JPQh6rAv
 lvLdGzfSOaw6uSWVQ+GP7AiWaUbInZyEh2AT9mAHkd470BBST6lMrhSRMEr15wWDd8Gy+iZWYaC
 L9c6KAfj8+mBx5C5r0gKJ/M+3+9MCqv2sWxoYHW51JR1h7R15OHL3Ej7lcC7CdZMnNo+I3fM2ae
 +MyYUH6JIRi9gRABYOg91oiwR8MHew==
X-Proofpoint-ORIG-GUID: v8RBknZWWZ10BAYUd9Pb39XJagHQp_di
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1OCBTYWx0ZWRfX4oXLxAc5tym+
 qK5eVXSWfQSgLlBT0jJYxiTNaeHjYkmkoXmPy9CKQrARC1lN3bHlXGRjVxnjMrFkf4oieroLt4n
 txKrYtr7WW8BoVSyrcm6a2ZvIzWQaTU=
X-Authority-Analysis: v=2.4 cv=FIqOVOos c=1 sm=1 tr=0 ts=6ae9f746 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=5NbLduwtq9nBFWGw9KEA:9
X-Proofpoint-GUID: v8RBknZWWZ10BAYUd9Pb39XJagHQp_di
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610300000 definitions=main-2611030058

Ensure that fmb_lock is held by pcibios_enable_device() and
pcibios_disable_device() when calling zpci_fmb_enable_device() or
zpci_fmb_disable_device(), respectively. Additionally, assert that the
fmb_lock is held within the latter two functions to prevent future race
conditions regarding new callers.

Fixes: af0a8a8453f7 ("s390/pci: implement pcibios_add_device")
Fixes: 944239c59e93 ("s390/pci: implement pcibios_release_device")
Cc: stable@vger.kernel.org
Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/pci/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index d64c544b32b0..c055a9ad0972 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -173,6 +173,8 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 	unsigned long flags;
 	u8 cc, status;
 
+	lockdep_assert_held(&zdev->fmb_lock);
+
 	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
 		return -EINVAL;
 
@@ -211,6 +213,8 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
 	struct zpci_fib fib = {0};
 	u8 cc, status;
 
+	lockdep_assert_held(&zdev->fmb_lock);
+
 	if (!zdev->fmb)
 		return -EINVAL;
 
@@ -639,7 +643,9 @@ int pcibios_enable_device(struct pci_dev *pdev, int mask)
 	struct zpci_dev *zdev = to_zpci(pdev);
 
 	zpci_debug_init_device(zdev, dev_name(&pdev->dev));
+	mutex_lock(&zdev->fmb_lock);
 	zpci_fmb_enable_device(zdev);
+	mutex_unlock(&zdev->fmb_lock);
 
 	return pci_enable_resources(pdev, mask);
 }
@@ -648,7 +654,9 @@ void pcibios_disable_device(struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = to_zpci(pdev);
 
+	mutex_lock(&zdev->fmb_lock);
 	zpci_fmb_disable_device(zdev);
+	mutex_unlock(&zdev->fmb_lock);
 	zpci_debug_exit_device(zdev);
 }
 
-- 
2.56.0

