Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34B22E266D;
	Tue, 17 Jun 2025 13:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165721; cv=none; b=iV8eApQNmQ5VexkC7HHpO03UnyWdJWHxUS9VC2bhdfpvibgUhiV4hYgUrtZnhjnOdMrxCC+9vDGhGCD9Z0naNeBXWubzD7d/vTg2RlSqytQLSZ4R/Oyfu87aH3n+DPOObPzYGmqZnr99mlghkRM3XsS3UbQNz9PJVFA4LuBnK/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165721; c=relaxed/simple;
	bh=4cMoozZix6jwpccdOFxjg09XGLJZ1sQdbLitLppvKqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOYClryabrG7kEVaAkocJy+YZAz7rTymBAwTuHHPxZ5fbpVFsq0PoixHqxkv96vzZNy8dlvLmDbbCzC7TqVPA1jW3uM5AC0cKECKmxtdHJoHnsRfTzE8sn/K5LhRc/ex5Q4CIy07x7mEdkeMF5JzhRkqUb09wkGaV+xYIL2CfUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cE4g/NAP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cE4g/NAP"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H8SBTp017991;
	Tue, 17 Jun 2025 13:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=p5Zxse7e33GhKYCPPhVo4RKuXPasj0
	vsR46SoWT4Vlo=; b=cE4g/NAPVIOb4hSoMezqqe56UDUnOWbhBgMDTohME8XUXH
	frMOH50hyGZB+NuHEmUPTqHQ9anDmljvxvqNUbhoQcO+hj4tQcPxtvm2bwNzGVzN
	uZsGUds6S+UaGkigEibjc5KrT8v81ptbDv5mIEpiIE+C9S9ZUZBER+AWj1iQs0Ii
	9V0BjKlJtYjRvvYtmAzkYDdd98nEzFT5ONP3E+IqerJ5NLSlSjzKTyUwJ9RhiCMc
	PC/DPy+Ma4URaicfr0svf2qhzm4pqh5Yg84w8rnBkPSM/3KLLIVypD1nPfeU/Jn/
	4IfNF4Ah0AhVgUcwYAUy3Ct7dgdXTJnoE1Y7JCFw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790ktgjry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 13:08:10 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55HCsuMf010266;
	Tue, 17 Jun 2025 13:08:10 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790ktgjrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 13:08:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55HAODNF014278;
	Tue, 17 Jun 2025 13:08:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 479p42b7rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 13:08:08 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55HD85Sl20382042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 13:08:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EBE42004B;
	Tue, 17 Jun 2025 13:08:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C93120040;
	Tue, 17 Jun 2025 13:08:04 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 17 Jun 2025 13:08:04 +0000 (GMT)
Date: Tue, 17 Jun 2025 15:08:03 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
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
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Kent Overstreet <kent.overstreet@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-s390@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Subject: Re: [PATCH v5 1/1] mm/percpu: Conditionally define _shared_alloc_tag
 via CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU
Message-ID: <aFFos/pmtkur+Vmd@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.1750143986.git.gehao@kylinos.cn>
 <7b912b54cdc12a3437edbd50dbadfc45545641b7.1750143986.git.gehao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b912b54cdc12a3437edbd50dbadfc45545641b7.1750143986.git.gehao@kylinos.cn>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kur0rvAEx469uj5a4sV_PVMfgwluIMH1
X-Proofpoint-ORIG-GUID: qeKjDJ8XglqOooSmeigyj6AVgCg4ohGO
X-Authority-Analysis: v=2.4 cv=KaDSsRYD c=1 sm=1 tr=0 ts=685168ba cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=PyGK1ZaQhdLI2C9XA_0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA5OCBTYWx0ZWRfX3O1mozk6l+7U qZmBnT6UGHDnfuTVGo5MP+yTvQAyDOhlzpgWd5VtyDHCL3hXrZMcmhAIlX+U1oNetUntb6vqTjE buYjbbRwSMPoEnwV2F2dwj4UPObc4qQDFB2Hleqp2iy2CD4ZKtNb6pFL10OEjQkCuqA0tP8mnjk
 vq+/UYKJEWMsaxR62JJc3xp4pfO5Dtu70cvfdRHqvBOrS04p9ehWoGW0r3G+cfU6VrNfdsGc6K5 pf2ai71sc8+8xZ3mp81VL3GKW0iBCcSxoRl72XqFFfDsHcw9bE/7t+/+78pzDzzkdBvfIOJjA+2 sNfc34cr+IpSGsSri7SE0L3xZbd8CbVvMNphj17GWXhXaN8uFnFEmPdIbE4tojSC+dU8DekLMmD
 Z7DzGkt1sGK+pU8bsVIyJVcXw4FJ4SMQzxgn1Y5/KaY1+WeGi+Xjild7nh9fMI9JNbW8pYzF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_05,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170098

On Tue, Jun 17, 2025 at 03:10:52PM +0800, Hao Ge wrote:

Hi Hao,

> From: Hao Ge <gehao@kylinos.cn>
> 
> Recently discovered this entry while checking kallsyms on ARM64:
> ffff800083e509c0 D _shared_alloc_tag
> 
> If ARCH_NEEDS_WEAK_PER_CPU is not defined(it is only defined for
> s390 and alpha architectures), there's no need to statically define
> the percpu variable _shared_alloc_tag.
> 
> Therefore, we need to implement isolation for this purpose.
> 
> When building the core kernel code for s390 or alpha architectures,
> ARCH_NEEDS_WEAK_PER_CPU remains undefined (as it is gated
> by #if defined(MODULE)). However, when building modules for these
> architectures, the macro is explicitly defined.
> 
> Therefore, we remove all instances of ARCH_NEEDS_WEAK_PER_CPU from
> the code and introduced CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU to
> replace the relevant logic. We can now conditionally define the perpcu
> variable _shared_alloc_tag based on CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU.
> This allows architectures (such as s390/alpha) that require weak
> definitions for percpu variables in modules to include the definition,
> while others can omit it via compile-time exclusion.
> 
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
>  arch/alpha/Kconfig              | 1 +
>  arch/alpha/include/asm/percpu.h | 5 ++---
>  arch/s390/Kconfig               | 1 +
>  arch/s390/include/asm/percpu.h  | 5 ++---
>  include/linux/alloc_tag.h       | 6 +++---
>  include/linux/percpu-defs.h     | 7 ++++---
>  lib/alloc_tag.c                 | 2 ++
>  mm/Kconfig                      | 7 +++++++
>  8 files changed, 22 insertions(+), 12 deletions(-)
...

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com> # s390

Thanks!
