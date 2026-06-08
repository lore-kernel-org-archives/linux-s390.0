Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AE037F721;
	Mon,  8 Jun 2026 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780947965; cv=none; b=OZ020BcyeW6IqlpVsTIwAMOFzfwDNEnqK7ej+Hx6XOgzF+7+aE5N2sA0lkUCRdiNrmzDtAHRwF5m0+elHCEb/tJ6kfcoVJqQhlIkN15rnZQ6/arGYmtDVaBKowq+vjwxLk/JCDdMAh6VTQjk0ia6PPEpPQ84aYC9dRUpwKLDIwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780947965; c=relaxed/simple;
	bh=FuwoI1zFq0YV/52Dk1RfBYLrLeCYnKkTd+VdjVTENhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRWOd+jutpiMq+6y+vlWJ4wbX3+Ad+D7EAKDIL+7hgpzfAlGS6WcAQN0Mb2oyEH1SeU9bK8/7R3On2rS042KH3bAZ5PacLCV0BGT59cWKPrpr2RC/o/O8NTxNWZpkMFp9pHelVh4e51oXW9mgP+blyF3rvHUODlYMzh1K/rQpBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=anBz+dB3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="anBz+dB3"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658A4gUO3640226;
	Mon, 8 Jun 2026 19:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=FuwoI1zFq0YV/52Dk1RfBYLrLeCYnK
	kTd+VdjVTENhE=; b=anBz+dB3E9wO6gQeCHs1SbPMpvwI97FCS8PGN8KYAI7edx
	Ru82J9TMakPS7Bft9ITxNHkBLN7PTLWEMrVgk5b+DSFUlb37MfBw1lwT0oxXaal7
	fHB+vQsUAZ97HMqy7+zFUUDLerWQ6CqSdLwjb3w4jT+5vL4COGJkqXDroWRWRX8h
	Oh+PZRFupp+qHN/MA2XHv08zOy6wF1g7CkLbUUKpNQqywAnn912gcVBIa/RYqO4m
	8KTq3O2ZUPJcXYqqTsLYykPgMBMbKTsqFDPLB8ehxjS8xZtgkg3AulyVTiB95FLY
	swmHz8+BWP5TzpuFsViIeMXvSBlaS2Lzo0Sv/0BA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye0y4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 19:45:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658JJd9K002062;
	Mon, 8 Jun 2026 19:45:47 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8vxy8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 19:45:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658JjiUN51183950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 19:45:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDF5B2004B;
	Mon,  8 Jun 2026 19:45:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C411D20040;
	Mon,  8 Jun 2026 19:45:42 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown [9.87.135.117])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Jun 2026 19:45:42 +0000 (GMT)
Date: Mon, 8 Jun 2026 21:45:41 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Gary Guo <gary@garyguo.net>, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, ojeda@kernel.org, peterz@infradead.org,
        jpoimboe@kernel.org, jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
        tmgross@umich.edu, dakr@kernel.org, rostedt@goodmis.org,
        ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/6] s390: Enable Rust support
Message-ID: <aicb5a1_SG5B_ByM@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260608181451.3734956-1-japo@linux.ibm.com>
 <20260608181451.3734956-7-japo@linux.ibm.com>
 <DJ3VN4EYXCUA.18YA9379UHT5Z@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJ3VN4EYXCUA.18YA9379UHT5Z@garyguo.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE3NyBTYWx0ZWRfX2Lh+SaNaDM5Q
 9T1usqJg39kLYWnIpcWOlA/lXeOHb87ZQDZoiUZxPP5qx85P4dwXD5wrbxzSAiZEqVK3eDEgnF8
 rj6O8SIFQoexK559vVEl+gzKnLGgHPkB3ei+JeC5ycupVSSgJVpSzdQqs0v/oQ3WifeVGV5+qIr
 srCIrmFu3wKYpcBEymmUGNw/nrpha2bGnbN7hubOwD8bVqK+rIvFGSgkHq3kxh89ugVXUnS7wvc
 3r0ZweY28UPLX589rzizC6oceX8fBn5WYFWP/N1vjEK7j6shpHHmppQC9lTA1C3Cxqs5IqiaE0K
 FsQUndkNs9vzWwNvchYkM1DAYToPwA5IXIQhM2i66ZgXJaeqdvU1ipt2OOzAXb64uhjfRw/9QcB
 PRZ9+Hs86RngOztO7exoJgnDuvvjbbGdFjOvUNBwWGWN4yPEJ+/s/vnCF5uBz7ODYVevdr0k6tL
 0RKxYm/M/4RazT3F+1A==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a271bed cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=5GdfEeL4wVfAcitZt-8A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 6IrOn4Ik66KRtSKnx79uPbtWp8I4oecN
X-Proofpoint-ORIG-GUID: ZLtCeCFROGdl4q267_Fdq3r_kpq_b4kF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_05,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080177

On Mon, Jun 08, 2026 at 07:25:06PM +0100, Gary Guo wrote:
> On Mon Jun 8, 2026 at 7:14 PM BST, Jan Polensky wrote:
> > Enable building Rust code on s390 by wiring the architecture into the
> > kernel Rust infrastructure.
> >
> > Add s390 to the Rust arch support documentation, provide the s390 Rust
> > target and required compiler flags, and set the bindgen target for
> > arch/s390. Adjust the Rust target generation and minimum rustc version
> > gating so the s390 setup is handled explicitly.
> >
> > The Rust toolchain uses the "s390x" triple naming for the 64 bit target.
> >
> > Rust support is currently incompatible with CONFIG_EXPOLINE, which
> > relies on compiler support for the -mindirect-branch= and
> > -mfunction_return= options. Therefore, select HAVE_RUST only when
> > EXPOLINE is disabled.
>
> Does `-Zretpoline-external-thunk`/`-Zretpoline` not work for s390? Rust will
> throw a warning saying that it doesn't recognize this for the target, but it
> looks like it does generate target features
> +retpoline-external-thunk,+retpoline-indirect-branches,+retpoline-indirect-calls
> in LLVM IR.
>
> Best,
> Gary
>

Hi Gary,

thanks. The warning by itself does not prove the flags are ignored,
since rustc may still forward unknown target features to the backend.

That said, s390 currently has no Rust/LLVM support for the EXPOLINE
compiler support we rely on in C, and the kernel-side Rust retpoline
handling is only wired up for x86/x86_64 today.

Backend support is planned, but has not been implemented yet. Until then,
keeping Rust support gated behind !CONFIG_EXPOLINE is the intentional and
conservative choice for this series.

Best,
Jan
