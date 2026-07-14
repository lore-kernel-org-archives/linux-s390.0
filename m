Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE32A3BBFAE;
	Tue, 14 Jul 2026 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784033483; cv=none; b=YUkG71z3IOIsEk23i6p56ZGzQxQp8OeZiVqAu/Ncw3J0ojfulq+ypWGUjuOFNxgOTrQC9VgSfprMT0OndW7Um8kNir0RhHFNmq0n6drQW7aqUw0XBAP83EzpI350DAVCJ93A0hLxdE8AUpYMbq7LITaVoM9/TAOVd8y5y5VFiSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784033483; c=relaxed/simple;
	bh=2nsn939ZM3yfLCl8+uj2Kx370ojFLKuWfJIJKgs7cEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSvw/fNGUCbLDofQ7APdxBVZ6jMQLsBMUOExpXl8jfIOeYtJUgHeVwvLWkamO+xo8jnCr0uS0vBK25jcPnKIp/rJoDb5ts/BwAI6lyx+81CKfyGakQ+rXH5uBfEMMWZM38MpxXdQpqGNKfS48HityVgi8wol7B197p05hGwhjH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F+ZXEoH7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F+ZXEoH7"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBg05O1134148;
	Tue, 14 Jul 2026 12:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2RKo/P
	ZiVtpCjMK179Xy76bIqraxmnSPbG6iaAyx110=; b=F+ZXEoH747HO0YUfEahbqh
	rCp2z5bRObwtHqbXh7kOTK8uSObaXNhD3aqbNHY3cCjuXKS6Vc18PQEmv/wi0NjG
	JLXl5ya0kIb+gWxtVfalYSX9unMzxF7cX43UV7j95rNxJ0FWPnTSw4O/QSaFJay2
	zt9ioeSIzV0q6dfG+770oKdCPJaxFETFQYoJ2N0h+kdmKmCUUzmawzY6Z7ZAf2dL
	wbegc4nv4gqWfXNteXRuWRRh3cN276QeQ/VWmyDyCMdxs5YicffAdinXpkQTa1zR
	jKwd+xhmWQdm4II9YGMTM9NXzorGjwZu92RI7BzlQ8Te8QqrwuZ/VoRVpmHvWpxA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2a5psm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 12:51:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ECnZr9020061;
	Tue, 14 Jul 2026 12:51:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05q30v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 12:51:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ECpEGe49873368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 12:51:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04F1A2004B;
	Tue, 14 Jul 2026 12:51:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9791120040;
	Tue, 14 Jul 2026 12:51:13 +0000 (GMT)
Received: from [9.111.15.51] (unknown [9.111.15.51])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Jul 2026 12:51:13 +0000 (GMT)
Message-ID: <decfba21-36cd-479f-b351-8429086946d8@de.ibm.com>
Date: Tue, 14 Jul 2026 14:51:12 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] KVM: s390: Fix overclearing ESCA in case of error
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260713150857.269954-1-imbrenda@linux.ibm.com>
 <20260713150857.269954-7-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260713150857.269954-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzMiBTYWx0ZWRfXzg7zdQgtCd6Z
 kaKStHfnE6HU5I6xAchNyJkWGgB06OQt77tQEErXsVLp3w7xXuK9dw5abUkUXxMPckEN2j826gu
 82N7lj0mkNQqKBM4LVV5AfgEQunQ5PE=
X-Proofpoint-GUID: DS9qt-n_zxZH25K4dH3AjaGXWkJAXvAf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzMiBTYWx0ZWRfX3bYANHkmRrZs
 KxEHnImO9CmG2v/QKmYhpVMmiBgCKVGc0KFEqqs4a7t0IWuI6jSltksfr7ygde9jH19pwGx34Aq
 67H0K/mCq5QD0w5Mo45d98hCdiVv/WOXYOGdkoeRLLKXgXySHJmjvFqC6pikxy9kp2FhQ8R3u0c
 dOaOLsXgHVdVssNM/CxSHPoA6E90llj94qBW6hY7jQVA6cJNFAFHG1rS1QpsGlQXYTczwqF+0R1
 lbl+N3NbjSZZO9qiOryWooMCfGJzHX5x/fLrMNceRHkPGnLnUzuC9eQqX1sObmD6K2KgIQ8LqRx
 EbrtM6Hwek9rsYMNRzYRKR8sInmUc0cmm/zGwNE+5D1ukj2VZOrRHEnlxqLI8R2JBN9ouw9/1TX
 nmP/6twoVbfFGLgKSp9un+H/tYmPLvWidTPGthO1Ubn7oVd4Ul+nTBTmlldHdLvvbLlyTo9Sp/x
 azyvym+GCMuyYEFTdUw==
X-Proofpoint-ORIG-GUID: DS9qt-n_zxZH25K4dH3AjaGXWkJAXvAf
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a5630c6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Fptb39lSpetro5A1CPgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140132



Am 13.07.26 um 17:08 schrieb Claudio Imbrenda:
> If an attempt is made to create a vCPU with an already existing ID,
> the duplicated vCPU will be destroyed. When destroying a vCPU, its
> ESCA entry will be cleared. In the above scenario, the spurious
> duplicate vCPU is destroyed, but the ESCA entry corresponding to the
> original vCPU is cleared.
> 
> Fix by skipping clearing the ESCA entry if the vCPU creation was not
> successful, i.e. if the pointer to the ESCA in the state description is
> not set.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>   arch/s390/kvm/kvm-s390.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index fc0a884d7f54..6339a327a7be 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3458,7 +3458,7 @@ static void sca_del_vcpu(struct kvm_vcpu *vcpu)
>   {
>   	struct esca_block *sca = vcpu->kvm->arch.sca;
>   
> -	if (!kvm_s390_use_sca_entries())
> +	if (!kvm_s390_use_sca_entries() || !vcpu->arch.sie_block->scaol)
>   		return;

I think sashiko is right and we need to consider scaol and scaoh together.>   
>   	clear_bit_inv(vcpu->vcpu_id, (unsigned long *)sca->mcn);

