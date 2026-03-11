Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2EC30B525;
	Wed, 11 Mar 2026 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773212462; cv=none; b=OL3qOxumSQLrIaCDi66KERtQPSFLCXBtzL2eQlI5hJkgQsmI2OrNSeGHPMXHNUA3OHqUxUGcmpcnJu0wioudi3vG1fxQ0KPBQ6I2VVfe12MmzUNzqcdxph0ou3LGeRFZdkZwPC3Q7CcgKNXRHosuVN55fPwGJ7rbsa/dlxdTwIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773212462; c=relaxed/simple;
	bh=3kzDNsvsskXlmXknyXOD4f0+YuitqQYcx5cDpi55bFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRWpgePARIQQf0gocCegP9YkMsDJQs7qO9vd15lG6B/QVBdTH7ewTJpGFDDW50hZ+U9lDALOoQsOHXfzaTRw3nDLnEzra7n8VppMCL1dMP81hvHI3KPaikvzdbmiK6VYhMP+urUGbHSjzFPLlBius9EoBdhlfsnFjazFFd5VF1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kg6uhTZG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kg6uhTZG"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B1vVnA049228;
	Wed, 11 Mar 2026 07:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=YBSn5OSKIG/z4ZPSPJ1xzUrMehIrh7
	R0GYyEGxD7vA8=; b=kg6uhTZGMtSN3TMxnYBo8JqCeWu21dUwzNQ6Iwu4UM7eBP
	7baoMHl6XQeFgSWjGn4auh+lWBnTz6SOVS2yF+Ihkrb2Rewx6dmVXyl5HuQo8XWR
	XMXzF8pvgStr3kUHXf4mQ1RKzKl1RmM6B9iWSf9GjujHR7FhIZYtebCFfg1UcLXI
	ylXYUzBZXLJzzAkikyaOdUjtDsopPx2c8OeGEvE7EKm34rp2M9NM0E3rGL3U/Roe
	zP+nsrVFp9pSWSc8yPdsaonaIjkkTXrw0Lft50S846FPK6NloSfjtYJNCj+1YGJB
	F+fnozwkftxoOsVAyhFK4Bz+Sm7KC5veX4Va27XA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvmenxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 07:00:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62B25jJJ015608;
	Wed, 11 Mar 2026 07:00:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4crybncdq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 07:00:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62B70sZV46989820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 07:00:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C9112006A;
	Wed, 11 Mar 2026 07:00:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79EB020063;
	Wed, 11 Mar 2026 07:00:54 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 11 Mar 2026 07:00:54 +0000 (GMT)
Date: Wed, 11 Mar 2026 08:00:53 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] s390/mm: add missing secure storage access fixups for
 donated memory
Message-ID: <20260311070053.9469A4e-hca@linux.ibm.com>
References: <20260310150408.160722-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310150408.160722-1-frankja@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HDAtHDHrkuJXEr8he60jxutAqdsk9TUi
X-Proofpoint-ORIG-GUID: HDAtHDHrkuJXEr8he60jxutAqdsk9TUi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1MyBTYWx0ZWRfXz4/9Q7QVjhjr
 fnWYIAgyfo+YXv8CpLl+kNIpxIZJKjsc8FF6FA/zDRAYEbMNMwJ/JUQEOvGhpBK7LtFGUxeN8kz
 VPVv6rYdfSf2NaFkESJvNcBVmwuzQaSH8CY1LADL+xglqq9EvlUWUnZXbBKORkkMIAPRir238hv
 kLyJ3ZmVur2ReON76bg28JPdrhgs+yNcpih4k+Hhz6V5jbZuq7kCcE7pJnxxU6cGAr5Wk4hfq1v
 27tbXPPKVA9d/nUAN5XsOnDoor0bZvn/+DD8fIC6Phs+vDFUnWnSe654jbtpKhCorK6DKCZ75KS
 jc8IQicrHyKY3nOGmewuC9Bl88lqE+SLlCY6x8pD3+0IeKT2bviguxvcbejNU/qQu2PSM7naxyF
 l3i33T55MeAXHhJxW3JvVgT1H0/V2MVyhSBrey/jveOvJ9yfl8Amdncnpapuf97efcYBmmFLJHG
 fv2BBliCQdVK/L/FyBQ==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69b1132b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=absFpL8vnmusHIZpY_EA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110053

On Tue, Mar 10, 2026 at 03:02:42PM +0000, Janosch Frank wrote:
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

Isn't the clear_bit() racy? That is: another CPU could make the page secure
again, set (the still set) PG_arch_1, and then clear_bit() removes the bit,
and we end up with a secure page where PG_arch_1 is not set?
Which in turn would arch_make_folio_accessible() al

Or is that not possible?

Just wondering, since __make_folio_secure() requires the folio to be locked
when setting PG_arch_1, while clearing happens unlocked. But chances are high
that I don't understand the code.
