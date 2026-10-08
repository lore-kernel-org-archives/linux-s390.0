Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996083D567A;
	Thu,  8 Oct 2026 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791481980; cv=none; b=Mcg9h2iI921XmlrnTSScoIPl0x17SKj3VpYDZqHYYsk4e/BlXVXtQq6T9ADxsVAOKr3+jO6AHh9XZwx1wXbFOp9Jt0YDLyzKF9wyfpDzEUdz39CxsrIY8uMtz1N6ItPJ+AZgoxP5qV4y0x7bItFO5rZBZrvMTJ/TGKmICmy/0Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791481980; c=relaxed/simple;
	bh=yUEBlBJJo9goAnvzWx06dDtASk+G0M5sRD97pPlyimc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etwVnzTzAdYywtLf9Nfzq7q5zheekRu9GjLWDxhnVzGtVcf0PIltGw317FuJOpT+mWqtWK+xrdGhTSaY6YvgIleBwtOHVTwQROFbB7p2dSWadxuYvAGnM2zXsbhdKizFsKPjzZleMCons3aCdebjRDbnmFY9vDrHQ30/GLz9b30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h8mf27wW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h8mf27wW"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698HZeRe2005197;
	Thu, 8 Oct 2026 17:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=zJm0qtDr0x8D6D5p2wkXURGtIvETML
	qP5KA34oDmD30=; b=h8mf27wWQyPukyxlGuZvB0l8t4QyfiMq/cWq0xCwzMLZyY
	856JS39Qwz/Bbl/YXeHxA2NfFFeB3I4zW2II/XaYq5S4DEheagT7sB7AclwdBkW2
	uHCxwZiydxuDA6sXaNxj7BvLhAvlbtHnuATn7h/DSVtKs5U8LhyOWCHjWyJ/4LwU
	IHCTgqrJUc4Au2suKAzGjd3sOvp1p73FxYyF/RYszhKPyDVBhAGz1d1Z6fimZDgM
	tpyoS7K78qqeEeSsFlj776asfJ10SmXdY7XWdfJ4Pv7kNCfjbEWTlpS7IMwgmEqJ
	iJJSuRIDr0xg/ji9qFLwiqSj9bLGDHGo/EnZOXnw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvn7b6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 17:52:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 698HWiGs3846178;
	Thu, 8 Oct 2026 17:52:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhh4e8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 17:52:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 698Hqq0J21561882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 17:52:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BFD220043;
	Thu,  8 Oct 2026 17:52:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17F9120040;
	Thu,  8 Oct 2026 17:52:52 +0000 (GMT)
Received: from osiris (unknown [9.111.70.153])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  8 Oct 2026 17:52:52 +0000 (GMT)
Date: Thu, 8 Oct 2026 19:52:50 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 1/2] s390/appldata: Emulate virtual timer with delayed
 work
Message-ID: <20261008175250.13419A96-hca@linux.ibm.com>
References: <20261006140113.3128582-1-hca@linux.ibm.com>
 <20261006140113.3128582-2-hca@linux.ibm.com>
 <20261008190827.1b9762c0@thinkpad-T15>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008190827.1b9762c0@thinkpad-T15>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H7BHGTK6OQZCU2pMydf63ZVtm1lqHJoc
X-Proofpoint-ORIG-GUID: H7BHGTK6OQZCU2pMydf63ZVtm1lqHJoc
X-Authority-Analysis: v=2.4 cv=FoOQbGrq c=1 sm=1 tr=0 ts=6ac7d879 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=7pSgel_-wBi3v11SP2UA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA3MCBTYWx0ZWRfX3lRESh9VeBjR
 aB9YYE3SCCeOBW38r0UfWjEzUYLOx7y05+UmNrZAfk4fj04AwGCtncsVFG0OB7pcvFx7l7pK25K
 z+6R0fmkUEzKQoclmKs1vX5sFnUoY+4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA3MCBTYWx0ZWRfX7mUI3ETiKOUY
 A5kPrz4AbyVS/lSxfGkxMtA9rh2l2aabHl5YIHuliloRYi+L/0fWbJOBZ/buS0BELYRup5vLSFg
 ovJWDwFf547wTQJ6PXnA1r0hTwT+n9Ba4dxCIyY/sY8NScg8eYgb47zMJXh2d7bAxrmOYwj5HLh
 kPivaV9PkTngInO8wcEBGuX6z3bHz9AHOYlEviLtLGw2jqmLowqr3UTmnbqEV1WKbtIEKlfn4fr
 rQpti5Dni3QLuklMrqY5SZBni6VTwT8a7y+Coa/7zv4MlfdqtPQ0+FC+tQzzKM5JTK7hnADa8s2
 ipTYhJDfMgApPvApR0rzHgroXbAW2WeR8yCRW/dfHYs4dCqQHMr1VnlRBTDiSCCfm9bod/StmqC
 1YYkzo6PTML3LIq2nXE9s9nqY5kcLQWiW8/VoL8FxB6UJhk2wtmIGijzY4VrBN3ZVa1AXzKFWWi
 McedhqMi3dld/QV9D4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_06,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080070

On Thu, Oct 08, 2026 at 07:08:27PM +0200, Gerald Schaefer wrote:
> On Tue,  6 Oct 2026 16:01:12 +0200
> Heiko Carstens <hca@linux.ibm.com> wrote:
> 
> > Emulate the virtual timer in appldata using delayed work: the work is
> > scheduled for the minimum possible wall-clock time until the
> > configured CPU-time interval elapses (remaining CPU time / number of
> > online CPUs), with a minimum delay of 100ms. The work then reads
> > per-CPU statistics of all online CPUs to check whether enough CPU time
> > has elapsed, and if so runs the registered callbacks.
> > 
> > This is slightly more expensive, but allows to subsequently remove the
> > entire vtimer infrastructure.
> > 
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > ---
> >  arch/s390/appldata/appldata_base.c | 171 ++++++++++++++++++-----------
> >  1 file changed, 107 insertions(+), 64 deletions(-)
> 
> Nice improvement, with minimum wall-clock interval 100ms. Specifying a 1ms
> CPU-time interval was possible, but did not make much sense in practice.
> On very idle systems, the resulting wall-clock interval would also have
> been around 100ms, but as soon as they do some work, it would have become
> far too frequent.
> 
> Also tested it, and on a busy system there is now no noticeable difference
> for interval values 1-100, while idle systems still behave like before.
> 
> Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Tested-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>

Thanks a lot! Applied :)
