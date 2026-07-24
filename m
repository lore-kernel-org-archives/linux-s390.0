Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70AA37E5D8;
	Fri, 24 Jul 2026 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784883712; cv=none; b=Q++ZF3QtdkyO8izQA7zOOy3EWc+1iLEmQfWP51einaevwScqyEMCJHknjzFK7VIu+KxDJaSzpt9gos6tuVEDwI/ALTynG+5a/8mDWSZV2VmVpse+ueKq2MOROz5MojLcufB3AbGvOlSh8rpH+6OJAv5G9bKZ6klR2iPPSlaovaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784883712; c=relaxed/simple;
	bh=B6cBuqW1GXSKhY1v0IZCbngGB8JY1YFm6s2hZi5KjhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilDZn3shKXzWmIzp6RRoovAnpoYEMlfAlKlUP2xCSPfmwJjtjF+HGzum6YXvSCv6z9hqIPhhsBioJrgyBWlqywjdMzFFp1LLuCn+nLE5im8BXLT5Snti1SOsDqw6Uwa1O22wwXCj30VOiMQ5Y/ENvBsVPdaGbdlQPZBEuDnbwhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=esmnImKX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="esmnImKX"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O5Bv0R825795;
	Fri, 24 Jul 2026 09:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=mDQ6cVvIFs9Ixg4svmqB2Fcrqs74sh
	RtpGEjHTDa3p4=; b=esmnImKXCoA8842f5wuW2toRMITm6iILhzuAiboAYyz4Yy
	MHzhrujMC4sWiABYJ5y7JJ3ghgbSehKJ0dGyvM85TD644zDEOlOn1KvI7Na12o2F
	knAdPDwdHNixf6zqLqfUVPoPi1Z1vHWzVEtL34/rSn26PRTv/v6bznLFPgSgTJ5K
	eUILzqdSs/65ubhS1qWa3Qfj2XbIQxSvNYa+i/EyBuEWdsShhgycEz4QWNXzBWeh
	2lG0HaOxIZHHikXMm3N9WRVvpVRWDtuKBE2IdcXPSrxuXepqWZKmYwJK5qunhSzL
	1uvaHmkFHYKjFnX3rvEwY/CH7nHzIUdtEGuyXtrw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kk9fs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 09:01:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O8nqd7026920;
	Fri, 24 Jul 2026 09:01:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahg5fa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 09:01:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O91hSL47710624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 09:01:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 482912026C;
	Fri, 24 Jul 2026 08:40:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD8E620269;
	Fri, 24 Jul 2026 08:40:17 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.82.167])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Jul 2026 08:40:17 +0000 (GMT)
Date: Fri, 24 Jul 2026 10:40:16 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] s390/mm: Fix handling of secure storage access
 exceptions in vmalloc area
Message-ID: <c10b144d-22fc-45f3-b684-2adf88dbbceb-agordeev@linux.ibm.com>
References: <20260717092415.3039699-1-hca@linux.ibm.com>
 <20260717092415.3039699-3-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717092415.3039699-3-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a6329fc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=UbbVNIISdgRz_8cPp8oA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA3OCBTYWx0ZWRfX5nGY8U1gv7z6
 ct8sQPMI4ORiOpGkcHXt/GEQm2HEb8rdo4U0gYy8IOVoBSdH7apwKtMEISV7falKNLVEW2XCv8c
 f6SWBr3vRe26O+oUp7jDBXs61uKGyo/qPeGdA/3ROBKqmb8wW1PiPtADUCSo5KsIEdeTzN0qVXB
 CgIr7FkAIUOWW0L1XQpSbU058p13nru2r1D2jQF4cTeIXAXEeN04MGdWgvnglPQ4N6YU9IndGmO
 vJRW15RgAYIyDHKB+++DJEblm7BN6AuxVz4uqLpAkN7e4n5KsSI0a2nZjzCO7nxQMGC1AzfqhLc
 exBd9KbH2vqCdNvgiHzaLMnU/xjWZiYQGJ/YIhm+uBCz/6g+KAPeZwO1o+zk6FgenGLVcjasNHP
 FfSzrnRcAv5VoTohd8xMG85JOHrWTWkXT4Nn0qfRgxzrjjy3/8FkdxD1NTcoAlk5RkSR2aFCN5Y
 arDD73sY8uwtVmigW9A==
X-Proofpoint-ORIG-GUID: 5ISxxLQzb5IJx6l1mJnn1BZ6wgSiRp27
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA3OCBTYWx0ZWRfX2PpLdc1JxVEP
 Q79n+RRxP5U20ARICCtzplkIiRnVCijRF2jcjO35QrANkwemuxFzbcq1lzHzp9ys54RysgJmhfF
 Yb2rhGyuVe3zShggH+enl/Uk4NIIBPU=
X-Proofpoint-GUID: 5ISxxLQzb5IJx6l1mJnn1BZ6wgSiRp27
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240078

On Fri, Jul 17, 2026 at 11:24:13AM +0200, Heiko Carstens wrote:
> Secure storage access exceptions in vmalloc area need to be handled
> separately since folio_try_get() or virt_to_phys() do not work on such
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
virt_to_phys() is not called here directly while folio_try_get() does
not accept the addr parameter. Did you mean just virt_to_folio() or do
you imply something outside of the context of this patch? 

> addresses. Given that there cannot be a valid access let such exceptions
> fail immediately. The kernel will either fixup or crash.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/mm/fault.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index 028aeb9c48d6..392e46742039 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -438,6 +438,8 @@ void do_secure_storage_access(struct pt_regs *regs)
>  		panic("Unexpected PGM 0x3d with TEID bit 61=0");
>  	}
>  	if (is_kernel_fault(regs)) {
> +		if (is_vmalloc_addr((void *)addr))
> +			return handle_fault_error_nolock(regs, 0);
>  		folio = virt_to_folio((void *)addr);
>  		if (unlikely(!folio_try_get(folio)))
>  			return;
> -- 
> 2.53.0
> 
> 
