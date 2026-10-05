Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FEF47ECED;
	Mon,  5 Oct 2026 12:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791201812; cv=none; b=ROhjKjISoZPuxWLuB4S/l9Eqop4gDk5dAlCIIpQbtrCeFHdPre39lYitX8SdE0/gJ0JHqbD2z2X89xawDFy+zLRkjMyNxosGXScijjLivczXDCXYAgEoma2JXjYvZMXhD3yFETPyu4JK/6zkbfkrODgVF689oF+3/KuJMpI3kVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791201812; c=relaxed/simple;
	bh=RCgsjotWvYnjuEQsXJKBSMMrRJ+dt7itoeI+1LXl+gs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JNXYBSGmGcHhwDJjARl8Y/HrMj9C23QYqlhytNgtwb/AFsehPoPbcHx1csyUl971pPeJj2UMs5PdVgHw+PIuphXKGbEr/RHZ1xzfXsI6wyzRWnYO7IUjB9XltFj/GuIaVRpbUFSCGx0pobKMnm1r0wGQP7d/m1tiCZ0KL5Xy7b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AFT2JkXu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AFT2JkXu"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695BZclH379126;
	Mon, 5 Oct 2026 12:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UDBLdK
	ihWVuHpIOXAAbCE7ws4otD8pU53D9M2cG0Gjs=; b=AFT2JkXujgQuKqzic8bMzT
	XjzSHUt1nQ36ibNy3L65v9p7+r3mk8SuqEAyL2dul2OrQI5vqvD67rBwDoOEHqUO
	B0MzOJMazsPhAg6gnbgju6n6sRbimCyg+zmPWxAWpJfeMYvnFyKYpSuWGyJWJ+wY
	fqy3mgXWFDyMKxWYW++Gi2sd7DkjU2BWS7gf1lWUlecBOy/td04QUcoTE+HNrHnB
	IAWB6X13v/GPfqtFBjjCDU1nOhRlGzVUoDFCrRaMErxgRKr1WGcBqvuHJp0vOIx6
	3Y0/ZohoB/72XxAHbfsiKT4798JbeNLNthJtvcFzk0V3wkCaKMG/qRpxbAQfDSvg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jhpqr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 12:03:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695BWdVq2862915;
	Mon, 5 Oct 2026 12:03:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqy53fg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 12:03:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695C3OF642402288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 12:03:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C36F52005A;
	Mon,  5 Oct 2026 12:03:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E87020063;
	Mon,  5 Oct 2026 12:03:24 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 12:03:24 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Mon, 05 Oct 2026 14:03:16 +0200
Subject: [PATCH v2 1/7] s390/pci: Fix double-free and NULL deref in zpci
 MSI domain cleanup
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-s390_irq_domain_fixes-v2-1-d45b824874c0@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: jKtooWpyssd62WG3Aeevzda9svzx430p
X-Proofpoint-GUID: jKtooWpyssd62WG3Aeevzda9svzx430p
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0NSBTYWx0ZWRfX8fq5cWTgqqkl
 lZFx9gImOSGcTxN65qWmBXlqF6yZKMNl/duW8xmbLixUCYEMn/CUpOPcweejXSFER5gUx3QuHgx
 EvGjTZEq8/QPbLk2XtXIYxEetKYVs+U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0NSBTYWx0ZWRfX4G3d9x4tJhVN
 2bwTlSdyBnG8UalathEUvORvsesgF9YdtEJS02EBBo0ls+T1Pk+91F+6qLdxUAp++qTI2qWiEKN
 +C9JciF5SSOsfLQWMgpBezg4tcQftMmT2Vx3Pd3+DuQkOvPYH6a80PorOJECvlhTSgoMxiY1R/r
 v8WyQ7FvFFVaBQw/HgZNOd9hoAifbLWu7YM4wlkf+lXI8BHPlRIeaawBtpW7nA9UC1D4ZJ98RHX
 kZxpGnE7L+XnYbmPpzrM+D8JH734i1FZ5NyeSt1YnnII87PSkjsHCJoy77S545vrHEnOQO/Nwmo
 kyADsptQi+pORIlCZaJ8JNblt7UrXE3InsMZU2d/YPH1S05tofTU8Wz59Or98Anr34mw7ZJvZf4
 tfg/UFNYxP6Opjrkax+gUoxplzga708NjGLbHo+wyYo3OWq2guGVOkvKUE6GbuORRgu0gRTeQIX
 K7fD8gq73xGrmFh137w==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac39211 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=n6EUqp7IjLKcVj1b1CMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050045

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

