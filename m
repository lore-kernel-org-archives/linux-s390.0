Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF9F25A640;
	Thu, 24 Sep 2026 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254194; cv=none; b=F2KntmG45frjV3aq2t/GWDaAyigaS9zaKdqWa2+UQSfy63tMHHdYS3H4pIF4Ip50+yxXVOnITL+aoJECBwYeMcmzPVGIv/yVOXJJGLJUGiqCEYOZTgc5IjQcA0MC4lnBGjq8QC3l8x3vovAJCco5KLLhEtBtMBGCssgB8uZuG2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254194; c=relaxed/simple;
	bh=hm9lccC/5GkhUlUUy6yq/Qs/yfkw6XGykRq5Yxficfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VWSoaSV/LzIArxqslsFZwY8v9OSK5j79Ao1PwMly/+wIX8MO1DlThmzP3sdvKYM/1tJW1mNHtqPu/QW5IO1O5dcZW/976tUtJPqA7piwBLL9zAmvQ01x2Kwq89Kz+CFHR92Z3JiTXFU4embE77PwedhA+QqoZrlvW8O8chRW0Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AoW8OMf1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AoW8OMf1"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OC6NXw2028389;
	Thu, 24 Sep 2026 12:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=y4VrHI
	CWVqgB2RYnCshNPELH3cVu+IGtJ7vUa8SezFA=; b=AoW8OMf1FayLISkIo1QHwL
	cFAWQxDbGUYkC1NqWdYeqlY4FuRaYc/uoajCBS3sxHfwkNdRnqPsb4HVcx6bMszp
	I2K0zsbxwKo9WRUaiXC6qcg1bOB54BvRF1qSiK4wqXncgkvFPHNuNOKGud4oPk6e
	7DSs6etDZEsITYf9XcTNSBHKU7RcG9rZx0ddfuOZu9xlPZ/f3e03QCHi6t4UmeuE
	eyRib7cT2zxIUErJAMj5tIkmJfKw3Gzd5xS7MhG7mgEDj5vNWR8vYpA24mtBQXpQ
	0d9mmo3F6wnFMWpQmGmSjFnlXZRx2o0KoTDL/D0HC6UXfmzSEVmRWM5jncu0jPcA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1rfhh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 12:49:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OCHXkJ2008825;
	Thu, 24 Sep 2026 12:49:40 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2wp70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 12:49:40 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OCndfK1639064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 12:49:39 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 655EB58053;
	Thu, 24 Sep 2026 12:49:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E1AD58059;
	Thu, 24 Sep 2026 12:49:36 +0000 (GMT)
Received: from [9.61.84.233] (unknown [9.61.84.233])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 12:49:36 +0000 (GMT)
Message-ID: <0256f343-fda7-492a-b987-91a6aaa4a5b8@linux.ibm.com>
Date: Thu, 24 Sep 2026 08:47:43 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] KVM/vfio: Use file-based reference counting for
 KVM
To: Steffen Eiden <seiden@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini
 <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20260924-vfio-v3-0-4a294307797b@linux.ibm.com>
 <20260924-vfio-v3-4-4a294307797b@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260924-vfio-v3-4-4a294307797b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: VuPTRVlfVh_aR3aEiGtkbeufOzj_RQPh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1MiBTYWx0ZWRfXyyvwNlWlDoUG
 d+Q8HdEF4tZSQ1nTnu3N5mDsRmAR7oiYrb7dS6JcHqrB/IYg2W0vJZ7LDvr7bzQneTcg1mwxQva
 p0JFdXT5hyFMJ8BFBZ8/w+A315WlE1xk1dYf9Ht7cBxVhj7cLLbKTeUqKUCb924kNdHtcS/ZaIa
 dvwvYfAUYUPK17Qw5HXeW5v7fF9R+V5GkQD6M/dhErxOP/IHsDqQ6YINgw6zy9tPkA1rpkK5C8K
 pVsQneejI56XQmyIpKxVqT6U8hohS47GWklEs6aeuPWSyoCLxQdpEMtYtJ5twU5L8b88JojWtMY
 b9TYyz3i2ti5WGNFjL141CZCczVFnm7TcyYrL3RI2sxuQqpkR0Y0Y+nSW+ItgKzALXlPe+XaEv9
 SJLUMA3eeKBY7aFvRCakh1Sguy6XABDMtPgCYU82wLFvLTwdIj06P4St7yuFrI1/Us0l4R88EEu
 7VcT1PbLRSklYN8uNBw==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab51c65 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Ikd4Dj_1AAAA:8
 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=lFuzCTX72hcPMOq5MnUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1MiBTYWx0ZWRfXwHIPapv4zwhG
 ng3bF1CAkzA/I1Lu/OngQ3Te9USvuZiZS8nYC6esfs1WwEHVuGmm0FcMyfIlZloeZ2hMNjN72KX
 UAhBl6sY8OgX7rOiQJVC0FTuPcm1gm8=
X-Proofpoint-GUID: 46gO1ejmXxZHVzLRdZbUxADVJ2T8xNmk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240052

On 9/24/26 4:58 AM, Steffen Eiden wrote:
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
> simplifies the code and removes all remaining externally exported
> symbols for KVM which would appear twice for when a second concurrent
> KVM module is introduced.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host_s390.h |  2 +-
>   arch/s390/kvm/s390/pci.c              |  9 ++++--
>   arch/x86/include/asm/kvm_page_track.h |  8 ++---
>   arch/x86/kvm/mmu/page_track.c         | 22 +++++++++-----
>   drivers/s390/crypto/vfio_ap_ops.c     | 20 ++++++++----
>   drivers/vfio/group.c                  | 11 ++++++-
>   drivers/vfio/vfio.h                   | 12 ++++----
>   drivers/vfio/vfio_main.c              | 57 +++++++++++------------------------
>   include/linux/vfio.h                  |  5 ++-
>   virt/kvm/vfio.c                       | 13 +++++---
>   10 files changed, 85 insertions(+), 74 deletions(-)
> ...
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 940c0ff668be..556e643244f2 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -1822,17 +1822,27 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
>   
>   /**
>    * vfio_ap_mdev_set_kvm - sets all data for @matrix_mdev that are needed
> - * to manage AP resources for the guest whose state is represented by @kvm
> + * to manage AP resources for the guest whose state is represented by
> + * @kvm_file
>    *
>    * @matrix_mdev: a mediated matrix device
> - * @kvm: reference to KVM instance
> + * @kvm_file: the KVM VM file this vfio device is associated with
>    *
> - * Return: 0 if no other mediated matrix device has a reference to @kvm;
> + * Return: 0 if no other mediated matrix device has a reference to the VM;
>    * otherwise, returns an -EPERM.
>    */
>   static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
> -				struct kvm *kvm)
> +				struct file *kvm_file)
>   {
> +	struct kvm *kvm;
> +
> +	if (!kvm_file)
> +		return -ENOENT;
> +
> +	kvm = file_to_kvm_s390(kvm_file);
> +	if (!kvm)
> +		return -ENOENT;
> +
>   	if (kvm->arch.crypto.crycbd) {
>   		get_update_locks_for_kvm(kvm);
>   		if (kvm->arch.crypto.pqap_hook) {
> @@ -1841,7 +1851,6 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
>   		}
>   		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
>   
> -		kvm_get_kvm(kvm);
>   		matrix_mdev->kvm = kvm;
>   		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
>   		release_update_locks_for_kvm(kvm);
> @@ -1894,7 +1903,6 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
>   		matrix_mdev->kvm = NULL;
>   
>   		release_update_locks_for_kvm(kvm);
> -		kvm_put_kvm(kvm);
>   	}
>   }
>   
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
