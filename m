Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F733D9DBE;
	Wed, 18 Mar 2026 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773844023; cv=none; b=dcaF2U+A9pAVveiIqkEj/yMuRgG1nqXGsp/9ARk/mZpq3LrvaGkhUmi/jDKjLsfNt4Ad/2Cd6xjGQ1fi77MUTzwi1dOIqCprW9LjEotLWPoPz8u80tTca0KL8FX7OnvXFqUrBrPP5qiTvhMkVAszm3Ykr42bm+0ipn/UWI4gi44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773844023; c=relaxed/simple;
	bh=m2E4r0k6/WgWFY1WeQ5lU6aqcnZggUAHP1upDMKcQyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b7Q4oSztsrFoBQx57053Is8HYOg2+m9iT1mDpj3baeGIWOnVz9BfhU+9uGSH9rH6XW3pNwPs0PMiL7vQwrFlOLJhj8npNCRXTJL/O1sFT7GDBRm2qmEF7WIvpRW5JeA7i12SsQclW+ql7194oZeWhJQ7MiMczqiol9DvG/vRTpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mtr+x6qC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mtr+x6qC"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IC1L8C1189868;
	Wed, 18 Mar 2026 14:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2tJd71
	YGhT38aTxuzqfd/Bw3KrsDY1+rznP/l1w21Sc=; b=mtr+x6qCnFEj3NwzAqTmgD
	wUtyDUWsddIdH5jG4ERZuNYZTTBO6wv0e5GOwOgmnhBmfP8rkUy1oaJqXjvM4tUS
	s5EoP00I15gqYVqiSbMcrKuh8MVtiC6nKuNycJNtUHRrUamdVV+hsOpOiXMHSL+o
	vYmXSgdV5JTh8B3p7ssfv/+JDFCXstVbaXAdB4rYj9AqHQ9AScRU/Rvir/aetQLc
	kHTvQBXdNFKfKcwMqw7TJIHvJeRH/dImNu+y23YYNmwDmyJtTdewNLny5t+nMt2/
	jbqK6zBONVf9T9AxHBj+zalXVncJ39DjFtBrc2xsqTkUt1hBXut+IE5RwXnrURqw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfmnw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 14:27:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62IDtjxR015655;
	Wed, 18 Mar 2026 14:26:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0neb72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 14:26:59 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62IEQteB62718334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 14:26:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C848520043;
	Wed, 18 Mar 2026 14:26:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AF3A20040;
	Wed, 18 Mar 2026 14:26:55 +0000 (GMT)
Received: from p-imbrenda (unknown [9.52.223.175])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 18 Mar 2026 14:26:55 +0000 (GMT)
Date: Wed, 18 Mar 2026 15:26:54 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        akrowiak@linux.ibm.com
Subject: Re: [RFC 03/10] KVM: s390: Convert shifts to gpa_to_gfn()
Message-ID: <20260318152654.17eb793d@p-imbrenda>
In-Reply-To: <20260316180310.17765-4-frankja@linux.ibm.com>
References: <20260316180310.17765-1-frankja@linux.ibm.com>
	<20260316180310.17765-4-frankja@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UIV-g_DJcMBxGpC-JxjN5h8cVsLxirBq
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69bab634 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=UlWm3JR3YRF3BLp4OckA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDEyMSBTYWx0ZWRfX72jYYo+md1gP
 sZrrFrNwuS41fdgs0AZ+rcnsUemXDWeMnXwk8/IQ7huufQ0gtbe5ZovMeeK95KCwZvXxvqARABk
 JvwPgDOAc9ApdGvEOJwpfO7df//myVCsRJQITEH5A9Oc+kuvCFNKykiiFA1RkFGKW7yGtbvQNmz
 SP5bSnx887BH87cbCqx7ZRi37GEygHpC73TLTrmDMQh0RJN+3bbgBOAJzAQjIENEYAs/N1E7N2C
 iYzG5P0ANjrVGlTz1Grb5gf+GyKBKa/PT6xCU7HJPqw+5jjWyrY8DIHNe/aAkKJsKDZB2dOD/dn
 U4Oh62xHBsY2iCu1HxdT+T2KZe/mogy13Bgip3jgb26C0hq+FxO+BKmC7SHjYR4sdoHooLobtV1
 ahgwbWAT2TXuyYrpPkKQCy66XWLl9Nv1nv44e/1EitozStqygOIRuw0cOWOAjUbnSVFKsyarnmQ
 1ql/ZZVDK1G4Rcu8Exg==
X-Proofpoint-GUID: UIV-g_DJcMBxGpC-JxjN5h8cVsLxirBq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180121

On Mon, 16 Mar 2026 16:23:50 +0000
Janosch Frank <frankja@linux.ibm.com> wrote:

> Not only do we get rid of the ugly shift but we have more chances to
> do static analysis type checking since gpa_to_gfn() returns gfn_t.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  arch/s390/kvm/interrupt.c | 4 ++--
>  arch/s390/kvm/priv.c      | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 03fb477c7527..1b771276415c 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2771,13 +2771,13 @@ static int adapter_indicators_set(struct kvm *kvm,
>  	bit = get_ind_bit(adapter_int->ind_addr,
>  			  adapter_int->ind_offset, adapter->swap);
>  	set_bit(bit, map);
> -	mark_page_dirty(kvm, adapter_int->ind_gaddr >> PAGE_SHIFT);
> +	mark_page_dirty(kvm, gpa_to_gfn(adapter_int->ind_gaddr));
>  	set_page_dirty_lock(ind_page);
>  	map = page_address(summary_page);
>  	bit = get_ind_bit(adapter_int->summary_addr,
>  			  adapter_int->summary_offset, adapter->swap);
>  	summary_set = test_and_set_bit(bit, map);
> -	mark_page_dirty(kvm, adapter_int->summary_gaddr >> PAGE_SHIFT);
> +	mark_page_dirty(kvm, gpa_to_gfn(adapter_int->summary_gaddr));
>  	set_page_dirty_lock(summary_page);
>  	srcu_read_unlock(&kvm->srcu, idx);
>  
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index a90fc0b4fd96..780186eb6037 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -1151,7 +1151,7 @@ static inline int __do_essa(struct kvm_vcpu *vcpu, const int orc)
>  	 */
>  
>  	kvm_s390_get_regs_rre(vcpu, &r1, &r2);
> -	gfn = vcpu->run->s.regs.gprs[r2] >> PAGE_SHIFT;
> +	gfn = gpa_to_gfn(vcpu->run->s.regs.gprs[r2]);
>  	entries = (vcpu->arch.sie_block->cbrlo & ~PAGE_MASK) >> 3;
>  
>  	nappended = dat_perform_essa(vcpu->arch.gmap->asce, gfn, orc, &state, &dirtied);

