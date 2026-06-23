Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9EC35E1CE;
	Tue, 23 Jun 2026 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782210847; cv=none; b=RaNSVcRBvpY80OkBcsCbI7Ee6xbIUbAV6VwRhL6uX+Crxf0LV5XPHdrbhZ0dOGJ6HmuJc+Gymh0sxKrlMD2KVTZCO64N5NZXP0C1mVr+NUNzhbVaK6BzvWQNIvJBiMO5lxO3UwKVkIvYnmF8Sx1YMQ8WbDSnjD36t0+x9jEKCCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782210847; c=relaxed/simple;
	bh=scXP73K7y04bSQ1q6WKW6VJ5Y5oA/a1sOUzORNnOzE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GoKn0i8HUjVhWAIKzaClp44rIfsK2sR+yO1FYMZAow0S7erq5hL99eGhH5sCs3sgHYd1YMYNJ56c02Oz2EPBz6SkFASPSqH5DYahKtw/MwMNkAFMvONn1G3GX2Bt/9hmp/PG5epHT3AlpNlL3R4r0AMQUailwTN+6Gh5Rrmo9po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jo3j9imD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jo3j9imD"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6mGvi1147913;
	Tue, 23 Jun 2026 10:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KDB1UW
	0dAi90WkM5zjPXvGE2Hzhne5hWbi+Z8GLSSSs=; b=Jo3j9imDi7g8FHwo6FkHva
	M2bFldTQjYt+jEsWXkjYXJCWNv7blnnBVqAr0JMZDXdp1zaXLKL1pQrTxl3BAep4
	Z3/AFG8+zSwnI+hCGWOViIrZ5lN1XAlMBRRvd3OURs2QyGvp7qC7sQLVkRESbjpX
	gK1ELtvEKcmXVfdA5u4LaF1FG/DWj2yGvL5uWpC46e9hI8HlPsO8aWcCaY/OagZ8
	iUFc4kEy2bXoq//D5cF/RLUduPc9X8mqEm4uA167m1MJlb5tBUdpXx4dJeEPUGU9
	qz+K5kPv/H6coyfFfY04aCoC5ZymiHu8NFeMHVsbuTRbuXgUPG59lxaMyZ/vq0AA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4dy3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 10:34:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NAJkPV018361;
	Tue, 23 Jun 2026 10:34:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qayqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 10:34:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NAY0kN47120660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 10:34:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BEC620043;
	Tue, 23 Jun 2026 10:34:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E51C620040;
	Tue, 23 Jun 2026 10:33:59 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 23 Jun 2026 10:33:59 +0000 (GMT)
Date: Tue, 23 Jun 2026 12:33:57 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, hca@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: Re: [PATCH v5 9/9] KVM: s390: Return failure in case of failure in
 kvm_s390_set_cmma_bits()
Message-ID: <20260623123357.677d98c5@p-imbrenda>
In-Reply-To: <117d0a80-345f-43d0-9b8d-b86c12eafc05@de.ibm.com>
References: <20260622160739.202044-1-imbrenda@linux.ibm.com>
	<20260622160739.202044-10-imbrenda@linux.ibm.com>
	<117d0a80-345f-43d0-9b8d-b86c12eafc05@de.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA4MyBTYWx0ZWRfXy0FwTEWiGzSm
 fFrCsAC3iMuwkNty7Dfwfeoiokzcwy9u6o+nNSSKBmKPVp2/AbcZpQp2p8NQPhwSiVJPrO0vVKt
 UXmJcTmEh8UIYZBD7PWJGOoHoboRe/o=
X-Proofpoint-ORIG-GUID: 6D-pDM_-2Ri_ygu7mzSBvA5XS8Rok-rp
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3a611c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=pHR4aYmbZQNmLHITC4QA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA4MyBTYWx0ZWRfX46n6no9cR4iB
 ItVYjJIMoLnCXIyKoQFl6NulJMagNHrEtPG0IIjNQppz64Q6zBUL7nVXqPq/qL7l4o/Jucpwpro
 LtfQGIqhqQYLjFhlPIa8DkNuKJcovKcI42/IJ89AFrWY6GBNu9j+90gqmKgwP385ig554eWl95m
 HVQ8y6cibuZubBeGulPLqz3RXIET7nRCFH0v+0cWMr/CQlosRe8oaLqfp046jCSAlfrmsM3MGlf
 ZfhyyAmRP2ihQYJYJfLE8cB5nnmcUly/W6pUQEhq9Ff3wQ1JtrzgntUCWi9Fe9wLC0hQ/S8SvMv
 uC0FjffbxEz99BrG23mKmucu7nMTWlhpWGsdUHcMCH47UHaq72pwtaTmg1yxZq87WlDmGdW4aUh
 m6r3TQ6YuruxRIBK73qeZIqlkBavSzkikupYhZF1r6Y2Uo9uUoOpmL2BeYJHmiy2/gp70W8tZXU
 r9/tLv1JxPEobpygLPg==
X-Proofpoint-GUID: 6D-pDM_-2Ri_ygu7mzSBvA5XS8Rok-rp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230083

On Tue, 23 Jun 2026 11:30:24 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Am 22.06.26 um 18:07 schrieb Claudio Imbrenda:
> > If the allocation of the bits array failed, kvm_s390_set_cmma_bits()
> > would return 0 instead of an error code.
> > 
> > Rework the function to use the __free() macros and thus simplify the
> > code flow; when the above mentioned allocation fails, simply return
> > -ENOMEM.
> > 
> > Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > ---
> >   arch/s390/kvm/kvm-s390.c | 18 +++++++-----------
> >   1 file changed, 7 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> > index cdd8b41d24ed..27d6004132d2 100644
> > --- a/arch/s390/kvm/kvm-s390.c
> > +++ b/arch/s390/kvm/kvm-s390.c
> > @@ -2282,8 +2282,8 @@ static int kvm_s390_get_cmma_bits(struct kvm *kvm,
> >   static int kvm_s390_set_cmma_bits(struct kvm *kvm,
> >   				  const struct kvm_s390_cmma_log *args)
> >   {
> > -	struct kvm_s390_mmu_cache *mc;
> > -	u8 *bits = NULL;
> > +	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
> > +	u8 *bits __free(kvfree) = NULL;  
> 
> why kvfree and not vfree?

because vfree does not exist as cleanup macro: __free(vfree) would not
compile

adding vfree would be outside the scope of this patch

> 
> >   	int r = 0;
> >   
> >   	if (!kvm->arch.use_cmma)
> > @@ -2303,18 +2303,16 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
> >   		return -ENOMEM;
> >   	bits = vmalloc(array_size(sizeof(*bits), args->count));
> >   	if (!bits)
> > -		goto out;
> > +		return -ENOMEM;
> >   
> >   	r = copy_from_user(bits, (void __user *)args->values, args->count);
> > -	if (r) {
> > -		r = -EFAULT;
> > -		goto out;
> > -	}
> > +	if (r)
> > +		return -EFAULT;
> >   
> >   	do {
> >   		r = kvm_s390_mmu_cache_topup(mc);
> >   		if (r)
> > -			break;
> > +			return r;
> >   		scoped_guard(read_lock, &kvm->mmu_lock) {
> >   			r = dat_set_cmma_bits(mc, kvm->arch.gmap->asce, args->start_gfn,
> >   					      args->count, args->mask, bits);
> > @@ -2322,9 +2320,7 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
> >   	} while (r == -ENOMEM);
> >   
> >   	set_bit(GMAP_FLAG_USES_CMM, &kvm->arch.gmap->flags);
> > -out:
> > -	kvm_s390_free_mmu_cache(mc);
> > -	vfree(bits);
> > +
> >   	return r;
> >   }
> >     
> 

