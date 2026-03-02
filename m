Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2CC3FD13D;
	Mon,  2 Mar 2026 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772462421; cv=none; b=mxwRlh2caMD4ZI6NvdxJzP7O3uxJMMzODAgHpzeqSccvcDwItNiu4gUZj7THQ59KZDfe+mE8/NE8YLN9AY9zx183Jhxf3+jNgTJ7Hk90PwjOS31cO3c7o3Ow0WE7Tqp5jyr0CKKJhWgjFPRCrexxzlSjJVFo3mHDR0NRB7Kf2VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772462421; c=relaxed/simple;
	bh=0gkNTtE1H0CrgO8zpN2gzwog7FXAjBes0ZvlRT1p9as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHITx7VQiVg2f9hM+TnNhEhAv+uatqxtCQthmhsP+BvkXgmhKFk0cYdVZ+ZZ9HLy1YRqepggJudDTSplsOXaI1qaC0Uqm4ciUxysMzxCYZiS80pXIQR+Ih5NX9kxxz01gr0g2bZJDscHH/G4sf4JGxxcvKrm70ZVQTVwwHxgbqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C0YE5fUX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C0YE5fUX"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622D7ZRL1850818;
	Mon, 2 Mar 2026 14:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ifEtGy8jlYcX+XQl3DEhsUlbMCiUoz
	VNLa597lESD/0=; b=C0YE5fUX26IApu24oEXAHYDeTJX4WjeTXTxzakDepAdbwW
	WzFwxeeAPr8wXkv9wWVLj/FvwLjeVmeEFktoPsPa8SL/5BCo4Inih9JuKRwuiUtp
	iS7kKcFGrv68qEKQTaq52tL8w7obPhiHx4qR5aHStsBIwBCbrag0xxrt0SZ841Mn
	kipwPfp2Qxyg4SjwOfvgXN1pp1HPH810O4i7grsmRJMzfBZA7J4ls9EwN7fy35oA
	A1bcG8T+oA42urbbgjp1eNlG0hQNpElbbtVcZcZA8hIuxS0v2wZZ0qLLZZdgU9GV
	TduJieRz0FHTHNGIiaaBJqn94OIc3Gn8qsxclxCw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskcq34e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 14:40:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 622EBpbR008774;
	Mon, 2 Mar 2026 14:40:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmdd167g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 14:40:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622Ee4p550200932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 14:40:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16E422004B;
	Mon,  2 Mar 2026 14:40:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98CB720043;
	Mon,  2 Mar 2026 14:40:03 +0000 (GMT)
Received: from osiris (unknown [9.111.20.206])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  2 Mar 2026 14:40:03 +0000 (GMT)
Date: Mon, 2 Mar 2026 15:40:02 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/3] s390: Fix and improve inline assembly constraints
Message-ID: <20260302144002.22209D5c-hca@linux.ibm.com>
References: <20260302133500.1560531-1-hca@linux.ibm.com>
 <20260302134751.GA21924@lst.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302134751.GA21924@lst.de>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4lwK1-1NUBwP3LEqrw1RfdbYxJpX31am
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEyMyBTYWx0ZWRfX+CxlAf83Got7
 Sj4mwwHCV/40jYPyWAbzKVFfadb1pwJdd+OFvQ0zbdiPzw60KntQlM2ppX7+RWqZbdH0dYg6zli
 8Dv3nfHTNTFT3i4iiBGmwaidUBwxBi0lZQx1v5/TJ4xWXkGuCfgoDZCiftybrkP/zHy6RtSXcm/
 XqyZLulniOwdmjHu+kBZs4h+khewKFrGO4HpjO08EUzYUzeaWVM/Y4mQEzDEUQHu+t+P+5Guki0
 ZOjQxZXhpS6kg7+vpKlWca7/XMMhgaTR2WGxeAswTvDBVmjisPfbkVHbRL10okBrqfm2ETRiw3d
 bJWskQFw/W1trF9PGKEoMAwPIGZfA0Vk6mXLPozMw3xx1Al9tTDBXtMkNyjff18M0Abn66iTQw9
 ml3faMLsV5afhlBNlCyyOIFWIjyQTUTAbIU+E9TBmHCcX3u6y2/ufOe/chgmwGn57NoPqB8/tAO
 wccuA2PiVnz1EtIzW8w==
X-Authority-Analysis: v=2.4 cv=H7DWAuYi c=1 sm=1 tr=0 ts=69a5a148 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=ZeEKcecX_V3YXsxNYhoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 4lwK1-1NUBwP3LEqrw1RfdbYxJpX31am
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020123

On Mon, Mar 02, 2026 at 02:47:51PM +0100, Christoph Hellwig wrote:
> On Mon, Mar 02, 2026 at 02:34:57PM +0100, Heiko Carstens wrote:
> > While looking at xor_xc_2() I realized that its inline assembly constraints
> > are incorrect. Also the inline assembly constraints for the other xor()
> > function look incorrect, but are not (execute instruction vs register
> > zero). However that revealed another real bug on __stackleak_poison() with
> > another incorrect inline assembly constraint.
> 
> No expert on the constraints, but have you considered to just convert
> this code to pure assembly?

In general I don't like pure assembly files, since they come without any
instrumentation. Of course you could (correctly) argue that's the case for the
current inline assembly as well (except for ftrace). However the rest can be
easily fixed/addressed.

But I don't want to rush in even more code to make your life more complicated.

> Otherwise please try to get it into Linus' tree ASAP so that I easily
> rebase on that for the XOR series.

Sure, that should happen before rc3 comes out.
