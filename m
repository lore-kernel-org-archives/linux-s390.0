Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393D847DD7C;
	Wed, 16 Sep 2026 21:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594457; cv=none; b=TcgX3P7y/SIBFE4KJxFozPB8su+1ny1mqwIgqOnJHCZGn4EdbFCMdU6d0nLVhffJdIv9Fkt7AMKtyyVCOTBoUOtmR2F/O9sTjNbxoyAW6yRGVN59arlt7/dXenhLW9BhNnYVZBWUp8ZA83cHSVJz0HnIWJKnrgLg1UHmzojtlBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594457; c=relaxed/simple;
	bh=yUb8mTGM7zTkL5qaXzz0D3zIGSe4h2+9fROZ3hHYKtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCtsuoYBayvwbCqGyEQz+Lb58Cx34tk38lXs8NpypFPiH+W2iwC1viDnWazr0h37+Qym6Ztnmrl/gB9MPrtd4wdGNuj9WpVfkeWaqgLTIbDQjQEJA33MAjBH68Ta3cuSGV8z4p0OzpakWoxdR2Nrlj2MLHlyXEjRCo+sW1tYOts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DEMM3yiJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DEMM3yiJ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GG1stS4057630;
	Wed, 16 Sep 2026 21:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dbycqcXXO6wFbgsri
	bJvgrXMkHVo7z9Bwk7dOLcpA8U=; b=DEMM3yiJUyYNDqZSeVbIIFahmOuuooaIV
	YYJTWVvEfCx9ncyj2J2Lw9R2H3X4S1gag9haE9UIY6T+0HS+gsIXrfgWZNYlezEp
	+pZ3mXo0iGh/EzqVQ3chvgg49YJ1Y4jCaNrT9vmcGku4O2K5OpElh9wcF242Pbm4
	be4wXGjXepzQPNKFpe5K8A/7mUaUf2EtsDCrrgg7sLuGNV3djbhR7qKWL2HShWSm
	wbWFmWkkmiqIOw4dYQNUmCoPC91t7jH9KXAdApbxhwaRxTNPTXz+FVnv1g7Zz+NK
	zPpCOdfA6x/Jmvz3HHchRc2h+ubaQuyO83GDeZiGL9aJ3vxLUtuwQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5hy1a3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 21:34:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GJ0XSI1663490;
	Wed, 16 Sep 2026 21:34:02 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq089rhd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 21:34:02 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GLXxrw41157234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 21:33:59 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35E545805A;
	Wed, 16 Sep 2026 21:33:59 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 641235805D;
	Wed, 16 Sep 2026 21:33:57 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.251.90])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 21:33:57 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org
Subject: [PATCH v6 3/4] s390/pci: Fence FMB enable/disable via debugfs for passthrough devices
Date: Wed, 16 Sep 2026 17:32:21 -0400
Message-ID: <20260916213222.233-4-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916213222.233-1-oelghoul@linux.ibm.com>
References: <20260916213222.233-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMwMCBTYWx0ZWRfXwtjf5L0DLuhb
 gwbcUnlLXJKk/tb50DLan2mS2pB/VyIdWaxDt8hJCSqoaDe7fUttBWQT+ms9iMH8+jleJg59DK/
 eNaxbH7AjFPbN5lWupkGrcOSRFfV1vTRKZz55Mze4/4XV18uAr2/OTjdZ1RCmj3hXs5WU26P/7W
 7afnnQahfniuLpaBsyr6YGoz9MdOd3lS0Wo74lLEWVIBteVXYPz4mtPiWQ81zGspF6Wv3ShnHAU
 KqwpsutpgzstEWYK74Et1PpX4rCyA/7yt2z3o38YSG9BO5lwcslkoHIsi/pMcGM55WcdZULwaRW
 qYE6rjGGem+HaIxWt1PvrQcha4Zeg6D2ylnnVTogja0AluwH51TJz5fq8ZIngnDl7EPRgdZqAaU
 Mk4xet/wJyF1TMEnbJ2CvkvG4MqOUgPsqHyCpcQT8CpysetFiHycAdAoDVNjgCwXZ8xrOwHRpHX
 Zt4nDfrM5QKfexs88DA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMwMCBTYWx0ZWRfX7KjGavTuo318
 PL5VYPEJ3U3vc4axPnzJTR49nkrHt3chOlOfFVi1zAlgVaYIFYkncioq0WEoJo+lyoVNnxcMlRB
 i6CJTnqQJqhrmBv7EwPrhRbIRsqGr9g=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aab0b4a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=0_QKAakMeY9AEM467WoA:9
X-Proofpoint-ORIG-GUID: PtmmWorVOpTUThUPstGbLyS8m9c6wN1R
X-Proofpoint-GUID: PtmmWorVOpTUThUPstGbLyS8m9c6wN1R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160300

Introduce a fence over enabling or disabling FMB via debugfs when the zPCI
device is associated with a KVM. This will prevent processes on the host
from tampering with the FMB while the guest is still using it, which may
cause partial counter resets and inconsistent reads which have no parallel
in the architecture.

For VFIO devices that are not associated with a KVM (i.e., for userspace
drivers other than QEMU), this fence does not take effect.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
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

