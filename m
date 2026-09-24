Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855D3440A0A;
	Thu, 24 Sep 2026 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240345; cv=none; b=M9jyKmVF0KWUmUeO8lLKR2ydKYsw0VCV+oPT098rki9Yn8MozavN0uJVHpSEC4ZWTm7ruvXhbruQrdMiUxCt/71UebyVbHstgpvum5g/Z44+5sKyMm2KwGIYuOJVD1jOD6QWqonkHfHhTMksNMKSIqylAtGDQ1BGhyjhBqyhF5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240345; c=relaxed/simple;
	bh=bDTBRAzPlPATxeusRNeByCdY7fVBeElH5D0aVqA+zuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ll5jdoET7lYaLyC0Rv8u5V9DvDzi/+apoMdfy8cK/x+xA5FaLc+KCnRXevhhZ4X6BUTxxbZqjarwdRfglCDO9lmwimIz9Rdjo12r+pDJrDIyTmIvbkjbCIUcBWj1N4GT7z5wYY2QqOt9DmKfQ2OilpegqorH6bHCnqRBljOVZEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P6xPJO9X; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P6xPJO9X"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5c4jj1180562;
	Thu, 24 Sep 2026 08:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wwppUw
	3ADf1sHTrYBhmISaYmlB4JBrEimBCGEmGK/3g=; b=P6xPJO9Xtsxvsi0+ls1rWR
	CLDQ0xwYu4mxvzn33lJ4oVpICz4006i6fVOekyGzvXdTojxgewxk3j3OnYhkRyFQ
	WFeMBJdoxC9GanNNrBflnL70DzjS16gHEnq8NHiK8Cu+7jz6U0dEkH9J5n4qQu2z
	MR3PloSRoYZGHre04Rp2H8mcPNQh8rNnlGOm3Mu58XJQD7cUVCAVANblhPJsk9s/
	aCkGjCSIdQL5jM70nlvGufOPErH+rGUGXJPbw49owCY/SO/qSe0JZlAmlzUPoti2
	dUfXpgUPI8vS9yw0ag95UinMn9k+e+nT4/QZNtDjMly547UMbZX+6GDk0o27KHEw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1qdet-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 08:58:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5ldEY212411;
	Thu, 24 Sep 2026 08:58:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7e9412-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 08:58:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68O8wdtV27066710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 08:58:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9E7420040;
	Thu, 24 Sep 2026 08:58:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 664362004B;
	Thu, 24 Sep 2026 08:58:39 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 08:58:39 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Thu, 24 Sep 2026 10:58:31 +0200
Subject: [PATCH v3 2/5] KVM: Add file back-pointer to struct kvm
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-vfio-v3-2-4a294307797b@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: xI7UUMHWEUIGPCBirjqTeV813jRKW4xy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzNiBTYWx0ZWRfX38C+FGOPUprG
 +ReWIkZpSEpn5RF818sfGUvBXb2NqZQ0vcfuf4tKfVUIGqCfxBwicOHfIw1bc4XLVZvJIEDGJD/
 vE8e8IEEDWSO6GOIZzSIE5COjD62zgylEr+RP9rN3WoggNYKpnvKU/VeGCiX5ghqkMvcWrcdO6F
 4NyXsmFIBiULdaZswmwN1LDJ6en9oBKR0jR3E+C1FCBQ3M5RZT8sB1m3EtWGjoh4MBeEJtgyb5s
 e3UM/QJQgcLedbGCpaZ8j78AlEv+4WrRdZoVrvsg1++2EUmbl7+XQHbaii7n8h/BqqVezNWsTRw
 4ukbTCMr0/ITOtque7kW3ZTAExYS4qdLRX181oiJ7LLqj12TPM0Hd2nHZ0XuDAHfoiEW4LBB4pW
 KO+ZbD3SAzlE9d4JJ+OCfK0RZMpJdexQtaslQP0TCOHV2JacyrhceszNUfT8gRFM31oP6q4RXpH
 xyUJLZVQjA7O4BdSIXg==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab4e644 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=cw4uO_N-L75IYahiFhcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzNiBTYWx0ZWRfX1vvCZ7XCdFNA
 1wfS7qPhSCnQGE8JpDb0UYPnOo0Wy16/wBadVafNYHw4iduPnR0cM354JIb7GipneYZiwK3tmP/
 QStVK2mb8Q62ccCY1czNNKu4+MPZyUg=
X-Proofpoint-GUID: 07eN4urjFPJge3Kc4XbpdxsHMAteikMn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240036

Add kvm->file as a no-reference back-pointer to the VM file in struct
kvm. The pointer is set at VM creation time and cleared under
WRITE_ONCE() in kvm_vm_release() before the file is freed.
Callers storing the file must take their own reference.

Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 include/linux/kvm_host.h | 6 ++++++
 virt/kvm/kvm_main.c      | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e840ceda9f16..943b108f01cd 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -784,6 +784,12 @@ struct kvm {
 	 * kvm_swap_active_memslots().
 	 */
 	struct mutex slots_arch_lock;
+	/*
+	 * Back-reference to the VM file for subsystems (e.g., VFIO). Holds no
+	 * reference to avoid pinning the VM. Callers storing the file must
+	 * take their own reference.
+	 */
+	struct file *file;
 	struct mm_struct *mm; /* userspace tied to this vm */
 	unsigned long nr_memslot_pages;
 	/* The two memslot sets - active and inactive (per address space) */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 0172ca94f82e..bab71d398236 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1352,6 +1352,8 @@ static int kvm_vm_release(struct inode *inode, struct file *filp)
 
 	kvm_irqfd_release(kvm);
 
+	WRITE_ONCE(kvm->file, NULL);
+
 	kvm_put_kvm(kvm);
 	return 0;
 }
@@ -5532,6 +5534,8 @@ static int kvm_dev_ioctl_create_vm(unsigned long type)
 		goto put_kvm;
 	}
 
+	kvm->file = file;
+
 	/*
 	 * Don't call kvm_put_kvm anymore at this point; file->f_op is
 	 * already set, with ->release() being kvm_vm_release().  In error

-- 
2.53.0

