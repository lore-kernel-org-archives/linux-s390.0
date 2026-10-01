Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93374EBAE9;
	Thu,  1 Oct 2026 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790852604; cv=none; b=HxkuCtwOqPyczV9Ts9znSk66bsAb36Sl1A/51vqTn0AZG+P0aEjyru3uuDHFxOT2aWerghkIo57d8lezEFPduUzstbq0u5gzicWt1/mp/lCA8cPc1OUS8tx/R0bcQDW0vN2VB1i/Ag7WHOnLa7oIG/MY8VZYULUtCpZJyVzHqVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790852604; c=relaxed/simple;
	bh=LFttZIhAFm+lqGn2jDq4P4s7mkNF9HzAGxFR+72KRrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QF6EEgcPl4LNZfccYzxbHE90VDiA74kdYsgklmLQpnYwJSxhCpKGw4Q9FBwLAnxpkYKC+BR06HPW8IIOsNj6hSH39C1TQ/zBWuHjZSx9Kf7sgJq4ovR8iBHw/tOKNV83Wg3SgwTnGOTofvUlJXNzPiFTPoOcDWliMWrrUMwwgMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WtuQgMqM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WtuQgMqM"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175UUs4040713;
	Thu, 1 Oct 2026 11:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:sender:subject:to; s=pp1; bh=ItK1CfwuIZ04jNSyZCfqu+k
	V1LoCb64Jr8/HT5gDcpQ=; b=WtuQgMqMiWN4iF/2g4eiK3oT8hFUANWv/rv24dj
	rLiAcMbw0JctJJ5mYj6/PWBc3BpxY1JX8ZEOPs+aEyQhjnmI5JpX8SKqM2Jk3YyN
	ogcEGhEwfegcSHReoRUdtpsX4MQh7yqGkvt+xB6/Xo/I4TalqfcgWPVILveq4xY1
	Qfx8eMDDv06j96koVerE9z6S95FVdfZ3t8EbyXvDJWogzY3+6yt0nGBqxOpstgwE
	v68AqnrC9N6DP2McpbxYswk2y2ayZIde0qnJxqcs3vamUP5pSFgTbiMv8OxrwiRj
	GXD5I1IKGNyBfO/dfDr78aLA2z9heQXtxcAfeKnF0M1wqag==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fehk62-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 11:02:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172Vqm520699;
	Thu, 1 Oct 2026 11:02:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpgdgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 11:02:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691B2UVe50659598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 11:02:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 678F820043;
	Thu,  1 Oct 2026 11:02:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F29920040;
	Thu,  1 Oct 2026 11:02:30 +0000 (GMT)
Received: from vela (unknown [9.87.140.173])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  1 Oct 2026 11:02:30 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.99.5)
	(envelope-from <brueckner@linux.ibm.com>)
	id 1xCDz3-0000000EDXx-1JV6;
	Thu, 01 Oct 2026 12:25:49 +0200
Date: Thu, 1 Oct 2026 12:25:49 +0200
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v9 14/24] s390/tools: Use arm64 headers
Message-ID: <ar41LayUDhKN26cq@linux.ibm.com>
References: <20260930173441.66762-1-seiden@linux.ibm.com>
 <20260930173441.66762-15-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930173441.66762-15-seiden@linux.ibm.com>
Sender: Hendrik Brueckner <brueckner@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abe3dcb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=pIDYuyBsNzMzyUpEjcUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MiBTYWx0ZWRfXz1Q15mH2sVvj
 RknoqLGudmx52FOgkx1dkcCaCmq9oxf/2E8oKEBr1KtVKDWgTmzeNOOy7tpgHWpTZGfeE32tGTt
 O42Uw3WfNedO+DwVs7j2TZ89fZs1zwM=
X-Proofpoint-ORIG-GUID: x45Aq5iA47UwqHleMqD5u89nRp6caifF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MiBTYWx0ZWRfX0sc7XyEBvHcK
 FuScV3wXgBKFzpJFhAsP3V/w4wX+Wpdeq3PsMD3A0SvUrL8TXWM9bioPCm7jPJ6X+qqdAKAi95L
 eggqevF1i+ArdyWah5iWhFGPvxK8jhXyiXBuRpUlcrXWNEsK8QjXNeQoygNgMJCD4FvHjkh/flG
 2T8/AUtimtx5CONt3ZIyqzYaGwxueHQEOs0VQOH8CECtSmcb2Jp75Fzz/Pen4HQO8d3j2EUiyja
 /iga8m+lrKCmT3li7tyRcZf6mz3ZdLUJDScZOGYK4SSLJMGeiE0xP57OvwiAbCaH28M9L09w8l+
 RcXCrVvUYHLpbS1GHTTb1odBpXoai6p8viyQ6eV+R/nKb2YBEXOjWDF2BEgAYvVyODg7yRd38a4
 b7pFN1OhQLI8s5R4bOZzTI31GMxmncHXEbNCfK04R/E82RUzAS2bxaOHqRrY54IRTvNJCU8yESC
 2o+o22kgESxsEMel06A==
X-Proofpoint-GUID: AkvHnWmuv38b6ddyzKFfJgbkuVZgn30w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010042

On Wed, Sep 30, 2026 at 07:34:29PM +0200, Steffen Eiden wrote:
> Introduce a flexible system for sharing ARM64 headers with s390 KVM.
> Selected arm64 headers or snippet of headers will be reachable by s390
> code through asm/header.h.
> 
> Add copy-arm64h.awk that detects ARM64_S390_COMMON markers and extracts
> marked section into a generated header consumable by s390. Falls back to
> full file copy when no markers are found.
> 
> Transform copied includes by replacing '#include <asm/...>' with
> '#include <arm64/...>' and similar for uapi headers to ensure
> correct path resolution on s390 and allow for a clear separation of s390
> asm headers and arm64 asm headers.
> 
> Integrate this extraction into the s390/kapi target, conditional on
> CONFIG_KVM.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>  arch/s390/include/uapi/Kbuild        |  6 ++
>  arch/s390/tools/Makefile             |  6 +-
>  arch/s390/tools/Makefile.arm64h      | 55 ++++++++++++++++++
>  arch/s390/tools/copy-arm64h-full.awk | 50 +++++++++++++++++
>  arch/s390/tools/copy-arm64h.awk      | 83 ++++++++++++++++++++++++++++

Thanks for the updates.

Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
