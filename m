Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1566822D4F1;
	Tue,  8 Apr 2025 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744130920; cv=none; b=Cmb4Y5OR3PSZEpUjnh8dxe4ty2JGlc3kQ7qbeBsaChzdaoivKonwtOeirW5tic9MjociiBJLhWSxPhj22sobEv0lmNvc5WMaLazLg8I/J5f2/9WEnKFud9CfWCb4yBTheUhe9Xavvt3vcphT5MZm2xcv47w22GVzuF2RVWNwCmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744130920; c=relaxed/simple;
	bh=L5M52uoR+VNHr6Aqz1at4XGsAPpzStQXAW03Nn5h+w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPTzmKWm014MTuW8r3QtPY4nX3bYyD866UTsravuaK5s9yQcjGiuDEAVuQa1LsHziZNeupR/eOvx1FgniWgkle/TwC2/irYJ6Jb5/2NB2lkkz0R8b/V+trtDYzJGertFcxRxct56IItYlYx29FLQu+zVY+e3jhhHEBVkfEuHQ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=npw3deZg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="npw3deZg"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5389aNfO028866;
	Tue, 8 Apr 2025 16:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pLqNtHwxdz+KjzF0o
	4al3IuUdgKeg437/opuwF8rOgY=; b=npw3deZgeMGx00Ar/mKuWmvCigPm0u2VO
	Ii52mQgYTAomVmfOm48ZVhxMbdrQ1GUR6Emzc9NVGE0oB2iMPDc2Ap+aPS38b1WT
	bsG/3vET2Rw+QSe7dwDMHqy9A2D/uqI59oqS23wwBOQyEMZmCTYEkgRBbKJhQ+Ol
	/2xtekq3+cuoDT/Ge8MqWCp0Uir/u23SHYcb/QhZDJzdZjUyRKqwsHKen7EcN0YA
	GwWtZetcyB60xluns20Z4kL84aR2CdgE6J4ri4Zsg+civDs0WFEAWiiwOffZIJvz
	KlqErpfaSdF/gjlJnP25WvspGWFGv7yL3NJk3GQCb3UZFEjntAXew==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45vnx0mumr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 16:48:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 538F8unP024583;
	Tue, 8 Apr 2025 16:48:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ueutbt19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 16:48:33 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 538GmW6I51183992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Apr 2025 16:48:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 430D820043;
	Tue,  8 Apr 2025 16:48:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 317F820040;
	Tue,  8 Apr 2025 16:48:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  8 Apr 2025 16:48:32 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id D3F1DE0577; Tue, 08 Apr 2025 18:48:31 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v2 1/1] mm: Allow detection of wrong arch_enter_lazy_mmu_mode() context
Date: Tue,  8 Apr 2025 18:48:31 +0200
Message-ID: <18bf936f63e0d1e53d8291a3bc2ee2c577876d9c.1744129955.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1744129955.git.agordeev@linux.ibm.com>
References: <cover.1744129955.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Yis3B4fiIrhXZdJ58ZjXe__p4Xw6AsHO
X-Proofpoint-ORIG-GUID: Yis3B4fiIrhXZdJ58ZjXe__p4Xw6AsHO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_07,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=777 lowpriorityscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080114

The lazy MMU batching may be only be entered and left under the
protection of the page table locks for all page tables which may
be modified. Yet, there were cases arch_enter_lazy_mmu_mode()
was called without the locks taken, e.g. commit b9ef323ea168
("powerpc/64s: Disable preemption in hash lazy mmu mode").

Make default arch_enter|leave|flush_lazy_mmu_mode() callbacks
complain at least in case the preemption is enabled to detect
wrong contexts.

Most platforms do not implement the callbacks, so to aovid a
performance impact allow the complaint when CONFIG_DEBUG_VM
option is enabled only.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 include/linux/pgtable.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e2b705c14945..959590bb66da 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -232,9 +232,18 @@ static inline int pmd_dirty(pmd_t pmd)
  * and the mode cannot be used in interrupt context.
  */
 #ifndef __HAVE_ARCH_ENTER_LAZY_MMU_MODE
-#define arch_enter_lazy_mmu_mode()	do {} while (0)
-#define arch_leave_lazy_mmu_mode()	do {} while (0)
-#define arch_flush_lazy_mmu_mode()	do {} while (0)
+static inline void arch_enter_lazy_mmu_mode(void)
+{
+	VM_WARN_ON(preemptible());
+}
+static inline void arch_leave_lazy_mmu_mode(void)
+{
+	VM_WARN_ON(preemptible());
+}
+static inline void arch_flush_lazy_mmu_mode(void)
+{
+	VM_WARN_ON(preemptible());
+}
 #endif
 
 #ifndef pte_batch_hint
-- 
2.45.2

