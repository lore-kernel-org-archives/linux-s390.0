Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A64936C582;
	Wed,  6 May 2026 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073944; cv=none; b=JxD8/NFTrRMI42Ey4jOHbM1OtOZu44sgfokBCHuVqYSLark11cwk3aikzb7u9ntVDknGIbPe29gQAdHa9Wb+dYS8xzKU+YYFQOCicB+WeN7lHc5Cxff1Rujfb3GfbonpUHlfNZYj+CAY0VSLZCIgUsl3QedWA86WmsWZPmEAM9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073944; c=relaxed/simple;
	bh=CNijoIQNOAX276vHTDi1eWIR8WO6wlFlE7ubL38vzt0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B33xgKSdBlS5Urc374Xo9A5xHvnvoh1/LmKhx8QVCSQK2kwlp6X+9C+4n++V1acEblO3XhF1nZR4GlRVxmjTMANp6bq5BraO7lB4PInbWZFdqkhPZihckwj7+Ra5D0HP39/TwHu8oAAIeaeslWdmVvMDieWfyt5Eg1zQmv/ke34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WrqO25ju; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WrqO25ju"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646C1nZg3351555;
	Wed, 6 May 2026 13:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZEdCJ6
	r2YD8Nb7FNVqw1vZvXAITQy6l4gn4aENcDiIc=; b=WrqO25juvzGaWW1NaxKqlt
	Oxbhe3OzSCenbbpllkcDxBg05/zBlBD2T99YHDc4WWeC3NrlGkYMTxe5hzWwBsy5
	vuKvzTGN6MvLlRFVX5cNtnXSPPQa+7fHyghmIDByOjoZcdDHluc7lvgExYbuG8Fb
	cNQvhNRv5coTWvzji0R3+1Ang9VUAtgiWIefD62c5rqwzv6DzPi+/4QDNKMg+Xll
	r4UFMR6UpJua8FUrbMbSNO6DPMS+aWszw7OtRFyMK9m5MA8wm/VZEuxHb+uwq2SH
	wAWs5oa3lJiUAtmAkLB6D36QNnWj9xXSD0GT0hVUDkwhYQ3g47KMnJAh6yjB5ovw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6g6bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 13:25:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646DOYnU018704;
	Wed, 6 May 2026 13:25:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkjxbq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 13:25:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646DPZes15860002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 13:25:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2090620079;
	Wed,  6 May 2026 13:25:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F068720075;
	Wed,  6 May 2026 13:25:34 +0000 (GMT)
Received: from p-imbrenda (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  6 May 2026 13:25:34 +0000 (GMT)
Date: Wed, 6 May 2026 15:19:09 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Eric Farman <farman@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank
 <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] KVM: s390: Toggle operation exception for userspace
Message-ID: <20260506151909.60278083@p-imbrenda>
In-Reply-To: <20260505204521.1658704-1-farman@linux.ibm.com>
References: <20260505204521.1658704-1-farman@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fb4153 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=cZKMOd1B8ittd17GYGgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: oyrARxBoJGd217dudYshMtZsYwGT6MA1
X-Proofpoint-GUID: oyrARxBoJGd217dudYshMtZsYwGT6MA1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEyOSBTYWx0ZWRfXzGgFwMqcWyhY
 25eIl9XUkfcjpi0szU64alI+i3VHS4nK2hDthq264LxaBMdohL2697C1NGK0+7VwIKp0W/5Xy3N
 KmgqbTg/gMbuCRwuzXU2w/2N6X6vDOSBChu1+uW3nJ0CcflNvgmfndmZUKeOD50HmqXz0hNZKhi
 A1he99de2NjxgsZggtWCu+rKEon73osC/f4dL3Qcx7FCRCZlROZuvLMskkmB19LyalkGH4lv/Dd
 /9b1+bshz8glvZJE9vyu5OzfkCLCJ4zEqBVVCq5kV4uRs+r6wf2FY6F9oIVuaREjXOdKmMw3T1x
 yXwxFXalwAuzzhxtakj/kUx0zZ2eTAGdkQN5YjhsQLyDCw9y9u6rLKeWyg9jGajPCD+DlwDE3xo
 wi6n4gFseoiQEguovteU4uo1eq73vLl3q2xJWXqF8RR3NDcV2MtbHUsGsRHch/bZPGA/N3zwq1Z
 H4OQfHpUjWPhlDQPkKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060129

On Tue,  5 May 2026 22:45:21 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> The KVM_CAP_S390_USER_OPEREXEC capability allows operation exceptions
> to be forwarded to userspace. But the actual enablement at the hardware
> level occurs in kvm_arch_vcpu_postcreate(), and only if STFLE.74 or
> user_instr0 are enabled. The latter is associated with a separate
> capability (KVM_CAP_S390_USER_INSTR0), so the only way this happens
> for the USER_OPEREXEC capability is if STFLE.74 is enabled. KVM
> unconditionally enables this bit in kvm_arch_init_vm(), but the guest
> could disable it from the CPU model and thus ignore this capability.
> 
> Add USER_OPEREXEC to the check in kvm_arch_vcpu_postcreate(), such
> that either capability would enable this type of exception.
> KVM_CAP_S390_USER_INSTR0
> Fixes: 8e8678e740ec ("KVM: s390: Add capability that forwards
> operation exceptions") Signed-off-by: Eric Farman
> <farman@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

can you also extend the existing selftest for KVM_CAP_S390_USER_OPEREXEC
to also properly test with all combinations of
STFLE.74 / KVM_CAP_S390_USER_OPEREXEC / KVM_CAP_S390_USER_INSTR0

> ---
>  arch/s390/kvm/kvm-s390.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index e09960c2e6ed..a91a42174302 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3521,7 +3521,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>  		vcpu->arch.gmap = vcpu->kvm->arch.gmap;
>  		sca_add_vcpu(vcpu);
>  	}
> -	if (test_kvm_facility(vcpu->kvm, 74) || vcpu->kvm->arch.user_instr0)
> +	if (test_kvm_facility(vcpu->kvm, 74) || vcpu->kvm->arch.user_instr0 ||
> +	    vcpu->kvm->arch.user_operexec)
>  		vcpu->arch.sie_block->ictl |= ICTL_OPEREXC;
>  }
>  

