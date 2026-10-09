Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6BC3B3BFE;
	Fri,  9 Oct 2026 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556097; cv=none; b=hJ6zJVjkvzJ1LBxQTn6lpqZB7YZIoNPM3NvGdNgD2sqfK2uM216Ou6RdFNA9gKFU3h2m2NRJyccj/pX+0Dme4c2nE8CDbbwY2u6V5rAqqtovdGoSYkVOGaxWIXzvROAm0KMI2iRYDnBtCOYe40zO6/sphuslwIaB27hf8jSS6c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556097; c=relaxed/simple;
	bh=32Tq5MtB5LE5xyk7vFo6uA1oxUeo0V1HB+uW36V2Wlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKPWHqby9SFGzOghDyM2SrJaTbDjWGPT646OoBdsWMHEnc5IS92BcdX1G6RmRX+UWPE0mfcCSTzmIfVdSvDcBpNZATK8+aqkInS++Bew5imfBA0qHL1mxVlWQCVvQll0m2C7vHkOr4vafv+vpWPd7YF7Yo+7seZSiNfPxDRZu+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ilmZbUFr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ilmZbUFr"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699DZXWe235993;
	Fri, 9 Oct 2026 14:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Qrdd3X8NI1W0PCcjm
	kIXytgTBlkJ0KqNNO9ITeL78Ms=; b=ilmZbUFrxu1bn64f6C3AydQL6Ql2RIL5Z
	td+XZCPyOPPo+0D9jYb9kEYRnjm5qA68pgDaQifzUp6cBhq4bly2vGijgICqlWk4
	BO4Z8lsW0Op1f3GchI4eSJSEDDx/pAiKEhODcy400Cn5LHduJsgmKej6mbtrObEZ
	q5vfQvr4TeS9YknXrDYZiW+BjdFXcVheV1OdFk/eihr3IfzTZDZVgRyplPAD65SC
	YD4V/5Ssq/IPjucSZEq2ACFTSN1Fbhd522GugCuelkgtMBmp7pzXp+85cX06t0CI
	din+HDC+3RaZhGXfUJGAaQFGvjV974aPVooJlpSYrr0Sgd9xPIiMQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvte8w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 14:28:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699DWVau3886520;
	Fri, 9 Oct 2026 14:28:05 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3u39xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 14:28:05 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699ES47f18481836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 14:28:04 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EFD15805D;
	Fri,  9 Oct 2026 14:28:04 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC07858059;
	Fri,  9 Oct 2026 14:27:59 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 14:27:59 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org,
        Steffen Eiden <seiden@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [GIT PULL 2/6] KVM: Add file back-pointer to struct kvm
Date: Fri,  9 Oct 2026 16:27:45 +0200
Message-ID: <20261009142749.186650-3-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009142749.186650-1-borntraeger@linux.ibm.com>
References: <20261009142749.186650-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: BypTR1YmscKcVHq_3kUghd3kgUEfqrJ6
X-Proofpoint-ORIG-GUID: 8cZeWaYyfxgOFIsm2dc306Top6aud3rY
X-Authority-Analysis: v=2.4 cv=FoOQbGrq c=1 sm=1 tr=0 ts=6ac8f9f6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=iMsfdjsCwqIbG2x4yYUA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1NiBTYWx0ZWRfX88zLyEdnHnpK
 /M6rzUgsUyqlQS5eWqvwQopY1vsorwUNUbg/bOZ8SPDSq+gHHWSAr6ApeaYEIy1LyPOtrQg+0vH
 NTyXa6QsvPEVPNT6o/+Qm+vFBgg1Fv4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1NiBTYWx0ZWRfX6u4B9iv+18sO
 lmGWQOtyS58iUjTP3HJDk+TYW7pSkDxcVk+HNlv6m+vpTlmKq9Bfc39QL0N6zMo/+fOkPhwX3jm
 Wbj5+46/B/+RgPeO+MY+VAJw56UTtOV4aPphx7wF10zBy3hurWa2bHGGksqBS01vMyliw+FuUvS
 6LZAJzWw8AsjqfjhMykcS7HsnVdTI9pdZvPrejiAezIkNnGgKERY14PmyUT+lHhMD0MF9GVwwkB
 ID5yIVEWauiD7LO7mWW3sHMYCkORFrbWBWBHBqbMzVqAhlLs/nbkMBTRRaMIooic4pVs0dWhk6C
 0gV/6+YL0eFw8i/6LOPe3zePK0lI7xYRA2+MIYlx0NeZ4h95S+kOJd/WPC9V7zdddVi8sIwK8IA
 Awl5NthFpqCA6fhOXF756k/EV1WBt0ZO/O1wv+3KXdVN1XT1etloEPy4TtzINXXp0XzLsIXeY2q
 kL10KnrimsZ4Zpacu/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090056

From: Steffen Eiden <seiden@linux.ibm.com>

Add kvm->file as a no-reference back-pointer to the VM file in struct
kvm. The pointer is set at VM creation time and cleared under
WRITE_ONCE() in kvm_vm_release() before the file is freed.
Callers storing the file must take their own reference.

Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
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

