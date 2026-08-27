Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38992442118
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837791; cv=none; b=TUtqf8nyp04eEMari/l3TMDmDG9MyWYSC/8gqjN5kHmjOpOdrU5gbkuJ5ruac1tbkbtyeaCzqoenxgevI8XZXPr+Acp9Xs9owgptPu+eoAADYgh6Jj7/ASzWFfU33UyKyIckOrN4c+24KKtny0PU7Lj6gpKo2zl5QDXR6HChLRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837791; c=relaxed/simple;
	bh=O9+Sr3i9YHiMaDCnQxqJrBhvakfmU/70/zS0K9a8V30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcBT3SnLjkUd5STPfeVjJskLM2y7gVrTYUEGNpNZqu7bDv2XQt6TnXr2BWa5B8Skr1Nc7Llc4EbLqweQFMTADTsmh8Y1Fq62DVqeLGUpu7Neb6DoDTscH4BaR0khgwiksZ0U51xfCSIYWqpU4AlBgOOaWY8V6rou3y39lrobmNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=En/cg7UI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="En/cg7UI"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RCVYa12976029
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 13:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=M2YYZg1AoJI9JJDNnBocT5B4CTaCXk
	7fzlNGtfuoPbI=; b=En/cg7UIp8B+WNYLjT6tsAnUrBDbNwnaC6zR25dN7KTg3k
	KBGm/P0MPtlelTVBGQCtDzDmx4KrRBjIC+QlhwFrx6T5PG8pVfBx6cW2DfYtZlqW
	XkLIDSBOr4U2s+YFOb4Kre/VfQwzFSeSss/0jOrcGxLbiJsvSMpXP+AG+jAwshIS
	D8HbilD5C2BNVwuQ8XMPbZ7cp3iddonFy8Ln22VZgNN/KkEymhi7vkL2MD9CaovQ
	N51GQ3Lc4H6qldhxWuSsswnzvK+Hb9gqzhpLUA9hCAJJFNmnHfqfZk0q/BX0ZacI
	AcGlfv3vRaFKrda8W92a40m03ch4ClrpsIzd12xQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7394dphx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 13:36:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RDQJ5H008876
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 13:36:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhg8cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 13:36:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RDaL1l45089042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 13:36:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34C882004D;
	Thu, 27 Aug 2026 13:36:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 079DE2004B;
	Thu, 27 Aug 2026 13:36:21 +0000 (GMT)
Received: from osiris (unknown [9.111.16.137])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 27 Aug 2026 13:36:20 +0000 (GMT)
Date: Thu, 27 Aug 2026 15:36:19 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/3] s390/boot: Fix physical memory search range
Message-ID: <20260827133619.25110C66-hca@linux.ibm.com>
References: <c00-03.ttkffvj@ub.hpns>
 <p01-03.g46f7a6bfbc01.ttkffvj@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p01-03.g46f7a6bfbc01.ttkffvj@ub.hpns>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b5bT0VGeeHi1GZuYq7ZtDV6IwSz1Z0YL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfX2GXyzHGgcQ5S
 KXqBmTz8F8og8nmxp1BQdVSEDQ5meN+gBj6WLKIILSuTsNwEISCqboiSDzitJZ/iNtVH+Gs/sV2
 itSpTU0mUaxSxaG+QhDZisLptY7MCqjyXO84/FZ5q4H3KnlC7xyptDaTG8VND6cLyBwikuz+viJ
 i1OwXId6gy+MJJXOstO54PgRrx43O4nNIE8XSRhbF/vo6SwuJUS2FQcJ3tN1OGSXB1atRX2FnqW
 D6yNKxTzXX/PjS3ugQw/7A6plTLleoFYrs6XwOD3dcWZRw28hlrOR6CCIGevYQwk4cE0drHt6xc
 OTx2EcnAqC/rJzLEoxiNLR0lR7xGi5K5l/+xbwSPwATZywFgGt3/SDlYXC4sxUkGN6/zkDoE1X7
 aiVC0Gfdi1eScb/JTKdRHJhWe5Mcy8YIdKncvZ5bXSBNgjOWOn/pqwqeGKALFzvN1j4N57+Bv16
 A9OX3s50TV82J5gmSXA==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a903d5a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=oJQcuCvBLmas7OT1Gc8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfX5qmeewdZWTNa
 fi4QEIg2KsL2llcdyBRrAxJ1pLC7mGMOXvC1ZCmhef8nlleErrwvaageUuVMO0iDYc/bdoUFhA/
 Y+KqMFNAsSDaHBJluQQ/VLOkis577wY=
X-Proofpoint-ORIG-GUID: b5bT0VGeeHi1GZuYq7ZtDV6IwSz1Z0YL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270113

On Thu, Aug 27, 2026 at 02:01:28PM +0200, Vasily Gorbik wrote:
> search_mem_end() calculates the number of 1MB blocks with a signed int
> literal. CONFIG_MAX_PHYSMEM_BITS values of 51 and above either overflow
> the signed int or shift beyond its width. This produces an invalid search
> range when the binary-search memory detection fallback is used.
> 
> Use an unsigned long literal so the full supported physical address range
> is represented.
> 
> Fixes: 4d14c2666b6b ("s390/mem_detect: replace tprot loop with binary search")
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  arch/s390/boot/physmem_info.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
