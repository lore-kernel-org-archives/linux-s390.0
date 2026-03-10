Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E38F392C32;
	Tue, 10 Mar 2026 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773168677; cv=none; b=CeadIkCFqYlFX8nVCdS5251o7hvIbuy/wzRvNmem//DkllTzUEgNBiYO4Q5OyR81oMjS/9C+Z4O69dsu+6X0pnkRTczVQl/t7i+4T3vLSi4bSqOTu1PrDyjKXEdsFS/nz+ZKwKR1kDnwWbGkwA9AcPEh8Rmctg14tFG+dw+wVUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773168677; c=relaxed/simple;
	bh=wL+Z3HwtHugqokmow9y5JIZpHy81o1+IrrrnJygERCk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXnkZ+rKuDZnq5tso4RirPuyJAGyhd4riBcx3e5NtnOmMOKqg/tVTrk4KLWO1FJkR+XPfQ7CruNhSD3JzDrTXQsaHroftEKu+FFR/8aCfeWbZEhzcXHoBq/CGxfBLmtFzEMwNU0KfOYaQlIq9AsggqkjwcAOSEaesD8P6SwKgQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e7EpZioZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e7EpZioZ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A9HCIL1581148;
	Tue, 10 Mar 2026 18:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dUZfjg
	R1YdloTZPblL1GRW0KfIEpr3vi3PegTQN42ZA=; b=e7EpZioZo9K7OpTwDuy6CB
	g5HPjQc0NMwc2mXhfhw3wh2a4ID4+bTr1RbO8g+fxhM5nFEmTTs+vBDZfSi4qun1
	sscJiE7MPXWedVKCQAdew2rLdscTRO1r+I9grSdQ1MeVMejmk4a4EzX2v6sBNtuA
	9FSnDaTBzFDLsNXXDTSGbfhOtpUFIqgRKbIL9dYZ3zVHIrG1jwO2BuCXpjipAngT
	jh+kSNO0fa5UsKHsQZuDCKKFLQicCeB7xPsbXk4TJz5tWG+4LppOgcVO7fzvTuef
	8ZVeaK+9lmQFUskB9M3KZKmohm+O7d0PfXsy4edbhp8C4Jg76ESKJOXypcKHnftw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcunc39d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 18:51:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62AFJHN5029306;
	Tue, 10 Mar 2026 18:51:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4csp6uq21m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 18:51:14 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62AIpAA445547984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 18:51:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4922B2004F;
	Tue, 10 Mar 2026 18:51:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B6862004D;
	Tue, 10 Mar 2026 18:51:10 +0000 (GMT)
Received: from p-imbrenda (unknown [9.52.223.175])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 10 Mar 2026 18:51:10 +0000 (GMT)
Date: Tue, 10 Mar 2026 19:50:29 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com,
        borntraeger@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] s390/mm: add missing secure storage access fixups
 for donated memory
Message-ID: <20260310195029.6c529693@p-imbrenda>
In-Reply-To: <20260310150408.160722-1-frankja@linux.ibm.com>
References: <20260310150408.160722-1-frankja@linux.ibm.com>
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
X-Proofpoint-GUID: ZNHtAPtzcdF2PeH4Y5tLhQlPzr9uRugT
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69b06823 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=absFpL8vnmusHIZpY_EA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE1OCBTYWx0ZWRfX062k4wVKYiva
 S2Mgf2uX9tPo6AucZMsj5FY4kq42ZftH/T1HgH+Aj9xBtearSX5CqZSbanF9+ZWTR9r64fUnm3L
 xyQMLASerQonhnJukwm7j/OhkxVvkiTl12UH6JeUJs/70ada+k8tcqJHRx5UqxFe56SJyf9NmsJ
 IBW1VsLftt8DITveUC6sl55cRutFSWbL6nyURtnrtGf4H4qNJdscQjvSQ87Eb7EK/3am/0XbsgS
 jHA79hMYvUIuxE6MIuVkJwwsAwHOt5O0aKzfDPMT2RkTEMMjTEVtHEyKsyDK2a75evyU+qf0e8+
 UI7EFBw2OxmTIp1la8NXlvKXxarHvJObMh38SxV9LNx2IkV8Fw5XCVFbA78C3DUdZwF2D6j0vMa
 vkJR5vUS7ErWLdLULIPSPd8y1VQK9LxICKCIRwJtRphm9o1QFnMpoMb7DeFgxMoSkau9nC2qfGQ
 3Ib5g2+C5vW1vJM0uEQ==
X-Proofpoint-ORIG-GUID: ZNHtAPtzcdF2PeH4Y5tLhQlPzr9uRugT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100158

On Tue, 10 Mar 2026 15:02:42 +0000
Janosch Frank <frankja@linux.ibm.com> wrote:

> There are special cases where secure storage access exceptions happen
> in a kernel context for pages that don't have the PG_arch_1 bit
> set. That bit is set for non-exported guest secure storage (memory)
> but is absent on storage donated to the Ultravisor since the kernel
> isn't allowed to export donated pages.
> 
> Prior to this patch we would try to export the page by calling
> arch_make_folio_accessible() which would instantly return since the
> arch bit is absent signifying that the page was already exported and
> no further action is necessary. This leads to secure storage access
> exception loops which can never be resolved.
> 
> With this patch we unconditionally try to export and if that fails we
> fixup.
> 
> Fixes: 084ea4d611a3 ("s390/mm: add (non)secure page access exceptions handlers")
> Reported-by: Heiko Carstens <hca@linux.ibm.com>
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
> 
> Changed fault error handling to nolock. (Heiko)
> Added PG_arch_1 cleanup requested off-list. (Claudio)
> 
> ---
>  arch/s390/mm/fault.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index a52aa7a99b6b..191cc53caead 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -441,10 +441,17 @@ void do_secure_storage_access(struct pt_regs *regs)
>  		folio = phys_to_folio(addr);
>  		if (unlikely(!folio_try_get(folio)))
>  			return;
> -		rc = arch_make_folio_accessible(folio);
> +		rc = uv_convert_from_secure(folio_to_phys(folio));
> +		if (!rc)
> +			clear_bit(PG_arch_1, &folio->flags.f);
>  		folio_put(folio);
> +		/*
> +		 * There are some valid fixup types for kernel
> +		 * accesses to donated secure memory. zeropad is one
> +		 * of them.
> +		 */
>  		if (rc)
> -			BUG();
> +			return handle_fault_error_nolock(regs, 0);
>  	} else {
>  		if (faulthandler_disabled())
>  			return handle_fault_error_nolock(regs, 0);

