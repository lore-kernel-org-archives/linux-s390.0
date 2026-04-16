Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266903793A8;
	Thu, 16 Apr 2026 05:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776318264; cv=none; b=MoI/Pl9vlWy4DaF73SXWotA6vIbqrhvLzzul8vSLp8SDRKX2NOTt9unl8cdmoCyBQHJ5UfMJod8TiDAbMXWd0zvrJ61uL9gE9K+bP0yf2lD48XSjxcGST6dkGTANMziATE9YCmT8r4h0RBL26z5XQCD7Oip6UxV0EX82GGyB+G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776318264; c=relaxed/simple;
	bh=8+QFa1MmEbHZPC5RLvkG6X/1TWorFu2dk4FFh9nYTUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prfUNLh7UKCDz8U0DsPZjj1oTCkYfQz4NFxCMhRThuOQHC7WEIg7BePqB2XH8fDrXqf9JQ5awSV8QmV6kDg9WMDtGKuB5rGH0iqbnOJJfOuO7xH5Uu57dbCBk54GFVTqzmcGn3T9E/HZM5EzIJeyQx4GC375e8ilIqSmK99GKWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hf3QYlGG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hf3QYlGG"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FHTUTb2131021;
	Thu, 16 Apr 2026 05:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=1Tu5xAMOTiI/sq8sxskBz13O5Z9Aj1
	zkghiLzks0d8o=; b=hf3QYlGGCsqyZAPORX1soQDa5jtb+fRS1qR+iMncXxYjJ2
	N8bAn48tBqRUSkmxKMPJd4upTCiV2ncktHimn7eEALicxMatWWC3bAdR3felvu1Q
	FY543lff2ff1qXsHPh80rUr+ZHcuUB2PDhs8lQU9Md4yryopuE6R7RVpNMh8t6e9
	U71EfQr4YlWKRrjNZQKrsy+FRCQ9bsWmWQJy5zOZBxftiwd2ftxMeZ15bOtI6O/N
	BnfO5glbZhK8ZHuJE9Fv/A91x47LSHVogYxj27i1epE5/H7T4i/Bbyzc7CkuKYFt
	auDyF+xZ0SCSn+RTCQDkWZl6MvGeQOShWYLGxbnQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89nkvfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 05:44:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63G2IXcq004175;
	Thu, 16 Apr 2026 05:44:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24khevq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 05:44:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63G5i8iJ43450770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 05:44:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 365CD2004B;
	Thu, 16 Apr 2026 05:44:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E27D20040;
	Thu, 16 Apr 2026 05:44:08 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 16 Apr 2026 05:44:08 +0000 (GMT)
Date: Thu, 16 Apr 2026 07:44:05 +0200
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
Subject: Re: [PATCH v2 6/6] s390/mm: Allow lazy MMU mode disabling
Message-ID: <20260416054405.10407B6c-hca@linux.ibm.com>
References: <cover.1776264097.git.agordeev@linux.ibm.com>
 <24d843c5568a8b591cbbe16eca092e7f45d18cf5.1776264097.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24d843c5568a8b591cbbe16eca092e7f45d18cf5.1776264097.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wDETBtZ7AQ3rup6ZrrfpHAtaCOzv1uZl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA0OCBTYWx0ZWRfX0rRYvkY5ZgnL
 iEPSeGwiSHeiLQJVrYN1Wh9k9Qy2q6vl3kdW61Js8iXgSvRXhxNV5kVvIXRhhFOptH6Z4mpSnRE
 +tkGJQrFRhPq0Mtn7T6BMhBS6IltcQt9IgHhnIVbRBJw0GrmTspEphvL1pHH6/mzFFewaVKIvRx
 Z2BePxo5Y31HJNTnY76yjuGYQAFioh9IQHjSdVPJXMSCUnOmgU+xVNskCyNh7U+b0yoyXyhn5DS
 h3JlsYgP0txdrh8/8JKxL67tMEgVHe7wivqjMnoS1BxeZXhQbs7s5ee+6K1wmPruswllb8XAUsi
 ++xIm/LlkQWQ6Gp5YRy8dxASQO4N+bHSyIIVQzAoSdTEZ5TbredA7FY+BlcjlQYCdhZbOK49PI8
 QLpfprQ8TwYbWhLXfglJZU+qeGOC1TFNVXghvZ311DoD1Oh+h1QAiC9Ob00XqhsYRTkzPVa+/1g
 6neS4P8zImTWVN9TUYw==
X-Proofpoint-ORIG-GUID: wDETBtZ7AQ3rup6ZrrfpHAtaCOzv1uZl
X-Authority-Analysis: v=2.4 cv=FY4HAp+6 c=1 sm=1 tr=0 ts=69e0772d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=inxPCtavq7kBZ1W-2pcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160048

On Wed, Apr 15, 2026 at 05:01:24PM +0200, Alexander Gordeev wrote:
> Inroduce "lazy_mmu" kernel command line parameter
> to allow disabling of the lazy MMU mode on boot.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/s390/mm/ipte_batch.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

...

>  static DEFINE_PER_CPU(struct ipte_batch, ipte_range);
> +static DEFINE_STATIC_KEY_TRUE_RO(lazy_mmu);
> +
> +static int __init setup_lazy_mmu(char *str)
> +{
> +	bool enable;
> +
> +	if (kstrtobool(str, &enable)) {
> +		pr_warn("Failed to setup lazy MMU mode, set to enabled\n");
> +	} else if (!enable) {
> +		pr_warn("Disabling lazy MMU mode\n");
> +		static_key_disable(&lazy_mmu.key);
> +	}
> +
> +	return 0;
> +}
> +early_param("lazy_mmu", setup_lazy_mmu);
>  
>  static int count_contiguous(pte_t *start, pte_t *end, bool *valid)
>  {
> @@ -169,6 +185,8 @@ void arch_enter_lazy_mmu_mode_for_pte_range(struct mm_struct *mm,
>  {
>  	if (!test_facility(13))
>  		return;
> +	if (!static_branch_likely(&lazy_mmu))
> +		return;

Looks like there is an alternative chicken switch available: remove
facility bit 13 from the facility list via kernel command line option.

Unless I am mistaken: that should be sufficient and avoids adding more
code.
