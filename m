Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D242113FEE;
	Mon, 10 Nov 2025 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767032; cv=none; b=bRdMKPMRCRsZ4oA0+U2Ags8jeWUa3OydvqxeBWw7MFD4hMDOpmVkoVa42W+dpd2JU/QlaYS4B4wgbpcF6WWpChGzJqxcZHB0Z46uQkA86qbuySWkVoS14+IhTrCfBKCjpikKGrUGM6OObiROtZQp+cFuFjutj6W4S1kQSRN9olE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767032; c=relaxed/simple;
	bh=WaEO8Vmi01eBnr5hAn3BWhvORVKvfB7zy3iAIQRmbpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoVxWhIMmgilii/mHLvulMmoQ04LlYGKQxHosKOm3kQqB2uz8wjhUadcWASShteQuVZJLqKxdWLi5tHD6rJJtOXD5A5RPR4o/o8Ercfo4phJUFY1D9IJJqqw6Oys7hELNo+AMzzqoz+vJYpUjKJPlMf2qdVqRpeA3jp2gS4IaDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PFC8YN+0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PFC8YN+0"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA87ZWP028610;
	Mon, 10 Nov 2025 09:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=VaM3ltU3Y+jrUrL+P4EgR92tGTJUnG
	s24Sssjdacj7E=; b=PFC8YN+0c4d1mlUq12IwaDQx5zXR2Nr67Dr4WrgGkkvjWs
	Dc6Czp2iAwX8X+hHn7mqDDU1Anew5KlWytXMod/X2n7v7T5l3/tbxhWIed70OOyo
	wgRZXHnZS1bfJ4sMh0yHSR8qF0I1zlphAoJi/QaN5hT3KHcbICXXRlMuSPaU6E6J
	Xo/RSnRgoXzl+ck0jggBIBg3VKL2oCZGt0tk/aveyR7RDIIFn0SA6qUAusOgB4f8
	ADjNDZPQR8c+LTcJ8mLVv5BgODY6c69/25pmdMeDg10CBSSHrcSJzEDz37nBBT4W
	mCYqBr7c9RSQ59OobDYjutnOULP23EzP3csAK9ng==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m7wqbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 09:30:24 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AA9RiIv023550;
	Mon, 10 Nov 2025 09:30:24 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m7wqbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 09:30:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA98nS1014779;
	Mon, 10 Nov 2025 09:30:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aahpjvuq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 09:30:23 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AA9UJ0S50725350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 09:30:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D2AC20049;
	Mon, 10 Nov 2025 09:30:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 828DA20040;
	Mon, 10 Nov 2025 09:30:18 +0000 (GMT)
Received: from osiris (unknown [9.87.148.55])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 10 Nov 2025 09:30:18 +0000 (GMT)
Date: Mon, 10 Nov 2025 10:30:17 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
Cc: Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v2] s390/fpu: Fix false-positive kmsan report in fpu_vstl
 function
Message-ID: <20251110093017.15528A26-hca@linux.ibm.com>
References: <20251107155914.1407772-3-aleksei.nikiforov@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107155914.1407772-3-aleksei.nikiforov@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MtZfKmae c=1 sm=1 tr=0 ts=6911b0b0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=bXxCFtWIKm37yWNRadsA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: a0sNEDIK0Gr--rLC5ZSC2Y2pLdE44ef_
X-Proofpoint-ORIG-GUID: YUzRASJ9uQFIpYFhIfz1zgYQR8wytDKp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3OSBTYWx0ZWRfXxogod00QcIgV
 uxzUe+g7lz3lHaOCnwEIxcVHN5gGOWoXZ4HO3AaCLusqFGOjBDLJPqo/nj5V2QcMXLdbuQ3yzeC
 yGjUrcMs6PFrGTOMLe+ryZ9gwyXpsEcTxMbyz3n0IVCUZDaK0PzPSuflo3MqHl/AF47x+HjBiZu
 mArNAPbyOFpxPmK6t3OMmQZMRf8yBdfaMub4j/NXDOoGDu+TIFDjFd0UcUIBO1SbIGQuLR4ziBm
 QKZoUS4BGk8Psx/eGR9wV16pq2pi96nq6FAALcmU+W/zFnBc4fK1mW5WZRQfHauKspnGi5bFOwv
 5+1XmMwbTAeR1j2GWHDjDQCIJ06lgkAv+BSao8HI5bO7cvGZVJ7kRqKqyEKbJyu0lyC8wjD+V/l
 2KO0TYZNxD90EkhEXnM3isnZIJT3vA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080079

On Fri, Nov 07, 2025 at 04:59:16PM +0100, Aleksei Nikiforov wrote:
> A false-positive kmsan report is detected when running ping command.
> 
> An inline assembly instruction 'vstl' can write varied amount of bytes
> depending on value of 'index' argument. If 'index' > 0, 'vstl' writes
> at least 2 bytes.
> 
> clang generates kmsan write helper call depending on inline assembly
> constraints. Constraints are evaluated compile-time, but value of
> 'index' argument is known only at runtime.
> 
> clang currently generates call to __msan_instrument_asm_store with 1 byte
> as size. Manually call kmsan function to indicate correct amount of bytes
> written and fix false-positive report.
...
> Fixes: dcd3e1de9d17 ("s390/checksum: provide csum_partial_copy_nocheck()")
> Signed-off-by: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
> ---
>  arch/s390/include/asm/fpu-insn.h | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks!
