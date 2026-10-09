Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F149D43B4B7;
	Fri,  9 Oct 2026 06:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526660; cv=none; b=TTIKhRORlObOWGaOUtq0dH8G96T4kwbCTZMZKAwBIq9dF2xUsV806AK6uRcYxy6B7RpFET/Yvfe07a5Gr4eHYZuFkYpQItQ67XK5VgDIRQ7xu/Gb5BxbUJdrl1/9RsHqL4ZvDKIIGtnOi96UHso+qZLMjQQKM1JAFGFjq9yxia0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526660; c=relaxed/simple;
	bh=3KWmeH51qAs3ZIMhBT6dKORACPO7AXkUGcj/b5qDMSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uqSsLeBNt0T1TF8L4Jm/WAakRtVGoIn1lHhp+pzUyxieVTeYQBsoYE7juDe9YGecKcDMkwco8sVyT7Hn/Q8iQgUKYvR/Qqda4VSot1TCoIpVKQVNjAe4uXpH82BqsHdat/dNJoJVrYbuSjpNQ69dFnf7mn10sIaRX00R+MxK5bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cl+GDLmW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cl+GDLmW"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993ZiwB3271800;
	Fri, 9 Oct 2026 06:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CsPz0u
	HtEIX+sHQx/LJ5vocZotR1biK6GowyilL4sq4=; b=cl+GDLmWohXqgs2aZbm/el
	QnQSlLF7dWpBo/IispVvn54LwY4vwiSD56WFkvtSHBNRH3BuAgod4xFNQo6t6oId
	aeUU1ptasfZ3tKsjnO0CoBnawMFYZt9aWqQwOtypMZ78VImC3Oc34sRrBQkSav4b
	R0xrNUWhzyD3V/tqSNi89J+52hEZ/f9DrHZnz1NXpV31c2ZOQN0aQhJtAbd7zORi
	3E8hDMhjzxepzOX+byfWnL0BH/S6LqNjzj6q7tWwZfpb+DqIuwDp2hb7nL9YBtsm
	r3z7Rh5qVOyxeedjumUwgvndOVRZezMdqPVA42c2GQxpYg3wF8yGoWn06p1fbDEw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw0tqr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 06:17:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6993HcbH249360;
	Fri, 9 Oct 2026 06:17:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h58ekay0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 06:17:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6996HXL942926380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 06:17:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D499D20040;
	Fri,  9 Oct 2026 06:17:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C3CF2004B;
	Fri,  9 Oct 2026 06:17:33 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 06:17:33 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Fri, 09 Oct 2026 08:15:50 +0200
Subject: [PATCH v3 3/8] s390/pci: Fix MSI directed-mode teardown IRQ bit
 count
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-s390_irq_domain_fixes-v3-3-ced19028da3c@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: fG-LeSp_iVjKii-kaCbbYH_-wT13Xd8_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAyNCBTYWx0ZWRfX+NsbF+DK2foW
 F82/PHCsuHhGh5FiU7D2+0v8uhpDw6xhTML1nuKM0fUGg5XyBdTSB98qjtfkxTWao+EWlsjSKN/
 YiJR1CnZJf/jb7w8IrJ539JAL1VEORMd6zP+Kuwsp2HWw8X57gSD3CmVsW+uY5vLjYHf+dYYgXD
 HgusFch7XF9EDEeTc3aW47gNIPhtqfkjcwSr/VTl9rt8fFMg2EuHaiYTjgBcgHv0PE+pI82dwTP
 s+JrIrZjnrL+Gdn9B8iC5vDduseq4JNkIq+R0gbWqt74ARHAAMEgh0lGf552l54lakaIiOIXvMK
 Iqdn+P6PvR3fgBFZ9iZ2jNezQH/uAc8+J2+kP7O0iISzPWcZW7somZMdofHxnAsQDGqefPlDFx2
 N5Mt++3Odkag/SZSgnD9u4w7kYX9ewtNTlP5+2BqPgIIpWymm7MeZFoAF7gqwbi90DR5R2uMru8
 Go2YmhUJYvFgdubwoZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAyNCBTYWx0ZWRfX2Rlq29aV/yAs
 0iKkdXBI/3Ep3aFxmkO9zItNvD3HZLtvGJI6tZNtaZWS/fQSN/PFJScN7wQhnq3YciBB3hCI5Wx
 QqcgVVAzyXK3c/Tq89dGis6oK0lQwHg=
X-Proofpoint-GUID: fG-LeSp_iVjKii-kaCbbYH_-wT13Xd8_
X-Authority-Analysis: v=2.4 cv=FLCOVOos c=1 sm=1 tr=0 ts=6ac88702 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=HZfvwOHSaoXKuVtsHEEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090024

On s390 with directed interrupts enabled, zpci_msi_teardown_directed()
frees the platform's maximum number of MSI bits (zdev->max_msi) instead
of the actual allocated count (zdev->msi_nr_irqs). This corrupts the
shared IRQ bitmap used by all PCI functions, causing lost interrupts and
heap corruption. Fix zpci_msi_teardown_directed() to only free the
actual allocated IRQ bit count.

Fixes: f770950a4709 ("s390/pci: Migrate s390 IRQ logic to IRQ domain API")
Cc: stable@vger.kernel.org
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
 arch/s390/pci/pci_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 134f8f4a5cfa..d5763c5feb09 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -342,7 +342,7 @@ static struct airq_struct zpci_airq = {
 
 static void zpci_msi_teardown_directed(struct zpci_dev *zdev)
 {
-	airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->max_msi);
+	airq_iv_free(zpci_ibv[0], zdev->msi_first_bit, zdev->msi_nr_irqs);
 	zdev->msi_first_bit = -1U;
 	zdev->msi_nr_irqs = 0;
 }

-- 
2.53.0

