Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D163E7BA1
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 08:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784708940; cv=none; b=CkcYFiEVN8Bw6YQNwgjfhvAeWe92Q7ADwUaN5ncdA7wZT/LFUy8Fprbvs3jB4emKQx8OYrBeoXCdiGK1GOLJ1hY+zgBmjdGUYAhF60v5aYXUg5+X1iym60oXEgalZcD2qJz2IVahI/hemxyRo1MErgzYYRh9abHr5wdj1+h+fvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784708940; c=relaxed/simple;
	bh=hGVkM1r0yIld4/WQGt5WPZtpReinwtE66PfEclOeCfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbylj2nO8JS0D6FuGISgSxSayuH2eocZ3DjEv0fSiML/tJVqVMRmMlq8awQ4RLsP+1nd5XxaU0sG6Q+oaAU/GUHlR0UEbNyBUHefE0wPgvbXVXiEOWiViv3tGUe2pVTdZ3rPayUcEHutgsv8KRW3Uf/zfW73CzI5IJB3cZOUDCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H+12PjmD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H+12PjmD"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M5BlRr3147927
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 08:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=nxa3emftrl1kb0a2PLOR0+tMTVBmnB
	eGDRUrO9smNgg=; b=H+12PjmDzwo7Mjn0AzLBzz3RrjFWruMmZ64RUjUybG3vGT
	ehRuJwkU2EDx+ljvHxf42U3qPxuxPOQnjRESrzTHvpWskwjvL28f7zsdB/7RIldT
	2RKU8fD/DT3pU0HDyPk+jSfzICyX9s3M6GHf06EH+BwdyHoeQMaMBAU+pXY9gDlf
	6I8P5uGbFoVGxXWsq3si6VoPWgznO5SHWyS0wYrWW0qlIgtZ7yf8DMFztup2noSA
	kEHCn9MBtxWRRypDialfDee6vT+svFS9NpBvPgIySokn1LzgD0y9jT5jh5crlZOl
	gpEFO5KcK3Itq+Hz2Kn67qjVeQdWTGQaQQNMCEJA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abh4bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 08:28:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66M8Ji3J009146
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 08:28:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnah6cfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 08:28:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66M8Sm3349414604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 08:28:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA61D20076;
	Wed, 22 Jul 2026 08:28:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8736E20073;
	Wed, 22 Jul 2026 08:28:48 +0000 (GMT)
Received: from osiris (unknown [9.111.27.184])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 22 Jul 2026 08:28:48 +0000 (GMT)
Date: Wed, 22 Jul 2026 10:28:47 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/2] s390/ipl: Improve readability
Message-ID: <20260722082847.16302A2b-hca@linux.ibm.com>
References: <20260721-ipl_refactor-v1-0-4d5938de9a70@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721-ipl_refactor-v1-0-4d5938de9a70@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3NiBTYWx0ZWRfX7546jLi/6Jhi
 1HmzKSs81I7t3JMhR30t1En8UIIqFf8I0s680qy7bNSk9hRsnnCdXsqmqalvJgh7J2CIo+0Jd5V
 Sp3R+lwsbQXNACUNyoZxiNUja5QqI1d30rFv0ml72tCIvfH1zcnklkEUNvsCDjMD8FE+5Dqht/0
 KmwybVM40kv+CfGyJDllC3gc44VHiuyw//UBkgQzOhYguNIVghyJlUnM+jeH6yR2Zo4cPduaPbl
 MdHTMt7Y2/HiY2h9c3DErH4EaboiZOXTn46HFC5+mKGE2skam9aoC66+2Mrv7csg6KyiUDU/mov
 ILNqdLe2AqvDYt+9d1ptW14qA+QTXK1JQl461X9uvb3KIGPhjt98v/PWmu95ApRKDCvzEIV2YaF
 SxQZ3MX+4ozPiB6pTNoRATyGJrgjfRjq4eJ9iSUV8PjAuwt0qSpxwtVUZr/EDdsQuji3NsyMbeA
 gMPLyM4oAhrVuvr5jlg==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a607f49 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=8HJMNE-WD3Ejd7u3PcYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: O0uJtM5ZjcVrcdfzqlwB__M3de1tT_pF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3NiBTYWx0ZWRfX2lxacBI2J1qV
 IK29XkxNV3jJmdZbV53OZJlEW+neFc0o6jMsy7XwGLWf7RVDK0hE2PIxcSeZfsRO2QZkc1Qgxqy
 vBlihIklOBu5Iaq8Iwk3ow+5RCdiBCA=
X-Proofpoint-GUID: O0uJtM5ZjcVrcdfzqlwB__M3de1tT_pF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220076

On Tue, Jul 21, 2026 at 08:47:26PM +0200, Mete Durlu wrote:
> Improve readability of s390 ipl code by openly writing static struct
> definitions, reformatting list definitions and using ARRAY_SIZE() macro
> in suitable places.
> 
> No functional changes, only coding style changes.
> 
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
> ---
> Mete Durlu (2):
>       s390/ipl: Use ARRAY_SIZE macro
>       s390/ipl: Improve readability
> 
>  arch/s390/kernel/ipl.c | 58 +++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 38 insertions(+), 20 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>
