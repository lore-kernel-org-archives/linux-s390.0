Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70134FE2EF;
	Fri, 18 Sep 2026 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744182; cv=none; b=RHXA9lE0QzeVYkqmoYNxMUv0kZUBV6Xn0ESJIPFY2RXZTx6W5+Ox2WTP10EYDM0/aDP0HlsZs26qQ2Dppe4UiXoz3aBOoSeFIHLGWNL9oYfnAJAp/gCeTp4TZIfw21hFrvcq4lj3K9ztUTmSySyZRpg7/1AVE4vU9bIJnsCC7EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744182; c=relaxed/simple;
	bh=bxbBS3YIMHC5rS6LXMGjZIFa17dD0noCcC3J9hR4gUU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U40PPADT/2cMMLtB7WdUX05BFPTEzzOhD94YXvoVUjBhF/EevLLfkSnoh7gpfNzF6aV2bSX0RmgsJYhM+AypzlUKkAFGjkXIH8TVlWl96DPagGku1WuQKQ1cdcFBdfUc17b4nM1EfIYQ8tyTv9KeMmSBZudH0cRblFH4hVWgPrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P4282D4+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P4282D4+"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVdDj1421304;
	Fri, 18 Sep 2026 15:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=ltFQ1RcUil6v7xtbtMm8MHzfvxoe
	SL5X7Ffy1yrwXOI=; b=P4282D4+GH/5Z82hQfBbXGjVpzcU3hFoHS3/NO4byYKi
	LlR7l8tgGyHV2yPoq5vrshH5AS+iA678635DeTum/nadYb5fhX/oEMCrD8+rtST3
	K92U/IFdruGJ5ggzxIMJXR4XExknzwScpAUvqSvg1JCcoNnhP4gGA+/s65KU0sBN
	gpx9XWyE75vTTBvXrrD/mgsdHSLxHgzWaUV3geybHvhAMU1U+n9/AVJ1tvTFONsR
	3xhNCeLkgMYzG6IFILhUvKUiiD8lQQRBL4kShp+XNJauOTTfu17fBgo8Qx5xRwHI
	pLPk0nEMEK0xgyvY3EG3xd7NJnpnHVNHJBoDxQzaVQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcvg4uu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNtXj722781;
	Fri, 18 Sep 2026 15:09:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjqv7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IF9Nmv43385138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 15:09:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2AB320043;
	Fri, 18 Sep 2026 15:09:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 303B420040;
	Fri, 18 Sep 2026 15:09:23 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.72.118])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 15:09:23 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Subject: [PATCH v7 00/21] KVM: s390: vsie: Add VSIE SIGP ECALL and SRSI
 Interpretation
Date: Fri, 18 Sep 2026 17:09:17 +0200
Message-Id: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23OTW6DMBAF4KtEXtepx7+QVe9RdWHDOBmpQGITl
 CrK3euQRUFl+Ub63ps7y5gIMzvs7izhRJmGvgT3tmPNyfdH5NSWzKSQBgAUnzIhz3Q8E1ctCpB
 aYWwtK+CcMNJtLvv8euWEl2vpHF9HFnxG3gxdR+NhNyQ6Uv/e+TxiYk9wojwO6Wd+ZoJZlF0rn
 KiXuxNwwdHXEaSwVovq45v6621PoduX8rlqkn+8ArHi8smr1tReRhmd2OJqyWHFVeHaeA8+CNe
 4ZovrJZcrrguPUKOurbUKzBY3Cy7tipvCm6gdYBu0DXKL2yV3K24Lr4QUIRgV0Pzjj8fjF+W7m
 hYUAgAA
X-Change-ID: 20251113-vsie-sigpi-3de01243efd6
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8529;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=bxbBS3YIMHC5rS6LXMGjZIFa17dD0noCcC3J9hR4gUU=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFlrQxRkq3UOqXlWHL27wzP56n0PxUzhHw2/AmQubvTZc
 /LyhEtfO0pZGMS4GGTFFFmqxa3zqvpal845aHkNZg4rE8gQBi5OAZiIZTLDX6m7tRY3lrjZ/GxU
 Kst3UarO2pKeyvE8q3vhYqv/4Re27WFkOL3r099dpVN820P7opZ+LePfo9eUpvq5epfCuYXzNq9
 n5AIA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfXzzKUVLVuRZtb
 qLiXR9oBTTgmzAHblIcxya0IbeiQBYsCKmCUuRFrJTht4cn73lYMf7gD6Lm57MyKsTMHPvxLU1N
 BSuC6YJAYA9f4zeSMPUdoRjTs11kP58=
X-Proofpoint-ORIG-GUID: 6m-hyzDD2F7tV_f53dQGqqXV7uIL8OLL
X-Proofpoint-GUID: 7BLEmN3PSD_lO_muA9gSE4sEVgGBqq1o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfXy1Lun6Y44XCI
 CMpTfpU/FTrV2H0fh42F7pNwgxU+V6xv15SENkuBbHSJdR2D2XH/Rkzugn23HeVFCG+vbSO61nt
 TgijOZ7c0rR1dNZpoxA//XyOd184VFJWiz8quzsOuSAqbuRs6bNCEj1rEmRdjDL7wXA3aIW69PN
 DspSXmOVXQQqD14QqllAD7Pf4x+3FpL8O5Jk39HULvdlGpJkUJOtMa116pZhzZe+kBFk2iV30GR
 0AFtYWy20tsaPaoyrW+SLe5liis5lJqaQudaZznMjJgAhegl+QH3KkJQslEQ8+ph8nHhZTf6HEt
 9m5JmzhSdo6KAXUUqr4uTn4sVXsTwu62KMyM2kbnztNF/nOo070UR08rpIGmdNIJWNEJfujfedj
 wDATJK1G2DuESNI4lfwzoDdcL25KIXu/b3NS9hIFagJmZRZFLkFzXWM+c5GPMPZPtKU0AfjYTNU
 mWSedrd8UviD/Eg88SQ==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aad5428 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=bC-a23v3AAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8
 a=yCkS3L7h3HkNc8eVUgEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180214

In the IBM Z machine generation z17 the s390x architecture does have a
VSIE Interpretation Extension Facility to improve guest-3
guest performance.

To exploit the machine support the guest-1 KVM needs to create and
maintain shadow structures pointing to the original state descriptions
and system control areas of currently running guest-3 configurations.
These pointers are followed by the machines firmware and modifications
of the original SCA for guest-3 (located in guest-2) are monitored and
handled by firmware. This results in fewer VSIE exits.

The SIGP orders EXTERNAL CALL (2) and SENSE RUNNING STATUS (21) can be
handled if requested by the setting the ECA_SIGPI respective ECB_SRSI
state description bits.

The series includes some changes to the non ssca path as well.
- original SCA pinning is lazily kept after exiting vsie
- addr_to_page radix_tree usage is replaced by xarray

**Performance Expectations**
SIGP sense running instructions perform about −97% faster without the
intercept. External call is harder to measure but about the same
(faster) on the sending side.
Entry/exit are within +-4% variation against the prior state.
Only tested on shared systems so far, so the numbers are to be taken
with caution.

**Limitations**
Due to no ESCA support in old g2 kernel and qemu the patches do
introduce a limitation for setups with a unaware g2 when g1 KVM has
ssca=1 the g2 kernel will report KVM_CAP_MAX_VCPUS=64.

---
Changes in v7:
- Add check for g2 SIGPIF in use_ssca()
- Fix error exit behavior in get_vsie_sca()
- Fix error exit behavior in get_vsie_page()
- Rebased to current master
- Link to v6: https://patch.msgid.link/20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com

Changes in v6:
- Fix valid sashiko findings
- Change some get_vsie_* functions to have a normal rc and out parameter
  instead of returning ERR_PTR
- Re-insert xa_erase hunk lost on rebasing
- Fix compile problems in intermediate patches
- Link to v5: https://patch.msgid.link/20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com

Changes in v5:
- Rebased to current master already containing dependency
- Dropped "Guard against invalid CPU address" patch, replaced with
  masking icpua usages - upper bits of icpua do not need to be checked
- Switched patch order 05 <-> 06 as un/pin_scb() depends on
  un/pin_guest_pages()
- Fix data race on flags fields (reported by sashiko)
- Remove addr_to_page usage on ssca path - vsie_pages are held in
  vsie_sca
- Change pin_guest_pages() to rc and out-parameter for clarity
- Inject intercept into current cpu on bad secondary cpu flags
- Harmonized method names (reset_vsie_page, init_vsie_page)
- Extracted _shadow_sca() to make _shadow_sca_cpu() to make easier to
  read
- Fixed non ssca path loosing scao on reentry
- Link to v4: https://patch.msgid.link/20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com

Changes in v4:
- Sorry for the spam!
- Same code as v2 / v3, rebased to v7.2-rc7 so that sashiko can
  definitely apply it and provide feedback
- Removed dependency on change-id: 20260716-vsie-cleanup-202607-8690ba7ac3ea:v1
- Link to v3: https://patch.msgid.link/20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com

Changes in v3:
- Same code as v2, just rebased to kvms390/next so that sashiko can
  apply it and provide feedback
- Link to v2: https://patch.msgid.link/20260810-vsie-sigpi-v2-0-e8d59a2f2f70@linux.ibm.com

Changes in v2:

Changes requested by Janosch (Thanks!)
- First 3 commits split out to its own vsie-cleanup series
- Re-split main code into commits a bit differently and hopefully easier
- Renamed sclp bit to has_vsie_interp_extf
- Renamed module parameter to ssca
- Renamed arch struct variable to ssca
- Add head and tail struct groups in struct vsie_sca
- Make writes to ssca atomic
- Add patch introducing SCA_ALIGNMENT_SHIFT
- Force vsie_sca->ssca offset to 0 instead of complex assertion
- Do not error out on scb_addr 0 (architecture compliant)
- move VSIE_PAGE_PINNED const
- decrease sca_o_nr_pages variable size

- Fixed Sashiko findings
  - allow 4 page esca if properly aligned
  - put sca on error in get_vsie_sca()
  - force reshadow on _shadow_sca() fail
  - unpin when destroy vsie_page
  - fix locking in sca change cases
  - fix writeback of SCAO in unpin_blocks() if g3 does not use 64bscao
  - fix err goto from shadow_sca()
  - set validity on shadow sca from pin_blocks()
  - remove vsie_page mention from comment
  - fix get_sca_entry_addr() for sca pages 2-5
  - fixed commit message, fix double read conditions for configuration values
  - use xarray insert instead of store and change alloc flags to *_ACCOUNT
  - fix double read conditions for max_sc* configuration values
  - empty xarrays on destroy
  - correct stat counter increments
- Link to v1: https://lore.kernel.org/r/20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com

Changes from RFC:
- fix locking and vsie_page reuse to run stable
- pull some methods out of the main patch to simplify the review
- rework kvm_s390_handle_vsie() to allocate vsie_sca first to store
  vsie_page references directly
- move sie_uses_esca() to patch 1 as it is used there as well - thanks
  Eric
- change pointers in {read,write}_scao() to generic 'unsigned long' to
  not imply gpa or hpa as it can in fact be either depending on the
  situation - thanks Claudio
- simplify code in sca_mcn_equals() using memcmp() - thanks Janosch
- copy mcn into vsie_sca using memcpy() instead of loop
- only shadow sca if the g3 wants and can to use sigpif - thanks Janosch
- change vsie_sca->ssca from pointer to embedded struct to as vsie_sca
  is only needed when we actually also want the ssca
- fix kvm_s390_handle_vsie() cleanup order
- rename sca variables to vsie_sca
- cleanup error paths
- adjust some comments

To: kvm@vger.kernel.org
To: linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Eric Farman <farman@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Nico Boehr <nrb@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>

---
Christoph Schlameuss (21):
      KVM: s390: vsie: Add SCAO read and write helpers
      KVM: s390: vsie: Move SCAO validation into a function
      KVM: s390: vsie: Add vsie_interp_extf detection
      KVM: s390: vsie: Add ssca_block and ssca_entry structs
      KVM: s390: vsie: Move pin/unpin guest page
      KVM: s390: vsie: Move pin/unpin_scb methods
      KVM: s390: vsie: Move release/acquire gmap shadow
      KVM: s390: vsie: Create helpers to alloc and free vsie_pages
      KVM: s390: vsie: Replace radix_tree with xarray addr_to_page
      KVM: s390: vsie: Refactor kvm_s390_vsie_destroy and extract reusable methods
      KVM: s390: vsie: Add helper reset_vsie_page() and unshadow_intercept()
      KVM: s390: vsie: Add helper unshadow_intercept()
      KVM: s390: vsie: Lazily keep original scb pinned after vsie exit
      KVM: s390: vsie: Add helper to pin and unpin multiple guest pages
      KVM: s390: vsie: Add struct vsie_sca with pin and unpin methods
      KVM: s390: vsie: Shadow VSIE SCA in guest-1
      KVM: s390: vsie: Allow guest-3 cpu add and remove with ssca
      KVM: s390: vsie: Add VSIE max shadow configuration
      KVM: s390: vsie: Add VSIE shadow stat counters
      KVM: s390: vsie: Create minimal scb shadows for not running g3 blocks
      KVM: s390: vsie: Enable use of VSIE SSCA

 arch/s390/include/asm/kvm_host_s390.h          |   28 +-
 arch/s390/include/asm/kvm_host_s390_types.h    |   28 +-
 arch/s390/include/asm/sclp.h                   |    1 +
 arch/s390/kvm/s390/s390.c                      |   15 +-
 arch/s390/kvm/s390/vsie.c                      | 1330 +++++++++++++++++++-----
 drivers/s390/char/sclp_early.c                 |    1 +
 tools/testing/selftests/kvm/include/s390/sie.h |    2 +-
 7 files changed, 1128 insertions(+), 277 deletions(-)
---
base-commit: 5dd1818b15d98d4a20806cd00b1b40320b06004f
change-id: 20251113-vsie-sigpi-3de01243efd6

Best regards,
--  
Christoph Schlameuss <schlameuss@linux.ibm.com>

