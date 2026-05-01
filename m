Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA8622F74A;
	Fri,  1 May 2026 19:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777663679; cv=none; b=kjQ9lTA50CuPANrbu8pCzG+2+BWmGsHGae4ahXTjbFI7THi4wyLDQgV7k4jL+0w3o9arG443RUXm18CObd3VaNrYjI/1+D7my4lM6DNGGskSiv5rgqwwzGlQioIZoJGwZZC+4GZpUrklzu0C0k8UkF2pmT6ELNiDjuOPaTB2sdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777663679; c=relaxed/simple;
	bh=Pqe3GwHtSZcK2T21A0SqmnIEyCF0+g9fH8a3c/J1xaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=niVyHdStvjt4JQqU6OX0wg183w42jWbHquyhggawCzqtTMs6p5BQH+ITAXdHy5NV5U5MiJOo3ttj5PSZmdCYIBopngS6ny/4mmtnckFT5ShiCuY3BhMe7g7aHz8FmV5RcvilIHUggGfuWxgwtjfc1p7QapP8SJsYuizMfYVJoj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=at7idcfj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="at7idcfj"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 641AS1oe1381532;
	Fri, 1 May 2026 19:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jN438DebSZsUDDnLH
	E5asg0DK+u7w1VCo7Yf7QJkQG0=; b=at7idcfj/jY+wRBb5IsHVY2Uabm9zCrgG
	CWtmokQI0Ib/j10y4rnyTb4VcSoRhCfzEQAXFT8TRcxQcC2/CAYxub0+G1uY5ytc
	ML5Nap9s6ujAoBuurZQDmJln8PbAipnEDNRZKJhFSQ1OtUyybRvGxX8dThyyNsYc
	y00lgVDHhHIRk+A0+oFc2ELER1oy3FvDOLROdzQd+W51C2sCbL4dV4+lax3l23vH
	S2grJfAulFMBYBND/Z1iemmKQm1j/Gn4vokarrwpT4Rm0tUUfvBrK9VNsuw4dsQo
	3dPLubk0vuXhoF297iXe/MzFA5if91ncrJqxujE99O122xrLzyt6Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1k49yt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 19:27:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 641JNnGI004255;
	Fri, 1 May 2026 19:27:54 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds9ehrrb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 19:27:54 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 641JRovL25100942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 May 2026 19:27:51 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF89358059;
	Fri,  1 May 2026 19:27:50 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27CDC58053;
	Fri,  1 May 2026 19:27:49 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.247.25])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 May 2026 19:27:49 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: [PATCH v1 3/3] s390/pci: Fence FMB enable/disable via sysfs for passthrough devices
Date: Fri,  1 May 2026 15:25:30 -0400
Message-ID: <20260501192530.9429-4-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260501192530.9429-1-oelghoul@linux.ibm.com>
References: <20260501192530.9429-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE5MCBTYWx0ZWRfX4r2AKb//1Byy
 /q8Z0yH83gWHAj70TtsqKBp3c2xDHad2b3W/Va2xGmWCIiriTqSfx7nicc82aDQv5SYQaS8RJlX
 bPYLVTr53pag+iQLlkyqsnuEmz4ufuVVpfjmNA3+Q79b4kXSQfaIQKsSycyHDad/X7CkwLi2Wls
 BPpZ1y+/PtJRXKAaIWWDmTD1hRtUvX/e1DCbu4llh4ISv/Ja0yqCpr4By/LgVK6ivXRbvS3nDIL
 Pjdl5C/Z6Nyk0m1ZRWowR8HHX0XaV3nh2E0wtAbu1OuwC9hiOFdLNbhTSkMu8Vgy/kZQVoW8J1l
 ilx4dghH6uc3yrGSIUoXF8J6fx7T2QuGYt+oKCsus0YQiTSaH2g3JISEbp86xjJ8b8jJDQAJpkU
 qG7K3lcuuoNZdGptqHaaPsS7KZQvOM0yeZkC0d1/eGIgmmvV7OwwCETs+on3IpfJPINTVOJqVR8
 xpI1y/GQJtS1sVYSGoQ==
X-Proofpoint-GUID: 9z_iCkJRxIl3kSXIM-RI_xs5uyML9Yge
X-Proofpoint-ORIG-GUID: 9z_iCkJRxIl3kSXIM-RI_xs5uyML9Yge
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69f4feba cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=LQOIlC5QHTpW1RRPx_YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605010190

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
 arch/s390/pci/pci_debug.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
index c7ed7bf254b5..b28923395d03 100644
--- a/arch/s390/pci/pci_debug.c
+++ b/arch/s390/pci/pci_debug.c
@@ -149,6 +149,9 @@ static ssize_t pci_perf_seq_write(struct file *file, const char __user *ubuf,
 	if (!zdev)
 		return 0;
 
+	if (zdev->kzdev)
+		return -EPERM;
+
 	rc = kstrtoul_from_user(ubuf, count, 10, &val);
 	if (rc)
 		return rc;
-- 
2.52.0

