Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9334457A4;
	Tue, 11 Aug 2026 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455419; cv=none; b=dROVegLZRuokYpZlL6nMgnYp4yNlb+D9TWC83Q/Tqu/mdqIeMguJIC0c2kj2Sx1urVXnja5lQ+pvnenFY53r++e/p2CJYirLEQvq8BPVuXbPqh3fX7T4v5qX8MT0AiwXK1f8AmAjRc3FMxsrbHAbyq2w0oCbNY0Dp4LUU5kpm9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455419; c=relaxed/simple;
	bh=++qcauf+pBgLcHuU+vB4q+rnvb9ryqOaO6SVS0lUnhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TxHNXcVBYGo/snW2G8JLRI+4PD1y282bSFnX5A2rSshBl2EkkPuNPFEdZ3zyMP56K9lG77pu3N2AR1IeH3iBAQPCOmO1fgSDIbbGLZAPQg5lU/bpA+f7abdv9I2b5L1af7kVmCCNGsfUtNrNkibHGjOy+EOnc1TjmdsrEvwzzUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nDeNTqZh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nDeNTqZh"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDXAsZ451271;
	Tue, 11 Aug 2026 13:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IhZaII
	cnvScMWelgXKut2aIcQfrShx1uIK0CLcpVoIU=; b=nDeNTqZhfoWEvWbpeS31Bj
	giEc/XGiLW0NNkrrdTi4HoTjNCXZBkGfVL7L0DWBOAEQH4UeC5fiBrshK1uvrpja
	gtNt8DsByiSDwZYZm+ZHq3s1V3YowyDtU3fD+rj8bDir4bSKbVfoO+zVY7ucFLC9
	Pn68TQGQdEcy/eugMwfo/GxSIDINKOh2hjriLSt8xSojTFp2V+bnMXbpMZsHdAWd
	eLEExmVOSQYNE03DJFnWTfoxSnTBz5hzCei+oYfbYWtY9Gliu48ovNKPFCHR09WZ
	CdDKnV5zVWDH63xT905+/hmcufP9eOAyRmfY6uPh5IRxH2xX63c1wX5XJj+EaoRA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2vgjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BDQI6U008890;
	Tue, 11 Aug 2026 13:36:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g8xs9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BDaXAu37945748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 13:36:34 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5D4320040;
	Tue, 11 Aug 2026 13:36:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FCDF2004D;
	Tue, 11 Aug 2026 13:36:33 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.69.228])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 13:36:33 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 11 Aug 2026 15:36:23 +0200
Subject: [PATCH v3 08/20] KVM: s390: vsie: Create helpers to alloc and free
 vsie_pages
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-vsie-sigpi-v3-8-45aa1ab07c7c@linux.ibm.com>
References: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
In-Reply-To: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2486;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=++qcauf+pBgLcHuU+vB4q+rnvb9ryqOaO6SVS0lUnhI=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFnVqlGCDP6pj91cDuunHd22Pf6B7ivu0NzX81Lv3fyrU
 Ba04ydLRykLgxgXg6yYIku1uHVeVV/r0jkHLa/BzGFlAhnCwMUpABPROcDIcHru5e1FDxvD3v89
 82RL/utojejQm0umefK+L450NptbfYzhN5vAFp3u2FNTP9rw3/2YPP3BzYdm+7j3qZjsZGjeeJN
 NjB8A
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7b2566 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=-UiXzxHpo5ppJV-mmbwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YjrDnSRz9pKPnBxPfRsIKzZpAkahRs79
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfX/PkQlBDbOyWO
 K7VJLpUxxeTVKT633F+Q4ZSPo50zcAWHpuF8Js8VPw9aRrglm35NVaJrzpLZ+rgSGzprOdlfe2i
 ycGJyiHWnnnWoeXci72h8PrlBulo0XGcyT8Rjos9Tm6L2rGOhQ0KPdPDtbrat8PI9CFzrp6MN3F
 UNM8/p8jxUMeBrt5mt/lFMG6fXVvTlTQFnbhBRsJ5Zxbf9V9bbrLPqCfDDTA1vIG7RQuP8TNtJa
 8+zsSieEfb0+08rZKhXnhwIeD5mbMjJex/dYQybU/aWr+2KWms4LHZ88HRBZuAppye/jumN9H2v
 ooZursqRto9ZSeTYKCVnQDAEykSJcBoPJGvGp1C0jfTjmd5RLLUqr/pidV6yi3EUhmsiekGOVvR
 oynLW+2uOARmod/QeTIC4X9Qg8athzqErptJcwmBxMzqVZXDXsV2EER6dkG2ApRlSe3KR5BSwcX
 ZmbwKb24xE9gBGfibBw==
X-Proofpoint-ORIG-GUID: YjrDnSRz9pKPnBxPfRsIKzZpAkahRs79
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfX3heqE4WOb9He
 VpOhFCMLHK+4RyzOGEz5EFHIX4cZphlplXpGgEls6CpXe+opHT1r6RbhLzsfBNmXksJZ1H2NBCO
 xHTjayY5AsTo401gbqljj3Em1rfrrlk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110113

Encapsulate allocation of struct vsie_page and free into its own methods
to allow this from multiple code paths.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 86e1c605f4ce..20e5fcbe382c 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1502,6 +1502,24 @@ static void put_vsie_page(struct vsie_page *vsie_page)
 	clear_bit(VSIE_PAGE_IN_USE, &vsie_page->flags);
 }
 
+static void free_vsie_page(struct vsie_page *vsie_page)
+{
+	free_page((unsigned long)vsie_page);
+}
+
+static struct vsie_page *alloc_vsie_page(struct kvm *kvm)
+{
+	struct vsie_page *vsie_page;
+
+	vsie_page = (struct vsie_page *)__get_free_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO | GFP_DMA);
+	if (!vsie_page)
+		return vsie_page;
+
+	/* Mark it as invalid until it resides in the tree. */
+	vsie_page->scb_gpa = ULONG_MAX;
+	return vsie_page;
+}
+
 /*
  * Get or create a vsie page for a scb address.
  *
@@ -1537,7 +1555,7 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 
 	mutex_lock(&kvm->arch.vsie.mutex);
 	if (kvm->arch.vsie.page_count < nr_vcpus) {
-		vsie_page = (void *)__get_free_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO | GFP_DMA);
+		vsie_page = alloc_vsie_page(kvm);
 		if (!vsie_page) {
 			mutex_unlock(&kvm->arch.vsie.mutex);
 			return ERR_PTR(-ENOMEM);
@@ -1557,9 +1575,9 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 		if (vsie_page->scb_gpa != ULONG_MAX)
 			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
 					  vsie_page->scb_gpa >> SCB_ALIGNMENT_SHIFT);
+		/* Mark it as invalid until it resides in the tree. */
+		vsie_page->scb_gpa = ULONG_MAX;
 	}
-	/* Mark it as invalid until it resides in the tree. */
-	vsie_page->scb_gpa = ULONG_MAX;
 
 	/* Double use of the same address or allocation failure. */
 	if (radix_tree_insert(&kvm->arch.vsie.addr_to_page, addr >> SCB_ALIGNMENT_SHIFT,
@@ -1662,7 +1680,7 @@ void kvm_s390_vsie_destroy(struct kvm *kvm)
 		if (vsie_page->scb_gpa != ULONG_MAX)
 			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
 					  vsie_page->scb_gpa >> SCB_ALIGNMENT_SHIFT);
-		free_page((unsigned long)vsie_page);
+		free_vsie_page(vsie_page);
 	}
 	kvm->arch.vsie.page_count = 0;
 	mutex_unlock(&kvm->arch.vsie.mutex);

-- 
2.55.0

