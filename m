Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C26B30DEBA;
	Tue, 25 Aug 2026 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652515; cv=none; b=djjENQ1/+r0EX+WKdnWJHEx2IL44fcg3VNcz4S1foO33J9+saqVZfXTAPxB27uv+INczdLCF/WopnlFSHYeNOLepTJfZcAQyhxkIRuVBMfpUXiExcMaqBtjjEsBeh/6G33mkPkBZsd2PDm2Jxkaz+ON1wo81xCbbgJWcKDShWRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652515; c=relaxed/simple;
	bh=n4XurS87EFMtlLFQADQTQH3sbMF6PWmvD46SxRrszcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CY+pHdhhYF8R/VtziPkCAexC4xLdjqjcA1ZXFM+Gr9m876K2qyBOOa6hfPrKIRZpKYhYWP0cnl/DHmvHHW2mblV6aG5EZwmxzwZcl/1Of1cy39fBJwjloc8p8ZegfzU5ZbhJRQ4qtL5MHWYYQP406C9S8WOzNM97p+K2bWV54Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dIvrH2v4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dIvrH2v4"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P8VWOb328035;
	Tue, 25 Aug 2026 10:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=OCGBlEXlqbyHi/AVYHWGuz3WxMH/1R
	NPpsOqgBoxWQs=; b=dIvrH2v4RuzbTVBL3sxeI2sXdvA6CMSIxwFlH9x1791YXv
	HLtp0wTeWdok6/KAeEML0QPyypgg77YMzSUABD1s8UsIxVarAE1ejIy1mEe9bk++
	ubnZM7mt2ETIP7kW5Bw+HA/kB2D4gytYgz03G+pkUUmuijK5Tjc2rUzCoaK/bIee
	6+1N/GlrTVQDiq4siBo6uuJlH+cOxkn5TKW8QHzJ2kU6XLLlHkqWcxIMwfUmvq6f
	NxfhARCUcKWzz0iQ8gtCtbvBzmEUN4DTohzKMQrucrXco8h57QorpR1Dx2Pr0dZX
	IaJPlg+T4rbczyohl+X/vRU6YgVrs1dnTKw+fFsQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4qeuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 10:08:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67P9uPcd001181;
	Tue, 25 Aug 2026 10:08:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3jum4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 10:08:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PA8NUO31392320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 10:08:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9785C2005A;
	Tue, 25 Aug 2026 10:08:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AF9E2006A;
	Tue, 25 Aug 2026 10:08:23 +0000 (GMT)
Received: from osiris (unknown [9.224.90.220])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 25 Aug 2026 10:08:23 +0000 (GMT)
Date: Tue, 25 Aug 2026 12:08:22 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v7 3/4] mm/kasan: Introduce helpers for lazy MMU mode
 sanitizer
Message-ID: <20260825100822.12095Cef-hca@linux.ibm.com>
References: <cover.1786956464.git.agordeev@linux.ibm.com>
 <52c9be0cf71a8896a5d76c148c38fb24a2005dd9.1786956464.git.agordeev@linux.ibm.com>
 <CA+fCnZfMkPDVyy0t9W-3d55M2ba9wXoRyzj2EWWYLEW=QO3zWg@mail.gmail.com>
 <20260818120130.1411942A70-agordeev@linux.ibm.com>
 <20260824095635.11040Be5-hca@linux.ibm.com>
 <c4ea355b-9807-4a9d-8f90-246b4e650684-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4ea355b-9807-4a9d-8f90-246b4e650684-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: vyqkNg84yn8IFtBiPCs36bkr0q50mJ_Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA4NSBTYWx0ZWRfX6MJVYSKIIeGK
 pJVrL9ncRX+rYf07cUoQRBtoPe9Vc7fcqeWmdBzfNODQTjwqllR9Yt5+NA7xb2Qr47a130R5V3b
 NJYuILE+9i4HGxxpnAM/RF2N60X5nZ0=
X-Proofpoint-GUID: Tun_GKDvURKFbZzads9eFM3iYsGilwPp
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8d699d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=8NHveA8ksU0-wkMMO8EA:9
 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA4NSBTYWx0ZWRfX7lRVKlL+M/Qr
 457OXpwPHz5uWsuTjtTsWHUcm55Ca/MaBM6cjrgMf71pQBbzQUGwd10DFxC2g7G67b8FXqDmg7e
 z7h7Kfy7wvOF2U8Wc4tfeBE038EFkCh6jjMT83W0ik+6kJnNgjxByTlMZjl0OFv4SVj1dZrLa82
 q0prcNcm/YKfnRKyhwmgWiK4RHSqB3rDcJK9XH5AIuByGOd3WZYc+810eT0l8LRwTNxm7Sjd0rh
 LecvA26y+ka2EilRgfjJ+j7LgSTDH00n0nBR5KbqkqXazeZ8qBDG6mQPoS0wMlAXqyh8gcMpMYJ
 KFr5PPFnmm7B5QAm+iS+xkz8tFqIZl4QyCBNgBqSMoPE96MVHDJisEbd6mCbwvjxfSNIhYd9MzB
 i9eJepqNKpQSHOQxlTwMBpcmHB9AWTEeBCovBMcOFp0Fh+uqVPfZ6gwnLYwNBQmovBK/btIsV2U
 kybSlQHAKPPBnGq2D5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250085

On Tue, Aug 25, 2026 at 09:50:30AM +0200, Alexander Gordeev wrote:
> On Mon, Aug 24, 2026 at 11:56:35AM +0200, Heiko Carstens wrote:
> > On Tue, Aug 18, 2026 at 02:01:30PM +0200, Alexander Gordeev wrote:
> > > On Tue, Aug 18, 2026 at 12:11:34AM +0200, Andrey Konovalov wrote:
> > > ...
> > > > Hi Alexander,
> > > > 
> > > > Should all this be limited to only s390?
> > > 
> > > The idea is to allow any architecture to opt-in. Once [1] is accepted
> > > this may look redundant, but I still see the benefit in having it.
> > 
> > What would be the benefit if [1] is accepted?
> 
> Just another mechanism for verification, and pretty cheap one.
> I would dare to say [1] does not rule out an invalid access completely.

Ok, maybe we should revisit this when we know how the solution for
page table accesses will be. Then hopefully it should be quite obvious
if this additional code is helpful or not.
