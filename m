Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8566D4418EC;
	Thu, 24 Sep 2026 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240345; cv=none; b=H16q9IFO0SmssUJ/A75vKdOOvzfPn39V+hIFpGLOJmdbhENu+Bx1Wp/uA2QDkA/9LiFbMUuxJjGTVYKWb7EX2Dpy+lAypuMrO7azcvnTDZLgkEwqcKYvBDfSkG5RxvU92xxBBPR/BvW+0h6M+2c7of3c+OSyW03HUED68/NBbd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240345; c=relaxed/simple;
	bh=c71TO+blIqIva/NvrFUNbJLZSjMREpaAxHd+thnFo4w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BLDDkTKDnxW8wWSGQiiy9lpaqRuQ2E4QN2ij2zXG4rsvY+MkgHaFWnf5bfcRGPXnFaiHqjzK7XfRij8KzfOx8I28LAz6E1HxeMrFxwo6L7iAjCpOlOLef9vjHXh1HShqEIlVUATR1fNv0E9qLvzW9x2+hIcxj8xtbTKjwx1cF14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ordu3U5I; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ordu3U5I"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5bS3u159870;
	Thu, 24 Sep 2026 08:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=Wdz7jdDkluBFsABp0WUP1YQfvmwo
	/lsMhcWKBdjr4u4=; b=Ordu3U5IcANgoY8pBXeJ6/CrTLIEmL9C6GESTLbDsiEw
	S0JoxMoUhdps+HVvV6t5k/41jbES+tztfId4JK/yY/MWNLNYs48jkQmUT675atQz
	F3txaFbBe9ARoNxd0qwAtrQ+Q3bWzir+8RLjkfp5An4OV59gft7acRqy57Ko/2Qe
	Oe4HaRZKMG+IXvHYU3bvQEGcdLAomcOOjsVgzGIRWB2fob7Q6o6z4lttWOZbyEPH
	trM9F3Ya8VcdfZp6hVeqzwS47nMdWgsscY1PAqYBXGlHyQOhUOoHHP4tC6c9cv6u
	My6tB6uW/HH6fQG3bCSQkT0ev8IPfeA/+zs/6R3aqA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqq8rq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 08:58:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5lfIC1501547;
	Thu, 24 Sep 2026 08:58:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2vsrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 08:58:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68O8wdXR45416946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 08:58:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18CE22004D;
	Thu, 24 Sep 2026 08:58:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD97B20040;
	Thu, 24 Sep 2026 08:58:38 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 08:58:38 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Subject: [PATCH v3 0/5] KVM/vfio: Use file-based reference counting for KVM
Date: Thu, 24 Sep 2026 10:58:29 +0200
Message-Id: <20260924-vfio-v3-0-4a294307797b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WMwQ6CMBAFf8Xs2ZK2FKSe/A/joZStbCLUtNpgC
 P9uISYmepyXNzNDxEAY4bibIWCiSH7MUO53YHszXpFRlxkklzVvhGTJkWdO81p3jWkrVUG+3gM
 6mrbM+ZK5p/jw4bVVk1jXn0ASTLDKOuStcEbh4XSj8TkV1A6F9QOskSS/oublR5RZRKdsp4Tm5
 l9cluUNbAIZF9UAAAA=
X-Change-ID: 20260812-vfio-f9069d8ab545
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab4e644 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=1mAWvp4K8iewrBkhS6QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzNiBTYWx0ZWRfX4M1RTSRDAMB7
 zAA1SYgJ9yyvxaxsfzSwMURRLFB/4dgiiK1RxLsPXkQd8b64MZX2oPfiIxLLFFwOKw87JUp/918
 ZV0ZQehqXkpthhBjYRGIzcfsCk+CPtjE0bHs+fEpTuTTL49jP7GWZAHP7To0fpwnb4jlODFC/bc
 0RwbCrqlVVk9dojCySJ6YonikcYpCieR+Dbf3k9QmWVPEloxSGDdmssQKEYK9V8d2+AOYLM+EuG
 JAlkcoCNYoaKTVCt0mcTLxERkxmQgxxEj//h6XtoSD0nBnKWIZaHRj/tFE1NhnOWOert9Oeno41
 ABTfURbEHxMHwictyU8hV/vrt9/FDr915SsgodZdRtYRXhBEgHC/DJYf3gsTXtwWH4KXRbGNxL/
 VFyIdW6e00yZIzF4E8jPlPkZjbUJCybvDgiKHsml8HyrR/aurNeXb9szyz8edirAZtwK2IxUVju
 cBLPrJeudEQ1e9ugOXA==
X-Proofpoint-ORIG-GUID: dhZG-DwmV8FLuJU6xfGDSe93zXcG6yOw
X-Proofpoint-GUID: eYJQvDkhqoJrvTTvifKATnregwLRSDPT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzNiBTYWx0ZWRfX6ZamDHATg9W1
 du3MhUOX9o2eF2/0apzVTLmbqy11JirutQZHTKilTa2uvnPQJZ6pRV5IKyU34RhbJuKkox0Zdr0
 UQnbkU/8oKtTG+pi0hTeK++ssh7FVwU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240036

This series switches the KVM-VFIO interface and external consumers over to
standard file-based reference counting, eliminating all external KVM symbol
exports.

This is a spin-off for the arm on s390 series [1] to address all the
relevant persons w/o polluting their mailbox.

Currently, VFIO integrates with KVM by looking up kvm_get_kvm_safe() and
kvm_put_kvm() dynamically using symbol_get(), manually tracking module
reference counts and storing a put_kvm function pointer in struct
vfio_device.

In the ARM64-on-s390 architecture, a second concurrent KVM module
(kvm-arm64) is introduced alongside native KVM to host hardware-accelerated
ARM64 guests. Having exported global symbols (like kvm_get_kvm/kvm_put_kvm)
creates symbol conflicts and prevents clean coexistence of two KVM modules.

Additionally, the file based counting simplifies the code and reuses
the existing fs refcounting.

Instead of passing raw KVM pointers and managing module symbols manually, the
interface now passes the underlying VM file descriptor throughout VFIO and
associated architecture subsystems. To safely extract the KVM instance from a
file, an architecture-namespaced helper mechanism is introduced that verifies
the file belongs to the expected KVM implementation before accessing its
internal state. A back-pointer from the KVM instance to its associated file is
maintained across its lifecycle so subsystems can safely acquire file
references on demand. Finally, with VFIO, architecture page tracking, and
device hooks converted to use file references, the remaining KVM reference-
counting exports are restricted strictly to internal KVM modules.

	Steffen

[1] https://lore.kernel.org/all/20260918133107.1042730-1-seiden@linux.ibm.com

---
Changes in v3:
- Split the previous single monolithic patch into 5 smaller, focused patches:
  1. Add opt-in macro infrastructure for `file_to_kvm_<arch>()` helpers.
  2. Add `kvm->file` back-pointer to `struct kvm`.
  3. Use `file_to_kvm_x86()` helper in AMD SEV.
  4. Convert VFIO, s390 vfio-ap/zpci, and x86 page-track to file-based refcounting.
  5. Restrict `kvm_get_kvm`/`kvm_put_kvm` to `EXPORT_SYMBOL_FOR_KVM_INTERNAL`.
- Introduce macro-generated, typed `file_to_kvm_<arch>()` helpers instead of generic casts.
- Clean up `vfio_pci_zdev.c` by passing `struct file *` through `zpci_kvm_hook.kvm_register`.
- Update x86 page-track and s390 AP/PCI to use `file_to_kvm_<arch>()`.
- Update x86 Makefile export checks.
- Link to v2: https://lore.kernel.org/r/20260903-vfio-v2-1-ef4cd4190ae7@linux.ibm.com

Changes in v2:
- Rebase on 7.3-rc1+ and resolve conflict with 9f240376d034 ("s390/pci: Store
  PCI error information for passthrough devices"),
- Fix stub prototype for vfio_group_set_kvm for !CONFIG_VFIO_GROUP
- Link to v1:   https://lore.kernel.org/r/20260812-vfio-v1-1-5cfe0b1fa4e7@linux.ibm.com

---
Steffen Eiden (5):
      KVM: Introduce file_to_kvm_<arch>() infrastructure
      KVM: Add file back-pointer to struct kvm
      KVM: x86: Use file_to_kvm_x86() in SEV
      KVM/vfio: Use file-based reference counting for KVM
      KVM: Restrict kvm_get_kvm/kvm_put_kvm export to internal KVM modules

 arch/s390/include/asm/kvm_host_s390.h |  4 ++-
 arch/s390/kvm/s390/pci.c              |  9 ++++--
 arch/x86/include/asm/kvm_host.h       |  2 ++
 arch/x86/include/asm/kvm_page_track.h |  8 ++---
 arch/x86/kvm/Makefile                 |  4 +--
 arch/x86/kvm/mmu/page_track.c         | 22 +++++++++-----
 arch/x86/kvm/svm/sev.c                |  8 ++---
 drivers/s390/crypto/vfio_ap_ops.c     | 20 ++++++++----
 drivers/vfio/group.c                  | 11 ++++++-
 drivers/vfio/vfio.h                   | 12 ++++----
 drivers/vfio/vfio_main.c              | 57 +++++++++++------------------------
 include/linux/kvm_host.h              | 18 +++++++++++
 include/linux/vfio.h                  |  5 ++-
 virt/kvm/kvm_main.c                   | 21 +++++++++++--
 virt/kvm/vfio.c                       | 13 +++++---
 15 files changed, 130 insertions(+), 84 deletions(-)

base-commit: 5dd1818b15d98d4a20806cd00b1b40320b06004f

---
Steffen Eiden <seiden@linux.ibm.com>

