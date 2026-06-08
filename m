Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39D13B0AE5
	for <linux-s390@vger.kernel.org>; Mon,  8 Jun 2026 08:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908965; cv=none; b=SjPFwxw6CMSKVBV/QdpXBPaxWwFS9g0n8zu+OU1Cr+WH24Flc0fFdTm242iy4QWVD6FNUov8x1PQlXoizqDnOUq/ptv+LNfkq7vHt9MO8C10p1FCZT1hQ8QXqrp6eTX/BtbZ7dZitsJF/W3WwYg0e6Lg5nRbDqNslFuVqL0xcIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908965; c=relaxed/simple;
	bh=yJnzZd2cGzHO0WaRrjJxjFHcgpLM/7wfD2wGcvxN3U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2+149XAOEQOfIXIP9I/wDihR0YQA/zVJQOd4BUODQSJL6FuK9iYg3TX2jsaJj/rFz7z+KLp8v9rkTkGXJBaZp5dFA3bt7/f5jUVnGloNCZuPDJwN4Nz25HZLbknyaKOFBdnKQ5j6a3qVR66WUehTUAWrI31hG+F2dHn3FxVM2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UjeKCEXz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UjeKCEXz"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657JBJc02661850
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 08:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=3TXe4HC8H4sPD2ksc9gQgyScFDN70i
	CWypNcIlNRta0=; b=UjeKCEXztq+ss4q82djJWjGT8WGDwqA/5SPkfLWPX2e6l4
	49509b1QvyUV0863QUD5s2iiBLa/HYXn/Wio86NHOzC4IDrOpvKQaeqUlsyqFn6T
	Ldpm7zYWfFgRVi5Wp++dZGXWfcJbq4iYg76pQwzmhGgEgu2W28b9hiytFDVSYm0O
	TnOANgqdlTzweOrOqHbAyDvsLfxw+6D+wKQTv4lqCA9g3Lkk/h4xGaGq7/Mh4WOA
	tjSBDGxpDoT6b32pD0JH8wTJSynmhUhX1frE4O/awrcA9NeAuyCyDdjaq1eZFJ2B
	V8MD4P8Idb/R6FkS/sZEc26dkOjR2jlT7Bxkhl8w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb956exs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 08:56:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6588naeq012704
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 08:56:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8vvp1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 08:56:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6588twRe38142462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 08:55:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B7CE20043;
	Mon,  8 Jun 2026 08:55:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BACFC20040;
	Mon,  8 Jun 2026 08:55:57 +0000 (GMT)
Received: from osiris (unknown [9.111.82.157])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Jun 2026 08:55:57 +0000 (GMT)
Date: Mon, 8 Jun 2026 10:55:56 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Juergen Christ <jchrist@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 8/8] s390/tishift: Convert __ashlti3(), __ashrti3(),
 __lshrti3() to C
Message-ID: <20260608085556.34400Bae-hca@linux.ibm.com>
References: <20260608053754.571282-1-hca@linux.ibm.com>
 <20260608053754.571282-9-hca@linux.ibm.com>
 <507926e4-d6a5-45f6-822c-1196e6d5d18a-jchrist@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <507926e4-d6a5-45f6-822c-1196e6d5d18a-jchrist@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a2683a3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=oR9Di9A-d3wXaOBcEm4A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: DXtzdCBPJZ28dZudhAV0jAbmKNwUjApS
X-Proofpoint-GUID: DXtzdCBPJZ28dZudhAV0jAbmKNwUjApS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3OSBTYWx0ZWRfX2QYwMXAbc40T
 EJ7bO34IwfmSJn2Op0bqFBA389936zm7Is0QH6J0VJBmBMY7xQWzOdCbqz5hcO4cjMe8jNRCwVz
 Phiia7UBr3d3lNCqGd/ZHrabw6w1NCHuI4qYUh3u6AJlJxxYMNjAEQuaMQe7gw4yLW6Pc4imsjc
 bvhZXYuDlEiPWgx2cJJHP/7Ay9Li2LyozZIcmYVufsJys5mAwtKsEXmjHJffX8wO9wyw4SYZNaR
 w4KZDN5m1xbmTS74f+ml7ahDmaGwx6stIvj35UVoaDEfHx0vdUjHIeqfskc6Y3LsLqTVkbnZ/Yp
 YUQu097xTjVTqinuWk3QhrDjmWkiMfg9+f45YG1PuGN7IHRxiaoef8npuGWTjNJ2OJK9aGv7MIu
 OufySzt7uUHbSNTrWCm6rWC6T/oyE7QI0Jjxs6y+6NUyX2DydZYZ6VeLBWPldsWiKZ+ZcNpVTHm
 oW8ZgEjmcjlWsQv+rEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080079

On Mon, Jun 08, 2026 at 10:19:39AM +0200, Juergen Christ wrote:
> > There is no reason to have __ashlti3(), __ashrti3(), and __lshrti3()
> > implemented in C. Convert them all to C, which allows the compiler to
> > optimize the code if newer instructions allow that.
> 
> I guess there is a typo and you meant to write "implemented in
> Assembler"?

Yes, of course.
