Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6762F4ABBDF;
	Wed,  7 Oct 2026 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791381599; cv=none; b=n5jiY/0EN79kTQhPf5WPX9jPWCJlLGsV4QduJOFvA5WNb85HvkcBmEWuZum1BIGJJn2hPbBxLtX4fzQein40lYbNY4l+qS1iLWo64IVX67BZXky3YHXQ4AIwHGpgEftG5Lv2BqrhDb2tSCxEV8MoKfyIwS8xBr8+c7X4xQochHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791381599; c=relaxed/simple;
	bh=F3PK5LDv2ZmKXw2GOnmGtLMKllllatbbYZiRdngBS68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXdyQDdGpOfLRl3GBrtti+LGc5nw82bnjxI2RLt3xrUk0yvikipjSoWIqb1UYJBxkZxwmbzTpZO1lNTqOfrM/ygpAaicHekR98L1U+rqmKAeQDnZVrqOWfdG7cdgfPSMVbDv+Tm1oVLNXtCKAV1mFANt0UdCMT7h+Wi1EdGfFU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=My50G49u; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="My50G49u"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZdNe2259599;
	Wed, 7 Oct 2026 13:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=P0tCvoBXthykq+t9w
	PoVRFNBaQ1u7UDeDvN3hDv9nIw=; b=My50G49uQrW+Y1h+je9CQB7gxCPMYE4S2
	W1B1G7sGtkC4wiK3qPz4uJ7zJNfXxMiQA5ANN/PtfEyx7/2rcR7uVYp0uRoT4ALc
	M7cmZfzcHHmi1HzxvWINhjQajuLCMw7zhHlPn/2oZBkrheHYSy4C3qK02OES0Krj
	pFwhnUvX/D8Znw13A9kTGN08nva3XC3ulDExoMv3n96fiUP9C7BcPsFw19YL+bTh
	db1/WLuXP3s/v/YYMAZjnzEAfJV32fhMZ18MwvNz9+0zHhxWd3BhxmruotRKDnXU
	EOEN0oJIqnjNnSMYDPn0eM69nzstIXVnfz5QlrKyO8KNDEPXiboLw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jw7ku-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 13:59:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697BlYUM1808456;
	Wed, 7 Oct 2026 13:59:46 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvxxb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 13:59:46 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697DxgDS21758536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 13:59:43 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B54E458055;
	Wed,  7 Oct 2026 13:59:42 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C968E5804E;
	Wed,  7 Oct 2026 13:59:40 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.253.231])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 13:59:40 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, frankja@linux.ibm.com, imbrenda@linux.ibm.com
Subject: [PATCH v9 3/4] s390/pci: Fence FMB enable/disable via debugfs for passthrough devices
Date: Wed,  7 Oct 2026 09:59:25 -0400
Message-ID: <20261007135926.82935-4-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261007135926.82935-1-oelghoul@linux.ibm.com>
References: <20261007135926.82935-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8q2X9g-YLDqhuUxnGehAmcF-_vD4R-3t
X-Proofpoint-GUID: 8q2X9g-YLDqhuUxnGehAmcF-_vD4R-3t
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1NCBTYWx0ZWRfX+zTIi/x4s/MA
 AzT5hki60HIiKHlYBLAzziOQ94jegT8FH6khUf39pSmqG1gigXy/Osm77lgn7M4242dZJChKd3D
 UCTOQK0DMnvwk9BACxbtYLC1O4VXUXI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1NCBTYWx0ZWRfX2EGqFASWpZTc
 Y5DMiFtMcs0cMxZIFO2f2ACm+nS5zrn0rimyykKaNaZ4EJLp2e7QJhXSvreTzwGCUBDzPFqV428
 rOkOXXt18oIQZURTeHYsLgj4pNtWuZ8bC0mxyKvMUL34nsq1uzQfUiCiV7ROEUdfASjlWbonvN/
 9xIkqxMWuBem38qKnJtxfsvxQH5SRmS1tYmtU82f1OmybBgrBYh7PCxgM3V649A+Zd4Dy8AMlm3
 qvQJ01fvBTxBv2Jbl5ADwBYrA9ox97b54orS8xWDfOWKA8O5/Px0Z22IB/dM5svnKCCbjPZcJ+7
 D5YjkP8JHVIt9y6pLh7sNxsz8C3JxgXWVuEiUkkU4OrfNrqHInxbYYna1E1OlME9/yBMBAqQQ1P
 d/sp3S4BoVXpxmQoeZ4G56ThQNjnquteER1wyR07nMkwCX/Mh/NAZjmgoqfr02zG/+NGF+q5wLc
 PWdaFk4ZFQtXtoznMvg==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac65052 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=0_QKAakMeY9AEM467WoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070054

Introduce a fence over enabling or disabling FMB via debugfs when the zPCI
device is associated with a KVM. This will prevent processes on the host
from tampering with the FMB while the guest is still using it, which may
cause partial counter resets and inconsistent reads which have no parallel
in the architecture.

For VFIO devices that are not associated with a KVM (i.e., for userspace
drivers other than QEMU), this fence does not take effect.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/pci/pci_debug.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
index 9a960310d4dd..e60ab981d2ff 100644
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
2.56.0

