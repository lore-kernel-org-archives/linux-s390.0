Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081573126CB;
	Mon, 10 Nov 2025 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787238; cv=none; b=tyTgzMc5+5Es4dyNBvwiA29tpVlH4kML8SltD3FxHK/a/QOtM6H9OEF2tt2Sul5v5PGvlL1syYkhMkJQN76WUay5NI+Lrs9t6s1o6829rvYXGUt8DEol7Vc14v1jbiQVtPIamJoZhlH+MObaC8sV6otUc+CgDU5CmJURCgCBaGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787238; c=relaxed/simple;
	bh=W9YP9EPcgv4yW7lsw2YUUlPgBSPV+K7+EaYQKOSEkMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8EO+Wp+OeO6or+A1gjznugXmbOomHazQXWQHbL3UZ93OZEvP4HoJ8pn8e+lJwx/fSPmwsopSSNdlyekIIc64CqUC19WpCrzS8M31W9pHFB9g+sh1/JeIrpKnc3v+CyjT6wTen+mAHMKXDY55wpW08uuY7ZTTP0bdMjwhdjM6CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rLgb7gH5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rLgb7gH5"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AABX70n000636;
	Mon, 10 Nov 2025 15:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=2gASaus2jqaxvWdWfOb8cTjqDY+Cs7
	E/4GuM+QjTvI8=; b=rLgb7gH5CmxPjj3KC5viSGx4YRyoUuj57IzwptauTpLVF/
	l20N0SZQ2yHBphT36lYlS04sEAnoFoVKrI+iytCTCXrgj8zZDAu7BNdIaRZ5aIhs
	dsDhAManMsql68BVC5NWBL6sKw6Ud8pvHVSj1uNqmjVk/7ZFhaQ7WXE8Z0kOePsp
	OjPYPjSMbsU7J951M6GuDHO5ORaVGSZsNnd1idoQMg5yYNHEbjM+pqB4ihgoiVad
	c9acetq//UKLKokRhmXVb63W+14U9Utpx+nM1m4UyGJ72hQRput/QKDp6yqkE3PV
	Cvc+yJzV5QmLbpbjnFSOonGjZxmIyESKa2XiuRxw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tjppxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 15:06:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAD5RBF011600;
	Mon, 10 Nov 2025 15:06:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw15vhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 15:06:41 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AAF6bkL41091344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 15:06:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 799E32004B;
	Mon, 10 Nov 2025 15:06:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CE2E20043;
	Mon, 10 Nov 2025 15:06:37 +0000 (GMT)
Received: from osiris (unknown [9.87.148.55])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 10 Nov 2025 15:06:36 +0000 (GMT)
Date: Mon, 10 Nov 2025 16:06:35 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] s390/ipl: Mark store_status as __noreturn
Message-ID: <20251110150635.15528B2f-hca@linux.ibm.com>
References: <20251110132803.1520-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110132803.1520-1-thorsten.blum@linux.dev>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _3UY6e4Vncmr7vb_UjCjcr-GwQW9lhUA
X-Proofpoint-ORIG-GUID: _3UY6e4Vncmr7vb_UjCjcr-GwQW9lhUA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5OSBTYWx0ZWRfX3e6euJQqPfsv
 4/TQGC5LKUHNcj9K1mDvR6h9QFTuq9opCqgBGfGxAQUJ37ihakEeNiAKhxAKRTSP8swMJ7seU4P
 aXgMRq6huLul3vAqgQk9QSAwONP/6/hNlGqVWuzfX724OKrgfP0wtnio6uxN50TNHkq1pSrOBAn
 HiDkqNSLYus4ILgJ/Yco7H8S+zKUb0WcR6imsJWAtsI0vCQqtqDF2w6TA+JhRXtUJ2bF9hEQn7n
 x7HbQbBQ84r1F0aPxB8T1lRL2qJSdtoYRd/lzi2jXE2h/VwBvpe/nm8CYXDB63PcnuVIY6Ww739
 I4nATf5leOZLluh8igKUc7vAPKLJAKVCOjVYYSjE3QU6HlQG0R34mjUvXaMXHgT2S8eOQZ7n7Hv
 SE5KuE0YL8Qe3OWYSIh1E1gQ1Ti9RQ==
X-Authority-Analysis: v=2.4 cv=V6xwEOni c=1 sm=1 tr=0 ts=6911ff82 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=YE7ldlw9Mkp0iZv7zvUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080099

On Mon, Nov 10, 2025 at 02:27:51PM +0100, Thorsten Blum wrote:
> store_status() performs a tail call (BR_EX) to the function passed as
> the first parameter and does not return. Annotate the declaration with
> the __noreturn attribute to improve compiler optimizations.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/s390/include/asm/ipl.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This doesn't make any sense. If a function is called, which calls
another one with a tail call, then _of course_ it looks to the caller
like the function returned.
