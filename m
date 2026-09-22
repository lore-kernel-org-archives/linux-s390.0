Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845034F391B
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790073310; cv=none; b=jt9VORFbBSkOV+ALI2hG88+Fo2dImra/11m84jHW6OVw2tz3lAmhklYG54d8ARHOAz4Spa5ILWmxY9cZW2+wvZIv2qAYZJmHd6sheRDsnQh2kRRU6+xc+ae+9ydO0WAZcXVCOBpfWTnJN6jOk840E0f60ZO5Mw2UAEMDRCjmEyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790073310; c=relaxed/simple;
	bh=9SPKXdejKSVe59K2K32lnllXmGoWbDx0Aqxb4rmcRrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcwSrXyJ+N+9nkZLdDNLvObbo2+SGmTCGmXSsH51Pk6GusSZKj7gOiJ9uhtNsJJVvzrckNhp7poGeQ/xoGyn4B99BSeQCiInDM1esgnViBfWdpZ0w7vPXyiFUQDNx5cr7NgWIRbg5t538v0PZLdIHhW7LHqy8P7By/+bfnxqFWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PVoYWfJf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PVoYWfJf"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M05M3H2939911
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 10:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=95133OOphoqyG0VO76Jd8QTqNDfQ+J
	M/2XwWO1ppHSU=; b=PVoYWfJfk2T40eh0siAKFZhnUNJ98c5LjYeowlH2zg6RBB
	FnHz1F/I8xFtNMb/HAX9H5SLkkEJlF9lUrxstzFK5TnbzWkY3NcRf7WXCCy9u5AB
	xr54Amlf88asrhzCV7aeXyMdMU6DDHSyZy5lTEk1nUWyZ9e6Up+irVAQgdJSrPx4
	mc4vd5fzHbbWIC5CfLz45IvZzrAqB9LXytXE1nhIMghzjqA+wvoE2GqFYijF0AMU
	LKA+BdcIP2fCedqi6d1jql26DjO7bKbX36PssTCjvxhkwW71OLSseRR4IDymoaOP
	GfbokRE4ze/wc85wZCQV5GRPrAz/JPMyCfLZhvAg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2d8de-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 10:35:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68M9xZsp2995401
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 10:35:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dy964w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 10:35:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68MAZ29x49873256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 10:35:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9D5A20040;
	Tue, 22 Sep 2026 10:35:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F0AC2004D;
	Tue, 22 Sep 2026 10:35:02 +0000 (GMT)
Received: from osiris (unknown [9.87.153.113])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 22 Sep 2026 10:35:02 +0000 (GMT)
Date: Tue, 22 Sep 2026 12:35:01 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH v2] s390/debug: Fix NULL pointer dereference in
 debug_info_copy()
Message-ID: <20260922103501.10121Aba-hca@linux.ibm.com>
References: <20260916160626.1988684-1-zaslonko@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916160626.1988684-1-zaslonko@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 36mt5-hQ3ZX5UVJUqqC-H3FpPkuZ520v
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab259db cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=gheRGZjsO9QmUI7mxtoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE1MiBTYWx0ZWRfXwwLkbvVeSO2E
 /a9819T27OXWbfgqzu1EHvpM1pcksT20RdQ0x4alnBQxWjnosxi0laUAPggvCeUcsnssfxik5FE
 CiAqiKmZEKi/pXfz79NYSEEp4QDpc1qFCN8ea77pPukHrrYzJUbgFWfxYi/Gdf8JjfmM5osHG2j
 o94mZYLV6M9XAeS9GmkDxXNnMRBgV2kyYDMvmVQJns1uXSuJcfYto5LL/JkjcYJk6Yg1ud+S/pT
 LHITttDt8q9tLjb+O2O50LNeXMdjGXUcqF6TatT/oqWJF+KK1R9dmlqJYHfmwcbuAlfo1ztwXyM
 0Q50RP/dPewFRw5qZbPj1eKF0Z5FrLgvuqwKznBU7WJ/Q9ns00nEeSpVey2hAr7DmZWrwJdAd9v
 BgyDSenni44memOLaqf+e8/tZo/hNEfEJE1nPGM3KAlkZLKg/EJF9Ev+H0aNSlQLzocr2rAkTvq
 l00sf80zfbCNS1/fJXw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE1MiBTYWx0ZWRfXxWINBcq+ydin
 dhl8So9gz/X08KsaXcg0HVjGzBlTmH7zA3cR+X9Yd65duZ6CVOFv9aEM5iFHXBMxNpBXojJ/M0G
 /2AOGXzFowHcOCy+gWPMwpfG++pIt6g=
X-Proofpoint-GUID: 36mt5-hQ3ZX5UVJUqqC-H3FpPkuZ520v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220152

On Wed, Sep 16, 2026 at 06:06:26PM +0200, Mikhail Zaslonko wrote:
> When debug_register_static() fails, it clears areas, active_pages and
> active_entries but leaves the area bounds unchanged. Copying such an
> area, either by opening its view file or via debug_dump(), makes
> debug_info_copy() dereference the NULL pointers.
> 
> Skip the copy loop when the source has no areas.
> 
> Closes: https://lore.kernel.org/r/20260903132123.12F271F00A3F@smtp.kernel.org
> Fixes: d72541f94512 ("s390/debug: add early tracing support")
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> ---
> v2:
> - Different approach: check the areas pointer in debug_info_copy()
>   instead of zeroing nr_areas/pages_per_area in debug_register_static().
>   Zeroing nr_areas made debug_info_alloc() return ZERO_SIZE_PTR for
>   active_pages/active_entries, which debug_to_act_entry() dereferences
>   before debug_prev_entry() checks id->areas.
>   Checking the pointer also matches what all other readers in this file
>   already do.
> - v1: https://lore.kernel.org/all/20260910104525.3788362-1-zaslonko@linux.ibm.com/
> 
>  arch/s390/kernel/debug.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks!
