Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682BC253B51;
	Fri, 14 Feb 2025 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739527379; cv=none; b=XaIYIuNNnJygFUmbA6ky3U74zlJvqw18vEF1gYgVMtIUbuVn+YT5TyRTMocSgIymUZWqEQI95Ws6oJ5OA1WJd6QDb2fvEe1UTp0lvIuHImoDebeu76Oj6S693UfUyFQ3Oz+ROW27YJfrVp7hrkG0iIn/qrRpDBzSmWnhQJlrIWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739527379; c=relaxed/simple;
	bh=+IjmgDqeVgSyvVDQ9e6EOVq4U2JIS3lAvxc1XVEMgVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzOEsfbRHL6Mec1UgPd9PDwKtz3sbMDbUpGauq8muCgiHVSZ+3fMy6uXhK+pi5SfqNjQ+k7EMSJQA6UdDoSiSJdJA66emE6V3PyOVLlRtWb9Uf2E6WUnTtq+bQKHQdyO1ljUXtuQ+Xt7HeQikg1DALFQy+pSR4nNrpeFAfZX+P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CVwsWe5H; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CVwsWe5H"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E2nlN8016442;
	Fri, 14 Feb 2025 10:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ra/Dx+WxOY1D7TZc+vQhA7pPWzHT7U
	ffFBZk9LGvtVs=; b=CVwsWe5HmaN7MxHB6a/tRHrUZYu4sxkab46TGw25hnKi9S
	rhNByw8aqMUcqYBu+5A279T84f2ec5gz+fRSpKlLtRCJ/mRedvbJIptA0yhOu2lP
	COoIB4iEP7P+GXGxG8m2N0CHDf1V8R0ejCOvIUUu62H+IufSPlhU6RV4Iw3NaOgg
	uy0yWLoMR8nJGrBpq6xTXvAyKsQndYhcAuMrHPITKcgTRQ6akqrhGnwg+ma+FzXO
	jCRvxMzKueF1Q7oHRt+mSPlduEdC3ch3jxbODQj0MmAJkro7xGiv6ZP8n8F/c4fI
	4nTfJI8xKT3sY+bpQw4Y0+7Q1tFNwkXhGUCRy8ug==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44skjuvk3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 10:02:41 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51E9xeF9031418;
	Fri, 14 Feb 2025 10:02:41 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44skjuvk3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 10:02:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51E7IJup001051;
	Fri, 14 Feb 2025 10:02:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44pjknk0ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 10:02:40 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51EA2a9a55378420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 10:02:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71A6F2005A;
	Fri, 14 Feb 2025 10:02:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48BF920063;
	Fri, 14 Feb 2025 10:02:35 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.2.165])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 14 Feb 2025 10:02:35 +0000 (GMT)
Date: Fri, 14 Feb 2025 11:02:33 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Frank van der Linden <fvdl@google.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yuzhao@google.com,
        usamaarif642@gmail.com, joao.m.martins@oracle.com,
        roman.gushchin@linux.dev, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 03/28] mm/cma: introduce cma_intersects function
Message-ID: <Z68UuZQJs6dpuHC8@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250206185109.1210657-1-fvdl@google.com>
 <20250206185109.1210657-4-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206185109.1210657-4-fvdl@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: t-In3U_tmNjyWhY_yTRmtH3LI7-89WMB
X-Proofpoint-ORIG-GUID: SYQ8donj5--N2ryoZQafKeRuOJfV_YtY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 mlxlogscore=501 lowpriorityscore=0 mlxscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502140067

On Thu, Feb 06, 2025 at 06:50:43PM +0000, Frank van der Linden wrote:
> Now that CMA areas can have multiple physical ranges,
> code can't assume a CMA struct represents a base_pfn
> plus a size, as returned from cma_get_base.
> 
> Most cases are ok though, since they all explicitly
> refer to CMA areas that were created using existing
> interfaces (cma_declare_contiguous_nid or
> cma_init_reserved_mem), which guarantees they have just
> one physical range.
> 
> An exception is the s390 code, which walks all CMA
> ranges to see if they intersect with a range of memory
> that is about to be hotremoved. So, in the future,
> it might run in to multi-range areas. To keep this check
> working, define a cma_intersects function. This just checks
> if a physaddr range intersects any of the ranges.
> Use it in the s390 check.
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Frank van der Linden <fvdl@google.com>
> ---
>  arch/s390/mm/init.c | 13 +++++--------
>  include/linux/cma.h |  1 +
>  mm/cma.c            | 21 +++++++++++++++++++++
>  3 files changed, 27 insertions(+), 8 deletions(-)

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
