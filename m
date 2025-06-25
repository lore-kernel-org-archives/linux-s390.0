Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB9A25BF11;
	Wed, 25 Jun 2025 21:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750888246; cv=none; b=n7k7cDntJJEp1sWOzoRSoON3eDndn4uCvjofGNK+P2upvQzZytUeEsNxGRWq8WNflZwkcr3x8Z//c9nZAiKIdaMhE+Fw20mjs45mmMId9VHb2NKWOWtuVol/VVAeVxcv2DSmE2+r6tm3qGYOb5SpjVcYaFoF7w2RBD9F1BDLxok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750888246; c=relaxed/simple;
	bh=f15bvMJjHUKr1oWhItNtYOyUqyPLEvzybv2hLaqBxn8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ia1dANMzep8FRKvSYMw+eq2SkmlSVZOzU98v2/1Uq7YUhlNHHOhvu1odQLXu7MTptyB+H5xd3COv8EdSTLboaFboCEhfKU4P77rpIGcZn590uM3aPdNVm0vY1WTxCcK/sw19SX+O/Qu6Xj0t726q2lYHpdxrPknBrrpLegahTCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ITsBzgya; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ITsBzgya"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PL6vdN024856;
	Wed, 25 Jun 2025 21:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MSnpKg
	kxXepRZ5XjUnuBrBNAmAPDuZs3X7Cqt1d6wys=; b=ITsBzgyal3SSFDchigMW+I
	IK9wBz8RFyiNTa/flmSIkHBkImLHUP6teDUWLG1wyO4D8lZh+Vil0wbacffB0gyp
	J1wYWoGXod5y/R2PZfsK/8od+3plVIZQE6bTIzWpZlJFHwMz9eUkyI7quTq7ll1Q
	w9gPvxwuXjDhAtoSPmnXbXOrgAn1ZTBLFzvxivdISkE/QS8LOnuoi8BlsX/Fevvo
	8y/sPiIKQK6S2f8qD17KSBe5y6CJLlNmBc2xjKQX1IWFqcOFhzMO1oCdRGEa355N
	QFxiratZ+/AgMy1l0opmjKERgVgAQXXlLVWPNziDnU7SO7uylOGJL+CugYLD5SrQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5u23rd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 21:50:34 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55PLoYjI018410;
	Wed, 25 Jun 2025 21:50:34 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5u23r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 21:50:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55PL7OPW006414;
	Wed, 25 Jun 2025 21:50:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82pbh21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 21:50:33 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55PLoTRg46006706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 21:50:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BDBD2004B;
	Wed, 25 Jun 2025 21:50:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C34820049;
	Wed, 25 Jun 2025 21:50:28 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.111.66.135])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 25 Jun 2025 21:50:28 +0000 (GMT)
Date: Wed, 25 Jun 2025 23:50:23 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jan Karcher <jaka@linux.ibm.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Alexandra
 Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Sidraya Jayagond
 <sidraya@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        "D. Wythe"
 <alibuda@linux.alibaba.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH net] MAINTAINERS: update smc section
Message-ID: <20250625235023.2c4a3e8d.pasic@linux.ibm.com>
In-Reply-To: <20250624164406.50dd21e6@kernel.org>
References: <20250623085053.10312-1-jaka@linux.ibm.com>
	<20250624164406.50dd21e6@kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ILyUOOWGH3G2v5fzypxdm2JPCNec9Nsg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE2OCBTYWx0ZWRfXx38yk2gb/bMd zvS4OK9ZzwXihNwdSxn2gUKoMFKOA2fI01FIvrutdnxodmv8TEjvW/lNYCaD7/kLU9UXRaHg73s 5D0L7KTdq20sGpLPO0RJBTuJQwi/cvczwubQqrVTFtsWG4htIi0S+StYu36Youorp0fgUAZtdq9
 H+I/rizalnKr+AwLk68jTBhtkdlgjjlDNhKq3bmJeU+ssR83zQ5TPefiQ/oIsm/mY5wj7xKQ86N JPuPe3VMmUVCowSNUwkPovcyCeuWegZiyAoTLon0bBkdqrthlhiWjzpJkhWInSCJ0XTBQPW0epS r+yTAous7o8Afc1Wdv8t1MJNZFp2IbVg4QW1DiNH20kw30WYv9eihKpxy0k/9ZbzWweYGcik2q2
 kBGUd1inU9zMD3kixCu7USWiFqfqs3DhMUhDqs1YfLK7qB4VGzP8abE0Zk0BVOpXW+ntbqti
X-Authority-Analysis: v=2.4 cv=MshS63ae c=1 sm=1 tr=0 ts=685c6f2a cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=SRrdq9N9AAAA:8 a=mT-SxY4RSD4c5V0lxYAA:9
 a=CjuIK1q_8ugA:10 a=n2qFYuOBGOEA:10 a=DfoyO1XrIf4A:10
X-Proofpoint-GUID: oHATqPXp7jbabRt_PNxH81CXiAL3Meq7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_07,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1011 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250168

On Tue, 24 Jun 2025 16:44:06 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> > +M:	Mahanta Jambigi <mjambigi@linux.ibm.com>
> > +M:	Sidraya Jayagond <sidraya@linux.ibm.com>
> >  M:	Wenjia Zhang <wenjia@linux.ibm.com>
> > -M:	Jan Karcher <jaka@linux.ibm.com>
> > -R:	D. Wythe <alibuda@linux.alibaba.com>
> >  R:	Tony Lu <tonylu@linux.alibaba.com>
> >  R:	Wen Gu <guwen@linux.alibaba.com>
> >  L:	linux-rdma@vger.kernel.org  
> 
> Great to see the cooperation with Alibaba!
> 
> I'm not sure we can add Mahanta Jambigi, according to community
> standards. Quoting documentation:
>   
>   The following characteristics of a person selected as a maintainer
>   are clear red flags:
>   
>    - unknown to the community, never sent an email to the list before
>    - did not author any of the code
>    - (when development is contracted) works for a company which paid
>      for the development rather than the company which did the work
> 
> I think the first two bullets apply:
> 
> $ git log --grep=Jambigi
> $ 
> 
> See:
>   https://www.kernel.org/doc/html/next/maintainer/feature-and-driver-maintainers.html#corporate-structures

I fully agree, unfortunately, the first two bullets do apply to Mahanta.
I believe the SMC team within IBM (including myself) was not aware of
these community standards, and on top of that I was certainly not aware
that Mahanta has still to make his first code and review contributions
to the community. The timing turned out to be quite unfortunate; I
happen to know that Mahanta has already his first SMC patch in the pipe
and is about to fix an issue with the PNETID table. We were about to
give it a round of IBM internal review, @Mahanta: given how this turned
out maybe you can send it as an RFC right away and we can do the entire
review upstream.

Jakub, would a respin with
s/+M:	Mahanta/+R:	Mahanta/
and the necessary reordering work for you?

I'm with you, we should observe those rules, not only because they are a
community standard, but also because they make a ton of sense IMHO. So
my proposal is to make Mahanta a reviewer and revisit the topic of making
him a maintainer after none of those bullets apply to him.

Regards,
Halil
