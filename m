Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637013B14A1
	for <linux-s390@vger.kernel.org>; Mon,  8 Jun 2026 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780910467; cv=none; b=roEQP4lp/yDkIcOs2pSI/yNeKFMa3rzZIcPOgJDXL87unzVIz+CzUu0seJ/fo2CeOuLKuNjbrBlurQG/o6s4y/jxyvahkaGdaDVirHYvX223KVlvDBl9WH0f+/H8ONwqu1et0DdNCuJXxLjcgnV+5qNod8LU2ebCXETY9R0dx9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780910467; c=relaxed/simple;
	bh=0VPErQhcpyd69F+3onHliW8ZhplLoS85u8bayXgpt5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8L94r1V3NLFopzKFtO9kkDx8YQpvK4jXRuerAGi9sX0AnRSW/2uhmZ3iTJCxcOZXJ3ksageakD+UqbbFUGHXdNjXkQg54aauGrBKcZ6roQtXIzuAg1TcUZVSwBtXbGrJO1TDZJzFQI2nLYVbb6Qq6vfoyqaoNhK1W0wOrRR3v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U7T6rFrf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U7T6rFrf"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6587UTpD1082778
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 09:21:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=d5WoI7ov+nqrPVFxGp0MOPhuyQOmkF
	C75QL4qQkB4dE=; b=U7T6rFrfVMBxasdObqqL0TLRCuNQrgVhJGMO1RgZGM5c4K
	XzefXog4le2NTmka5tniR46cvfpVkNS1IYuEnE2Y+iqESanwTARMfbFvKeRSE5nm
	dw6N1zVGUpJdfPlXiDKlz6tv8Yhvdof+bJh51hoCAySYyBYvZzOYz+ycdckDoqFd
	llnXcf1nrB/XP+G6Qsb7JCKK6DpelmyzCWOQr+GDanT1BwXF5+EgZ0g8jjC4AbQx
	BLsgV1X/3KHizm75/2fMiAjTXfxdS/RycgLZazADEg4ot6HDNK0lLdDqZ/u8rrjy
	Jejeg3Ag1G8h+Y6zZHb/Apyxoa7iBCMl29Cm/7DQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qehbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 09:21:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6589JbHw030614
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 09:21:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjmn6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 09:21:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6589L0nh47841572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 09:21:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABCDC20043;
	Mon,  8 Jun 2026 09:21:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5060720040;
	Mon,  8 Jun 2026 09:21:00 +0000 (GMT)
Received: from li-3a824ecc-34fe-11b2-a85c-eae455c7d911.ibm.com (unknown [9.87.139.142])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Jun 2026 09:21:00 +0000 (GMT)
Date: Mon, 8 Jun 2026 11:20:58 +0200
From: Juergen Christ <jchrist@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 3/8] s390/string: Convert memmove() to C
Message-ID: <7ee8b02c-7828-4149-a942-cc3c8804aff8-jchrist@linux.ibm.com>
References: <20260608053754.571282-1-hca@linux.ibm.com>
 <20260608053754.571282-4-hca@linux.ibm.com>
 <3408b4d5-7542-417f-9da6-67e212071d97-jchrist@linux.ibm.com>
 <20260608091442.34400Ce7-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608091442.34400Ce7-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a268981 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=mDV3o1hIAAAA:8
 a=_x6vIFmAf_vQ2a7-OIEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: dxA8QebOkxO4PRGVrSOh9DxMONei6A9Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NCBTYWx0ZWRfXxqD6UvEBu+YM
 +9gg6STY7e6ibI7K5jl7Uq+TRMBNjOkL7Tr4T66GMOQyRu+65JLA6XpEJUqHSRjZJB++RuVoxST
 SR73+jGgMMEcYqszH2lGMykmYG5bm0BdMuI5NIXrkB6lPZgR/8fbrLgGXNKG5DecHf4Eql6D2rW
 +OLpVpVPIjnpD/lh9mNtgSBVQzazJthaFm41n0Otp7z+SkUzpPcSQfBTZh3J5ZDxYfnMXhFGOuC
 Fqt5sHAx6nQhr/Na++qetVGCjn+DB+Z2tMLd9JAyQFgAdA12J++feAHixLnk7s14S1mJFY8yqEq
 RV1YN4rU+zXo/IizZtLQMbToGw7QlTDpFMWyeap0BXkf00f2424lkn8b4pEnDAxvx7/ym/iU2zd
 GHxeb80Wdt5wbifhERXNLxRnLNkwyQd31vZAZiiItiwQcCFuVyiIiH1XlHOyZ7Ay6hyFE5p5ggJ
 gq6WaNlU5BviMG7K3OQ==
X-Proofpoint-ORIG-GUID: dxA8QebOkxO4PRGVrSOh9DxMONei6A9Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080084

> > > +	if (!n)
> > > +		return dest;
> > > +	if ((d <= s || d >= s + n)) {
> > 
> > While this might work on current compilers, technically it is UB.
> > Pointer comparisons are only defined if pointers "point to the same
> > object".  To be on the safe side, you would have to do the unsigned
> > long dance around this C standard definition.
> 
> There is a GNU C extension, which says the above code is valid:
> https://www.gnu.org/software/c-intro-and-ref/manual/html_node/Pointer-Comparison.html
> 
> Since GNU C is relevant for the kernel, I'll leave it as is, unless
> I'm completely wrong :)

With that definition, the code makes sense and is defined.

> > > +		while (n >= 256) {
> > > +			asm volatile(
> > > +				"	mvc	0(256,%[d]),0(%[s])\n"
> > > +				:
> > > +				: [d] "a" (d), [s] "a" (s)
> > > +				: "memory");
> > > +			d += 256;
> > > +			s += 256;
> > > +			n -= 256;
> > > +		}
> > 
> > I am wondering here if it is worth also doing a 16 byte loop and,
> > maybe, a single 8 byte move.
> 
> I'll give it a try at a later point in time. For now this is just
> converting the existing code. Thanks for giving the hint, and looking
> at the code!

Yes, this highly depends on what you actually move.  If you have lots
of 16 or 8 byte blocks, adding a special case to avoid the exrl is
worth it.  If, however, you will have lots of other sizes, additional
branches in that tight area will kill performance and one exrl will be
faster.
