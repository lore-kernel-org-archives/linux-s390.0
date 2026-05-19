Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC476370D67;
	Tue, 19 May 2026 22:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779230663; cv=none; b=o7LckScQX5anOsq8Vi9oab/G91+CWz3AHTZoIpjhgQGF8PUwVq6DcUlL5aE+aqdOf6lx8pYAYyzO13G7efN4D1I34Nw0LvbZISV6+ob/JZlvfwlGCNc2w91X3Eiucl9HNainleIsroiYnblY3c78hDxrc3pJY0rK99EuGT4k5nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779230663; c=relaxed/simple;
	bh=ADBuxpAHmfGju7MPPidYfUdnyuM/6W+pFUa5x6o1zfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqEGF1unuvBaNaWBt+2T24fGT++tGv/mLMKhW7Lgfla9D3Pe34r8+sNLHeglJUHK3pvRsR4zQRcIGkr+tk3M0XuhqyJa/UDNqRVr7vuwcLd6XXTRdDyyyO861goEuLkD5drudmAe5NFvWX3PelGcXASLWLAmg779vhY6nMG+ABA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EHd5fQdt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EHd5fQdt"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JMFtiU4104744;
	Tue, 19 May 2026 22:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+BUYnlGN3UPyA3ORn
	JYnT7dxYFPIvdJZstvzf7IoxRU=; b=EHd5fQdtCZMF1EsbZHBQ0S6q8oCzSUxCP
	DGl6R0RTKtqXXGda7AYmD/MANYQG+vkqVHFxPsmUM8whqQrng3JqbaR6YYIR2wxB
	oO2kx6N13dsiM/F0qs8hr8aF4wkQUrDbDT5Rmbxz0EK3IebVQ6F9ihYsdjf9HcnP
	DyN83G82+8XprJwq+GlKpdgy9S9lCkK7C/eC5oqkCP1e3Kqf8holyMQAiLgFM2tZ
	qkkdv1tZgmjEmdY0/3Dtd7Kw9c5bgsbpgNNB5h7DG8RP8H9EOL0woidN20oYMAb6
	QGKuY+Wlu/ey14nRvQyMbXwuikL/O9/LK6rTl79ij+8mwUe6iFIgA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9xyfeb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 22:44:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JMdMxD021176;
	Tue, 19 May 2026 22:44:18 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk4twb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 22:44:18 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JMiFcM21103232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 22:44:15 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA1B258045;
	Tue, 19 May 2026 22:44:15 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A54758050;
	Tue, 19 May 2026 22:44:14 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.253.120])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 22:44:14 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: [PATCH v2 3/3] s390/pci: Fence FMB enable/disable via sysfs for passthrough devices
Date: Tue, 19 May 2026 18:42:04 -0400
Message-ID: <20260519224204.19154-4-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519224204.19154-1-oelghoul@linux.ibm.com>
References: <20260519224204.19154-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDIyNyBTYWx0ZWRfX7NMznHLmPat1
 i+gz7SKX4M5VVBOdNXHuerH9kGjOYdI+Ksp+1tTTzpSla3fDIpAdZcc5bDAW85WuGKZTxkdGcv5
 WYQ7qDrvYcVC4gZTetV7+ostADIwJuwCGTyeu8DtNMno0xgHJ7Nbej/Qc5x399JAG4w81oBtnGO
 7pb7GxlZDU7f4QRSjnxzrrXaCZ05JCN65/vGcLyn5x2VdWvzI4PN2K+t9my6p1kxgHEQsUY5zbE
 t1Eh2Z7nZFlOPulSOY9tiHBVy0H59orar/YjMlAr1knC6sNhbQxH4CsB41o9q/oY4+W8rfH6SBv
 /XZUEMjlch2Onqh0cTvhnMbGboMLXcAEHJJssPvjCkKXzmxYDsZe8QT2MA/rvZwGkuUxbD7hYJE
 OjEpwPC+vSsXEUB0fjT7FhBmILcA9ke0a3cJMMYnXVh6otrrW8UxvLPZV2TpoCVbLd0PE1P5nN5
 m0DOt9FWYjlyAKEn9vg==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0ce7c3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=LQOIlC5QHTpW1RRPx_YA:9
X-Proofpoint-ORIG-GUID: gpqo4L0SjI6NG4NwGvtlU8cOZYMuyNWy
X-Proofpoint-GUID: gpqo4L0SjI6NG4NwGvtlU8cOZYMuyNWy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190227

Introduce a fence over enabling or disabling FMB via sysfs when the zPCI
device is associated with a KVM. This will allow a KVM guest to use FMB
passthrough and avoid the edge-case where the host disables FMB while the
guest is still using it, which may cause partial counter resets and
inconsistent reads which have no parallel in the architecture.

With this patch, the userspace driver, likely QEMU, is still able to enable
or disable the FMB using the VFIO device feature introduced in the previous
patch, effectively securing what is associated with the VM state and
isolating it from other processes on the host.

For VFIO devices that are not associated with a KVM (i.e., for userspace
drivers other than QEMU), this fence does not take effect.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 arch/s390/pci/pci_debug.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
index c7ed7bf254b5..2601614b919b 100644
--- a/arch/s390/pci/pci_debug.c
+++ b/arch/s390/pci/pci_debug.c
@@ -149,9 +149,15 @@ static ssize_t pci_perf_seq_write(struct file *file, const char __user *ubuf,
 	if (!zdev)
 		return 0;
 
+	mutex_lock(&zdev->kzdev_lock);
+	if (zdev->kzdev) {
+		rc = -EPERM;
+		goto release_kzdev_and_out;
+	}
+
 	rc = kstrtoul_from_user(ubuf, count, 10, &val);
 	if (rc)
-		return rc;
+		goto release_kzdev_and_out;
 
 	mutex_lock(&zdev->fmb_lock);
 	switch (val) {
@@ -163,6 +169,9 @@ static ssize_t pci_perf_seq_write(struct file *file, const char __user *ubuf,
 		break;
 	}
 	mutex_unlock(&zdev->fmb_lock);
+
+release_kzdev_and_out:
+	mutex_unlock(&zdev->kzdev_lock);
 	return rc ? rc : count;
 }
 
-- 
2.52.0

