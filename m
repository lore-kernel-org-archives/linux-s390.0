Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619EA3A5436;
	Fri, 25 Sep 2026 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790325929; cv=none; b=OMHayU2F9ClYu/mwmbqokLZ8VRe+RDuKxMa9NTO8UHfJkT6ihZxoDXxChC05zh+G3lp13VgCVQ4k38SeUMQznERErJHEN3CLDoGlYOxDpkUI3xy/SS+h2GkABT+bwFEYpfojzvj0wjcMVvrmbsmkJUYU7Um5iLhWLbyoqdMXv7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790325929; c=relaxed/simple;
	bh=J/nvE5eYJpS0kIo0tIMt5vOFhmfBJFQUnBTgMp5546c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJLOliqldhv/UyPibHly+BUE8VR3nNyjqsES6/S3w1t+Pdqt2P5SqWsqynedcakCYFHmXLvTWC4cKh8XbKrU29ON3wSlukOMKIYt1hrO8XG5uRkWhvkEqlRMB7xvTyIFjpw2uEQjFLL8UarToYpmstPGc93JctSZ+uXbN1KqMLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p3huYxFH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p3huYxFH"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4ZuCw4104239;
	Fri, 25 Sep 2026 08:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=2de9xHNjmPAOVaG2ifsPQ33bU5QHct
	L9cV7tymsHQY0=; b=p3huYxFHoSEQncV4QHHXzz9lN66r41EH9qE+HH2FTWFAo5
	h/zba0v1i+C0lHm8p2oh9LrPWVV3JhMXJRxLFZdaiKbbx78fnhoRNxy3VsNT261u
	bOl1eIgrFHbcrLXw+wr961mlSwl/0x47DzjqFGscKv1Z2XQo5YHvdhbHwvJ/B67N
	RoylsQAfclr6bKM/i7XgIxeHGJuwlQzJkx7+sn+KWg+ZW8EfSpKI3oV0+kp8R6Ef
	M+UIn9ZkBXlwgq5Ra5CRDPgCDKq4OfWB+dP1dpoNuFNSn2sM8P0NVMsKNkfB4/GG
	o5fFDUTtUg7Pcb+/6QZNnYiMoUzfXOw8A4Zzf+1w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1w7vm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 08:44:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4lYGl1959512;
	Fri, 25 Sep 2026 08:44:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7edxau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 08:44:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P8iPQw28836176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 08:44:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF1762004B;
	Fri, 25 Sep 2026 08:44:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39CD820043;
	Fri, 25 Sep 2026 08:44:23 +0000 (GMT)
Received: from osiris (unknown [9.111.31.68])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 25 Sep 2026 08:44:23 +0000 (GMT)
Date: Fri, 25 Sep 2026 10:44:21 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
        bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
        aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
        daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com,
        work@onurozkan.dev, nathan@kernel.org, ndesaulniers@google.com,
        morbo@google.com, justinstitt@google.com, jszhang@kernel.org,
        japo@linux.ibm.com, jpoimboe@kernel.org, seanjc@google.com,
        pmladek@suse.com, thuth@redhat.com, ynorov@nvidia.com,
        joelagnelf@nvidia.com, david@davidgow.net, fujita.tomonori@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [RFC] rust: kernel: Add KUnit tests for ARCH_WARN_ASM bug table
 emission
Message-ID: <20260925084421.23528Afe-hca@linux.ibm.com>
References: <20260922054959.955093-2-mkchauras@gmail.com>
 <20260922064735.GS4121339@noisy.programming.kicks-ass.net>
 <arNxAn7I7NCVWmD1@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <20260924111557.GP1837346@noisy.programming.kicks-ass.net>
 <20260924151335.18402A8b-hca@linux.ibm.com>
 <arYWDWmMJgIAt1_W@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arYWDWmMJgIAt1_W@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 87lA0aCgX2z2D3O1YImj8y7jkpHmz4CB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzNCBTYWx0ZWRfXyKhVgC1T7hXc
 V/4zpWORmrgXaPIYCPqnXQh+/XRSwR1UXNgV2YvLqkokz4XTbTo2lSCIo2oGyHP5I/BQxBbtksw
 OLPZx6zdmUHojKQonoku7cjqsdZoePEMaX0dEzbcuBAjpuNDcXWXe3/vUlCZJCpBd1Ovtom/noX
 MmniggVMhfgZ4L07KrgtwHhet7Eir9r3Xd+hvhCrbn95SRLiCdjhLNRQOT1IocKdr6r3LvwTadO
 y4CSA8jcRzWbkgfE23lR/ONSq0zsrCi65ubnC6woMeUNsQI0j9K2e5fXc2TQHy5gh1QKHLNc17Y
 OAKjpKoYQ7Qn9zZ/n69xqyFwRfiWN33KM1gJzZ/57d5EDtrsVvAoPaozHfnjajPwokHT1TRbBU9
 QhA36CoSDk/x1vOSIIwGzAn4zrb42OphDQSjxR+zQe/DJOGEddcYVSIoiECr93Fdhd/S9YsZJa3
 kKlU0vrfYgVZwYwHzZg==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab6346e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=kNr3sdrnxbR47e0HQjsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzNCBTYWx0ZWRfXy9BY6yI3+QWb
 ojtvWdD5I9GgEO2EI/5q1+KsJFtrN8hUGDyFDrjjLiBS4udvzPoklpbszwigPS0vRy/fC9pj/Ag
 cPRsb7OwEtSlA8sDaU+DGjpOMGVPE3o=
X-Proofpoint-GUID: rzTFMSH6Roqit0uEX2DfQ6jw3cCbmDAk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250034

On Fri, Sep 25, 2026 at 12:06:28PM +0530, Mukesh Kumar Chaurasiya wrote:
> On Thu, Sep 24, 2026 at 05:13:35PM +0200, Heiko Carstens wrote:
> > On Thu, Sep 24, 2026 at 01:15:57PM +0200, Peter Zijlstra wrote:
> > > Untested thingies for arm64 and s390x.
> > >  int is_valid_bugaddr(unsigned long addr)
> > >  {
> > > -	return 1;
> > > +	u16 insn;
> > > +
> > > +	if (get_kernel_nofault(insn, (u16 *)addr))
> > > +		return 0;
> > > +
> > > +	return insn == 0x0001 || insn == 0x000e;
> > 
> > I have no idea why anybody wants to do this, but it looks like I'm not
> > alone :) In any case: the check is wrong.
> > s390 uses only the monitor call instruction and this should be
> > 
> > 	return insn == 0xaf00;
> 
> should i send this out along with ppc. I am not paricularly very good
> with s390's assembly, but if this looks correct to you, i can send it
> out.

No, I still don't get what this fixes, or what the improvement would be
(also not after reading you reply to Mark). The current code is fine for
s390. Unless there is a pressing need I'd like to keep it as it is.
