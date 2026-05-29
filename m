Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACB13C5DD4
	for <linux-s390@vger.kernel.org>; Fri, 29 May 2026 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050416; cv=none; b=uPHNreSUIdoxEYx8ABewtZjXRIKs7ng8hreFxbCZRn98cPysu+6pnFb0SYVfzdHGSI1/gQNlE+P0nvO3x0GO9mdrtKbQkDJH6cZNSNkt+eOSVyw35YfG3VzHljTXmAmWt8/DxGSH46KY4DqIegUMPbO34Z7/OJ+hVrBhVHbvx/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050416; c=relaxed/simple;
	bh=p8PdzQ90+HaTrHjN8nIvzsXiBWREa8J1MbYpI3g9sZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czRpMaOOshzbirFvwGOzEXxQjGtNNt6rn50eeJDaZAbXJqS93B4n1v/7CaQQs4P/BKria4bScVPbjxHpCB0VCxJEoDEHbMocx4MNd+rJokkRf60DLilr3PR/8+yvoZ+a2KYDyHbfFbkXcQBi2WylW8Pr0RIxNCUim89aqYRo1EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZUg8Yndx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZUg8Yndx"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SLlh1G1467798;
	Fri, 29 May 2026 10:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=1gwdTXTvNTAhmdpCaJLk63p/3Vw+iy
	2C1u6o5AH7O3s=; b=ZUg8YndxUSzrjT6jki+DbxImmjpS98ROfV2VaCd8nQHOOY
	r8aWK17koyPB+F4D8mHL3uemKAP93qhSetIcBM0+zqDoAjJiH5ACbkr8s6kmHAfI
	YItWVdvCLYTc63bfZ7VEfcPDkqjkTD+qQk1MRftU/v0kqIDR5q0BjSEvfHfSG8/r
	iHBnmUEbLda0YgpIjjEXxask3Y6f7h+FoA8ahNZbxfbjc6zJ+W9/Naf8ljiFLGKO
	RI8IZWbdXkSayS1VNH4TOhyWRKwZ+qwxvbNBnqLSl+IpbvGa1mGwna5QE2P2i75I
	z74P3tA4koLpqeGv+1HFkLKYbdPSNZPA8/Q+2pTQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee886g3de-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 10:26:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TAO70J020422;
	Fri, 29 May 2026 10:26:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbd49r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 10:26:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TAQlAR51708374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 10:26:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E9BD20067;
	Fri, 29 May 2026 10:26:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80DC220043;
	Fri, 29 May 2026 10:26:46 +0000 (GMT)
Received: from osiris (unknown [9.111.13.205])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 29 May 2026 10:26:46 +0000 (GMT)
Date: Fri, 29 May 2026 12:26:45 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/6] s390/con3270: replace __get_free_page() with
 kmalloc()
Message-ID: <20260529102645.26496Dfb-hca@linux.ibm.com>
References: <20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org>
 <20260528-b4-s390-drivers-v1-1-b7108f54d722@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528-b4-s390-drivers-v1-1-b7108f54d722@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qEmD8RvslV-LYMzdUI0RGck9j4G41L4_
X-Authority-Analysis: v=2.4 cv=Z8Dc2nRA c=1 sm=1 tr=0 ts=6a1969eb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=kt7I_EveaTZZBW9BUTwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEwMCBTYWx0ZWRfX1wQsn+4ugKCz
 WzIq0BD0UYAby0+ZaXZU9+2IIUQBSl88Qu0spozm4a8ojq/bNR4Jr9Dj2N4ahbneyDQnot0o7nd
 WOhnPQ4mvmPRmAJdt6s8WAzhIWwVl/LY8zK9qpzsoZ2YMmoQ7aHPkFHugb25++cZh06s+5tX/p5
 eIkwJVJDSHcRh9TQu0junrcbLI3H2MVjgm/HDtLDs3J06P9oQvtSjX1kXq5FEAoANYS4fWZVfUA
 pjgEInWPtHP376gN8eaJ/Qj4gSth7NdXcsjSD1mXggTI7UruZ4cOzTqLLI3Tnm8uG1gR8x4f8ZY
 U4xZYExkCpgI5EsD1deJ2svgTh5Lmj9e4ppQnSjp0h3VS9BRDZDfG9gB7gh3Igrnhep1nVS3SeX
 z/sajWeSxfPNHDWGsVyV8Bj2mPiaA4hyNE+xvln1jvnxAHhJW8srNljii00OFnrqXwnJvRUqzSA
 1vdMgQKoXuystMt85dg==
X-Proofpoint-ORIG-GUID: qEmD8RvslV-LYMzdUI0RGck9j4G41L4_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290100

On Thu, May 28, 2026 at 10:09:49AM +0300, Mike Rapoport (Microsoft) wrote:
> con3270_alloc_view() allocates a staging buffer used to assemble
> 3270 datastream content before it is copied into channel program
> requests.
> 
> This buffer can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
> 
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
> 
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
> 
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
> 
> Replace use of __get_free_page() with kmalloc() and free_page() with
> kfree().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  drivers/s390/char/con3270.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
