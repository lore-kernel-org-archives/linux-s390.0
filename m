Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E16444A3F0;
	Wed, 19 Aug 2026 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133539; cv=none; b=AdFK4dUPDi5qcw4MACA8DaJltlPs5hHh1xS6sbY9dgfKjdMKRhnEGa46gPssI5NecKRV/XDkpL7fLZb1aJ3xDoYSmhZQmSw+dVe1ERKw+EIyA0j6H6XIYqIkhfuRShZJt6sOG3cTlgLjv1BZE0BiHAK2E44TQ+ohWzP4P6JayOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133539; c=relaxed/simple;
	bh=CaUSDWtz/IVWqQv8Np/XQRShV7So3oHGR2DW3ntXVvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hFgJ/HJE3pwtEirXmjLNjV62/QeemJdDH73vdLd9MNLz20EsRk5K59W1NW2ORo5WLp0WMM2xJMiJZpWQ2tqtTH3uLQ6y6wH0u0w7QhV8PQeR1+lg0HsGXhmsYaLdLtrKvnIHOrwMphaFVkgcmre9RIRVx8t/thwAfqmbG6/FWJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RYMj9ZKV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RYMj9ZKV"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6VsD02666945;
	Wed, 19 Aug 2026 09:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=r7VmsY
	7juywJefMVLNPcTqaVTVgamDPwqXmAefGt/yE=; b=RYMj9ZKV5CnJBl7IFYXbdk
	cY+wHjdubU9r+BghXXlV5fZy7SzVD5+fDkfj1epAVG+lFXUNBorvAxGyj/Mw9EGq
	fdfEM1rN4KXDPPORKkv8rJ66XGv058pPPzhC3ACBIZv4IKaHL2w51Q0RXOSfDP45
	4GfiyokIe3vUDarthtPfb6e95ky3g3wLep7qD3yhvc5xLZF/SweL+/+AfUjawTOn
	kG0l9ezfItoEbXJvCOi3F8xjyoF6TyPCkZ6OQAm4BEeuWwg2rg9Eq42ECuVXezwx
	onimkWUxg2lCJ0fijtcD0HUURTtIcHvH+b5ou6Nthopmt5C+ECzGGdujx1dOTBBw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0ax4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 09:58:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J9uJaU023307;
	Wed, 19 Aug 2026 09:58:47 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngg2u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 09:58:47 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J9wlDs32768728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 09:58:47 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 073DE58043;
	Wed, 19 Aug 2026 09:58:47 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68C1A58059;
	Wed, 19 Aug 2026 09:58:44 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 09:58:44 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 19 Aug 2026 11:58:31 +0200
Subject: [PATCH v2 2/2] s390/pci: Extend device lock to cover
 zpci_report_status()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-fix_zpci_report_status_pdev_leak-v2-2-da0c4aa7c0ca@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=947; i=schnelle@linux.ibm.com;
 h=from:subject:message-id; bh=CaUSDWtz/IVWqQv8Np/XQRShV7So3oHGR2DW3ntXVvE=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGLJa63yn7i4peB+Xtu/Lqk8C25JyLuW4rhd17poekHdpw
 ZL8AJNLHaUsDGJcDLJiiiyLupz91hVMMd0T1N8BM4eVCWQIAxenAEzkzj5GhsMLatnFfF0PFs19
 cebTudXLDZj3Mr06/0pj88Tj1xJfTaxl+CtVMVk/rc470Ofm6x7/HbxP/Z7N31CxdlNHxHaNT8Y
 BZ/gB
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a857e58 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=9KfxQkRVItaoTKmxOV0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: u-dRpCLs5L6ggs4Rw6q100LNRUxXjVSg
X-Proofpoint-GUID: u-dRpCLs5L6ggs4Rw6q100LNRUxXjVSg
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA3MiBTYWx0ZWRfX0uPh4c8Ewy0l
 A66uRUX5H4JdZ/DzvL166Wpm7uvCbdNd2/RxUQ5lAfiu6IMiafHxy195lwvDY6/Vq4zrAjnG4Rx
 KigR7tgR+vZxCXoL0Pnors/pz/NX1iA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA3MiBTYWx0ZWRfX63yb6ZbAnWiu
 vkN2L9u9gwIgO4qksausoDP4e5g+7ylUC8aZwHiO36Xf1kDP5O1l6SEGZEtErJvEalfqMmXQ9iK
 pLt4A7X+BUg7KmWvilan0FT9YZoRcjrvQ7WT3UffrDMrigkvCcm5yy5oz9j7uxSjegQfhRQD9f3
 K0+WWUVV69HTdfNBqMtMu54Jo8zdrPZIz4S+MAdDKKbwV9bLR30Jyt5SRChf0DpCbNl3E5Cnf24
 3IQ/r/+S9DC+bvLsIze3K00QWAWgSGjUMHPy5j4E5zfBtkWUld/tAojEKaHbimpJmLfoaTEDPSd
 VPOHsR4H8JbCARCCprfGkFExfbskqLjxF4qmj1t5LVs8QMnCIWKCszFtMpnpypsULhUye02oDeE
 oe9dEIk7Jf5ddAze2F6GHiTyL1ljze6dDa+dD5ze4nY3/vlW9jPDoSaZwX8KmbX/xXJum8akeJP
 XgSr3yHcaYzoYHWm1/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190072

As zpci_report_status() accesses the device's driver the device lock
needs to be held. Extend the critical section to cover the
zpci_report_status() call.

Cc: stable@vger.kernel.org
Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCLP")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/pci/pci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index 839bd91c056e..48c150d6ba81 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -256,8 +256,8 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 		driver->err_handler->resume(pdev);
 	pci_uevent_ers(pdev, PCI_ERS_RESULT_RECOVERED);
 out_unlock:
-	device_unlock(&pdev->dev);
 	zpci_report_status(zdev, "recovery", status_str);
+	device_unlock(&pdev->dev);
 
 	return ers_res;
 }

-- 
2.53.0

