Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D429E1EEE6;
	Thu, 16 Apr 2026 05:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776318064; cv=none; b=MJWhnMxabC1+IRNRJw7GoVikJJ6Z/1bc2PhCdEs4EiseBUlu0qAzd0gIon8tYvE0cQxkjPwLsaUF9lv2FV30H7kmSScRX9J4gqAGzJi/sFjrdIA9HqtEjYfZAB1oRLV4OESYAnI9XCxHhe3IOL8qCyYupXbcg7y64JfAgbr8CbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776318064; c=relaxed/simple;
	bh=pvIqFyzkm9/OtXrphPTOUh29Slpci3RnZwrnQw363yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KK77BCxSZbnlIvR0dmqrnGCkXz9/DdgN3mlcNGqYpgMUNQPOmAsQ39KRWu9ikQiwCwSEDlcIEiqbc6+g5NYdRSBv7Hg7uGbeYmisBqu3pcMkMfCD+7vK+mys5tsDLkbyAkjLL2O2tousmGy3HexPagdpBDuUo4G1bPz1OKczr8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tD3THvqh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tD3THvqh"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FG8PSR1833234;
	Thu, 16 Apr 2026 05:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=D6k+eOmawKf0S3bAh+pGR4TUjM1VcD
	anzk69tnu6AhQ=; b=tD3THvqhELKwhvKybuzzOXYaTe3eUpFTcDW/yT5Jq3I2CI
	L49M+UCZeGtl+uX2PJXzXBIlEPs5MlYxB95jcSjgTjGN3tY6iILcNg+MDdBZACK4
	2r9wXxTP4AjyD6jGaDavmLq+J51PlRA+Z83LjIQeUiQWl0wwGIYBhykGKbY9VBgP
	ZwIChurt3LLKeKfsw+Mqqgk9lnFrVEAjU/dVqZtBvRPzqVZgkQYv6GncXuNgt1st
	nyjO9mjxyckhsrOHYZr4cSXLLhsWHjoUHh9dB/pDBoMxrEobzyJ0CscdhmIkU9uZ
	apx8DgvQFFtbemBc6OmqAohwSF8uTDXP/o5C3CXw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89rku53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 05:40:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63G1TnmD003610;
	Thu, 16 Apr 2026 05:40:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mnhgn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 05:40:52 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63G5embZ58130730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 05:40:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 407A020040;
	Thu, 16 Apr 2026 05:40:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CDE520043;
	Thu, 16 Apr 2026 05:40:48 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 16 Apr 2026 05:40:47 +0000 (GMT)
Date: Thu, 16 Apr 2026 07:40:45 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] s390/mm: Batch PTE updates in lazy MMU mode
Message-ID: <20260416054045.10407A20-hca@linux.ibm.com>
References: <cover.1776264097.git.agordeev@linux.ibm.com>
 <924c91e711e8b16470eb2af7e31d0b6ffcf2940c.1776264097.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <924c91e711e8b16470eb2af7e31d0b6ffcf2940c.1776264097.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA0OCBTYWx0ZWRfX12RE5HsXdsjt
 UXEXMbXdC/akNcokxSzoE+3CiWjt0BgHqIeiAxc7gXjFdI1T6pC6DSWPyHcV49FJUtVdcEc5OsC
 WhBCJ6QHHaZrDgnIsmnQ+6URT80ZW/wFjKRdwq6/2oEKRhsrKK2S7aQ0yPw7+Yo7EoGLVeztehb
 Ap0seC/Q+IrDGsczw0IAukVScxQyBxZqZ18cu1SZbRfOLzXh10IEnq6fnwzmR5G4+oI5ViWfj37
 aB2T7+muApMhDdJr5f5PMxFq8h2Kzn3vT60FgjnoWBd+klWeNszkJxxq5YKbGkvtsmirSno0Bvj
 BCPyK2QJmSBFcXb2YFpE2X70dkXaWKFVId7JhPk1/C/3JCYCi42qzLlyK0lPJWkFE+RqBCjczmf
 XI01NWfwkFqw+HxERtwJ4b6y7U9RaVUpncJppWIxFw26nf6snmEn/U3XOTq1BzK1BsMXo8Tnp0a
 db8E+rpHQ/QVEPwkYMg==
X-Proofpoint-ORIG-GUID: 9ofSS6RPIkZFeRdb9lqffwjtnk2ZduVR
X-Proofpoint-GUID: 9ofSS6RPIkZFeRdb9lqffwjtnk2ZduVR
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69e07665 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=lj8NcCMTIohhnMXQ0FkA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160048

On Wed, Apr 15, 2026 at 05:01:23PM +0200, Alexander Gordeev wrote:
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 7828fbe0fc42..deffc819268e 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -732,6 +732,17 @@ config MAX_PHYSMEM_BITS
>  	  Increasing the number of bits also increases the kernel image size.
>  	  By default 46 bits (64TB) are supported.
>  
> +config IPTE_BATCH
> +	def_bool y
> +	prompt "Enables Additional Entries for IPTE instruction"
> +	select ARCH_HAS_LAZY_MMU_MODE
> +	help
> +	  This option enables using of "Additional Entries" field of the IPTE
> +	  instruction, which capitalizes on the lazy MMU mode infrastructure.
> +	  As result, multiple PTEs are invalidated in one go. That improves
> +	  performance of many memory-management system calls (like mremap(),
> +	  mprotect(), etc.) and decreases CEC-wide quiesce traffic.
> +
>  endmenu

Just some general comments before I find time to look deeper into this
series: please let us not add yet another config option. This will be
enabled anywhere in any case.

Not having this option makes maintenance easier.

> +#if !defined(CONFIG_IPTE_BATCH) || defined(__DECOMPRESSOR)
> +static inline
> +bool ipte_batch_ptep_test_and_clear_young(struct vm_area_struct *vma,
> +					  unsigned long addr, pte_t *ptep,
> +					  int *res)
> +{
> +	return false;
> +}

Why does this depend on __DECOMPRESSOR? Which code in the decompressor
would generate a call to the ipte_batch functions?
