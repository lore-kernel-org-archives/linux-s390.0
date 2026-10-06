Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D073E3D85
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 08:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791275439; cv=none; b=KZD2mQSM7W+aUqWUWfmT8Ep/ATVTH9XJm1r5y9bfW7MTaK/rHIjwmCbnSavR7GKzoro2dNJhbyuxpKl8ldJdGI8KksVu3OWzeJtIdaweTSDAlb8OBUw+7zMRi6j3VYcIfHlwjKRG2Qx8WfHZqSJBDkMcSLKDZhqlcIHIjjQN8Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791275439; c=relaxed/simple;
	bh=lL1RA57pEjkv8p1xBhuuZ/0s5d9CgpjejHF5HIrzlwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjrJ/Cse2mfddLDocvZhulpOKTtkcoFZefbkbkf09AJupD6oBmc2kXZi4j78skWaBcs7YhTdd8VI/z/qSm834ZCSWs5U/nfhj3i+eGtM050wkTWzCvnnC7L45UuLcVLDCSJ2Fx2WI97T5VQ2GfCZaq8a/dJWy5yIl1A7K12G63c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z16fhfd2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z16fhfd2"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6966br0S2907197
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 08:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ZbXn0Zf8dfrZtkdDo8OpT3JXdz1WCa
	yAQPpq4nci7eg=; b=Z16fhfd21pecvnV6mXhJK7/FNW86LlA6jfZ3X61kUwYzM4
	U83UMjFmiXln99O2r62DhL9MbFnDIIasiYIoWQtksxOLddFG+NiApra3wPkJ00Va
	wjzrXJBTDux20COGOuc7e8hh8cpBgjfGuihCicq2HhzHcodl6qi1y9oOuqxAKyxj
	DRiWNl7rgxiG1GH0ywtpEDuK7e//qZf8fWJqgkWlvKJHkdxZolaGBM6ZF39f/Fj0
	5Yu2mU+hmFtKfcyxR1Vc+XDgzqet+EWZYlhwF30Q8Lt/j/tAf1HU5PxlWBTCCdWJ
	GyknOiWmlMf6IppIIuJLIlrOP1TzbWWUSytBOQsA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5evf4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 08:30:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69672TZj4103048
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 08:30:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvs6y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 08:30:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6968UUQY49283372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 08:30:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6ED42004D;
	Tue,  6 Oct 2026 08:30:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96E352004B;
	Tue,  6 Oct 2026 08:30:30 +0000 (GMT)
Received: from osiris (unknown [9.111.2.28])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  6 Oct 2026 08:30:30 +0000 (GMT)
Date: Tue, 6 Oct 2026 10:30:29 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, fcallies@linux.ibm.com, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v1 1/2] s390/cpacf: Rework cpacf_kma() to return
 condition code
Message-ID: <20261006083029.17402Acd-hca@linux.ibm.com>
References: <20261005141417.65822-1-freude@linux.ibm.com>
 <20261005141417.65822-2-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005141417.65822-2-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzMiBTYWx0ZWRfX0KhLgg7a4t2r
 UJmreE01/mbwB7SoEnEVL0LoSlDsPZWk8pXldK7MG8xqgebtP/N1siqxcyS+59kNkKC1BMPKFyR
 JVW9wd8cbrkKWSb1RaOjTMjERs4JBAI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzMiBTYWx0ZWRfX87CK5Y4QfrUh
 cdfBtmiWD6DL8lGII1H1Wyzg4lhPx45hcmX9OMdQ8nnv7yxHv8FhnFbB+WCostiaXRj/Tkoy6Mt
 gCuOT+Dz4sRB90SFuUID7bf9L5MyvAoUXyOW+n7sZcp3J3C6JC7ImAlT2N/bKQmG01fcgFEkQkK
 ygkHVbiFFGALTjEe38rlG6BTxQGsE3nT441D9+01z7pnetqhoyqLJ/y8QMD6Hvi7w8mPw3hoz3Z
 606vOoSh+PohcK3yKiS+9pPLRzIun/XHK0u2z2Ize9uGrOVqI5dceFr6pIBEU4gikpbczokCuvM
 TEQ8UzPv2mpyDSOGoAlRYmHSHphnNr+V4/N2yPQDh5few0h3ELqqVmXoS/g0ec9gk5od2Vvsp1p
 yLEsP6h5YTrT+RANnv25dsnGJ5hwEhrFABgz9N8no5cGstzc07DAYY6+If+zgOHXPS48CjX/s1W
 rVXDv2nf6S0QjOPQ6pA==
X-Proofpoint-GUID: c-NrKVpQxHnpScCXLfKi0A_s1ECsWih3
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac4b1ac cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=9w2OE9MVWGUyLk-M16gA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: c-NrKVpQxHnpScCXLfKi0A_s1ECsWih3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060032

On Mon, Oct 05, 2026 at 04:14:15PM +0200, Harald Freudenberger wrote:
...
> better readability. Additionally add an kmsan_unpoison_memory()
> statement to reflect the updated memory by hardware.
...
> @@ -731,12 +739,16 @@ static inline void cpacf_kma(unsigned long func, void *param, u8 *dest,
>  		"	lgr	0,%[fc]\n"
>  		"	lgr	1,%[pba]\n"
>  		"0:	.insn	rrf,%[opc] << 16,%[dst],%[src],%[aad],0\n"
> -		"	brc	1,0b"	/* handle partial completion */
> -		: [dst] "+&d" (d.pair), [src] "+&d" (s.pair),
> +		"	brc	1,0b\n"	/* handle partial completion */
> +		CC_IPM(cc)
> +		: CC_OUT(cc, cc), [dst] "+&d" (d.pair), [src] "+&d" (s.pair),
>  		  [aad] "+&d" (a.pair)
>  		: [fc] "d" (func), [pba] "d" ((unsigned long)param),
>  		  [opc] "i" (CPACF_KMA)
> -		: "cc", "memory", "0", "1");
> +		: CC_CLOBBER_LIST("memory", "0", "1"));
> +
> +	kmsan_unpoison_memory(dest, src_len - s.odd);

Since you added explicit instrumentation here it would sense so add
kasan/kcsan instrumentation by adding an instrument_write() call.

Also, given that this is in-kernel crypto, shouldn't this series go
via the crypto tree?
