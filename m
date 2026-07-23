Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B121B474257;
	Thu, 23 Jul 2026 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831689; cv=none; b=awGT3CoiHpXwDRJXFzq9ASWi01NBZ1Ra6kpvn8QbjpX6D5QZRv0sJDR3qN5sW4EzCKxh3tJuHgr9Kzm2GO1Ue6C6zHRT3o7JfiU73FURbVuYK5dFogX5/UL10pp81jU6MpeVe8PSixMve0R0Zbxa2KBmojOZ5m7fpQhVRXNk3Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831689; c=relaxed/simple;
	bh=J4rj2ZN//xVarZrYZCxN43NnJ0NcRj3mrBSYGw7AmqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wb2kdG57bjabWDtOQDUyCFHHldFh9acgtNuGXy4wrnIai5LZfZ7HEKziZ9QnrggawZVGXeaqAPmpuWjgJ1ylP9AgHNPf2A+QF3FYS1+DBxSyUBvwkWGXbAPeqRecAEUco33RhTOqgkxja3jWNUQy4DNGswSHVv/LJNXThh2NRvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rGLeh095; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rGLeh095"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NHfrAY3682113;
	Thu, 23 Jul 2026 18:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=s8kEz6tL+IAX1w09s
	dKggdxzvbkfbK6pwkFuZZg4FFU=; b=rGLeh095PHCU6S5jIwtO5B5n4wwIJ2le2
	3IDZv6ZbGk8yMqMsWB8li1cZVW4dUa1oHwE9ma5fkHBCiObo/+EgdItf2GVwT+0M
	bu7k08DIAU8oSp3ZBJlbErls/ILfa/S5lPW7WjtIP3+vB2Cjm6kDOOp/UIBY9iYY
	OylrhVuz6dXzKecYUggD2gqMt3PaqQDahtJPi/xEDm5cBdi84s171lDRLqPoIJLD
	5Hw1t6X3aHcNe0KxG5O2VReSlBqo1z4o8V+rklk8EzETdShUhIJlk4cxZUXDAo9I
	8XcpuvUOsasKzqLJTCI670A93ovqkpgoEdg9HnhxiXTVstmpwE0mg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abs44t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 18:34:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NIYd1X005327;
	Thu, 23 Jul 2026 18:34:43 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wdmg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 18:34:43 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NIYgEc30999146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 18:34:42 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69E4258054;
	Thu, 23 Jul 2026 18:34:42 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8512458050;
	Thu, 23 Jul 2026 18:34:41 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.118])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 18:34:41 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH v5 1/6] KVM: s390: pci: Reject adapter interrupt forwarding if already enabled
Date: Thu, 23 Jul 2026 11:34:35 -0700
Message-ID: <20260723183440.3271-2-alifm@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE3OCBTYWx0ZWRfX3fv50InkElkW
 j47InmsQasLQyftiDKKU3QGkSeaIfnbCQgL7tG9HPcHl9dF4xUj1/+000HxBgFtRQeZxwNKrNVO
 PoZJK5nvNLAfWuZXlURjJaytDpNAYr5RdXSieCqBou3QN7T9bh2FpwJlLzSJwD5cKz1KKw4r5VG
 wMQwFlpB3BHTlhNfzkrVHHn99xvefxOEbdS0dc+afRbc/8JsoqZuhHzAGOCf8jEp5zHBerH6pol
 6Mdv3pFfxPcHTqh9O9RuacvLWtOUdJsZwKk2vqFbKRWTMFGfmOJNFIVH05wEDRVQLxFc+lseNJ9
 svwbrdqt2ahI0GvcqJEry+MNEkRAjKAoK0TX/FcnJnuQjfBRyHEGYuMB36NEztx8qydntwGZJ1Z
 uaviXxYMFEcO3YBJaMWT9o0OK+VcnYv/duKC9Jat5MDgzliyk3cd8febNdBN72Q5ByMmRzUFKSr
 gohGaePdXD2pKlBrb+g==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a625ec5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=G-uFRffD-WzugI8hyjEA:9
X-Proofpoint-ORIG-GUID: C8GPBtHJm4CWlXqUrRYpmmShWCnLyidt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE3OCBTYWx0ZWRfX2gEi7SMwPluw
 iVE4lLA6ceEqUnG8AtfKBftAmCn/R5z1JvQWe8ty0iCVyj4YeWtYYno8DxIFq/qP4lHQWFlv4bk
 /EVdHtOUkp4YzybwzIKtr3V1wnGT92U=
X-Proofpoint-GUID: C8GPBtHJm4CWlXqUrRYpmmShWCnLyidt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230178

The MPCIFC instruction doesn't allow registering adapter interrupts without
first unregistering. So reject any request to enable interrupt forwarding
if its already enabled for the zPCI device. This also fixes overwriting and
thus leaking resources when the ioctl is called multiple times for the same
device.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Cc: stable@vger.kernel.org
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 720bb58cabe2..d2a11cdf6941 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -237,6 +237,10 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	if (zdev->gisa == 0)
 		return -EINVAL;
 
+	/* AIF already enabled for the device */
+	if (zdev->kzdev->fib.fmt0.aibv != 0)
+		return -EINVAL;
+
 	kvm = zdev->kzdev->kvm;
 	msi_vecs = min_t(unsigned int, fib->fmt0.noi, zdev->max_msi);
 
-- 
2.43.0

