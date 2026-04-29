Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1A31448D5;
	Wed, 29 Apr 2026 05:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777439858; cv=none; b=jDAfmcnwc6tkLcMnaQrcSOjrPdSQHoqrerlmPnoxNlETWxt2R1y/h9tTR6TM2r2QYc710+QCs5hpEfGiNXuEFs2PbYpqw2sxLJMO4iTGuFY5IO6/Zp+LfOJnH+EvsGQa1xN+pCH3S65qmxm5pN/H/0KEdYKKlehcIkWcf3Lcm6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777439858; c=relaxed/simple;
	bh=XSb8R4GznxdCovB/JoSymNXrKS6eouT+YDdKvqxnik0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8OTwO5Fu1TsA5I7DrlKAicCQAwMHZppIrTm4zRgrRflxQro+lwd+DbncvPoh+TQDemm0l/7RVljhHZFjxEkfkzL1/ddFOtSJ3zpTCZqo/CnOIIeBgNP+AtSbIim+Xs0kokc8ylWNr6FOFei0yWnkY3CcFc/P2SLDV1yak892sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iIH/qVre; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iIH/qVre"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SIQPfu2931477;
	Wed, 29 Apr 2026 05:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=UUspB+lESn2oCZh2aN+BsumVLW77Nc
	gq+i+bTh0emak=; b=iIH/qVreUHXN8uZfx1p5v+TpkbgQHBSDwvKO4dO2Ojp3rA
	bPdGOP8eFXpmv/xpW/nidEgNIOHX+0RaAW7W4hSYEc4pKouvtIUHCTB4mUCe/2vX
	56t6cBFqukAQyLwUiyugHpd0zJ82i9wxVWtLAcQnTv8yzXgX6XRyZ3edWj6XsqAC
	E6XdKj9VdNgadncX4f/E1cSNfa0752iSp5jO+Xi4yzs44qxvaFmPvpMNtcQgV3VL
	l7KE+or5wxAXC9TgPNAH5oMLv1qz2hOFF8hWDtdkxqM4wEp6TYO54P1iOmnHtKwO
	lBNiJXIyTfJGgC7OEw0Sc3VNTRdD2cXlWI12OsaQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44ry9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 05:17:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63T58k7H019335;
	Wed, 29 Apr 2026 05:17:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xk4xjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 05:17:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63T5HGeF31261020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 05:17:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFEDF2004F;
	Wed, 29 Apr 2026 05:17:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F11D2004B;
	Wed, 29 Apr 2026 05:17:16 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.87.137.131])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Apr 2026 05:17:16 +0000 (GMT)
Date: Wed, 29 Apr 2026 07:17:14 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2] mm/gup: cleanup pgtable entry accessors
Message-ID: <3faf45f0-30f5-4a11-850e-3e5ed7668c72-agordeev@linux.ibm.com>
References: <20260421051754.1691221-1-agordeev@linux.ibm.com>
 <5f45cc59-d71f-409c-8cfb-6eba23b0a447@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f45cc59-d71f-409c-8cfb-6eba23b0a447@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -jsekM2twbOwTE1FFA270frnhpVV5cIB
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f19461 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=MZt8_KVsnJdHBUldAIAA:9
 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: -jsekM2twbOwTE1FFA270frnhpVV5cIB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA0MyBTYWx0ZWRfX7t7mFOM7Kse7
 YWScEjxMJiIMja7fgwtbQizA1HCX1GaR+8WaaDtXna1NOxK4feoijHVQSB4cQpi1V2q4tb7BoKZ
 HBQvwT3gSIEWVHiklMC0/2BgRSBBpBoY/jQR9XktMnm93Qd4Tj+okplZ0rssJZ8/jqFeviPBSfv
 j66Z/IQDGjJYAONW7P5NH9QyCo12BzhKLVeDIl1NsqyRv6IUJKY4W+tvI7r1i4xzXujsiCd7i+B
 V+2lFXo0PGzzSGauGGoU+8zum1aY23qBZtNgWSVRWjwqTT+i6agPKYoGJrE+C7EFJVqlTO91C4F
 6jBTGzf4vWvy2rrU2uZ6NM61W8UwsUCezdEPVpOPGTSkPdBvp7zX76OfdizJQ8vTrx8b5s6FCBC
 ioH4adaBJTgGsbqaRkl3K9qqFcvyX6qAQJL3ES3IZrzy4bjKv8y7W5sCJaiwJo/enasbGsMrFbh
 amK1KYxC4BgIeXrlUDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290043

On Tue, Apr 28, 2026 at 09:45:59PM +0200, David Hildenbrand (Arm) wrote:
> In general, LGTM.
> 
> I do wonder, though, if we want to switch to pte_same/pmd_same/pud_same while at it?

I thought about that too, but decided to keep it focused on direct
dereferences (as it fixes a real issue with the pte kasan sanitizer).

I can send updated patch or a follow-up patch - as you prefer. But
if you like the follow-up I would suggest to un-squash the original
series to get it in three logical steps: 1 - pXdp_get() fix, 2 -
lockless access fix, 3 - pXd_same() cleanup.

> -- 
> Cheers,
> 
> David

Thanks!
