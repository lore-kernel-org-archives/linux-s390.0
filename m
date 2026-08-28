Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309C137F725;
	Fri, 28 Aug 2026 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933687; cv=none; b=XLph2Mir0+lrBb3PGQ7nEeUXwN7yM2NxAPBtBxiWDDWvScN5LV85S46hcsYR8Sd/yReTf3SA/URBTfQbe9n83qMyJ3h1GRXjTYrfyVCnBapGFyE4NhaVP+W3/CwwtsXRcBMyA9eAvvkPQHEZALIbyFgUPO79pPTIjbIAPpODFMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933687; c=relaxed/simple;
	bh=5cG9Cyj233IkTf95MvgZQ8jdXN+FmLHn5ZuloYzK0CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqb7XWLIP2i9rn+IJS+ixeO4pMO2tVOPQXxKWLji3dHb8/f9X8Dxsd0JyU/I/O4l755lU3OiEZ/IdFA2qQVMqardbhB0o6rEZr0tn241z3/P3miD2ockbtcTJOfcd1bYZU6cdv4WDdDBy9vDMs5+32ZFo4J4nyNr/PGSsRf/zA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pyD09kTt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pyD09kTt"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDVV3Q2103053;
	Fri, 28 Aug 2026 16:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=b+ACTBmM0+p0qH4wH4Z9F8ihyRM/CW
	d6wxi34YiAYmo=; b=pyD09kTt5fLKs/5P8l2r0nS5dpyFwMuDiQWkyIpybnVSML
	w4vfTtb9UkGjRyzYybgmjpKmwNcA8B0Tj+dcIRA+cu8J3pF0vh28WE6VKkILiwSQ
	bnFT/CxpHqXF4r0PiZ49/+Utw8NQ3Dx+hSpx0YqSCorybcC2TxT15bRttMIFFqRu
	DsNcuEC5dEBv8sU1p402fSYNXyVIXev/Su1bLQlowu1X3ceexVd45f5pI39LS0AR
	C7pWKTGKIHg+zieAg1u47JLY+extopyqphb60Bj3wnx9ONAZObSDrBu9ySO2mtu6
	9Gj6uXBlVQGw6uzsQXEXNGDf3rq0ORbKEBZBMI0Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7394np8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 16:14:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67SGBGSr006892;
	Fri, 28 Aug 2026 16:14:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qqnq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 16:14:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67SGEI2T37028136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 16:14:18 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3763C20043;
	Fri, 28 Aug 2026 16:14:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4763320040;
	Fri, 28 Aug 2026 16:14:17 +0000 (GMT)
Received: from osiris (unknown [9.111.68.102])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 28 Aug 2026 16:14:17 +0000 (GMT)
Date: Fri, 28 Aug 2026 18:14:16 +0200
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
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v6 31/33] KVM: s390: arm64: Implement vCPU IOCTLs
Message-ID: <20260828161416.164752-B-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-32-seiden@linux.ibm.com>
 <8b141a3d-1ea7-44ad-9311-2157ef37d59f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b141a3d-1ea7-44ad-9311-2157ef37d59f@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: xYV0U-q5HSwRRYNF2YzhHs5akyyE1Ip_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzOSBTYWx0ZWRfXxn8wDFUddKvg
 hrpPnu9uLX26z2vCg3K1Gz4/rGFyERafolaJ60pNF38W06tVbEgda3xwjkTeTE06QrPwCOQibgo
 n7cSw/GxJ8co7pwOe/7LZYIzPvymt5Eo9u+3CCG6l5gRI3bXvu/PNK8TI5PAPhpGmZmkwXEdcxI
 Ae7l55Agmphpw6wwL+APxIEzZGUDHBnoKjnXby1MxLoFHE4QDWfm4iYGrvEtlxl0/jYzJMOW+x+
 b1lWZbec3AS/7kc7F/+xc0/tnQMyTP5P0x03iEJ2uzZzaTvYqrK0lY4SKEdRCHZ1uFFYnnGf6es
 hlkOb3qiMTKrcpDLIfCRx3oOHCjnyH15XfvoYTED329wDtOl7g024qlaLbkSKTytF8hoKiUdyEI
 Dlb0ztBAYyEuPeLJ/gMx+Qokls/FbF7wQ05mt/XDLze5ebq8zdJkqgqZz4z5tu0auhy9yHv5hrA
 qildb2f4mwa8/qbO3vg==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a91b3df cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=hdEzL2LqU29Kkz1BBA8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzOSBTYWx0ZWRfX/dFjPldipt2f
 q6+s/sAKIfSOEpS9+/fpzmP0F/kE4Qj3D93/+VNxsfALbjiN5Kpb0EDJ4Zqzo12oz0w7G1ccqOp
 bQaDv3LUsVuRwhmO72w0lu/IqpHLj/g=
X-Proofpoint-ORIG-GUID: 3N4ZzIrXz_MlJmBm3joiMUE0Itwzwn8l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280139

On Fri, Aug 28, 2026 at 03:34:34PM +0200, Janosch Frank wrote:
> On 8/12/26 5:36 PM, Steffen Eiden wrote:
> > Implement all required vCPU IOCTLs.
> > 
> > Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> > Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> > Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> > ---
> >   arch/s390/kvm/arm64/arm.c         | 392 ++++++++++++++++++++++++++++++
> >   arch/s390/kvm/arm64/guest.c       |  47 +++-
> >   arch/s390/kvm/arm64/handle_exit.c |  31 +++
> >   arch/s390/kvm/arm64/handle_exit.h |   9 +
> >   arch/s390/kvm/arm64/reset.c       |  73 ++++++
> >   arch/s390/kvm/arm64/reset.h       |  11 +
> >   arch/s390/kvm/arm64/trace.h       |   2 +-
> >   7 files changed, 562 insertions(+), 3 deletions(-)
> >   create mode 100644 arch/s390/kvm/arm64/handle_exit.h
> >   create mode 100644 arch/s390/kvm/arm64/reset.c
> >   create mode 100644 arch/s390/kvm/arm64/reset.h
> > 
> 
> [...]
> 
> > +static int kvm_vcpu_initialize(struct kvm_vcpu *vcpu,
> > +			       const struct kvm_vcpu_init *init)
> > +{
> > +	unsigned long features = init->features[0];
> > +	struct kvm *kvm = vcpu->kvm;
> > +
> > +	scoped_guard(mutex, &kvm->arch.config_lock) {
> > +		if (test_bit(KVM_ARCH_FLAG_VCPU_FEATURES_CONFIGURED,
> > +			     &kvm->arch.flags) &&
> 
> 
> In this case I'd rather have a long line than having to look at this mess.
> One of the cases where a normal mutex acquisition would have made the code
> more readable.

Technically, it would not fit into the 80chars even if I use traditional
locks.

Nontheless, I'll use a guard(mutex) and then go 2 chars over the limit
for improved reading.

...

> > +
> > +	ret = 1;
> > +	do {
> > +		if (signal_pending(current)) {
> > +			kvm_run->exit_reason = KVM_EXIT_INTR;
> > +			ret = -EINTR;
> > +			continue;
> 
> Why not break?
> With continue we'll jump to the condition which is immediately false since
> we just set ret to a negative value.
> 

I'll break


	Steffen
