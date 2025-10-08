Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202991339A4;
	Wed,  8 Oct 2025 09:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914760; cv=none; b=mWbdlvQup0gzCR23WGAd6gUmIF1teXss5UxjsSYcVzGSNSmgOWH4ZJf1EyMZol0KvotficmB4lHBGL3G0KgLKLAkyxuLwYLUroXUxqtbUo9A7vKDXQ1g8W/1wnK47Uvtdvg160L+vVt7QU+hansixeOgG6P/9qMboN9m3pvtqj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914760; c=relaxed/simple;
	bh=Kp07gAsJlNKZ5fUadYzAELKG5ORsDtrNuDEpygEuihE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UohiDHTeKFuyEaNLB8a0ekJJqChN4lcju23ONYw5u6f8LfPYSZY5sYYyxIgEbjPVdqvQzA6MfnjIFONOO62uUpg6L0hBwQcz6xbwlpuh3Lvskw9QzgZ/OD0kRssy76HC22K61LWKovhilqisOrUuib+jVbmHu8dxJVhpf/Ygxso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qvdNYe4+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qvdNYe4+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5980ZHXr032558;
	Wed, 8 Oct 2025 09:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=aK9mCC/RHPHdTK5kHYQdLWTNRy23qH
	+qQ26TBsTBalM=; b=qvdNYe4+5EA++mkwOCUGVGO+t2OONxB1DygeOEhFhJ5hMY
	gk/gCN8a1/xtNWL0X8oW6VJ9t2nfHg67GfVs1J6jEIAA7fBGBXCMZGoS0M9bGAiu
	movKI9GmUUVyfDFXZe7w/RXgp6Rirw14jCYkiLnvQigQOfgZ29PmuribvX2o25Ak
	ykSxexPnFs03HU6QAYwu1yn7dLKciVfAwGrdCA51oTOnjvxFJC1uvZQPrOXWUrsJ
	L9Vd06JsF5jRFObwC9YQA1jK7HiO1KKhjhaLFaOraOMjSj7RPqeAhfMY2UCEh8xe
	aEFvEqbd5uDXcYPbOsd95OIm2GF6dGPKDBu6Rn+w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49jt0pkh2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 09:12:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59892jtF000922;
	Wed, 8 Oct 2025 09:12:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49ke9y7vvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 09:12:31 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5989CSnE54133064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Oct 2025 09:12:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08F2420043;
	Wed,  8 Oct 2025 09:12:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1A062004B;
	Wed,  8 Oct 2025 09:12:27 +0000 (GMT)
Received: from osiris (unknown [9.155.211.25])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Oct 2025 09:12:27 +0000 (GMT)
Date: Wed, 8 Oct 2025 11:12:26 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 0/4] Support dynamic (de)configuration of memory
Message-ID: <20251008091226.7407Ba1-hca@linux.ibm.com>
References: <20250926131527.3260733-1-sumanthk@linux.ibm.com>
 <ab366c03-8c78-449d-bfc4-2d155212d9d7@redhat.com>
 <aOVUNmDiWgrDJ1dJ@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <5e3b16ec-9ef9-483e-b97e-bff0c1915b19@redhat.com>
 <aOX_L1_2S30XhLRA@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <1efcb368-fcdf-4bdd-8b94-a705b7806bc2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1efcb368-fcdf-4bdd-8b94-a705b7806bc2@redhat.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XvT3+FF9 c=1 sm=1 tr=0 ts=68e62b00 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=jU7K009U6UgGpLyiXvsA:9
 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: gQe57XFfwFvGSr-qkxi9m24GyXfNLFtK
X-Proofpoint-GUID: gQe57XFfwFvGSr-qkxi9m24GyXfNLFtK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwOSBTYWx0ZWRfX/lr/owc4waxF
 aHEV/cPN1MWRV5BM10eao/zGoE2x2fKeLvek1NljdqlnGVdRUGXcWyrA694yVz+M1GLdJnB5dIk
 i91NXmWl8V9L0dDPfHzcA4TnMB2T59mYlEbp+PyIt5LD4oyvdmC2FjkeDTrsa1L4zRLVn1WwOdG
 +R2k1RGEaGso1b+mWHbRNFM/GgExy7PDrkBIalJ3dHM64PN/hvJ3B3/Exx/XTdiJKnA8OlSagza
 XrXADd6SUsz2d8ytrwwTrX3qILR48CuBV4klUs8izLjYHzv225xCAO+heSkU39+gXr3SsXuaQDI
 WmERe9y+E9uRhNW9opr5WthMidZt+GFktfsA9TkhtvOPF1dI6UUA8hoGAHEKvDiND9gqJLCmS97
 ZB6MBbYm1sx4nAtvoaCUsTDmusz3hQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040009

On Wed, Oct 08, 2025 at 10:02:26AM +0200, David Hildenbrand wrote:
> On 08.10.25 08:05, Sumanth Korikkar wrote:
> > > > chmem changes would look like:
> > > > chmem -c 128M -m 1 : configure memory with memmap-on-memory enabled
> > > > chmem -g 128M : deconfigure memory
> > > 
> > > I wonder if the above two are really required. I would expect most/all users
> > > to simply keep using -e / -d.
> > > 
> > > Sure, there might be some corner cases, but I would assume most people to
> > > not want to care about memmap-on-memory with the new model.

...

> > 2) If the administrator forgets to configure
> > memory_hotplug.memmap_on_memory=Y, the following steps can be taken:
> > Rescue from OOM situations: configure with memmap-on-memory enabled, online it.
> 
> That's my point: I don't consider either very likely to be used by actual
> admins.

But does it really hurt to add those options? If really needed then all of
the sudden admins would have to deal with architecture specific sysfs
layout - so the very rare emergency case becomes even more complicated.

Given that these tools exist to help that people don't have to deal with
such details, I'm much in favor of adding those options.
