Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C7C30CDB1;
	Thu, 18 Sep 2025 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205172; cv=none; b=Xbcll48xBZO3ObiRMN7aqGKujtLLJ5aKj7f6W8kRriPC9/RTQkyswbjVxd+fpxDMdjsRZJQbjt2NXzC7C1nqFGN7SETnMaMxiQhfc5Z3r/N9CVysgzX2PamEkjEd9R3GGYcXayQia6nTjf5ruIWKD2XMO+TOGBBVixBZgL+XUeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205172; c=relaxed/simple;
	bh=ZaQal7p/D3lVjO56/+eFW4knjRvXXBe2Az2adf7o3pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1HyJjJJssgKoKovf2K8npUHQxX5lpz24LbCJ/7UCkEnsD+ash1TLQHwzAvVwWxjfxtzNhDwSAicV3XxWML6Eqbuu+Fmx9u5+686U9c9C+GZAly0CPgfMn13oD9+a8u0+J7mafeQRjBKH29i55y7mr73rpR5JKoUDzc5+f2peYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mDSdxegK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mDSdxegK"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ICVv4D000437;
	Thu, 18 Sep 2025 14:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=DprqDoKslhG2Vxphcet3gBW4by2OCt
	LD3p/0yuyogXk=; b=mDSdxegKalYo9emM9i9PNcujkOp4bHhQQxnqmYzRU/Yow2
	DaL4TDZKRLmyCmFQ9g0/bFGVN8WX2b3ADBNLDJkEgaqm+kj6wyRSPyGo4dXS956N
	jpjaLGrByxzCqoPPl+5uhOOVkWKFrMkhdWmAg6ZA0fIjh/kmMqWRkoto7U7OpDgW
	O/JKMntjYOJQK36M5m/O3gmj1j0Y2sh/uhTnRoy4HNagVyrK5hkkFdrYVatY4Zv6
	yGvvt/oCaypxWzqb61hdfxLdd/scx56cn/Iitw1cHpCLjb64OVhf55jL68HGLnGV
	2Tq419jPZLwKFemA6msNW196e7rYTUwqwdO5k0wQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4htree-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 14:19:28 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58IEEROu005978;
	Thu, 18 Sep 2025 14:19:28 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4htreb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 14:19:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58IB2OjR019200;
	Thu, 18 Sep 2025 14:19:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mpt6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 14:19:27 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58IEJNT741419068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 14:19:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1FCB20043;
	Thu, 18 Sep 2025 14:19:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BCF320040;
	Thu, 18 Sep 2025 14:19:23 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Sep 2025 14:19:23 +0000 (GMT)
Date: Thu, 18 Sep 2025 16:19:22 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <kees@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH v2 0/4] s390: Fix and optimize __flogr() inline assembly
Message-ID: <c38409b1-fa4e-4fa6-94a8-51616bf1fd6a-agordeev@linux.ibm.com>
References: <20250916134803.874580-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916134803.874580-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6N_hs30sEL_CvWtwubb2zil0yj7Y07Oh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX6qmWAPCuYGjR
 LulzjsIPBdnSu3dK9rer8sWqsXlBsQSR3EUbqtv6eni4ana3CZDTcbqxqlAlkyJ+vs3exFoOpkO
 FuFTb57yI265e/rDDyI6ukJM2Kp4aJwWOII4rzXDamos5QqabBRcMI5xnB4hnLf0BRVojXdKiJB
 m+LEYYnlQR87xf7S3xXOE7TP9M4fDF4rD2uMk85hglFxet1ZUlz/QmCXR6QsPPN72h9nQq25pOI
 hzgxcXwAt6SoyYGE0q91VkL8yRhfZ9NCH31SvZXbBfgfSrc0wF/95UqKYHJRRxWYgQDu7R/2ksf
 y+E5IHOGVI7Cf+fZPduz/VuX6zyn24JVghUe7QynV1SnESpk5kRTlNMMxazEh1nTFNKm9f3L0MW
 hK4ZHtxC
X-Proofpoint-GUID: eT4eKIyRBDCi3yCkmH9GexjPMpYsHkAP
X-Authority-Analysis: v=2.4 cv=co2bk04i c=1 sm=1 tr=0 ts=68cc14f0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=9osAhOkfvIjfBw3QZZoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160204

On Tue, Sep 16, 2025 at 03:47:59PM +0200, Heiko Carstens wrote:
> A recent optimization of the s390 specific ffs() and ffs64()
> implementations leads to a new compiler warning. Instead of reverting the
> optimization address this with the rather new assume attribute, which
> generates even better code, if supported by compilers.
> 
> Since the assume attribute may be useful for others as well, add the
> __assume macro to compiler attributes, so it is kernel wide available,
> instead of adding an s390 specific optimization.
> 
> Heiko Carstens (4):
>   s390/bitops: Limit return value range of __flogr()
>   compiler_types: Add __assume macro
>   s390/bitops: Use __assume() for __flogr() inline assembly return value
>   s390/bitops: Cleanup __flogr()
> 
>  arch/s390/include/asm/bitops.h | 21 ++++++++++++++-------
>  include/linux/compiler_types.h | 23 +++++++++++++++++++++++
>  init/Kconfig                   | 10 ++++++++++
>  3 files changed, 47 insertions(+), 7 deletions(-)

Applied, thanks!
