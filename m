Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78883DA5A1;
	Tue, 15 Sep 2026 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789485493; cv=none; b=rFr4VZnY3zFHugc16OxNJgHfPrbfzNjQe0dSnI/dobqkt/XHwjANZ+eonVTn5SWnvOPxkFNdBAPrQ2jq4q3Xnw0i7UNdHnT8PozIrH7pSUno3CZwNx053bkTW9kVqFwP/jEFs5PLa+sqPsQGTzETQXe2fTadsIL32W6/TKQ0I2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789485493; c=relaxed/simple;
	bh=zJhHO4mYc84ktjrPVU8zY4vu53j0s+pteo3nbECw4hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mt7NS/eNyuqKt16a+h5dxMzPmkMGEGCkyD43yRk6XNZ2lgELT3IHP0VqhFhMbKFptQTtPOoOxuNBvcwlOO1A/QPbduc1vh+WRmG8/t5pqnP/vomqaL0WUresVXY9dwN8NEluGb2Bzby+men6xT7jCzWNpzq9E7b6UK8tOaOz92A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iAxVku8r; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iAxVku8r"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FD1rZX3911396;
	Tue, 15 Sep 2026 15:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=76JtMQgcrcoWAQS7rfin5o8TJLarqB
	PYtiV7mCrQdrQ=; b=iAxVku8ruaXup7Mx/yNHEldPmLG8kabOQ6k3jb0asp5huv
	4nJSpyEhZ01j4k9yBLS92UoQbzvA1CPGG7M3mJNNxZlrsFykGQnDTWbOHByWN8yU
	T0yNgQDVKSsMlW9/rmqv1b8lxJJF0w2v+xxQQMM/9UvN2OnJkX4Vaw0Cx0Opnzts
	ZRHKRtpPoPnE2a8YF01UY58BSuWnE7ASHjUmBbs/FWr34JeCbonP2uhKzw8B5KUz
	vYoDFDEPDzmGW77LS/WpWFdrNwIdKM18LlBZuBogakwLIOKGjj+crnBPCqzFjkIL
	fHXWdyjfWX9fON84JgSqv26xW6kD9ow6PfA1v51w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5dymqn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 15:17:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68FFAiIG4140950;
	Tue, 15 Sep 2026 15:17:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq03bsxee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 15:17:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68FFHaHX54460826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Sep 2026 15:17:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6DAC20043;
	Tue, 15 Sep 2026 15:17:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D98F2004D;
	Tue, 15 Sep 2026 15:17:35 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 15 Sep 2026 15:17:35 +0000 (GMT)
Date: Tue, 15 Sep 2026 17:17:34 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Marc Zyngier <maz@kernel.org>
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
        Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v7 11/23] KVM: arm64: Share arm64 code with s390
Message-ID: <20260915151734.236989-A-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-12-seiden@linux.ibm.com>
 <87se3tmlrv.wl-maz@kernel.org>
 <20260901084037.185345-C-seiden@linux.ibm.com>
 <87mru0m76g.wl-maz@kernel.org>
 <20260902124152.438647-C-seiden@linux.ibm.com>
 <86ecey7l0f.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ecey7l0f.wl-maz@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIxOSBTYWx0ZWRfX39SwLfho220l
 JFpv8A+QB610kNtt6nv9eVbHt+JQjm+V6a65s5Uc1C0Exq4NcpQTyDw2q5UB41/1SF/ztQ3ZREX
 uT8yzEvffqr3TXSVAqIvbX6ZgHeXYHfp+M4JFmeXwSo2uJ0yWTPBps34aIASgApI87vj8X1LrcW
 hdOgOFf1elGwmEfu2dCG4pTZF/IgH9VBD2LOQa/pub2wcG7XGEqF1XcI9Iu24PmWMYXd2gJIfxW
 /X+Adg9LMWxmQ7Nnlkf3+603w58WINKnrl4VMcNs22Yv9kfH2ttZSkZXj9F0iBqxeO4JoDt2Cc2
 +tdOCgUJ1HJkyQG4Dw/80tzesDiGgu0KXmugAB0TtWnqwdIFUwhfq5kHt3uQbCKinRjxHZW8rSi
 COzQTsdmIc9/WX3AhCEfYMlYXn5g/2SAOBUWhkugZpJoC/OgobORWhJzxUFqry+JbH/co1rlwkZ
 9ykO4kqu5KvTKl1EPZg==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aa96195 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=Y8MAOLtguYw86oH_A5IA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: zpFR-hljM6rPtsYW02W-HcrR1bEPqXlA
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIxOSBTYWx0ZWRfX2yeS5KknftJK
 v9J2wj2t7OORAhvJB3k0c34in5YVwShjhUUwXfx61+xohp46yEcaCqVmWA/2ZGZF51kSukMWf8k
 SeZcdHozK1FxMI8OBzX0fB37ZhT+wD4=
X-Proofpoint-GUID: tY_ktDP9JJXAzqEbA4GNEvWtvNFHdGhR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150219

On Sat, Sep 12, 2026 at 12:43:28PM +0100, Marc Zyngier wrote:
> On Wed, 02 Sep 2026 13:41:52 +0100,
> Steffen Eiden <seiden@linux.ibm.com> wrote:
> 
> [...]
> 
> > So my suggestion is:
> > 
> > For series 1 (and 2) s390 has its own, local implementation of
> > handle_exit without sharing any code with arm64 in regard to EC
> > 
> > When s390 has all the relevant code available (likely series 3) s390 can
> > switch to using most (if not all) EC handling code used by
> > arm_exit_handlers implemented in handle_exit.c.
> > 
> > This can be done without a mixed patch:
> > 
> > 1. Mark arm64 handle_exit.c as shared (roughly the first 400Loc w/o
> >    includes) - s390 will not use it after this patch.
> > 2. remove the handle exit code from s390's handle_exit.c and include the
> >    new generated handle_exit.inc
> > 
> > This approach brings us further into the share architecture not only code
> > approach you meantrioned in the comments regarding sys-regs. (I or
> > Andreas will provide a solution for this later :) ) 
> > 
> > Is that OK with you, what do you think?
> 
> I *think* that's OK. I just want to make sure that in the long run, we
> don't end-up with pointless divergence.
>

Yes, that is what I want to avoid as well. I want like to share as much
architecture code/concepts as possible while keeping the churn as low as
possible.

	Steffen

