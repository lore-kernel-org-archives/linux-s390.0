Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214AE20DD72;
	Thu, 13 Feb 2025 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441486; cv=none; b=TO+YJ1U8x1bHXNxQiTCIylk07eQvlnqLql5pNn5Qs1deJr/VWLowG36YyiJIJfWzK5ygbsAKlrBza+vGF/eL6YIwFR5ZhFf8zhqWmzYuhER04sXmSZJOs7Xxlt9ciMrhCWyeYU4i1aCE+c5yM7lnseQWcxZGVSxln/HRQBkbgt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441486; c=relaxed/simple;
	bh=M+w9kabOMahmG52D1RxSaUfG2yewgL3Ce6/3SZBF4P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqRwQgocvQYIaRFbo98SC2mGxNVibBVOlgeu2BH8Pmu1zBTfD2memJcm+o9g8BuCJ6lRd6f6XbYB5VaQ7uQ8ilN5TEyzX+EWKTWlqvxHtuL9vF9injUrWQA5ls8Kf7PzXV+iOiz02bhgcoZJ8kCrjqxUnf1YDAs1q/eBE+P2Bl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QZaxwkOd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QZaxwkOd"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D9muVw015181;
	Thu, 13 Feb 2025 10:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=U74TuyLY5AFY92KaNCGYKAz8R/LTgs
	X6KqtfSKDyU1o=; b=QZaxwkOdw85j9Se0f9lFoCNeL1+646+DW0iQ9bHd+2mPPY
	vWqtGD5BwxqpUxMC3zkNQG6+jdpgq0sEH4netftKyNmLYF0AqjSGG8qSZ1uAFMTf
	yYXJ5vd/nCGKCSPisjrpkrFa0t2CwNoxqPFCh7cV7LL5zruKqtMA4JsEmSnKfsRY
	VTrm8bvV8FxOrbK2QH9DJayp8jbFWDM0VNbQomc6h+4HG9plUjyeurYGWWSbm1tE
	bfk5w58yHm3q+rgUy2LAQrlvjBR3KWyb4ONn6eNv8aFpEN6WObqjisa6wVZUQEd7
	CIOdoMIDAihTrxKz55PhvnQ4yqut5eE0CtRRkelw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44rxfu4u9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 10:11:10 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51DABAlR007340;
	Thu, 13 Feb 2025 10:11:10 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44rxfu4u99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 10:11:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51D7LWPQ001358;
	Thu, 13 Feb 2025 10:11:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44pjkndpd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 10:11:09 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51DAB5CT29753996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 10:11:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B348E2004E;
	Thu, 13 Feb 2025 10:11:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA4E820065;
	Thu, 13 Feb 2025 10:11:04 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.6.230])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 13 Feb 2025 10:11:04 +0000 (GMT)
Date: Thu, 13 Feb 2025 11:11:03 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Frank van der Linden <fvdl@google.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yuzhao@google.com,
        usamaarif642@gmail.com, joao.m.martins@oracle.com,
        roman.gushchin@linux.dev, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 03/28] mm/cma: introduce cma_intersects function
Message-ID: <Z63FN1+f+Ca2owdm@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250129224157.2046079-1-fvdl@google.com>
 <20250129224157.2046079-4-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129224157.2046079-4-fvdl@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4-Nzm_kfKbiYH4HhdkDWG-rtcGAVd8YX
X-Proofpoint-GUID: Vzn0MMqmK8Lalyo1VKVejFWob49y7KWE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 clxscore=1011 adultscore=0 mlxlogscore=491 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130076

On Wed, Jan 29, 2025 at 10:41:32PM +0000, Frank van der Linden wrote:
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
