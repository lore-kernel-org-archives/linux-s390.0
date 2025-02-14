Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5B32566C9;
	Fri, 14 Feb 2025 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739530714; cv=none; b=LvtxkczCmYfK/7X6oumwgIf0yXsFrFjsuy3VG9E0GLuVJ8DE69bk9itdQeMxb8pO/akokLJ27h9RUB76FEaoVXVhaLmI8wJJIqkHBM1zzQTB3oNBlWERV8yGSNHPMMCVs6fHS3xjzOZoi0EZhqYwS7eFpzkl1+RM6vdAdGvO2/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739530714; c=relaxed/simple;
	bh=EGhdWFhxvU3DtsYF4hIXdWEmXBhYFs5Ow5Bp/8iMIiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4x4diFmxqsXfhHH4JjkNLVhxglUayORlO2McqiQy3/9lZXDtmp8Yg5/67TYPCZVOb0Y5vf1eM29AiziSCvwTxNveNeBRDMvdKxyR6edy25+eLRCNjWP7tjyCXV3W9D/JMNRZi5Is26ycqFmHkr+s25U54hpgmlVuY340Die/F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G5PRFuPt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G5PRFuPt"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E5NoQr009108;
	Fri, 14 Feb 2025 10:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=l6Ljw11vv0g6aPW7jT24P/lwJvcqP8
	Sj9NRTFWAGRFg=; b=G5PRFuPtrkMf4oYHRTqokZxv2bzghKO1H0gCqDYkxz9QAO
	FJ0KrlABcM+IhSsHfgz/trnjRkwmPQEDUY/mf9V3EE5YRa/jalt2CUK90wklOb/S
	yMZZ9H52uIjnbOG2cLI7NZU4aScv256LYZZRwCiAnUGwFPgU1tYjae43IcrNJnIf
	ZznWJyZhowtRe3SjNmq3F2QWN8mQpN8e1RcykLVuEH4mHfr/6TLBWZmThe8Yoefq
	Clm1IuNjNKy9dGXRVX119JrB8YFN4kFP4kk2UMezOeqO9JaCtY4ttJ1eHPgVt7RV
	2xwNk9fgUQT6l4gjUAgwnYNXCBzpxQ1TW9SoGo0w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44syn81d2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 10:58:31 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51EAkCBx031764;
	Fri, 14 Feb 2025 10:58:31 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44syn81d2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 10:58:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51E9UMdc028721;
	Fri, 14 Feb 2025 10:58:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44pma22rxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 10:58:30 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51EAwQfu56033602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 10:58:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6B5E2004E;
	Fri, 14 Feb 2025 10:58:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2FDE2004F;
	Fri, 14 Feb 2025 10:58:25 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.2.165])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 14 Feb 2025 10:58:25 +0000 (GMT)
Date: Fri, 14 Feb 2025 11:58:24 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/mm: Simplify gap clamping in mmap_base() using
 clamp()
Message-ID: <Z68h0B6vFdfCbNpb@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250204162508.12335-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204162508.12335-1-qasdev00@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HOdcIq1id7PMttC3DckWZT2oqeTVr7cg
X-Proofpoint-GUID: qWbfhfH-79yeqrouzcP-2CIhSIydUMOj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_04,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502140076

On Tue, Feb 04, 2025 at 04:25:08PM +0000, Qasim Ijaz wrote:
> mmap_base() has logic to ensure that the variable "gap" stays within the 
> range defined by "gap_min" and "gap_max". Replace this with the clamp() 
> macro to shorten and simplify code.
> 
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> ---
>  arch/s390/mm/mmap.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
> index 76f376876e0d..a3d3e09a2828 100644
> --- a/arch/s390/mm/mmap.c
> +++ b/arch/s390/mm/mmap.c
> @@ -63,11 +63,7 @@ static inline unsigned long mmap_base(unsigned long rnd,
>  	 */
>  	gap_min = SZ_128M;
>  	gap_max = (STACK_TOP / 6) * 5;
> -
> -	if (gap < gap_min)
> -		gap = gap_min;
> -	else if (gap > gap_max)
> -		gap = gap_max;
> +	gap = clamp(gap, gap_min, gap_max);
>  
>  	return PAGE_ALIGN(STACK_TOP - gap - rnd);
>  }

Whenever possible I personally prefer branches over ternary operators.
But if one wants to clump it in one line, then gap_min and gap_max
are also redundant.

Thanks!
