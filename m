Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE8337E2E6;
	Tue, 21 Apr 2026 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776789052; cv=none; b=R9qRsuYjB8uzaHs6wAodpMFWSVtKwzpVq8KOv4j7G6ra+I2v/KkAPbeOIWNttWm+uLv5x6jrtxEBjktQ4cxIvIsQUheI4gO3skXXS2e2/qReoFyw7ZILy0PHgg3xEjGW7hJFSuaADN9ZzhKeDe5VCThPuOKSwCGUnKjn21ReB8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776789052; c=relaxed/simple;
	bh=/A4i7jVvjy73WaQOU6JOmUh4l/ODHy9wJnwVOUgyG1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AaUvyvPw0/0XLLVWCnRgomcWBpqHChQK3pyomAp9AZI27+0IVmUrEDeKdsIHDla78znO3G4J5p+kKoz/ygsjqmXzsNYMQYrF0YOtzTDFcJ1F9Na4aqYPBQwA0JMU3IGSCVi8HNGtTbjqLqJJdtBUbxzJ0oC5HRTzXE+kXrnWdB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BCHVM0yw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BCHVM0yw"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LD1pYe1536078;
	Tue, 21 Apr 2026 16:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Xr+EsZK/+1s603aWr
	/wUgOxtfADRseSmWFfwoV44DZo=; b=BCHVM0yw8Qmzrlang3L+Hw+iot0OUvli9
	xo9dzeXWFx8ledpv7xTvIPCHdWN+vH4QnSOktbKiOz9OMBNiZUYi3LGYhIjeY73v
	faii0lZKg+2+KTMFCAbroDOgBj7e5VodLldHXnY2KKCSo3x3T63tn1q6UqVC5aRX
	CJ9ey/a57Dvh7XiVhLWhbV59MsIO8sest7+AM+sVl8XC069hrg3UH6CwaTnWH1f8
	cYRXBJvS533POAYOVYwkqp4FHdP1q7HI0mfbTS+JkIldaFoADRjsSAUbV9DGJsUD
	TW+OA4QrkrwjXziac1ps+fEYAm1dvYGpJvXersRVmZDvHUJjq795w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k6mguk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 16:30:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LGKOJf031627;
	Tue, 21 Apr 2026 16:30:38 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmmnvsjyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 16:30:38 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LGUb6N000596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 16:30:37 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8952B58054;
	Tue, 21 Apr 2026 16:30:37 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 372155805A;
	Tue, 21 Apr 2026 16:30:36 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.248.17])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 16:30:36 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        alifm@linux.ibm.com, schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v14 3/7] PCI: Fail FLR when config space is inaccessible
Date: Tue, 21 Apr 2026 09:30:27 -0700
Message-ID: <20260421163031.704-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421163031.704-1-alifm@linux.ibm.com>
References: <20260421163031.704-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L78theT8 c=1 sm=1 tr=0 ts=69e7a62f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=1owyFLT6pZZ0tE0DW5YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE2MiBTYWx0ZWRfX1qt4z6e4rwcx
 3Cu7a5lX/7BhY6068G5wF6hLQF9BrNx/ylImK2Akl2zDnKxUfALdm04jyBMgr3MFBhRSdz2CHvp
 PYEH/8uG3XAZh5dKGGEOGpKNMV958QaJlW0nmDkaEsjWpicTqHiBglYWz4KGcsam4OdDX+q9s7+
 +7pKEzgNmiuCGnapbnSAL+5XD/BP7gzEsvFYkt3RWH0Nfck44ad0WXfFuy0rPzm6CCAozJVxSyq
 m2DntoixeqPIndovFSg/0taTUeolE3MUEvMlSqnC2SQJLbYPLZdnx2sofCX5i8Y89BnMvy/SSco
 CatX/2CNeu+AKjIRLPE0kXslLOZDOIR7HodRnhlAJsvvXcpybV1RnI1M3WXkUoOB8WT6Coy9Pk2
 ojPTADrIcIuY5uz+Bh5qg/valK5mmVq2IaaI5V5C0BNVKCyM8JwuCDbnP0W3tHUGIupLbzCT76U
 gp7EHBLhFF6khuSwAOA==
X-Proofpoint-GUID: dD6YWv8sIlTvTE2QbxKW59DUV8xbyODQ
X-Proofpoint-ORIG-GUID: dD6YWv8sIlTvTE2QbxKW59DUV8xbyODQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210162

If a device is in an error state, then it's config space may not be
accssible. Add additional check to validate if a device's config space is
accessible before doing an FLR reset.

Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e71b81415392..c50418f5e318 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4396,6 +4396,9 @@ int pcie_reset_flr(struct pci_dev *dev, bool probe)
 	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
 		return -ENOTTY;
 
+	if (!pci_dev_config_accessible(dev, "FLR"))
+		return -ENOTTY;
+
 	if (probe)
 		return 0;
 
-- 
2.43.0

