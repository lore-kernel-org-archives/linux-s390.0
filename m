Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3383EF650;
	Mon, 27 Jul 2026 09:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146252; cv=none; b=Q8KcIyCp9QvuQQT+nHr6BNQlBwlwZnA6TES8zlY+bZaiF3dPC1KC+sbPtTz7/BLsp2MDOspSLzLNuXqUlMo3EPHm1iA3Bc35JA+EhhZKOqdbN9C4OW/BX6d2solfAK9Gu3jrj9fyUo1a2S5OBO+/mf252PO4UgTfVHgx98BM9Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146252; c=relaxed/simple;
	bh=X7sBzC5Y4MVZOi58wpp4PxDp67gcS5G/n2bDbXe4v/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X03ouJVi+DBCc3ubpDiuy1dZq1S1EmoVb/HdwwEUkXWqI4R/jDZNtFIZn/eho8BeG3UniiaVY7qoXyKMARCRdNWeegCWh87JhVhATyrhVttNvoDf5tdIcrRLgpK7nLaEADNSKqEJSYDSka/givgKDMeRqK6YJHPJsT4hwvWa3tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bpuS8QRW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bpuS8QRW"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R9UiE64154491;
	Mon, 27 Jul 2026 09:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+CkgrD4ffuc5Id/qO
	MQXrZXGoluo61w7ggKa6b8NUIk=; b=bpuS8QRW6vsU7Z9IY+AxJHUir/DeuxRsT
	XfRXS8Pe+Z+Crs9VU94lB2APpwpfRJObViOL4INLbxxZZTlWpskPVFzXav5HuxVr
	ryAd8kk5DWAJMqWcILbg4nzMSwsDRKhNg+R1gci5QRn3KrCmVpPqJ9yoAnCF9u49
	xHyeSbd6wVN5xh0+xo8wNx9d3AQd4x7xASAeQx7spZjYy69C3h7RhNKM1zquSCMY
	koufKSFbQLO0Wn0HRwLDSEaRHs6o14AY3xKXNS1FdJ1w5eqCZg8W+5FDvzJ3PsNF
	vg1duYRfhsakuyCu+MWXz3sByL2u2t5xd/1lqR2c1yrGHQXKh+kfw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc7bh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:57:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R9uIPN011366;
	Mon, 27 Jul 2026 09:57:27 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uvvyb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:57:27 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R9vQpa24511160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 09:57:26 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B6B85805E;
	Mon, 27 Jul 2026 09:57:26 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE47C58051;
	Mon, 27 Jul 2026 09:57:23 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 09:57:23 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Jaehoon Kim <jhkim@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>
Subject: [GIT PULL 1/7] KVM: s390: pci: Reject adapter interrupt forwarding if already enabled
Date: Mon, 27 Jul 2026 11:57:14 +0200
Message-ID: <20260727095720.9150-2-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727095720.9150-1-borntraeger@linux.ibm.com>
References: <20260727095720.9150-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FoDCFbEE5eoxObJb0-tw442GFPCLUPke
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5NiBTYWx0ZWRfX8I8tc8CkPNVP
 Ux8cUcVthnunhXAXVK5MUOkgBGxM1YuogWgChv9AhcPrBl8WAeSNDfqRNyOfFictx7aLc6dQnF7
 kJXll0TavZuhKs5i5leEDqfEKb3lvtXHr7dUkwIRyA6/pBw+ihIgfEFq7bCiE0x0XpBDZYN3sRS
 lTDRCA0/VO2N6w+vodb7ZMDhl4ZHRPobVYd574wVL7jRcR8v4vM6aTYCIfYECtAavPxYDUbao45
 AmGLgGYtHz7Xp5JhMcnHqzb+KL8Yqe+FMzDtXl6S/G0uHUCJ068xdcmPtMR3FQvJa7OYLNJG4rd
 pD0uf1CbtP2OVcmQNmqo+3Ds/r3vnWUqqYMr/XPyZdP/wdKCqY4aPBp67iL3OLUyc2IMJyaNR/a
 Bh644ty5cSzKBkjqPfdk7hOuRS8EvA4DD3AIsXMgFtLM4MeAcEF4k+61zy+8FBISXB1cw4YCpn1
 Ul3SEMoi8FHBALwS9Wg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5NiBTYWx0ZWRfX/v1zSRn6UZAM
 sbdQnESEVd6CDfuYwL9OjXwU0bq2A2LJsCVUaevz6/HOoThoQ2qXq/diZeoCjTS0WD1sIYo/fJy
 Dai9IOe5qFUZyV8hB29W5D+s0t3sV+E=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a672b88 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=G-uFRffD-WzugI8hyjEA:9
X-Proofpoint-GUID: FoDCFbEE5eoxObJb0-tw442GFPCLUPke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270096

From: Farhan Ali <alifm@linux.ibm.com>

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
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
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
2.53.0

