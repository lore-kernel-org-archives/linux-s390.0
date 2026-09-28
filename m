Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3FF4BE424;
	Mon, 28 Sep 2026 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790604993; cv=none; b=fnA5Xe009LXR8QMmwFkY2DZSVjUFq3/WeKxccU6FugXTrt48nfxF+Xdf2zskSKw7PhI4BUnhqa6dKXAzwt1fDVtk2yiQ+dRnABKnZYs5bIG2C3QO1x1sVDLcrIX5vJzLQAolNy1lMp3TDIEa9wHkWJSl5nBMMJRXcnc9HkqTZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790604993; c=relaxed/simple;
	bh=QbZ5UsXrWS0owgzj5i50hnc+v3PF+lldVQgfA/R/4ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkV22eipdthk7IAfFlSPIaikg443N7kmzw6BKlcexYQkQhy/6RT6jHvpY/l6t4KKObYK6mvRIvT9N8MQSNYIVqGuHlVZrwP1p+u74XMyKuvQWBuy6PyzMwPibNo4XQFGo2/C6BeCWcWAvBeFnpPRE27HLcqBzCnIFen8q4BBITg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WbDo8fIe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WbDo8fIe"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBZwWd3971640;
	Mon, 28 Sep 2026 14:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:sender:subject:to; s=pp1; bh=AhCRB9NLLW8bdkoAECwyNoY
	+xY+rBOaD+BK919XDM0M=; b=WbDo8fIeaTKnBfjK/pVvpw/oChstda5C+Yb1tvz
	XgMWR9NLexh9wlD4QGlbRttOz5xFIUcCHBALQZ0yKwInkbf+KeaNeplwHZ//whbw
	OqxQ7Za+DrUsyQuDFefQpniEAnX7BzX9b5Ql7V6hT9JqgjEzQReqcCidznpPiLr4
	V0X+5ErzjrOtOiX7JYZbz+xV6QWteo5+X8BMrwvw6omOQhCKUkdactsmDPSSjvZ6
	MFlk6/nGS8yMsBuOv0OZoEcBHg/s9e/2H42TeCo2pDVPyPVH9GCLfT2/IgzETLIt
	ha96CONDR3QJRJYetRJX5sd01ThkMUqZB3X1k6nfa1cXEkQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fe1hqg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 14:16:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBHtjM076695;
	Mon, 28 Sep 2026 14:16:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhdg4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 14:16:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SEFxuh32637348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 14:15:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72A242004D;
	Mon, 28 Sep 2026 14:15:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55A3D2005A;
	Mon, 28 Sep 2026 14:15:59 +0000 (GMT)
Received: from vela (unknown [9.111.89.89])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 28 Sep 2026 14:15:59 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.99.5)
	(envelope-from <brueckner@linux.ibm.com>)
	id 1xBC98-0000000C3I8-3ejc;
	Mon, 28 Sep 2026 16:15:58 +0200
Date: Mon, 28 Sep 2026 16:15:58 +0200
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
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v8 23/29] KVM: s390: Add basic arm64 kvm module
Message-ID: <arp2njz3Dro0sQ6Z@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-24-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918133107.1042730-24-seiden@linux.ibm.com>
Sender: Hendrik Brueckner <brueckner@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6aba76a7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=nnIaaF498kqO1bEHNMIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1NiBTYWx0ZWRfX72hKPbHn0oBk
 RVFuvBqH8UHPWEoKzXdQr64GJWDGGWKnIO1MVn7goXs69X8xC7jB4YwC1auPz/wXgY+NIiJmji4
 d2xLMIzsZPnbCNiU1IPsNlQcBk50BGk=
X-Proofpoint-ORIG-GUID: c8k90I_35h1vfDy12bjJ-4_B4O-n2PNu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1NiBTYWx0ZWRfX6cPRFJGxV5Ug
 TAb9cNc5k7WfJCqfLczGDe5HlTRxPb4/jrOu3EyqNFsXiIXGE/HTuUQWdIlsPCB0lyUVd9ijXGK
 qrkARkw5fH5VyeBdLrYhaxLZ7HEZJNw2FMXASvcymwIkuVHt7IiIGR3KZB3l6+lzE+7CAbGjzG2
 3HjsWMAQp0EgYWgXjqplQGXaouXCHjnM4HLI5S/fIDehHStPOKdeDOsMYXUyVOdX2XadHW4ssU2
 XY82J2DcaQDjianPr97X326Q21kz6kvzfoDn+QIeW3SFViYyExlRCwwlJD+QT9AtrNul/nKFGm/
 zP02XnFqeHjAqDTQJUjG7ijPg45l5Qs19aZaLW6wbbBMjTLBa66EJZYiFauL+kFRkFcZtQ4jm8S
 paXA0duaRBpGf0gY/k7Lqy/jtAI2xhiNBzXOi8F3cpvQ01wt8Fln72L34jmpDg2doVfTq6T1HVh
 2zGyVeJyg0a5Tx+qyoA==
X-Proofpoint-GUID: gQs0JtJQ3bmijgSPG4xGjgWcJAErDcqK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280056

On Fri, Sep 18, 2026 at 03:31:00PM +0200, Steffen Eiden wrote:
> Add basic code for the new arm64 on s390 KVM implementation.
> Add kernel module boilerplate code and trivial functions.
> Add tracing scaffolding.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>  arch/s390/kvm/arm64/arm.c   | 147 ++++++++++++++++++++++++++++++++++++
>  arch/s390/kvm/arm64/arm.h   |  44 +++++++++++
>  arch/s390/kvm/arm64/guest.c |  92 ++++++++++++++++++++++
>  arch/s390/kvm/arm64/trace.h |  18 +++++
>  4 files changed, 301 insertions(+)
>  create mode 100644 arch/s390/kvm/arm64/arm.c
>  create mode 100644 arch/s390/kvm/arm64/arm.h
>  create mode 100644 arch/s390/kvm/arm64/guest.c
>  create mode 100644 arch/s390/kvm/arm64/trace.h
> 
> diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
> new file mode 100644
> index 000000000000..8b056fc836d7
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/arm.c

[..]

> +static int __init kvm_s390_arm64_init(void)
> +{
> +	if (!sclp.has_aef)
> +		return -ENXIO;

I suggest to use -ENODEV here to be consistent with s390 kvm module.
The arm64 module also return -ENODEV when not available.
