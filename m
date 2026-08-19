Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9CD2E06E6;
	Wed, 19 Aug 2026 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133533; cv=none; b=I2YpsN0q0A0dGzZ+1mCWOdMkaA+JQdLC0JWWr80Vo2DqsaSxuFMh76MCXTIxx2GnfQEvmQCuIJtZ/+68PwBt58uo7gjgfQYyl7J8/MNWJl2YbEh49Nyt9RG0NUKFyQeEDJyQK883Izjl67mRjstoa64r93ouiH+2yUutHA2CT8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133533; c=relaxed/simple;
	bh=im0c8Us1e8g4dw5CQaFZxdRbG+I1Yn3bv7FFnFcFn+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cSyirS27kOc5Ssd5Cb7QBSGodRUzpQRYFeJGcK2Lzv6Kl6ak/hu6ldQcBPYdnOl3WYDb8aTXapch/M7FfOU5gNeFcOfQykz0FxEcRPKVZq5mekyc4uR2dT9470ZeQ9XbXW9Rtp1P1yMCcYsFIcNVDUDXHeWHPNy0prEHNh43jZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=esbvdDiE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="esbvdDiE"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6WCl5798477;
	Wed, 19 Aug 2026 09:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JGOwac
	b35odkwS/EdwFGZsbS+Vx4Hs5ca1iR+oEAYk0=; b=esbvdDiEuHCu4eORa5YBSe
	Tn/zKZWk5l3dnNoizzO10YSTsKAZCs6hNIrZ6T80hKSvf7oFS9OS0zsfSvPr8HPl
	UN9n9QF3OteH6YlOIABfDfSwtp4YTEcRyUHgHMsaa2v47qil5S3Kcpg8wd5zkiyZ
	ErKixX5Isdnak0PlN7AUwFjf6gLsvBOmccqQCpEdUdmBX1u3vu505rxRGFeYTAgF
	9Xx4gls01UlxD3MxDpFdltOYhp0b6EWzoC79pbGLMaUXya4/z9I8xq/8xoUJ1Z+0
	2zGylYpr0ux/nzoPK27U2FTUXoSuYsDhTxti0N4GLu8WMeev1brF405owt/Sg36g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu02wx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 09:58:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J9uNEI024273;
	Wed, 19 Aug 2026 09:58:46 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yg0wq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 09:58:46 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J9wimF3343010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 09:58:44 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 278615805E;
	Wed, 19 Aug 2026 09:58:44 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BEA358059;
	Wed, 19 Aug 2026 09:58:41 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 09:58:41 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 19 Aug 2026 11:58:30 +0200
Subject: [PATCH v2 1/2] s390/pci: Fix missing pci_dev_put() in
 zpci_report_status()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-fix_zpci_report_status_pdev_leak-v2-1-da0c4aa7c0ca@linux.ibm.com>
References: <20260819-fix_zpci_report_status_pdev_leak-v2-0-da0c4aa7c0ca@linux.ibm.com>
In-Reply-To: <20260819-fix_zpci_report_status_pdev_leak-v2-0-da0c4aa7c0ca@linux.ibm.com>
To: Gerd Bayer <gbayer@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=im0c8Us1e8g4dw5CQaFZxdRbG+I1Yn3bv7FFnFcFn+E=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGLJa63ybtqgYN4l/TZlxgLefnZ3z9B+7n1MuCUzRbu988
 XfbotuXOkpZGMS4GGTFFFkWdTn7rSuYYronqL8DZg4rE8gQBi5OAZjI12CG/1kszXNdmpxkZc+Y
 ZRUJe1p29Ey4fa+3z6fUR/vIdvNHGYwMc9T2elvs2bI4sFPmhrp26JTys6f+35kZdT33fJDCUcm
 rfAA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BksDzR1Tm-AbqphaTYv6AlYqkLSPmjjn
X-Proofpoint-GUID: BksDzR1Tm-AbqphaTYv6AlYqkLSPmjjn
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a857e57 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=7bLVd-tG6EYq6qT3GVcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA3MiBTYWx0ZWRfX9B78tmcoB9a0
 QCHpsEe0xIcPeFsfwHWIyFp3a0mbkWob4IhxhtN8rsTwoCFlRj1VxayLcHnvtQ645eag2o4ux4S
 2lNHthUa5o9mz4N4w4Iw1FwE97lgybY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA3MiBTYWx0ZWRfX6Z7QeMIyWSdg
 csaIycp9D4fieC+z5rD8BFZ8c9/BFbVQ7kicYY9FH6l8r0L9psNMvUzBxBLYjXaTGackTN2pw+p
 BXPcUXoU/juQU6f0O8WkOD7JcOWnzyxbsXo16TGhK8NcQ7pxAFL8T+VJIUuv6h2cVIRTLO3QVQ0
 yeGgk0ugoBofMATuwOiHo03hY5U8en0wRdyUPCU9RYQErTxfq1GYx5diRNBzBzow06XcnZtfiaF
 pj/1KzKBmU0Dgu8TkuFWmkc2r4Ii7KEv/i1C9fodfSb3bdiCFbzc4j7RyfGm7oE5zzlU5jKLDYk
 jUEJRB/WTnVwnd/oTMGgbufhTqmitY+WJHTgK40TlcV2BXEmaF72qu4M24aVmAD+8xjAkY6QnjT
 bWF+tSEYA04TLUIXYP9+1gCZwE6EpYEz2VR6RtEU2OUK9kmMDPBCaAKcwRfIXfjTC4S1BqkokUF
 NBFyDWDqrRHF4PAwXCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190072

In zpci_report_status() a reference to the struct pci_dev associated
with the struct zpci_dev being reported about is acquired using
pci_get_slot(). This reference needs to be dropped with pci_dev_put()
but this call is missing thus leaking the reference. On subsequent hot
unplug this will cause the struct pci_dev to not be released leaking
memory and potentially prevent reattach.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: stable@vger.kernel.org
Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCLP")
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/pci/pci_report.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/pci/pci_report.c b/arch/s390/pci/pci_report.c
index 7030f7052926..76b8afc146fe 100644
--- a/arch/s390/pci/pci_report.c
+++ b/arch/s390/pci/pci_report.c
@@ -151,6 +151,7 @@ int zpci_report_status(struct zpci_dev *zdev, const char *operation, const char
 	else
 		pr_info("Reported PCI device status\n");
 
+	pci_dev_put(pdev);
 	free_page((unsigned long)report);
 
 	return ret;

-- 
2.53.0

