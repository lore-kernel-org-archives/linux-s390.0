Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04188363C52;
	Tue,  7 Apr 2026 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575202; cv=none; b=jgv2HA+CJ8TctdD6A0RIOik3wj03K9/HgUS3klmXxwQw0rYFZ/V25ZbRvrAV6SI1OVfunrasG2p9OCMHR99O4rUJR99QiHtF0yzRgDOOflBRnLtAYK7HbXzTb6KSL40DSK77H7dCk24y05QN6/PegBvjQ2con4USusgQHnEVbQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575202; c=relaxed/simple;
	bh=tSU2fWAEeApXlpZMKRXSkVTWFb9+gd2fghu+YuvxO0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHNLtnBu2kwEd+ajnCfE3d95xwnA5j9Q3VnVKCHbZzn1qZ4uoEZIBcdK6d+f1W+Ii1wHxivPpPNT8VK1CrCl1724tyIpUFJGTuDcvLWFy54eBWb+9XDYlTXj4fFACSI3L49uKMxTaST9FljlQ8urSWmcZrS5HpR5rdUrB6dJuTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lyfbE6gy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lyfbE6gy"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637ESS0x2299520;
	Tue, 7 Apr 2026 15:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=alhA4WwmGHKSDlsKtCukEptPp6WTas
	YciazJ8fWo2yY=; b=lyfbE6gyTX90c6wMXQgcp5EpardjeCFvQIlIBvIYERZaNM
	nt1pu6aIE/KNkj5eQnDLSQhlEJBvD3L1UH3X3wF8Awzu8x2NvdMAf6ImPKD29UM+
	ykdeXmxIu240lI2YdPdYcNEslLm2ZNHSMSRZQpe9XEpPhtsG/qrynlv7DLKY70hm
	FVQOYixRZhYJ3lRncET/mZElYULT/HtODMfx8sO9e/C/I37hl7podImhdcjwZAv5
	u7fBOgdjkfiOOgz5JYMcIg7pZ96RworhMn54eRZpNNWiasIKjqwiMkJY8ONFiwKX
	w/LKrOw/XeCSY8Gq0f8P4NnqsA4PuL1eZYKy297g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fud6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 15:19:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637ERG3H030102;
	Tue, 7 Apr 2026 15:19:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme7bqch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 15:19:57 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637FJrg320906734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 15:19:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2C7920043;
	Tue,  7 Apr 2026 15:19:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE0332004B;
	Tue,  7 Apr 2026 15:19:52 +0000 (GMT)
Received: from osiris (unknown [9.52.216.133])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  7 Apr 2026 15:19:52 +0000 (GMT)
Date: Tue, 7 Apr 2026 17:19:51 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, david@kernel.org
Subject: Re: [PATCH v3 5/6] KVM: s390: selftests: enable some common
 memory-related tests
Message-ID: <20260407151951.64427-A-seiden@linux.ibm.com>
References: <20260402150135.196943-1-imbrenda@linux.ibm.com>
 <20260402150135.196943-6-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402150135.196943-6-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d5209d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=zBtu8v2KzdITmXKmy5wA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 96b8y1J04_sofgy2FmYn_i7w3q8usuZv
X-Proofpoint-GUID: 96b8y1J04_sofgy2FmYn_i7w3q8usuZv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE0MCBTYWx0ZWRfX9wgtZskY18a3
 lol9HkMT1kbe9b8Z0iblabHT4AsoyHDYSFjTsTH1zuLFZlkexcUTiwz2s6S9a/zaDUBjXjp6FE1
 l8RDsz5AzcQnd459Ys8gE59Y9uW0kXbkQjNlwift9F0evBXzC6ptMU2ROTOyiwqHiwTumJDvmv0
 JYo1/Quat798UzuuxeZeF8oQDDt/r7itcqSX/I+g4itw3ty68/kocXW3D1p5RqUm3AVfZIvyTSd
 8OqON39wxX00IGp73bu1il9o0w9/F7x7JEb5E9n7/ZUJ7rs16/P5ivZWKO4cA3ezTqpDMj8fvh3
 /wRZaVgPQH2sewi9ax28pV250rHAZOcLTxgkgZCLF+eq1b60mLRzh/hvx6ujS0Ktag1bfoL101V
 ugRwbPtRTyREI9WFZAT8zzuLoWpWPLDCftahMu4mgJBq6ENwQxIWuJTfs7WH1mVO6+WhYNIYry3
 bJvASVXqfJn5elNDzwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070140

On Thu, Apr 02, 2026 at 05:01:34PM +0200, Claudio Imbrenda wrote:
> Enable the following tests on s390:
> * memslot_modification_stress_test
> * memslot_perf_test
> * mmu_stress_test
> 
> Since the first two tests are now supported on all architectures, move
> them into TEST_GEN_PROGS_COMMON and out of the indiviual architectures.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>

