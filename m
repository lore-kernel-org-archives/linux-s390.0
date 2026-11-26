Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795700283;
	b=qa44eVIHND+ixPosju1rIvgiK8o1B3jEcIjH+C8kS6onlGbPEpF5hnUSDE0LboWvG8oU
	 HG3neRxnyQ4fklNFvKRA5Caj6zwGITzCrfXCP5hjPoDXru/P+vKErjIW0cTHTO57JEMbz
	 D2tghAdK4lH7t0pTJmM1GYC2F1ayRG2dvyTqGFW/nGOb0qUmulMlo2zZbqaOZdQ+RcF61
	 nq0sDCeOAwVqt8TJJLb0ZQm81OIi1jscn4RGutCf68Q4q6Qld2RMci8QN218+MjC4yBFC
	 3Ll5ZdHJcP5sr3Jzv9dkp1kTzu6qenZyB7p1XmIXwAl63fr24EadayWhupEHTZOVxxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700283;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=02BGqLoy5W4EZR++kJaOBR7XvPnZihslZauH69lTdO4=;
	b=wwVuevp93qgx/gIknul3Dr0t9HBG1HFHaN3sX7WpLx4jI2p3fKZbYEi5wgq5d6IhEDk9
	 tG+JaIoWwHsRE9BjdnzQ3F852LaST2x6SoneLigqa1jvAWlKbTr4dW9+kOTq4ROjHjeOO
	 5sd85JfSvwULHfzq6TknnRvYcjgWy1lboDu9ZTsjbcxVYKplHH891QXteagNTamYutEur
	 NI0jNh/alQfGLkVBj2TbmDg0oi1baNPXGww6eKFEMGvxnGf0DrdOiRnEJO+fxF0QsPRuM
	 uPCtf2eQrwZ+s+lqvfVgNwqDK8exzJ40F1UFEwu7Eh7aC9vdBxEgjUu0f174DRcnAoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KOls12L7;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F591606A31C;
	Thu, 26 Nov 2026 13:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F591606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KOls12L7
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQBYimN4167477;
	Thu, 26 Nov 2026 13:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=02BGqLoy5W4EZR++kJaOBR7XvPnZih
	slZauH69lTdO4=; b=KOls12L72vnnjXrTjUWBLWgjFhoKFMKnBVXBRAGkcL2Djt
	F84Yb17spq3+bZpFQ2wuf0Dcao9/PBpsE+Ji/Qsko+/z0ea0RgYQPIuvQ0KmTSk6
	jD89jMBb8Rr1Hl4jxQnQYVG86ldhJrSFL5QZzkC9Or/pg+4Dnu5SSZ/Wa+AcqhY3
	73n8tZrXM5kIk954acvwAbs1xkwH44CPf6bhc/jRo7s0FT2jLUnOC9xdjKP2tFz0
	Wp1FFOjKaxzZylPsocMJf1VVVWgsHo6ClWoPZAY0O4DM+Uf0rmR601nV6ZMDPBtq
	T53noGrUPWBTzmmcaoL2PUpT2nan/YjXKVspxHTQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gvgy5y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 13:37:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQBYJ1s1111383;
	Thu, 26 Nov 2026 13:37:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5kfa6bth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 13:37:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AQDbjgH45482330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Nov 2026 13:37:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACD2C2004D;
	Thu, 26 Nov 2026 13:37:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8027B20043;
	Thu, 26 Nov 2026 13:37:45 +0000 (GMT)
Received: from osiris (unknown [9.68.29.29])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 26 Nov 2026 13:37:45 +0000 (GMT)
Date: Thu, 26 Nov 2026 14:37:44 +0100
From: Steffen Eiden <seiden@linux.ibm.com>
To: Dan Carpenter <dan@pereq.eu>
Cc: sashiko-reviews@lists.linux.dev, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, Oliver Upton <oupton@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Karthik Bhargavan <karthik@pereq.eu>,
        =?iso-8859-1?Q?Cl=E9ment?= Blaudeau <clement@cryspen.com>
Subject: Re: [PATCH v2 2/8] KVM: arm64: Reset SP_EL1, ELR_EL1 and SPSR_EL1
 when resetting a vcpu
Message-ID: <20261126133744.219929-A-seiden@linux.ibm.com>
References: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
 <20261125-double_exception-v2-2-224689d8a764@pereq.eu>
 <sashiko-outbox-232760@kernel.org>
 <awam4std0Zifdn9k@stanley.mountain>
 <awan8mSx5cbzXzJ7@stanley.mountain>
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
In-Reply-To: <awan8mSx5cbzXzJ7@stanley.mountain>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b08362e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=tATfSOZSwkvfaf42cScA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1MyBTYWx0ZWRfX0nYfkJib8H2e
 C5yHfAPDBViPSMaBWZemZJHITHp196Efv9d9lDY2D4QGRrBtNWXV5QylAghC5+n/C0pzn1CmzVY
 qvjr/n3MrMw2bBxhZHzBtATb/ZVAYiU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1MyBTYWx0ZWRfX8GlYiN7T4QMa
 09eTnuy+v8pDrTupsl1oO0OqWjqvbe3jHCD8CZv4xatonKxI6cOHvo232QfKTodwESNhbhyXSEJ
 D7itvXKPXSZ8Fqd7UrADUCL+WX8JRx4LI/ziYU0lUSQzq08RDiLeQqGIhvpzFY1mFrBr882Ts6p
 W/D21RUTR2H4FJGQAoh6Y4SdffEXEMfKw9KWDGZa+KQ2etQ0Qa03cd0WbD46KCnK1DrvtUnGXmm
 b9APgYjB671qGYz2F03i7L+SrJFsh/9915QBN+h8wSsKEJRkMder+PssfJ+f3X2qU44ND30WVff
 y5Ipy3rld/r0qscIrEWSD7RobcjH9bphpOehs+KlGEPZ8CTp9vWaDsr6oCYDNUA7OoF1X3YjMQ2
 J1HbUzf/iGDLV6kEQ5oAMk+6NekXF4aAqK82ZNhT3TkEnViiI9VMq2sfKbnyZZAchtrCxqkKK/7
 PRcIu11prvhlGzYKwxQ==
X-Proofpoint-ORIG-GUID: IOCH92TSPRg1nO84vXqoe5hpnwcJ5ANo
X-Proofpoint-GUID: IOCH92TSPRg1nO84vXqoe5hpnwcJ5ANo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611260053

On Wed, Nov 25, 2026 at 12:18:42PM +0300, Dan Carpenter wrote:
> On Wed, Nov 25, 2026 at 12:14:10PM +0300, Dan Carpenter wrote:
> > Let me add the s390 maintainers to the CC list.
> > 
> > I considered doing it the way Sashiko suggests but s390 doesn't have the
> > __vcpu_assign_sys_reg() helpers so it broke the build.  The registers are
> > not the same so, either way, some of this is going to be specific to
> > arm64.  But Sashiko is correct that s390 probably keeps a stale SP_EL1
> > across a reset.  The s390 maintainers could probably take the selftest in
> > patch 8 and modify it for s390.  :)
> > 

FYI: the arm on s390 KVM in the current upstream state has no idea what
SP_EL1 is :) 

> 
> Actually, never mind.  This can be done in kvm_reset_vcpu_core() like
> Suzuki Poulose suggests.
>

We share kvm_reset_vcpu_core() as well :) 

I assume this fix series should go into 7.4. right?

I have a series posted adding the required functions and infrastructure
for s390 [1]. This will likely go to 7.5.

For 7.4: Add a patch just providing a stub that does nothing for the
required helper (untested):

diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
index 3e69724f17c9..bdca7ebf6405 100644
--- a/arch/s390/include/asm/kvm_host_arm64.h
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -206,4 +206,6 @@ static inline void kvm_arch_async_page_present_queued(struct kvm_vcpu *vcpu)

 #define kvm_supports_32bit_el0() false

+#define __vcpu_assign_sys_reg(__vcpu, __reg, __val) (void)
+
 #endif /* ASM_KVM_HOST_ARM64_H */


If this does goes to 7.5 queuing that after the corresponding s390
patches would be the simpler approach.

Thanks for fixing the bugs 

	Steffen


[1] https://lore.kernel.org/all/20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com
