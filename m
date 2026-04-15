Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63820332906;
	Wed, 15 Apr 2026 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776250774; cv=none; b=AoNwn2cBlRdcxsqXcCuC0mmYCm/P/EHBDr5gXZcuYT37S481pSmfp6SQzeAbnJGulUMHEcQ92Oe88XuroOqfhK3DGklHBtjxILAfIxopfS81+X48IkRTDvqUgALv0ApTfnP4S7giq7Tj0fSVKzNf7+9BpT8Z8NF5TcAurG8llqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776250774; c=relaxed/simple;
	bh=UeGFSTDoJqBsLuNrVjPGI7nozN44eflH0Qgot+HRvBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1HrI5LJEDci2LQP61Nk6Z7F95+yasCtUjk+suH4uk6G+n9OJ5dk5cGLwrbQR8pCck4TYUtzv2Hj4LRamfAt75VwDZLktkMdXUOYn0gWQ8JaVq/QQSe6TtFGSiocBtmT5Dy3Jgycmpc6DEg7SqheqjzeQdaLvHY2f4IaHak/EL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PAnO4rsX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PAnO4rsX"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EMeJaG1733761;
	Wed, 15 Apr 2026 10:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=CKHhqQ8oWr4TMUt9zL7LxR9PZ1FgqF
	xtMQUsupGvFjw=; b=PAnO4rsXc7WrDha/qCYFO2rEtbGFWsbSMqbEM8Fuzd70ys
	aY8yqroIRdRmH8wM12ae83ddwX3KVxMykd4dGMYgoU96796dYQcSQKtiJDsVR8A0
	ZuxQlU2PPaiaW/a/4Ruk8+Lv2Re8PE7aUiLK2RESjp87V/yvqpOvyCmYaRpK6Lfk
	LU7wLqJFXiSNdTwTT/u763BdUJs01rmD8lYeiIVc+ys7XAbtHBuPBUxCb41bCm2r
	W6mmPAXLrtSbXVGNBXKVnqfewd3wPckvBwT1qktwovkvBZ4vk7m1xEkMKowJX+16
	oP6GXuSmd5h/QkLEtO6e6zTPXYmj7RWSKNtFSoig==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89m775m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 10:59:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63F91E3p025835;
	Wed, 15 Apr 2026 10:59:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg3b1nmrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 10:59:31 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63FAxR9L46662094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 10:59:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B43902004D;
	Wed, 15 Apr 2026 10:59:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94D6620040;
	Wed, 15 Apr 2026 10:59:27 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 15 Apr 2026 10:59:27 +0000 (GMT)
Date: Wed, 15 Apr 2026 12:59:25 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com
Subject: Re: [PATCH 1/2] KVM: s390: Fix lpsw/e breaking event handling
Message-ID: <20260415105925.10321B18-hca@linux.ibm.com>
References: <20260323153637.3683-1-frankja@linux.ibm.com>
 <20260323153637.3683-2-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323153637.3683-2-frankja@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I/dVgtgg c=1 sm=1 tr=0 ts=69df6f94 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=TW3WLsQbQTa6aNEchmkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: MLhZliGtGrXv_YfPNaULJGQnqqow5u9V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA5OSBTYWx0ZWRfX25hTlmmJ2r/3
 cfPK4ll6mgFjWiYqLkViqs0ZNQYfalGCg4woXz0ZJ4SGlGjwjXdFbbwMSbtiCKzlWn+OGIYmJfL
 2LSrdgT5HXLNIJ/EGtWQEPfqRBVfyK1DwRQE087q2KkMcwG9gJNb3D8IjMlOkzxVd7jGQCsGHNz
 O/8d6n3CQuZ1bISzFJwIUK2Ovv8AIJPyDaotoXdyJPlbVGxvm7vK+TaxIpQuULZx1x1RbWhTndO
 +86DEjcx5xV15LG65wj3YY238II+zcNaVD1+w3fM6esolLDzKwegfNMZdnWcCGLn5E6MagwxTgj
 CncJ8tVTpva+0dhmXOBdiI7PG81iLUxWcFhzakpy9NIX4GiOnocmC2gaeU9Xemq6v6Ewg4VKvt+
 DNvECLhvaKJP9llJwWA8/SXzCl0kcCormPQZf9DoQjXive8BXsfCY+zIYoYcjw/X11YTpyVzBU8
 kAH3UPka/MYbvlcIdzw==
X-Proofpoint-ORIG-GUID: MLhZliGtGrXv_YfPNaULJGQnqqow5u9V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150099

On Mon, Mar 23, 2026 at 03:35:22PM +0000, Janosch Frank wrote:
> LPSW and LPSWE need to set the gbea on completion but currently don't.
> Time to fix this up.
> 
> LPSWEY was designed to not set the bear.
> 
> Fixes: 48a3e950f4cee ("KVM: s390: Add support for machine checks.")
> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
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

This doesn't look correct to me: even if there is an early specification
exception the PSW is still replaced, and hence the breaking event address
needs to be updated. Read: the gbea assignment should be moved before
the is_valid_psw() check.

>  static int handle_lpswe(struct kvm_vcpu *vcpu)
>  {
>  	psw_t new_psw;
> -	u64 addr;
> +	u64 addr, iaddr;
>  	int rc;

This breaks reverse x-mas style. :)

> @@ -761,6 +764,7 @@ static int handle_lpswe(struct kvm_vcpu *vcpu)
>  	vcpu->arch.sie_block->gpsw = new_psw;
>  	if (!is_valid_psw(&vcpu->arch.sie_block->gpsw))
>  		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +	vcpu->arch.sie_block->gbea = iaddr;
>  	return 0;

Like above, I believe this is not correct.
