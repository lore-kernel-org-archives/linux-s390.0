Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA6427A91D;
	Mon, 18 May 2026 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132194; cv=none; b=uHWoYU3LtV9LFdkFlULbp0mIX5YGW207N3Ibh47LQqXIk1g5qoh1rYdRCtGWm+ijDgttTuAF4d9j9fgUAlqYEXCvaXLe7G28d71ouO3d9WUdjtpcF3n31bR/r4q25TLr2UqFh3/xBQGzLx8kEUk/doxjDNb3zixuTSuZGXGAEec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132194; c=relaxed/simple;
	bh=EwbvFUEHbSGfxYp59ljnXmf80Vq97RjSBEkvXqpPVLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIbM9inu33ZiCZ1a5nDxJV/J8Y5/3F7EUHt2k1dRfkNQw6lYD5JkaEEZo+JI0JDwWOMVAYXYIh0OpRShthrFMUWAw4bAz9i5ReUrfg1uIL7gZkoY5XblwZzjLv0LLgVHP5o5i6lah26kDHYU2MizzFiBtruS+ce+NaBjPrTU6jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=biN9UJ91; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="biN9UJ91"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IEXMgc2723414;
	Mon, 18 May 2026 19:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jbArDC
	YPVwk2TZqJmnpIo+zByOISKcSAXATobiR6s8Q=; b=biN9UJ91Jvf0VpL1VQSOJ3
	aCQnxeYLYxjXAqt/HCbgGQe1zn8bJeFUY7cSvN963eQ3grvhEYP1C/cDM1ro+Zvw
	FLUK9RMYTJPXRBby5MBGZovOggbfh1rir4JOhVIAxTO/mSDartpxErJyehbFaKtq
	Rp/+bLvUDR8Hd4940vaWL+kMqFnK28jPBLcGwNMA30hw6CPPttjeNjg4xv2geNI3
	YaFZvouo92UBPkFYfzg4HIS5I3oDYHT+Zyh9g87Hldc+3Yb3njEL6Rr7Mjvu6dZ8
	grmkExShMjhCnFNHrc19gVflBMgsnndihCejBP1R0IwEf59k+gQli/IMoLNVoVFA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9xsqb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 19:22:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64IJ9AxG014426;
	Mon, 18 May 2026 19:22:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739vqg4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 19:22:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64IJMmYu44368234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 19:22:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45E9D20040;
	Mon, 18 May 2026 19:22:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E016520049;
	Mon, 18 May 2026 19:22:46 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown [9.111.60.118])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 18 May 2026 19:22:46 +0000 (GMT)
Date: Mon, 18 May 2026 21:22:45 +0200
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
Message-ID: <agtnBewXZw83JhPQ@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260512105920.2426293-1-japo@linux.ibm.com>
 <20260512105920.2426293-5-japo@linux.ibm.com>
 <CANiq72=dD5fw6XmLJ=zSq_k_ZQy8sLLMs3m1xjX=UTpO7tLisw@mail.gmail.com>
 <agst-5rhj2mFF448@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CANiq72m0n4M=Yyb2=Hhrpg3EWk2-a2Q8V0Fc=0Ss50HuBO5hHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72m0n4M=Yyb2=Hhrpg3EWk2-a2Q8V0Fc=0Ss50HuBO5hHw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE4OSBTYWx0ZWRfXy5U3GIPZUqJ2
 m/M4Xh0goXhDVzaJIGWiMTmSNXz0RabMubHI8J9HI9yodsvF2MC0YXJ8A6Y4kwjVM2MsmXx9Y8i
 hQMIlwrb3ZADmI5vNVaS9FH3BqS8kP8UeHKpEg9pEcQDYzhB9v47NcGhnlmJXbuvo8ACELBrEpK
 KOogl15Xz8gKI9ql+DS//9iyauIYOo2SPVnIrFNXhzC2xlKKeVenbi7yv+i1Dvyz3FHLGvYxpqw
 OTPfGr5m4Xl2CLkTh874LDOZMTxOmwYNo/3e/7kLgv2IUVL/jFuyzvZNLfFNB3El+zHg/dTEoh7
 f3c3oWyLus8iDgrvTmvPnVk1nLliBS3plfHaaK/06MWdowbAFbXLFeFNKhrS7/7IS+x5dpdtQfh
 c58Ii9LKFJLXRSkYxyxSNJ+/dW8cJ4rE1sxKOlld3KB0gLXELcrR9X5ctaOI4pbOm4L76Wkx/GD
 +cBRo7zllm5rZFlg/Uw==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0b670e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NEAV23lmAAAA:8
 a=PfD2oos9AAAA:8 a=VnNF1IyMAAAA:8 a=xliUfsdOhJ765NiRnkcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=oXWlT9oWAVMySZ1Hvsws:22
X-Proofpoint-ORIG-GUID: xj3FXAlZTEoR3L_L9vOv1k4pjhvYj0tN
X-Proofpoint-GUID: PfdaP4Tm7Pg_7r3OVe_TGYStZJvRMKZu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180189

On Mon, May 18, 2026 at 07:23:09PM +0200, Miguel Ojeda wrote:
> On Mon, May 18, 2026 at 5:19 PM Jan Polensky <japo@linux.ibm.com> wrote:
> >
> > thanks for the review.
>
> You're welcome!
>
> > -Zpacked-stack: I’m not aware of a dedicated rust-lang/rust tracking
> > issue for this flag. The implementation landed via rust-lang/rust PR
> > 152432, but it doesn’t appear to reference a tracking issue.
>
> Yeah, #152432 is the one I linked in our live list.
>
> Sometimes tracking issues are missing, but I think upstream Rust is
> generally OK adding them -- I have created one, tagged and linked it,
> please feel free to modify it, close it, etc. if needed:
>
>   https://github.com/rust-lang/rust/issues/156724
>
> I hope that helps.
>
> > minimum toolchain version / beta: as long as we pass -Zpacked-stack in
> > KBUILD_RUSTFLAGS, we need a nightly compiler; beta/stable won’t accept -Z
> > flags. In v2 I’ll drop the 1.97.0-nightly guess and set the minimum to
> > 1.96.0-nightly (the first release line that includes -Zpacked-stack).
> > We’ll keep the “-nightly” suffix while this remains a -Z flag. If it gets
> > stabilized and nothing blocks, the earliest stable release that could
> > plausibly carry it would be 1.98.
>
> No, it is meant to work -- we use `-Z` flags (and other unstable
> features) on a regular basis, as you can see in our issue #2 that I
> linked above, e.g. you can see some of them with:
>
>   git grep '\-Z' Makefile
>
> Please see:
>
>   https://rust-for-linux.com/unstable-features
>
> for some more details.
>
> That is why I was suggesting that you test the current beta, because
> it will become soon 1.96. If it doesn't, then it would be wise to try
> to see why it doesn't! :)
>
> Thanks!
>
> Cheers,
> Miguel
Hi Miguel,

Thanks again for creating the tracking issue for -Zpacked-stack and for
all the references, they were very helpful.

Regarding the toolchain: since this works with the Rust-for-Linux
bootstrap mechanism, I tested with rustc 1.96.0-beta.7 (6be5f81e1
2026-05-17) and everything behaves as expected. I’ll update v2
accordingly (min-tool 1.96.0 without the -nightly suffix, and adjust the
wording so it doesn’t imply nightly-only).

Best Regards
Jan
