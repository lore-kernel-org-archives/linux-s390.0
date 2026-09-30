Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B05471410;
	Wed, 30 Sep 2026 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790758428; cv=none; b=mSOlZmyYSTY4/aRHKB+RJxYbzuhdsyW48+aNZYAagKU8AtdY4za/3OXQHiEMlFUMjcsX1tW21/+jDjy0A/3H+cIe+09s05fEkdne8oOJaSLRRI1aED5USkFX+8iK4ez1AvD00yR7G0t2HOcfZKxQwoT16TVdEiftPyAlOsuo8rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790758428; c=relaxed/simple;
	bh=LnomSK7POE15LyEpdzjf0O2g1cDeKGmuEsQmVqZE1qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtmgD/eRDntrhxGaJ379gYkdOl8b642V9fxSryCdXd8q1InuaAOiKIZplYwR8iI+vUkrmTvl35j4cZEwj+DPW5L7z/AP6not6t3oGWT3kujPZQ+kOpl+lAHWoM/Q3c1lhDwAB1ixzyV3jjHDtzsFtLdYnfP5+sjw/KF80dXulZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rx9ygRXK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rx9ygRXK"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U7aoAg2367598;
	Wed, 30 Sep 2026 08:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=NhIukOj8BOfFcEqXCoWm3ULcTHuspX
	E7+r0QvW4z63U=; b=Rx9ygRXK4WPeGJMhbwYHlLYdxios9M47BgGk66SEF6gAMt
	h0dW1XEo/2YkR5l3mMTR7WJn5zsyBgxIqbOMv+M5EyFozLbTkC/P86WeMMEohjv3
	isA73RkGrpXKsD0X2vB01phmIwSiI5zWxane0cfeiT/eC5q5KwZ/p+h4NaeLXfCh
	3Kl/slGriTpnE5ffjkQmytugwlxCFiJuXC8Fu9Jz4xRjXNk4wcNry5gQf+ryi/9T
	jkWxNrvFXvpKzTdhrMiJaoq1b2383FivMVaTKP1eADYKl+6iSNyehGXHBrf33rDb
	oqxhDVYDwB/03/5zobKhhepzeE1KbvE8IYXQTe4A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5ptaysu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 08:53:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68U7lUPa3126451;
	Wed, 30 Sep 2026 08:53:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0g8e39we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 08:53:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68U8r94338732070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 08:53:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95C1F20043;
	Wed, 30 Sep 2026 08:53:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A79BE20040;
	Wed, 30 Sep 2026 08:53:08 +0000 (GMT)
Received: from osiris (unknown [9.111.12.23])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 30 Sep 2026 08:53:08 +0000 (GMT)
Date: Wed, 30 Sep 2026 10:53:07 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v8 16/29] arm64: Share arm64 headers with s390
Message-ID: <20260930085307.770322-B-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-17-seiden@linux.ibm.com>
 <arqQ2Eat4VUBbl49@arm.com>
 <20260928162345.428362-C-seiden@linux.ibm.com>
 <ars6Jh5DiendDT7G@li-d8547bcc-2d90-11b2-a85c-a70f2a37009a.ibm.com>
 <arvunF8epgpWh1YT@arm.com>
 <20260930072803.664031-A-seiden@linux.ibm.com>
 <865wzn41h6.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <865wzn41h6.wl-maz@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: hlt5tY_2sa3oCouRCckoYMzdGBgxEcfG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAzNCBTYWx0ZWRfX4XfLdgpSugRT
 XlKY3BXGec62GjXr1X+q9M67hlS8YubEVWaNhhIhulpnmG2ZHgqFVr+JMnYqgFTwHGBQSjFE70P
 enyCwFTO9Yls0xjnOUrNp4rpLxuGKQjXjVe61sDv0E508eP5Kl0eT4uGQtjZmRCn9luussRqyXS
 EzlTbb2paiO2eythsFkgh5xASzLftBQVwdWS2iCab2oU2b0VyoGKPZGYt2lkW6NXZNWwCrso1Zs
 O/1dOaAoci317V3iqnfv5YDJDl1A+Wm48aElWcKjYrK4D+r+3OwgwHW1rhlp6YGK6Nm5A0mxHrt
 5IIQ8Yo634NNeCpNVYn0D0RX6SSQ+3UEuj0Tz5WvLOzrPwR/7jos7+6/VyJ5Epib+FCSXZqICWf
 JT4D4Dms5HnS5LOdl74qFsbJSc5NQjEw3jwfhHctbxUryr8H5Q5mTTuBlUT2fftpVBgl2BsbARa
 dnBaT27Kq+ET3ko/vCQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAzNCBTYWx0ZWRfXx2ydMeHP7FMn
 y172RhPy8DuzoeAapk44jnJfuMot6M4Z8iauGIimm8Ek3ereyYBPrAbiPULWZilGPkoqfRsvDw5
 Kc9CBQQADM1FBkMtHRn018l4K5Atuhk=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abccdfe cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=GA_TYQvl0U8dmn4ZWnYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: i_8l7rOMgnEnckEEpZJW-6IXi7e8oe2u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300034

On Wed, Sep 30, 2026 at 08:55:49AM +0100, Marc Zyngier wrote:
> On Wed, 30 Sep 2026 08:28:03 +0100,
> Steffen Eiden <seiden@linux.ibm.com> wrote:
> > 
> > On Tue, Sep 29, 2026 at 06:00:12PM +0100, Catalin Marinas wrote:
> > > On Tue, Sep 29, 2026 at 06:19:20AM +0200, Andreas Grapentin wrote:
> > > > On Sep 28 26, Steffen Eiden wrote:
> > > > > On Mon, Sep 28, 2026 at 05:07:52PM +0100, Catalin Marinas wrote:
> > > > > > On Fri, Sep 18, 2026 at 03:30:53PM +0200, Steffen Eiden wrote:
> > > > > > > +# Enable all code shared to s390
> > > > > > > +KBUILD_CFLAGS	+= -DARM64_S390_COMMON
> > > > > > > +KBUILD_AFLAGS	+= -DARM64_S390_COMMON
> > > > > > > +KBUILD_CPPFLAGS	+= -DARM64_S390_COMMON
> > > > > > 
> > > > > > Do we actually need these defines? They seem only to be used as markers
> > > > > > for the awk scripts to extract the definitions. Why do we need the C
> > > > > > preprocessor involved at all? Could we not just have comment markers:
> > > > > > 
> > > > > > /* ARM64_S390_COMMON_BEGIN */
> > > > > > ...
> > > > > > /* ARM64_S390_COMMON_END */
> > > > > >
> > > > > No technically we do not need those. They could be useful if we find out
> > > > > that AWK is the wrong tool and move to a C Preprocessor + diff based
> > > > > approach. 
> > > > > 
> > > > > if the ifdev is not closed the compiler will complain, but an 'arm did
> > > > > not destroy us' verifiaction tool ( I will send one soonish) could do
> > > > > the same.
> > > > 
> > > > iirc the last time we discussed this we didn't think that load-bearing
> > > > comments were the right tool here. We also briefly floated the idea of
> > > > using a #pragma region based approach, but in the end we went with the
> > > > #ifdef preprocessor directives instead, as the least invasive
> > > > non-comment marker that was available.
> > > 
> > > The downside is that the macro affects the preprocessed code. We need to
> > > ensure they don't leak in uapi headers for example. Not a fan of this
> > > approach but I don't have a better suggestion either. At least we could
> > > write them as:
> > > 
> > > #if ARM64_S390_COMMON == 1
> > 
> > This is a great idea and an improvement. Thanks.
> > 
> > @Marc: Shall I sent a v9 of this series or do you want to pick v8 and I
> > send this as an improvement once picked?
> 
> Please send a v9. That's invasive enough that it warrants it.

Will send one ASAP.

> 
> > > It would also be useful for the awk scripts look for the paired #endif
> > > rather than relying on the comment at the end of the line. Otherwise
> > > it's not really different from just sticking to comments.
> > > 
> > 
> > Are you suggesting that the AWK scripts should track the #if% and #endif
> > in the code and warn or reject if the marked endif for the shared code
> > does not match pairing with the starting #if? That makes sense yes. I'll
> > investigate and would add this as an improvement later on.
> 
> I think the suggestion is to teach the script about the #if/#endif
> nesting, and therefore to not require the trailing comment on #endif
> (i.e. the script acts as a normal cpp).
> 
> It should only be a matter of counting the #{if,ifdef}s and #endif
> past the ARM64_S390_COMMON guard.
>

Yes, countin is what I had in mind. I will deliver this feature (or fix?)
as an improvement later on. At this point we may actually use the cpp to
do that for us. This requires some investigation from my side. IMO the
current implementation is a good first step we can use as a starting
point for further improvements.

	Steffen

