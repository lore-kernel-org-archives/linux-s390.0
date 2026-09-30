Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A524545D93F;
	Wed, 30 Sep 2026 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754379; cv=none; b=ojoi3XZTefcmUcxdAsbc4waQzHoAnWnN49nd9LT2kOToyk/UVtXNle4xu1ImFOTxErAoemPKF+FjmxxFCd3WVeKWutONei9484fwi1smZY+S6LVuGGl7SlF1OMJWoTek/I1/psCuvkCWXIeiusjZzagiW/bcfX0xlBMzPsWyNbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754379; c=relaxed/simple;
	bh=YDAydixwszqxYAdhXulZdaykr7vDmtsr39aeivsFPwU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlHw+o5dp6ry2um3WHHSAVWTZyD4w36WncE0eozJ3styCrHgHLRwEDkUYDyDOg+IVjps24jCK3BShqZiLaYoPuuD6qXBNTrBPIBN6z5yWGLvYX6L8f5kfzJUd23MClN6cCmf6Dq1EIdFm2/Gd6c+6cZ4hxXmgkXmy3MHZGaLbcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b0Kx9lSo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b0Kx9lSo"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U7aSGx537469;
	Wed, 30 Sep 2026 07:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dGjzFf
	LnZ7oKSJakW70tM6oXpl30vym5VL//cUA4ERw=; b=b0Kx9lSoFBvBEETO+cN9YK
	BgvQkPBpDnOhAElSO4j4WrLW6Sx5IIFytQ9UcyKb3fELtViSz9W3gInhX3Hprv4F
	QaFeoa5TIdD6jPfHqMUHa3fA5O2BEUvsiG4Ox2kk6nOKIo5EZOHtr/Lb4l+bk3J8
	6HmOMDkazA2N0sD++12D8MC/hAjtTaY0M+7IGwaBbcbyIuwuX5qaqIiDheOAYqDd
	u3btqL56n32IHFSWBSw4wHPEwneUABRJTN/0jRmLPQJcAEKqurxwfYwi4vvg8z5l
	ziNgZ2xYplFviNFLMh8mLEBj8542PGif1oVPfTHg0GuZKvYfhQfV72EYkWFwctfw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qrbjr5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 07:46:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68U4t7iZ1289126;
	Wed, 30 Sep 2026 07:46:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4p9e7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 07:46:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68U7jwlI41091340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 07:45:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 993BF20043;
	Wed, 30 Sep 2026 07:45:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 100D32004E;
	Wed, 30 Sep 2026 07:45:57 +0000 (GMT)
Received: from p-imbrenda (unknown [9.111.91.245])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 30 Sep 2026 07:45:56 +0000 (GMT)
Date: Wed, 30 Sep 2026 09:45:55 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank
 <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sean
 Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Matthew Rosato
 <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic
 <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald
 Freudenberger <freude@linux.ibm.com>,
        Holger Dengler
 <dengler@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 0/6] KVM/vfio: Use file-based reference counting for
 KVM
Message-ID: <20260930094555.606453ba@p-imbrenda>
In-Reply-To: <20260928-vfio-v4-0-e32e226d5932@linux.ibm.com>
References: <20260928-vfio-v4-0-e32e226d5932@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAzMCBTYWx0ZWRfX+24HRtVjrn+h
 uZy6g4FAqKMTIwCI5dDEMJSOb21g5D/x+HYg+XgCAVnkSf+1E7KTjzHSC0p6GPJ/LyjX4CtKP+q
 hd/ylYRFiUaul9dy4P7lm7Bk60DBYiExkhgEcV+i+gAlMlJkWr7cx+jMydpMSvXnSM2tp1GRFDN
 L15u1ZnLBHu25ZD5SJuJUJd8AWT/5TXErtcdK4wq3wdTx8xiaGFDtrm671Q/Dwwo1NvXF5PejGt
 Ak9y5DLlMI2CVqhtUIbwwGausv8LpLZlqARCGORDSsImECCdKcvMH30KzbAdaKkYBDtUCSaPvIU
 dPmbUemszrK9TeC5+gnKQLJG+rSFMmZ4Bw67h9K5VK+9p7WXOypFadAxUSsqE9rR5Eek0+R7DCw
 bvv97v6CEWSfS9rJ5ZC/w+FOh4CMTTbVe68AIgkHJRQtugpKHsxGSMX5a+MNw2yHbcEeP9ynb5Y
 UORp2lOI/5daYssM2Mw==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abcbe3e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ymbBGZbuHbOlQHgLLQEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Tw0I5bp1wQTZ59HITxZKut2tg9hqAoWW
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAzMCBTYWx0ZWRfX+EH1Wae3PBEk
 AcJqjFZUGxuFLi4fnaSnSsDtNkmg73xPgEqMZCwmmCgB0kZMufkAOrgMv0dW5H220Ef129iKYNf
 a4dO5dLGsZlvv+XdLbqquCW2qJ5mcZY=
X-Proofpoint-GUID: tjfDHuU1ArZBXava69oiDDZed4CwVhrT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300030

On Mon, 28 Sep 2026 15:07:01 +0200
Steffen Eiden <seiden@linux.ibm.com> wrote:

> This series switches the KVM-VFIO interface and external consumers over to
> standard file-based reference counting, eliminating all external KVM symbol
> exports.
> 
> This is a spin-off for the arm on s390 series (old version: [1]) to
> address all the relevant persons w/o polluting their mailbox. The
> arm-on-s390 series now dropped those patches and depends on this series
> (for beeing able to link with KVM=y)
> 
> Currently, VFIO integrates with KVM by looking up kvm_get_kvm_safe() and
> kvm_put_kvm() dynamically using symbol_get(), manually tracking module
> reference counts and storing a put_kvm function pointer in struct
> vfio_device.
> 
> In the ARM64-on-s390 architecture, a second concurrent KVM module
> (kvm-arm64) is introduced alongside native KVM to host hardware-accelerated
> ARM64 guests. Having exported global symbols (like kvm_get_kvm/kvm_put_kvm)
> creates symbol conflicts and prevents clean coexistence of two KVM modules.
> 
> Additionally, the file based counting simplifies the code and reuses
> the existing fs refcounting.
> 
> Instead of passing raw KVM pointers and managing module symbols manually, the
> interface now passes the underlying VM file descriptor throughout VFIO and
> associated architecture subsystems. To safely extract the KVM instance from a
> file, an architecture-namespaced helper mechanism is introduced that verifies
> the file belongs to the expected KVM implementation before accessing its
> internal state. A back-pointer from the KVM instance to its associated file is
> maintained across its lifecycle so subsystems can safely acquire file
> references on demand. Finally, with VFIO, architecture page tracking, and
> device hooks converted to use file references, the remaining KVM reference-
> counting exports are restricted strictly to internal KVM modules.
> 
> 	Steffen

Whole series:

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> 
> [1] https://lore.kernel.org/all/20260918133107.1042730-1-seiden@linux.ibm.com
> 
> ---
> Changes in v4:
> - Add patch to remove now unused file_is_kvm()
> - Add Jasons r-b
> - Link to v3: https://lore.kernel.org/r/20260924-vfio-v3-0-4a294307797b@linux.ibm.com
> 
> Changes in v3:
> - Split the previous single monolithic patch into 5 smaller, focused patches:
>   1. Add opt-in macro infrastructure for `file_to_kvm_<arch>()` helpers.
>   2. Add `kvm->file` back-pointer to `struct kvm`.
>   3. Use `file_to_kvm_x86()` helper in AMD SEV.
>   4. Convert VFIO, s390 vfio-ap/zpci, and x86 page-track to file-based refcounting.
>   5. Restrict `kvm_get_kvm`/`kvm_put_kvm` to `EXPORT_SYMBOL_FOR_KVM_INTERNAL`.
> - Introduce macro-generated, typed `file_to_kvm_<arch>()` helpers instead of generic casts.
> - Clean up `vfio_pci_zdev.c` by passing `struct file *` through `zpci_kvm_hook.kvm_register`.
> - Update x86 page-track and s390 AP/PCI to use `file_to_kvm_<arch>()`.
> - Update x86 Makefile export checks.
> - Link to v2: https://lore.kernel.org/r/20260903-vfio-v2-1-ef4cd4190ae7@linux.ibm.com
> 
> Changes in v2:
> - Rebase on 7.3-rc1+ and resolve conflict with 9f240376d034 ("s390/pci: Store
>   PCI error information for passthrough devices"),
> - Fix stub prototype for vfio_group_set_kvm for !CONFIG_VFIO_GROUP
> - Link to v1:   https://lore.kernel.org/r/20260812-vfio-v1-1-5cfe0b1fa4e7@linux.ibm.com
> 
> ---
> Steffen Eiden (6):
>       KVM: Introduce file_to_kvm_<arch>() infrastructure
>       KVM: Add file back-pointer to struct kvm
>       KVM: x86: Use file_to_kvm_x86() in SEV
>       KVM/vfio: Use file-based reference counting for KVM
>       KVM: Restrict kvm_get_kvm/kvm_put_kvm export to internal KVM modules
>       KVM: Remove unused file_is_kvm
> 
>  arch/s390/include/asm/kvm_host_s390.h |  4 ++-
>  arch/s390/kvm/s390/pci.c              |  9 ++++--
>  arch/x86/include/asm/kvm_host.h       |  2 ++
>  arch/x86/include/asm/kvm_page_track.h | 10 +++---
>  arch/x86/kvm/Makefile                 |  4 +--
>  arch/x86/kvm/mmu/page_track.c         | 22 +++++++++-----
>  arch/x86/kvm/svm/sev.c                |  8 ++---
>  drivers/s390/crypto/vfio_ap_ops.c     | 20 ++++++++----
>  drivers/vfio/group.c                  | 11 ++++++-
>  drivers/vfio/vfio.h                   | 12 ++++----
>  drivers/vfio/vfio_main.c              | 57 +++++++++++------------------------
>  include/linux/kvm_host.h              | 19 +++++++++++-
>  include/linux/vfio.h                  |  5 ++-
>  virt/kvm/kvm_main.c                   | 21 +++++++++----
>  virt/kvm/vfio.c                       | 13 +++++---
>  15 files changed, 129 insertions(+), 88 deletions(-)
> 
> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
> 

