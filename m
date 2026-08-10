Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29A332B130;
	Mon, 10 Aug 2026 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377263; cv=none; b=OyyKFyz3JyQeQA8fwQ1/4pBj+ucZ9P9qSBm0sx1CpWi6fEWI+p10FVxNEBcOl9DZztfQLho7Wt2tbhD0R6sg1wjY7PJl/OCVUb1RiT2wfyQDEopPN0DKiVBGUm0BHnaUTqe/DABntXMuI1pk/ki7mCaivnLQYKtzAduU1i7HLZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377263; c=relaxed/simple;
	bh=2YxjWDe9s60n5QMyPjATsSHigb4IKF6uo+a0gYB+WIM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nASjSb5Tar/WwvBiucrZhvEKOH4+2jrbbwmRANfyNr4YWAHgilBUy3E+wW6F75jU+GhG7Ag96zphqwubZoGtLnwjm8SfamjERqyd+0WqdFtO61zgGSVeq4BLVsJ0PDksel7ds5rD5o2no0NZwHo01g0lqNu7u0/yIattC/Bh7Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YeaXkuZo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YeaXkuZo"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AFWm8L1982487;
	Mon, 10 Aug 2026 15:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=HiQGFBM0mTIKNbjZW2KJaMYtyMBo
	c3A5HtT+wZMX4qc=; b=YeaXkuZocusP2dALlrBtvDLPYzjDeZRoeRTEkBxFBWHK
	mserNNAQ3R6VzV04axltIZVOKQhzh10lanls3fhJkY6KWA3CoUlmlx7DYfpZTBIj
	YJ8PTtA1jtnl47FJ2Qy8Ul3CNQZSjT9FBqSW5BAGnzOGKDs9c0Pw4lsm9hzI80cS
	p9gNjo2+Xx6+ayOcmSSQyrtqTyePP/ar8IkAUj16Mb6lqpHiJ7UCJCV8Ji2fx6QC
	FjQ4WmJ5CtNATnriNL9WAh8abbACPvcDWSwFSvk2mTm95dMC0uFQisHO+0JO+1o+
	jsEQCKuu5y6QqsixWQ6SIqrRcRpP9b2qt2hvQ2rImA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq98t5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:54:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AFgZWF016512;
	Mon, 10 Aug 2026 15:54:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9gwbs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:54:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AFsCgC51642698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 15:54:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 114E520049;
	Mon, 10 Aug 2026 15:54:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64E4B20040;
	Mon, 10 Aug 2026 15:54:11 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.111.41.151])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 15:54:11 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Subject: [PATCH v2 00/20] KVM: s390: vsie: Add VSIE SIGP ECALL and SRSI
 Interpretation
Date: Mon, 10 Aug 2026 17:53:48 +0200
Message-Id: <20260810-vsie-sigpi-v2-0-e8d59a2f2f70@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02PwQ6CMBBEf4Xs2dVt0Sqc/A/jocCCm0jBFojG8
 O9We/E4k915M28I7IUDlNkbPC8SZHBR6E0G9c26jlGaqEGTPiilclyCMAbpRsG8YVJ6n3PbGIg
 Po+dWnr+wyzVpz485Zk7JhMoGxnroe5nKbPDSidv1Nkzs4R8Y+aQNHZVJuPrO1s0jJhdPpqDKH
 m2dsy0XBV/WTcI0+NdvR7S+sHRNxX/lRSEh26JVmozZ0+l8Fzc/t1L129gLruu6fgBKNPi0FAE
 AAA==
X-Change-ID: 20251113-vsie-sigpi-3de01243efd6
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6488;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=2YxjWDe9s60n5QMyPjATsSHigb4IKF6uo+a0gYB+WIM=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFmVXxQzbp/ad2eRb/hSPT07Jb7tRW8Kk9OFpuWtanyQ8
 t1ttnlNRykLgxgXg6yYIku1uHVeVV/r0jkHLa/BzGFlAhnCwMUpABPhncTIME3c1HnZxoKVvCbb
 926Rqjc4cVFKxP1UKdfOH1OURK4bljIy/NQTbTkmbrGU/3/M5+s/1COS6/4EMi88oL2lwVFItoG
 bBQA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 76_-C2_hGfjozIghqDjY_-KABiA9awnt
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a79f429 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=g60jOLDkW94iq19WvOYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfX0uXz+nVDbvO9
 QeZ7ocoZwofgYSaR1+3bEBv2CBEXX2cUH9mq8J9MqOzkMqgoC397YWTi+iUwKKyyqrvkWduvqtz
 J9jPsKLhYkAM+wyg2LJmGTpCgPbMz6pzNr6n0UlE6CHCl0cJ6r9w8KZiOmHf1QdSWu27NvzoyGE
 5Z2yC3FR+R49MOKTnBo56wS0o+SHMTmTlVUXSeDRVy/AKklsh5RINjOL0MhCBjzc99IHm51bTux
 fc8TS2Liz8aWm3sXOV1CfY04wF4n21Gb31ieeB115MY5Plyeuib6nZc+klIRw2WgpuhF7oIUn8K
 lEq06uFQS9aL1XTQwKIt83+Mo86im3kOeuEK5EVm4PE5QkT6KOELHxlS9CY67fPsDq5L6MX/mYn
 Rl3xbpKco1LnEqCYP9V6AcHLiMy4kZxI51sijXp7RL+tiy2ne46hrC/GBqP4SgKpHMHxr/IsVf5
 nV2ElGHJIk+1D3y4VuQ==
X-Proofpoint-ORIG-GUID: 76_-C2_hGfjozIghqDjY_-KABiA9awnt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfX7BHnHOKv8j8B
 L6NaAcX0MrzBwLKrQEB7fy0Fwgce7Wu3AJZ5ha+YgtJRHqAATepKfgBotFXsaAiXxVQOy+57nvY
 1nkLbzEVctaR+8EwYW8djr1yIQAjEzw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100134

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

Due to no ESCA support in old g2 kernel and qemu the patches do
introduce a limitation for setups with a unaware g2 when g1 KVM has
ssca=1 the g2 kernel will report KVM_CAP_MAX_VCPUS=64.

---
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

Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Eric Farman <farman@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Nico Boehr <nrb@linux.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
To: kvm@vger.kernel.org
To: linux-s390@vger.kernel.org

---
Christoph Schlameuss (20):
      KVM: s390: vsie: Add SCAO read and write helpers
      KVM: s390: vsie: Move SCAO validation into a function
      KVM: s390: vsie: Add vsie_interp_extf detection
      KVM: s390: vsie: Add ssca_block and ssca_entry structs
      KVM: s390: vsie: Move pin/unpin_scb methods
      KVM: s390: vsie: Move pin/unpin guest page
      KVM: s390: vsie: Move release/acquire gmap shadow
      KVM: s390: vsie: Create helpers to alloc and free vsie_pages
      KVM: s390: vsie: Replace radix_tree with xarray addr_to_page
      KVM: s390: vsie: Add helper to release gmap shadow
      KVM: s390: vsie: Lazily keep original scb pinned after vsie exit
      KVM: s390: vsie: Add helper to pin and unpin multiple guest pages
      KVM: s390: vsie: Add struct vsie_sca with pin and unpin methods
      KVM: s390: vsie: Shadow VSIE SCA in guest-1
      KVM: s390: vsie: Guard against invalid CPU address
      KVM: s390: vsie: Allow guest-3 cpu add and remove with ssca
      KVM: s390: vsie: Add VSIE max shadow configuration
      KVM: s390: vsie: Add VSIE shadow stat counters
      KVM: s390: vsie: Create minimal scb shadows for not running g3 blocks
      KVM: s390: vsie: Enable use of VSIE SSCA

 arch/s390/include/asm/kvm_host.h               |   28 +-
 arch/s390/include/asm/kvm_host_types.h         |   27 +-
 arch/s390/include/asm/sclp.h                   |    1 +
 arch/s390/kvm/kvm-s390.c                       |   15 +-
 arch/s390/kvm/vsie.c                           | 1232 +++++++++++++++++++-----
 drivers/s390/char/sclp_early.c                 |    1 +
 tools/testing/selftests/kvm/include/s390/sie.h |    2 +-
 7 files changed, 1054 insertions(+), 252 deletions(-)
---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20251113-vsie-sigpi-3de01243efd6
prerequisite-change-id: 20260716-vsie-cleanup-202607-8690ba7ac3ea:v1
prerequisite-patch-id: 0af599c91d3f2d10c1d2918b6de8e84d593eae26
prerequisite-patch-id: 98bb44791da9135bd417bd9114fe301c19c13895
prerequisite-patch-id: 11a133c07f1d30a48898705db1c21e62d53f8f3b
prerequisite-patch-id: 02bb7b6f57ac045c9b2d37ba0177145a65337e59
prerequisite-patch-id: ef7e3c6deef90a8c91753eea4d4f50cc83204109
prerequisite-patch-id: 4b93b72638c82737b11db6792f365a4f27f8083a

Best regards,
--  
Christoph Schlameuss <schlameuss@linux.ibm.com>

