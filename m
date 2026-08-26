Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F5F44BC87;
	Wed, 26 Aug 2026 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756730; cv=none; b=GBHU2Qo4U1BOGkJ03Fh0+kAv6icrPvfwH6YLj1k+bEQXgicz0zAIGGCwTgj9y5isOK0WTCxZlwqVDivr5HMy4mN+0iHnPl8jj6zl01ULevU9/BqxmdvHpXLNw1kcuJ8dTxbVcuWdWTDkh0/vJqDExmW+Lrn9RYgh4rlmxe0taZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756730; c=relaxed/simple;
	bh=DuAtA4pcODAfHqkwCpGDO85Ac4uflEax5F2Nla9CEqo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=habi8pr73dKLO3oWCBIjtJQCnS0zVQiZo+voRk27qwd1CJzsePRIawYbG+zjxuSdk5BazXifL4y2T+3YJFz+gqsJ+b8QaiFhRxJBwWq7dqzv+S0u/4pOExYOXOVpX4Cj6L3Gans8SEiyYVLuYPkB/HpiD8P/MKDMNX+ixK7DVyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b1gE3ZxQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b1gE3ZxQ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1fIl3084964;
	Wed, 26 Aug 2026 15:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=qm6PlyH2hvZM7u7XX6thydQ4tOdK
	WjHWy2si3OEArG8=; b=b1gE3ZxQKlmQ08IwFgmkN0nSf8juaBloQeFJaZ4C1E4z
	3QoTLuhblIolqMwf3baktQVo5MUn5iXbHRW9ldhj2Q7kIyjJEgI7U0vNeC2LzZoS
	RAY//glDGrOJEFHvn0dmG+OMzwCRKgJ8lWQdqSPK9UKc8ZereSbOHh5j8/gPJH01
	lkk9tZtnW6LK6ISY0Rh9PFp316TKXtkqA3ceE3cDuIbKZD4w+VDkx91eyXv97LQW
	VFDbp2c89ESQdLLBZ1Oq24hfJ1msyWF3nxYQRfVbUGJjCyEF+Jw2054wLX4J9S8w
	Wsgm5vBQdgc6Z0Cda17QOVjd8VzUVYDiMo0o9zeLrA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726eqbw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEuIgO015611;
	Wed, 26 Aug 2026 15:05:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhagwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QF5GiA50463216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 15:05:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E17CD2004B;
	Wed, 26 Aug 2026 15:05:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6D9D20040;
	Wed, 26 Aug 2026 15:05:16 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 15:05:16 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Subject: [PATCH v5 00/21] KVM: s390: vsie: Add VSIE SIGP ECALL and SRSI
 Interpretation
Date: Wed, 26 Aug 2026 17:05:02 +0200
Message-Id: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23OTW6DMBAF4Ksgr+vU4z9wVr1H1YWBMRmpQGITl
 Cri7nXIolBl+Ub63ps7SxgJEzsWdxZxpkTjkIN5K1hz8kOHnNqcmRTSAIDicyLkibozcdWiAKk
 VhtayDM4RA93Wss+vZ454uebO6XlktU/Im7HvaToWY6SOhvfepwkje4ATpWmMP+szM6wi71pRC
 rfdnYELjt4FkMJaLaqPbxqutwPV/SGXr1Wz/OMViB2XD161xnkZZCjFK662HHZcZa6N9+BrUTZ
 l84rrLZc7rjMP4FA7a60C858vy/ILwQn6n5YBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7920;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=DuAtA4pcODAfHqkwCpGDO85Ac4uflEax5F2Nla9CEqo=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn9DCtv3BDbfPdePIcau2qYbap3u0lCbH9yTdiEVpOPr
 HkX8mM7SlkYxLgYZMUUWarFrfOq+lqXzjloeQ1mDisTyBAGLk4BmIjoNIb/NQdexc37diLyWdzR
 I4H7Itm0c856H+iLuO+ydU5jctCKDEaGF9qHtOJeTLOYV3Yv2F/zm/V7vYkt3yUFXlx4cz3jSa8
 DBwA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8f00b2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=bC-a23v3AAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8
 a=EgIEG_Zc0jmtSiAReEwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX9jITIz4AuTa7
 J+589L23Bzpf0kwdkM4tQ05k7VkQHDA3iyDPETKgx0+anCfSyR76Z0uZU4H8zDD0qutAd/FK/6X
 kytoJlH8UsmsdCTjGc9RztaXesTdbCU=
X-Proofpoint-GUID: gK_nrN3wJzPO5SqeX5bgFjPtjSj1osAL
X-Proofpoint-ORIG-GUID: -mQZmmsSMAyA1W5AOT1khdeB2zPP8-yB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX5ivFU6Z9bmkO
 k3kO4YGb4ATJzyF5YabwqpK+CJvsKDbDnctgZ3SJ5r6iZfCPrmqaFoCoCOhI+/YVSLFcmdbwMzM
 i2eh3qSwnpGM0QTqiOhFLKbNu9EwWadhKCcWzgJs7v1WGkRwqIZYXVlmAoDtUP+BkzFD81PEz0Q
 gSY8lj9b8Eejg9q3DVznmvrAbv9OCpq+iyR5fPEwZK1B4M93Q3ecM4vTN0C09xeekqcbNGPv8R2
 p5cStHz1iLFVgypBxO2ElYtZGgAxv95z0HcYAHsi1xOUrDoaAa0R3Nty+cA7aLGUgs9kC17TF48
 NLJVk03/WldfJ8IwJxKlbGpIAoUg1cA/bJzxn/1CdhU4D0c6wuE1nlzjKrYMRRuDvBB+Qkdldsx
 Wv/mY7tqvFd5rqvbVAdnA37mG4FFMVIQ/CerPpUmC57LjKcztx9oDSawIm6Vcl4eI1Q5st+zN2l
 u7RuV422rlBkv/hsZjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260125

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
 arch/s390/kvm/s390/vsie.c                      | 1311 +++++++++++++++++++-----
 drivers/s390/char/sclp_early.c                 |    1 +
 tools/testing/selftests/kvm/include/s390/sie.h |    2 +-
 7 files changed, 1111 insertions(+), 275 deletions(-)
---
base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
change-id: 20251113-vsie-sigpi-3de01243efd6

Best regards,
--  
Christoph Schlameuss <schlameuss@linux.ibm.com>

