Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A12528850D;
	Fri, 23 Jan 2026 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194383; cv=none; b=atPNXCbYHAWdxAV1EyccMG8QZm32xdptokcIzTSapXPU5pIO35FPZNjqUo2j+yw4jtoFkHW6AiCqHcFb1irTIHPxekchjCtf1U8W8fsFP1CCdO7M4eeiOvXMEhOPN8qrWDs/EMZgDBxduActd/l3fEoiCg/8/BxlHVnoU0r/iPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194383; c=relaxed/simple;
	bh=oe0XkVWDiw3tfv0sKsNwva0qYyb2e7477YSaN5Pqn0g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ELfLWdYauBWB7FezAIJAwEooYICvBfAptlGuQfFfaL9ShvxtKuIE0PisLANMR3zY5QPOk9Vl6UxgvWu5pTez+iqUeJN7HBngPeA6O/xBJ11Rr9CR3PqHdR6ABxypTh6Ctmy2bMuJQVSk8oSJ+9LGo9PayNQjZLCy9fk/03kRojY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ax9qKNPm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ax9qKNPm"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60NAdxPp006864;
	Fri, 23 Jan 2026 18:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=KhmC6+vOzH7nYI3dC8XJ9rEeeId1
	GxH3eqOdCzqhSDA=; b=Ax9qKNPmHLgHSc9JTT5dRwr7NXD7TpsMlOfTMFKf2wea
	6465tLph2eaZ5UuG/LMEU4ANr4+On22t528YGtxYvV77zQXdkdOMMprhvvy5m0m7
	J3bxI6aRhzOXHL51eYjhSFKf/SMsrkdxEhI0V+Z2PgkHYFlrYXunlEEcVGG+MkWh
	Qg1RoquE0KgkKN8pbUbYVsHVA3gAObAPB7lW37vwCC9L0GVAR1+1ujDfe4zCctwV
	gojiOEqqhYSPVX+dtQ8SXbfekhivwTE9BtxYVQTi64dx4mWN8F4LMHW301K30vcr
	nfp7LuaCkByo5nPopDXVr61vZSE3bJ7F2S5KWVlSYA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23shw37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 18:53:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60NI8sWN006393;
	Fri, 23 Jan 2026 18:52:59 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brqf22g0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 18:52:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60NIqsb229688510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 18:52:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D07A520040;
	Fri, 23 Jan 2026 18:52:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 632EE20043;
	Fri, 23 Jan 2026 18:52:54 +0000 (GMT)
Received: from osiris (unknown [9.87.139.254])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 23 Jan 2026 18:52:54 +0000 (GMT)
Date: Fri, 23 Jan 2026 19:52:52 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 6.19-rc7
Message-ID: <20260123185252.8148Ac6-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5ynhCWl3wXY3xjIahDuSph4G_Oo4jeYs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDE0MyBTYWx0ZWRfX017g9NTKZTC9
 nngv3cuLNA0OdSQQhWwSMZhVIitte9usGY3nckuPsGMIk54jtviX4O/bV0LY3iAfUY5LqdKz5xV
 J3Cp5sZkqYyhbhlY73Kqg/gqg7b+YUltSPYVU5f4kp7SKJxEQ8cPLUrIaRY9EZqRvT0Gja7B3kG
 fjWEanY0fPmpZfEP+IKK5Rn+W69AHpFXTDY/8OXn1QKjDbD54tnlH+KH8j/wmiS02qvuEmBT5L2
 WeDUvMikkaVLfCwibb4L9oK/lsVLQdbsaeFefJnr2YKFHAkY6NEw88ErYuy4dRGskFdsyz73L6E
 84rv8IAjR1KtCBVjTV9XYBCb0PSjgX28guJQUs+pZ2d84zxPAMZSWvI+6UH6LjrRMJVDzgzoKx3
 5MDDUxEgkS4/Hkmu3+chaTH3ldtpqYGmiGx2LXo3+wDUOuAZxuDwuhvZjwR4VoAo+rgYQs9DVR8
 Vda9rfaMbi9SeWQTLOA==
X-Authority-Analysis: v=2.4 cv=J9SnLQnS c=1 sm=1 tr=0 ts=6973c38c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=So51VoVwsq1AG95YE6QA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: 5ynhCWl3wXY3xjIahDuSph4G_Oo4jeYs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601230143

Hi Linus,

please pull some s390 fixes for 6.19-rc7.
FWIW, I don't expect another s390 pull request before 6.19 is released.

Thanks,
Heiko

The following changes since commit 9448598b22c50c8a5bb77a9103e2d49f134c9578:

  Linux 6.19-rc2 (2025-12-21 15:52:04 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.19-4

for you to fetch changes up to ddc6cbef3ef10359b5640b4ee810a520edc73586:

  s390/boot/vmlinux.lds.S: Ensure bzImage ends with SecureBoot trailer (2026-01-22 15:15:50 +0100)

----------------------------------------------------------------
s390 fixes for 6.19-rc7

- Add $(DISABLE_KSTACK_ERASE) to vdso compile flags to fix compile errors
  with old gcc versions

- Fix path to s390 chacha implementation in vdso selftests, after vdso64
  has been renamed to vdso

- Fix off-by-one bug in APQN limit calculation

- Discard .modinfo section from decompressor image to fix SecureBoot

----------------------------------------------------------------
Alexander Egorenkov (1):
      s390/boot/vmlinux.lds.S: Ensure bzImage ends with SecureBoot trailer

Harald Freudenberger (1):
      s390/ap: Fix wrong APQN fill calculation

Heiko Carstens (1):
      s390/vdso: Disable kstack erase

Thomas Weißschuh (1):
      selftests: vDSO: getrandom: Fix path to s390 chacha implementation

 arch/s390/boot/vmlinux.lds.S                     | 17 +++++++++--------
 arch/s390/kernel/vdso/Makefile                   |  2 +-
 drivers/s390/crypto/ap_card.c                    |  2 +-
 drivers/s390/crypto/ap_queue.c                   |  2 +-
 tools/testing/selftests/vDSO/vgetrandom-chacha.S |  2 +-
 5 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/s390/boot/vmlinux.lds.S b/arch/s390/boot/vmlinux.lds.S
index 50988022f9ea..070bc18babd0 100644
--- a/arch/s390/boot/vmlinux.lds.S
+++ b/arch/s390/boot/vmlinux.lds.S
@@ -137,6 +137,15 @@ SECTIONS
 	}
 	_end = .;
 
+	/* Sections to be discarded */
+	/DISCARD/ : {
+		COMMON_DISCARDS
+		*(.eh_frame)
+		*(*__ksymtab*)
+		*(___kcrctab*)
+		*(.modinfo)
+	}
+
 	DWARF_DEBUG
 	ELF_DETAILS
 
@@ -161,12 +170,4 @@ SECTIONS
 		*(.rela.*) *(.rela_*)
 	}
 	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
-
-	/* Sections to be discarded */
-	/DISCARD/ : {
-		COMMON_DISCARDS
-		*(.eh_frame)
-		*(*__ksymtab*)
-		*(___kcrctab*)
-	}
 }
diff --git a/arch/s390/kernel/vdso/Makefile b/arch/s390/kernel/vdso/Makefile
index 2fa12d4ac106..fece5d975eaf 100644
--- a/arch/s390/kernel/vdso/Makefile
+++ b/arch/s390/kernel/vdso/Makefile
@@ -28,7 +28,7 @@ KBUILD_CFLAGS_VDSO := $(filter-out -mno-pic-data-is-text-relative,$(KBUILD_CFLAG
 KBUILD_CFLAGS_VDSO := $(filter-out -munaligned-symbols,$(KBUILD_CFLAGS_VDSO))
 KBUILD_CFLAGS_VDSO := $(filter-out -fno-asynchronous-unwind-tables,$(KBUILD_CFLAGS_VDSO))
 KBUILD_CFLAGS_VDSO += -fPIC -fno-common -fno-builtin -fasynchronous-unwind-tables
-KBUILD_CFLAGS_VDSO += -fno-stack-protector
+KBUILD_CFLAGS_VDSO += -fno-stack-protector $(DISABLE_KSTACK_ERASE)
 ldflags-y := -shared -soname=linux-vdso.so.1 \
 	     --hash-style=both --build-id=sha1 -T
 
diff --git a/drivers/s390/crypto/ap_card.c b/drivers/s390/crypto/ap_card.c
index 8102c8134c49..8b0ad6f582ec 100644
--- a/drivers/s390/crypto/ap_card.c
+++ b/drivers/s390/crypto/ap_card.c
@@ -43,7 +43,7 @@ static ssize_t depth_show(struct device *dev, struct device_attribute *attr,
 {
 	struct ap_card *ac = to_ap_card(dev);
 
-	return sysfs_emit(buf, "%d\n", ac->hwinfo.qd);
+	return sysfs_emit(buf, "%d\n", ac->hwinfo.qd + 1);
 }
 
 static DEVICE_ATTR_RO(depth);
diff --git a/drivers/s390/crypto/ap_queue.c b/drivers/s390/crypto/ap_queue.c
index 4a32c1e19a1e..a80ab87cad62 100644
--- a/drivers/s390/crypto/ap_queue.c
+++ b/drivers/s390/crypto/ap_queue.c
@@ -285,7 +285,7 @@ static enum ap_sm_wait ap_sm_write(struct ap_queue *aq)
 		list_move_tail(&ap_msg->list, &aq->pendingq);
 		aq->requestq_count--;
 		aq->pendingq_count++;
-		if (aq->queue_count < aq->card->hwinfo.qd) {
+		if (aq->queue_count < aq->card->hwinfo.qd + 1) {
 			aq->sm_state = AP_SM_STATE_WORKING;
 			return AP_SM_WAIT_AGAIN;
 		}
diff --git a/tools/testing/selftests/vDSO/vgetrandom-chacha.S b/tools/testing/selftests/vDSO/vgetrandom-chacha.S
index a4a82e1c28a9..8c3cbf4dfd6a 100644
--- a/tools/testing/selftests/vDSO/vgetrandom-chacha.S
+++ b/tools/testing/selftests/vDSO/vgetrandom-chacha.S
@@ -14,7 +14,7 @@
 #elif defined(__riscv) && __riscv_xlen == 64
 #include "../../../../arch/riscv/kernel/vdso/vgetrandom-chacha.S"
 #elif defined(__s390x__)
-#include "../../../../arch/s390/kernel/vdso64/vgetrandom-chacha.S"
+#include "../../../../arch/s390/kernel/vdso/vgetrandom-chacha.S"
 #elif defined(__x86_64__)
 #include "../../../../arch/x86/entry/vdso/vgetrandom-chacha.S"
 #endif
