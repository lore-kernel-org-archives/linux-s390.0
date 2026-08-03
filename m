Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5182D40F758;
	Mon,  3 Aug 2026 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768642; cv=none; b=Tfmywqha+PV/bqiRm26Rzf3fhbf2p4oPqChIyA2Z3H7GRQumsj9D18aC070c2mC4sCuOkdALh4m9ZqLZvCGCqchNhdM5JN9PYTnTYGXXksZHd1PHkLVF8dKzj6FRW3Bk3BHGT9SVos4wyLrT+qmgffM2sSSQODPOaHKapNuV1rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768642; c=relaxed/simple;
	bh=LhbFtZeSRM/lHmBbsxsnaAvH6bwwiYZ9owqxg7r9B+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJ0SsKWvRiCNhOnQ+aQOd9JVwaK1Ka3lnXgOscQZiZTJgSJmYNsU1r88ZWpBmiZPJ6/4RV2aUkv3TdQ0+IizVtzE2SRB6nqLu+G3BVHq2doMCgcJtJ2tByvIsHQZpgREm6Abkk1MWnKnoaFSjqMg862icvPbdYexXt3+i9WjYdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GuXeFDgg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GuXeFDgg"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHvaj2202069;
	Mon, 3 Aug 2026 14:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=i0Czew
	ef9AlyuQ8G/s3F8zF5LqpGZIH4VjBM859COA8=; b=GuXeFDggF6fpcLxLC0XANK
	3thagKoq6SNTxWuKLNtqWHEO+i4Hz02evR9RvRPsX4SWp1ux9zVsrfwVD1jlC/F3
	7GMw0NtRJfsVgq0RqlA9wPVUxWSLJQw/lhekfPkyb1AhDKOvt2Ku72Hpy0i1gQf4
	jFVPsR4h2RXn8lNejfmGfkp5lYcm16LfjGrS+Vn+wDGtenFlKdWE6qXGQLeQPMOm
	sJRjtHJvvxNSAdifIfPOPT3wEPH4T6ELKDzyhqeRREn98o0ZADkh/jouiHc1ZBZS
	RyzV7s3Xo5W3xlJEpKN/u0OPrCyNmjfbe5FwHWKVU65igcm1bRQ7I5XSZhAmTe+g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hhaq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 14:50:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673EfQsS032514;
	Mon, 3 Aug 2026 14:50:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qe12u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 14:50:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673EoVj833882620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 14:50:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D37C20043;
	Mon,  3 Aug 2026 14:50:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08DA920040;
	Mon,  3 Aug 2026 14:50:31 +0000 (GMT)
Received: from [9.224.88.46] (unknown [9.224.88.46])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 14:50:30 +0000 (GMT)
Message-ID: <8209fdba-9947-42e2-b124-81adf3419f15@linux.ibm.com>
Date: Mon, 3 Aug 2026 16:50:30 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/13] KVM: s390: ucontrol: Fix sca_clear_ext_call()
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
 <20260803124040.126471-6-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260803124040.126471-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEzMyBTYWx0ZWRfX1f62FE0C8eB6
 SKbD7sI9rGOe3wuhhRrWPrFIBiaH7agCaI1Qa4IrNEsKs+/qeP88QTv677Yb/gIWfGwjhIE7rdr
 7Dn5/4ioE37IN/gNTnGabf0I7EKXIg8=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a70aabe cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=pRtseFs1avcj8GDnxtYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEzMyBTYWx0ZWRfXwpTCdWz/QKz8
 wtCYylpL9onVlt4LBghkn11pgICfwTrUtlp02MPYL8MXPojDolA3TbF+2D0yfRzrtYRNrwMCeVa
 vsZUMkz69yJip39aC1p5VxOrRtNv+85K5xl0zXq+inkkkRyDLPspZcWoulceGCTtPHQw7FCr3GT
 xTfakclMQdnSzoHiBQ/VTZUZ1ZUeT67n+WtE9VHCs87b/89poPt3ckviczyow60DSPxeb4VJKcx
 xPlSDdtYwNBc9leSXdAlJ78wVcM5lCaXu9hIeKl0a+1+Iktc4PPIOeHqVlOSuYypwrBlAQav/L3
 S7TSTDNLuayZB4Xy89OXQqL3GquxzUp6+icMd5zjOwjDn6VKYvtPp0MofSls3U4csouYuHqlXUY
 XsUF5KpK6nNk+D61iKuGXvVR2I3qrb2ZeoKi/0e4fAzWIkbRccQYMTpiAqd+aPmOxSLvaPlwoLv
 caHEXYrbzxYceDxnYWw==
X-Proofpoint-ORIG-GUID: DvgCWMViXtaWT-5cuC8Y6zPltZe_nfio
X-Proofpoint-GUID: DvgCWMViXtaWT-5cuC8Y6zPltZe_nfio
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030133

On 8/3/26 14:40, Claudio Imbrenda wrote:
> When cleaning up a UCONTROL VM, sca_clear_ext_call() will touch memory
> outside of the allocated ESCA block, and UCONTROL VMs don't even use
> ESCA.
> 
> Fix by not touching ESCA for UCONTROL VMs, and fence the
> KVM_S390_INTERRUPT ioctl altogether. Add extra checks in
> sca_ext_call_pending() and sca_inject_ext_call() to make sure UCONTROL
> VMs won't touch ESCA.
> 
> Fencing does not cause regressions with userspace, since UCONTROL VMs
> never used KVM_S390_INTERRUPT ioctls.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Fixes: 7d43bafcff17 ("KVM: s390: Make provisions for ESCA utilization")
> ---
>   arch/s390/kvm/interrupt.c | 19 ++++++++++++++-----
>   arch/s390/kvm/kvm-s390.c  |  5 +++++
>   2 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 2acdff130fa6..6b3f97a7513b 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -45,13 +45,16 @@ static struct kvm_s390_gib *gib;
>   static int sca_ext_call_pending(struct kvm_vcpu *vcpu, int *src_id)
>   {
>   	struct esca_block *sca = vcpu->kvm->arch.sca;
> -	union esca_sigp_ctrl sigp_ctrl = sca->cpu[vcpu->vcpu_id].sigp_ctrl;
> +	union esca_sigp_ctrl sigp_ctrl;
>   
>   	if (!kvm_s390_test_cpuflags(vcpu, CPUSTAT_ECALL_PEND))
>   		return 0;
> +	if (kvm_is_ucontrol(vcpu->kvm))
> +		return 0;
>   
>   	BUG_ON(!kvm_s390_use_sca_entries());
>   
> +	sigp_ctrl = sca->cpu[vcpu->vcpu_id].sigp_ctrl;
>   	if (src_id)
>   		*src_id = sigp_ctrl.scn;
>   
> @@ -60,13 +63,16 @@ static int sca_ext_call_pending(struct kvm_vcpu *vcpu, int *src_id)
>   
>   static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
>   {
> -	struct esca_block *sca = vcpu->kvm->arch.sca;
> -	union esca_sigp_ctrl *sigp_ctrl = &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
>   	union esca_sigp_ctrl old_val, new_val = {.scn = src_id, .c = 1};
> +	struct esca_block *sca = vcpu->kvm->arch.sca;
> +	union esca_sigp_ctrl *sigp_ctrl;
>   	int expect, rc;
>   
>   	BUG_ON(!kvm_s390_use_sca_entries());
> +	if (kvm_is_ucontrol(vcpu->kvm))
> +		return -EINVAL;
>   
> +	sigp_ctrl = &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
>   	old_val = READ_ONCE(*sigp_ctrl);
>   	old_val.c = 0;
>   
> @@ -84,10 +90,13 @@ static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
>   static void sca_clear_ext_call(struct kvm_vcpu *vcpu)
>   {
>   	struct esca_block *sca = vcpu->kvm->arch.sca;
> -	union esca_sigp_ctrl *sigp_ctrl = &sca->cpu[vcpu->vcpu_id].sigp_ctrl;
> +	union esca_sigp_ctrl *sigp_ctrl;
>   
> -	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized)
> +	if (!kvm_s390_use_sca_entries() || !vcpu->arch.initialized || kvm_is_ucontrol(vcpu->kvm))
>   		return;
> +
> +	/* Initialize after the above check, to prevent going out of bounds */
> +	sigp_ctrl = &sca->cpu[vcpu->vcpu_id].sigp_ctrl;

Not sure why you only add this here and not at the other two occurences.
But I don't think we need these comments at all.

Dereferencing things before a check is not a great idea in most cases. 
Especially if the check validates if the memory has been set up at all :)

>   	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_ECALL_PEND);
>   
>   	WRITE_ONCE(sigp_ctrl->value, 0);
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 5b2727d7dfd1..21574f57be72 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2934,6 +2934,9 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>   	case KVM_S390_INTERRUPT: {
>   		struct kvm_s390_interrupt s390int;
>   
> +		r = -EINVAL;
> +		if (kvm_is_ucontrol(kvm))
> +			break;
>   		r = -EFAULT;
>   		if (copy_from_user(&s390int, argp, sizeof(s390int)))
>   			break;
> @@ -5456,6 +5459,8 @@ long kvm_arch_vcpu_unlocked_ioctl(struct file *filp, unsigned int ioctl,
>   		struct kvm_s390_interrupt s390int;
>   		struct kvm_s390_irq s390irq = {};
>   
> +		if (kvm_is_ucontrol(vcpu->kvm))
> +			return -EINVAL;
>   		if (copy_from_user(&s390int, argp, sizeof(s390int)))
>   			return -EFAULT;
>   		if (s390int_to_s390irq(&s390int, &s390irq))

Do we need changes to the api documentation for this rc?
