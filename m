Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964179;
	b=4JKBaSS+DsS8j3+XbNi1sdHy9c1P8KVejxJYcQXpDBUK6O5Q51kZIKG9QqwrFql1embE
	 UPojybP0Gf8cOCwk9VYiiQPxDbrTC6UKZ6aJ3/LfQgvtFxB6qwK8lx33iiyVQl/Df5jLj
	 ZxxrUT8slnjE8pq3GhRRUdHdwxGR/fpwTBpBcENYQ2hgaoAZeqfmJWJCR5oi6ow1YfLrb
	 Cc/9BBqzUiyfL2WrGr0kL/YqZwsODSP7KVQ4e3IMTUalYiS8QNqr69pNAE+9QazkTo1qc
	 JOgRSsmc5sRNTj3RrnHXwTZEqPCI9ZKFc8eLQkBzadIY2/HUDE68tce+4ZCD9trzXIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964179;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:From:Cc:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=XSkCRP/iCAmBq/Ps3sn+ycEaOS8RbaoK3GlU0yrOuoo=;
	b=XWdDzECTnH5HBFcucBFztlABKFL7Nh7UrCFcbGjUXnFjE0i2TmyeyCF+KbqzWSsJon7r
	 V57FDlSwrAkIRAJ+1EjTDlGEoQ5JcQCP/PztZRDtWPKw696jVsCDCMtOh5PqxDUfTwGDl
	 XM5t0auG/40OTrWnSgBfBWeR1WNbAAvGfw4t8+lU9AQUxsrbzFGgwi8e/zQaDKguUYEnL
	 FOlABOw+G2/hGnO+Urztt08gF0UtvJHQ7Ob2p2nk7yrEBDEBVK4mvArcACBDdA1Za0uue
	 7gvnrfRS9bCSdEQFsAAGo4uqB4Uubl1n1XFUiQ8IPBuuZAt1pa8ym1CsfpgvH4fl/ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="Pu/0y5rW";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821C2606A326;
	Fri,  6 Nov 2026 11:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 821C2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Pu/0y5rW
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AjbgX980374;
	Fri, 6 Nov 2026 11:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XSkCRP
	/iCAmBq/Ps3sn+ycEaOS8RbaoK3GlU0yrOuoo=; b=Pu/0y5rWc2ZrdPZqiI2pP/
	Te1Gta1kngdRT+2amzGzZ3MydLtq4CkBKZ3uTRCtTMnXvT6bfDYrxyaANsvsyh/R
	33MRcI1343pdxyf0lDnJTeppbWzknzuWe6v+lZE85A8jlrqurH0KuEH0AzoqF4Kz
	O3bTMiT3XWDVeKsIjcefVIoUGfSMcyODzR86L8Eh0ByIm4KME+zQuOUwkBu0ViRV
	u9n6gZZVa+vhgJ6V8lIqJYVOcAQiM2XE//xsnf5N684CZqNamr6X8XLVKLo9+dbe
	t+GxoilQWHzPfmqJDHAHFO04CE9iRQkfkQbp29ay4xXoMwquAyO65vzF9cUiCnGQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rbuufn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 11:21:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6Ao7943260750;
	Fri, 6 Nov 2026 11:21:19 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqv1v6tfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 11:21:19 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6BLIss4981286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 11:21:18 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EA5F5805D;
	Fri,  6 Nov 2026 11:21:18 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CA0D58058;
	Fri,  6 Nov 2026 11:21:14 +0000 (GMT)
Received: from [9.111.151.197] (unknown [9.111.151.197])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  6 Nov 2026 11:21:14 +0000 (GMT)
Message-ID: <0a3c64d1-2b8f-4e0b-87ca-5397d1aaa3ee@linux.ibm.com>
Date: Fri, 6 Nov 2026 12:21:12 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crash: keep crashkernel CMA pages reserved if activation
 fails
To: Usama Arif <usama.arif@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, baoquan.he@linux.dev,
        rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org,
        ruirui.yang@linux.dev, jbohac@suse.cz, david@kernel.org,
        hbathini@linux.ibm.com, leitao@debian.org, kexec@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, kas@kernel.org,
        hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
        kernel-team@meta.com
References: <20261104145600.3708886-1-usama.arif@linux.dev>
Content-Language: en-US
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        Bradley Morgan <brads@mainlining.org>
In-Reply-To: <20261104145600.3708886-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zxaghCs0BOzGJLIG7jFmKscVIT5NRM5b
X-Proofpoint-GUID: zxaghCs0BOzGJLIG7jFmKscVIT5NRM5b
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aedb830 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=v7f7EczwOuDDiPIii9gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA0NCBTYWx0ZWRfX7zq9oNWaXh0U
 FC1wxkRX4UHerDFfCDSe/7AR824SCkh7FVX0m2cCeucIHT4Qq+DAREGwDLQSjfLCCK+nKG0/Z1I
 k4IO/PNS/iN+mDiWAQFfOU4tOWY5As4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA0NCBTYWx0ZWRfX3tB4QAo85Yle
 twUqL/+8aN7LMEcEsB0CAs9RLVC9vrrZteEwPlo0j3uRnR1W7YoMALXTqFVp8Q8esXu727tdaNN
 DzdYK3osL5l2FKNQAldUR0T/tbOAmH1Ye7UE3wTJuE0EOaRNi70qgaUXGol9TOXkv2GzsZtVF8Y
 HzOla4OtHShSHyenU7fM371K9csCj8c/HHABc9VweEns5PXP7bX7EL4kWFCss4zMnR2/zKaKLCe
 teVC0uDbMbjV2EJNV5CkaHjB/+l0F1RJo7ul4xS36lSlXia5Ma/cCGqXFB6bNEwM41dH2yFJZgu
 CztOkLSkX+4K90IxdqV2zMzKwQLt6WM6P78Rn3Nh7gGTu/4e1UxH+zNtWduHbZJbrf1VG2i/nBd
 tbST2q9naYNAlGRwdh3794QaOWbdN9MwRT+TrDPbHB+1Y0HEQNOYk3xyea7O1qObAt4ldoqYP+b
 IYwsVB69XIeNuxIWUOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060044



On 04-Nov-26 15:56, Usama Arif wrote:
> reserve_crashkernel_cma() adds each crashkernel CMA area to
> crashk_cma_ranges[] as soon as it is declared. If the area later fails
> activation, e.g. because movablecore= put the ZONE_MOVABLE boundary
> inside it, cma_activate_area() releases the pages to the buddy allocator
> as ordinary memory. The range is still handed to the crash kernel and
> excluded from the vmcore, so kernel data that lands there is overwritten
> by the crash kernel and missing from the dump.
> 
> Mark the areas with cma_reserve_pages_on_error(), so that a failed
> activation leaves the pages reserved: lost to the first kernel, but safe
> for the crash kernel to use.
> 
> Fixes: ab475510e042 ("kdump: implement reserve_crashkernel_cma")
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
s390 hits this without movablecore= (adding the s390 maintainers and
linux-s390) since ZONE_DMA ends at 2G here.
CMA tries to reserve areas above 4G first, but falls back to lower
memory when it doesn't fit, so a cma area can end up across the 2G boundary.
I ran into this while adding crashkernel=,cma support for s390, which I
will post soon, and came up with the same fix.

About dropping the range instead, as you offered for v2: I'd keep this
version. With the range dropped, the kdump kernel gets less memory than
configured, and that only shows at crash time. With this patch, the
the first kernel 'loses' the memory as with a regular crashkernel= reservation
of the same size.

There is a second problem in the same loop: all areas are named
"crashkernel", which breaks the CMA sysfs and debugfs entries when
there are several. I've sent a separate fix for that:

https://lore.kernel.org/r/20261106104309.3669583-1-zaslonko@linux.ibm.com

Reviewed-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Tested-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
