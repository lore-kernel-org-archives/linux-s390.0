Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4403090D7;
	Wed, 18 Mar 2026 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849123; cv=none; b=IK7che5oxH5puPL0+QVYfxj7hnccpUQIvnc1+s3ZLlMRax7qErot25mXCRfMto/wtMTbzLO9XcNV3G8fN8lo+5NBp4kZYxOx6AkQ3AgwPAN0NH0dA3EKD6TvT5POURpW56zroaJ2+1VyWxJqUUM1vBo5SJKpFE0eRpizg1TdfEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849123; c=relaxed/simple;
	bh=owI70S1LGUsfBUDQ6MfwNmdqUFCKIzOdqqU5HCKkzxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eX3ijhN1uEgYPbs7u0seVqHTU1iIqIGSczY2tI5K366wXpFA71azB2an3sUhRJ/0oQVpzY4/WLtpuOk2B0Lac90+RRTtAG43CFh1RO0vLWenNT0FNCOcLsfcWWw5QlxoGxR/2Y0+Gexm9sDFSgh6Hf6yVbkolT8vAh+gIcIeTE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B+en836W; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B+en836W"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IBxsit1711869;
	Wed, 18 Mar 2026 15:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=t/i2rM
	rtwYM8VRwV0oACeJBuipfZSagOj23FBgyTFlA=; b=B+en836WJnbPIZOL2opjUi
	oYbk1f8NKpNjSYxNyIgb7FQgC+bMSUoIAVfAIQUG5/PymhzwjzJ1/pSueUk5qWM2
	3RqTMbW3OdG13WaqgzS8h9q2WfpnPw6GGnUxb2NGz0DV0VU/ZF/vDbSW6p0TFZ5R
	h2LoU5MaRAUUbJFQ3Z+QeAY4gjKaxjKZtXpnrXbPGmJSOICNML+eJ0EtpRvVnh3W
	pJJ86TszlTHjyg2ySUnHUkX0lz2pul0i64GCtPFr/qXJHjDPoYquMRtuHTUb7fh7
	I8GoL0i+YkewZJLnGW+O+u/tfTFwdTW/y1IVsS2Lv8Cbgj4oMqqkd/4HSuX9F89A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64tvve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 15:51:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62IEjvxI032448;
	Wed, 18 Mar 2026 15:51:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jxfmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 15:51:57 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62IFpsDU42729768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 15:51:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C24B20043;
	Wed, 18 Mar 2026 15:51:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A65520040;
	Wed, 18 Mar 2026 15:51:54 +0000 (GMT)
Received: from p-imbrenda (unknown [9.52.223.175])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 18 Mar 2026 15:51:53 +0000 (GMT)
Date: Wed, 18 Mar 2026 16:51:51 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        akrowiak@linux.ibm.com
Subject: Re: [RFC 10/10] KVM: s390: Cleanup kvm_s390_store_status_unloaded
Message-ID: <20260318165151.19e0aff8@p-imbrenda>
In-Reply-To: <20260316180310.17765-11-frankja@linux.ibm.com>
References: <20260316180310.17765-1-frankja@linux.ibm.com>
	<20260316180310.17765-11-frankja@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 0bXRT_g3BStRudUkf-EfGv22H_AnRUwg
X-Proofpoint-GUID: 0bXRT_g3BStRudUkf-EfGv22H_AnRUwg
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69baca1e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=DqrMr1mMpynh7L77FOMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDEzNCBTYWx0ZWRfX7+uUbrAeOmKy
 Qb4eXhE8NpH4x195DgdmMWyBXj0R1DpmGfrf93DHZPSII9V4hOIcTP0r4+P1LLRIgVsKG28J4Bs
 AITcAKv9CIe9WcVl1/em4A0I3jKIwLbcmyowgCp1CnVnJipHF6/DsBjlb/g52b2yv8e+oJqIcqA
 CtASyDYCKETpEM5XhYE1kgHOUQtFh1runzkBSf7XXx89Vfssrzmb+z/jGZsnl0LBlb0y9S7PQQ2
 sfMOxThA+ZZ1uOf2qMah6+3ahCT/3BiXOzOCWHGjqzX1YTgHQzT/c508mwCG/r50aW2iRxFmBes
 boqk1QEyuXNmTWVf9fcDdkEE6+9sl8qrjB97lPiW9FRUccMj2W+a+wDF5ToOEbWvEe9Cl3I9UO1
 HTd7Q5R4vFnzGw40yRIQcaDcNgnJqXd/ooz9FkqO8HLUDPow2KMPw+KHHd2mWXjI5JeBNND+gF0
 kFsHfMSOwhfQmnQsv/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180134

On Mon, 16 Mar 2026 16:23:57 +0000
Janosch Frank <frankja@linux.ibm.com> wrote:

> Fixup comments, use gpa_t and replace magic constants.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 24 ++++++++++++++++--------
>  arch/s390/kvm/kvm-s390.h |  4 ++--
>  2 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 1668580008c6..c76f83b38d27 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -4993,11 +4993,12 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  
>  /*
>   * store status at address
> - * we use have two special cases:
> - * KVM_S390_STORE_STATUS_NOADDR: -> 0x1200 on 64 bit
> - * KVM_S390_STORE_STATUS_PREFIXED: -> prefix
> + *
> + * We have two special cases:
> + * - KVM_S390_STORE_STATUS_NOADDR: -> 0x1200 on 64 bit
> + * - KVM_S390_STORE_STATUS_PREFIXED: -> prefix
>   */

since you're touching this comment block, make it proper kerneldoc,
describing parameters, return value, etc

the rest of the patch is good

> -int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long gpa)
> +int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, gpa_t gpa)
>  {
>  	unsigned char archmode = 1;
>  	freg_t fprs[NUM_FPRS];
> @@ -5007,15 +5008,22 @@ int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long gpa)
>  
>  	px = kvm_s390_get_prefix(vcpu);
>  	if (gpa == KVM_S390_STORE_STATUS_NOADDR) {
> -		if (write_guest_abs(vcpu, 163, &archmode, 1))
> +		if (write_guest_abs(vcpu, __LC_AR_MODE_ID, &archmode, 1))
>  			return -EFAULT;
>  		gpa = 0;
>  	} else if (gpa == KVM_S390_STORE_STATUS_PREFIXED) {
> -		if (write_guest_real(vcpu, 163, &archmode, 1))
> +		if (write_guest_real(vcpu, __LC_AR_MODE_ID, &archmode, 1))
>  			return -EFAULT;
>  		gpa = px;
> -	} else
> +	} else {
> +		/*
> +		 * Store status at address does NOT store vrs and arch
> +		 * indication. Since we add __LC_FPREGS_SAVE_AREA to
> +		 * the address when writing, we need to subtract it
> +		 * here.
> +		 */
>  		gpa -= __LC_FPREGS_SAVE_AREA;
> +	}
>  
>  	/* manually convert vector registers if necessary */
>  	if (cpu_has_vx()) {
> @@ -5049,7 +5057,7 @@ int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long gpa)
>  	return rc ? -EFAULT : 0;
>  }
>  
> -int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr)
> +int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, gpa_t addr)
>  {
>  	/*
>  	 * The guest FPRS and ACRS are in the host FPRS/ACRS due to the lazy
> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
> index 1ffaec723a30..9cfc3caee334 100644
> --- a/arch/s390/kvm/kvm-s390.h
> +++ b/arch/s390/kvm/kvm-s390.h
> @@ -450,8 +450,8 @@ int kvm_s390_handle_sigp_pei(struct kvm_vcpu *vcpu);
>  
>  /* implemented in kvm-s390.c */
>  int kvm_s390_try_set_tod_clock(struct kvm *kvm, const struct kvm_s390_vm_tod_clock *gtod);
> -int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long addr);
> -int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr);
> +int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, gpa_t addr);
> +int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, gpa_t addr);
>  int kvm_s390_vcpu_start(struct kvm_vcpu *vcpu);
>  int kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu);
>  void kvm_s390_vcpu_block(struct kvm_vcpu *vcpu);

