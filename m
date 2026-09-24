Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12B537F010;
	Thu, 24 Sep 2026 08:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240342; cv=none; b=l8e5TnhPVUrztBX4WfvmXeoB40m7KEBry30qrqRGDFT2aaOB8fnK6i0f3/vWQ+Wll+mZbI5gBPU9moFrnW8iHm3MoR+ZrJri5+BLlFd1NSMJlhRAw3muGM70j88MeoL2kL27piBI5taWlCjHpCnRspKiqyaYTLxEBlu2SW5GkhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240342; c=relaxed/simple;
	bh=Kenrhn+UDzuMaur6gMV5zYyMoKgY8g4sw250kds7mBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Aipp1C35xzm7s1t18jH4FGZ+fVjr5MLxHx3euti+JRt35UTli3BurwZXBd2DCdHfssksr+A/M+J17DzcB3HNuwbvXYucC+K6wV9VmSAXZYY+vRF3A5wSrNHiCWeZRde8StF3ida+hYvDuTsdnmCTcv/yfbTbEbgLphE/NTZfM10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oAIopnMk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oAIopnMk"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5cSNF1335411;
	Thu, 24 Sep 2026 08:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LtdnIF
	my0U0w37qPOTcZQX+JKb9EABiAddZDctDHt74=; b=oAIopnMk8d5xh8XQ8E6l6c
	IE0WcfLLyd5mcqc4FsI3QPdZBjJ2wP7d+FJ3csQuNNXtBoY2IRN+vpbaWpvqRPv9
	fXSQE8ME8i3dPzwGymiZvImUEr6fu8522Y+F/aOmLFS7uEwToP9KoFjwhb3C51Oi
	ngAtACWQi2NJxs6pXvEs+KxMEZyxZNhyAZUoxIsFjqMOunVHoONv8q8NThtMU4m2
	55dlYbPu4vZiC/g7pPMdugdgxXoACcGtRolFaRcTSI8DH2wpnxX57nAGaD6xw4h+
	g2Q+fmJf5sbrfRI7sjpbfmOxIACWj6YVcrvXWGBxMan7IRwMznxbeFEQZzvXWapQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsfxva-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 08:58:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5lTo31501452;
	Thu, 24 Sep 2026 08:58:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2vsrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 08:58:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68O8weWa31982202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 08:58:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00A1320040;
	Thu, 24 Sep 2026 08:58:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADB0120043;
	Thu, 24 Sep 2026 08:58:39 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 08:58:39 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Thu, 24 Sep 2026 10:58:32 +0200
Subject: [PATCH v3 3/5] KVM: x86: Use file_to_kvm_x86() in SEV
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-vfio-v3-3-4a294307797b@linux.ibm.com>
References: <20260924-vfio-v3-0-4a294307797b@linux.ibm.com>
In-Reply-To: <20260924-vfio-v3-0-4a294307797b@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab4e645 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=JZHfIBTrcVpj99XhhAcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jo-HCn64oLn9anyleR7rf3k8tQl-undb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzNiBTYWx0ZWRfX4VH4Ygfi8zuD
 NruH2l8Ochg/VJSuyrBbNzmDrfvJPNIGy3xEpleCAPP6hiTAZMWo6VHsRTZYXTuLcFpFZhdP7K1
 qvUkc2rRjsdZdSvUETGK8lVnpul4Pniau2fLnNyreJYtcHSv0vHpUZsJtCsr27ihbsZUxp0X+ai
 9e1erqct2JQEeUI+wc2K0rD6suMGR8l2+6v/yKuHstqYYgR/18BP6xo6oin9X+Wlogn9zHxPCEG
 pLcbhFjl7lZ36PJ4sZnXhggTFqIKLMKhoOklXAaZo7TNpoUdxHJbaSB8dkro0RSdipnjLZiQgB/
 3yaGUoWP/CtVZzW5ENLR2iXqRo472gtPRZC0Y+OZlIO4WVlwinbowiWd/sIEeruGEARYbJgOZdc
 u1c3u/AxHP1v7CiFcFcxKPvwHdrK4xviKurvojSXw2c70lNHUebeIR7VUV8wnpwXFTSqjWNG9/o
 as2aGi+X9gVjjY/8uqA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzNiBTYWx0ZWRfX+NGaPCLavOwS
 qsjegNU+eIZ/Ov11Qniat5e841grjLNpMk9nPc1DxY541Gkzo/cVJ3yGe5YMh6HvhK6FoI6pd0W
 lLyWB0GI99AUJH70os9AmAHTFAbsuyU=
X-Proofpoint-GUID: 96MUqAWqgqHzWSymKXSHrgukD0y2Ptpw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240036

Use the new arch-namespaced helper  instead of open-coding the file
check and private_data cast separately.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/x86/kvm/svm/sev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 5705723f1f41..6b0eacde4f06 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2145,10 +2145,10 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	if (fd_empty(f))
 		return -EBADF;
 
-	if (!file_is_kvm(fd_file(f)))
+	source_kvm = file_to_kvm_x86(fd_file(f));
+	if (!source_kvm)
 		return -EBADF;
 
-	source_kvm = fd_file(f)->private_data;
 	ret = sev_lock_two_vms(kvm, source_kvm);
 	if (ret)
 		return ret;
@@ -2866,10 +2866,10 @@ int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	if (fd_empty(f))
 		return -EBADF;
 
-	if (!file_is_kvm(fd_file(f)))
+	source_kvm = file_to_kvm_x86(fd_file(f));
+	if (!source_kvm)
 		return -EBADF;
 
-	source_kvm = fd_file(f)->private_data;
 	ret = sev_lock_two_vms(kvm, source_kvm);
 	if (ret)
 		return ret;

-- 
2.53.0

