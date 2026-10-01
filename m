Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B2C4ABBC6;
	Thu,  1 Oct 2026 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846431; cv=none; b=tffdw4a5/ZoLU0bHgbGqvROu2dE9gR4xlCZgnCkdU48CDLFxi/z7qHpSPwAr6dZ7DMW3MoNFfoM84QU6fw4VihPbOh2uWLHndjCA5rcAzknFxfZ4CU+G6hz5Sz3Rn56zkQxtD7lD52uIMWm4KIEOaq1lOlIUIehng6EY2LwWqpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846431; c=relaxed/simple;
	bh=PX20bDzSvP+8ZelvqFkMUFhDkFeertkEiZ7WsdmMjJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgDa/1K/hpymSU5XkUWWf7x3KHowTCdVzVRdcqiqt47R8XgmtTBokdxYsePO+fzFqiAb+9iXhqkzBjusX7bolyeWWphRvcTQPnl2PUYVja/BH/Jqs1IpPpOcPLoY2kvnI1ozu4CoB2Pb2mZsxInbskV0f+eYExnnDNNCOvJroxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gdJINpHS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gdJINpHS"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175Nqh1085937;
	Thu, 1 Oct 2026 09:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=/U7PAdAYYE1tCfg1LWT8pYORgWUBC3
	Qp6JlrsNLO14Q=; b=gdJINpHSnQ6Vod5hUJRs/vR56qTx/JZZgxqnfVMFkzRS3R
	r8alf1/A0UvQQBIn5f3nWQ/Llh3W50gxTAz8AKzeLEUy748BKfXA/Gtz76RRozQI
	/9ejpUyB8ZUKzg2ISsVisnHlaXxRARVwgCR+47Ofej+TXcnj0H2PMU09uwckNC/E
	PZ/ktBYUYV8Id4bcIYBMSR6Rfw50gPle39Y5LcYUUIka53+b3LrxO9hqmU4/b9SD
	JXs+cmWHd43xB0e9kkiH6c1QnoFyFOI71tC2SaQuyDvD/MDbSei10h6INlxRbvKO
	eHdQrIAfU2ozQ46GH7LXKDJgL8mQzEMozqocM/LA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5j986-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 09:20:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6917HqFF545802;
	Thu, 1 Oct 2026 09:20:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcsd801-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 09:20:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6919KJnJ45023600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 09:20:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 666AE2004D;
	Thu,  1 Oct 2026 09:20:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0488C20065;
	Thu,  1 Oct 2026 09:20:19 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.54.207])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  1 Oct 2026 09:20:18 +0000 (GMT)
Date: Thu, 1 Oct 2026 11:20:17 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v7 2/4] s390/mm: Batch PTE updates in lazy MMU mode
Message-ID: <15c64970-d54e-4b8f-96f6-50c021079a94-agordeev@linux.ibm.com>
References: <cover.1786956464.git.agordeev@linux.ibm.com>
 <d7fd78377a7278108ef501cf76571e80caef5968.1786956464.git.agordeev@linux.ibm.com>
 <20260824104048.11040Cdc-hca@linux.ibm.com>
 <b66a61a4-a532-44ba-a1c6-26f02193fb05-agordeev@linux.ibm.com>
 <20261001082143.23106A21-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001082143.23106A21-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzNiBTYWx0ZWRfXyXw3T5h0GlUw
 mQv54xvwV2kNS4Bglyn0SaRfbANUc+FQUcfWVGeW/1h5tBDQ3pBgzN33vqcceE/EBsJNPMctyab
 y7xoxADYS/kTks5aIDFit8DqoZd6iZw=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abe25d9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=c9BTM6wM6yW0X3cp0v8A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: uwGReYwd5a8785TSxr4_gRawb7bMaKQz
X-Proofpoint-ORIG-GUID: ow73LtbKnqceLk8VG9Es6Mkw14u5-y5L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzNiBTYWx0ZWRfX+WBvBRTaxLOF
 uLiBPaOdGS7YJmDITVp65n048VbpZHAQpzqV8vqOyQNr9wzoPccYK5E1bQ1TZXuaKTcr7GRXZXe
 /OLan6+DOMcBAlKeW3hYBs1GqjP+UtLpqYoeC1JJY14mqcwEuFJSLKvuEMKxZVzUgxGbGegrKS6
 JhFwPiJfpYQolXHcZiPOyz6qK3DghdKb1gmsosWG6QtNAiJVuAld0ma+5ivEGtino7NhhY1u2sL
 TuHB8SNYOcXC9az9duOfAfan6MMqAvn8pe90vPmLPVEfjLQbvpmBLwD0pL35otQnwO46syL3b1y
 bFLbD5lJmq1uHUpu4OgkZJm1Hnp9W7J7oQi1wMX9tS7QXvvdpkBhtQF0RJvVW6sdOhn1GPPPJVy
 FbUwJ41is0jLM4G7LgdeAF5hXVm9S/eGpdW/25vori50P8LZBN3Rq4h1ajnNg2YTKbDtZ9+w37x
 AkDRsv7bsACmb2xxMcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010036

On Thu, Oct 01, 2026 at 10:21:43AM +0200, Heiko Carstens wrote:
> On Thu, Oct 01, 2026 at 10:00:55AM +0200, Alexander Gordeev wrote:
> > On Mon, Aug 24, 2026 at 12:40:48PM +0200, Heiko Carstens wrote:
> > > > +static __always_inline bool is_lazy_mmu_active(void)
> > > > +{
> > > > +	if (__is_defined(__DECOMPRESSOR))
> > > > +		return false;
> > > > +	if (!get_lowcore()->lazy_mmu_count)
> > > > +		return false;
> > > 
> > > I guess there is opportunity to generate better code here using an
> > > alternative and using a flag output constraint too.
> > 
> > It is only CY and LT instructions that make sense for me.
> > Here is what I came up with:
> 
> ...
> 
> > As result instead of gcc code:
> > 
> > 	lghi	%r8,0
> > 	lt	%r1,1032(%r8)
> > 	je	...
> > 
> > We get more or less the same:
> > 
> > 	lhi	%r1,0
> > 	cy	%r1,1032
> > 	jne	...
> > 
> > The only benefit is [zero] "d" (0) could sometimes avoid LHI if a
> > zeroed register is already around. But also the KASAN coverage is
> > not generated.
> > 
> > Does it make sense to go ahead whith the alternative?
> 
> Not really. But why is lazy_mmu_count 32 bit? Do you expect a nesting
> level of 2^32? :) If you would reduce that to one byte you could use
> tmy or cliy.

Good point. But still, do you think it worth dropping the KASAN check?
