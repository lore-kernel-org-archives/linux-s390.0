Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E553DB339
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785401436; cv=none; b=kmy5gs/cxxv2Zj3NnAIw9cToFjMDmV2FqPL1RJHQZSVC86irAJDJF6mx/sMXx+fS5Sgxfqf5eGUNlpRC3nTQcV1bQiXsgSRvVnIzWKGuab7R4o6YkOW065bvj6vmNsDsARAQzHkpIVeKvBSxfIx1OTnRMKA57YnUx6HaiUxhsb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785401436; c=relaxed/simple;
	bh=n703KJ5/IMPs30b02U87Rk8ULUivZj2C4nTFDt3PcEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTNRcDfeshKV1P8mNU9VvM4lW3+3m2k810jK8Vc1FYIwTxFaFB9O1gf11aSIwBLQCgeXHUZop5DudL9KqNmQIgaEC+h1xBrrMMAetgmToFf3nIPyta2sDP2rz/mB8Gec8is3V4ZoGq1cAgeOE5R03cUt0qo1/jlw4N59VF0DKqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A5hKK1VS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A5hKK1VS"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U6lnE3404380
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 08:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=GJFMsQEzxsrh2Fw4uVKRGcJ4DDldry
	qjwb599UvmMkc=; b=A5hKK1VSl3qVR9B64djXTxFnGB79O46XSl61olOgcILgWy
	EBCaCaPG/E52Dx5Rtjz8LvhDyoV9EoKGsrrpgDAiUgBle1Z2T3QLZLSSkEFHCnmn
	B1+rdexicvq7vrIoXqBbW6CV2fY+RIxGOuv9+LDoT64pv9yer27ROGN8Ura9Npx+
	kmVrAkDnU/aXiizXteyl9DybskHpqAcXJtQ1TUPslMxPnjLJeJJOM9I01/xnGtfT
	koTJD1F9IA3DrPa5hHyft9xCcb8BQz6TIC3ZQb3mL7H01Z2xgdJm5sAXUEhMvjse
	G+9yuJkZrVCKKLCP3M2OoCIEx3pnDNwClaYbZ/yQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycpt8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 08:50:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U8fFD9018754
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 08:50:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgjcp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 08:50:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U8oOeR7733564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 08:50:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D65A020043;
	Thu, 30 Jul 2026 08:50:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9851A20040;
	Thu, 30 Jul 2026 08:50:24 +0000 (GMT)
Received: from localhost (unknown [9.87.133.185])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 30 Jul 2026 08:50:24 +0000 (GMT)
Date: Thu, 30 Jul 2026 10:50:23 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        ifranzki@linux.ibm.com
Subject: Re: [PATCH v4 0/1] Fix buffer over-read in cca_cipher2protkey
Message-ID: <ttizcjz@ub.hpns>
References: <20260729114009.187946-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260729114009.187946-1-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uEHH7RoOsXQbHypvrHdoYjsMaVhcm9Wn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA2MyBTYWx0ZWRfX7FJV8a8tlU4m
 kP05m2x2gIhihaRta/BE+mT42fBVlWoKPMDposUU8LbsOODmbhqAmrXYS4ntgzPneIiz3lVIsEn
 CZFLnKPfXHt2LmLnlrKWJkHa8Wh5j3It8f5GcSP9fIcgLvXUkl4au2bUT4BfRGdCkC5i8mDeMwB
 mHJlUHD2qNiJOFBleSajUmHut7N3CaowW/rwt7c0xaI2AVYINhUKfCKcEmS9+l29tfMZahEqS92
 wglbm+AKwj6qpqBRJjUGJx+7bDtRxqxf0lGCkDypsF79472G79ZPx7SpUbGJFuvmXm7aNBIjiOY
 MhyxAA7vUFpRgZGNpvJXvKVfyMeDr/45cwSwPXqjirLsYWdgjy9XAjTNsoKtpMaKkj+M1Yixzm6
 NyWdR4+3rOAB9QN168TKk4BoqWWFnvdGA+xZyEiZTiVuDfHu/cb963ZW5TRyy/5dbRhZ34LWCgA
 A1CJcjq1v37l4l9Jfig==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA2MyBTYWx0ZWRfX7f8zluzUEZM/
 ZALhUvfY1HHDRdj1fLBPyQWHLGOfN16+OPrt3gujQwDzVXdYukiAihbBviUzWt202SgNpCABA1s
 GeWDMevGqFss3drO1Juq5de7R7dx5Og=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6b1055 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=j8vmKfi9clgtBY5k_aYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uEHH7RoOsXQbHypvrHdoYjsMaVhcm9Wn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_02,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300063

On Wed, Jul 29, 2026 at 01:40:08PM +0200, Harald Freudenberger wrote:
> Add validation of both the actual key buffer size and token length
> fields in all the cca_check_sec*token() functions. Additionally check
> in cca_gencipherkey() for possible underflow with returned key size.
> 
> The CCA token structures contain user-controlled len fields that
> were used in operations without proper validation against both the
> actual buffer size and minimum token structure size. An attacker
> could set this field larger than the actual buffer size, leading to
> reading beyond buffer boundaries. This may result in a kernel crash or
> exposure of memory via sending this as part of a request down to the
> crypto card. Also an attacker could have used a very small len value
> and thus enforce a buffer under-run which may produce similar effects
> as a over-read.
> 
> So now a key must
> - key buf length must be at least sizeof the token struct
> - the key len field inside the token must fit into the range of
>   sizeof key token struct ... key buf length
> 
> Changelog:
> v1 - initial version
> v2 - extend the length check to all cca_check_sec*token() functions,
>      also check for min given buffer length and token length field.
> v3 - there was still a possibility to under-run the length checks in
>      function  cca_gencipherkey(). Fixed as suggested by Ingo.
> v4 - Reviewd-by from Ingo added.
> 
> Harald Freudenberger (1):
>   s390/zcrypt: Fix buffer over-read in cca_cipher2protkey
> 
>  drivers/s390/crypto/pkey_cca.c       | 15 +++----
>  drivers/s390/crypto/zcrypt_ccamisc.c | 64 +++++++++++++++++++++++-----
>  drivers/s390/crypto/zcrypt_ccamisc.h |  6 +--
>  3 files changed, 62 insertions(+), 23 deletions(-)

Applied, thank you!
