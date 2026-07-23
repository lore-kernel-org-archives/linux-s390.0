Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3423BD22F;
	Thu, 23 Jul 2026 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784809194; cv=none; b=b5Wiy9SWgPSSUwlsKeo2NRdVLS/hUtU1gKgjwYhlxVypjOhNNTPkZFCPMtPycWl+VFycEsogYH/KMo4eKkzEwxZzVZK+9a/Bpka0d7UtNe1JT7AGTlLw3nBqeTXi8aQdBKJFsSGvGqdVSA9RqrhXBjfxjYirIf9OYISh4aBSu/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784809194; c=relaxed/simple;
	bh=xppOIHZ2bEHcvtnvX17rwc2BmYIhc9mpD7fMCzMOnQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fW5Yb4zzEzduwyy/55K0OV+mqKCRZKwSJonF+OhAenNAG01cOWyqH79VHcbjRc+/xpk+zaky2wf7A7vOC8WZdI+FydAssNgaspEACdykpdj1gjJbXDQC02bkz6Wn8J448QGCa/7kVIRKPB0nt1uhVA1s9wTsIo5RxJ0cr+ZdP74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oTBvhx8K; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oTBvhx8K"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N9BgKb2580298;
	Thu, 23 Jul 2026 12:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UjF9S+
	safBc6v+xURjtQHmtgG5kxDQ056Zwtj/Orukk=; b=oTBvhx8K30ac/XuuCsv1eG
	NzcCOJaa0AxKVVMi403TE4b4fiK9IlU742q2aVmbgsm84uUsea+mTXDdQ9nPloQy
	29tGFJL0ylkoEPJHCbvNO1Zyy1vlZxdewWBy5oQeiREFE0KUUB19CKymst9/3yGx
	VIP7YMLBtR6P0V6hbIItHtoxYg+CXLgcakn217CSQKQItRJpe1xaQPg9UaiJ9WMq
	UEg5LqDxHuHugOqRkptBbyUbEEhwp2etE/8J6FSqB0ZoUPhbC4Cb5zTtnPj/LEr+
	KRiOtE6cXNL1BH5C3LU4MtkuuPpwfiyPflN4V8D/Kf09F6qQHp9c8G8s1p9MbY1Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abqecd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 12:19:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NCJcTD027330;
	Thu, 23 Jul 2026 12:19:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk427a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 12:19:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NCJkBK62849446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 12:19:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C81C42004B;
	Thu, 23 Jul 2026 12:19:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AB9520043;
	Thu, 23 Jul 2026 12:19:46 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 12:19:46 +0000 (GMT)
Message-ID: <185f906e-23c8-4eb0-8e45-9d91d23708f2@linux.ibm.com>
Date: Thu, 23 Jul 2026 14:19:46 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] KVM: s390: pci: Validate AIBV and AISB before
 pinning guest pages
To: Farhan Ali <alifm@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com
References: <20260722170621.1686-1-alifm@linux.ibm.com>
 <20260722170621.1686-7-alifm@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260722170621.1686-7-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEyMCBTYWx0ZWRfXyKGVXcKXRFIA
 rjSQWpknmytPFIxgaB2TjQVvwWGbiyXH8nwgTR6c7V60Ur5OZa/3DT2nrg5a6HJeC4ntGpW/ljA
 zZ+tHZhEfKabhkDCjaVXjsBNUbTjdyhGAylaavEFoWwZHRM+UML4RZ691KitTc8JmvG1AvfZ3Tb
 mMv/T+zhUdj+mVGAW2bFqQS9MD78n2GgRmde57GFzdfUStrFDJl4mIkrILld/KIprZu+6GztTWb
 ommhMY74APhHDxOnZ6NO693q8R9J7tpYcOtkFtzaXFxr4D2TMEdawBbq2fV+w+Q1EA2Wa+LqGya
 UBI+YR4Vtcyn58UBg8DHD9FS0xYBY1sFg6Wtj4Si0lHwT53bOvpR8yvjN6WQ0vyWp4ZjmfJuppC
 wu4naomh/rsUlCzsbIfsMtt5Au5AC28FO7wXTME1YpfqRTzoKWt38BuQk8ea2UbjtZIwagcZ0dg
 z95B9dXvaiNUE4ckbOA==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a6206e8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=TNCYBv8i-itO30bvNugA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XsB6Ee8uRHDh6eb385cAkXANJMnZbA3D
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEyMCBTYWx0ZWRfXyvcbHiPAFC96
 rHFbACt7sRUa3xg+ohKmRHUW/c/xyDG5MwTKrda0sjp29MO3e+Bc7wifdzmeyagEg+qGW2iXxWf
 B6N12B75GvYUiIuwmF2dWY19jxTjMr0=
X-Proofpoint-GUID: XsB6Ee8uRHDh6eb385cAkXANJMnZbA3D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230120



Am 22.07.26 um 19:06 schrieb Farhan Ali:
> The AIBV holds one bit per MSI-X vector for a given function. The size of
> the bit vector is derived from the NOI and the AIBVO. If the size of the
> AIBV exceeds a single page boundary, then reject the request as we cannot
> safely pin the guest AIBV.
> 
> Similarly reject the request if the AISB address is not 8-byte aligned as
> the architecture requires doubleword alignment for the summary bit address.
> Since the AISBO can address up to 64 bits, the size of the AISB can only be
> 8 bytes for the function. This also ensures the AISB doesn't exceed a
> single page boundary.
> 
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Apart from the + 1 this looks good.
With that calculation fixed:
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
>   arch/s390/kvm/pci.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index d76b2c5484ac..e55e75b81b51 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -241,7 +241,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>   				   bool assist)
>   {
>   	struct page *pages[1], *aibv_page, *aisb_page = NULL;
> -	unsigned int msi_vecs, idx;
> +	unsigned int msi_vecs, idx, size;
>   	struct zpci_gaite *gaite;
>   	unsigned long hva, bit;
>   	struct kvm *kvm;
> @@ -268,6 +268,14 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>   		return gisc;
>   
>   	/* Replace AIBV address */
> +	size = BITS_TO_LONGS(msi_vecs) * sizeof(unsigned long);
> +	size += (fib->fmt0.aibvo / 8) + 1;
> +	npages = DIV_ROUND_UP((fib->fmt0.aibv & ~PAGE_MASK) + size, PAGE_SIZE);
> +	if (npages > 1) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
>   	idx = srcu_read_lock(&kvm->srcu);
>   	hva = gfn_to_hva(kvm, gpa_to_gfn((gpa_t)fib->fmt0.aibv));
>   	npages = pin_user_pages_fast(hva, 1, FOLL_WRITE | FOLL_LONGTERM, pages);
> @@ -283,6 +291,12 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>   
>   	/* Pin the guest AISB if one was specified */
>   	if (fib->fmt0.sum == 1) {
> +
> +		if (fib->fmt0.aisb & 0x7) {
> +			rc = -EINVAL;
> +			goto unpin1;
> +		}
> +
>   		idx = srcu_read_lock(&kvm->srcu);
>   		hva = gfn_to_hva(kvm, gpa_to_gfn((gpa_t)fib->fmt0.aisb));
>   		npages = pin_user_pages_fast(hva, 1, FOLL_WRITE | FOLL_LONGTERM,

