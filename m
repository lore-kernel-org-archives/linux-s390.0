Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14DE439F71;
	Fri,  9 Oct 2026 06:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526662; cv=none; b=KHglY3QGTLgd1Wfxhpb/O5T6U1bb3UYKUdmVW4eXXIgWWFtDTErRn2I2uTRNN8Vo1Cy05cXNxPoX6nT8Kt+BsgnP6+V4yNty5jXj41gFA8rI9T9Xxp5k4A81c4oIM38IJA9xkHG819ygo5hcKWCP4sRwQML2mBt28Zn0tLRUUc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526662; c=relaxed/simple;
	bh=qc9M4W96aiGSJMdMdBl1SIzGtL7ba1PPYNyXnFDxb2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p8cuKsbBINDJKCTkRxNf5NzIUqaBfDQW3xfU4GHutv40jLv79D3g20GMsG3msDf10AOq3mrUtUb1yltGma8ye5gH8TWj+IegEXjfv6ucPnbnbHFJJIvqq8thztj9jbJuhh/flwZYsvN7PujmXv+Yo0f9i6njznKK/Ncl/qjAeP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nnBQlaxJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nnBQlaxJ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993ZOcf1402979;
	Fri, 9 Oct 2026 06:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hFpNLb
	UVGM2Rp/8xZBoI8lMCuTzMc1dB44zDEVGS/9w=; b=nnBQlaxJQckWc0RRHV5qr+
	99gxEv8rUq4WObbzZi02PB1eOo9T1CwtsFMw1r3985uCrilLH80aZLiM29ZdDlhs
	vw4ylBP79GSd3eERUh8/Fuo8KW70zMoPEEz0sJ8h6i2kRqYg72jQ4kVs+s/PU6CA
	vZTXjw01e/qUHWzuMsDsGndwy3DDFzCufelebHqizR1CD1L5M/riEskis7XwnRdi
	kCEf2NM6DWwu1a17jtIllRLr7qcr0FL1WnSF8V+BbM1wKiQ+5wcghiyhvYG9DqE3
	d5eW6WjVOJr/WTGDMB9e8qeU0bqUwmfANhqsHNHS0HDNl2qcwJ3/FjUhUo3uauZA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw8utc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 06:17:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6993HelL290341;
	Fri, 9 Oct 2026 06:17:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsnhs7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 06:17:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6996HZvA28574004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 06:17:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D57F20040;
	Fri,  9 Oct 2026 06:17:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB2C020049;
	Fri,  9 Oct 2026 06:17:34 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 06:17:34 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Fri, 09 Oct 2026 08:15:53 +0200
Subject: [PATCH v3 6/8] s390/pci: Set MSI_FLAG_NO_AFFINITY at IRQ init time
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-s390_irq_domain_fixes-v3-6-ced19028da3c@linux.ibm.com>
References: <20261009-s390_irq_domain_fixes-v3-0-ced19028da3c@linux.ibm.com>
In-Reply-To: <20261009-s390_irq_domain_fixes-v3-0-ced19028da3c@linux.ibm.com>
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
X-Proofpoint-GUID: 8-wGEq3ax6bid_9nX-_83S_WdkJWSC9M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAyNCBTYWx0ZWRfX8M6maW42qrOe
 KHu+XE6ZvHfm2ZkGwUn1YhJQ5+fFjtn7R9o+lsN8bBETMR5yiQDXJf3mfcIORBmijqSfmoTbyGS
 IZ18e4zYZ8jteyDU6sYPyDsTm7JIgviwSDeqO6jB/oU9L69aS/m/RxjMgP2nmLEuXwoXl3TOFy3
 bZoV5lhKWfkQML77xGqPF9j+4Kcy2ZqLM+3Kdeb9I1Yc+iNrxKEPMh+Be/PsvcZ27So0Q9dDRS2
 +atj/v+xIiV5aSvMX8z2LiJZTY/jP1kaKwCbTo0SZnioVKwYYYuzapMYcHB0JccEZnpbZNU5m1z
 RHTufyzq6un+8DugvwgE6B7vRN4QnMxSXvqGxYHc+AR5MZqBUSDErSM7DiSZyVtU78S2Jx5aWVK
 IStOLutyry0YTdvElUWT18R6pEUFyQhfJrzM6q4Hph3VAa4an0Cb0FTCcydDkXmO16lzX5WQgjI
 xUhaM7kK9jpV11Z9+VQ==
X-Authority-Analysis: v=2.4 cv=cIt1IVeN c=1 sm=1 tr=0 ts=6ac88703 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=itDI1dsBLLxKvHJ0Zb0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAyNCBTYWx0ZWRfX9BnnXKFp2ckb
 baFMeN/RfHM9xAA6UdIz6uCaObnu3meGqpKpOveVGRLfLjx6LgbvYHu2opLw+9Q8LsjmcW9tBGr
 Tid7EZFfhKP3NyAONVlRMLvnpZXvJ5s=
X-Proofpoint-ORIG-GUID: 8-wGEq3ax6bid_9nX-_83S_WdkJWSC9M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090024

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

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
 arch/s390/pci/pci_irq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index bcf11585df8d..b890b55be873 100644
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

