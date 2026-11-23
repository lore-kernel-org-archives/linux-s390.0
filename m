Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443076;
	b=Ts3wK2lb8NZpaIKLj5VWibJWm3rTzZoFaY3Tvvuxn/hlzLbxKdZuLkKXOZ2aSLwT6Xsv
	 jTuo6Rxy5+doG5oxGHdED4JlNY/YnlOuTMW9XJy9D63HsK17uYbuY/Yj8iwMWi3bDQiW0
	 wBtZRcjdr08R+IO2+1DsY/M8kYRfQeqdCxQ9G471kCo74S26uZCbRCtjUpV1pskwOzUUW
	 Cr8UEgvyhJoaK1lOmj2LXo4mPOXdI68NNuGDVU9e5kePptrO4Ane38B6/lLYXg4ECRGEJ
	 0oxn/T8CjFs/ZfuTii6YLGrW9Lh2nOIftc/Hd9o+jyOaaeRDALb3fJuEBIyxSzod8+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443076;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=WeCpiEzcRm0UGUmqtjFXsgROLu5jSswOWLuXkZD1mcU=;
	b=HqS1Pzma4uEbkHc4ERKBgp6/Px3bnpqRD9S8MXIeR9nwdz9naHHV8iO3DEhQKWnAY5Y6
	 B3zZVw0TU5LNJB1E7iwPWjrQ+ficFMUShtPZjB83gzhQ3RfBiv+Y9qV/7PLrUQ3PBrbwL
	 5wDVIpoeuNkjoNoUu9mOeV2/pzUqWjeEuPipoJ5qjxnhBOF3CZ3YsJjoK3e7F8Y3HF+ln
	 h49De+uEwxrh2CacfR+JSJ2bmxG/Gp/GqhElrspNp66LhJcxPJBANrtUfUcxDyKAvlHCy
	 sxIfdzhhcNKk6EpugJeXxJdEGg3E5udUazJDjQF7HSrdpZcZSKeyQziDw7QS4qNGMCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cOYi1IMq;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56887606A31E;
	Mon, 23 Nov 2026 14:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56887606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cOYi1IMq
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDYalk2482446;
	Mon, 23 Nov 2026 14:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=WeCpiEzcRm0UGUmqtjFXsgROLu5jSs
	wOWLuXkZD1mcU=; b=cOYi1IMqlWV3Ko4gc3xePGgvJyUUSUXjoroycRey72hq/M
	Am7yM1hJbcAv8+U6oSKIhw78cTLA5Wx9jiX6JOEOWajrQZ4ekH9M9pkDx3DKBqY4
	HDsXMIIloDg+P48b7ItuF+qzzellOW+Djs3HCjVMAHQ55OKEunqomaLeLFlqP4PX
	7sMpFFA6v5fygzE2agmsaGzW0HmoVxZWITqVqpQMLP1Xw/qiEN8055tnFFHswiEM
	rj2770N9Sox2PBkAb6E5Rb3JOY84wchhyWF4GHzsGbssmnFypR3OUEyuRCwAM4m5
	S4nmyyisDMxDMvocereyqmV8FwDbs2TzMuQQ6Upg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4b314-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 14:11:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDJiY61976236;
	Mon, 23 Nov 2026 14:11:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3rayes5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 14:11:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ANEB1Qj50790750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 14:11:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6A3620043;
	Mon, 23 Nov 2026 14:11:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C69120040;
	Mon, 23 Nov 2026 14:11:01 +0000 (GMT)
Received: from osiris (unknown [9.111.54.232])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 23 Nov 2026 14:11:01 +0000 (GMT)
Date: Mon, 23 Nov 2026 15:11:00 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Anastasia Eskova <anastasia.eskova@ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/2] s390/cert_store: Allocate keyring with link
 restriction
Message-ID: <20261123141100.14793A9f-hca@linux.ibm.com>
References: <20261123102324.483917-1-hca@linux.ibm.com>
 <20261123102324.483917-2-hca@linux.ibm.com>
 <awRCtUt7_hHclKpe@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awRCtUt7_hHclKpe@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1NiBTYWx0ZWRfX2aruVn2Y8ScU
 3RJwsULLFzOcyfyjYtWkj2TMBM0JUFTlYTmq+W/DkYU5K4EPF3ifw8/vg/cQc/DTh4Mzj6y0hUf
 jluwJRakJb1qL+ahD+XGh8tU3VYmjCM=
X-Proofpoint-GUID: eyx2u4G4vgT2KMnokHR0kz6toDrlgK4T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1NiBTYWx0ZWRfXzeQ36fIpPNoJ
 AMg1RTkubKNmpUhkFmH1Ln3rD1mGVlsa8M2vb8a2+iNv/uJmptZnIfnv7N1veUepX7nYufUEmjs
 bXwcEN5dIaam8CED6fr256OicfRMUFcDBrVVJh+kngirw8Wv5ZiV/MqgpLTxc3nY2i2FdIKBMz7
 nvgy8maN82stKvV6OpNdmt4x09m0rnYkYRuuTROxb6Q9w9NQLm8X86NTYKNfxmTVy/MSdvY3x+q
 5xnnfPV1D2XwgC7yQg5ikXMxVDNVvCuM6+PHmNcNd2BPueL8eLJdeZNZwCD0cPsSJclHAo6zvuS
 o0ik0dsyI6sH9M96qjghsiPwhcfP25P8g5FKkozzDdfhAcDO+3d/RgI8F8HqQKFLSaE14l/mcHh
 74jNZHf9cPBApsBcKGcp9AHSkUg/u3PQUbhyRdujPwPhWf+9ZQhva5vDjyPsrjvGlPKDympV/Hq
 pjahFnkIJtjt7me98og==
X-Proofpoint-ORIG-GUID: eyx2u4G4vgT2KMnokHR0kz6toDrlgK4T
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b04497b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=Z_qaNafLRb7wvQTEmcoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230056

On Mon, Nov 23, 2026 at 03:42:13PM +0200, Jarkko Sakkinen wrote:
> On Mon, Nov 23, 2026 at 11:23:23AM +0100, Heiko Carstens wrote:
> > From: Anastasia Eskova <anastasia.eskova@ibm.com>
> > 
> > The keyring is linked into the user session keyring on allocation, but
> > keyring_restrict() is only called after all certificates were added.
> > Until then a possessor of the keyring can link arbitrary keys into it.
> > If keyring_restrict() fails, the error is only logged and the keyring
> > stays writable.
> > 
> > Allocate the keyring with a restriction which rejects all links, create
> > the certificate keys with KEY_ALLOC_BYPASS_RESTRICTION and drop the late
> > keyring_restrict() call.
> > 
> > Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> > Signed-off-by: Anastasia Eskova <anastasia.eskova@ibm.com>
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> 
> I think it is best for overall good that earliest possible release
> for my intersecting changes is v4.7. I think that it is good to

I guess you meant to write 7.4?

> do that architectural change but since it is a problem solved
> there's no need to rush it in.

All the fixes are planned to hit upstream before 7.4 is released.

> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thanks a lot!
