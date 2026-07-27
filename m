Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1076C42B32C;
	Mon, 27 Jul 2026 16:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170860; cv=none; b=fRYxX9Xd9Vsv/f95cxrxAQ/j+8H79SBEiTkxiu3TFEk143n53LYHUN3eRjiosER2kkfAKVMlBpWjicwI9ZfBkEPQHcc1zSTCIhkJ8epv3HrIcx357w2/h1Ktohjm4fZwd6iA44qpj3tiJRqjVDFUN3UQ/G+BBVjQI+rMZnLTeAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170860; c=relaxed/simple;
	bh=yb9Xcmeh8e+eZYpmvMOdBYnbjV+KLEbxmwzpjNRvpa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZQ8FofMMuk62r2haaF8poCZfeNDVzVW3uWI537pQL/oE2ci9quTJovB+kwoUR4dyis+HhKOq2KFINnTOrTePNDxK323/ke8tA+M7ra/kI61NnTaijKeA10cXdjYfK3ufJIyCHVlMcS5yBTyvzK+7bm6SuQF+ATgChKtIoYh6y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zjr5Mna+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zjr5Mna+"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDnbhA2412218;
	Mon, 27 Jul 2026 16:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9E1TLQNZxnid8pnyt
	59uUgIAQmffeBAIXW/c6KkUCjw=; b=Zjr5Mna+5dLnRdjZHmAup7RwEgQj2x74+
	YK7+V5FuxGVEU9AbNXU8u1fHn9uD6G8Uc2ZjKYKGVZqLxpZmEtGRAfM1rArP4f+k
	tWb45ScDojbYJY6cPZfr4cXfL51Xvfmyz3UzQZjBDhu4LnP8cjQQrJd5I/ouWOkW
	wS/ZQay+KiIcSe4WU9c+Q20aqJbHwfWTTIVBtq7I/+PfBfXbC1xqVNUDaM9X1Vro
	svq3ieH/9ILfHPSkmlC+WLbCgmAzogiZQ7IUT/MA2d2v91CzF5cuDnoQApT6fw6+
	bopCUaUiSMqs9ZpFRgGPXaX8BuDETh2YmIGcfHQ2TKDKboR5s7UTQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcrnr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 16:47:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RGfNHV032665;
	Mon, 27 Jul 2026 16:47:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xwwaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 16:47:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RGlMIY12583216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 16:47:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E15A20244;
	Mon, 27 Jul 2026 16:24:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CED3720247;
	Mon, 27 Jul 2026 16:24:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 16:24:30 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] KVM: s390: Remove cond_resched() calls
Date: Mon, 27 Jul 2026 18:24:28 +0200
Message-ID: <20260727162430.1599396-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727162430.1599396-1-hca@linux.ibm.com>
References: <20260727162430.1599396-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: h1MKthZq0jCa2bCcUXBBUaIpPh066N_D
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE1MSBTYWx0ZWRfX0fTFf5PtF0/m
 0cizx/BqIf+OmFkO7YuTnDDpS/4Gg7FBQG0inWrcVtjRClosllgNUCSf2FBs3wbbGu0dbzAesj5
 0TWMrfON4TpDpGAwY/oSJJPM2eNCJXA=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a678b9f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=cu7Gx01AU9FYDFtBg_UA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE1MSBTYWx0ZWRfX9jAoyjooThkC
 yaMbiV7DInYuBpIZDkwhtZE5i8O1QHMTPJXNYtRz898SUIfpyCWvW0yUrg6azZoYFESNtWyRU2K
 WI+1vMyU2riDG+5u7LhMG5F+kK5uwcpBmDH36RcaGIecLwmXue1uKL3pKBFqGZNKkZoW/w1qas/
 feXl5tPmBGwhe7Jffn4aVV9kaU+S3AsLWSneauyeMDs0h2gE2ea2MOIiiDd2P9lvm6pHztg/VnZ
 wWtml2aIjUmJPW+7dLYbZqJ/MQDRl9MowqYrHbJKYynDXDcj9rpZ7yOzkZYDwbFohxySwEX/EU5
 XRzCcOBHvtXgJywqWvDJbCpj3L0xGWUj/hVImZ13/0nHn9VmuU01BidigBohQdF/MATOD+3hNeF
 mnOxGg2bTXWu/SbX9gn0Iva6WHvtPFT69M3sCDf20GuQ+T7hd/yYXWYcLZ2SXJ34nS9fZ6+peo0
 NCio0zchu/bV8p/w9wQ==
X-Proofpoint-GUID: h1MKthZq0jCa2bCcUXBBUaIpPh066N_D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270151

Since [1] cond_resched() is a no-op on s390. Remove all calls.

[1] commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/uv.h  | 1 -
 arch/s390/kvm/gaccess.c     | 8 ++------
 arch/s390/kvm/gmap.c        | 4 ----
 arch/s390/kvm/kvm-s390.c    | 1 -
 arch/s390/kvm/pv.c          | 1 -
 arch/s390/kvm/vsie.c        | 1 -
 arch/s390/mm/gmap_helpers.c | 1 -
 7 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index d919e69662f5..795da130342a 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -461,7 +461,6 @@ static inline int uv_call_sched(unsigned long r1, unsigned long r2)
 
 	do {
 		cc = __uv_call(r1, r2);
-		cond_resched();
 	} while (cc > 1);
 	return cc;
 }
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 36102b2727fb..0d389a302a70 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -151,10 +151,8 @@ static void ipte_lock_simple(struct kvm *kvm)
 	ic = &kvm->arch.sca->ipte_control;
 	old = READ_ONCE(*ic);
 	do {
-		if (old.k) {
-			cond_resched();
+		if (old.k)
 			goto retry;
-		}
 		new = old;
 		new.k = 1;
 	} while (!try_cmpxchg(&ic->val, &old.val, new.val));
@@ -189,10 +187,8 @@ static void ipte_lock_siif(struct kvm *kvm)
 	ic = &kvm->arch.sca->ipte_control;
 	old = READ_ONCE(*ic);
 	do {
-		if (old.kg) {
-			cond_resched();
+		if (old.kg)
 			goto retry;
-		}
 		new = old;
 		new.k = 1;
 		new.kh++;
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 8abb4f55b306..3758e4009709 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -941,7 +941,6 @@ void gmap_split_huge_pages(struct gmap *gmap)
 		scoped_guard(read_lock, &gmap->kvm->mmu_lock)
 			start = _dat_walk_gfn_range(start, asce_end(gmap->asce), gmap->asce,
 						    &ops, DAT_WALK_IGN_HOLES, gmap);
-		cond_resched();
 	} while (start);
 }
 
@@ -963,7 +962,6 @@ static int _gmap_enable_skeys(struct gmap *gmap)
 	do {
 		scoped_guard(write_lock, &gmap->kvm->mmu_lock)
 			start = dat_reset_skeys(gmap->asce, start);
-		cond_resched();
 	} while (start);
 	return 0;
 }
@@ -1019,7 +1017,6 @@ int gmap_pv_destroy_range(struct gmap *gmap, gfn_t start, gfn_t end, bool interr
 						    DAT_WALK_IGN_HOLES, NULL);
 		if (interruptible && fatal_signal_pending(current))
 			return -EINTR;
-		cond_resched();
 	} while (start && start < end);
 	return 0;
 }
@@ -1138,7 +1135,6 @@ void _gmap_set_cmma_all(struct gmap *gmap, bool dirty)
 			gfn = _dat_walk_gfn_range(gfn, asce_end(gmap->asce), gmap->asce, &ops,
 						  DAT_WALK_IGN_HOLES,
 						  &gmap->kvm->arch.cmma_dirty_pages);
-		cond_resched();
 	} while (gfn);
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 150b5dd2170e..2ede8f035a38 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1027,7 +1027,6 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 		do {
 			scoped_guard(read_lock, &kvm->mmu_lock)
 				start_gfn = dat_reset_cmma(kvm->arch.gmap->asce, start_gfn);
-			cond_resched();
 		} while (start_gfn);
 		ret = 0;
 		break;
diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index 1beacc841ca8..935fe308a050 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -832,7 +832,6 @@ int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned long size,
 	while (offset < size) {
 		ret = unpack_one(kvm, addr, tweak, offset, rc, rrc);
 		if (ret == -EAGAIN) {
-			cond_resched();
 			if (fatal_signal_pending(current))
 				break;
 			continue;
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index eea24562e7db..6dcd3b110c17 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1434,7 +1434,6 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		}
 		if (sg)
 			sg = gmap_put(sg);
-		cond_resched();
 	}
 	if (sg)
 		sg = gmap_put(sg);
diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
index 4bf7c9012feb..d564cdefb90f 100644
--- a/arch/s390/mm/gmap_helpers.c
+++ b/arch/s390/mm/gmap_helpers.c
@@ -272,7 +272,6 @@ static int __gmap_helper_unshare_zeropages(struct mm_struct *mm)
 		 * truncation. In that case, the shared zeropage would be gone
 		 * and we can simply retry and make progress.
 		 */
-		cond_resched();
 		goto retry;
 	}
 
-- 
2.53.0

