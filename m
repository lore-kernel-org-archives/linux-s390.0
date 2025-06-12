Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADAB205AA3;
	Thu, 12 Jun 2025 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749727374; cv=none; b=b1isSbGzuY2Cf1MJ66NcrvW4JMwF2HbL9nEEZDC32NrjtL7+Pt5bS16RVR6neXRYRRic0Sq7ITQ3QNEb11GsdTzlpgG/hrI8Kt5Mg30lzayJrJVY+GemzNTM8k/OB50H6DMtOs6AfO8oYaCix1/MbuuZengObecomxoqOo9ihO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749727374; c=relaxed/simple;
	bh=WX7P5uPL90hx6cv1d1k1CPGBaUchyS807lFC6FHItBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXRgFA5G8AAftwC7btjP4EL+2twuzATvYCSBpmf/iZOu+ecqLejjeH038B7/GNzZh2EazixmI9mkGW1DNMRDauzL4ldSpPiVM1PrwGGTDoNYky+UVCSO3fSX56sFB+sJS5yy2/v8j8C0oUr4XGJmiGnvhZn8hKV0WD/fk8lrlPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S+0Ier0z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S+0Ier0z"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C4AaaR027824;
	Thu, 12 Jun 2025 11:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=3STLFyJlkAtONNswVp9fcHwUoZ12uc
	3WwYjMNueQd2c=; b=S+0Ier0zEIGIw5PjDxw6VYXIDMZoNTokcmPlzb0mpYVaoQ
	TH+GKYaAIi9YTm9H96oBwmVlzv0GiPt7tzO1mciJbpqlOPq2lI7JYJlKmfi1fTfv
	NwbCaTyLWQlKJ+TIDh2dFtt7gxRynLQ4pM+nW92vuoQAuBK+zg5yH8uRrTBMHdxA
	caZraOnjhek2O5xICThS7KstoKCeeh+3nrlCEHO4unOofwTxAD7XceVgVCzfGqKS
	laqBAOJ1Cb+xH8oMfBsangs060yK5e0n/uy4Y/XrHbbF4QuquGW7vs90PK1rQisK
	nxMhJekZR76gI5pylyjhxXix0pym8FeGvug3CtEA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4mfda8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 11:22:23 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55CBLWRc029468;
	Thu, 12 Jun 2025 11:22:22 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4mfda5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 11:22:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55C8AAnb019573;
	Thu, 12 Jun 2025 11:22:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4752f2m4uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 11:22:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55CBMITF55837168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 11:22:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 654EC2005A;
	Thu, 12 Jun 2025 11:22:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49AE82004B;
	Thu, 12 Jun 2025 11:22:17 +0000 (GMT)
Received: from osiris (unknown [9.87.144.171])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Jun 2025 11:22:17 +0000 (GMT)
Date: Thu, 12 Jun 2025 13:22:15 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Hao Ge <hao.ge@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Kent Overstreet <kent.overstreet@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-s390@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Subject: Re: [PATCH 2/5] alpha: Modify the definition logic of WEAK_PER_CPU
Message-ID: <20250612112215.10868Da1-hca@linux.ibm.com>
References: <cover.1749715979.git.gehao@kylinos.cn>
 <4d78498def57e0df4c768ad9eb672cac68fb51dc.1749715979.git.gehao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d78498def57e0df4c768ad9eb672cac68fb51dc.1749715979.git.gehao@kylinos.cn>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Y4X4sgeN c=1 sm=1 tr=0 ts=684ab86f cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=1XWaLZrsAAAA:8 a=qgZoHugHpSLCC5hwMT8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: cFaCM5ioo6oV4W252CJQ6_AbeOYbv0MG
X-Proofpoint-ORIG-GUID: 4eZjzSqrsFgGxPf8TxMGwJ5ywHDFaxa2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA4NiBTYWx0ZWRfX9kqynoea00ca dw1P8MwVNzix+KaE7qPljPCZbvhxGYU11FDgEnQxCjnYKwnhhBpm6fg/TMDNf8nRMXYA4IH7jLz b/0gfJm57nuOFAAmBPDYe8kjqj8H+YhlZiZx0BnJrwt3vBG2hyR7cZ5Jn2W3L4/6EsWfg6ZugBK
 GlofawOkvsQrAH6/iknx8NlH7TiIFqihJyZ1LoZH8Hu4M63F5KvnDMW5ZgR973eoeBr8at+FhXx wQrWzesedZuQh86muM9uEUfojqVJnAq2ii5JB9/N77UpzOzOhm8NQadzFwQarApvM0ghLC29AQ9 JSdoBGYous175eq60+1nPaoxMKnBdOeGZ0Zbuh2IdAZCfo8yf/hDvgHj2fdY4wJTU+Ci9OwUnee
 sMm6IGCPItF/A8/mN44Ex4TmPJ18WEyVZcHcHFBveYf0UDDbTcABy1vTLhigl/KGmV7POEmN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=716 spamscore=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120086

On Thu, Jun 12, 2025 at 04:27:27PM +0800, Hao Ge wrote:
> From: Hao Ge <gehao@kylinos.cn>
> 
> As stated in the first patch of this patch series,
> we make ARCH_NEEDS_WEAK_PER_CPU a Kconfig option,
> and replace all instances of ARCH_NEEDS_WEAK_PER_CPU
> in the kernel code with MODULE_NEEDS_WEAK_PER_CPU,
> gated by #ifdef CONFIG_ARCH_NEEDS_WEAK_PER_CPU.
> 
> We'll make corresponding changes for the alpha
> architecture.
> 
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
>  arch/alpha/Kconfig              | 1 +
>  arch/alpha/include/asm/percpu.h | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)

...

> +	select ARCH_NEEDS_WEAK_PER_CPU
>  	select ARCH_NO_PREEMPT
>  	select ARCH_NO_SG_CHAIN
>  	select ARCH_USE_CMPXCHG_LOCKREF
> diff --git a/arch/alpha/include/asm/percpu.h b/arch/alpha/include/asm/percpu.h
> index 6923249f2d49..5d8b75ec3bf2 100644
> --- a/arch/alpha/include/asm/percpu.h
> +++ b/arch/alpha/include/asm/percpu.h
> @@ -10,8 +10,8 @@
>   *
>   * Always use weak definitions for percpu variables in modules.
>   */
> -#if defined(MODULE) && defined(CONFIG_SMP)
> -#define ARCH_NEEDS_WEAK_PER_CPU
> +#if defined(MODULE) && defined(CONFIG_SMP) && defined(CONFIG_ARCH_NEEDS_WEAK_PER_CPU)
> +#define MODULE_NEEDS_WEAK_PER_CPU

CONFIG_ARCH_NEEDS_WEAK_PER_CPU is always set with the above select.
So there is no point in adding this to the check.

Furthermore this removes ARCH_NEEDS_WEAK_PER_CPU and defines
MODULE_NEEDS_WEAK_PER_CPU while the common code conversion happens
only with patch 4. Or in other words: if patches are split like this
things break.

Same is true for patch 3. Just merging patches 2-4 would be the
easiest solution to this problem.
