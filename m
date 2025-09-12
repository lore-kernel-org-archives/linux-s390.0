Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79172FE59D;
	Fri, 12 Sep 2025 11:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757675191; cv=none; b=MQ+HX9muSTzFwwp3shC00bm+HkqpcMnuPASUkHOC2Uu4xxy/KhoF0dzzLWN+TS9BM2ips0zQnjb/KiiuP/vjZxpVvB2OCtkLqP2DXZcpGpTTN+Ccnwx4w/S/3nhJvdpgl31FMAzz40e96XjkdSEcKn+UW4HubgVSWP/hbgWwod0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757675191; c=relaxed/simple;
	bh=Kj7b39EwGXIMsVqckuF6i0A+l8QuRq3Kd6OJ3M/gwR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5Wt4N3fUmO8ZcEOBMltjEd7PqXFuWmeItJL0sdF0BBRyS/+WRBE14A1fPXn1zUnRgwarBGugX7xWnSDNLn65sFEOIGC7s6zmWJEPnGLaX943p5nv33kxVnQlQC+k3H4FgLagJGRSp2lKQLJaB1kV3oqzhRKuPOHSHkbYt2LIdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n1hswEG8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n1hswEG8"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1frDr028317;
	Fri, 12 Sep 2025 11:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=GQH4DDcdoUyhWWmYT6poEuJ3xZ/fw2
	tHlDG8m8Y1vkQ=; b=n1hswEG8hN/oiaCxV1TYt+dMth7V7f2pHslkTMslcZQ1fP
	wNbVGMOHF5wrVWc7n4JGmZjUnRRBpD8JZ5476xaj3Rc4c/rPudtg8LcK+qXxq1pv
	6IuE3VEXBFrdVlvs8jsTDY4JFXTBv+bvz0UetsWrpuGb+J5LPCyqwKLu+aqCW5kq
	T+6XlqIKVvEyVQJxJOj2LrJV5tKxq1YlDXVT0QpqvDqiGncc+TVfVH/14XV2LMgx
	J4O/aW9iavJqRH54/EOh2kvbafM7gQNPaIeFKmXNFKF+mSzp7J+9U5NG0zAel6Os
	y1XxHi3GDiJrLrTEz9G45trylZ52PGPsG/gv1Dfw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmxb2ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 11:06:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58CANOw8010605;
	Fri, 12 Sep 2025 11:06:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4910snaj96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 11:06:25 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58CB6Lkt45089100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 11:06:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DEDD2004D;
	Fri, 12 Sep 2025 11:06:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F5612004B;
	Fri, 12 Sep 2025 11:06:21 +0000 (GMT)
Received: from osiris (unknown [9.111.34.207])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 12 Sep 2025 11:06:20 +0000 (GMT)
Date: Fri, 12 Sep 2025 13:06:19 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/hypfs_sprp: Replace kzalloc() + copy_from_user()
 with memdup_user()
Message-ID: <20250912110619.10147C7e-hca@linux.ibm.com>
References: <20250911214539.1483234-2-thorsten.blum@linux.dev>
 <20250912095620.10147A01-hca@linux.ibm.com>
 <D56B6A09-8633-402D-A942-1C24AE465AC8@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D56B6A09-8633-402D-A942-1C24AE465AC8@linux.dev>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7aPxp19Xt2xJ32tiIDQc1kBen2GqYg3S
X-Proofpoint-ORIG-GUID: 7aPxp19Xt2xJ32tiIDQc1kBen2GqYg3S
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68c3feb2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=9SSZd2EgCJoyoMjWAIwA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfX9xQXovjQFop/
 2jXYo29v3wKEjxLXMVY05gvxCxCmZmd9gfr89Exx1Z3XW83hBJMwh9jPPdDw6zloLd3lrepMDUV
 9/OLVQeAV/4b7+KYOl+upk0pXNEh9VqMPDvHYwpRjSZm8xoRL7qVq8h59sJuLITHez43z3OZyWx
 hBS85AJaB+goGwhmETFSvrvYILc9k/2/E19MaNFRnJoP1hMUzL/96mVUTWlUshjUkk/gVy7eGYs
 hSPePomh9vPH1bk+47FBaXJOxrZs4ZTAX5mTdFqzJRnh6BhUtwQsvW76+XI+PwVnYvrFCwUtleJ
 lj6GhSRY1iis0B27sXpJ2ZTeBglSnfjDIJlSDWfmyu6bZp+8XGScwrBw8gr03vmuLDA/cSwepQu
 Hk6ql/VD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025

On Fri, Sep 12, 2025 at 12:09:43PM +0200, Thorsten Blum wrote:
> On 12. Sep 2025, at 11:56, Heiko Carstens wrote:
> > This is not an improvement and also incorrect, since kfree() may now
> > be called with an error pointer.
> 
> Unless I'm missing something, kfree() works just fine with error
> pointers. See linux/slab.h:
> 
> DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))

This is for automatically freed memory, but not for the generic case.
See cd7eb8f83fcf ("mm/slab: make __free(kfree) accept error pointers").
