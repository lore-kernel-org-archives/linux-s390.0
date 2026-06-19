Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C0924B28
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781861697; cv=none; b=Wh+Fdhv8Q2ai9Za/YGbWrSAHeT5x6MYmq4qX4aOWtyXB42vC4R8/+cu+pnNkQotrL7dxG0NfD2gyo7sqcyFDnf0bdpe17ewcnguv0EAodL7o0DK59nKJYLaRRczhpRKE++XXR18x1L+IoI0YfxN+X+CbiPCcX33KyMEyw/cU2co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781861697; c=relaxed/simple;
	bh=2fiHQ4AMWoTxampmV1p/s25BwaupOCnNFaB+3Wv60w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q00POwL808fpRVl34l8d1Xd0D7hEyQuctP3NSDM5e+KKuM/vl3g7Pqs5tFMMSnOk/LqxZRxGf00XpHV70CAsOC32ywWFCZQVRNhrsGw4moyxF5uIzTP/PDmSurdrtIoZnkPUW9ChuHv62KYeOc/RrB56iVc9U10u13ORsDQ5kU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PTgz/643; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PTgz/643"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7mKb71711894
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 09:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=gCYUHIAtAdsXsj3OmmXMzIHBrCrTmG
	RLkik9luPOsZs=; b=PTgz/643yVs/tes7usR8KS/NSaYeLaPvOxaOl5oAJYhW8C
	HNZIIzyp8bkm9WZwj6qmdsHWvC+R2Olkg5rhESbHh/G5HsYOrH46N+93TGc8M3Eg
	dgKnbbV1X+oCHzFJvM32gW4Epm7mvIgc+gjrm9ce8/vsj/gqhTi98AhpMmuhfGGL
	XTmSa9v4LStpJIHCQW6wV9BFo3F0wm4xiM/zo31Kze673DjKAvPsGIp6PiWtEJYv
	eQEF9+0T1RkrjIfvSU92Feh3C9cKEC/RRO0CWzVPeV3wRlH73teqjRihgkUHY2R0
	VfIiF23bpsss/GplQj0hznOE2q/8HJJmZ4MHSOQA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqtvvva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 09:34:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65J9YeL4026592
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 09:34:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev17286hv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 09:34:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65J9YoID47251822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 09:34:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB09820043;
	Fri, 19 Jun 2026 09:34:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B0E920040;
	Fri, 19 Jun 2026 09:34:50 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.83.221])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 19 Jun 2026 09:34:50 +0000 (GMT)
Date: Fri, 19 Jun 2026 11:34:48 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] pkey: Fix bitsize check in PKEY_VERIFYPROTK ioctl
Message-ID: <22083ccc-9393-4c59-bf74-e6236058c14c-agordeev@linux.ibm.com>
References: <20260619074541.1710716-1-dengler@linux.ibm.com>
 <20260619074541.1710716-2-dengler@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619074541.1710716-2-dengler@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JmtnAA1zuZ8zd4RPB6HnuD4VFQMwsSON
X-Proofpoint-GUID: JmtnAA1zuZ8zd4RPB6HnuD4VFQMwsSON
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA4NiBTYWx0ZWRfX0pUe+/ua+h09
 elf2Tw2SFvqGqu/hIYvZwnW9+AnleQb2Dd3uWFI2bi06Fa7/Dg3206RCcKTKlRCIUc9AA1oVlTX
 U227/TICUWWn0XaS82p4MFcdte5T2s4VN4VAMsOPJ3EQkhGgaq/BMfZvmfT97IMuKEp6SMANaDY
 kT7+CpPojtdUNDREMAvcUFOMOtppFe4efMZ3/e/MtqayJ3iqORVYn13FjY6ZK6Es8Uk99uKVa3I
 nYMHW/QH0bcBeC5kVW3TcyH8XvM1FxqnUo4Z2lZlmENRN0oF8PF4+K5HoDLaU4y9GT20nZ4Y9WE
 GSPJKTOuRLO9zeBFoxPiYLfG6bkQxI2+aNCNKc66NGaZzr1eYyuPipgd883RAU4tzTj4EYsoOg/
 94dJGPGtTQfKFdH6SU6QCbgpHHgr2sF4AJ4uK/gCn2yZ6c0R1hbsxfZAGur8+urMF3Ulgmp4b6Y
 ydP/UClFkJdREQeBKFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA4NiBTYWx0ZWRfX991RTjP4APn6
 a0G8v18O87BdYId2/Frx9r6j7W3cOpOJYpsJfIVT1ZbAU8R/0UfbX/KqLAho52SeBemXSrEIryy
 zbMARd5WJliBPakr0Nnp7WfADj+rnVM=
X-Authority-Analysis: v=2.4 cv=B4KJFutM c=1 sm=1 tr=0 ts=6a350d3f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=tt6_0u0paojY7SyHAdcA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190086

On Fri, Jun 19, 2026 at 09:45:41AM +0200, Holger Dengler wrote:
> As part of the verification, the PKEY_VERIFYPROTK ioctl checks for
> supported keytype, which are derived from the bit-size of the key. The
> calculation for the bit-size of a protected key has to take into
> account, that the length of the protected key blob also includes the
> length of the wrapping key verification pattern (WKVP). Subtract the
> length of the MKVP from the protected key length fixes this
> calculation.
> 
> Fixes: 8fcc231ce3be ("s390/pkey: Introduce pkey base with handler registry and handler modules")

No -stable tag?

> Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
> ---
>  drivers/s390/crypto/pkey_api.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks!
