Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63B23B4EBD;
	Wed, 30 Sep 2026 07:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790753781; cv=none; b=iTL8ZBIedP9db5yA5KPGs66AOA2XVgNHLGX07tpu4lPK5OCg4ocpg2H8uneWBdFokf7nxDV7YmMMr3bsvLF2CmXc1XEuQm2cbq+pJnXqFRdQS7us8INe8FlR/T/E6Pr63DDfHVVeb5EadrhD7SAk3O5G+4BWYWO/H4Ap0IQFW0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790753781; c=relaxed/simple;
	bh=DipoJ9RjjrXMz5bYKv74hrheEodgN85s4+ClCjBS0Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqVviSG+eulcNqr7Enu3l8bG+8o+eQpwqd00wZsZIAQ4tLKGNGT0Cd2uUF/jfxdxO3v6L2eheSlbRCMVp7TdIYDhDSqPl1QJkZC3zk9abzbQBfZdxkrBQR2Y6W8/XuuvcIAeMJBv/cDNX3E5hRr5L0whCNN3Po8R/deIDia+i+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rv6Y3Dyz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rv6Y3Dyz"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TNZuQ61172224;
	Wed, 30 Sep 2026 07:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=LXc5IPA3Ts9jz9cHbi3SGJcANTuikq
	wfUBg8u2NSd+Y=; b=Rv6Y3DyzUXFOBexDRXVGWc1MCIPgxU6tt24x/Q/hWu1XVb
	psuSCndSHBLa+h+FEqPK7r4RRNTQOKegxhtWPda32e3Hzs3I/oCwO+0k2x6UTXoC
	+9nPoQeb6kZ+6xY9+vl0bbjtIE0Q1IiYF0QLx+f9ZDeg9o5kChf/pAE0antM9toI
	HTmkdFrLh6MTlhEqCabZowDJ8eZWBu6lZv/f6Cdu5QWJ9t4x6yhnwnKfAomTaf4x
	KyKll4tqNvuJrZDT2aT6NkixPtbNEsxQGsZE6paOeh37N2eyhK6Cha8lC+KIAevi
	Lo5EhjOufO9zbF+ZzYQ00Ypw89ikyvf2V7lAHncg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkb10m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 07:36:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68U4rovP2589538;
	Wed, 30 Sep 2026 07:36:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0g8e326g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 07:36:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68U7ZxB343057454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 07:35:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B431E20049;
	Wed, 30 Sep 2026 07:35:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C839F2004B;
	Wed, 30 Sep 2026 07:35:58 +0000 (GMT)
Received: from osiris (unknown [9.111.12.23])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 30 Sep 2026 07:35:58 +0000 (GMT)
Date: Wed, 30 Sep 2026 09:35:57 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
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
        Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 4/6] KVM/vfio: Use file-based reference counting for
 KVM
Message-ID: <20260930073557.770322-A-seiden@linux.ibm.com>
References: <20260928-vfio-v4-0-e32e226d5932@linux.ibm.com>
 <20260928-vfio-v4-4-e32e226d5932@linux.ibm.com>
 <20260929195954.3db8f840@p-imbrenda>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929195954.3db8f840@p-imbrenda>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: hxwnLzwH_8nsXHqSd-L5i4IY_ZXL74SN
X-Proofpoint-GUID: OnUwbumxm2AOJQpv7S_XRm3D9ULTJsOn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyOCBTYWx0ZWRfX1qP5KKMRMc09
 N0iUJS8Kqw0bvLrYy6Krq3ViwTlEsEbuncuZtGrLGzrBTkZMShujxIJ1RSpgp7pOkNikaAup50I
 pfyA570fBhWuqiIvRlLQVRR9lP9ROOw=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abcbbe7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Ikd4Dj_1AAAA:8 a=1XWaLZrsAAAA:8 a=cSaYzA00SFW3ExK1YA4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyOCBTYWx0ZWRfX8Xk4QZ+dcaAJ
 83P4K1J+Yr4yL2xgRN4vUbejx+Alu4g93CyUgeGO/MNuV5C6vVij/YToAotZ4QmvSoznKVa0ybr
 P9Ry8U9tsy8Eq4rUfbtFi/4rxDcZHUw0akEI/YFmJA7NaMpUY8SNHSD+goc2MPvnxChjkChA0Hk
 1Wa9aDaRN7cezwAGMEZs0NvIeLKQefZ+W5NwJw7sRhlgiuSKQDF6fL5fy6gaQfj9lgkwvyu69GA
 vcN2iR8xUU5pC+du9H9leyv3F2/M9SjXiydxcukmnZVvO4SSmMuROjFe2vAon/ad7Nf20G4vQAP
 yRgqnN7D7ivPriKPutl6M5JuoXEynkAgSR6dvzVgzLlgIzB/xsDV7f14rtBWPMFgLvgAuMMss05
 CmOZ7Nacm0MyYvmnYmlc3joL1fvc+YZFdLD6lbe7uIKbKVXxZlyKrZ8H/E8r+HOkPX2yGjQOQco
 l8jVK7oZvXMRqGyfGJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300028

On Tue, Sep 29, 2026 at 07:59:54PM +0200, Claudio Imbrenda wrote:
> On Mon, 28 Sep 2026 15:07:05 +0200
> Steffen Eiden <seiden@linux.ibm.com> wrote:
> 
> > Replace manual module reference counting with file-based reference
> > counting for KVM integration. Previously, VFIO used symbol_get() to
> > obtain function pointers for kvm_get_kvm_safe() and kvm_put_kvm(),
> > then manually tracked module references through these symbols. This
> > approach required storing the put_kvm function pointer in each device
> > and carefully managing symbol references.
> > 
> > Pass struct file pointers instead of struct kvm pointers throughout the
> > VFIO-KVM interface, leveraging the kernel's existing file reference
> > counting via get_file()/get_file_active() and fput(). Convert the x86
> > page-track API and update s390 vfio to use file_to_kvm_<arch>(). This
> > simplifies the code.
> > 
> > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > Co-developed-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> > ---
> >  arch/s390/include/asm/kvm_host_s390.h |  2 +-
> >  arch/s390/kvm/s390/pci.c              |  9 ++++--
> >  arch/x86/include/asm/kvm_page_track.h | 10 +++---
> >  arch/x86/kvm/mmu/page_track.c         | 22 +++++++++-----
> >  drivers/s390/crypto/vfio_ap_ops.c     | 20 ++++++++----
> >  drivers/vfio/group.c                  | 11 ++++++-
> >  drivers/vfio/vfio.h                   | 12 ++++----
> >  drivers/vfio/vfio_main.c              | 57 +++++++++++------------------------
> >  include/linux/vfio.h                  |  5 ++-
> >  virt/kvm/vfio.c                       | 13 +++++---
> >  10 files changed, 87 insertions(+), 74 deletions(-)
> > 
> > diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
> > index 8a7eed5847e1..9519b8028b10 100644
> > --- a/arch/s390/include/asm/kvm_host_s390.h
> > +++ b/arch/s390/include/asm/kvm_host_s390.h
> > @@ -722,7 +722,7 @@ static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
> >  void kvm_arch_free_vm(struct kvm *kvm);
> >  
> >  struct zpci_kvm_hook {
> > -	int (*kvm_register)(void *opaque, struct kvm *kvm);
> > +	int (*kvm_register)(void *opaque, struct file *kvm_file);
> >  	void (*kvm_unregister)(void *opaque);
> >  };
> >  
> > diff --git a/arch/s390/kvm/s390/pci.c b/arch/s390/kvm/s390/pci.c
> > index 82892e1e03d9..d79bd3bdc68e 100644
> > --- a/arch/s390/kvm/s390/pci.c
> > +++ b/arch/s390/kvm/s390/pci.c
> > @@ -498,17 +498,22 @@ static void kvm_s390_pci_dev_release(struct zpci_dev *zdev)
> >   * available, enable them and let userspace indicate whether or not they will
> >   * be used (specify SHM bit to disable).
> >   */
> > -static int kvm_s390_pci_register_kvm(void *opaque, struct kvm *kvm)
> > +static int kvm_s390_pci_register_kvm(void *opaque, struct file *kvm_file)
> >  {
> >  	struct zpci_dev *zdev = opaque;
> > +	struct kvm *kvm;
> >  	int rc;
> >  
> >  	if (!zdev)
> >  		return -EINVAL;
> >  
> > +	kvm = file_to_kvm_s390(kvm_file);
> > +	if (!kvm)
> > +		return -ENOENT;
> > +
> 
> the !kvm check (which you remove in this patch) returned -EINVAL, but
> now we return -ENOENT. Is this intended?

Yeah, kind of. This is now another kind of error. Before: if kvm was NULL
it was somehow not set by pci/kvm. Now: it might be an incorrect file handle as
file_to_kvm_s390 cheks for this. 

> 
> is kvm_file always guaranteed to be non-NULL? We checked for !kvm
> before, why don't we need to check for that now?
>

file_to_kvm_<arch> already tests for !kvm_file before it verifies it is
the correct file handle (by testing for kvm_fops).
So kvm_file can be null.

> >  	mutex_lock(&zdev->kzdev_lock);
> >  
> > -	if (zdev->kzdev || zdev->gisa != 0 || !kvm) {
> > +	if (zdev->kzdev || zdev->gisa != 0) {
> >  		mutex_unlock(&zdev->kzdev_lock);
> >  		return -EINVAL;
> >  	}
> 
> [...]

	Steffen
