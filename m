Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4026C459AE4
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791299628; cv=none; b=UMFcTlSS7NeAgQzmms0Sa7+sMbOceYISUTP32nE0UoNvdHj7TMts7jj5zr0/8ISzdh4Ayo42Rm49Jlud/SYBm+3fVxY2phueMA2fS6aJGYgYezKsBSLTHcTgeJEDNPOgKqJwCC7dts1CryMhWWlVkCRyD6jcCzhh0zUI9UfQsVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791299628; c=relaxed/simple;
	bh=TPKZ3IO+ddTdDlnJhNz8j6mBOZ5k30nPXF0YEJ/V60I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oioor4B9rrjJX6kkU6EYVhN8ETvBUgOQDQ86ZhEJazFoSy8e5+iFtZKWZzc2zXTcIZyAF5vyFJtG2hvyP72nNVga7lc8BrHZpc+24w+Jgk/bZOtVwy7fTdIz8KKOO/y4D9HvUEHHPn7C9d8iNrZlAErDjf+HuzGuwya4e+AtN6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iXMiRbiX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iXMiRbiX"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696EZMux4058912
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 15:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=O0o+WGe8S9VDZh+4tk9W7a+AabPXyx
	+1SYwDLf0Kfkw=; b=iXMiRbiX5ovRKxz9A0EXm5f2i0nNZ93chfbGMGySHhBTW9
	eu9D3YUl0XzjuyyHvBYNZNyHd0g4pHEGc8kV27DPLzQDzotv4rtKNfI56NUe90pv
	kiP56LWF3G2D2GKTJ6HJ2Qs2yj488IyCdLp4WFFJm/3mIMDbNEYVPWRCMnJ5muj1
	A9GKA+4OqaYAMfkRjq04cFZdzkt236gb2ZfpgzCe0YbPj3L0+A+uu39dAd7fiGTS
	ZwOyxGvRUlsWJvfB0UW8Ykw1MNLwUICvTFrw+TMldwqNB9gOcHKWJ5R/omSb8SmT
	Mejb8BHUQkJKFD29O/2NJqyNFAaJih6V75xFHnDg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74rstx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 15:13:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696EHUXJ424967
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 15:13:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqya7bs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 15:13:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696FDXSa32309600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 15:13:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DCB22004D;
	Tue,  6 Oct 2026 15:13:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 118A42004B;
	Tue,  6 Oct 2026 15:13:33 +0000 (GMT)
Received: from osiris (unknown [9.111.2.28])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  6 Oct 2026 15:13:32 +0000 (GMT)
Date: Tue, 6 Oct 2026 17:13:31 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, fcallies@linux.ibm.com, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v1 1/2] s390/cpacf: Rework cpacf_kma() to return
 condition code
Message-ID: <20261006151331.17402G1c-hca@linux.ibm.com>
References: <20261005141417.65822-1-freude@linux.ibm.com>
 <20261005141417.65822-2-freude@linux.ibm.com>
 <20261006083029.17402Acd-hca@linux.ibm.com>
 <137730ff3385fca1febcab3006c17584@linux.ibm.com>
 <20261006133931.17402Ee9-hca@linux.ibm.com>
 <48014bf5d6cff03b25de57bb6474e71e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48014bf5d6cff03b25de57bb6474e71e@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: p-bupSLwUFGH2iPSGHo-5brsN4BbKB77
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA2MCBTYWx0ZWRfXyPzvTUTygy3L
 Wz5056Pu8aF0BbYHri8CvsiCubmkSIMT0Zf9beYuErURpI5x/0U61YhkmpgJuL3Mjmuo72L0A6x
 eDDHhr3Tjqp45i2KdzzPZ92++ZS9xBk=
X-Proofpoint-GUID: p-bupSLwUFGH2iPSGHo-5brsN4BbKB77
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA2MCBTYWx0ZWRfX0Piy+AoAMVMi
 p8qxTnhjX/RdKWqQPDVO5Fh7XL2j2xPdmgrt/XyRiLyFtS/k8/jZvkG6SjdHBEVxOi6elINLZaY
 e5H1YUgPPTrmcUPwkwB2tdvEb6CPuHBJvyibQoxjHb/L7VoBiAidGZ/zy0kvkHTYSAr90YRhNQ3
 Rr19Kv//MuWF/ErN08oc88xsCYMXgQedHkl1NM5YnwdGDlzCuG3ReantS79Rj6dYU1Y15uDq2gz
 l2RZXKRNa25fZvOiTd7UJNbEJx/5+yxVLKiptM8ndflkYR4bnrzlGl32tzgAgJ4FXqybst9hz6k
 SszMCd6bFM9rz8mCFw98JRwVka9sGFeABJOO863TYik0W6Fu3ghRNI0D5Mg+yWnSq9FUcNUzUAl
 zEDGOd7DrO2dg791QVdeOD9VhduqVjRYSOXoNoSjNIjc4TTP0SLceETZa3mh9kVQq/6Tb8J3X8R
 MFIJzLkPBe0p83PrAlQ==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac51029 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=YcnuCH3AGjEtxYgH6zsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060060

On Tue, Oct 06, 2026 at 04:16:42PM +0200, Harald Freudenberger wrote:
> On 2026-10-06 15:39, Heiko Carstens wrote:
> > It would be helpful if you would add information like that in the
> > cover-letter. This saves both of us a bit of time.
> 
> Ok - will do. I avoided to have direct address people in the cover letter.
> But when you are ok with that, let's run it that way next time.

Sure. Just write what you expect from whom, unless it is completely
obvious. Usually at least I apply patches if I'm on to/cc, and it is
without question code should go upstream via s390.
