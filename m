Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2217A40962C;
	Fri, 12 Jun 2026 18:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287864; cv=none; b=MFJlbdXVzYMTCMxKM94is/CsyGYuTljUUVIdGUCUSF3TjwyZRx4wF8CTxL2OZFHEBFkLB8/F0quwuMqDGCtiJI3JFumBTk2e0TlIebQKg860JLPOhhizMcwMib8TUn4d7mDyTimxaavM3yWnNSV8uS/D5Y8XocpLTXuSSx6v1KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287864; c=relaxed/simple;
	bh=+/MJbz1Nx9N5DsM/+uCTrYmoBCKXQgRFW6ylS1HpNR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQzkEf9fE8+L2dcv0GvFQ0USzI20u2Es2d2IHUVimgqTG5cyfpwX/QC/uoKxfhNCh/Opn3GVzRv8mti6dilNKZzB+UIvv4AnuLY/ZTRx+89ZdRQWtLR8aSPPZxdo23gd6Jb8uw3JF5p5CMnWyEy4qsD8rNX6lRXp74KclPmG3RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H0fh107M; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H0fh107M"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CGWSvH1725605;
	Fri, 12 Jun 2026 18:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SsqudMM6wancz+w4e
	1ii3g/z8aangAqp0EsDxJEqIJI=; b=H0fh107MFEhi2WGudUfIsd15wjdZboLmi
	LLIQgjoSOMMxCyUxWD2RiJ5VjukyfjEwpSJlDFXUA/G8v7XoIFN+mfaC/psjjxb4
	RmB+1PuwfMuUEC1n1v2J7mdQAjt/4XZLkgJgjqz7vweSr7KFlixxH5WFN2EfXcTv
	BY0iQx5J8FMd3dQJBBql+66Ty2fyFHukR9wLuWWeNdLKPGi7o6xq8RHcFMPJTXyT
	i7y4Y4KW5n2DYqzM+OA/oo+17LrHqMWndmiECVCXYn0JzdtPt3qSWQtkKmOjbJZ1
	V1KR9OS6pARBlJv7uTrmzOYp7YPLES3A+bV9o761mzx2WxFlR2zHw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8e1w16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 18:11:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65CI4aoK010572;
	Fri, 12 Jun 2026 18:10:59 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe0a91vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 18:10:59 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65CIAtb226673740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jun 2026 18:10:55 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F6AF58052;
	Fri, 12 Jun 2026 18:10:55 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7131B5805A;
	Fri, 12 Jun 2026 18:10:54 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.255.20])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jun 2026 18:10:54 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: [PATCH v4 4/4] s390/pci: Fence FMB enable/disable via sysfs for passthrough devices
Date: Fri, 12 Jun 2026 14:10:48 -0400
Message-ID: <20260612181048.91548-5-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612181048.91548-1-oelghoul@linux.ibm.com>
References: <20260612181048.91548-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6i-YppnPb8Gg6JKUbOYK0dHfi6bs0XTR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE2OSBTYWx0ZWRfX9U/U/eiqhICM
 4sh7BC7fr38ih3jmiaXyxrSPjYYAwjNj6MHGIZO62BfU4Cy5qGVtsfUHzHYICV31h80l5TV5zCz
 LmqZGM2sz2aLRJzxe2jL4ePWt1Vaaz0kBlERAKEeHGvG/ydJ8fzF/Cf3iHnGDQpJmxUXV8HiDJt
 XJr78/0tv61NzGrd5KmLS5nvmRdnhf/5M1NOIHO/fXc4ciyAHHq4OUhjpZlBWM7w/jblAKo2PSb
 55KnwopReF+EiTFICuq5DhWSIZrDtQN3QNt/9Vmn6SnVw9/sxrPBPnX4NRFCgGjMxKq4QK0Ay0H
 ncIGhTTLzBhfq4SA5gnUmGW3VoyVol92AncIW5LF3OSLD/fEAzV6zMN0putIGPqjcQUGDS9iSCs
 A5IBZvYVCjvsHznOUq+cAceiglI4+SPGM2gCCxrkeQHkiT/tFm/178/qhG23igDlXFC+28DqmYB
 nFNfo2KkqS4Zb2j6H2g==
X-Authority-Analysis: v=2.4 cv=DPu/JSNb c=1 sm=1 tr=0 ts=6a2c4bb4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=LQOIlC5QHTpW1RRPx_YA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE2OSBTYWx0ZWRfX6vl13LaxdeKd
 PmLl6rKjd0jy0Ap6NxZB7X9Ox/mHHgKP1qcukLrXS1lCH2IEBvTxDKpyPYoBncLj9P7gA9UhNuw
 nhFqfG+Ai1C2HBrgb+c5tsQ66HA45pM=
X-Proofpoint-ORIG-GUID: 6i-YppnPb8Gg6JKUbOYK0dHfi6bs0XTR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120169

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
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/pci/pci_debug.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
index c7ed7bf254b5..a2dc79418c21 100644
--- a/arch/s390/pci/pci_debug.c
+++ b/arch/s390/pci/pci_debug.c
@@ -149,9 +149,15 @@ static ssize_t pci_perf_seq_write(struct file *file, const char __user *ubuf,
 	if (!zdev)
 		return 0;
 
+	mutex_lock(&zdev->kzdev_lock);
+	if (zdev->kzdev) {
+		rc = -EPERM;
+		goto out_unlock_kzdev;
+	}
+
 	rc = kstrtoul_from_user(ubuf, count, 10, &val);
 	if (rc)
-		return rc;
+		goto out_unlock_kzdev;
 
 	mutex_lock(&zdev->fmb_lock);
 	switch (val) {
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

