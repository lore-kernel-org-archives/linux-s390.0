Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA943D903B;
	Tue, 21 Apr 2026 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781573; cv=none; b=uCM59jpji+isreqjV87yChkVrTdpQ6ODRbt3UEWCyi9gSIUwjIISQCHWQ8IBLum6Gj9Q+8UQKFy4r5nn1MgU0oP78sz/bCd6YT8qG257FBGB022VpnDzDfPy3eoWlP2BKrcypdr8ex+eABfRgcr4IWofs6RIelZt3bqHxihkO94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781573; c=relaxed/simple;
	bh=mG3rBPaJJB8o6y/abUTRFqQQiN4OrkszvG6fdH/V7gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sj/97vKWysoXQRvj7vxRbvdEmbd6WRj6hseOvHcIE+TnsiwKtnXN20z03GGBvkrQF4w971wZnQc0fduylqpUJ1yu5hFGCLOKOYR1YTlb568aO7lkMF1U6nziJj7Pf1Pu2qHysVguSj+FDjH2jnMoRNj7AIYmNsfxj/rMKdu8zi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rsmOHNUw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rsmOHNUw"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LDQ1mH1926157;
	Tue, 21 Apr 2026 14:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=2DP+/uoEmB7VI2NVLNGwr1avjO8rNu
	cbPXI3ldOUbjY=; b=rsmOHNUwrHpWnCPlkAZqCNyVi8hHOqxsGFDBHr87KVvAhk
	uNfnBUb03kHoa0+4Na5KlqQSlgZeLElnI4454clRlf9It+Lf3OPlVNoTVZfftgaL
	a7zsUlTpMdzJcF5CPb6giztkX2JnJ/Hhwh7RK07DD6b5AVZyje5BaokGdXSCKUfR
	0DCaOemzgLGbe4aMHO6SV4AvEp8Z9F/C6J8T+g8I882LCYazb7iW00aOMtP20Ozi
	lERj5T8tc7UJ9WLLWnf9pBEqK86yJYZu/ldZmnDZlLAPuKnKKarDEgTjhP1AVdFz
	t5ToEIxox6aYCvX2qEWcE6gggVT77z1kBIN9HWXQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2nf4rfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 14:26:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LEKMiW016890;
	Tue, 21 Apr 2026 14:26:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmm9q15y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 14:26:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LEPwVT49021218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 14:25:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D84020043;
	Tue, 21 Apr 2026 14:25:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2F9620040;
	Tue, 21 Apr 2026 14:25:57 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.52.215.75])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 21 Apr 2026 14:25:57 +0000 (GMT)
Date: Tue, 21 Apr 2026 16:25:56 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] mm: Make lazy MMU mode context-aware
Message-ID: <8a70c78d-36d2-4da8-9c10-e39a1f69ec2d-agordeev@linux.ibm.com>
References: <cover.1776264097.git.agordeev@linux.ibm.com>
 <8809412aaed8a515fe2e149c822543d640060936.1776264097.git.agordeev@linux.ibm.com>
 <3daccad8-cf08-4543-b9ec-b34711a4ed14@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3daccad8-cf08-4543-b9ec-b34711a4ed14@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zOGn3bc-uCXJ1VnIwroqLa9JorHBLG9F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE0MyBTYWx0ZWRfXwK3Au59d/O88
 EFPF+igDeKCgztav8Xi21cxRQbtROvMGXHbwld8sYoyG75Bv59oW854tfEGkfxvYrGwHHTAs+CY
 aWsX+5lzUAAXcJrXsVzNtipZQSDqUfT4zPfG2Wq+kD0rjBOYu3TvZqIJO2mCqBUFfKmVpHWRJM/
 MunIxDJotoO4WCF2XDohTSHsMyCkLTzLuBttGVCVdiTY81ZFKajgnwmNnT9uDWe8iNSq8fEPrFI
 RfZ/W6KliO4NMvtYCd9x7jf7bAY8ydc5uO/hcOq1+nQnhoyNNa7Ph/OIfj12tj9xqrmkyWb23DY
 M4OvGkY6wXnsbOfgKncCR4ZZuzADolUQIc29sm/QqpxYSKDyLX92kDJ8kGv2EfVlOOGV7sknNl+
 GQi5b4ELj8ejwYx5q8GKIdjYitPLgAdAVU5zmnYhHxnEKE1cNS4ry9mZIe6+9PTddyc1P+s3Jsx
 5JJ4Gr2dyCvTDw6jtmw==
X-Proofpoint-GUID: zOGn3bc-uCXJ1VnIwroqLa9JorHBLG9F
X-Authority-Analysis: v=2.4 cv=B7iJFutM c=1 sm=1 tr=0 ts=69e788fa cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=2RKckqcH8cpCXoM4mLcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210143

On Tue, Apr 21, 2026 at 04:15:44PM +0200, David Hildenbrand (Arm) wrote:
> I'm still wondering about a better name for this. "enable_for" indeed
> sounds like it's only for that range.
> 
> Maybe really something including a hint like you previously proposed
> 
> 	lazy_mmu_mode_enable_with_ptes()
> 
> 	lazy_mmu_mode_enable_with_pte_hints()
> 
> I think lazy_mmu_mode_enable_with_ptes() is neat.
> 
> Thoughts?

Works for me.

> In any case, on the general approach + semantics:
> 
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
...
> -- 
> Cheers,
> 
> David

Thanks!
