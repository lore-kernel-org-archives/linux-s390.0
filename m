Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C648A3DB334;
	Mon, 20 Jul 2026 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541414; cv=none; b=hXuHYBcoRivn7AEIeUUJj9BuwGstr52LjTtEAq9UvIDBoJxANMUFr0LsNzpUYkypE/U+YwHmBJCh4CijH6aEEUlQ/8hn1ez3Z9m/YMuhKfePDwyT3ODiIwG1oMKxZwN3aJQUlQMW6z5MdBymsePMGetokRf1RxxkZMI0HkNV37c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541414; c=relaxed/simple;
	bh=Gz9HTi/5Foq9aKlRvLRdYxVla+mbGu3H0F94pHGomdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j461En7N3CeAFAqDOSYfv3azJRM2xyYw9C+pk30kJtKE4AJdDYNZ/F+xYd1Kud1bZFi89ML1hrSRhxTWDMRUHgvfpJfjNjuuPAyGf1pa72Xb4AUZTUk66DTR57zveWSZVlC0wFKyGOIMHSZjB1Mn6NP3WY+HOrpJL/8BsPFdik0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d1fp3VIt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d1fp3VIt"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6fvAK1382010;
	Mon, 20 Jul 2026 09:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=L9qPdH
	PULYxPt0wy8WiCVbV/TKw//6CwnBJT1q5i+oI=; b=d1fp3VItOe1zrzfaGLgeWT
	ydufwQdo3hpStAE3MbrWplFYtTwvEGzJgE6o6bJ9i7rYVRkEAtTpPHz+azkPlUug
	fUZAAB4PrAS8bdkfG6DK+V3yTNqTmmd9hWLVL1F+51SXRfjE4toPSFJmAf4e/geE
	VnePj9pj7H5H7nuDtd+rdEOSRNLSL0LUuRR9XTZJiMFUQIsG998qhr19i0QpvMOf
	0hbzvr+497yez4KNSzx1OS6HU/h85PJjsb66/4x7qqGnK1UsbtZgDFemzSvuX/Jz
	kQrHoznMvipDBVVHO7vnP3NMuILaTwq/MLx9OKvSX4wMyIf9y4FkY2OOQn2Vacrg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77jxm7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 09:56:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66K9ni6B031151;
	Mon, 20 Jul 2026 09:56:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1g4v05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 09:56:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66K9ubGv21627472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 09:56:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 976BA2004D;
	Mon, 20 Jul 2026 09:56:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B1312004B;
	Mon, 20 Jul 2026 09:56:37 +0000 (GMT)
Received: from [9.111.21.55] (unknown [9.111.21.55])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 09:56:37 +0000 (GMT)
Message-ID: <30f0084c-5621-4602-8c0a-9082dd9d3d43@linux.ibm.com>
Date: Mon, 20 Jul 2026 11:56:36 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] KVM: s390: pv: Use VM_SPARSE area for guest
 variable storage area
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260720085834.898025-1-hca@linux.ibm.com>
 <20260720085834.898025-2-hca@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260720085834.898025-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a5df0da cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=YKi7x7nYPf8b3Ghbl54A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwOCBTYWx0ZWRfX8SPdGrCuxMK/
 9+FgjwTdAhWlCUrJS3zEV1tls5NJDb5DxVgGgtGyS5R+wjW+/HnbyyYJJ3fVbknPlf9FKHj03oL
 /CnaEYCN+FwrZnv8dSlzM/Ct/GbnzyNfQVABMAzHVR+l3rbsaPM2QSPkyPvaYvh4Ggdag/R3inN
 +FPzcaeuBIC05h2gguT84buC92LZRzdYrM+M8W/PRcBwZK1OaBoAhOSDzS4UVtGQYBTjcXFrQGu
 aXAssaImxp05QPZ4RmsDw4uF+FI6F3nqFPkHjaK6X+m5KlUAC/wf9zD+hvFsRx3rJH7HX/jtgkU
 F5QEUmyom0qYOeS1aAzUhRw5viCqVWSwQ1oCwY8c/h8Vza9tsq0G7qTgRr+W2mY260TsWGtPEDY
 S06Kh+TokPYqAFs94yoTe3rzVkr+kcespPm0xlJf/Ac9Q7JP11PdCNGsJeOyuaVgQ7905NhrCx6
 j7C4NVwX4fGzwembavA==
X-Proofpoint-ORIG-GUID: AlkHTrDAcqJ_ZXHfjLA6-ONkhq-ZPbUs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwOCBTYWx0ZWRfXyMJu2fuBk09/
 z/P9yTWGsYuAUyTXLPOnemS++wWTDTVOQpi8NBN08nVvSNAWwNFQnOLek3gukNcwm+wt6qyAItG
 hCtQ+kXgniB6afhk9IRu5WLOyw5Ur6E=
X-Proofpoint-GUID: AlkHTrDAcqJ_ZXHfjLA6-ONkhq-ZPbUs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200108

Am 20.07.26 um 10:58 schrieb Heiko Carstens:
> The guest variable storage area is allocated with vmalloc and then
> donated to the ultravisor. Any kernel access to that area will result
> in a secure storage access exception (aka fault).
> 
> This is a problem if such a memory area is read via /proc/kcore. This
> causes an exception via vread_iter() and results in an unexpected short
> read. Avoid this by allocating a custom VM_SPARSE area. If such an area
> is read, vread_iter() returns zeroes for the entire area.
> 
> Note that the function which frees the area does not update ptes. This
> is intentional to allow for deferred / lazy pte updates and TLB flushing
> like the generic vfree() code is doing that. See vunmap_pte_range().
> 
> This assumes that s390 will gain full support for lazy_mmu_mode_enable()
> and lazy_mmu_mode_disable() in the future, since as of now the used
> ptep_get_and_clear() in vunmap_pte_range() does indeed invalidate and
> flush every single pte entry, but only for s390.
> 
> Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>


[..]> +static int uv_free_range_cb(pte_t *ptep, unsigned long addr, void *data)
> +{
> +	pte_t pte = ptep_get(ptep);
> +
> +	if (!pte_present(pte))
> +		return 0;
I guess we do not need it today, but it certainly does not hurt?
