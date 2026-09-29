Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A662F7EE4;
	Tue, 29 Sep 2026 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790704824; cv=none; b=f1tRKjOda/YBy2RDCOeLgWisNKxlU8bLfQy5eeR8uFbeH4X5Gfmoy1yPIZavIdMYLXkXiADiS8msq6cinfF4MeKyuJDRb0jQVe0KmB9+bc8vQWYBd8Ak8Pwomm1JanHzibagr2U/RGiRQTbq4QvocYTuT0ylj9CQT0ttLBhAGxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790704824; c=relaxed/simple;
	bh=AenBsAv8ole41IBuZHCZTq4DORQfoaw6/0eMqQqljtM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zp/4pv5h/U/zVM6ALCJOp9RLYHYsJJPaSMh1Sl82VwMXJ0BPaPaMwGaHE+DpgfFNqX5uU3bquPOaaj0+JUZb2Jq+IPLB0xj2mr0NK7tYJXPVOuU0ZSRFLRbcNiG2KGcq/F5GNf3QRmp2GK6DXkZkI4okscs12bzV46DE6tYHRGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I44S7IZ2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I44S7IZ2"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB5YoN4017586;
	Tue, 29 Sep 2026 18:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=d0JBOp
	2Zgl56RrKCWGNjxKxPnVYKsxt8Rhm9tXG8ad8=; b=I44S7IZ22g5Nr4wtzxk7L7
	C+I98Tt56PrutHNvbAGbNLVM9VVkZSlpCnd8BaODTdn9kL7ERM6lbhTUx4t+6oBK
	avWXxepBFDLgdySYIBGmyLKpvtNKqhlc0bZ+ZFHPFd3894vlou6HfLGjob5oz+TL
	86PlU36kovjM6sOOqZDk4Wv1BQmqduswY4NlGn8Xo5uSfWMoSSZrS1LiVPn7v9EH
	/CrrUb2r8dubLPUOzdnwHMhVV3j209b+q7PnFjKBRlOfla8KnRuBDyC9WzFr6M4P
	UJotnSGC453OsUEWWfiYe735ZRkTSWjlPYw25R7Fk+QGABbl82Czk26mh5ZVku7A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pt7qw2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 18:00:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68TFj2Af2060753;
	Tue, 29 Sep 2026 18:00:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0g8e0g5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 18:00:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68THxwBc43057418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 17:59:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B1D920043;
	Tue, 29 Sep 2026 17:59:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0128E20040;
	Tue, 29 Sep 2026 17:59:57 +0000 (GMT)
Received: from p-imbrenda (unknown [9.87.155.98])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 29 Sep 2026 17:59:56 +0000 (GMT)
Date: Tue, 29 Sep 2026 19:59:54 +0200
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
Subject: Re: [PATCH v4 4/6] KVM/vfio: Use file-based reference counting for
 KVM
Message-ID: <20260929195954.3db8f840@p-imbrenda>
In-Reply-To: <20260928-vfio-v4-4-e32e226d5932@linux.ibm.com>
References: <20260928-vfio-v4-0-e32e226d5932@linux.ibm.com>
	<20260928-vfio-v4-4-e32e226d5932@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 8FT0QXAjdsG7nXQbB7MYupM2vTJ1wG2U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA3MCBTYWx0ZWRfX+S2CBX9hd12C
 ifGO/eO9xPyfANL0DrbHtwKrsjqJPsXsgTIAXjwNaw5ZIZCExUfQDAYoAGMSonXMqM4h7rf9guq
 gU5+ZxEognUHrPZqdNzj5pcouypvy6X2J5kgrA3wNCvxVpW74fcsF3wfTh91ZxogfYHgfofuQGa
 oGB3AzOT2cDeW5JCaDgwTkbxmlQj7s/1AB9gmxN4l+oW5M3ferqlD6UpBHcGHPL95sz6yc3aD77
 ao38QII6Rh0HfOo3EQI07qY/yP0WcajxvdCe0vQYvvI/UF+9Tr2KWTSCX3Dhs/+g43n7DOw2G4y
 ZPfw+2gAmYmfBWszcQdKWHzZWEwkot3VxQQ/0d6SbcqTS2XqRvnzSBp5yPStNEEptBgy4yORPvI
 1qReSU3FofQKXDqntHV1jUWmUW1Ysb/K1ubBIvQXiGLPqB2ftR5hz4w7a4jZ9b4utSH9urfQv8Y
 U8UEnIX6Aoun/NVOV/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA3MCBTYWx0ZWRfX1w8OIjW41n7J
 HyzifB24Af7oA3TEe33Fh/p4dWk4Ppqusm8tSokEPq5LSzfkasM52jNU4/gsJziUgnW9LfJPCC6
 LQ3B9qrbCpCoNJ5v6ouepj0K4ka8/xw=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abbfca5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Ikd4Dj_1AAAA:8 a=1XWaLZrsAAAA:8 a=NGxIVH0s-Lo3PVwwm9IA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: -tnjIJvNjZ9bd-j0AC8ySM0yhh7Lbf54
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290070

On Mon, 28 Sep 2026 15:07:05 +0200
Steffen Eiden <seiden@linux.ibm.com> wrote:

> Replace manual module reference counting with file-based reference
> counting for KVM integration. Previously, VFIO used symbol_get() to
> obtain function pointers for kvm_get_kvm_safe() and kvm_put_kvm(),
> then manually tracked module references through these symbols. This
> approach required storing the put_kvm function pointer in each device
> and carefully managing symbol references.
> 
> Pass struct file pointers instead of struct kvm pointers throughout the
> VFIO-KVM interface, leveraging the kernel's existing file reference
> counting via get_file()/get_file_active() and fput(). Convert the x86
> page-track API and update s390 vfio to use file_to_kvm_<arch>(). This
> simplifies the code.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host_s390.h |  2 +-
>  arch/s390/kvm/s390/pci.c              |  9 ++++--
>  arch/x86/include/asm/kvm_page_track.h | 10 +++---
>  arch/x86/kvm/mmu/page_track.c         | 22 +++++++++-----
>  drivers/s390/crypto/vfio_ap_ops.c     | 20 ++++++++----
>  drivers/vfio/group.c                  | 11 ++++++-
>  drivers/vfio/vfio.h                   | 12 ++++----
>  drivers/vfio/vfio_main.c              | 57 +++++++++++------------------------
>  include/linux/vfio.h                  |  5 ++-
>  virt/kvm/vfio.c                       | 13 +++++---
>  10 files changed, 87 insertions(+), 74 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
> index 8a7eed5847e1..9519b8028b10 100644
> --- a/arch/s390/include/asm/kvm_host_s390.h
> +++ b/arch/s390/include/asm/kvm_host_s390.h
> @@ -722,7 +722,7 @@ static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
>  void kvm_arch_free_vm(struct kvm *kvm);
>  
>  struct zpci_kvm_hook {
> -	int (*kvm_register)(void *opaque, struct kvm *kvm);
> +	int (*kvm_register)(void *opaque, struct file *kvm_file);
>  	void (*kvm_unregister)(void *opaque);
>  };
>  
> diff --git a/arch/s390/kvm/s390/pci.c b/arch/s390/kvm/s390/pci.c
> index 82892e1e03d9..d79bd3bdc68e 100644
> --- a/arch/s390/kvm/s390/pci.c
> +++ b/arch/s390/kvm/s390/pci.c
> @@ -498,17 +498,22 @@ static void kvm_s390_pci_dev_release(struct zpci_dev *zdev)
>   * available, enable them and let userspace indicate whether or not they will
>   * be used (specify SHM bit to disable).
>   */
> -static int kvm_s390_pci_register_kvm(void *opaque, struct kvm *kvm)
> +static int kvm_s390_pci_register_kvm(void *opaque, struct file *kvm_file)
>  {
>  	struct zpci_dev *zdev = opaque;
> +	struct kvm *kvm;
>  	int rc;
>  
>  	if (!zdev)
>  		return -EINVAL;
>  
> +	kvm = file_to_kvm_s390(kvm_file);
> +	if (!kvm)
> +		return -ENOENT;
> +

the !kvm check (which you remove in this patch) returned -EINVAL, but
now we return -ENOENT. Is this intended?

is kvm_file always guaranteed to be non-NULL? We checked for !kvm
before, why don't we need to check for that now?

>  	mutex_lock(&zdev->kzdev_lock);
>  
> -	if (zdev->kzdev || zdev->gisa != 0 || !kvm) {
> +	if (zdev->kzdev || zdev->gisa != 0) {
>  		mutex_unlock(&zdev->kzdev_lock);
>  		return -EINVAL;
>  	}

[...]
