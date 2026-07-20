Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FCD3D6487;
	Mon, 20 Jul 2026 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537931; cv=none; b=GJKr5oI0MkHx4iWsxHPase4PD/euZDNP/Dre7vtfd7MJyJzOg+LrKtTJiufmT5juZAOv3sq2vb/gs5A9wBBgtzFqLxIAJTxev6/7VAYmLTJ2bDGiouAwln+I1cpDpAzCBJauQWh7EKEXlIf6kowCDvMziXH1UgUsOhjWVxNwTm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537931; c=relaxed/simple;
	bh=BI1cQlVhPm9BA+ffPVedpKNRFMrwYNeA2rDys7JzQJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UcihSOkeyO2pF1rnNcdX9izeu9q+Grv71tSZ/p05SPSNyUMuxceueeede/rxYmCu+cOaRuHNy8B0IzXknJfOLzzapTxsDONHLOyYMIrXSm15ucfKjwHl02vZOJ0/savURGs5olqTE+k7SJNugLlU62VNWZeRZKwoENsJ+4uFpgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fcs69YoY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fcs69YoY"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6g2j11368537;
	Mon, 20 Jul 2026 08:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=CnkcAeX184QHRH4c2KQsIFyVwzJNleHBQovz5C9j+
	+I=; b=fcs69YoYS2Lax/LSUvP1XhXOeluQ8ck7FlqJq/J0X8IzadWJqbOFbwl3Q
	d4IK/AHqGDjzo2Kti1ocNcAKP7K7lq1zkITeeXtGq0qJKA5d2mxw50RWN2tv5dMp
	B4ClPn5NnW/GqQwuQpZtNEfToFRD/NUx0UAqC6Djefy6/EO48HlFHFcjWFR4sS4I
	DXsZHJBohMRBIBCtI87L/hePv6aXs11mAByDciFO6JDYbH0BoXiIfHMgQ5TO6WBr
	LNptzObr3b+p5j8yHAKdKWrxH6qH/VgTOUvRIHKjeXcn8hGv+4aJ2KEGKWXs9dCx
	7jllKPYs2iCGFjP2SAOuF8PnTl6vQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78fxc88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 08:58:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66K8nn44031500;
	Mon, 20 Jul 2026 08:58:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1g4n2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 08:58:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66K8wZYR53018956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 08:58:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 046FB2004D;
	Mon, 20 Jul 2026 08:58:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D587120040;
	Mon, 20 Jul 2026 08:58:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 08:58:34 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/8] s390: Reintroduce support for DCACHE_WORD_ACCESS
Date: Mon, 20 Jul 2026 10:58:26 +0200
Message-ID: <20260720085834.898025-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfX3JEm1XqWEy1u
 VoUjroVcqj3Z59oyZ9VjMd6NtU+fHf4R7Gspqb9jjii4p1FMeRlVdOSg/6BGqG8uH5+IBTY9xl7
 wyIPe4iK3EC/P6VuBX3Dhq0A591GBhKfZdaSyjm++QRcUz3YVWiN4pAc40escrE2V/MImYAq5mc
 8lf9mt6GTyj8gPbFtp/xWIxWbFkkvwZY0PhFFJ41hBMNHbL1jOcwv1hl6xBlHzBLlxmijKOIY5+
 1tWqnDF1WDM6J/HXR0vXSLVFnvaN4xZlEgqOjVqxeb5bb0o4+j0AdsMulqnPkS2Kr0mJA52M1Cu
 AihIBzvrAOrpTaGUcramEK/hFoifhuO5hL33skNyv5vFfK4k2UCQXHLqFH11oRRW3SaofXK70QC
 Kf3zGL0Mw3QGlRu3/N8lLi2+wk5/dFuEJw+dt7QQIiFqVr7BzpLYOfNT/5RBSae+mhSAtn24V4A
 7R6JTvfO1scZuTJrOFQ==
X-Proofpoint-GUID: XX7zjUCr57DvU94z8Dz27d2haGu5UYEK
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5de33f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=oTK_JJbRH6YLXrI8L4wA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfX51A94k1WODoy
 Us9Agv81D0vZdPvQ7CHzh80231Lsd9OyJHiqegknmCTiymNw/8+YRSLGGf4rZDiHLfHE4QoV9tU
 Dok8Y7kDcHJX0+kEkg7mE3pvGTC1gHQ=
X-Proofpoint-ORIG-GUID: XX7zjUCr57DvU94z8Dz27d2haGu5UYEK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200096

v4:
- Add two more cleanup patches based on Sashiko feedback, however I
  don't consider them as bug fixes. This is more cosmetics:
  - Use handle_fault_error() in do_secure_storage_access()
  - Use goto statement in do_secure_storage_access()

v3:
- Fix two more pre-existing bugs reported by Sashiko
- Add Christian's Tested-by tag to four of the six patches

v2:
- Explicitely PAGE_ALIGN size in uv_alloc_stor_var() [Sashiko]
- Document that lazy PTE update / TLB flushing is intended [Sashiko]

v1:
Support for DCACHE_WORD_ACCESS was recently removed [1] since it caused
problems with the incomplete handling of secure storage access
exceptions. It looked like fixing the exception handler would be a larger
effort; therefore support for DCACHE_WORD_ACCESS was removed as a work
around.

Address the potential problems that exist with secure storage access
exceptions and add support for DCACHE_WORD_ACCESS again.

In particular address the following problems:

- Reading the guest variable storage area via the /proc/kcore interface
  results in short reads. Address this by using a VM_SPARSE area for the
  guest variable storage area. VM_SPARSE areas will be handled like
  memory holes (zeros will be read).

- Fix handling of secure storage access exceptions in vmalloc area.

- Remove folio handling for secure storage access exceptions to avoid
  potential data corruption.

[1] 37540b8c287f ("s390: Revert support for DCACHE_WORD_ACCESS")

Heiko Carstens (8):
  KVM: s390: pv: Use VM_SPARSE area for guest variable storage area
  s390/mm: Add missing mm check to do_secure_storage_access()
  s390/mm: Use lock_mm_and_find_vma() in do_secure_storage_access()
  s390/mm: Fix handling of vmalloc area in do_secure_storage_access()
  s390/mm: Remove folio handling for kernel faults in do_secure_storage_access()
  s390/mm: Use handle_fault_error() in do_secure_storage_access()
  s390/mm: Use goto statement in do_secure_storage_access()
  s390: Add support for DCACHE_WORD_ACCESS (again)

 arch/s390/Kconfig                      |  1 +
 arch/s390/include/asm/asm-extable.h    |  4 ++
 arch/s390/include/asm/uv.h             |  2 +
 arch/s390/include/asm/word-at-a-time.h | 22 +++++++++
 arch/s390/kernel/uv.c                  | 65 ++++++++++++++++++++++++++
 arch/s390/kvm/pv.c                     |  6 +--
 arch/s390/mm/extable.c                 | 18 +++++++
 arch/s390/mm/fault.c                   | 35 ++++++--------
 8 files changed, 128 insertions(+), 25 deletions(-)

-- 
2.53.0

