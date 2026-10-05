Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FD24CDA2B;
	Mon,  5 Oct 2026 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215254; cv=none; b=atb11WPeKxWAfHnPSui30diFIiBeQnsvkoOr7RwUMYiMMYN22S18DV0/BWZF/Tbwirn/p6i5LndASkxkTbLnwHvG288L/8PfDFH8y8K78IB9p/FaATKu0BFeDcm2QSZGoAalBrFj2GCIwGzeBLWrGWljAlOpDXFYNkhQC4al7aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215254; c=relaxed/simple;
	bh=I1fVx7xkfzQZGNlOcQsdhAgR+UHVKsjkiVSiEjNinOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJ4k3slTuanHr7Qu2Pm3MxpiIs8B1pL1ALiJ9BnW6sz60qEF3j5+4vt4MCkCuEzAeG6YsQA28VUn/X6ev0zHK4VIu2tLXNnEV7pIbdBXO15Gm+V9+2tzOn3MI4JGFjfxFDVzIbtXAm0TWFvp622qGsjLJOh9NJrRPcN7Bzj1MXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E1yWfH/L; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E1yWfH/L"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695EZb19756371;
	Mon, 5 Oct 2026 15:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Rz0dDOvRH7Cb2Oji0
	W3dPt+bW/NxAh3YonG9VziKXq8=; b=E1yWfH/L5q1D1X1IgUGjHYxVeuJQuru9R
	tZVGqoGIy2P8ZUFYo+3qa2PjyUiw4JNa0QC+mH8BEnL4ity/tsnqRHPjv0UuWg7r
	7WB16wMAfHRZkNEI252jFnnGn2hT0ATXjBfEeIIpM+jDYjC3/EmK3EIzbUL3w8mI
	HxXue1FlTfQyAP1Ppi6zA6FGJkvtzVfblJRQfuEl6wL74VZQPoz66sD6efeCeP/q
	4/y+e22ygn//aTA+ShujhKoeg0DfU4urmK5Mh57VoomI84PKJtERVBkJe1KQFYVu
	eMJiN09t7SzRu3xwEYxnN0ilO3XCOpH8ToHBI5vs7n3miq0UQRbUw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jjrvv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 15:47:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695EWXwY3050674;
	Mon, 5 Oct 2026 15:47:29 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1pp981-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 15:47:29 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695FlQPD14025440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 15:47:27 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B491458055;
	Mon,  5 Oct 2026 15:47:26 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1F6B5804B;
	Mon,  5 Oct 2026 15:47:24 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.252.89])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 15:47:24 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: [PATCH v8 3/4] s390/pci: Fence FMB enable/disable via debugfs for passthrough devices
Date: Mon,  5 Oct 2026 11:45:56 -0400
Message-ID: <20261005154557.57801-4-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005154557.57801-1-oelghoul@linux.ibm.com>
References: <20261005154557.57801-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rT2ctG7rltgINdWW1c6_XZFVc1yLZquc
X-Proofpoint-GUID: rT2ctG7rltgINdWW1c6_XZFVc1yLZquc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2MSBTYWx0ZWRfX/uJwtxUA4sDc
 uVeRgfa7onm99oHlwn0KJucm0wvit4RYEhIFSKVcmIIr0bWpcS7LOA2ttBU8JCyFX1SKY6aD/iw
 mapzzp0hzcGsjatIFFoy1kUMg7IIHxk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2MSBTYWx0ZWRfX2usjC5I+dRV6
 +nb/dfajZplLZ1DtwWfouk3DcaJzo/cC7+B+2ofOJ3N3RXUUcMkCZFVSPSsAUyoxN7AdWzGNau4
 Pem7iei5G3NOKLhudPPl5LxQWr4C86kXgDTV8StRfPRJla2Je+p38kyKrXH2fntiJ8gaEAewA83
 ELL6rfkxdkS32DvVES6KbfyVgC2jXUPIzkED2pqOCdagP4125/yB1bKUTMwsOeCJgBcsirs8OWd
 RWIDKYrvv2PbSLAvK+lRhaMZVLE+VorS6wkIdsK6zkuDsMsYM1sm0XogArkj/5Cl7e0WPWPndjS
 D9V38xE0GxSwEzAKH/JIileuB/kjtP836xr+t8B3ehvS2H0YnmuZcGXjPzVLPmXraiLowdpgggV
 EodIoZ/JBiQesZy2+oWAb7n+9HZAnr6fu9cr6ZaL8uFg1vbHgdL5BCkRnIKltBjiyBT/1Lq2yXM
 11PQKYrlrLpn8QIwQng==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac3c692 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=0_QKAakMeY9AEM467WoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050061

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

