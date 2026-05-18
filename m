Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586BC3876A4;
	Mon, 18 May 2026 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779125602; cv=none; b=lRhJCt5m7Z5YdJ9jiAHAbQouscRhr83Rwxnlfq0WZ4kUVJVBmV+3PaNfCFmfJyxUV19CScX+Z8yLwnEqH57nnXSiFk6GBeuXrLTZA3RnBymnvcmyrVuZwS7SVXHvH9hRIYk6djJlamslBvkBzSKUeLmkb5hj1sTYO4yz4oHivvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779125602; c=relaxed/simple;
	bh=fTpFq3/wQ7FIRv/vjvT+dACvPobVNqtUp68bfYA4evU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhApwk09r3ExCc9EFj+TIdqic+tBZa8wmCjyo19HwnpcMaVXtfx+y5XtVXPP/tjwRAU79a7dpldBIPu86wLj6cSgUH6SccKS3MRm7t2gfo7SkWHmii3Rd8XWR51xRpenPG6wk1MCkN6y4UfOWltjSvvUEZD4xUq+pwhwtJQPRdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kzx2JqSl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kzx2JqSl"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IGKtbv3175559;
	Mon, 18 May 2026 17:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1AJo79
	grdike9ytu+cx2yoanOEzBfAiqRw1j2ZzuTCE=; b=Kzx2JqSlbilPChvV66P3pL
	FIptcwb6EX2abYY64Fl7JgG+jdez6N9mehqvAowhscpAgBR2hFagZq5rzD3/fhg0
	/2CVVCOURBRo0sinIEInJSU4NFAlLOVDdz3ZKbFKsSsiXCePJnjvCA080xPo7HS9
	7enzLve084YII9P95x0rVchiaawU5A/frbLQat+QByVIKNp62u4xiae08eqJbNsw
	kWNBeEbezltkBTGws+251PP5cq/2fIuCvMIYutoi9EfhMKRCN4xmFFyBKtiC93FB
	RKzNtXETFH8XVpiIVVuF/G+R/dP1uoitRl7jcp6g9lF0NQInmubUQ3hIfUjqZM5A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mh9sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 17:33:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64IHOHYT008599;
	Mon, 18 May 2026 17:33:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kxxq5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 17:33:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64IHWxQQ35979728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 17:32:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C01420043;
	Mon, 18 May 2026 17:32:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC81E20040;
	Mon, 18 May 2026 17:32:57 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown [9.111.60.118])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 18 May 2026 17:32:57 +0000 (GMT)
Date: Mon, 18 May 2026 19:32:56 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, ojeda@kernel.org,
        peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] s390: enable Rust support
Message-ID: <agtNSG2nJVhrRIUW@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260512105920.2426293-1-japo@linux.ibm.com>
 <20260512105920.2426293-5-japo@linux.ibm.com>
 <CANiq72=dD5fw6XmLJ=zSq_k_ZQy8sLLMs3m1xjX=UTpO7tLisw@mail.gmail.com>
 <agst-5rhj2mFF448@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CAH5fLgjbrPjpYReOYdPs+_Omv3w18AttkSGyc-VNogPZDP90kQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjbrPjpYReOYdPs+_Omv3w18AttkSGyc-VNogPZDP90kQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 8Xp0dn7wtdoilnNGItQfAin6p7B5pY7_
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0b4d4f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=xliUfsdOhJ765NiRnkcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tksR7WVimUh0gu4TTpxXd_INftFlVMv9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE2OCBTYWx0ZWRfX8qfqNdYo1RCa
 lTsq6cDWaKF2FId1dMfd5p+iioxmzVm/5aACkaz+rB0HVSOG4ae/tpOSIC5o7evqYTA65lAKoFs
 QarrqwG7bCLdFbeThG9iiz12YpinYCoPfW4yOPtKI7iwL4xzwgJfZTWg3azN0cAsbZ9QP4P3FUc
 sdHldqRtQeOsmieS1wo+rUZa2RAdrbcSsEId14x9fm9c2ve2uLqqFOSCCKJ8axnCK2gDizE9A/i
 ptIqCZCxmEGeVvklHhOei2/2wDG6hqSWdfinMNpYcq/PSPb2gYXRLgeSsq3fXMU3L7taoX9i2tB
 Na6S4LQ3873W2+Nt2ct9IiDtN1lmLal12X4iPWWBJvY5IRKK6ji+mH2ESWhDtSTV9xKxAD54eQr
 VqKK0sn95MfGa7wifW6JEGapuv4IEIDU+vUlHDt/9/3CtooLBSa7Rr7TRs8Tk8/0R2yxuQiUugc
 /KD4N1MASc2kZkO+9wg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180168

On Mon, May 18, 2026 at 05:30:26PM +0200, Alice Ryhl wrote:
> On Mon, May 18, 2026 at 5:19 PM Jan Polensky <japo@linux.ibm.com> wrote:
> >
> > On Tue, May 12, 2026 at 02:10:52PM +0200, Miguel Ojeda wrote:
> > > On Tue, May 12, 2026 at 1:00 PM Jan Polensky <japo@linux.ibm.com> wrote:
> > > >
> > > > Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> > >
> > > Closes: https://github.com/Rust-for-Linux/linux/issues/106
> > >
> > > I am happy to see IBM getting involved and being able to close a 5
> > > year issue! :)
> > :)
> > >
> > > I backlinked there this thread.
> > >
> > > > +KBUILD_RUSTFLAGS += --target=s390x-unknown-none-softfloat -Zpacked-stack -Ctarget-feature=+backchain
> > >
> > > I added `-Zpacked-stack` and a bunch of related links to:
> > >
> > >   https://github.com/Rust-for-Linux/linux/issues/2
> > >
> > > Is there a tracking issue for it? I linked
> > > https://github.com/rust-lang/rust/issues/150259 for the backchain
> > > feature.
> > >
> > > > +       if [ "$SRCARCH" = "s390" ]; then
> > > > +               echo 1.97.0-nightly
> > >
> > > `-Zpacked-stack` landed for 1.96. Is there something queued for 1.97?
> > > If not, does the beta work?
> > >
> > > Either way, I would prefer waiting until we know the actual version
> > > number, i.e. without `-nightly`. It is just a few weeks away anyway.
> > >
> > > Thanks!
> > >
> > > Cheers,
> > > Miguel
> >
> > Hi Miguel,
> >
> > thanks for the review.
> >
> > -Zpacked-stack: I’m not aware of a dedicated rust-lang/rust tracking
> > issue for this flag. The implementation landed via rust-lang/rust PR
> > 152432, but it doesn’t appear to reference a tracking issue.
> >
> > backchain: ack, the s390x target-feature tracking issue you linked is the
> > right umbrella reference.
> >
> > minimum toolchain version / beta: as long as we pass -Zpacked-stack in
> > KBUILD_RUSTFLAGS, we need a nightly compiler; beta/stable won’t accept -Z
> > flags. In v2 I’ll drop the 1.97.0-nightly guess and set the minimum to
> > 1.96.0-nightly (the first release line that includes -Zpacked-stack).
> > We’ll keep the “-nightly” suffix while this remains a -Z flag. If it gets
> > stabilized and nothing blocks, the earliest stable release that could
> > plausibly carry it would be 1.98.
>
> You should not add a nightly suffix for this reason. If it's available
> in nightly since 1.96.0, then you just write 1.96.0 here. Linux uses
> RUSTC_BOOTSTRAP to allow use of such flags on stable compiler builds.
>
> Alice

Hi Alice,

thanks for the clarification. `-Zpacked-stack` is currently only
available starting with 1.96.0-nightly, which is the last prerequisite
for our toolchain and the kernel build. I will set the minimum rustc
version to 1.96.0 (without “-nightly”), since the kernel uses
RUSTC_BOOTSTRAP to allow `-Z` flags on stable compiler builds.

Thanks,
Jan

