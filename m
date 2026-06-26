Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107E83AB282;
	Fri, 26 Jun 2026 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496607; cv=none; b=VPfyArSgWgAlZLXrxjk7r1xD3HCEYZFnXi8+e+XQFITG0Ezl3IrCnk+FmVny2RAUxQHBWAhZLceMF2lbSBHVvgCMt4untVB8sRGRaNrgy0wjZoAHRyoWKmmVZj1cnmUv756+ABQsN1jWwXQ6k/d2pSQyeKvecP1FCZmaxvEIrr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496607; c=relaxed/simple;
	bh=oXxNDG7sYcOLuo69UQ/Vo3sDkWJVZAcEkQsnZWPBcf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVcFKpeLL1m4sQ5Aj1pMNEOiyn+Gv4UQbq+g6J1vRUJMGWBF/+1mnN+SbGg6JG1D84x7Rca2/40GNb50IVFAg1iQKHhfy2nrUKNg6XbO9VVQG3gm+Ai6qUIFHT4226AC0A0GtM0hebkK25tK9h+xJXGx7JXq23f/iL+He5g4TVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O8eVJLGX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O8eVJLGX"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QFngxD3422898;
	Fri, 26 Jun 2026 17:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HT8vXRuURAaWqNtru
	Ekg48cAzFTFkaZuC4BuEIn1P1g=; b=O8eVJLGXjs6rOZRhlsPdidMp9Y6MH4hum
	aGiP4W75wNdD7kzRMz5Jnz2fXIrT0gr55yqKgRphMfF/bnkk1INijZCosdqyTa5g
	mY75/x2BsmB25DXSdllDzsfn9e6WG4Xf2Z/qZltEvX8obfTvo1HLENWJufIeBNp0
	V4vPvq1KfEc1ObnnuIMfO0dvThda3sZH1CbN9DA/p/zhWjs2+UeYLG7D0wQWyKld
	NodJ6/RIBUxzwlUanlEoOavMeEJV/vjiOx9vsGKrvOsiE3lAnxVgQ4XmhLb+7gE6
	tssgET9ZBjzL06tMOKfik+REQjsYNxia7euhg+9Rzae+MetcRdezA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk50cad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 17:56:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65QHnik0018373;
	Fri, 26 Jun 2026 17:56:41 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phv4eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 17:56:41 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65QHucPi11535002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 17:56:38 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03F0358052;
	Fri, 26 Jun 2026 17:56:38 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57E5158054;
	Fri, 26 Jun 2026 17:56:36 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.243.21])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jun 2026 17:56:36 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: [PATCH v5 3/4] s390/pci: Fence FMB enable/disable via debugfs for passthrough devices
Date: Fri, 26 Jun 2026 13:55:24 -0400
Message-ID: <20260626175525.37370-4-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626175525.37370-1-oelghoul@linux.ibm.com>
References: <20260626175525.37370-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE0OCBTYWx0ZWRfX3p3AqHUwnd0g
 MPQm09vNe6tjhiRxa381nepqNXBy90stgUWQWGuwa8wBwNie5M0u2HAMeaEqmOtvtJziqszavPJ
 JsBK5dG90RvOdZItKs5nscemW/qfQU0=
X-Proofpoint-ORIG-GUID: m306KpfqV8fMdoz4l7-eF7FpI51Ejyk1
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3ebd5b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=0_QKAakMeY9AEM467WoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE0OCBTYWx0ZWRfX+ShDIRFz2VaS
 D6kLjPl0NTRRzhaGB31/XlI7JSRaEHjJmVDx9U5PBNuKL9GAHeXfHiktTOsqTr/1A2rqMKprdG0
 E3P+YzJDC06hMIjrmhtVtTkCQLU2T8B5BESYijR5GzW3NFK/DgPx/pTvQd3jz0fBrYJfjcmn1k3
 A6jHwFnjoXLcGtGLspOBFzaAHsCy1JanIOHsAB3893FTVlBtAuIT2lhr9hDhpySLLkvTSer/JT8
 t7pKtHkJcd0yNnJNgfUjJ7zutpkg+4zhH0Ea1+nhAsDvZXVa4CkTctByHMtk2kP7r8pvT9QAieM
 mMdIO4J8z27KxQMNTJpYF/xNFBFhlQ3sV57ssrm8mXNr2tZOE4H6/9j2HlTBt40j7t17B49oyVf
 t6QZ9Kyt5mGuBr5vYgZCu138huQcVhbQRWdxwvDl4VVvb0UrFGyG69nUCO0wcVeleBe3Mtnkzyk
 fqbABjAT7O4ZzyRtJzQ==
X-Proofpoint-GUID: m306KpfqV8fMdoz4l7-eF7FpI51Ejyk1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260148

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
index c7ed7bf254b5..23eb7e72c870 100644
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
2.54.0

