Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8180E46EF8D;
	Wed,  5 Aug 2026 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935457; cv=none; b=AbwvBdQJE18RBj0KbjfHhHdSvHtLw8bvuNXlohkBWBG6zJdwfGhTFLxOAgxwl9emsZVCt53SAKCv6D83jZGsv8/WQobaXRiN1vUVb2a00maFa4Mx9A/QZK54fNGdc/TxTQWrsWinmhOK4FU4rbjhaas5yuRigu83G38k8dEut+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935457; c=relaxed/simple;
	bh=NpJmGbe9miX29VeG3Ei7DSRwIstNMyEf23NkVKyjXaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oREc3G9HLL7Ty0+PaHWz7hgOD2F7W82BWxOdftLCWofCNEtA57NFiPJ2PQl4RAbG+HiRgLmKEIX8VLB2YaTqhd6DeWo9Q32rP367zXYLdAvIawmI5kIsh0zM8RpwWZ75PGKF6zfwtjCFwXymwvQj1Ew0cQYTik3bT9RtabrksvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GQ+uD22f; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GQ+uD22f"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675CHg9Q1940808;
	Wed, 5 Aug 2026 13:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Rk3T2yE6Ye7kWfBhFD9jctLvK6kpleFkVhH6pVxsK
	MM=; b=GQ+uD22fpYdONxLIzpGCGbmGga3Zh21rjIO1Fi2Ul0FloRes0GssFWz/w
	KK1Bpdoj3TQ4vJm/rna4kM/G6usAZ3gvGWq4oZmJXcuT5FS13qQkNbMUnbQOuzaK
	0a5Nh5yFtmpPVF+CWjH4uUOgIrSLnxf4FkYCp+cIhYPr8ZfN/AQFlkzB08VgzqWH
	5b9r9C4H/dzgsZNshJWRcg5zBQa6Wks44sDJeDHSmzZUimvnkESBbpjmbtqPM+wo
	ZE9L11IWin9Iw9fSzc5ZvKdJ+b9wEFmc+MIvM+3VM9gTVSKIAUmgTVc+NfWEBFOC
	Un8UM9D0rf5IRebRC+uSNOfJklq1Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqu2qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 13:10:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675CuHAo023070;
	Wed, 5 Aug 2026 13:10:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhek5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 13:10:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675DAiDU46072190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 13:10:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B6A720043;
	Wed,  5 Aug 2026 13:10:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C656820040;
	Wed,  5 Aug 2026 13:10:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  5 Aug 2026 13:10:43 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id ABB79160ACD; Wed, 05 Aug 2026 15:10:43 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Aswin Karuvally <aswin@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net] s390/ism: Fix UAF of sba and ieq during ism_dev_exit()
Date: Wed,  5 Aug 2026 15:10:43 +0200
Message-ID: <20260805131043.954639-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Q3jq0tDFM36PrcZMGJtwml9rRDbHIYbN
X-Proofpoint-ORIG-GUID: K387me-3siY-6tcyRirPOC6cPoZdLvHK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEwMyBTYWx0ZWRfXx/FOoRmFi9kf
 S9+QcEr6/RaVw/jMPOujdt/RHiKwi+w3yPXLPYSG0Ga+Z57ghshJ6io6BzPGxDfmuoMRlgLeR0e
 xqpwrro+Q4epCL4tvv9nngI+S6j4Lpg=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a73365a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Ep2FSAoXtVLO2NvLzX8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEwMyBTYWx0ZWRfX6tAwATNFLj3G
 0eIsnc79gjxcjGdetmXWIFuyKvtkFEGhVaNp87ZopRr5eOezQJwkod5GSeUZwHQ3Aw9sKXhFZOR
 SPebWYmZ6k+0AJKQ+CLPWm4nBZdpGmyT+Xhi+Qb2eOChrInbgadyGYTGBUou6tcq+wIMk2XCiTj
 bB+HRIUkJ5uVGI+2exPXR8ILEfgf7v7WBoeEVxXgdD551r8C1Vsz1BL1CCJGNjAwB21fQjSGB8V
 GuLCKIAKwr7QcM+hQeSOt3oJm1gM4yAaUVm7vTnwJrn0oDLt9Ew6JimUiW7e4ajZdCBLJK1bUxp
 wQIfu8+5gLIi4wA0YNRPt+I5KhSQB+kPoWy+ukW2YIN3BSCaLN8SczObxI5GWQ3d62jUi83yyXe
 NGFBXfIuTVnqCmQ5/vHrF/bD9wT/DrMmBE2SkNPTHC1Scmp3wi/rQA48gddaKWEZZhLkR/cw+Yp
 EjH2rCSp/W/O/mAWvFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050103

A ism interrupt handler can be active in parallel with ism_dev_exit(),
accessing freed data structures.

No new interrupts will be generated after unregister_ieq(). Drain ongoing
interrupt handlers by free_irq(), before freeing ism data structures.

Fixes: 684b89bc39ce ("s390/ism: add device driver for internal shared mem=
ory")
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/ism_drv.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index d99c588d3e00..242da20f27e0 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -148,13 +148,16 @@ static int unregister_sba(struct ism_dev *ism)
 	if (ret && ret !=3D ISM_ERROR)
 		return -EIO;
=20
+	return 0;
+}
+
+static void ism_free_sba(struct ism_dev *ism)
+{
 	dma_free_coherent(&ism->pdev->dev, PAGE_SIZE,
 			  ism->sba, ism->sba_dma_addr);
=20
 	ism->sba =3D NULL;
 	ism->sba_dma_addr =3D 0;
-
-	return 0;
 }
=20
 static int unregister_ieq(struct ism_dev *ism)
@@ -168,13 +171,16 @@ static int unregister_ieq(struct ism_dev *ism)
 	if (ret && ret !=3D ISM_ERROR)
 		return -EIO;
=20
+	return 0;
+}
+
+static void ism_free_ieq(struct ism_dev *ism)
+{
 	dma_free_coherent(&ism->pdev->dev, PAGE_SIZE,
 			  ism->ieq, ism->ieq_dma_addr);
=20
 	ism->ieq =3D NULL;
 	ism->ieq_dma_addr =3D 0;
-
-	return 0;
 }
=20
 static int ism_read_local_gid(struct dibs_dev *dibs)
@@ -573,6 +579,7 @@ static int ism_dev_init(struct ism_dev *ism)
=20
 unreg_sba:
 	unregister_sba(ism);
+	ism_free_sba(ism);
 free_irq:
 	free_irq(pci_irq_vector(pdev, 0), ism);
 free_vectors:
@@ -585,9 +592,13 @@ static void ism_dev_exit(struct ism_dev *ism)
 {
 	struct pci_dev *pdev =3D ism->pdev;
=20
+	/* ism will only generate new IRQs while ieq & sba are registered */
 	unregister_ieq(ism);
 	unregister_sba(ism);
+	/* drain ongoing irpt handlers */
 	free_irq(pci_irq_vector(pdev, 0), ism);
+	ism_free_ieq(ism);
+	ism_free_sba(ism);
 	pci_free_irq_vectors(pdev);
 }
=20
--=20
2.53.0

