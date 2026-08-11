Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CA043E06D;
	Tue, 11 Aug 2026 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455416; cv=none; b=XWGW9F2WlzF9sgCC6BdAeJJO1vB0YzKsxwzrZVTayBSNkDcRmKvdz2UKMPjat1XKgV+e8DxyNs4PrFlxh229dhbMM5nJifqffw9402HS69cxlFokjyXC6675mk5tGUboVtomjgfUHbjHiZXAUZMmEttNK/Pen66cqqdVSvcq+74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455416; c=relaxed/simple;
	bh=sJxfoRLzo13IvVczx/Z4Sbdi+o25zKUF1shoQm1Hxn8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WPWtuFMRVpC5rdcW+MbqkUdgG1wsNBjyuqGymL5txeKe5e3a5vJQ6Q7j5Yra+MwRo01VGl49Qr7SWWffkjKgrbyvye84qe7JAHhjQV1T+rPTHTziYuruauJRAzK25rWSqw9kzPQnY+prfMXw8gYi4bMpVexvDwSmGTd8L+PH7UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IziFt6gn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IziFt6gn"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDXJBq570120;
	Tue, 11 Aug 2026 13:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=rQDl+yUAinNMlvS4xsZ9bdMmTSSs
	8lGVXtE2slSCRUQ=; b=IziFt6gnHGK5C4Z8cTm/nWN9CVrng4FTbB8reyufvgKK
	7HhPEdF4rmUPEW+VAEbxD8n28LIqTINw1SYG64C3q/0nUNk4n+YVmpWLEggWbQAK
	X2jaU6BTZcKG6Ru1kZvF8nXg/1l/8k8X7wGolUuiszTH1IWlK5NeEomxKDdBpDuB
	WiG54UvzUoq+nBWRTajAEbDs+5h5N0K5PSycxhAUuXGVNsbFMwmai+uj6XR3tT7S
	yDp5Ovg3Y6ZezTGj0rKaA0GotqWLgbC1M1hYrlQteEv14j7O2rfwTWrylL+bkcNc
	efeNV0WX4ewvcEnUBjOB2Sytz1QBmULkkf3+sxiPMw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw4frg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BDQHS4008687;
	Tue, 11 Aug 2026 13:36:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g8xs2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BDaStH52167164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 13:36:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59E0F2004D;
	Tue, 11 Aug 2026 13:36:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A845520043;
	Tue, 11 Aug 2026 13:36:27 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.69.228])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 13:36:27 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Subject: [PATCH v3 00/20] KVM: s390: vsie: Add VSIE SIGP ECALL and SRSI
 Interpretation
Date: Tue, 11 Aug 2026 15:36:15 +0200
Message-Id: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12Py27DIBBFf8ViXdIBEvxY9T+qLrA9OCPF2AEbp
 Yr878Vm0bTLe8W5Z3iygJ4wsKZ4Mo+RAk0uBfVWsO5q3ICc+pSZBHkRQigeAyEPNMzEVY8g5Fm
 h7TVLwOzR0uMY+/zK2eN9TZtLLllrAvJuGkdammLyNJB7H01Y0LNXYVMknYZS6KzrbmjcOvPc8
 krX0JrSdApNEwXbXVcKy+S/j3+kapfl11C/nhwFB46mtkKC1meoPm7k1seJ2vGU7jqmovzFKwF
 /cLnjVX+pjbTSlvAf37btB1BOELlTAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6700;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=sJxfoRLzo13IvVczx/Z4Sbdi+o25zKUF1shoQm1Hxn8=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFnVqhEvxJ09O5NYGqdJ37Ve1K40o/jowQ1acxLTbF7ws
 Lp8/VzYUcrCIMbFICumyFItbp1X1de6dM5By2swc1iZQIYwcHEKwEQSVzMyPLJcxuB0cCP/GrEf
 N9jUcyv5AlZ/urSkzuLZ/AkTS/TiTRj+B22Qk8mt6XJOUZIqXrQp0y5hA8/r3+psdo4Nc9hPV6l
 wAAA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7b2561 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=bC-a23v3AAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=Ks_63i_EzwTcwWThHREA:9
 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: FXkOt9y4wcyymVJchBaAugVCtx2z2L-W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfX579b+W84dgO5
 XW2N4lmj4be8b1NkSVuvqxixIT90Mh+RqaQd6qJA/MnC69Iy7sXwN/A4Up2MEyAd6bAblIGSxwd
 k7V6JOAnNeTocbcJwCnqoX1RsS2FnM8ZUeR1j78ISe168MlbbMvTMo4CAc6hGshQB7obfh7hUdu
 pRFNbcadCznycHOE200ef5qny74TmBOFPoURIw66bsULnVndFqOldmX6cqg3oIGlUZpPROj1V5q
 QknjJ3+9DEHqjBL8VcbCa47PN0fAttYF9KbZYej9TAgRzi7z2glogXmWZO/VGiXB60OTYAQQ37D
 QK1jx5wU1+bb0wozsEG7remx4QLkvBSt3rfKstjH1rrkrZSgwQT+t83i5Hr7KVrchRNk3HeLxim
 7qxCFwmEtJuA/gsPTbteCl1sLLwXPU2qAhN9ZHN1BjnPRbQf3GfnVxwr5ebic41z0GUNDlyngJy
 iy+Fk7MBcvAwxAHh2Eg==
X-Proofpoint-ORIG-GUID: FXkOt9y4wcyymVJchBaAugVCtx2z2L-W
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfXxbYmnPDtCQym
 nhD6Nz5R6VhhiWYkVMcMcCBmJqAc62OtmtlHhhRX3wzwnQrSnRUJ0/tfS+yKpBs3uANeVfrp8ev
 yO2F1Q1wSAFWl3qWZ1wFjJ/5bOF8VqI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110113

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
base-commit: d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
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

