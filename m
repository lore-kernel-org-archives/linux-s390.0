Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735E627F017;
	Mon, 18 May 2026 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117590; cv=none; b=JTrllMuPW2ZAlXz5T7fNZd9l0xoK1WnYdzj9GNqzD80YsflO73T6XHqaK30HY6lFBuMCKtUgpbeIHpnc0QaPzzcE2tZwA5u/zqs6j9HZIEplImtf3qG0Etyde9VHkrRehCUwHRq114LmDJp8Me45pwEtxYLlHuzfZyRDPekntEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117590; c=relaxed/simple;
	bh=ztT+I3bdRQnQ/U1gREjDJ+ZsHMUhpZ4esibexJPoTDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZqFAOU70f6MfRZQaCVZqmE+Ztfsmej9exdUOM1Pq2r9RxHpnWU0BRcc5/5jcmTPotyJxtaGj7DPNy30bOporWk9/uMzBCAYXmp4Dq05panMdkCLgOiIc28A7wxCrfokELwGZ1BZDw/Hz6nyIdvcL8qK6N/K28Z8+t0TU8eWk9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CGjG/R+a; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CGjG/R+a"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ID3JIw713511;
	Mon, 18 May 2026 15:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=asRf8G
	ZwhQFo7pcspZ9Qb3Hz5Zwi7ycpce8WuViNLcc=; b=CGjG/R+aDaZLx43KPlERbb
	0QllqMtvYwOk+POqx1M+vTGzok6ZwmI/Y1CY0Sxol3h/Q3UEBJcaA7BYL5BE3GEF
	A6tm8CiATkPRhAKEs9yNDdPS1r1JDeX508yRRy6CLIdkzmta6KTscxmGxwnOgE/V
	vXWjQiN4xczFNdzHGBmosonUHgjTyenPyEnuchaIShGYAHgkMcQUiYH6ROPxCue8
	/4sQKJR0k0WaUAm3jY8G5cw2Im2amXPlluGl/8Z7YAKAfpGgoy8dGCwBuVfnveHP
	zsC7PUyPXTWVmPcr9w2AxpInP6C3fjgEh6N0DArrWE6M42/NS0IFT70OTrAyyUdQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h74rs9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 15:19:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64IF9B5i021246;
	Mon, 18 May 2026 15:19:29 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wpxntp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 15:19:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64IFJQ1i47841732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 15:19:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E56622004E;
	Mon, 18 May 2026 15:19:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9851420040;
	Mon, 18 May 2026 15:19:24 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown [9.111.60.118])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 18 May 2026 15:19:24 +0000 (GMT)
Date: Mon, 18 May 2026 17:19:23 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, boqun@kernel.org, gary@garyguo.net,
        bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
        tmgross@umich.edu, dakr@kernel.org, rostedt@goodmis.org,
        ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] s390: enable Rust support
Message-ID: <agst-5rhj2mFF448@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260512105920.2426293-1-japo@linux.ibm.com>
 <20260512105920.2426293-5-japo@linux.ibm.com>
 <CANiq72=dD5fw6XmLJ=zSq_k_ZQy8sLLMs3m1xjX=UTpO7tLisw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=dD5fw6XmLJ=zSq_k_ZQy8sLLMs3m1xjX=UTpO7tLisw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0b2e03 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=HQ1FvIGFvDyT47lXsOsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mAbRrBPTh-gJ1Y5a-KxrYwbKOS9v05Lx
X-Proofpoint-GUID: cODwNgnwOUAC0KSt4pj5F46AfK8szurB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE0OCBTYWx0ZWRfX1Q28HJGcwgcv
 jzWEZkeAA/Cm79ZEz9nJZ8mgqhytuIHwrJQLp6TXItuvf0EWYYIhD1vi+0yll3TgaE5hZB7ebWO
 pjqkJNbmSEe0wLvjqwMsRWmD9rJ2qy4SIR3WT2W46YVR/FACowMfbyxlWlk4zUrO3+nXD0GUMIH
 s4CwRDAaXsxzLPaxx679SvXgHnu4vwuYXwVl71yB1CocxdTYN6++s6dGbemAJk4oFlFm2bHykdh
 nNE+HoXDXHitveq0R9lBfZinCuWJKQVmTYG5WP6MRhzOhFdQUI0RaDTcv7oTRtJAgfxiQ6e/9cw
 eHfTwieUUloQD3S4ejd0CwReSWIGaqO8SsyfnOVwYZ11scOYWlgKMjldx/3n6lnNd5hfuHevXug
 yWplDMcnnGo5Ov0/Dm2UDxMBABgxBTeQvDWPKcm8Sur6LHFXXdCYooBFng8ddPp+hy2s3WVeNn9
 DD1/j7IQEYJKgZ69p8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180148

On Tue, May 12, 2026 at 02:10:52PM +0200, Miguel Ojeda wrote:
> On Tue, May 12, 2026 at 1:00 PM Jan Polensky <japo@linux.ibm.com> wrote:
> >
> > Signed-off-by: Jan Polensky <japo@linux.ibm.com>
>
> Closes: https://github.com/Rust-for-Linux/linux/issues/106
>
> I am happy to see IBM getting involved and being able to close a 5
> year issue! :)
:)
>
> I backlinked there this thread.
>
> > +KBUILD_RUSTFLAGS += --target=s390x-unknown-none-softfloat -Zpacked-stack -Ctarget-feature=+backchain
>
> I added `-Zpacked-stack` and a bunch of related links to:
>
>   https://github.com/Rust-for-Linux/linux/issues/2
>
> Is there a tracking issue for it? I linked
> https://github.com/rust-lang/rust/issues/150259 for the backchain
> feature.
>
> > +       if [ "$SRCARCH" = "s390" ]; then
> > +               echo 1.97.0-nightly
>
> `-Zpacked-stack` landed for 1.96. Is there something queued for 1.97?
> If not, does the beta work?
>
> Either way, I would prefer waiting until we know the actual version
> number, i.e. without `-nightly`. It is just a few weeks away anyway.
>
> Thanks!
>
> Cheers,
> Miguel

Hi Miguel,

thanks for the review.

-Zpacked-stack: I’m not aware of a dedicated rust-lang/rust tracking
issue for this flag. The implementation landed via rust-lang/rust PR
152432, but it doesn’t appear to reference a tracking issue.

backchain: ack, the s390x target-feature tracking issue you linked is the
right umbrella reference.

minimum toolchain version / beta: as long as we pass -Zpacked-stack in
KBUILD_RUSTFLAGS, we need a nightly compiler; beta/stable won’t accept -Z
flags. In v2 I’ll drop the 1.97.0-nightly guess and set the minimum to
1.96.0-nightly (the first release line that includes -Zpacked-stack).
We’ll keep the “-nightly” suffix while this remains a -Z flag. If it gets
stabilized and nothing blocks, the earliest stable release that could
plausibly carry it would be 1.98.

Thanks,
Jan
