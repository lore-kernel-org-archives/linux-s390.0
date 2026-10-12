Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B8639EB59;
	Mon, 12 Oct 2026 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820864; cv=none; b=oHwlxV9pT6liNLMP+JGD+oDM2j14DQA1tfYbQgUFoUOXXmahl6jII2H0OIvtGPj3Y8a0+oEcNvNffEIRrMcmV6WzLIoQqcmoGyux+05WgtslVnuxUDpdA26upovsGhfFsNO9baRvCMbQRoPFGB31ZlwtXrdqGNeucOlIBeUOouQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820864; c=relaxed/simple;
	bh=q8SI+drTw3F6KcN8OWh5NRQrFdKa7bE1MAaOyuqnHIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0Vsl2SrFKQ2EGW1aXtvNXv0Yuc9ZCwGebML7hcmBD70ckyqw9omtJxy+yDbLw6iNd9hs2W8BMTE2mwvERrtV4rRIneZkNhYQ1BN1HIdn0gMriE8z7Hj/n13x8gAKs3skBtQId65FNZ5e8yqya5hdxJ3AHZ+7RP5KiIZvw66504=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dWilGJVS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dWilGJVS"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFiVM5664654;
	Mon, 12 Oct 2026 16:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=vL0gmA7EC9swyEls8PJks8llqpZxML
	FcWX5gGDq4/ck=; b=dWilGJVSbgrV7kCDgg54idKdj5JBOfRAUGBKT0JS8iIIzx
	LmQyjGPCl0IZIkqfJYG6LzQbb1SIA+DcG0RiNpBoKlwxBT033bzV8beeL+XUyDa8
	oZKWKjFRxNBQ0YWTmDzrvLzUy4ipUTgOCgqxbMfw7kJfs394B0nJMvGyleRpeK1C
	f4KAAZbgP9xkjBZ9RiegrSk3jKojK37E0RM1fUCUbO1sKxnO0rFw3ss01zd1jeTu
	0jXzfq/XqjlNN+d+3DIP2c8kOcSRwjt24/04m4db+KeTP6osCaZY/WQ3EbFRUjet
	byeGXPBh8IRvgFLzUK7EGXqFR7tL4no7IjnYhU2g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w1d34-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 16:00:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFoCbD1519905;
	Mon, 12 Oct 2026 16:00:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjnvjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 16:00:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CG0pxw52167162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 16:00:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C698920043;
	Mon, 12 Oct 2026 16:00:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30EDB2004E;
	Mon, 12 Oct 2026 16:00:51 +0000 (GMT)
Received: from osiris (unknown [9.111.15.154])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 16:00:51 +0000 (GMT)
Date: Mon, 12 Oct 2026 18:00:49 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Farhan Ali <alifm@linux.ibm.com>, Cam Miller <cam@linux.ibm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH v2 0/3] s390/pci: Updates to PCI insn tracing
Message-ID: <20261012160049.19350J7a-hca@linux.ibm.com>
References: <20261012-rpcit_trcfh_upstream-v2-0-1812db73dfa5@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-rpcit_trcfh_upstream-v2-0-1812db73dfa5@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2MiBTYWx0ZWRfX7PssTzINJumg
 siATpb7pzGE8ulLAK5h0ateQNF94xnlDTd0oJduH1O87rp9obFlLObIOiPY3QE+yEKPBh38mkhG
 AWX6ACvbD40v7zDh+g85tXU4EQo6NWU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2MiBTYWx0ZWRfXxVwYbKV9F/ku
 TIKKe73O1/YQhhW0DVgZoDJMgfUjIwN+PZi3rWNv2o6Jaxvw8MGtCfF81gg5wW2F41vKfNNSYcZ
 pa0ULlH6aRgQEHUhEc3dE7kbaFbswIL1pAHepuSMXUj/frM7qFrta+S/33UFMWgvdCnkHeZgJ2f
 Qd/MtRIx4T9kewAETsrXbg1xY7aKJGpf+C+uCAEJATIgo2TH38LwWT19lWnC4vqjaSu65tVdz/G
 F85oRg04BJm3WdHvYnejtzx6kmN5LXi/mmZE+ngApmNVTHEHFBWDYD601jnoibDxbU+2euV0gzC
 vbY6H65ODVJtIRKgk9yq2Uy6di5JC21nl7BA0sWXNJ6jKc2NdiCG6/Ei0W5/bVGpaK+7dnI46Mo
 suKTTrxhpXqO4FXvfI6IOAJknQHcLC8SwhfB9cHXpl4HLRl5jVUlSdH71hFBylg6kfUVYvvcPE3
 YkoIZP+PQLwpT/yGKtw==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6acd0438 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=eIcJ-32R2tUNuVzK7gcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: L8eCir0POkxz7MiFZ7VvTwX7pAQWm2Gf
X-Proofpoint-GUID: L8eCir0POkxz7MiFZ7VvTwX7pAQWm2Gf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1011 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120062

On Mon, Oct 12, 2026 at 04:21:48PM +0200, Gerd Bayer wrote:
> With this series applied (+ a test patch to trace RPCIT even in CC0
> situations) an entry in /sys/kernel/debug/s390dbf/pci_error/hex_ascii
> looks like the following (removed time-stamp and ASCII transcription,
> replaced instruction address with "<IA>"):

...

> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
> Changes in v2:
> - 1/3 and 3/3: Replace unnamed bitfields with named dummy members for
>   padding (address Sashiko findings)
> - Link to v1: https://lore.kernel.org/r/20261007-rpcit_trcfh_upstream-v1-0-8a2718cfb90b@linux.ibm.com
> 
> ---
> Gerd Bayer (3):
>       s390/pci: Adjust alignment in insn trace
>       s390/pci: Use 32-bit fh outside of inline asm
>       s390/pci: Add function handle to RPCIT insn trace
> 
>  arch/s390/include/asm/pci_insn.h |  2 +-
>  arch/s390/pci/pci_insn.c         | 42 +++++++++++++++++++++++++++++++++-------
>  drivers/iommu/s390-iommu.c       |  8 +++-----
>  3 files changed, 39 insertions(+), 13 deletions(-)

Even though this touches drivers/iommu/s390-iommu.c I assume this
should go upstream via s390. Is this correct?
