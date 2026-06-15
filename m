Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16BD3EDACC;
	Mon, 15 Jun 2026 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527377; cv=none; b=NIMj8LXJgBKWnkbCFO6PwD55LxlCs0OwUYG9F2YR6PUjjg6vzulYNek4cFMHlyKtFOnjbysKpoUVcTfGzm8q8fL8pnVsbvNOa0z+BUPDnLeRKpua3yPpJ8s/y+OG0iPdM0wLWN6iqLWA64GNp8x7H+Zn7y7Ptdj2T9uFKCvgggA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527377; c=relaxed/simple;
	bh=6idOP8BAZ0Mzlzd/IybKTMfRlFR/pbNhXoT9IVOSjjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5kui8jQujdqNsMI0FhneoiBkNKxThnbgSPdtHKUELcxlvVMPJgNaiDpGJtHspu14wYJIS3Elbg+0VdCn6gXoItePmNv36cbGDe9ffY5k+TbHpOxTIr2NwwjXcApynZOVPQd010TT2PWGBZbIlWRf7mvrvDdODHIZXV1CnQ1jUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b5HkzRl2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b5HkzRl2"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FAo1Xo2255368;
	Mon, 15 Jun 2026 12:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=R/0og6a/7hY3bhKI8
	ps6myRHBAQevRzK3RKTc5Uvg08=; b=b5HkzRl2rUgAZNBeUFSQ1zQdsF8uiltlW
	8NpdGGNcllMHoqw8k9nEu2PZCjPtDAZYgG5HZH/+gctQJBmNq/A5yN9lcEpAyTBn
	8lvHC3TIJEmRlt0QRimJ+/yEoOesn9T2NAEX+vxNIoljro6KTEJ91SQWtQugH47b
	0b7hdXbGuxD192j7WOUf/v8OeeiEg24pgvsHEoF63FSDbDLtwnR7k62Mt8moLSAJ
	zYxxhupAJNj83e/i476McmPQRqQlIgbnWEZvxvu83jDn9Eo/V11JmnTFhNqtQ6F+
	kPz8aoSFK1oee+g9/JtlYh6DwN+cQzrgeVyqy0J4AXh8uURyob1Ug==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1h80ku3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FCYfKJ017148;
	Mon, 15 Jun 2026 12:42:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrg6cq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FCglIk27263446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 12:42:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2442D2004F;
	Mon, 15 Jun 2026 12:42:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF04D2004B;
	Mon, 15 Jun 2026 12:42:46 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.31.49])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 12:42:46 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 06/17] KVM: s390: Add module parameter to fence 2G hugepages
Date: Mon, 15 Jun 2026 14:42:32 +0200
Message-ID: <20260615124243.187614-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615124243.187614-1-imbrenda@linux.ibm.com>
References: <20260615124243.187614-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX8WNSqxBIV3KN
 mo1N8dbQH+EAMW7HjcpAXLFugVUpRf2BErJq+O0G3OYabxSC2PN7YoBPUiHWagA1yZCCFGwz1EP
 ImvYX2Jn++bx6BxR7/LHbviG0s2+tn8=
X-Proofpoint-ORIG-GUID: T76UUxp4KVvFByyCyLEyKk_WO3U-rRcR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX19CeQtKWjYDA
 1rpet46yETSExxm8bgF73N6GnINCKvBoBdeUFNWCQX2OcgT8PhS5qkc0E9JrCU6AIYxOLHB4sXj
 dvbkSyuBQPB3AjZRpa2fPbtJR9V8aBPY3HOMw6K2LCeknJt+NSwT1iBIYCAW/1al9WLoZ9fq5gr
 YVFktZFUDALcS+KnVlfh98yyf9qmT9vB/n51QMeh9XBRG0wrgasOVLjtYfoJVgaPQiDPPCtcmne
 YXwbcJ4Qg3SqVJBjWF9jTZ414B9ku3XtYeMHVaq5gJO9HPLC76PAkFfpncUGlgLrU/SpQ0et0P3
 S5ivaVJ91XpZK7ooVZrYzgFV2Iy0BBK/aphnZylFou9CdJk8zaX+SEbKZd1vjapH5wOoFjFern7
 gJ7cchTzXDHFrmrun0ro/7Zi8bApThavSe72ipnoNYsbP0QB3PpF+4JrYZfgTp+bFL5nT1A3zCC
 rVErM2IAH/T7HH29srw==
X-Authority-Analysis: v=2.4 cv=U9uiy+ru c=1 sm=1 tr=0 ts=6a2ff34d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=-5nL1enD9Bub2BjMfYYA:9
X-Proofpoint-GUID: T76UUxp4KVvFByyCyLEyKk_WO3U-rRcR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150130

Add the hpage_2g module parameter to KVM to allow enabling or disabling
2G hugepages in KVM.

If hpage_2g is enabled but hpage is not enabled, print a message and
disable hpage_2g.

Opportunistically fix the comment for the hpage module parameter.

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260609150930.665370-2-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f6521f16532a..abc7941d7bb4 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -204,11 +204,16 @@ static int nested;
 module_param(nested, int, S_IRUGO);
 MODULE_PARM_DESC(nested, "Nested virtualization support");
 
-/* allow 1m huge page guest backing, if !nested */
+/* allow 1m huge page guest backing */
 static int hpage;
 module_param(hpage, int, 0444);
 MODULE_PARM_DESC(hpage, "1m huge page backing support");
 
+/* allow 2g huge page guest backing */
+static int hpage_2g;
+module_param(hpage_2g, int, 0444);
+MODULE_PARM_DESC(hpage_2g, "2g huge page backing support");
+
 /* maximum percentage of steal time for polling.  >100 is treated like 100 */
 static u8 halt_poll_max_steal = 10;
 module_param(halt_poll_max_steal, byte, 0644);
@@ -5842,6 +5847,11 @@ static int __init kvm_s390_init(void)
 		return -ENODEV;
 	}
 
+	if (hpage_2g && !hpage) {
+		hpage_2g = 0;
+		pr_info("Disabling 2G hugepage support, since 1M hugepage support is not enabled.\n");
+	}
+
 	for (i = 0; i < 16; i++)
 		kvm_s390_fac_base[i] |=
 			stfle_fac_list[i] & nonhyp_mask(i);
-- 
2.54.0

