Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE09424D70;
	Mon, 20 Jul 2026 13:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784553747; cv=none; b=Jw/k689Xsm7w1lCJT8Sh8v/lvOhA+7Euj142WSneStxcyIvlvj3ByBp8a7yufOmB853U5Bb+c+mY+ISflsRXjaCcqAFXoZaVgCarO1EjdcSvvm9uTHSEFkhhsI7FwrH0Z4YS5mSWIvPL6SGFE5FmPo/d5sxWU04ucSn/zI43hoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784553747; c=relaxed/simple;
	bh=EAHaDOllrFDsIlHFAJ8sHAebAN0CK6Dtpr4STlHhdhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jK9wIc68Z8R6coEdypce2gY9HCaiOdLlXgBgHmHJhHsveMqsNQxcIY3K02zyWEUqSVeOUo/i7AgUFZl1WhUXMyg3QAF+mddeHeMho+s+DPiGhFtU0CbnrigKSIIBXkEXNUbbv7iKLfYUIVNlsxKmAzzGKXd2tNgmFnIggbBU+A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i3nq5Ugi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i3nq5Ugi"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KBBtCW1936010;
	Mon, 20 Jul 2026 13:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=WXI7HBQpjge53CoNb/zHzx8sC74bUX
	GPOta0YkVJSKs=; b=i3nq5UgiCrC4x6j1oyzPaFM84vqN2EAW5otHLBk0rlm7i8
	oK6BaWkd6ZhnCR1zrn0V81wQwoPYNu2A16knCddqFWlO45QunCJd8W4nphYqsdGn
	vYnS3yLH5zWDa5T+lbz29cLiTPfmectKMgRof8mrt+U4LLLRsaAZ+0CyFDmvzG8y
	3bFYcpIM/wqaTr4fA3Y+tw7D8kcNSjWq5IdK4rBVXdtsdR2+IQiZjZmBY8vzVejR
	3icVDowLB3szxsCrThukWSCGiB39Gaw+0mg2G5H64/MWNwS7hldq3F4X7jsC2Mce
	iYIHZUnquhNqdto6OhPsiswZfs9N66QD/DudqPCA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78fyc9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 13:22:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KDJa7b005258;
	Mon, 20 Jul 2026 13:22:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtjnrja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 13:22:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KDMKmx39387574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 13:22:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B7DB2004B;
	Mon, 20 Jul 2026 13:22:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8AF020040;
	Mon, 20 Jul 2026 13:22:19 +0000 (GMT)
Received: from localhost (unknown [9.87.154.205])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 20 Jul 2026 13:22:19 +0000 (GMT)
Date: Mon, 20 Jul 2026 15:22:18 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v2 0/2] s390/vdso: Fix GNU_EH_FRAME PHDR
Message-ID: <ttih6h6@ub.hpns>
References: <20260713144231.1251145-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260713144231.1251145-1-jremus@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE0NyBTYWx0ZWRfX+4z/9i5BdTpb
 4U8CQP4DnT6q5j1PXilLuA8k7hVDie4NCMc0r7g5IUBlxwv0FQz2NY/RrGp/nQ+OzeziAptVSlt
 8yQqSkLkWfO70ueNSyNJ+96t5NEKuWAakHb/7Hefht5WBuIQxROnczEefgMK49adO6pt7pjKWNg
 Zeqn6Qm+OsJv2LLtoBkk2t6wjpSvNqG/VP8SPCsAU4L55na9cONYUcodUKdUdw32anic0BbI6/d
 zJt4DU55XjKErhYc/f3wKjd16uQOlgX/V6Iz/8eWBrJSrwlEg6N4bQbLsScHBqwwcXtH0xB9vFJ
 5fQQX1GHIWM5rO0TEfTbfsJUvr9DvmGfuz9rJ8AYM6rjxTIKxoN+fDX+b02ru1xP0nBN1QvFKCk
 y52GF3BgSI1ryDA9auKnZAAmp5dGmHRAn1uySpXxKmo7983GGXIZS+gMZ+ElpTJoFyMwwizmqje
 EHRHdLnR1GPSGJ8I+vA==
X-Proofpoint-GUID: qRQHIfyJNhqsPKLRHdIuJ4n-BanoK2fr
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5e2110 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=IByosa0Zpxt-sA0yv74A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE0NyBTYWx0ZWRfX5ZTLbsvUg0pn
 +koXCAvT0fC2YWNPP9zqipilF1973HLkRQcIuYbakn73/E6rQn0z/H+o0CWq01GsV9BkC8HqurZ
 kU1JFhCIuo89duniKYCLqRasRXRWbVM=
X-Proofpoint-ORIG-GUID: qRQHIfyJNhqsPKLRHdIuJ4n-BanoK2fr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200147

On Mon, Jul 13, 2026 at 04:42:29PM +0200, Jens Remus wrote:
> Patch 2 uses symbolic constants for the PHDR permission flags to improve
> readability and explicitly specifies the GNU_EH_FRAME PHDR to be read-
> only.
> 
> Changes to v2:
> - Address review feedback.
> 
> Regards,
> Jens
> 
> 
> Jens Remus (2):
>   s390/vdso: Pass --eh-frame-hdr to the linker
>   s390/vdso: Use symbolic constants for the PHDR permission flags
> 
>  arch/s390/kernel/vdso/Makefile   |  3 ++-
>  arch/s390/kernel/vdso/vdso.lds.S | 11 +++++++----
>  2 files changed, 9 insertions(+), 5 deletions(-)

Applied, thank you!
