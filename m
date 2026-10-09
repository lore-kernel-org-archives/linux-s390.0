Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF03043F085;
	Fri,  9 Oct 2026 06:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526662; cv=none; b=bFghFxshZsprdc5rpraWrtsZyvukBw6i+spI6qapUYfl+eUpRT6PwPYbfQO5gZfKek8mfIpXJTQGIwO/4Pz2DfC2hgKJCjwZ/ilwePONajCe4RRAnLjFbu+NTq7JySQVrWlDb2orSGiKwgFZ95ObI0VRoWpauYrAOcAa4QUntQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526662; c=relaxed/simple;
	bh=hAOO2T2o4Fimel9/dyq+B9wGWrjBadw4KkmhQiAZenw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UoDg7M/C7+r3WLCdg83HvkBR/On5ocUkNUHuPsmS/YaOpMsT/8CoRmW0DeX2g2vxaVwe3CKqf1+ZVSYb59KzLZhm5HH9thxX980qanKHy6TTRx5GH5DxPWxFiNzke455MdvZUoNLsP695vF8BmVyFUmSHZifEgeN66D3vvAjclQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ffoy0Pnu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ffoy0Pnu"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993ZT7x1992232;
	Fri, 9 Oct 2026 06:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=V4sbUB
	ol7KCSHfw1cqZoBEfbCVKNAMI563pkInnKaeI=; b=ffoy0PnuBwZRyqHwhKRXp1
	YZGkfBKj4bE7coBs3D9lm/sGDD90YNKtyFqjb10Kgf+mivxP46cmvkuPZlzBVzj9
	YOi/GrHkecrRaJcxjo58FVtyOwDAS7neL+wiW6eZHyIwt5MSLZ/QDbM0vwpyRnNH
	GjBYHC0RNdFpNfzsLnnTFx8Hb7J2mQXY/wKdqgrCpdQ6fIv8SksUWteScFGIB89L
	FobahdKnetYu8Eks1FdOYg4x/Fnhcw2SlGgEPTGAu+LfI0QhdyZ5OJ/Z/H7SDCoD
	SnfXccwv27czwZ03PFnbFUsR22nVt2T1Wxzxj8CKT2Hq+N1DqDvig4cjqz8hJQiQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xk1g671-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 06:17:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6993HcbI249360;
	Fri, 9 Oct 2026 06:17:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h58ekay0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 06:17:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6996HZxN28574006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 06:17:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DFF520040;
	Fri,  9 Oct 2026 06:17:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1731B2004B;
	Fri,  9 Oct 2026 06:17:35 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 06:17:35 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Fri, 09 Oct 2026 08:15:54 +0200
Subject: [PATCH v3 7/8] s390/pci: Drop the unused index argument of
 zpci_msi_clear_airq()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-s390_irq_domain_fixes-v3-7-ced19028da3c@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=YtCa1IYX c=1 sm=1 tr=0 ts=6ac88703 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=suPEyLX7Zp9e240Fq7UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAyNCBTYWx0ZWRfX64EqDfA5Q+26
 LPx3FabkTwvIgVwTVUtcEkQoldvh5VamJPzDThU8JqIM/S3UjupqgS5AzQ+OreOy8E14Jzr59DU
 uHZKrn9LoAHrWEmrHyo1NcygbIjFUP02Qaf5jq5W0yqln4hFAVMgQCs1/UF4uexGIk4TdElDP7W
 jkEYU0/nYifQIe4WXNNpGnWjMVcsNgw7INxdU9eO5XBmYUCq6v/VZvhgP62Z2yKw8Mg9sAPnON6
 fv5hgT43bOUI0+q4oa0+5DbZgAMUvpB4fIT4kLnboVsaWH2eKBsmefko4vi3JPRe6/UL/Fui0O8
 akbYUbbz4xaFxB/6U4FxeXTcOpg0HSbTAftZmegiHgVBKZn4o/eUAK+n6mj9Ickzwl2pNpAAm+A
 FIqa5BxCdHplymtDEBfaCiLSj1w64tSfdVdfjkgoBLoOAhOY5DSI4TWfsp+QBesmY63X9yUDQWh
 cdUA205U+fMGrAXn+kw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAyNCBTYWx0ZWRfXx5kTMm5MTvLg
 SmwDjHp1J4gk46UFf2hWDG965reormi8sLJ2Dzqk+DnXslpRtaQ6A5Aiu+9tMvkDneyAwSMcBuF
 hiM+mRfER5P8GkG1tYmk2hpFOu0wRgo=
X-Proofpoint-GUID: hcGug8DcTrMAoNRADNa5VDZdR_zWHwyW
X-Proofpoint-ORIG-GUID: hcGug8DcTrMAoNRADNa5VDZdR_zWHwyW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090024

zpci_msi_domain_free() passes its loop index to zpci_msi_clear_airq(),
which adds it to an offset that already accounts for it.
zpci_msi_domain_alloc() stores hwirq + i for each vector, so
zpci_decode_hwirq_msi_index() hands back msi_index + i and bit is
already zdev->msi_first_bit + msi_index + i.

The doubled index never selected a wrong entry. An irq domain's free()
callback is only ever invoked from irq_domain_free_irqs_hierarchy(),
which walks the range itself and passes a count of one. So, the loop in
zpci_msi_domain_free() runs once with an index of zero.

Drop the parameter and the addition.

No functional change.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
 arch/s390/pci/pci_irq.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index b890b55be873..4b8ebb987580 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -446,7 +446,7 @@ static int zpci_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	return 0;
 }
 
-static void zpci_msi_clear_airq(struct irq_data *d, int i)
+static void zpci_msi_clear_airq(struct irq_data *d)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(d);
 	struct zpci_dev *zdev = to_zpci_dev(desc->dev);
@@ -459,12 +459,12 @@ static void zpci_msi_clear_airq(struct irq_data *d, int i)
 
 	if (irq_delivery == DIRECTED) {
 		for_each_possible_cpu(cpu) {
-			airq_iv_set_ptr(zpci_dibv[cpu], bit + i, 0);
-			airq_iv_set_data(zpci_dibv[cpu], bit + i, 0);
+			airq_iv_set_ptr(zpci_dibv[cpu], bit, 0);
+			airq_iv_set_data(zpci_dibv[cpu], bit, 0);
 		}
 	} else {
-		airq_iv_set_ptr(zdev->aibv, bit + i, 0);
-		airq_iv_set_data(zdev->aibv, bit + i, 0);
+		airq_iv_set_ptr(zdev->aibv, bit, 0);
+		airq_iv_set_data(zdev->aibv, bit, 0);
 	}
 }
 
@@ -476,7 +476,7 @@ static void zpci_msi_domain_free(struct irq_domain *domain, unsigned int virq,
 
 	for (i = 0; i < nr_irqs; i++) {
 		d = irq_domain_get_irq_data(domain, virq + i);
-		zpci_msi_clear_airq(d, i);
+		zpci_msi_clear_airq(d);
 		irq_domain_reset_irq_data(d);
 	}
 }

-- 
2.53.0

