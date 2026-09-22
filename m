Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627CF4AE8DC;
	Tue, 22 Sep 2026 19:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106732; cv=none; b=Topmwkx7TFqHyWOZRxsbQvudfRLmKYvrKu1t3wWtbqzTzVr8uvu64Wool/sb/+Y2PFnWo4XaVP9PSCA54+XhHix12iIJoAdD7UyEd+OhEWJUjeMv5f2O7HQ4L5c+tBhWSaLrWet8kBnlWMvERS9h8+FaRTz2sulYRfqh3GR6QXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106732; c=relaxed/simple;
	bh=I1fVx7xkfzQZGNlOcQsdhAgR+UHVKsjkiVSiEjNinOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqY5gAeUtm4aqRWfdyp2Btzj2SKT6W67l6Q+Hg3CKUuEB+2TMDlJv/PoNDx+B3EE/c6YVaEUPSdEvSXv0bAbBCU+/PREv9YhX4zI7uK2sF5ybqs0MXo6DCKEoqu+oLn9S6X6MJ3tAnUmGqE4bd9KyzbhtZ4SaGGTdzs/KhWwBkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IbfGAjqT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IbfGAjqT"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MI78Qt1156917;
	Tue, 22 Sep 2026 19:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Rz0dDOvRH7Cb2Oji0
	W3dPt+bW/NxAh3YonG9VziKXq8=; b=IbfGAjqTj2gqHpWwnfuNXbUgL8QqSGPlX
	+AMEiQp2myF4+3bJMzqeTNRrtheocylMW9KHL4BoIrIscSTagVgerG8Y0+4u1Uq6
	JAL7ysre0d52Tgx3lgGTiioMQggd5UCKU9wWS8ZntvP9DSQ2xHOFY2Oew0zYtWdJ
	Jnv+cG70ozPQiW1LkTknGhHgm7c+8c9MVI8difgWX2fBQOjpCQO4PsNzpLujAux+
	ol3nRn81snhB/JkEJ6hTkyRHv+ptYqQd2Km7nKYDq2h370toXS63ySeHS+9zCL3L
	KMUIkkNM+yJgs3HmCOrDh+b6DDMUgfypRTlLRgGcQCfwKNYr5xUbg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv7ctn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 19:52:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68MIHUrB4187941;
	Tue, 22 Sep 2026 19:52:08 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dyb174-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 19:52:08 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68MJq4eu29753686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 19:52:04 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 887C458045;
	Tue, 22 Sep 2026 19:52:04 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB14A58056;
	Tue, 22 Sep 2026 19:52:02 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.246.118])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 19:52:02 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org
Subject: [PATCH v7 3/4] s390/pci: Fence FMB enable/disable via debugfs for passthrough devices
Date: Tue, 22 Sep 2026 15:51:40 -0400
Message-ID: <20260922195141.94548-4-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922195141.94548-1-oelghoul@linux.ibm.com>
References: <20260922195141.94548-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SAIoarXcB7oAvNnxcniHfG-RK1AKzhsJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI4NyBTYWx0ZWRfX0N+t3swFV2O0
 5Ac9EGMHNba7J6VuIaB6A2gPZTQw2DRcj2zREtlQTjCj5GCNUOpC1DNSFwnXebTCDhHp85iYuED
 q6/YJ1yt3rWj5smn62W/yMYju65lPmI=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab2dc68 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=0_QKAakMeY9AEM467WoA:9
X-Proofpoint-GUID: SAIoarXcB7oAvNnxcniHfG-RK1AKzhsJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI4NyBTYWx0ZWRfX7qM+K733pWv/
 VXd8y1z5XQDrHTLBVg9QsfbBZBh4o1d3eUR+89Ta+QohsYd+Bo5IikJcTw+YAjxt2B/uTkFz7PQ
 Z5qkZ7fzdq6BUz+/N3HauGV8czQ30o60vxFUw7WGpdHq5XXCPVlmTj1/B6dIDH/Px3ceOs2Egyg
 QMX2hMOQjpwEpP7MYd6Vcj9yeWlGeIYqYsyiLBAOUbhHUaDXwJpm5QRB0vcYiLMHHCrsvIIVRO2
 5cmebRMtidGS/83yPWtSHwEWTuOrrARVpNr9vTIYqvHBO/1EYEq9/J2Uj8dSDbXCf2DnCUhr13U
 ZAGqVStqgyMBDLZkfTkduaA5RpOX39bxhNklaGfe8VnmMoiYBPFiQW6VbDnrPQv0rGgq8bK0ebv
 FMeNwBVwArr72DlP5pMxGWaJ+kaNAftxdbv6UBQ97+7oCY24FSWrOkAG7W5zRHZGbO70E9c7naS
 tKkaW4tGes1J5CbRqbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220287

Introduce a fence over enabling or disabling FMB via debugfs when the zPCI
device is associated with a KVM. This will prevent processes on the host
from tampering with the FMB while the guest is still using it, which may
cause partial counter resets and inconsistent reads which have no parallel
in the architecture.

For VFIO devices that are not associated with a KVM (i.e., for userspace
drivers other than QEMU), this fence does not take effect.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/pci/pci_debug.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
index 44f026ead414..afc52bd5271a 100644
--- a/arch/s390/pci/pci_debug.c
+++ b/arch/s390/pci/pci_debug.c
@@ -153,6 +153,12 @@ static ssize_t pci_perf_seq_write(struct file *file, const char __user *ubuf,
 	if (rc)
 		return rc;
 
+	mutex_lock(&zdev->kzdev_lock);
+	if (zdev->kzdev) {
+		rc = -EPERM;
+		goto out_unlock_kzdev;
+	}
+
 	mutex_lock(&zdev->fmb_lock);
 	switch (val) {
 	case 0:
@@ -163,6 +169,9 @@ static ssize_t pci_perf_seq_write(struct file *file, const char __user *ubuf,
 		break;
 	}
 	mutex_unlock(&zdev->fmb_lock);
+
+out_unlock_kzdev:
+	mutex_unlock(&zdev->kzdev_lock);
 	return rc ? rc : count;
 }
 
-- 
2.55.0

