Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7E915250C
	for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2024 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721740700; cv=none; b=ZkYtJw4BECjAn21OtMPQh8zE3V5GtdHfO0CprnnKSM2Pv3DbsjJ7KDXHBZGksQipBZd4zPaKI8ooRQ1wW+IefOyjf6zEofG2awXNyKM5opSEZtjngbLBi0FbI0CqrBlRSR38mEX1nBbVOyGonJmZQxX7pBms9BeH4pTO5kU94v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721740700; c=relaxed/simple;
	bh=w/HsJqcP5uERUPmELx06NhsGxrzazdBBOUnUuY1bXbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOVP/OfUI9HMhTyxnMl4dhG/dygzZrQmcPcofC4gmnxzhdQENbRAYmQGCafO/7u0dDyE/iyWo1bgJ5XKC//lkjJtXcshHhVc/4KTm6FGakgN6nrdvOGNsEYZ6kpUiCo67gmXZ2+f2EoG0I5PCYT/6Jjk/Va1NW3KDUo2XDwauZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hQHJpWyW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hQHJpWyW"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NCvbvD029474
	for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2024 13:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=r3Oq/DXD857wtmNFPZNoFNJJ07X
	b5ojVzfCjePuN3QA=; b=hQHJpWyW1qsoLYdMCI9AL0yD71dbQgt1FmVmsHGHsEF
	gK8hPiejg4t3HVYaQc88uAqfzgOZ04b3v+7wlqXfCXfQtk7feWUxIuUaUL/g09tK
	xij3uLEVKXPH6MDY5RPCNKeCGyZnlheGb09IP5W4VgVMuXfBfGCf9H76yCavUbTY
	PTd84QsYou41YoA1Z3NeXsmMnkbMuLQ7SvkdqmZL4QIzD6bps1hzl0FDdz6fuKaN
	HVZJ33kriPamGYYLnF6LPB4pjiMJa6ZzPfu9xcqgh0SNcc8LFmXF06VBPrcdGc0m
	9mcJm4ppVo4k0qscdydUK0ESETMxf/fdrVloPqmMPdA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j9fq8gv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2024 13:18:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46N9Oqp9005890
	for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2024 13:18:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gy2paebp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2024 13:18:12 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46NDI7XK48234992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 13:18:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 385C22004D;
	Tue, 23 Jul 2024 13:18:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 160F320040;
	Tue, 23 Jul 2024 13:18:07 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 23 Jul 2024 13:18:07 +0000 (GMT)
Date: Tue, 23 Jul 2024 15:18:05 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/2] s390/kmsan: Fix merge conflict with get_lowcore()
 introduction
Message-ID: <20240723131805.6750-A-hca@linux.ibm.com>
References: <20240723124441.120044-1-iii@linux.ibm.com>
 <20240723124441.120044-2-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723124441.120044-2-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1Q_bZDTd_6piT_HCCjxCC2NsnwrqKM94
X-Proofpoint-ORIG-GUID: 1Q_bZDTd_6piT_HCCjxCC2NsnwrqKM94
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_02,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 mlxlogscore=545
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230092

On Tue, Jul 23, 2024 at 02:44:11PM +0200, Ilya Leoshkevich wrote:
> Resolve the conflict between commit 2a48c8c9cf87 ("s390/kmsan:
> implement the architecture-specific functions") and commit 39976f1278a9
> ("s390: Remove S390_lowcore").
> 
> Fixes: 2a48c8c9cf87 ("s390/kmsan: implement the architecture-specific functions")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  arch/s390/include/asm/kmsan.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
