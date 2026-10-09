Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DEA3DB319;
	Fri,  9 Oct 2026 06:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526660; cv=none; b=RXWpBEspTY67QV6W8ueaceeam2FHfLrB45a4fef77XQ4i6pTZEtlaBnkIVlQVbQhdvKPXQkNcCJMSJM2jkgbAuqGXUvCph1s0FNkXfPAARjdEBrj+d1vE1+S8WetAWouPvT6M0UYSc0fx+HIrLZOMgvCgQ1srdFGvbouyZ4raVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526660; c=relaxed/simple;
	bh=3rwbqUsg/f2pxYq9UIPVdj6DGQJmKvjI23AYEGtQGw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qrtb9VejuaiLXeoh5tZ5DDLCC6aXpx4r0ZiAoiTPwhxWmKFcG3Jls6sXCONWcMsQlfQkYdHwK+sl4C2SSopmuXiCZhq787AOToKiwqhd0gEwMQJXMi21bt3zgDfxHNH9YYWm4pkJGXIT2m6s+ol2lMA2wauourFSYJYXWebLfjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gqstm/lk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gqstm/lk"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993ZZmX3209231;
	Fri, 9 Oct 2026 06:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=c6uqu/
	8vk8TbpeiMfmyfc5pM4gET2QamtPTDTx8qxcY=; b=Gqstm/lk7P8m8Zqy1NLN/8
	9pkzU+gvipvSfiY8MtYJKcgwjWz7tmmokS/dFwOBlOnXUuPxuNmqNlUWqCogA2K7
	wqBj/GrZmksOAZR6UFDHKN7d5oK/27MOZsk5AWW8LmE6mLBJ62YzL/uv/V7fPpGY
	yLg2C0Kof0ks3Rl879/5IHWgqUB0IuLA7Ase17Zm3xDV8nCmrYhkoMtKUNeik96x
	yuZnjwZFIlmLSHYI+N6mIbUhNKj9mivxD8HQk3Ynva1dZaUCMwpA+iqomcmY7Bk5
	+y5Ge/dxyvbgEFHoqXeSQF8tNorTUJ6FHCQ2pIhHGzwASX9tI7P5mLMNVJ1tB7Bw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvr6ft-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 06:17:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6993HkSG290369;
	Fri, 9 Oct 2026 06:17:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsnhs7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 06:17:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6996HXF742926374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 06:17:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1293A20040;
	Fri,  9 Oct 2026 06:17:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE8D82004D;
	Fri,  9 Oct 2026 06:17:32 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 06:17:32 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Fri, 09 Oct 2026 08:15:48 +0200
Subject: [PATCH v3 1/8] s390/pci: Fix double-free and NULL deref in zpci
 MSI domain cleanup
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-s390_irq_domain_fixes-v3-1-ced19028da3c@linux.ibm.com>
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
X-Proofpoint-GUID: Bk7yXKmzSBbLWAsxfJ762PUSprAAuhlN
X-Proofpoint-ORIG-GUID: Bk7yXKmzSBbLWAsxfJ762PUSprAAuhlN
X-Authority-Analysis: v=2.4 cv=FoOQbGrq c=1 sm=1 tr=0 ts=6ac88701 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=n6EUqp7IjLKcVj1b1CMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAyNCBTYWx0ZWRfX9QjbekdTAXaz
 9gaOeXESB13OObX4mcSzdD1B6dRzRMxsb9HoVPhqG4YKw+qsbdUcjdX+K0FKaIMtIf2zDJaTc03
 Kppmt/sgVvpx/6mRg/g3lgunEnoloD8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAyNCBTYWx0ZWRfX/l6ocZLyAvJ0
 /kaoyBc1vKNVW4DiDvcyFKaLz20ukKgOrKE113QI6MaAh+vBFkCNE0xi1BNRmQR66fsYaWbeih5
 9ZYZ7sObWKZ/XH+pM1F1RziF0HCMaUxW9Wc3/e84mS9g/bpnGMtq7cdVMIZGZcMFXQckWzNIPx4
 VmX+adtSv2mhXntJDiIi28XyEERomKnSK/7kcT8atwHwB7e1QU3G1FN1dxftn8pHYPt41Zp8nAH
 1Rd7VhiDcWbOI9veRa4cectN/bfY1bkWbDSaTbl2oAO/nit8MS4i98Y3sdfpJE+cntM6w8cbYvM
 CNm9aQvbOuGqEYKSrI6mguY0wyCaqEf86V0l0PFAz1atwo3RTywwwBfMBHNl8LhdP/OGmKGzE6f
 2/+aQB+rwt3HfXF/MflTZd7dWmcAb6aCDuXxkmIxpjN1TeoCTTvUmi2n/B0iEjt1jtDQnDWarWW
 5p/bk+vuETD9BQwG1gA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090024

zpci_remove_parent_msi_domain() dereferences zbus->msi_parent_domain
unconditionally and does not clear it afterwards.

zpci_bus_create_pci_bus() removes the domain when pci_create_root_bus()
fails, then zpci_bus_release() removes it again on the last kref_put(),
reading ->fwnode from the freed irq_domain and freeing it twice.

If zpci_alloc_domain() or zpci_create_parent_msi_domain() fails, no domain
is created at all; zbus is kzalloc'd, so the same release path dereferences
NULL.

Return early when there is no domain, and clear the pointer after removing
one.

Fixes: f770950a4709 ("s390/pci: Migrate s390 IRQ logic to IRQ domain API")
Cc: stable@vger.kernel.org
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
 arch/s390/pci/pci_irq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 9c9ed3d8d959..c9520a16ca75 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -533,9 +533,13 @@ void zpci_remove_parent_msi_domain(struct zpci_bus *zbus)
 {
 	struct fwnode_handle *fn;
 
+	if (!zbus->msi_parent_domain)
+		return;
+
 	fn = zbus->msi_parent_domain->fwnode;
 	irq_domain_remove(zbus->msi_parent_domain);
 	irq_domain_free_fwnode(fn);
+	zbus->msi_parent_domain = NULL;
 }
 
 static void __init cpu_enable_directed_irq(void *unused)

-- 
2.53.0

