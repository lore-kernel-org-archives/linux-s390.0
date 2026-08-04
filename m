Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5264746B8;
	Tue,  4 Aug 2026 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785860701; cv=none; b=qJg1/uL05jVQW+Cg3RvlqxylN710EBDqA9+jSXvZB2sNfE7qyXk0IOuW3aiu0nuBySN+i+24ld98zXV/vWJVmH84Z2tfc4nmpnjzuJhf8UwrIBu2WfGDx5HGTIC1HymjKjhuEWL6Ngkm0XJejzazyBvm591jX3AhyoONtk8djQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785860701; c=relaxed/simple;
	bh=Fsd6pWJXABO6VAiKRB+/D+bbmaxu7PLXBORZzKJcCds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVM7fcZ3mDvi+Vh5pvdO/2Jk9k7hgE1YH0HlKHpgjS16wV5H5X+diIQTwQ7QIxn1w5brFBLJkYain+5veLDLtdoGdQzVu7SitRTUQd7Cz1n+LuuYQ39E8fUCd7o6SP79w93Ah2k1JCZt1M53cTwsx0Y/9VH2FDNtBd2MhUz3MwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TgbqG+dt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TgbqG+dt"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674FldFX1192104;
	Tue, 4 Aug 2026 16:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=37PIucMykZIUAuoBl
	It+eGGnJJfdjthIGvjI5Ob5uD8=; b=TgbqG+dt/eamHAvh3njfLW4mubNIAo4fo
	wowwB+5qnQIATwNtOJ1NJoDP4pY91EjO0MzQgKNxrW4Sei24g6TR8Tjrrt2+QaSY
	wyPsRPySGduZDdavV5I8lEioJlPcOS+qtjuLlKMom4psANAA4bNr3Zr24vV98RCe
	taYbcB0NRsDOHN7kmDrbTx8sQtpR8mGRtxGcih/0NKoJXcIb6QDhwhQtZPYbwrdM
	SLHi5hCiqXg5jJ0SIDwbojkEIkGzbwvpzCe7sA8Gx/p/rM4ydVnBtC+4LsTiVj3f
	zWKp7pPuvBZqGSyIkJ56r8NoAGGti3Gj2G/BQqzxdybuNmbqlm+JQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hpnb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 16:24:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674GBJdM019709;
	Tue, 4 Aug 2026 16:24:55 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw2th3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 16:24:55 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674GOsin32047716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 16:24:54 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6796358059;
	Tue,  4 Aug 2026 16:24:54 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BF8858058;
	Tue,  4 Aug 2026 16:24:52 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 16:24:51 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: KVM <kvm@vger.kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>
Subject: [PATCH v2 6/7] KVM: s390: Take srcu when importing watchpoint data
Date: Tue,  4 Aug 2026 18:24:34 +0200
Message-ID: <20260804162435.28617-7-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804162435.28617-1-borntraeger@linux.ibm.com>
References: <20260804162435.28617-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEzMSBTYWx0ZWRfX5N4EjzJMCemp
 Vhq9wxQ67nuZ/RTv7V/VhJOuFplVJiAOi0cay7nHziqlwns++nYxfS65A3ZkmrcUKfLc17qqXHG
 Mn6n7JCpNvpyf6A8uphhPu3qYIP34j8=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a721258 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=HjbLuaNmiay7o59Kxp4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEzMSBTYWx0ZWRfXxOSBhPbWiplR
 J64dgVwVKroeHN37X6MZn9OJDAx86tu62+6WwblzlBOVGzRXsP59UEDkDliaBhjmo3Q2z0ooBWd
 LDXNRITNZPUCEpH55wK/oN3DlFXlZYYPdSA4RxRSx/SmKieX3FSSFyT/S5Vials770aNSkQWUQG
 ZI72Ot5o6mI6zn1Vh0OSshkckqKEJ+tbhgErOqTzYnqQhHJT6dSexgKx80M6t/ANF8akFu6d5TH
 Eqcdtf+i+9PUAVFnuZyUR7/uJ9bPJBlgmIM8EhnhX+DkVKd2XPE/Biyep5/jsNppJAlV3dF3w4Y
 XNj+IO7FgkphmWXZIybC7ntT07QNzqNGKw5tt5wR7vXOQqno5COvqfh337LHHP9nq4imL5KJ+HX
 gLQujWtMtVk+uslaksrybluLP/qc7J4/Nyoln9dI3bp48rm88aSUwbw/Lq85+OD+KxvHTYL7BzX
 SPLlqBNtJQky5aPeLqg==
X-Proofpoint-ORIG-GUID: k5p2S8u5Apa4uS0LEyGN2BocJkuRtAN0
X-Proofpoint-GUID: k5p2S8u5Apa4uS0LEyGN2BocJkuRtAN0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040131

__import_wp_info() backs up the original guest memory contents of a
watchpoint with read_guest_abs(), which is kvm_read_guest() and therefore
resolves the memslot via __kvm_memslots(). That requires kvm->srcu (or
kvm->slots_lock) to be held, otherwise a concurrent memslot update can
free the memslots array under us once its SRCU grace period has elapsed.

As this is not fast path, following lock ordering (mutex first, then
srcu) take the big hammer and hold the srcu for the full import.

Fixes: 27291e2165b6 ("KVM: s390: hardware support for guest debugging")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index c47c3a930db7..e0548926dc49 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4247,8 +4247,10 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 		/* enforce guest PER */
 		kvm_s390_set_cpuflags(vcpu, CPUSTAT_P);
 
-		if (dbg->control & KVM_GUESTDBG_USE_HW_BP)
-			rc = kvm_s390_import_bp_data(vcpu, dbg);
+		if (dbg->control & KVM_GUESTDBG_USE_HW_BP) {
+			scoped_guard(srcu, &vcpu->kvm->srcu)
+				rc = kvm_s390_import_bp_data(vcpu, dbg);
+		}
 	} else {
 		kvm_s390_clear_cpuflags(vcpu, CPUSTAT_P);
 		vcpu->arch.guestdbg.last_bp = 0;
-- 
2.53.0

