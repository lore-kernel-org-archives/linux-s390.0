Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D991D47F3B3;
	Mon,  5 Oct 2026 12:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791201813; cv=none; b=lVVb/ZviTM+K4nVwPdK9VEq4FRpFzE1/SJX5cH6cy4WPwkgkZTh77Qo4Hwy6v5AOnZgzYbXPCohnwGpHtK9KqXbzdyHdSw6WGJjOCp4ls3MM5hul2xpbJzvOnmJclG2LVdPIgAlrNlzZ1QDfXgOyIefWAfNN1Qsj/hfhoE43R/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791201813; c=relaxed/simple;
	bh=ratMpSQYgJPe2BtKl1pVTWqIMOnQV6fTARU6PqA9/Ks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FUY1hhPw/flGHOlzho51sG3rLKl7WMbYJ52okueFcX09olAohVNS+PEUlD9khOCeB8Hva1hK8qoJH1fwH8dTLnZhz1VqM2ZGdF6xj9rqvIbHSh+ssfzN65cf/wFW22e7IxkFY9EgLYFHbtYsHsuNk9wAvEleP0Gv9BWWs4IHfwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ftgw7+GU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ftgw7+GU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695BZiH5379195;
	Mon, 5 Oct 2026 12:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=njX9q2
	dBovJRgjOs0uEc5srBN8YbB55OC6UOvyd27Xg=; b=ftgw7+GUYTmS3aRaD0lOBK
	Pdg3Hxd76OSH+ryC2Vc2xJF7b5Gdrd5e4UThOAlNKQVib5WzVFtIeuEpFAXMsokt
	XC6nEWADn7P4xKieeRuwbrcuRi/d15HzKRmp4g7996NtkL8h2OYRdVMqjsV/wdgV
	/ODUaL5skwuoKILoiJNZhMqjPtDFbXzaVQLy3aVSsXX940olBKZFZp7Fr1EadFhq
	AJvi2QAaj3NqEJvHC7iXwrF+WRUtYYj24Cc7AeC7xT+phD3Sxd5PuX7VQoodYgo1
	j+lsqDYw+qCAiuQrZMlXxT2X3pxVkRPzBbMHypghltEGwNW0rEdhmPJr2zanu9fQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jhpqx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 12:03:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695BWWbq2892034;
	Mon, 5 Oct 2026 12:03:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgn8dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 12:03:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695C3PIV25625228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 12:03:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D363420040;
	Mon,  5 Oct 2026 12:03:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3A6820067;
	Mon,  5 Oct 2026 12:03:25 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 12:03:25 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Mon, 05 Oct 2026 14:03:21 +0200
Subject: [PATCH v2 6/7] s390/pci: Set MSI_FLAG_NO_AFFINITY at IRQ init time
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-s390_irq_domain_fixes-v2-6-d45b824874c0@linux.ibm.com>
References: <20261005-s390_irq_domain_fixes-v2-0-d45b824874c0@linux.ibm.com>
In-Reply-To: <20261005-s390_irq_domain_fixes-v2-0-d45b824874c0@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tobias Schumacher <ts@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JC9_hgjtLwD3wDhbQyncBCrEsD9xZnhj
X-Proofpoint-GUID: JC9_hgjtLwD3wDhbQyncBCrEsD9xZnhj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0NSBTYWx0ZWRfX2PRNCaCr7ypR
 uix+WA4lFm3yea5KwS8GA6TZJLBXYz3jsAz378ZkVx1ZEc1faJuoF2OGYvkFf79EUSAG+bjH7WN
 g2vfqdkjzOxYqim2kgCG57Vc7rllUsk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0NSBTYWx0ZWRfX1TTaplO7722R
 YJ7skK3kyE/G78Q1gsI2o2bP/ECQ7Vw5RyZe7MH0d9WjO8dI78H1AJ3/WzYwrkxGAJsCEiXxT22
 DEi54LSML/9r6NnARn/nzvyBn+chwe1X0NIBOTU6tABhKzHj4oSmGVWBMtxhF+pHRZVJ7jsa7NJ
 94p9xusYfLAcu5q0XHkFFSyivtKKg0D+Ljg140yuNFkBXbGd74vFI5M+zrNMVMYgv5GE9ZHkG2P
 /DV/PKx7/kqT8Kkoe+jSefvQo9DRz6fF3jSkAyrciBWPVoPlDZdFVlj0DxN5054RScH+qNo3MaR
 fyCIFI4N9n9SHvqq6zsXHUmxwcOfbFBHNhG6LoQ+F56F44u0G632BUwHBIsJcIrTB0SuUFJfIg1
 c8voDsfnqdd5WZ4hi/XchHFl5VBvRSS0EWZQ3G+JZ96Xvtw//sAL/uxSKzu3Ow6QiNASP7RcvE/
 d4mipC4o93NzBZMfZ1Q==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac39212 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=itDI1dsBLLxKvHJ0Zb0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050045

MSI_FLAG_NO_AFFINITY is added to zpci_msi_parent_ops.required_flags from
zpci_create_parent_msi_domain(), which runs for every new PCI bus,
including buses created at runtime from a hotplug availability event.

That is a non-atomic read-modify-write on a field which
msi_lib_init_dev_msi_info() reads without a common lock while setting up
MSI for a device on an already existing bus:

      required_flags = pops->required_flags;

The stored value is always the same, so no caller observes a change, but
the race need not exist: irq_delivery is decided once in zpci_irq_init()
and never changes afterwards.

Set the flag there instead, before any parent domain exists.

Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
 arch/s390/pci/pci_irq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 682bceb6525e..661867a1ffad 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -523,9 +523,6 @@ int zpci_create_parent_msi_domain(struct zpci_bus *zbus)
 		return -ENOMEM;
 	}
 
-	if (irq_delivery == FLOATING)
-		zpci_msi_parent_ops.required_flags |= MSI_FLAG_NO_AFFINITY;
-
 	zbus->msi_parent_domain = msi_create_parent_irq_domain(&info, &zpci_msi_parent_ops);
 	if (!zbus->msi_parent_domain) {
 		irq_domain_free_fwnode(info.fwnode);
@@ -636,6 +633,9 @@ int __init zpci_irq_init(void)
 	if (s390_pci_force_floating)
 		irq_delivery = FLOATING;
 
+	if (irq_delivery == FLOATING)
+		zpci_msi_parent_ops.required_flags |= MSI_FLAG_NO_AFFINITY;
+
 	if (irq_delivery == DIRECTED)
 		zpci_airq.handler = zpci_directed_irq_handler;
 

-- 
2.53.0

