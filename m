Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352693845B7;
	Wed, 29 Jul 2026 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343567; cv=none; b=ZzHCVXCvO+nK0YmMA2wfidUo0BwZxA/XiQ9vp1KgDVq/uncu7ihFEre5hT1+P4j4o+TYGt59Xk0OVJiJvGLtmTgq7jJKC1Hx67f9m0iW5EL92S/Fpel7E6AK2CGdG7h7C/xpsys7YTrRkZ/EbnEu7gFbvFKRNL9OOzQ2pZqAGXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343567; c=relaxed/simple;
	bh=QPuaC3dxlEPHEINgArjQH66qzKbZGl1PDBXu0xoryaU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XpZASfPKd1k3fDOMuV9+qBZL72gUvWU+qJj1sSJ1eOVQbB5ehAszVTyDhYgwBd/jymuKv1TKTaMMxmpzfe7MJ3+KavscNRvHwX2LgAJLaKMak7cXOWjYdadH2Gl3kd2b8iRc74B1Tm2mYzWh1h1Tvx9+1yzRCxBZCftV8EFh5Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZBIo/TCf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZBIo/TCf"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFHeXH282821;
	Wed, 29 Jul 2026 16:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ScA+yq
	vkMQ3Yx8fPuej7n5EGazacuYoTqHeteFF0W+U=; b=ZBIo/TCfYgEC1mGkk/z/8r
	/G2TZqywegt6q9kWWjW8j9ikg6ir2SeZ8J2vZamOyWRSIfEZq35b7AfBAES+Fyzm
	8KHFgo12ebALf2frS7BDoue+t1pnvELhg5how8w5tdFfUW+FDAugv9JAsyM+StVC
	3dpzje7uLMNuwg2tQlrpieDQWo/1lxQPjFQhqsuOJ5U1Is6iDqA1uqeBOV5E89si
	8bRg49msMcrQPIt4ix5Un1wqCj9ubndZdoyRw25Z/H3YZ/jXzLBbY70SnebMziLo
	tWFhHvICaRnWnHF9LcqiE+6vuJyLvtux6clyNr3Pmys1cYjvEMby+i74ozidrveQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0ntwkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 16:45:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TGfOFS020910;
	Wed, 29 Jul 2026 16:45:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhff3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 16:45:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TGjoXu33751424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 16:45:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 968B020040;
	Wed, 29 Jul 2026 16:45:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DF3E20043;
	Wed, 29 Jul 2026 16:45:50 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 29 Jul 2026 16:45:50 +0000 (GMT)
Date: Wed, 29 Jul 2026 18:45:48 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        Harald Freudenberger
 <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Vineeth
 Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter
 <oberpar@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David
 Hildenbrand <david@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] KVM: s390: Remove cond_resched() calls
Message-ID: <20260729184548.38b7c791@p-imbrenda>
In-Reply-To: <20260727162430.1599396-3-hca@linux.ibm.com>
References: <20260727162430.1599396-1-hca@linux.ibm.com>
	<20260727162430.1599396-3-hca@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyOSBTYWx0ZWRfX7ia9hMX2n0Hv
 uHZ1rTcX4iMbsEw63VZtANBtLKE8HvQG0vTRnZRbXRS4dwTcpBfbNqg4+i927hdxT75M+bk3WeJ
 aX1QNnb92OToZ91tWrn5Cy60wuk0v+Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyOSBTYWx0ZWRfX3gq5sJ0UDGet
 uGK0X2WY1QpD4kwNvF3xUTZU4TdGBJJOuap0yfrxmvMg2MnGLtUENMUaj+EF7m720mPLx29uo8v
 YBMch0Yf6cxPcGthKUrK0sdoToLvWw1NyA+zwSJ0HHzz6kylf+bcx2bQWmbyJQ2dm4ZoGRBlK95
 /IxYQ2WiMWKlh7NpePxYQDAdt4IIHJjiqBLYVcptLZLEhe79ymDlZn6XNIsABMZAhN1m+oh1cch
 +pXQ01ZQptKWHMICRwUZU6fp30nmbj+7G1V+NvrMFNDCQOXNBP2ICph6Jd6fmLk1tg/3aEJY2CD
 EYwNgN8j8Uerly/KtzzKl1ONQz4lZfCRwQcmQ/JX4asrbXaYDnxbbs17dJtKCQVzMtbz8sJfTiT
 Z4HiQfS9K2Nf+cJOOcKJd3NG59H7i5L6YFobP+oa1ILYzKzgyWdJNqsajbY20t8sGn3WsVe4VW8
 641TlCe4Uons2FeKy6w==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6a2e43 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=46ucpF2riSQio0EZcHYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Kg9jgJS_JnBR9It7Es2Eglddsid6VJHo
X-Proofpoint-ORIG-GUID: Kg9jgJS_JnBR9It7Es2Eglddsid6VJHo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290129

On Mon, 27 Jul 2026 18:24:28 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> Since [1] cond_resched() is a no-op on s390. Remove all calls.
> 
> [1] commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/uv.h  | 1 -
>  arch/s390/kvm/gaccess.c     | 8 ++------
>  arch/s390/kvm/gmap.c        | 4 ----
>  arch/s390/kvm/kvm-s390.c    | 1 -
>  arch/s390/kvm/pv.c          | 1 -
>  arch/s390/kvm/vsie.c        | 1 -
>  arch/s390/mm/gmap_helpers.c | 1 -
>  7 files changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
> index d919e69662f5..795da130342a 100644
> --- a/arch/s390/include/asm/uv.h
> +++ b/arch/s390/include/asm/uv.h
> @@ -461,7 +461,6 @@ static inline int uv_call_sched(unsigned long r1, unsigned long r2)
>  
>  	do {
>  		cc = __uv_call(r1, r2);
> -		cond_resched();
>  	} while (cc > 1);
>  	return cc;
>  }

so now uv_call_sched() is the same as uv_call()?
just drop uv_call_sched() then


[...]
