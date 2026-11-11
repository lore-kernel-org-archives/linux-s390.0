Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414513;
	b=A41Zdj9jDrHQ9Pw2i3qYO+J9bvO2ZK7b9d+xkEVDI8WmOKGWVrh/hAks+GNyOGCaBBl7
	 zP2PX84vKH6nW5EZKYGd9tcN4ShTj8MoXUBVbOmzC9W4JIEmn7nk3uxkdt2Z6RpsywS97
	 eHTHTA8FH+TmQFsis8P+XKvSDcgQzh1PRIAWKxa5+7/uGxHA2T+tYb1VgmZLncewbnH6T
	 9bStK2s9qUVPcbyDt+CuYFOEAlYLGXCfsjHaJdYPIa4AQf2BECRw/jB1W6nLCqisRXQgL
	 AYoALPsMqKNeNI72YNX0BMlrTqNWFjhjxKhUE/OWHEl64e0iymtC8E+TQVKVPdR2d0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414513;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=RiXPkXBK79oMjc0qvlQ0EEn70yKgvGLjOF/FFRMgQxE=;
	b=P+AwqKv1PP3QZvfyCytSiUK3zJfdJM/a2zHhg/0yF5UqVcC6fD2WxjDaq5Ss5tmmhety
	 DhyiATnZ+EOw26C4HixLj1dwjHtxul2nr8U8sSTNz/2DZvIFp0l42DzXmHhoqguxViVt1
	 Ieyj7oKVRTjQ19ax1jbAjv6OLw5AUU/ibsiUYq8UCGUG2jlb8ilAm/IlumW9u9tznHZGy
	 ivGSnRvMDpG3xvjInBM9XvSwh+bu6Esj+u+fKfYU8+Jxg02alfHu1OaTEqx3SfuuXwQcx
	 zyCJXQHms3PjLK+VCMRwGBXeYc1pjSLZ/VJgrZk611BKoS47ZP5RgthvCPWP2ncDA9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=q2gAwzKO;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB0606A336;
	Wed, 11 Nov 2026 16:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CDB0606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=q2gAwzKO
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABFEThh237221;
	Wed, 11 Nov 2026 16:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RiXPkXBK79oMjc0qv
	lQ0EEn70yKgvGLjOF/FFRMgQxE=; b=q2gAwzKOrdSDK5UjVallxjSqvLD9Kn/+w
	/83gx0zqjwO9PiWK3IChAAnOc9YhPCIRGZmlUWBbz+FBo7pq4MYAonvMGSdFIpFl
	36fGXIMraHUHv9hW/plwW04TmAVtKpletJRXsh3Y/9yeyqnTjSdDn2uHVFvdLNcl
	g9BO7z55u+mDurClpl5Z/a09y+9EHxX1t3uNkVANaIwqDCPO/tE1mO4zGIrxNPAr
	NCUb03+qcPadjshj1HnHWqaOjRsoEQsM30TarlvGebv0C4ihZUTcPWFsB6vm0lzo
	+gVrS4FvuFOXHxtWSJGy531ujuBagWGIVZZEHbvshFXCR6D40aFNg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdgagts-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 16:28:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABF56kt2382115;
	Wed, 11 Nov 2026 16:28:29 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hvd51tusu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 16:28:29 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ABGSQAS25100864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 16:28:27 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99DB358059;
	Wed, 11 Nov 2026 16:28:26 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FADD58017;
	Wed, 11 Nov 2026 16:28:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.243.186])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 16:28:23 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
        gbayer@linux.ibm.com, pasic@linux.ibm.com, alex@shazbot.org,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v13 1/5] s390/pci: Hold fmb_lock when enabling or disabling PCI devices
Date: Wed, 11 Nov 2026 11:27:54 -0500
Message-ID: <20261111162758.9792-2-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111162758.9792-1-oelghoul@linux.ibm.com>
References: <20261111162758.9792-1-oelghoul@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af497ae cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=5NbLduwtq9nBFWGw9KEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2NCBTYWx0ZWRfX4IGsndVqdzSj
 CVbZzDVZwgINywHzsCMg8dEayL1PqSk4+vNDQUIXzqL40KKtLEbCdwK0sTrD+WVsQdJd2SFM219
 cqDOwAcOua6LhRfrCMJvqu6mimQHadC37CinQv+cByhYlx/hgtr6xwnS9wFwlkVARYw/Pc0Y32/
 2IUFivIb4GXfTvIzTumbQXyipfEuBRluRkgOswtnSW5Tbi0O7/7Ny31zFmU23BSiz7C4NXZoTyG
 NaNpFqIbIzECa5ZMSc2bingnY41DFKaN4Vp4c+LdBRFdyX3OTsKDhzXRkQW+1TtVkZlo8RIthXR
 qONeo6PIQAnD6qCKwiQOYhpU6eoe4Yn9f4v0fcnGolUV8r2PFENwEe0mN/4CgUMLzOOc+Y3J1Xu
 /tJ+HZ/vWFuZL921DywCRURjV29BDd7aS7xMao0zEjhLBgnrrf6H/RFnkrwCELRyw/QFc/+w2oD
 5ic9/BH6HfxozwR0XIQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2NCBTYWx0ZWRfX6c+/XQ9shmA6
 J7bxcOwsqWNLnDSTjsAbEHk7ljMFkDgoRGaSLJBpXY5QRINB8+7zZ9A34K1irIOqEqENOSzo9kf
 R1ZUT0Zs5FNAzn+bMNpG/NNzgahjdr8=
X-Proofpoint-GUID: rrex5CUG5fCOWyxsMSGWj2lg74Xgonuz
X-Proofpoint-ORIG-GUID: rrex5CUG5fCOWyxsMSGWj2lg74Xgonuz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110064

Ensure that fmb_lock is held by pcibios_enable_device() and
pcibios_disable_device() when calling zpci_fmb_enable_device() or
zpci_fmb_disable_device(), respectively. Additionally, assert that the
fmb_lock is held within the latter two functions to prevent future race
conditions regarding new callers.

Fixes: af0a8a8453f7 ("s390/pci: implement pcibios_add_device")
Fixes: 944239c59e93 ("s390/pci: implement pcibios_release_device")
Cc: stable@vger.kernel.org
Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/pci/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 1192fb167d3f..ee1b1759655a 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -173,6 +173,8 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 	unsigned long flags;
 	u8 cc, status;
 
+	lockdep_assert_held(&zdev->fmb_lock);
+
 	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
 		return -EINVAL;
 
@@ -211,6 +213,8 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
 	struct zpci_fib fib = {0};
 	u8 cc, status;
 
+	lockdep_assert_held(&zdev->fmb_lock);
+
 	if (!zdev->fmb)
 		return -EINVAL;
 
@@ -639,7 +643,9 @@ int pcibios_enable_device(struct pci_dev *pdev, int mask)
 	struct zpci_dev *zdev = to_zpci(pdev);
 
 	zpci_debug_init_device(zdev, dev_name(&pdev->dev));
+	mutex_lock(&zdev->fmb_lock);
 	zpci_fmb_enable_device(zdev);
+	mutex_unlock(&zdev->fmb_lock);
 
 	return pci_enable_resources(pdev, mask);
 }
@@ -648,7 +654,9 @@ void pcibios_disable_device(struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = to_zpci(pdev);
 
+	mutex_lock(&zdev->fmb_lock);
 	zpci_fmb_disable_device(zdev);
+	mutex_unlock(&zdev->fmb_lock);
 	zpci_debug_exit_device(zdev);
 }
 
-- 
2.56.0

