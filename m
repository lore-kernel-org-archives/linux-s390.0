Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADA9339844;
	Thu, 23 Jul 2026 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784844854; cv=none; b=FyL5XnQv1RuDkGyXNZWQIukysSD9aYGhNDZnAPWaitbqGFVNAuT7+4z3zlzMSg63b2GUx0UKuvE9JgZUKK68zKNB7ecOfIQLIJa/wdRnyzHUE5QoPHuaRZlsQhIxB6QwtLuUOroXoxa/2B+DN0r6xtAGKiD5QTVc/GkOPlXqgZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784844854; c=relaxed/simple;
	bh=J4rj2ZN//xVarZrYZCxN43NnJ0NcRj3mrBSYGw7AmqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NU5xX+ez8juJxrcIVae5EzVK/1IC4IIFtJNpQwltUpfUE6O+lV1P91X08mFQoTRz44XjW8blRGR6MJdcymPzFIE3L7nhXyxBkPMo/Bpu5cxtEGD+FaLZXT0aTouNZQAJID0uSA9rDZmwo6uF3w/cr8gpIu/gUyYWCEm+Of+kV84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rTSfBIWq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rTSfBIWq"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NLgUox4192294;
	Thu, 23 Jul 2026 22:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=s8kEz6tL+IAX1w09s
	dKggdxzvbkfbK6pwkFuZZg4FFU=; b=rTSfBIWqZUrmRzLpe1TY0KSZ1mt/7Kg8b
	PxukEyrdTwyl8yOK4ERhl7MKX3lxS62OkQ23uhtTwTycjRFMugOeBUe8+YcB3Bi9
	PcbHXjI5XsNA1vaUy9tQZHtnBRYOrthbf9fHxrIwa2Frvdg9SvzprVFihuvWhj3N
	LixWtgt7P/a9iXPs6JPIaIZny9Mhbwk3DpOxTIzfRSKC+FWV1EXxBY0QZMrMP9L7
	gVhiWl3CiOrAnVxvOwEoIZobB+bX908Aa62E4xpYyoC4BohX1fLHJXvru05rrAn5
	NJKXzdGUDrHeogOEPMs/u3pQd0oFmBLxhvWD9jRBnJKSDMW/yfeZw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahh8ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 22:14:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NM4cNO031287;
	Thu, 23 Jul 2026 22:14:11 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyp0ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 22:14:11 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NMEAK227066988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 22:14:11 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB7885805A;
	Thu, 23 Jul 2026 22:14:10 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 411D958056;
	Thu, 23 Jul 2026 22:14:10 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.246.245])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 22:14:10 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH v6 1/6] KVM: s390: pci: Reject adapter interrupt forwarding if already enabled
Date: Thu, 23 Jul 2026 15:14:04 -0700
Message-ID: <20260723221409.5874-2-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723221409.5874-1-alifm@linux.ibm.com>
References: <20260723221409.5874-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HVYBf80CMZCwmu5DhCzfvwqQP0yyc0FH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIxNSBTYWx0ZWRfX+ygpPwVVR4l7
 E1euulMoO6LtbnSKvTPUR18TLT2HdV/+sQho2Mv7598pHiv0ccysLlQfuQU/25uPjTfr6L9tFQ4
 zb5QAQrrTFo/66l8WjNqY2KlGGixE5U+NsUEItVAYiee2RZ/ono1KYHo5nigS2NfZ/iN/8pfsGM
 HyEL0nVPVIDtv81/dmpVekbjHS0p3svuxvlzNT22PTASH9hZ6LsGaPwtqo6+m6WIQq2FF0VKZuX
 vWT6TVO/UJvuAOmC1rAubBYubrHNzEGsIA8NSRfLD/7A5Kr4WSQU5bAZ3W9nXFhfoxQ6JeZq8Ar
 m9YcJ0XZiaT/BSytx6N9gsN+KeaQeCE35wPKNltsmtE88h5IHt960ZgyFlRfqzID8hqOnTOePE4
 LcaFbzrbl6NvDoYzgu6pV4rXC+73BhFsUYNH+K7c1v/gAt6Fg/59md052gX4vK0Hl/KV5bHhQCi
 1tQDTPOYjpZM6vMnE2w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIxNSBTYWx0ZWRfXxpeBFRWhBgnT
 i2TRoxZvMOru2MyUQetlVm/MG3/7y90g+y4Z0XjkOKx5dlG4GfSPo6kSURcekKu047/bL/Qii32
 2CSlpshYZm+zGZVW96b2DHGGK4e2TrU=
X-Proofpoint-GUID: HVYBf80CMZCwmu5DhCzfvwqQP0yyc0FH
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a629234 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=G-uFRffD-WzugI8hyjEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230215

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

