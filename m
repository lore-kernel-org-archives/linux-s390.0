Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793779172;
	b=hpFj9LxAzem4/Y1zXsuCLzvnsW1h6QdrPQ0wvq1j4LnmablGwcWWtO1YTNh391aFa7NA
	 OPOXoKMUv0fygfG6Ny4zY10sUSKLkl48wB8/3SqDyS4+3hFa5VYXmyq+8265Ill9kXbS6
	 tT3Zf06SEHF1Le0uafW3Xe0l6KAn6H8VGeiucPtrKKOjW9fS2pvUZ9j0c++4Brg+9S9g0
	 kwSbWasCQtCl6FS4uNKYv9CdX2GHltx+/8HlQbMXkQDdPO6PxA9LUX7ONrUOxd0ggkCht
	 6VbPZD0MVI2CouzPKhM7AzovbyTxiaxcEFXtvgldq5au6AjGl2HuUYm3pZjVrA7QLAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779172;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=E5BFe2qGhYY+j7i/NDpJAV1R4OFOksaCpMvxwhppjRQ=;
	b=qRrhQhHdkdtbnoPqly2yzmc1Brelu+5vNMn1gKcypyw7Pl/Srj/bo30GHBIdcYn3DhJB
	 EsHDIrIieoDhbJITtreBRT1mScEwGjXgkcGdF32XmjR15smATWM7RqGg0DYpim0JHhRig
	 JlRoIRXhmOgrS0DEtwX/O+aY9tV9fqL18iSWuQhypQjF+qmN90Ee3sY7g2+J639llBktv
	 hkc7KwD6QX9fkFvFv3QbCu8/wO9t44vvm58H6JaPUACo8tBCMBwlU88NSNZhLh8Tm3sBQ
	 4RogeTz8WNUt6z9/4io4Y4kslpiB/zPq9tli0JilhfYMwAe0OLlbit2FUeMhm1OXeug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=c0vu2uZi;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA7D606A31B;
	Wed,  4 Nov 2026 07:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BA7D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=c0vu2uZi
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A40iuH13336172;
	Wed, 4 Nov 2026 07:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=E5BFe2qGhYY+j7i/NDpJAV1R4OFOks
	aCpMvxwhppjRQ=; b=c0vu2uZicAo+3O3DYFXLgSyRqOF4Mg1YTgWirfg0suiZz7
	14Xmn8xgqpfQuNs5wTzZmcJYgjxhjz3U15NKxe1PHuDjrqptLHeSI7FZUhuvprCv
	2eE9lEWWHoB91QxfBbDBKhrmpFIoixnknM4UQkur4GBvqZ3UOJon9S6eTLoXMyuA
	nZ3twFAYN1zRbm605QD0Nden64ZMI6H4a2d9PoyNiL/E2otFLuc8smVeY7pi0tUg
	VgGQI6O+mH0VtE1zK96sx4OsvG+uUsgcYBYHRkDCv02TOLB+102J0IGt9ddlungo
	LUB0YFT7oq+oSvVu5DXAsKzT29784JhWq7XcDw0w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7ys28nk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 07:59:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A45N7CZ3382714;
	Wed, 4 Nov 2026 07:59:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqf0gcj1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 07:59:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A47xOX042008990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Nov 2026 07:59:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F71D20040;
	Wed,  4 Nov 2026 07:59:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ECEB20043;
	Wed,  4 Nov 2026 07:59:24 +0000 (GMT)
Received: from osiris (unknown [9.68.29.29])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  4 Nov 2026 07:59:24 +0000 (GMT)
Date: Wed, 4 Nov 2026 08:59:23 +0100
From: Steffen Eiden <seiden@linux.ibm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Andreas Grapentin <gra@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] KVM: s390: arm64: Fixes for arm64 KVM support
Message-ID: <20261104075923.8132-A-seiden@linux.ibm.com>
References: <20261103-s390_arm64_kvm_fixups-v1-0-21c36fedd878@linux.ibm.com>
 <864idx3gxo.wl-maz@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <864idx3gxo.wl-maz@kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Mcr5KJ/f c=1 sm=1 tr=0 ts=6aeae5e1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=ggGzQnQN4awjNpwVzzEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzMCBTYWx0ZWRfXxfVbup9GHinv
 hKyu/+yefVgynynGZHZbNwhFhZ5SIsy72sBY+6DxmRX65JuctHDcn7aYpTCTIGUQoXXb4mvxF+L
 wdG85g6A03aroNbUD0SLvtXi+oEaPV8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzMCBTYWx0ZWRfX4pk+606MSTy5
 3yDRzZc+Fec0v95akmR/Fxh50UNeWiU0qD1in4WHKzOHFjW//Cf+HiKJS1HmK51HQyKXuNx//KT
 GxbJR97373ujTlhXBreYN/+Gf/ynitV+V7wfNHH9ZSJkfxD7e5ibOIgXnWawvlKABWb2JA2sGIm
 iYexUhirrzQu5I20PsFIldxc+4+ZhWnTu7bTMqtAgqtiKKoq0Vsymxb5Rg4pNVj7yTni3VqZfFv
 gXZPVG9UPxnDIikGmj72TLAKEOGWML7xKQlw27m1K86s1VFJ9EyIx1Khy8GuK7Pm+0UfFcpSi07
 j0rb0x4d1vFiZMPnhWd8d5kFgH8BEV/1LcHdq/aFIEadgYDXfpYAqFPXa4RRN4OsaOfNvOIjH4Q
 NJZPxw4QasrtVX9SPd8HGd32Uo5/RV97GGgypY+Mpo/+7qbkylRe3tV/+HQ/GfAwSECvE57p0eW
 DD1MDrOz5dqh2AR1BOA==
X-Proofpoint-GUID: AiZn8Ak7zH0UuNv5w0Eu3D4wJTsL4kwP
X-Proofpoint-ORIG-GUID: AiZn8Ak7zH0UuNv5w0Eu3D4wJTsL4kwP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040030

On Tue, Nov 03, 2026 at 06:31:31PM +0000, Marc Zyngier wrote:
> On Tue, 03 Nov 2026 16:37:01 +0000,
> Andreas Grapentin <gra@linux.ibm.com> wrote:
> > 
> > Some fixups for the previous series that introduced arm64 KVM support on
> > s390. Forward-declare enum vcpu_sysreg because we are definitely going
> > to need that, then make the module naming consistent and iron out an
> > inconsistency in the definition of vcpu->arch.pause between s390 and
> > native arm64 KVM.
> 
> It's an interesting one. Obviously, this wasn't caught by building the
> upstream code. I guess this triggered with the rest of the patches?

Yes, this was triggered by the rest of the patches. The field somehow
got in the first batch although it is not needed. We'll need it later
anyways so I did not delete it for this fixup.

> 
> > 
> > No functional changes intended on either arm64 or s390.
> > 
> > Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> > ---
> > Andreas Grapentin (2):
> >       KVM: s390: arm64: Declare enum vcpu_sysreg
> >       KVM: s390: arm64: Fix kvm_arm64 module naming consistency
> > 
> > Steffen Eiden (1):
> >       KVM: s390: arm64: Turn vcpu->arch.pause into a counter
> > 
> >  arch/s390/include/asm/kvm_host_arm64.h |  8 ++++----
> >  arch/s390/kvm/arm64/Makefile           | 12 ++++++------
> >  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> Looks all reasonable to me.
> 
> Acked-by: Marc Zyngier <maz@kernel.org>

Thanks.

	Steffen

