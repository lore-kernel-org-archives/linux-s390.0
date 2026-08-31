Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA2F43D501;
	Mon, 31 Aug 2026 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183449; cv=none; b=WVILZno4BVaK/7BjNGKix1P010ONOdo+vo+HSox3tTInWI82VDJXzXK2w59ipySl0iSfTKQrLckZNIofb9oKJSWUCpL3IbOD75IIvWlyvuJ6P21GfDiktOzH7nADH9jcaW7oeLv0AW3AA8w7jGkp285qKlaDSPrF7Eaxp18Ec9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183449; c=relaxed/simple;
	bh=rzhKHiZhbJczQxCSf8YeS0RQnX+NC9a5nAFu5PYb1rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijYF2AQm5euy4VON3kwDPVXQbFZXW7ev5nAAayqb60r2UrL80s/A3bK/9ipbiJAxh2DhkK1ACYdSirqoYW6Seh9CQw2tQFhDZ+HzgPz7myCnqK1w5G3fF14ZfjlxM8i14o86NNYXclJArR8XC7Ey+I49+yrnNh+veTcVijXFVoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h1lQ5RQP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h1lQ5RQP"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBVXQ32083773;
	Mon, 31 Aug 2026 13:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=otTD/p
	mpS21gFWrEyYn3w686LmTfhTTidUa/EHv5Jws=; b=h1lQ5RQPmpLxqFEY5cmUs+
	Erf1Dg31ro1pqtOoRbcXA+pr+CB4gKByHVE1OKPuy82G6yPETt6xNyWdgEsrB3RP
	/8gBkAQzYROH7Z8MfNWuX59N5N0RkS+DFxB0coPEEMn7hNXvFqij+g/o+93dXeTj
	P76YOKgKnbVgKj4m042/ynr29DoNPc9yWHQQnjhVm7cm+K6uIBzcKGFR2rWFUV6l
	pVHoQkyXI9NSuvRjzUT7OlEMObXBiwfDXF6EZRZFiFjbWJuR2HtgoqEggyU9VOOl
	YDNAOuutVPMPBLA9InzxkLHX9ujV6j2NAt5U3OE2iz6sIWYRh0QLdZ1Ds1a+e8lw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54hj2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 13:37:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VDQHYS016879;
	Mon, 31 Aug 2026 13:37:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gca4vx6ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 13:37:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VDbL6v30278370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 13:37:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D20E12004F;
	Mon, 31 Aug 2026 13:37:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9027E2004E;
	Mon, 31 Aug 2026 13:37:21 +0000 (GMT)
Received: from osiris (unknown [9.111.81.24])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 31 Aug 2026 13:37:21 +0000 (GMT)
Date: Mon, 31 Aug 2026 15:37:20 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: sashiko-reviews@lists.linux.dev,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] s390/ebcdic: Add character classes for the
 invariant subset of EBCDIC
Message-ID: <20260831133720.34274Baf-hca@linux.ibm.com>
References: <20260828140057.1728173-1-iii@linux.ibm.com>
 <20260828140057.1728173-2-iii@linux.ibm.com>
 <20260828140945.EAA981F000E9@smtp.kernel.org>
 <43d49c51-0a9c-40fa-8967-2439331972bc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43d49c51-0a9c-40fa-8967-2439331972bc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDExNyBTYWx0ZWRfX5ZFm4uWKj5BL
 fOdjx6zpV9qoTvfM7/g7mTBBmaiytTEWDhMr5//GsU039uKrCwkzOD/OE3mTSqZ1bWLlBgDh6TY
 j29GKBeJ2BbRtmLYVZQisL56zpb753oVRpL+Ot0z87UhL9Q3kyWvhojxmbHAq0IFYDG2ABBEl1/
 x/zMFNjP7s9cuBmS8c9h3LLVgaw6iPhf/GEyYPxHKww1ARyfklssNV+LU4YMt9ABiJ6WNgbZ7rP
 P9gUFcWIJLQSn6iZOZhynSyoDODAwCcIyq1pi6WfVLeRpGgzC/oiPDmI9P7TAFS1Q82U/meG0SV
 lubxNnTNDVggfkAeHx9oKR4zRG5hwjAiznl6A7xwzBAJxx4g+JPIMuiDRK6Co87eDI8qtjkmg6f
 M4BpjcrKxt9LJpee2v2c4zzYTnd8nS2W64OlQDJ5Sj72Wnxqso6tJx/ahCtUXkHEv4yahR+bVn1
 luUfOe0A9fE0cyU3TDA==
X-Proofpoint-ORIG-GUID: 6g7MuHV04mVIQ00BVmOSctCNUd8gqmVf
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a958397 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=xmvgcqXOEkXRZdUCUdsA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: 6g7MuHV04mVIQ00BVmOSctCNUd8gqmVf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDExNyBTYWx0ZWRfXwr2jb2qoR1cO
 3IhwI1dWpVf7bKPeAGs+6EYJSxfF0fXIvswI8awtUJv1ivltwV5tdhsHJI7uq2bRBO5ePCOPxGT
 AaFZKkL8Og/CcApgPjDiCXSu4bBGoOE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310117

On Mon, Aug 31, 2026 at 02:14:19PM +0200, Ilya Leoshkevich wrote:
> > > +const __u8 _ebctype_inv[256] = {
> > > +	_C,     _C,    _C,    _C,    _C,    _C|_S, _C,    _C,	/* 0x00-0x07 */
> > > +	_C,     _C,    _C,    _C|_S, _C|_S, _C|_S, _C,    _C,	/* 0x08-0x0f */
> > > +	_C,     _C,    _C,    _C,    _C,    _C|_S, _C,    _C,	/* 0x10-0x17 */
> > > +	_C,     _C,    _C,    _C,    _C,    _C,    _C,    _C,	/* 0x18-0x1f */
> > > +	_C,     _C,    _C,    _C,    _C,    _C|_S, _C,    _C,	/* 0x20-0x27 */
> > > +	_C,     _C,    _C,    _C,    _C,    _C,    _C,    _C,	/* 0x28-0x2f */
> > > +	0,      0,     _C,    _C,    _C,    _C,    _C,    _C,	/* 0x30-0x37 */
> > > +	_C,     _C,    _C,    _C,    _C,    _C,    0,     _C,	/* 0x38-0x3f */
> > > +	_S|_SP, 0,     0,     0,     0,     0,     0,     0,	/* 0x40-0x47 */
> > > +	0,      0,     _P,    _P,    _P,    _P,    _P,    _P,	/* 0x48-0x4f */
> > 
> > [Severity: Medium]
> > Does this array incorrectly include variant EBCDIC characters?
> > 
> > 0x4A is mapped as _P (invariant punctuation) here, but isn't it a variant
> > character (e.g., '¢' in US 037, '[' in German 273)?

I guess this is indeed wrong, and 0x4a should be mapped to "0"?

> > > +	_P,     _U|_X, _U|_X, _U|_X, _U|_X, _U|_X, _U|_X, _U,	/* 0xc0-0xc7 */
> > 
> > [Severity: Medium]
> > Is 0xC0 also a variant character?
> > 
> > It is classified as _P here, but it can represent '{' in US 037 or 'Ä'
> > in German 273.
> > 
> > This seems to violate the definition of the invariant subset and could lead
> > to missed warnings for garbled boot parameters.
> 
> This is a naming and not a functional issue. The IBM037 punctuation
> marks must be present in the table for the series to make sense.
> 
> I guess a 100% proper name here would be something along the lines of
> "invariant with IBM037 punctuation" or "IBM037 without weird
> characters", but I don't think it's that important: one can look up
> the Wikipedia reference in the commit message to get to the exact table
> I used here.
> 
> I will defer it to the maintainers, whether I need to change comments,
> names, or the commit message here.

For 0xc0 I don't see a problem - it matches what we have in lib/ctype.c, which
also maps "{" to _P.

That only leaves the question above about 0x4a.
