Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE82E1DE2CD;
	Fri,  7 Feb 2025 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738924207; cv=none; b=iCaB2RUEim80POtpHRIMP+9Z1c9TkKa0Nk1Fsfx8jSaWGMCb/L1bDx4Aa3XqsLbXNsFJWbTU8fDwmFBt3prYrrSZw87U3qVqo6a3ZmXiS3JnaZs6e6n7E3vsEwMTBnJPdaFvvCMPJ9etD6LWxvR6Pt7bwaiVltYtY+n8KaV+7yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738924207; c=relaxed/simple;
	bh=JpbQcaAa8JcQZWOzqHFtWGVskjPJYM2OOIEdEBr9QSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=P+1fa48j4yvKI8JDSdcUXSA+kRHFom0sLdTZTiqQ7c0I4c2xFOlUZg4VUYNpee9zZMTURX994XgmnQ0s8wProVow2ZDBzUnWbizkgHQ4UKpaQ96B+8K0v0WIZOvAiq9f06Uj1zi+NF3kuwFEXWgs9TB0NcRErIVqny8Cf73dH9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j1PAOVYj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j1PAOVYj"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51716oQQ010458;
	Fri, 7 Feb 2025 10:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6W0N8f
	QjXPiR8sVNB2nSeoDujwMgwlQ8qmGFGmH8wrc=; b=j1PAOVYjYmvoN4MsXtqrFe
	u7V/IQcO6W0sjjw/fjI6F1sxMxhIfLgsnaQz+O6FzRcRPIp/5Xdx7bgchX5r9hg8
	AB95LKPBoSpm5sri/dhZL+AZPlv7sQkou/HI4YhH3NSCyeQEJ8QL6BMbLh6oiPeS
	gycoJR8+XK6mu+PGQyfwXm7BJjJ0K6wU22/IZJKYz7zthvhIIovKuL4r0J6Vr3Rj
	3SnsdklT+T+LStXz/XOUM88jlNTRUac5miPcsUJyRB6u2FAfcRqAMcGViYk3N+XM
	sudQQ2+y8m5e0SjtCzanSJLHJkMy6NRsioQsYObkkWVVy9Xmj0eYdF/wvwi+hK2Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44mywtvrpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 10:29:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 517A7hDV016297;
	Fri, 7 Feb 2025 10:29:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44hwxsu9rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 10:29:38 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 517ATYMI44433798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Feb 2025 10:29:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3B2220085;
	Fri,  7 Feb 2025 10:29:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B46120084;
	Fri,  7 Feb 2025 10:29:34 +0000 (GMT)
Received: from [9.171.75.27] (unknown [9.171.75.27])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Feb 2025 10:29:34 +0000 (GMT)
Message-ID: <828a5848-518a-4049-b534-0ae45ca964b2@linux.ibm.com>
Date: Fri, 7 Feb 2025 11:29:23 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/31] KVM: s390: Switch to use hrtimer_setup()
To: Nam Cao <namcao@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>
References: <cover.1738746821.git.namcao@linutronix.de>
 <637865c62963fb8cddf6c4368ca12434988a8c27.1738746821.git.namcao@linutronix.de>
Content-Language: en-US
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <637865c62963fb8cddf6c4368ca12434988a8c27.1738746821.git.namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ld2vLwj5Mc7hMxxdUJFbzNTX1ZAazY_i
X-Proofpoint-ORIG-GUID: ld2vLwj5Mc7hMxxdUJFbzNTX1ZAazY_i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_05,2025-02-07_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 phishscore=0 mlxlogscore=876 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070080



Am 05.02.25 um 11:38 schrieb Nam Cao:
> hrtimer_setup() takes the callback function pointer as argument and
> initializes the timer completely.
> 
> Replace hrtimer_init() and the open coded initialization of
> hrtimer::function with the new setup mechanism.
> 
> Patch was created by using Coccinelle.
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   arch/s390/kvm/interrupt.c | 3 +--
>   arch/s390/kvm/kvm-s390.c  | 4 ++--
>   2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index d4f031e086fc..11a33fa21dfd 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -3171,8 +3171,7 @@ void kvm_s390_gisa_init(struct kvm *kvm)
>   	gi->alert.mask = 0;
>   	spin_lock_init(&gi->alert.ref_lock);
>   	gi->expires = 50 * 1000; /* 50 usec */
> -	hrtimer_init(&gi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> -	gi->timer.function = gisa_vcpu_kicker;
> +	hrtimer_setup(&gi->timer, gisa_vcpu_kicker, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>   	memset(gi->origin, 0, sizeof(struct kvm_s390_gisa));
>   	gi->origin->next_alert = (u32)virt_to_phys(gi->origin);
>   	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", gi->origin);
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index d8080c27d45b..a0ef902c7a3d 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3930,8 +3930,8 @@ static int kvm_s390_vcpu_setup(struct kvm_vcpu *vcpu)
>   		if (rc)
>   			return rc;
>   	}
> -	hrtimer_init(&vcpu->arch.ckc_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> -	vcpu->arch.ckc_timer.function = kvm_s390_idle_wakeup;
> +	hrtimer_setup(&vcpu->arch.ckc_timer, kvm_s390_idle_wakeup, CLOCK_MONOTONIC,
> +		      HRTIMER_MODE_REL);
>   
>   	vcpu->arch.sie_block->hpid = HPID_KVM;
>   

