Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EAD365A03;
	Mon,  3 Aug 2026 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773381; cv=none; b=G5dk29/3oZ+T0mXbVrZLY6JlPCd6fA+36GHA0z01tho8VisDlgH8HCThcvoR3yOd5R8WV9GL5EqOZegxzF2a2HQShpy2H00mDTMrYnxm9Q7OIa+hDbvJo0e5CQd8jI3ijvnwasH0L8BdxQQmKnYUc9oIaqp0AXtZNfAsptGjY8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773381; c=relaxed/simple;
	bh=B1msya67s3fas7tvXdb0RpnnWeQtT1SbZPzrr9m2BxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+yzn1HyHQgsqdoNcyK3NmTOQZ/zqFoG2nrNkBn/c3eqU9zulfaOAu8EX34CEDtaFJibLlCV5Wpo9BxlIuy9CKTqNOI/Rm96H+iPmi2G4u6/rXmglJ/4TYiuFTjX1k7npX05goYqWmj33yNWetQRBWOMWkp9onRtdP+iZX7Z0+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IBU46jff; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IBU46jff"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EIF1A2342028;
	Mon, 3 Aug 2026 16:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ix0flsG4Cnb5rmliN
	HvXEzlrR6glWWcgzImNc5yA4/c=; b=IBU46jffYrQ8aZgNB3asfH5gaoBdYVVv3
	Ekr2UB/Oxoidpgg1G+8Q2Z6q97MZiUPaFQJY2seTT4JMDN8C0p8lA7YuQRLvlN3B
	gAIDXhpDeHTHhit57czSuv8s4pg0RfrCDrywjk0lzcGwaDlUfRnkDMNEFraDFsTD
	xFYXhzJ99lEhdckLOsX2/3c3iEukzmlHO/UeehVeCQwxGo5vOCF8bXqkIH5UJQS6
	goj8nWx6BxlB5r5GYT+qyYNmTu3++UQWRkOGPX+6rKAj7HBOWdw3FzteLHdlugLQ
	0ZpOsyWpw3mKO2Kt7PtUo/ZtgF6mw+TO6bCYG1qBEQ3nyIjHiiNjA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8euhbf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673FuGEJ022260;
	Mon, 3 Aug 2026 16:09:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg5xyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 16:09:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673G9QmY49545624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:09:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7905220040;
	Mon,  3 Aug 2026 16:09:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 565322004F;
	Mon,  3 Aug 2026 16:09:26 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 16:09:26 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 12/23] KVM: s390: Do not free SCA if it was not allocated
Date: Mon,  3 Aug 2026 18:09:13 +0200
Message-ID: <20260803160924.236807-13-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803160924.236807-1-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: C076yU_6IMYBjLB-K9vKqlm2YOrFLkU0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX2QCGn1copcxs
 vxsI3Yg2WolmozD4Yzgv1wo1FUv1rbFl1l+0UsOQGgCnzWZ8m5TdXxev6TU57QqJcsNhxup8gyi
 /38x2NmmJaxxo9MaHTo4SajGE5WW1N4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX97M0icday8Z4
 ZPkkUVJzr7t3fJAn7bYYS7zyyxmkT5ijYgew+1P4m4cL3hXVEZU23mx59yC2opdQtTB9b+uP6u1
 Db2+fWU6tI2aDLdO4rXlDXe8p/lmNxijWKoudHVO/+ZmIQ4uDlaxfQ0rmFxMKNZCEJxqw7Afm/S
 kaeUNPjISvbOengbR3U23iCP9DGhT/VXhpf/zmJsXagTFFq78RyiDbhWLeS8+1GwnTTE6s52vu5
 K25d27CNP8Qm9/pRrIKXHrdg0yfx+8QMY1h0eJe5Lp0F5zpfLWNjuxJ2Y8JhAhNn8uy6C5tGSWy
 y/UpU1MGIiW6OWHdB1N5qjakR6Y4D8gFyWnf9MqSrsreBmAxN/K4PVYV1ahdl401zroBQREDAYw
 zoOafSngo+hiJGg3bdtivAsmaSkMWnF61RYeYUvlh5R6AG3wdQlQzYDg3MIj5ukJru0UmLaFXD6
 nvSFaoxIktPkiSdVS8A==
X-Proofpoint-GUID: C076yU_6IMYBjLB-K9vKqlm2YOrFLkU0
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a70bd3d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=M5uM2SGDJJfKum1V:21 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=3jiQNkuJ7WxZ42At8I0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141

If VM creation fails early in kvm_arch_init_vm(), the cleanup code
tries to free up the SCA, even though the address is 0. Due to using
free_pages_exact(), only the first page is skipped, accidentally
freeing pages 1, 2, and 3.

Fix by checking whether the pointer is NULL before attempting to free
the SCA in sca_dispose().

Fixes: e72753ed1267 ("KVM: s390: Use ESCA instead of BSCA at VM init")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260803124040.126471-3-imbrenda@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f86b4b0b356f..1b3290a5ad1a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3247,7 +3247,8 @@ static void kvm_s390_crypto_init(struct kvm *kvm)
 
 static void sca_dispose(struct kvm *kvm)
 {
-	free_pages_exact(kvm->arch.sca, sizeof(*kvm->arch.sca));
+	if (kvm->arch.sca)
+		free_pages_exact(kvm->arch.sca, sizeof(*kvm->arch.sca));
 	kvm->arch.sca = NULL;
 }
 
-- 
2.55.0

