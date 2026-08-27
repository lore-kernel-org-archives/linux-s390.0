Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9851847A873
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846356; cv=none; b=ShhFaZXsFRJkhyaXVKCKs8/qIkU9goyfWhat1znPaJ981wSwfSOVL+hXc2xT4PJcPYf63oKA4TmwoEr/BuQ04ASbacFYNcc5zFCow9aGmDsMAn2+X9jPYm7K/gPnkWxLGtkP+FPv9OjjNCuWJA9XbeN4vAA4T6Ga21z0L+NPA+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846356; c=relaxed/simple;
	bh=KYlOol+JqN+Wr6PSunaPj1aUBQ8/bt4tMdCBLd6z2wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKrEf23i3U06yKeFGE0QACEMhHTe6TamGs9HSP0rmWpAGpIM5I3h1LJKPIwuLRfoYS6IYI/4txZ49qQcyer8VIUtzxtD+bqe3bYl8GFryi50MPMEQPoh4T0Ho5PHUD1NyTrfEFhly+bu2g0RS8L00vbWdY/yQYDFuzZnmNTDFqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D+n26qIR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D+n26qIR"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RF5R1M3245637
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 15:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Tk3KUjJbLIMQVqbSmfC2T9sm58K1Uv
	IyVc05gfSB67w=; b=D+n26qIRypVuXNvyqe6dpRETTClLa2ZaQgrDuKvYk/Zuov
	S1L2+MOUdsrocBnWcZ992adBVxeK4pI38T2nhADSAuZZ98QePitDLUtuc/afAtYO
	+INOZKkFVVpyZh6IzSmsuKI0weiwmyzaQh2H461R2671Hz907S/96TIP6G7wZYOU
	BEFqeYNOITHyTrJ/bTw549iAP3rA4WFs4qNrUDwgN8P3O0o3MOtW+zRflaHXnlYo
	adcerBhGyzPASIWAqsFnQ90+L3h7XHs5azlmTtgM1BWXjSXriomtYYIG0N2QNbna
	l9dGPqYV+oUpdafegigLpPTbRojl3btJl5xT7+Aw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716j6f1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 15:59:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RFuELP013633
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 15:59:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qh5ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 15:59:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RFx7IZ31851058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 15:59:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E11B2004D;
	Thu, 27 Aug 2026 15:59:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2ADF020040;
	Thu, 27 Aug 2026 15:59:07 +0000 (GMT)
Received: from localhost (unknown [9.111.46.147])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 27 Aug 2026 15:59:07 +0000 (GMT)
Date: Thu, 27 Aug 2026 17:59:05 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/3] s390/boot: Fix couple of early boot edge cases
Message-ID: <ttkfr2h@ub.hpns>
References: <c00-03.ttkffvj@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c00-03.ttkffvj@ub.hpns>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX/Dqp4wDg+z2q
 jp+RwK9GFpCq2wU9QbVsHozbThBcjLGsJkODpm954D1VlxevVmPy3YjrathFgL2x/wUpt/dLJpv
 54xnr5r1GOyva68Uh1Paum9NQLwU0GE=
X-Proofpoint-GUID: tDOwr8NGd9lY4pvs94aJZVT1nfG7BUio
X-Proofpoint-ORIG-GUID: tDOwr8NGd9lY4pvs94aJZVT1nfG7BUio
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfXyzc1fizQZY/8
 YMkYg/mhtYJtucxXzpdPaXs0c1AmrM1DKPArNq89X2slxxzMQGlfyfJHp1lT7K7/JcXtlZXLw6M
 3Qb9wGnyc+Sd/6Wtq/nXMXAsIaXFdyq2pkBs10wdvZCs+dsxg7lA0VsvSugjhit8pMNl6zv/KYp
 SI9fzNK18NNRmFEy8aKLDf6CiiW0HZXitivhaJY/+2EwsJPzMrSnZuj9Vn9iV+Drq+jj9FsT0Np
 FK8MB6Lo3L77/jLwZcwvXQ7cGRE24aIZ9QfD8pD19Vit4rT49ZHQ+pt98yC92ElsfaUbQhVooiH
 zbIbusEE0ssmN/izqyPtlGT0OaKSYhqK47mHBNivovRY48cC3tXZQFOmNfIKuC0/GItjtThxawt
 +lc0P/vCpmU7VY5+om2QTwiHFCVEtXG5b1w2CCNL8QSxlvuv97twaxs/LB66iPNmOrjMRtzD8MB
 dfAlWwcKLESpME3eesQ==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a905ed2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=nBnls3Y4wH4Sz9WoXjgA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_06,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270131

On Thu, Aug 27, 2026 at 02:01:26PM +0200, Vasily Gorbik wrote:
> Fix three independent minor early-boot issues involving the physical memory
> search range, full command lines with IPL parameters, and unbounded facility
> ranges.
> 
> Vasily Gorbik (3):
>   s390/boot: Fix physical memory search range
>   s390/boot: Avoid IPL parameter append past command line
>   s390/boot: Bound command line facility ranges
> 
>  arch/s390/boot/alternative.c  |  5 +++--
>  arch/s390/boot/ipl_parm.c     | 23 ++++++++++++-----------
>  arch/s390/boot/physmem_info.c |  2 +-
>  3 files changed, 16 insertions(+), 14 deletions(-)

Adopted Heiko's proposed style changes, dropped Fixes for patch 3 and applied
