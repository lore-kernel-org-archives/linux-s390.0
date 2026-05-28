Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE55278156;
	Thu, 28 May 2026 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977319; cv=none; b=riu4k6sWnNdLHsb9xUsY8ubQP/WnIvKocpbKDzqBZciQzXVir9lM0rrSmwJTiSCM1H+SPAYNTVHdqTTT79h3mJ79WcfNhRzjdr6xEFi4as7AQNO546LW2XGwerIjYrIysc5+2gjHPpc+Y6K+eIgAw7ZCFsKnLtMZHH8VjQyJrjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977319; c=relaxed/simple;
	bh=md6trvY3vS9dxUZYF3oOtsRoTLA+AFDVxzIMaPzLv7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoJYlRMjPa4oIBdDQmRY/ZhLQviqoy0UdiEw+NwCLp5ta5ZAXxU5TC6V6L3ks7N9b12C+Iqo/HavdvGwkfEFpuDSgCuJRxegjrRo0HR4lvvYyYjveAkSIwadAXcgGQwRPrGT34f4u4KrhiN4Qr5Y985WoE+Zsaz3Z47hUg/wsZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LceWR4Li; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LceWR4Li"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SDJn163426678;
	Thu, 28 May 2026 14:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=3eExDAg2mYsYhxtjRFnVb1tUK6LwIe
	CTON/cbEZ263c=; b=LceWR4Li/uk/spy2kAVEYJvIrbeZQjmz7y0Ie5EUdVk9fJ
	vskySZLj5nfDYuIkpRa791UjJQiFH2O/kyEDptgiUf8c15d0IAg7agnfTiqVZGeB
	b7hzT7yWgg6VS8c4yJwt3TM9s+9unx/5Sg5Hc3qTwbBFYpCqrikbrqSO6+3sjSwa
	H1yQ74ubnO1wfVquDC/pTKWT3XoOohiw9BxtCRnmBJeNsIOZaPaCDffTftsmWHdf
	zNXJv6jnkZktFIx+ji4y9U5Ug6TUXtBD1VizA1X3dZmevwbIKsSSfxNEZvFsiqot
	c1RoIAGz8QZvqy6r+PoQTjjOv3XiV1bySKWrJPMQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884kcwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 14:08:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SDs8kU022619;
	Thu, 28 May 2026 14:08:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrb8dyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 14:08:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SE8VrZ30212520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 14:08:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47E0520043;
	Thu, 28 May 2026 14:08:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 202062004B;
	Thu, 28 May 2026 14:08:31 +0000 (GMT)
Received: from osiris (unknown [9.52.216.133])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 28 May 2026 14:08:31 +0000 (GMT)
Date: Thu, 28 May 2026 16:08:29 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: Re: [PATCH v1 4/7] KVM: s390: Fix fault-in code
Message-ID: <20260528140829.405668-G-seiden@linux.ibm.com>
References: <20260528114727.142178-1-imbrenda@linux.ibm.com>
 <20260528114727.142178-5-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528114727.142178-5-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a184c64 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=yyblsrMLF2mYRii7pEUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: cgXa2Gm0giiomvmSrANLPc1-uYIynKO4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE0MyBTYWx0ZWRfX0x79a0QaoxN7
 D2PYAZnGsixvh8f/pWt64s8p6z7rnftHmnkDpqXShfwwiUbWUK0QE27TNVs/E4szwQ2XllGzhAk
 rMZFUXiDnrx6nNN0di8PdaqDdrJ06ca1BsvcvojchzX6HMnELLPuYt4eRXG0NMCJd9a0K9Ia/tF
 y+zoN9inoLjmGI2uCZl0cFaNst38usyZd4rTHL5nCahanO0cl8a7E27pJF0bwVrDeyXEtWX71Pb
 qMMgd8xFj6OWDtRT5znwsDGK9wni2fJHO9LabuvKq6AhamCklwkcdT24WuXIovtmRFfx4M3jocd
 IBTWoSxIt5qc82Pira7sVUBZQvtodrruOposQVgf/eN+6Q+GLPTcaD8daB3hLbbEhEi95pHnU5h
 vrJHtCDOJS1OQwZugDSWpm3Fk3Zo7HnRd9WtK4oWLcdjQtwvR6hrQen1zR0zI3jA5P6b65g+7bF
 GsqjFZN8U+VeChxrC/g==
X-Proofpoint-GUID: cgXa2Gm0giiomvmSrANLPc1-uYIynKO4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280143

On Thu, May 28, 2026 at 01:47:24PM +0200, Claudio Imbrenda wrote:
> Fix the fault-in code so that it does not return success if a
> concurrent unmap event invalidated the fault-in process between the
> best-effort lockless check and the proper check with lock.
> 
> The new behaviour is to retry, like the best-effort lockless check
> already did.
> 
> This prevents the fault-in handler from returning success without
> having actually faulted in the requested page.
>

One nit below.

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>


> Fixes: e907ae530133 ("KVM: s390: Add helper functions for fault handling")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  arch/s390/kvm/faultin.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/s390/kvm/faultin.c b/arch/s390/kvm/faultin.c
> index ddf0ca71f374..3047dfdc8be4 100644
> --- a/arch/s390/kvm/faultin.c
> +++ b/arch/s390/kvm/faultin.c
> @@ -36,7 +36,7 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct kvm *kvm, struct guest_fa
>  	struct kvm_s390_mmu_cache *mc = NULL;
>  	struct kvm_memory_slot *slot;
>  	unsigned long inv_seq;
> -	int foll, rc = 0;
> +	int foll, rc = -EAGAIN;

This is not in reverse Christmas tree anymore. 
Split them into two lines.

...

	Steffen
