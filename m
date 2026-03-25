Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C34B39B972;
	Wed, 25 Mar 2026 12:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440049; cv=none; b=FxVsvEdtd34UBR0A9/KMxs96Yy7SfjqqPV0UuVcChFVdjpB7iMzdVqIRj2iVf0db/Nf5Rf3wLmup7m0pWa3Ik/kGPCD6mKo3avnvK3v7IJraF15eYVJ38FtUWPyW+EA9o5fMYy8hT6z7pvYe6U3F27WgQu5gjAm0jsROQRgiczk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440049; c=relaxed/simple;
	bh=GAhXGYzukz50piDgwNLiC9kZneR24GT0XwsFt7jwZT8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=asZss2QOcmPRg8IQXgjLIrM8uPWVWjUdRKy6PPyfBu+83Q0hTc1HaQTnvxGw8Is2pn0E0B962UJ4m4PebM9bzK4JMH3FoVid57sWe9I+d4rVjmKPRw5A0m41j8fVNVyFImYDBxYHPm5braJyeLgC3/DzJImKutc2S3OAAt+Xc3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HDbcbZ0T; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HDbcbZ0T"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P6BXOR3548859;
	Wed, 25 Mar 2026 12:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2hmgYn
	YDvAV11K3/MvOjFR3/Yc9Ls2jwVrI6RUr2P+Y=; b=HDbcbZ0TqfkrujM2XWpLkJ
	kMAHYP3S5xYU7ZHZViH0X74BtVCJS+yzYPQQUmGSCzj8oDUhmcL3zaiSfQWlIa/i
	XYWvZxA3EHkKHVDkihxcfNh9Uq2J8pzrBSLY1VtsexeGgsdm2uRFrwdL7yC8jtrv
	6p9ZFht9CA2EZ8PcGXJUMLZI3wQxcjuR0qMlRXmyose3iC0tY5VIDCatZURRQW6T
	bIEoTm+eREiE+azGoGESSeJCV4ZDciIUoh8Q1Mh9fYAJogPpKQSFyJs+EtMjw0zp
	MKTI5lKxQm8qTSG9+8wF4wC1XeSIzenp1fhHtCR1rOVyJumArEqMc4Ajp73/M91w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqg8r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 12:00:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PBlfvL026771;
	Wed, 25 Mar 2026 12:00:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275kxa5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 12:00:46 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PC0g7g46203182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 12:00:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5293220040;
	Wed, 25 Mar 2026 12:00:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 351F02004B;
	Wed, 25 Mar 2026 12:00:42 +0000 (GMT)
Received: from p-imbrenda (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 25 Mar 2026 12:00:42 +0000 (GMT)
Date: Wed, 25 Mar 2026 13:00:40 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@linux.ibm.com
Subject: Re: [PATCH 1/2] KVM: s390: Fix lpsw/e breaking event handling
Message-ID: <20260325130040.5cde190c@p-imbrenda>
In-Reply-To: <20260323153637.3683-2-frankja@linux.ibm.com>
References: <20260323153637.3683-1-frankja@linux.ibm.com>
	<20260323153637.3683-2-frankja@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: mWR6Sl7Cj96F25cmCTrHrNROnyVPNdlg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA4NCBTYWx0ZWRfX0Z9LHIqRZZq8
 qtf6agmzK+rYKn5LZhJ34gsFrvsfSsV2TZazKzN/MvBm0qg+lFWPVoZieaYoxTIbJCqZQeFDROl
 +aGKshFJ2UYJa4A5wsjeAzdKRcsgXwmnJrO8oaqBnY5Yb0YKip8A+9NLLAX6EcLINFZ0W2Y9aje
 w2wQHHbMiHFQAePZgJokDTUMO0G1fHDidN9x7BHqfL78l2XWhw3P2SuqHnwGZb0i0s6clPll/9c
 uNXxRH5c9bKBOzb1v69lsZH02pJI/YuRHmGByIp0zAZAIP51aORbKEED1j8a04v/E719un43KGY
 pNxANJ9mskZQCqUcCIzy1efzcPTPbAvXSTxqrTK/S0q1/Vxm9pYb8aXA5Ceq3CHNCdGUhWnsrFY
 UtVZZtATqibYusOV8QtPHM8yJrVFQeCAThJBixxo1kV8nxHhy7jZz7g5q8aE1vin1K7bniXedIq
 9/7DQq8oO33qZhuh/eA==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c3ce6f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VLN7PFTZkrhM44o7lRsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: mWR6Sl7Cj96F25cmCTrHrNROnyVPNdlg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250084

On Mon, 23 Mar 2026 15:35:22 +0000
Janosch Frank <frankja@linux.ibm.com> wrote:

> LPSW and LPSWE need to set the gbea on completion but currently don't.
> Time to fix this up.
> 
> LPSWEY was designed to not set the bear.
> 
> Fixes: 48a3e950f4cee ("KVM: s390: Add support for machine checks.")
> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  arch/s390/kvm/priv.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index a3250ad83a8e..cc0553da14cb 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -714,12 +714,13 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
>  {
>  	psw_t *gpsw = &vcpu->arch.sie_block->gpsw;
>  	psw32_t new_psw;
> -	u64 addr;
> +	u64 addr, iaddr;
>  	int rc;
>  	u8 ar;
>  
>  	vcpu->stat.instruction_lpsw++;
>  
> +	iaddr = gpsw->addr - kvm_s390_get_ilen(vcpu);
>  	if (gpsw->mask & PSW_MASK_PSTATE)
>  		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
>  
> @@ -737,18 +738,20 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
>  	gpsw->addr = new_psw.addr & ~PSW32_ADDR_AMODE;
>  	if (!is_valid_psw(gpsw))
>  		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +	vcpu->arch.sie_block->gbea = iaddr;
>  	return 0;
>  }
>  
>  static int handle_lpswe(struct kvm_vcpu *vcpu)
>  {
>  	psw_t new_psw;
> -	u64 addr;
> +	u64 addr, iaddr;
>  	int rc;
>  	u8 ar;
>  
>  	vcpu->stat.instruction_lpswe++;
>  
> +	iaddr = vcpu->arch.sie_block->gpsw.addr - kvm_s390_get_ilen(vcpu);
>  	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
>  		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
>  
> @@ -761,6 +764,7 @@ static int handle_lpswe(struct kvm_vcpu *vcpu)
>  	vcpu->arch.sie_block->gpsw = new_psw;
>  	if (!is_valid_psw(&vcpu->arch.sie_block->gpsw))
>  		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +	vcpu->arch.sie_block->gbea = iaddr;
>  	return 0;
>  }
>  

