Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330BE3A3809
	for <linux-s390@vger.kernel.org>; Wed,  1 Jul 2026 06:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782887120; cv=none; b=C42tg7kH3piZEksuIep/dKAll4x6cYDJFZokswQYG2cKLzPhTVHHYYSo6pG72uGsZvjSnLmaEfD/9Q93SPT4wbOaBqnNkc31ijfN9ZuigaM34iT42ikw+sAiYoqNskYAda5UG8yKZQ8RS1jWWO37jh0fjyBdz0FlSOcvqc80Pgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782887120; c=relaxed/simple;
	bh=0Acwrlwd/Ekza37SGzI8LgP1k8EyWXbg+BalsUObww4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SXF9EARI47GcnsX/iigMT03kH6s7hqEt6Mp+UEIVZYpkX7RLg3A4Ob5djBW0+mqwE+kl1c50DHzoK/NB9kazgxE+LK+uQcbrH08FzBc3TM9NosRWFaJV/1VyTG/chQ5imFK4vC+bhgSscIvxX5BA6jBDxMfWq7EEniQb2dxmies=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O3Grfu4l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O3Grfu4l"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6613IXZB4062050
	for <linux-s390@vger.kernel.org>; Wed, 1 Jul 2026 06:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=TPNm0BPjc372iG6so2J089H+Lwq0Mc
	xxq9zamDqQzGk=; b=O3Grfu4l6+oH8yK3DMqvICzJ2sqmwI4Jr0cTWidetn9PG+
	e6ii/uCPIxVRXL7re7F8n/B3fyk4X1XjYDkW3pzxm9xhcv8mQdop3BAAHOjWrXzv
	YiKlT3ppDR8clcq+3KvzAGkPgNDXsbKSYZvNiaIoYw+qMnsbCVMCEOXwX43T++oY
	W4KvsvKtpaf6Mfg7e699C0TsRcOk83nRFLSAQfso9vPT40IGshaKBZOg206wgD/9
	vMX4jyc29l/qMnlZgenLIs2Uw0rAw8ugLtSNg7FzqpczYNa+wptFeK7xG1JY7DI7
	q4y6yp0JkOnGVYFRaTS8eUXzeLM1/VT6O/O5LllA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qg2u40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 01 Jul 2026 06:25:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6616Jgqa019352
	for <linux-s390@vger.kernel.org>; Wed, 1 Jul 2026 06:25:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhydqd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 01 Jul 2026 06:25:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6616PDNN60883324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 06:25:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 890E120067;
	Wed,  1 Jul 2026 06:25:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 705AE2004F;
	Wed,  1 Jul 2026 06:25:13 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  1 Jul 2026 06:25:13 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>
Subject: Re: [PATCH] s390/mm: Fix type mismatch in get_align_mask().
In-Reply-To: <20260630173214.3114408-1-gerald.schaefer@linux.ibm.com>
References: <20260630173214.3114408-1-gerald.schaefer@linux.ibm.com>
Date: Wed, 01 Jul 2026 08:25:13 +0200
Message-ID: <yt9dv7az8bw6.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a44b2ce cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=gf1-7XqKsu7sE-FiRg0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA2MyBTYWx0ZWRfXywe4jG5FHi6b
 WiMgt8v4jT+g/LK/AE2ce2bNWbckk08wgo2undcVAO55tzXGkvIm7yvVUo4cDfeDFRfqOdPGFeP
 k3il+IavK+tynRegO9HiycMmZZQY47I=
X-Proofpoint-GUID: rMRBmfhbx606rPJefRb6qA0fgEXRXBwe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA2MyBTYWx0ZWRfX9Kl/+2Uq2ZOg
 DNrnIrq1o2FYNbaWrl/RwvV18Ws3ICJ/0aNmD5oD1Q74OzarpeamZEQK9RPRUaDtw7eR80ntsFg
 UtDvMCGVMdxTCQuVeMtbb3clvsUisWjcFz/Hcvgj3gZmNL4sddTmSh8nfwh6dPlqY/Ve0Jr03DZ
 /8FyGXtvqlGQx8IbNPshij+LBSZupiL52j1GkuL1FanHw6CR5lDbAvi91UZwvqA0tKHzvghZsNp
 Ybd074BGvEsvricj/yLrBfpcCnHyH28ac+dUOrFomyJnTZ0McALtlH/JrElZOZyN9jMymQwwdG1
 6R6bI1VNAEN3U7iCEsNxD07KbtbNLkcixDrIiCMk7R/+aBF6lnzBjVHy5hPXK55CVW19XLOSqTJ
 Gn3fyVYaLq924hLv+2rfIE8ZmqhY3sxqE7znAELxpm6cONBDIuZScUHl6S4lpedRzOXLx6TwGyB
 5RJxL/pDsq9I+ZX6LRA==
X-Proofpoint-ORIG-GUID: rMRBmfhbx606rPJefRb6qA0fgEXRXBwe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010063

Gerald Schaefer <gerald.schaefer@linux.ibm.com> writes:

> Commit 86f48f922ba79 ("s390/mmap: disable mmap alignment when
> randomize_va_space = 0") introduced get_align_mask() with return type of
> 'int', while the target field 'info.align_mask' in struct
> vm_unmapped_area_info is 'unsigned long'.
>
> With currently used masks, this should not cause truncation issues, but
> fix it and return 'unsigned long' to avoid future problems.
>
> Fixes: 86f48f922ba79 ("s390/mmap: disable mmap alignment when randomize_va_space = 0")
> Cc: stable@vger.kernel.org # v6.9+
> Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> ---
>  arch/s390/mm/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
> index 2a222a7e14f4..ef7bfc87758c 100644
> --- a/arch/s390/mm/mmap.c
> +++ b/arch/s390/mm/mmap.c
> @@ -64,7 +64,7 @@ static inline unsigned long mmap_base(unsigned long rnd,
>  	return PAGE_ALIGN(STACK_TOP - gap - rnd);
>  }
>  
> -static int get_align_mask(struct file *filp, unsigned long flags)
> +static unsigned long get_align_mask(struct file *filp, unsigned long flags)
>  {
>  	if (filp && is_file_hugepages(filp))
>  		return huge_page_mask_align(filp);
>
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482

Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
