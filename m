Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792531488;
	b=Q28nCCxdD/uZs1yS/pSPJM8DRm9ESRnW5evrStodQE2iuF4qufCe+XxfjrClEPLsSN33
	 aMRoWfpeskeI/bp2VjVIw1cxCAf4SZtXRgAYM23xR9yl9mbjhGnB7djH5Ps6liCuHj0he
	 kB9eaq8KCOCNz/mbA50FHaBnFREZsxsMoKzOM1NXEqAM7QFQ8bgmmhKam0nMKMTYehtb5
	 xzy2VYv4KGzlqlMZFWEU7TRTf8+vcpXzw/HT+mNm78CQkWH4na3e5uhbipXtw71ta7KmP
	 1UC8D45heEemuX7loFmPsIsi82q1HyVkaupi2hsEDW4utNb78CSVOmK/yaGGJmtGRVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792531488;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Ugy1MPPX4rX1hKJ3Iu+kcccg2ZINH127EjdwX5suMt0=;
	b=jes+nNat0/gJBWP4BCygnzc/c4OCx5UlWr5FYQcnI+WozlOZHI6dnd//GkBPyMKVH8yp
	 NjSQqiqWYpt2y9A67IJKbwsse4QwKt+MMxXSM02u+sOjHkTU8BC+dkMn6PrdJ008Ph36V
	 oGviKs7mOgp76FKoWzeiC+B0vu5HNJrgLkHZTEljhDpliGx2r1HYIVDzA/OohloadSUOQ
	 gJSWqG7az06IIPTfnt7fqT8pWb+6OuvizPRUzmV2Xl3ZV0QDVGoM0N77Xw1poTICxwapV
	 AGisKsk/j8aDEIhwtfwQSs5fDaQXuJLac+nIPN96AavKDu09o41i5xXoys72zSixHSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pdLIN0is;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C54606A323;
	Tue, 20 Oct 2026 21:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12C54606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pdLIN0is
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KLE46w3671534;
	Tue, 20 Oct 2026 21:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ugy1MPPX4rX1hKJ3I
	u+kcccg2ZINH127EjdwX5suMt0=; b=pdLIN0isF+EByB6IOD6NqQdUSUA2SFHVt
	Vc7pdOLmswPBlxGbr5w5xi/nfCgLu4rhgnO9elUlB6fCp5bAoxC0+PVV5JpqVc/e
	IXGIvQUiZ4jZzPrlUBn8ci6bfJ6am2Nm1Sv3cr82CUhFdW30cIsIhIifecQIuS/7
	GPue1ok3VCKFpqdOqVzGgYAwhtG/fIUQRJURkkKGCik09iBTcNXlJM2OC8UYBmKO
	hpkhvqEegu2lUfC8adWf4xe6q+SSuhXGCexx/2jlCfJ8vqnFQP8a0dpQYC90zpDT
	1RKPuft513kkLyflztRTjmV8S5GgR5Qy/Zc446/8nDZZoi0vkFAZw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw58ngqf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 21:24:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69KLKBT92072392;
	Tue, 20 Oct 2026 21:24:44 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hckqvm7j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 21:24:44 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69KLOeB431064658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Oct 2026 21:24:40 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AF5F58056;
	Tue, 20 Oct 2026 21:24:40 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1AE15803F;
	Tue, 20 Oct 2026 21:24:38 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.240.182])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Oct 2026 21:24:38 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH v10 1/5] s390/pci: Hold fmb_lock when enabling or disabling PCI devices
Date: Tue, 20 Oct 2026 17:24:23 -0400
Message-ID: <20261020212427.2561-2-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020212427.2561-1-oelghoul@linux.ibm.com>
References: <20261020212427.2561-1-oelghoul@linux.ibm.com>
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
X-Proofpoint-GUID: ym4Lt7jAqe4IBRc9aZzIFX7l7EnbXSxy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA4NCBTYWx0ZWRfX4+J9UjtGborz
 5sDyjVGnOY4tPXyFZgMBqty0q6q17crBP0mqXu6h33j3oonKjA7h9pAkBL7yblTQdBiYzxXfbtg
 jJQxFYA+haJOSBfw4qvd+7HAaloro80=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA4NCBTYWx0ZWRfX3//PsAevPt6q
 3qg1ftCg3UGkgPkt2R3AxKFH2bPkNStuFGHPwegdFKu9yW05hewJN03ci2KXRkdH97ae/BorTgh
 zDaMX+ngcEqSy+xDsIQ6mKguzNCJFpqoHIudcDW/mbinHh0hjMx1fO+LfvqLSPI9gdFNRBArnal
 jPUkndmgx4e17rpoTwJZHgPdHG7V9MTo/SZ/vv9gI1w998UI1ehqonzvO6zM/Ixbf/V4SWwQCkl
 wSUkmwfz183qxFPCvQ8zxob76JSfwFExuGfUszm+77uFakbmcNIzz4SwnZI5ol+Uk7MqTwwAe6l
 Y0JhMp3AlQgcmiD0QfLGY5MFdKlvQrnEyA4JK0EM8OgLf55tgbl57XcoiTdqWTQzJtIxV1je/j/
 038mrkDDo8rFIZ2jeTnr/m6PMVn2D0rfa49WXQNQ4ZbLilJbd7yLHEF5rUBF80v3qayssDNysvX
 ilysKlsa2EliU/8ve+g==
X-Proofpoint-ORIG-GUID: ym4Lt7jAqe4IBRc9aZzIFX7l7EnbXSxy
X-Authority-Analysis: v=2.4 cv=Ob4NnRTY c=1 sm=1 tr=0 ts=6ad7dc1d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=5NbLduwtq9nBFWGw9KEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200084

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
index d64c544b32b0..c055a9ad0972 100644
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

