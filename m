Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A360B3EFD0F;
	Mon,  6 Jul 2026 11:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338842; cv=none; b=mquxIvns4QmzgWPUmRWrCUz2+Ksde6BuhlsqvnmI8XOlqimk66rMtcNWt/Ow46/UQCJJmlEGicyNASInEMntfRF9/cHKQx6DKR8XZJ40/e8DieE4wBzRwxytl2PcThqv9/CLoPoFRmOWzAkEKEfZA75ldxwqdmBporXkwYxWavA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338842; c=relaxed/simple;
	bh=IJ/TYANO9yqb+zvt3/nPQYtz0SWFco/ejBLBBADkoqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaUn7K+D4+c5rwHWgcgIsInRbHgZlkijYsIe/rwRvqLe6l9cur1WC1rDxyQYY/DWPfV6Dr6EWbMgN0I6OrnZj84iW/j1s7ooYa4UKWcwsXo74iN+EJYw1P2C125zck/mBDDt3oVDzZ2w7adDBjq9kDPHYDhIjSQE0YgRZe+ahS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sio/hwru; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sio/hwru"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BIZgD041409;
	Mon, 6 Jul 2026 11:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=s9n6tsDLu0c4N30evfB9JHjeraziDA
	ONy2Yyx3LR1Uo=; b=sio/hwru4xGhv4JXyM+22CEoogEV0e3ss5O3zcOV3rKpOd
	gNngkW2l+nCt3A98Jf8yXqnZNq5CX2lgHaArIl7begVnzGKB0s2DtrTopunBo0kS
	9mW7Tp+LLsYjUkqkioSE8JQICBQG87Q0z8ORjR2F+vA0N5q7DbJfmfTS/Iv8kpui
	SpEXjuv5MqI4CWO/SFbV4tQo6kklXCc9VVar+8ptAOaZbDRtO5ruMYF+IQ71BAs7
	2tItj4DckoyACFVzmKUkCaKAcrNTmqbRMvoM5DCc5PQizuR/YP8YsSjbuNPJWMAH
	zMm6btCfymWrsWeSvR6S0xk/E2qOhlAEWjnwa0Uw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qkn9arx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 11:53:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666BneZW007900;
	Mon, 6 Jul 2026 11:53:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6xw2q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 11:53:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666BraRD46727626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 11:53:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6AC92004B;
	Mon,  6 Jul 2026 11:53:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C471D20043;
	Mon,  6 Jul 2026 11:53:35 +0000 (GMT)
Received: from osiris (unknown [9.111.31.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  6 Jul 2026 11:53:35 +0000 (GMT)
Date: Mon, 6 Jul 2026 13:53:34 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v4 19/27] s390: Introduce Start Arm Execution instruction
Message-ID: <20260706115334.104396-P-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-20-seiden@linux.ibm.com>
 <8239c9ba-154c-4e2d-b2fc-700ba12eb585@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8239c9ba-154c-4e2d-b2fc-700ba12eb585@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4b9748 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=ERqXt4YBi1nz3Ag4VCMA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: fETsMo4dD4Y6qi9C3CNdK4GHSlsqbE4I
X-Proofpoint-ORIG-GUID: fETsMo4dD4Y6qi9C3CNdK4GHSlsqbE4I
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyMCBTYWx0ZWRfXzzTt3U/+SU+e
 f3uSEwUff5DwXPiE4hB24nxIGXCWoeGm93R1bnNIjw0sfzY7ZTUlOYH5y3iASau5Uxqnmkjtry5
 YuwmFpVIVAQiwJqxsWq0Tdt490mKokk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyMCBTYWx0ZWRfXxSx+4RrXjjI+
 EDEfQd7qDuHkSsHHsu9xPSn7cjGAyVKvOduFbg9HiyXtGzWRplnDfZpM2Si5isqm4lSGdyvlTKK
 aDFC5tUypUvDo5jyQgeShhh7n5OvtHIZ0FHbsSgNyCV+pLlhZXHI1MejXd854HIdR8H3wXhJ62u
 gccMZ9VgTUXDj7gcQDQjrcAYHpJbu8hsskWZPeadD/BOeI7EKu7mOywHK2GNWYl7zhAL9JXVfS/
 V7NNOZG2URgUzzsRmSlrKcxnVSZ2rQewz/a4VwiARX3W1Vt+hzGFHnKEATV1xVkN39payD+Tns4
 FGrePitja1Y/Zam+lM0x7XlahyirIWPV0WaLALaqCTw9xvK0TPjwg/fWNVjrT+1zA6BowOcPuHA
 bt6i3D257ca61V8o7/Qgmz4nLs4n0VbiOk0rsr4Q4SPogs+Sa1SZzc/YD7jblIzItdcXdRr3vcG
 WzCP+8n1omaYTrxrLAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060120

On Mon, Jul 06, 2026 at 01:17:02PM +0200, Janosch Frank wrote:
> On 7/6/26 10:52, Steffen Eiden wrote:
> > The Start Arm Execution (SAE) instruction is the centerpiece for
> > executing arm64 (KVM) guests on s390. Its purpose is, similar to SIE, to
> > enable accelerated execution of arm64 virtual machines. SAE expects the
> > physical address of a control block as the only argument.
> > 
> > The host is responsible to save & restore
> >   - GPRs 0-13
> >   - access register 0-15
> >   - breaking event register (BEAR)
> >   - vector/floating point registers
> > between SAE executions to guarantee host consistency.
> > 
> > GPRs and BEAR are save and restores in the asm functions. The other
> > register are handled in within C code. Access registers are handled in a
> > later patch and SVEs will be handled when they are introduced in a
> > future series. Most arm64 registers are handled by a satellite block
> > called save_area. Some registers, frequently used by hypervisors, are
> > placed into the SAE control block itself.
> > 
> > Enlighten asm/kvm_host_types.h for the new header variant. The new
> > header is chosen instead of asm/kvm_host_s390_types.h if KVM_S390_ARM64
> > is defined.
> > 
> 
> [...]
> 
> > +	u64	gpr[31];		/* 0x0300  */
> > +	u64	_03f8;			/* 0x03f8  */
> > +
> > +	union {
> > +		u64	icptd[8];		/* 0x0400 */
> > +		/* validity-interception reason; icptr 0x01 */
> > +#define SAE_VIR_UNKNOWN		0x00
> > +#define SAE_VIR_UNSUPP_FORMAT	0x01
> > +#define SAE_VIR_MSO_BOUNDS	0x02
> > +#define SAE_VIR_MSLA		0x03
> > +#define SAE_VIR_MGPAS		0x04
> > +#define SAE_VIR_INVAL_SYSREG	0x05
> > +#define SAE_VIR_HOST_CONTROL	0x06
> > +#define SAE_VIR_SCA		0x07
> > +#define SAE_VIR_MSO_ALIGN	0x08
> > +#define SAE_VIR_HLC		0x09
> > +#define SAE_VIR_IRPTC		0x0a
> 
> Will these ever be used for something?

I'll remove them.

