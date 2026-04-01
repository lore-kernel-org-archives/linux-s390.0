Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17984070F9;
	Wed,  1 Apr 2026 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775048311; cv=none; b=niAB2zA2tIwrsV5CEAnOY7P2xr3AG1lPRW3giYfjcmWMZAVjtHKqUGhQOCqZWddi8wQE4fPaha9UNh7dejQ8tv+nMGhC8ktxcKSVp/64xAeeP2eYliHVN0w3BwMRmxG+bYMNjcYJVMQgX/RoDMUhHyY8hPyd5vXV6jrRX6w0FyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775048311; c=relaxed/simple;
	bh=hmT33dhSXjqZg8WLCqFHCS2S3/RoKIGqpGb0IRAM1Jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/Za8APkxvXFXjrNBRUeiTcmMxHcu+26o9nzLrLn6s9ikVdAMA6OjY1m+54uowfmmEyWPdA4DqvtD1Mu+s4gbMBv4T5siWuYaUaYxoL1/ybC2TZvlJTSiFRn/dtVE6LV4gtiHjNBxyn96rtoxpSiXFT+RpdzXFjAv9qfUtXcdZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VMdAILIU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VMdAILIU"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631C0Qd9395498;
	Wed, 1 Apr 2026 12:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0co5/2
	kcofKLBDAR/oqiVYY5fHP6YOuRWTpMSmNz4/Q=; b=VMdAILIUEBz2Cjb/DtTEj/
	zwxmeMtqJLQu8qV3nRg6QTJGl7pWKq792N4LNMmCNQE5UZE0BfFhv2oYRH3zIZbU
	Y6hj3Kzg8AUbSXNDGdkDvyTUkMf2Xy5bjqnXVjkHoAsIWPTzW+US35zCyv+Id8vh
	kzrJVppQ+lnYazr/a65SFbBYAh7Ingy0sX3BujqrFzBRZatut6Ey16U+VeU/XSzL
	uZ45j00V1ksAcheiX6pzmIPOtovVkWYihZJbUldYk34W7rirftoEoA6dZJltQWp5
	ESv4aTjr8aK+DvTABVS9b0U11iAXcuEXPEptP6ldFdr/oFQdWsG6J45HH9ViQ6Mw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g206m8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 12:58:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631CaU9n031552;
	Wed, 1 Apr 2026 12:58:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjweg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 12:58:25 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631CwLtR57278804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 12:58:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4930B2004D;
	Wed,  1 Apr 2026 12:58:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9381D20043;
	Wed,  1 Apr 2026 12:58:20 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 12:58:20 +0000 (GMT)
Message-ID: <91feaccb-9d28-4519-8e89-43f75e88b8bd@linux.ibm.com>
Date: Wed, 1 Apr 2026 14:58:19 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] KVM: s390: vsie: Disable some bits when in ESA
 mode
To: Eric Farman <farman@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20260401020915.1339228-1-farman@linux.ibm.com>
 <20260401020915.1339228-3-farman@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260401020915.1339228-3-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69cd1672 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=PpwtwfPK-DW6U5gnzfAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ubbeVcpf3vu4fA13ztoRjg7_4C4VVbEU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDExOCBTYWx0ZWRfX3g82YfMAZDkh
 PaxvMvxNQg0gb/Qgr/nw9121+hgg90BWJ3RyWuDCstWwF4jl3UZpkfV+rg62TbFL39J8sjwTVik
 J0cnLf8Pdi++UZCBa4W3c8mnazRpqa0MC1hbIf3sHApD0EklHM0Htg1P3eU8pMzjMw8AUN1mx0u
 XGr/qGFXCsHYJHdlGx3JSkMDPR8d5hP38L9WZbmxt0+WiovidFFCTRHtlt3CBpFp7JuCvpmIJ5i
 x3W+glYjNda9HBnXkOyLB8BXprAwBHDoeHAhLjBV5M8OwTF4xhVQichzSBP2tVipsjHYqKcuvdh
 1ecB834HmQnozlZCcGQ9ZbWg1vnet988fYzeKiHGq9DJR4ENW5DYRjXNx0iMIbz240ckyxo3cY/
 LOmDOmFmysPEFvUe1HpbmauDWWbaV+0beFEh//oDXnfhHm3aK5kR5aED8g99jFXFCcsbFxOIbqD
 dl9mHJtwplI0mYSSZGQ==
X-Proofpoint-GUID: ubbeVcpf3vu4fA13ztoRjg7_4C4VVbEU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010118



Am 01.04.26 um 04:09 schrieb Eric Farman:
> In the event that a nested guest is put in ESA mode,
> ensure that some bits are scrubbed from the shadow SCB.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
apart from one thing below

> ---
>   arch/s390/kvm/vsie.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 888370a02ef7..584fc7803632 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -387,6 +387,17 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>   	return 0;
>   }
>   
> +static void shadow_esa(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
> +{
> +	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
> +
> +	/* Ensure these bits are indeed turned off */
> +	scb_s->eca &= ~ECA_VX;
> +	scb_s->ecb &= ~ECB_GS;
> +	scb_s->ecb3 &= ~ECB3_RI;
> +	scb_s->ecd &= ~ECD_HOSTREGMGMT;

shouldnt we also remove the TE bit (transactional execution)?

> +}
> +
>   /* shadow (round up/down) the ibc to avoid validity icpt */
>   static void prepare_ibc(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>   {
> @@ -590,6 +601,9 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>   	scb_s->hpid = HPID_VSIE;
>   	scb_s->cpnc = scb_o->cpnc;
>   
> +	if (!(atomic_read(&scb_s->cpuflags) & CPUSTAT_ZARCH))
> +		shadow_esa(vcpu, vsie_page);
> +
>   	prepare_ibc(vcpu, vsie_page);
>   	rc = shadow_crycb(vcpu, vsie_page);
>   out:

