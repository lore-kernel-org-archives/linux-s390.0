Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513AB29B8CE;
	Thu, 12 Jun 2025 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749749809; cv=none; b=PVAQp80hdCB33CLjeRo6P89vvZCzKwweiJKT2qXmCXygxQMW+0jUJBC51ZQykADsMbthWHQBbJyk7MfjVZvkIADS7mUbICqjyQDRsMjIzrEVpMo4jpYKm7Sa2Zoeo8mcwtPM5U7DUTYnAz29D8/UstXioC8O8ZOVC3kWyFPqEYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749749809; c=relaxed/simple;
	bh=Ax7zUYwF9boHvnFfieXPrkD9Z87GbCIu3OgAwvQ6H4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCaqDgWgDwLQ0KM4xV2//dFNzoHpbcK1BevpnD2z8u7DWU9fjpqDlrUjnPIFSs+NL6+0euwZu6BtzJCbesagZ6DT0niRiR2ju6gPc6zpBULyh75P7ibIJPlVSpSqGuYfN/YClFz6un7ASByD+M/aupXGFBTx8RE2eZovfZmqBR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s1GKeiAi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s1GKeiAi"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CCr3E5027868;
	Thu, 12 Jun 2025 17:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4hV4IXUZ8LEPGuSQG
	01CQzmpidG+/SLdlI31Go35JsY=; b=s1GKeiAiMdnysT0X4IxcglrScCDxHGupI
	zA15vl63KE6Seni7PWOENpJ/Gv59FM2b1Ca6r2wUSawQqzznf++bc8pp+JrLepvD
	11bMaHktb6H3M6gxH1wWrRWImCuQvvEnNAl5zja2tALWGEHRiMhzoaVOi8QGHYaw
	aZz6TyrWN7R8ZtTMfSaiN5+qPDW6ofgwqKI4u93tJjADKNFDM9eGeeyxox6+z/Tg
	/YvxI01+Nyzw+6LR0Ko1q4QdNC8AvCEPF/VQKQe07zyBatxjhnu2th41Vj34ykJb
	VJ7AFrQxxkj8nBsjbedXmLfZ9S4sPBvTCF878vtwezm8Z8t+8f7XQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474hguue6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 17:36:17 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55CHXi2p029325;
	Thu, 12 Jun 2025 17:36:16 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474hguue6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 17:36:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55CGdbAS015184;
	Thu, 12 Jun 2025 17:36:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 474yrtp6b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 17:36:16 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55CHaEtZ33358432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 17:36:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45F9520043;
	Thu, 12 Jun 2025 17:36:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31BD320040;
	Thu, 12 Jun 2025 17:36:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Jun 2025 17:36:14 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id A6F65E19CF; Thu, 12 Jun 2025 19:36:13 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        Hugh Dickins <hughd@google.com>, Nicholas Piggin <npiggin@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, Juergen Gross <jgross@suse.com>,
        Jeremy Fitzhardinge <jeremy@goop.org>,
        Ryan Roberts <ryan.roberts@arm.com>
Subject: [PATCH 5/6] powerpc/64s: Do not disable preemption in lazy MMU mode
Date: Thu, 12 Jun 2025 19:36:12 +0200
Message-ID: <448f6e26a9d72fb2c873245ea948807491f6b798.1749747752.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1749747752.git.agordeev@linux.ibm.com>
References: <cover.1749747752.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Pfr/hjhd c=1 sm=1 tr=0 ts=684b1011 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=Nsn6zn2YLSyj-wdhBosA:9
X-Proofpoint-GUID: Y7JL08S83tcOGpHgHyKOLNsFJBfulgi4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDEzMiBTYWx0ZWRfXxvLPCGltFBs6 pER1hH7Vt06TbX8owkaLIhYurkg/bfiZiDeVHa0PPT4UG5RzmpaRyaYzy4ZzCd+x8pHRBQxHNsW LlMM92svD1VKZhMAfFH8HhjxN6kzFIktURb71PQI+3H4WVjFhd6e0GNz+MKZ65cpAblc41X74IX
 VWf/EXsyOP+k9EtZQhTtCLK0y9XnX1bfZybbHwQJ+iYyzR+cu2qDSo2vTQjKBcaqzXtO6QCws/G ahxfH8pkJ/OernQEEfBz8Qu/RAndqb3+4jUDYJorjlTofk/Ag29ituHGNj7JG2D1/13Yq1Xceww QO2NYvvcSi2BXvJvwSvBOgqw+ea0ndyQmYpre/Tbc4lnWu8mCsCWILjWTkHUy9oPg7cQuigdRwF
 pFY0gzFF6leNeCu5EA1j0z0C62x0JAJFBWJjNW0G83T1t2FdFvdOnFeb4KXHaR+HM9fW5qE1
X-Proofpoint-ORIG-GUID: ES5ST5n3tkdVQkhjd27yAL3iJS4bjEER
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=654
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506120132

Commit b9ef323ea168 ("powerpc/64s: Disable preemption in hash lazy
mmu mode") is not necessary anymore, since the lazy MMU mode is
entered with a spinlock held and powerpc does not support Real-Time.
Thus, upon entering the lazy mode the preemption is already disabled.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
index 146287d9580f..aeac22b576c8 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
@@ -30,13 +30,9 @@ static inline void arch_enter_lazy_mmu_mode(void)
 {
 	struct ppc64_tlb_batch *batch;
 
+	VM_WARN_ON_ONCE(preemptible());
 	if (radix_enabled())
 		return;
-	/*
-	 * apply_to_page_range can call us this preempt enabled when
-	 * operating on kernel page tables.
-	 */
-	preempt_disable();
 	batch = this_cpu_ptr(&ppc64_tlb_batch);
 	batch->active = 1;
 }
@@ -45,6 +41,7 @@ static inline void arch_leave_lazy_mmu_mode(void)
 {
 	struct ppc64_tlb_batch *batch;
 
+	VM_WARN_ON_ONCE(preemptible());
 	if (radix_enabled())
 		return;
 	batch = this_cpu_ptr(&ppc64_tlb_batch);
@@ -52,10 +49,12 @@ static inline void arch_leave_lazy_mmu_mode(void)
 	if (batch->index)
 		__flush_tlb_pending(batch);
 	batch->active = 0;
-	preempt_enable();
 }
 
-#define arch_flush_lazy_mmu_mode()      do {} while (0)
+static inline void arch_flush_lazy_mmu_mode(void)
+{
+	VM_WARN_ON_ONCE(preemptible());
+}
 
 extern void hash__tlbiel_all(unsigned int action);
 
-- 
2.48.1

