Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2860B470448;
	Thu, 23 Jul 2026 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820913; cv=none; b=YRCEBMbR1PljaA/PvmiNNpVXDHbD6l8sNg/SUyFR+HMoo4LdBX+n1u2UFDBqE8PXcjGya9/bqyvnuPwinl/rIXkrdeYPx0BTnlyv9Se0jONi5joxlgZL2FcNB5cveGn8BIlGA00/Gqyhr8ZjNb3AjpqTl8FebwnijW+svDflRqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820913; c=relaxed/simple;
	bh=xt/Lo9bhGiXWzACRTsGVWSE8AZkk8Z9BRiqKsCiahdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FK0jxzfG+syE7DnTNxCtOb39Hl6mbXTkyDyN4Q8pRDDhqA4vTdfaXX9nClnq9wLf3KKc3HhlVBm94724ooWlHYfOyeWPHsKTh3ztJtiQvqKwSd1Olr9Truo1soRxZfe9fn0nYGciPJ8RYkao5KwvKmIK3tNJWPs/8PnzaviGOb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aNfrQ0P1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aNfrQ0P1"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDC2Kr3015602;
	Thu, 23 Jul 2026 15:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7L8ew2
	B6qL+AVkX+cCk+SXwhhrNP/BdWf2ha0XYhvCc=; b=aNfrQ0P1GZcYDB0pXqeV3D
	HJ62YHee5jVyGhvJMpC0SrqlyLMMA3Nk9Ok6E4O4uhnor23irwE5TbivBtVooaez
	owI3k1w/P8ysbBn8odew0pBVfCX6T4nPh6pVXDrTsfu+adpa+cPBWYp0AAfyk0vA
	cmvasb90szJWj/18qQYcLQPgJFDyjzuDy1ABbAcOd/oLxM4SjxyxFSSCUKM1Jrzj
	N6AL0Xmtj6NLRoWDFs/smYCIzuAAPYc6djlYcNBqn3JgPuiGYubaXX/Aa3HlKvC1
	IhrQy1ir3xM+8p4C7EqG/9TQ9rF82/Eg3Groz/EoLhb0HdpbntqnOHMBd4hS9Bsg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kfrs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 15:35:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NFYbtD005289;
	Thu, 23 Jul 2026 15:35:04 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahcsmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 15:35:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NFZ23q25690718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 15:35:02 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84DC95805F;
	Thu, 23 Jul 2026 15:35:02 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A948058053;
	Thu, 23 Jul 2026 15:35:01 +0000 (GMT)
Received: from [9.61.177.4] (unknown [9.61.177.4])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 15:35:01 +0000 (GMT)
Message-ID: <9255bf01-ce5f-4430-8f44-e6c44a47e737@linux.ibm.com>
Date: Thu, 23 Jul 2026 11:35:01 -0400
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
Cc: borntraeger@linux.ibm.com, farman@linux.ibm.com
References: <20260722170621.1686-1-alifm@linux.ibm.com>
 <20260722170621.1686-7-alifm@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260722170621.1686-7-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a6234a8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=TNCYBv8i-itO30bvNugA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE0OSBTYWx0ZWRfXw6ZeK/Z+G5u9
 hYwTyE6qy7q2mayjOxNpRJP8+v5t9ibFjeZzwRQt9/3AuvRpsKgBF3otKoNCJ9VftYFZ/i6QnPg
 /FREJDX8NmLlKq5nmd6BntbnSaxqh8EFMqKkSAzOX1wWuLC2EYa/rX0Pk6XTStRrjW0OQsqIUuF
 /zJxveVc80c+5yVbszrOMUEtLUKwm5Sv0FkoBmjF5s6N2NN5PINaevlKMIAaG7FXZJllVa1GLAP
 VB9fTW7LNK/eqYTWOFwPz4QCPQeYSQm7hco9srF7lVPgayoInNHKrX/8MrDekKSBrWzn/M8ru2g
 EvvdGr48JShLCqVYHBlBfFUe2LiwNSz/01NTeApoRWFbvVJW0Hr+DwWgfLR4oh8vbyrSBOrsch5
 nhJqKk5dzvhCVBrB/QpzZTtT/T2Wkr+sqfeL6QgMIlFkZ5XtJ2fL7J/5woM10WK6O1qKNAAj0D0
 4n6A0204wma93dcuvrg==
X-Proofpoint-ORIG-GUID: m6RGMa7n0GmXxp_WB4ZTfkEEgT3fypiS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE0OSBTYWx0ZWRfXz/onDq3DSPQi
 XGu4HMS2wiKgpLBRbi3WLcraNb3tY51ObZAwEiV0NUT7Xl8ws9cIt8vyJ8KWgfSXXRAI993wfWH
 EM/jNoKpH7+DS7h+sqasDybDYc/ztlE=
X-Proofpoint-GUID: m6RGMa7n0GmXxp_WB4ZTfkEEgT3fypiS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230149

On 7/22/26 1:06 PM, Farhan Ali wrote:
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
> ---
>  arch/s390/kvm/pci.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index d76b2c5484ac..e55e75b81b51 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -241,7 +241,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>  				   bool assist)
>  {
>  	struct page *pages[1], *aibv_page, *aisb_page = NULL;
> -	unsigned int msi_vecs, idx;
> +	unsigned int msi_vecs, idx, size;
>  	struct zpci_gaite *gaite;
>  	unsigned long hva, bit;
>  	struct kvm *kvm;
> @@ -268,6 +268,14 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>  		return gisc;
>  
>  	/* Replace AIBV address */
> +	size = BITS_TO_LONGS(msi_vecs) * sizeof(unsigned long);
> +	size += (fib->fmt0.aibvo / 8) + 1;

Sashiko's comment here looks valid, remove the +1.

> +	npages = DIV_ROUND_UP((fib->fmt0.aibv & ~PAGE_MASK) + size, PAGE_SIZE);
> +	if (npages > 1) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +

Nit: 1-liner comment above that the AIBV cannot span a page?

>  	idx = srcu_read_lock(&kvm->srcu);
>  	hva = gfn_to_hva(kvm, gpa_to_gfn((gpa_t)fib->fmt0.aibv));
>  	npages = pin_user_pages_fast(hva, 1, FOLL_WRITE | FOLL_LONGTERM, pages);
> @@ -283,6 +291,12 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
>  
>  	/* Pin the guest AISB if one was specified */
>  	if (fib->fmt0.sum == 1) {
> +

Nit: ^ unnecessary newline?

> +		if (fib->fmt0.aisb & 0x7) {
> +			rc = -EINVAL;
> +			goto unpin1;
> +		}
> +

Nit: 1-liner comment above that AISB must be dword-aligned?

With the +1 issue fixed and regardless if you take the nit suggestions
or not:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

>  		idx = srcu_read_lock(&kvm->srcu);
>  		hva = gfn_to_hva(kvm, gpa_to_gfn((gpa_t)fib->fmt0.aisb));
>  		npages = pin_user_pages_fast(hva, 1, FOLL_WRITE | FOLL_LONGTERM,

