Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780FA31AA8F;
	Fri, 29 May 2026 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067084; cv=none; b=ScrOgUdzu0QPRHhat9QchetEBaoSIG93cSmQOqdZKOliWRaEFVo23sRgSM2ruJBWGDKbTyA8C7fHv2iqVd+wKhzuhywKIsmDblr9BiqV3ifUkfDy0EX0DXEofuCNDjDWXt1pCyfBEMq6Fq7SKmv6l1mFWBjBhVG4HNsEkpI7K5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067084; c=relaxed/simple;
	bh=NrF4oZpcveQBqZS05IeYfbXTGApLRT+glbMOr6v7keA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJv6TITrZxmS1xCXQhsSL5noXGHUX7esnCmlcCl4ms4EvlySBa/RbGVDLtmbav0oh9SytravtXi9TlztLQP/TV6SWB/P0KWzRiM76tCS2kJZKC832l+ab4/7FywDQM90BCb2pTsJZAbTSzMItjftnFfdhVW+NB9OUz7Yd/oQVaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AJWH6Q2q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AJWH6Q2q"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TBR93J1684634;
	Fri, 29 May 2026 15:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jEFP+O
	KqkjiI+gD+dHAPPodveqNlEUuXsXFlYR2VXrs=; b=AJWH6Q2qFIas3gXhteYeZ4
	cYXKFc+lxwmXEtA71J4J1gvaJFlN6SrSh5y6PbfbsAhFK5APtE3a2ZpLXEWhJXNs
	B2f5BwRyOrKZT208p/VpKVK24HhWovECMObiixRwCeFcxrI29xB2oz6YsgxjdPIa
	mnSKtcd65tlJYQc4lEsZbhY1qvreakYRBVdC8OhQsbn7IW023nE3ZLDWQqQxesy1
	vxtxF823LR4Ptrxez/Gzzy6Iip/VlyFqGlPmQnPfVLghXP3tMcT/lBoqrKbijxjD
	5vfupfAfpQbIJMuurhH4EtkxacV2AZPZjPWmO0a9u9pAbSuPi3A56IKW+e/7ZlVQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884jtbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:04:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TEs5fY019197;
	Fri, 29 May 2026 15:04:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbfb12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:04:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TF4KXZ52167110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:04:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E6F920043;
	Fri, 29 May 2026 15:04:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DD7C20040;
	Fri, 29 May 2026 15:04:19 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown [9.111.19.18])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 29 May 2026 15:04:19 +0000 (GMT)
Date: Fri, 29 May 2026 17:04:17 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Gary Guo <gary@garyguo.net>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>, Boqun Feng <boqun@kernel.org>
Cc: gor@linux.ibm.com, agordeev@linux.ibm.com, ojeda@kernel.org,
        peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com,
        aliceryhl@google.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
        tmgross@umich.edu, dakr@kernel.org, rostedt@goodmis.org,
        ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] s390: Enable Rust support and add required arch
 glue
Message-ID: <ahmq8eDz0Un0ivjS@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260521165622.279953-1-japo@linux.ibm.com>
 <CANiq72kT7YEuMaM7wkOtCz8ZqEXbPLniA-x4L7E=B+x0zXt_2Q@mail.gmail.com>
 <20260526161312.19291A8f-hca@linux.ibm.com>
 <CANiq72m4GVWFYqnxNtCHTPu7XcGewHB5LNwOoayTfnXs9pPbNg@mail.gmail.com>
 <ahhLT-fFx2lUi_FV@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <DIUDF8QHISMW.3JL1TE1G7VBQQ@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DIUDF8QHISMW.3JL1TE1G7VBQQ@garyguo.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fIYJG5ae c=1 sm=1 tr=0 ts=6a19aaf9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=NPoajCNbdbnhu86xXogA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 92kolDPiN1wlK6IAhHAhkNrkQpR4GAba
X-Proofpoint-GUID: 3CUfvmbNvk1u0rIS0zXbzLDuWeaIsz-N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NiBTYWx0ZWRfX1fLwTpjAkjmX
 pELau4rnATZLALgTeGZxYm1qpcIgsAPIJ3vDjJxOe+7KKcppb1XAVvdB+WSM47yf6lmKl64bF24
 1mFolMY8g5SDx9B1uYicTqHK4+CgCTrbGZo2BKXf6Rb5cDaoxkcn81WGkHY3HrEk6Xxy1j5woLq
 gf4cJVbSFrzhCXuCA6KmcFzo6AQTgB9Tbm+0lWoiltl2bFn944Dtoqn82+fA5nKiWM9urlKQfKJ
 RTrkE8+QZhW4xforgd7cQXuSiU3caDxrmZV1kINyaPRsF+L2exVEPJiJywQupwJMTJnO7NFLTlB
 MyDjDgo713gNINmZK8axIIHg5cBUeqWdpK3AI/ZMfPood3gl45ju4M5swRJSX0TkSinUcFO/k0H
 fDTUXMbWZ1kHAncLczrW6u5XujvikjinlSbXBHT8pdkgBn8UsfZasfl0cHstDuPH91NrDlwJWze
 Eva/uWVEmulBh776bcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290146

On Thu, May 28, 2026 at 03:14:29PM +0100, Gary Guo wrote:
> On Thu May 28, 2026 at 3:03 PM BST, Jan Polensky wrote:
> > On Wed, May 27, 2026 at 12:08:38PM +0200, Miguel Ojeda wrote:
> >> On Tue, May 26, 2026 at 6:13 PM Heiko Carstens <hca@linux.ibm.com> wrote:
> >> >
> >> > An Ack from you would be appreciated, even though you made it already
> >> > clear that this series looks ok.
> >>
> > [snip]
> >> similarly named function `memcmp` defined here
> >>         |
> >>
> >> So we likely want a Rust helper here in `rust/helpers/`.
> >>
> >> Up to you which configs you want to support initially and how clean
> >> you want everything to be, of course, so:
> >>
> >> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> >>
> >> I hope this helps!
> >>
> >> Cheers,
> >> Miguel
> > Hi Miguel,
> >
> > thanks a lot for testing and for the Ack.
> >
> > The backchain warning is known. The KASAN report around the 1/2-byte
> > xchg emulation and the missing memchr in some configurations look like
> > separate follow-up patches rather than issues in this series, and I
> > plan to address them separately.
> >
> > Best regards,
> > Jan
>
> The memchr problem is something that need to be addressed in the series, because
> by introducing s390 into a mix you're turning a function that was previously
> always externed to something that cna be `static inline` and need helpers.
>
> KASAN fix can go separately.
>
> Best,
> Gary
Hi Gary,

thanks, I'll include the memchr-related changes and some more in v4.

Best regards,
Jan
``
