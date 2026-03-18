Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D2733343B;
	Wed, 18 Mar 2026 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849800; cv=none; b=N3UBx3Uj+BFlWX4GDWG4lzDNLFS8Bct//da5ZkxXG9nDslwPcgA39ahsDT9/bKNkGALKUYOGA0pFGFs9BJM4Me1BTJaNceFxasLc5O9yxTfvKfrZ8vZ78J1khpi2d4JvLB4YdOSWW6Awt7Sg71HSaIncl1Qm/HQ8NoC6uYWDq7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849800; c=relaxed/simple;
	bh=lUHiTAKblWNnfQbNwTNI3iUjog2g8JiAHuC9HCtIub8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7qGLux7M7YyDE9WTvK1sa6DdFxh6BtP2FbMO8YS/YoDXbxbWFSS90Bzo5KQHXPBJUZsbJDnaTMbI+ksgsfcCPFnzdLZpw8QMe5aH6jaCvFYAbz0Zmd5AdDpH8To+mdH9MsWwUqCq32UAryTdUNBwL3AitayUCMIdmoOtsw3HpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AJYARrG1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AJYARrG1"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IE3VHq1394708;
	Wed, 18 Mar 2026 16:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XClIqW
	LXEtwwyhWPHxmg0un6jwf9COJ3cbdaLNv8B9E=; b=AJYARrG1FCLZnJKS6wWIX4
	vfSIX2n8CkbnI1VhA/4ri4QxnWItOj3umap5emR4eOcBfTYY+DB7TsID55dEiLu7
	yjRfrZKfZwOecExq0ly9+TVcYjuSuBeURoqO8CgAKDepEKH4y0PJTCCMTEqPVV4/
	QmGF3+dkb0WLPOtrr/rlsLECxHIm56uBdwOOo7AJB9rxmIlBtXlJn4XsBKXe7EaS
	oW7kxNjia6khj5qSmzaj5HgOrebSwnxiz+LioUiTmsF9Oes03i3lsFq3jTeDmC+X
	+AQ1opz/0uBx5jdGVP6Qmz0XGfJu+rvs9HBUdrF5z3FVFPdJB6Vyl66aKKcCwSDQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfn3r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 16:03:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62IDxVed028765;
	Wed, 18 Mar 2026 16:03:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgkenrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 16:03:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62IG32cT30146840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 16:03:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FE9C20043;
	Wed, 18 Mar 2026 16:03:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED42B20040;
	Wed, 18 Mar 2026 16:03:01 +0000 (GMT)
Received: from p-imbrenda (unknown [9.52.223.175])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 18 Mar 2026 16:03:01 +0000 (GMT)
Date: Wed, 18 Mar 2026 17:02:59 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        akrowiak@linux.ibm.com
Subject: Re: [RFC 08/10] KVM: s390: Use gpa_t in priv.c
Message-ID: <20260318170259.2cb92001@p-imbrenda>
In-Reply-To: <20260316180310.17765-9-frankja@linux.ibm.com>
References: <20260316180310.17765-1-frankja@linux.ibm.com>
	<20260316180310.17765-9-frankja@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: E4_K8DLyAqdutV8hyNY1FNz6Dy-dFNVx
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69baccbb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=YwzkiLcPDEtg9eQ2-J8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDEzNCBTYWx0ZWRfXxQ8hACkxUCja
 4sYYsHwaj7O+xfFxAmCQdA50nX8nJ3f4qo4vdYQnAI7KgT5pbqWjBehgHXJNzuc4WqLJBbofF9v
 5spYasp+IrIKxgS8C+e5g8/HBlKcUdhCWbxMWsJH/nYwNZDaG8LXoT8/c7RS+3ClfFE33kqC+sO
 5aW1cN75DGby3C1X3b+30XdThqOOjEEjbZmxbgI7iEQot1m1Yld4AkO11r+DpE8f0so8kT7U5P0
 ZA0x9/6NSRnyj8KekXP/pPbvs22vVaMJkQCH6r2CcaXsPbk4kp8claEqI8WuQlb0k8a1w6Du1Yp
 Kam7QivoJZtaQ+ldBbufvLp39SRPswGX+6oVomNM6mwtIb0zIc8o/6H58n1soDHHdCdaYjBmFzv
 bLPenS3IkBZZwL3Zvv98Kx3LqmbqGWlGRoRkSTwQvpjATiSLAREUtAGpaEs9CIJziGk8+ZCw8Cm
 m8y0cjtrrjUm8a3IEiQ==
X-Proofpoint-GUID: E4_K8DLyAqdutV8hyNY1FNz6Dy-dFNVx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180134

On Mon, 16 Mar 2026 16:23:55 +0000
Janosch Frank <frankja@linux.ibm.com> wrote:

> More unsigned long to gpa_t conversions.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/kvm/gaccess.h |  8 ++++++++
>  arch/s390/kvm/priv.c    | 27 ++++++++++++---------------
>  2 files changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
> index f23dc0729649..970d9020dc14 100644
> --- a/arch/s390/kvm/gaccess.h
> +++ b/arch/s390/kvm/gaccess.h
> @@ -89,6 +89,14 @@ static inline unsigned long kvm_s390_logical_to_effective(struct kvm_vcpu *vcpu,
>  	return _kvm_s390_logical_to_effective(&vcpu->arch.sie_block->gpsw, ga);
>  }
>  
> +static inline gpa_t kvm_s390_real_to_abs_effective(struct kvm_vcpu *vcpu,
> +						   unsigned long gra)

the name is confusing, it should be something more like
kvm_logical_to_abs, or kvm_logical_effective_to_abs

the rest of the patch is good

> +{
> +	gra = kvm_s390_logical_to_effective(vcpu, gra);
> +
> +	return kvm_s390_real_to_abs(vcpu, gra);
> +}
> +
>  static inline gpa_t lc_addr_from_offset(struct kvm_vcpu *vcpu, unsigned int off)
>  {
>  	gpa_t addr = kvm_s390_get_prefix(vcpu);
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index 780186eb6037..78d3338afdb2 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -256,9 +256,9 @@ static int try_handle_skey(struct kvm_vcpu *vcpu)
>  
>  static int handle_iske(struct kvm_vcpu *vcpu)
>  {
> -	unsigned long gaddr;
>  	int reg1, reg2;
>  	union skey key;
> +	gpa_t gpa;
>  	int rc;
>  
>  	vcpu->stat.instruction_iske++;
> @@ -271,12 +271,10 @@ static int handle_iske(struct kvm_vcpu *vcpu)
>  		return rc != -EAGAIN ? rc : 0;
>  
>  	kvm_s390_get_regs_rre(vcpu, &reg1, &reg2);
> +	gpa = kvm_s390_real_to_abs_effective(vcpu, vcpu->run->s.regs.gprs[reg2] & PAGE_MASK);
>  
> -	gaddr = vcpu->run->s.regs.gprs[reg2] & PAGE_MASK;
> -	gaddr = kvm_s390_logical_to_effective(vcpu, gaddr);
> -	gaddr = kvm_s390_real_to_abs(vcpu, gaddr);
>  	scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
> -		rc = dat_get_storage_key(vcpu->arch.gmap->asce, gpa_to_gfn(gaddr), &key);
> +		rc = dat_get_storage_key(vcpu->arch.gmap->asce, gpa_to_gfn(gpa), &key);
>  	if (rc > 0)
>  		return kvm_s390_inject_program_int(vcpu, rc);
>  	if (rc < 0)
> @@ -288,8 +286,8 @@ static int handle_iske(struct kvm_vcpu *vcpu)
>  
>  static int handle_rrbe(struct kvm_vcpu *vcpu)
>  {
> -	unsigned long gaddr;
>  	int reg1, reg2;
> +	gpa_t gpa;
>  	int rc;
>  
>  	vcpu->stat.instruction_rrbe++;
> @@ -302,12 +300,10 @@ static int handle_rrbe(struct kvm_vcpu *vcpu)
>  		return rc != -EAGAIN ? rc : 0;
>  
>  	kvm_s390_get_regs_rre(vcpu, &reg1, &reg2);
> +	gpa = kvm_s390_real_to_abs_effective(vcpu, vcpu->run->s.regs.gprs[reg2] & PAGE_MASK);
>  
> -	gaddr = vcpu->run->s.regs.gprs[reg2] & PAGE_MASK;
> -	gaddr = kvm_s390_logical_to_effective(vcpu, gaddr);
> -	gaddr = kvm_s390_real_to_abs(vcpu, gaddr);
>  	scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
> -		rc = dat_reset_reference_bit(vcpu->arch.gmap->asce, gpa_to_gfn(gaddr));
> +		rc = dat_reset_reference_bit(vcpu->arch.gmap->asce, gpa_to_gfn(gpa));
>  	if (rc > 0)
>  		return kvm_s390_inject_program_int(vcpu, rc);
>  	if (rc < 0)
> @@ -1142,8 +1138,8 @@ static inline int __do_essa(struct kvm_vcpu *vcpu, const int orc)
>  	int r1, r2, nappended, entries;
>  	union essa_state state;
>  	unsigned long *cbrlo;
> -	unsigned long gfn;
>  	bool dirtied;
> +	gpa_t gpa;
>  
>  	/*
>  	 * We don't need to set SD.FPF.SK to 1 here, because if we have a
> @@ -1151,10 +1147,11 @@ static inline int __do_essa(struct kvm_vcpu *vcpu, const int orc)
>  	 */
>  
>  	kvm_s390_get_regs_rre(vcpu, &r1, &r2);
> -	gfn = gpa_to_gfn(vcpu->run->s.regs.gprs[r2]);
> +	gpa = vcpu->run->s.regs.gprs[r2];
>  	entries = (vcpu->arch.sie_block->cbrlo & ~PAGE_MASK) >> 3;
>  
> -	nappended = dat_perform_essa(vcpu->arch.gmap->asce, gfn, orc, &state, &dirtied);
> +	nappended = dat_perform_essa(vcpu->arch.gmap->asce, gpa_to_gfn(gpa),
> +				     orc, &state, &dirtied);
>  	vcpu->run->s.regs.gprs[r1] = state.val;
>  	if (nappended < 0)
>  		return 0;
> @@ -1166,7 +1163,7 @@ static inline int __do_essa(struct kvm_vcpu *vcpu, const int orc)
>  	 */
>  	if (nappended > 0) {
>  		cbrlo = phys_to_virt(vcpu->arch.sie_block->cbrlo & PAGE_MASK);
> -		cbrlo[entries] = gfn << PAGE_SHIFT;
> +		cbrlo[entries] = gpa;
>  	}
>  
>  	if (dirtied)
> @@ -1447,10 +1444,10 @@ int kvm_s390_handle_eb(struct kvm_vcpu *vcpu)
>  static int handle_tprot(struct kvm_vcpu *vcpu)
>  {
>  	u64 address, operand2;
> -	unsigned long gpa;
>  	u8 access_key;
>  	bool writable;
>  	int ret, cc;
> +	gpa_t gpa;
>  	u8 ar;
>  
>  	vcpu->stat.instruction_tprot++;

