Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83AA3624CF;
	Thu,  9 Jul 2026 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610133; cv=none; b=M39IETxIf9hcq2vaWYYejEUugu0kzFxfX6ekJTiLbKw+3uTxUKz2l1ajFEXjmOVbkWnLVbiTDWegNg/muPBRrUTfst/nlVPzdSeiJw/3C1tvXfHIfe6GTq4kAKm1kwrSCKD82Qnmtm/QG1Z9tzN5clNUASoo3FfyIh0su7bhmkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610133; c=relaxed/simple;
	bh=hL/0OxJeeH4vxgJc1YymF4ALKvmWl7m2uYZ1FXUgkxk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tJvBiiVmiBCTegbdcsTYDnWAJeaCL9ChgdOsTBo2G3HIboLxEkcRLWYkI8peTYWNOV134kyv0nMeemILyERB7PkDTlaVvCSoZUlHzXbwSVCE64ccGgFD0uqn2VMzyke9V2jxQldPsAZz/zaVcLW6H5AC1QqFEA+n3IsoD4ePuD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ks6hnpD7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ks6hnpD7"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669EIUQa2551664;
	Thu, 9 Jul 2026 15:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=RiRpUD1sBxdL0kpDsqp8FS80ldSI
	ioF+MdmVSbuMla4=; b=ks6hnpD72zo/LT40hoL85i0dTBwZPON22tTOPZNMOkC5
	mAMAs9uouCpjcRCE0wz88afU/EbPksLfFnDtZ9x0A/nirciZvm9E+tCyc+fT/XZH
	+mO6a5DhnOmeYH/HF0EyXuAM+R3Y1Onglvw79Ul3wA1zDAQrSBchzlqxl5lmsbU6
	C484YFRbj2B/i1BpWLAuYDxCYKbOQpHSxC0dQnZkom+tAxTAm/R/GOfJvmaQkSqP
	173qtkvsWeiyKLDt/v8JDo5y4H3naYJE1PXHWfi/5uJ9r4XxG+3C8JtcsizwCjmj
	62XA5/ffFmsM8Xox6x9mR15Xof1QS/t82+Eup7RgMQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknssps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669EnaxU028343;
	Thu, 9 Jul 2026 15:15:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgqdwcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669FFJYm51446060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 15:15:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47B3F2004E;
	Thu,  9 Jul 2026 15:15:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 959162004D;
	Thu,  9 Jul 2026 15:15:18 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.64.199])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 15:15:18 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Subject: [PATCH 00/21] KVM: s390: vsie: Add VSIE SIGP Interpretation
 (vsie_sigpi)
Date: Thu, 09 Jul 2026 17:15:00 +0200
Message-Id: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6DIBCF4auQWZdUoO3CqzQuqIx0FoCdQdPEe
 HeJLr+XvH8DQSYU6NUGjCsJldxgbgrGr88RNYVmsJ19GmOcXoVQC8WZtAvYGftwOIUXtMPMONH
 /jL2Hy4y/pTXrNcLHC+qxpES1V4UpUr4nLxUZhn0/ACcBC1+NAAAA
X-Change-ID: 20251113-vsie-sigpi-3de01243efd6
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Eric Farman <farman@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@de.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4017;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=hL/0OxJeeH4vxgJc1YymF4ALKvmWl7m2uYZ1FXUgkxk=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn+u5mkmN2cf0ilu7y5ZG/4z0b4y855Sg1nJq+3n7urV
 6lhutvxjlIWBjEuBlkxRZZqceu8qr7WpXMOWl6DmcPKBDKEgYtTACbC/Jvhr/S2GwwrYuvkEnly
 DJJvnXTTk5c+pbtKZ4v9ft0fS7I++TH8d39nIl8qeNlp0xXVfNZVa1IqPjwX3swUzhPNKeJ53/w
 vNwA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4fbb10 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=7vDbEVZ9YygXXmxz0SQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8Ei27kUEYMXYG_fEVUbynv9-tR47jhs_
X-Proofpoint-ORIG-GUID: 8Ei27kUEYMXYG_fEVUbynv9-tR47jhs_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX9wCq6TW4HQhS
 o8HvrTS3st6W6fLN6Qk0iwgCHPpX44PwJcU+kTA7iGRvYa3kkG594bQUm/FGLtXfhr8O6hIeQBj
 Vt9z+hZzjfJve5HzmunVNLkd96HGUOE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX3P5hOG9kiRIE
 ERaIL2wDkDgVIlrNqBMO3tVJPMWdpc1as4EMwmklJfsleVAaE0SNpHBe1fxZQKcjcFs1DXxT+AW
 gpMdeoGkLYgl9WGFKmzPMjzAD0iDz7PfZWN6vBXMjUSPC0IN3vLLZMPLKIFA6gbm7U1Tf1OCR3u
 Jk1qFp/OWKDVmm4hwfQHBQXEF2Vm0Cc2dywWLaK/kkd0/rtEprZYQHAeczDz6CVHnJRC2zOGff+
 oKPVh8uBlHDJC/B5muXFcVFh4Pm48D5jKFnT9LfHdS6j2uUAx23ZzJqDmo5Q9RKbkEeTBN/LrKd
 psvSXg6sxNueDwJko1kU0b1AmfO6Ftz6KYSrEeOkzq7bTVLM6B4hjv2DSBXU6AIcVLXxBJ/oMR2
 rPCQvgW/mcGzLWhgDnmYIOTPjVt3bsBG15n6c3o92LtGUl2GW31bp9paoC3k3M3Z83cnOkBBa60
 BR6w7tusxBVuzcf0TIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090146

In the IBM Z machine generation z17 the s390x architecture does have a
VSIE Interpretation Extension Facility (vsie_sigpif) to improve guest-3
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

The series includes some changes to the non sigpi path as well.
- original SCA is pinning is lazily kept after exiting vsie
- addr_to_page radix_tree usage is replaced by xarray

Due to no ESCA support in old g2 kernel and qemu the patches do
introduce a limitation for setups with a unaware g2 when g1 KVM has
vsie_sigpif=true the g2 kernel will report KVM_CAP_MAX_VCPUS=64.

---
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

---
Christoph Schlameuss (21):
      KVM: s390: Remove double 64bscao feature check
      KVM: s390: vsie: Remove duplicate assertion
      KVM: s390: vsie: Convert shift to phys_to_pfn()
      KVM: s390: vsie: Add SCAO read and write helpers
      KVM: s390: vsie: Move SCAO validation into a function
      KVM: s390: vsie: Add vsie_sigpif detection
      KVM: s390: vsie: Add ssca_block and ssca_entry structs for vsie_ie
      KVM: s390: vsie: Move pin/unpin_scb methods
      KVM: s390: vsie: Move pin/unpin guest page
      KVM: s390: vsie: Move release/acquire gmap shadow
      KVM: s390: vsie: Create helpers to alloc and free vsie_pages
      KVM: s390: vsie: Replace radix_tree with xarray addr_to_page
      KVM: s390: vsie: Add helper to pin multiple guest pages
      KVM: s390: vsie: Add helper to release gmap shadow
      KVM: s390: vsie: Add struct vsie_sca with pin and unpin
      KVM: s390: vsie: Shadow VSIE SCA in guest-1
      KVM: s390: vsie: Allow guest-3 cpu add and remove with vsie sigpif
      KVM: s390: vsie: Add VSIE max shadow configuration
      KVM: s390: vsie: Add VSIE shadow stat counters
      KVM: s390: vsie: Create minimal scb shadows for not running g3 blocks
      KVM: s390: vsie: Enable VSIE SIGPI

 arch/s390/include/asm/kvm_host.h               |   28 +-
 arch/s390/include/asm/kvm_host_types.h         |   28 +-
 arch/s390/include/asm/sclp.h                   |    1 +
 arch/s390/kvm/kvm-s390.c                       |   18 +-
 arch/s390/kvm/vsie.c                           | 1185 +++++++++++++++++++-----
 drivers/s390/char/sclp_early.c                 |    1 +
 tools/testing/selftests/kvm/include/s390/sie.h |    2 +-
 7 files changed, 1001 insertions(+), 262 deletions(-)
---
base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
change-id: 20251113-vsie-sigpi-3de01243efd6

Best regards,
-- 
Christoph Schlameuss <schlameuss@linux.ibm.com>

