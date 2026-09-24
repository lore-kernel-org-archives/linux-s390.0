Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083C14A0EF3;
	Thu, 24 Sep 2026 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263932; cv=none; b=kaDSrTf96xg5wE+Mk3x6JD2+CAFBNc6nS/LP0klyABu2T1T9NV/m9Sgrjx9LRAwTgM9r6jpQ4Ik8koQ6V1+Pzfmr5tejnKRNpTg0aAaZIpM7QIbhIqsmkHyr/k3C/w81aIF7kSEIQSDkvhof+NUoWP76sctRJiZppbeDtU3oBbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263932; c=relaxed/simple;
	bh=Q07bjrNmLd3004LYEqADn3LgL+m1IXHndxRg/zmhPoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZT+MU5SH/iTuenFAfytNCIIG/IZ0aqTwqJuOb9BKqUKRSY4fAzXh9tlePzz0KSeJsIFMNz73m78ThhVFejGTvtqKJ7iIO4aZ7XknCVLLuxV9HXVVFA5bQdFrTWq80nSgF9rl/rnPqdBRVOE0KdiWex/dB5VHaVVgALuALGfBAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YzQjlSwv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YzQjlSwv"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OC6HwH314968;
	Thu, 24 Sep 2026 15:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=VnyebmH3hj23KfTlR+0yYV0CI7rYbi
	irwByR/BvP5+M=; b=YzQjlSwvCMlhnctkyUoJFMD152HZQshRU0r2h9IhnDr9m1
	rJuHc8Fu0osgbgCfX2s/wAt2hsu+92ck7hpoW0vzzaDANaKRyIq9C62q1lpYePG+
	qxzX/9ervcfMZEusIoRxuJAki+wRT0z5u/pFHfLpgIJJ8mkhX6+gMI9a/2UbUL3H
	LCHoQ+G+2TKTkJo1vuBKrweR6YYE6PDwEGP4rcjijKMpxjdqMhR1ILXw5aE+PAIV
	vfzq+BcyLby2WDSspxdg6/yRtQwakK7JMh3c1K6aYpyAwkSeSq4eB1A15crm+D3/
	7s3lGN8VAphZYfCE3wmPbTUQuL0n8j4OrH7Lk+uA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske2200c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 15:31:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OENe4G2243730;
	Thu, 24 Sep 2026 15:31:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qpfmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 15:31:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OFVesF36110630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 15:31:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3631C20049;
	Thu, 24 Sep 2026 15:31:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA72620040;
	Thu, 24 Sep 2026 15:31:39 +0000 (GMT)
Received: from osiris (unknown [9.111.55.6])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 24 Sep 2026 15:31:39 +0000 (GMT)
Date: Thu, 24 Sep 2026 17:31:38 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/kprobes: Prevent kprobes on instructions with
 exception table entry
Message-ID: <20260924153138.18402Bb1-hca@linux.ibm.com>
References: <20260924115725.1108581-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924115725.1108581-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lNZ1LKJH6LofHFxX7brlM0RLm2t4JBMg
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab54260 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=6zlbbHazvbHoJyaoz7kA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MiBTYWx0ZWRfX1M8hYZvqr+GC
 GXJN038e/DsDwoLme3esTR5RVtYFCl7zcyupjtAOlO3V8/tJf15rDSMoPFxv8DM1ZyX1nXO+j6d
 RmWG9L28qtNhVdKP+tDXRV5Rhnu1EpE=
X-Proofpoint-GUID: lNZ1LKJH6LofHFxX7brlM0RLm2t4JBMg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MiBTYWx0ZWRfXyNRg/U6olkTL
 l/BTC77ZZ1E4L7XnshzrabFZyPWkUUqLJ19msQw2YjnM87I8j/Di7F+fsO+/K0McMDkIpUeBAEU
 oH4I7rqEIHLPH6wNhAcnf9mZM22nvgAHtv9xNoXi9mj88l5zICDkShm1iuDBl4EZDcsY96NYAGT
 5EEBLJjlnKpnOLuYHAl+aJDah5DJCjdmfRYQB6ZR1GRIlfW6+PMIiwYvRbl+ZQ/pitEph9CJ/vV
 j/o30nzabcozcuGbHsYv/yZZTFV1SqDhseOH9sv577avxDp4Jp8b+Ux49xKHBKgRBwu3PlmjdaQ
 i0hcq+JmK34INHskqgm61JBy3rKnY7MrwJTX7hL95kjF3tCBhCJKQfNeTg8Yfm/cCwTxj0LnQIa
 +BLoVtTqIBZ/dd3fcMxsXP9NfibIUCl+e8zLCYiL33j+Jj4Pbt0R6YWlEgOJgxGI62A6Bqtagf3
 nEWR2dM9dHfefBnyigA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240062

On Thu, Sep 24, 2026 at 01:57:24PM +0200, Heiko Carstens wrote:
> The mvcos exception handler ex_handler_ua_mvcos() decodes the faulting
> instruction, assuming it is an mvcos instruction. In case the instruction
> is kprobed the decoded instruction is a breakpoint instruction instead,
> which leads to incorrect instruction decoding and potential register
> corruption.
> 
> Fix this by simply preventing to set a kprobe on such instructions,
> similar like arm64 is doing it.
> 
> Fixes: c488f5187a24 ("s390/uaccess: Shorten raw_copy_from_user() / raw_copy_to_user() inline assemblies")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/kprobes.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
> index c450120b4474..e806b124e4ba 100644
> --- a/arch/s390/kernel/kprobes.c
> +++ b/arch/s390/kernel/kprobes.c
> @@ -85,6 +85,9 @@ static bool can_probe(unsigned long paddr)
>  	if (!kallsyms_lookup_size_offset(paddr, NULL, &offset))
>  		return false;
>  
> +	if (s390_search_extables(paddr))
> +		return false;
> +
>  	/* Decode instructions */

FWIW, I believe x86 has a similar problem since it tries to decode the mov
instruction of load_unaligned_zeropad() in ex_handler_zeropad() which was
introduced with [1]. If a kprobe is placed there instruction decoding will
fail.

As far as I can tell there is nothing that prevents that a kprobe is placed
there.

[1] c4e34dd99f2e ("x86: simplify load_unaligned_zeropad() implementation")
