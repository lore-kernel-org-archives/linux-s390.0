Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C1D334C08;
	Tue, 16 Jun 2026 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781618737; cv=none; b=A3/PPl/PcCQ5uTPR90ErxbaWGk1Dgbk2t4tPyHLzkj3MrmAOtq3acSksVLaSXw4oFRogmQ/pF6ot4EmXneqdJvAftraZbimRZZFkIsGHBKS4Ag7N/DHgFaMEDDKkziU+W13WsUqn3tJuwtcu75nwSnxG8XNdyBOCN0KDwQaTeTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781618737; c=relaxed/simple;
	bh=4MsMctDxP0V0N7hmdGew2Nrx9oRhea5cdVp7e1+E9cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLRnSBl2dW989ZXsDCD6RM+wDSOgLIkY8wmEqYrvOz3xbV3r+lsdwH+HtRx8cKASySeFzMs4ygUcVTNOWGYczUcfMnCD1O+gSGYGeYsmo/rvmsRZuAsZutLmwx6lC/RLcwYvtkUnIr6GPqtM4iEzCuWPpMzL5DvswQbo/LckEC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B2ho91op; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B2ho91op"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAIo0w1135652;
	Tue, 16 Jun 2026 14:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4MsMct
	DxP0V0N7hmdGew2Nrx9oRhea5cdVp7e1+E9cs=; b=B2ho91op7o6Up69Z9Gd4MO
	/UYN0Zv3PAp7v709F4xxjwMDAUoJSblJEXCGDSQMepe7eygHBjTWnkJ9HwqYIXFi
	PGNajIekRsEISVRtGmNuqfynXe1jbxmpJDjTRHk+VGwiYwoBtEPbfFO3UNXDrRhf
	sS83uJ7odtPGFl2dRfjIPqJe7Brsmfbzwk66fy76gZcKBDJomjkGDcBxCurjuNU0
	pl1jgX5LAAfvPowTF4fAIpvDclrxGyYDnUXJZdPVoK+b0pMp1EeMsCdDbiapMrWK
	/h/ITS11L8I7bhWoqRhv8GBnXX2rfQFaD577mzbCHDy+NC1Mm5g/Yg/K6eCMhSUQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1u0nhvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 14:05:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GE50xs025961;
	Tue, 16 Jun 2026 14:05:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshww3sav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 14:05:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GE5Is250397620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 14:05:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E583020043;
	Tue, 16 Jun 2026 14:05:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A488020040;
	Tue, 16 Jun 2026 14:05:17 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown [9.224.74.129])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 16 Jun 2026 14:05:17 +0000 (GMT)
Date: Tue, 16 Jun 2026 16:05:16 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, ojeda@kernel.org,
        peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/6] s390: Enable Rust support
Message-ID: <ajFYHCZSXC05P7O0@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260608181451.3734956-1-japo@linux.ibm.com>
 <20260608181451.3734956-7-japo@linux.ibm.com>
 <20260615164013.GA249489@ax162>
 <CANiq72nkm2YwxcV+vwDj+v0svd6e1dro-W_0ybVms3pG_oJiXg@mail.gmail.com>
 <ajD9uw7MhsisxdzY@google.com>
 <CANiq72=Dv8wUrMz7jbsHOwAyd2GtgnRxvXzZeER91KvPcULzhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=Dv8wUrMz7jbsHOwAyd2GtgnRxvXzZeER91KvPcULzhQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: roaAaCbviLUo46EhF4sroLpK4_YfE7XH
X-Authority-Analysis: v=2.4 cv=XdK5Co55 c=1 sm=1 tr=0 ts=6a315823 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=NEAV23lmAAAA:8
 a=1XWaLZrsAAAA:8 a=Cn6JykAFl85rGkSfe7cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE0MCBTYWx0ZWRfX8TuAvxgSbzhf
 Cf6mJgf+L/QXkWDnkGr5qPlNJstpNdvCDZblkr7yg+wcROlDIawcnHCY/CG8F5AmumZA2K9sOvt
 pDAG01Hc63a/xk+6g53bzTbTqycGSIe7/Xhr84YP47pAnzt99U+AvCuOxrMJk+rmDuazZ+yylPH
 arggkY0JtM8FCHCChleZMZkg/8x/95qHdH6SvEptAq6hY6b9HuciMkRzyj0cXSfoiQYz6A2TvQ7
 YQM0UurUUrA3FIlXieTjs8heV0YgnZH4qdUGc5N7KmpapoTHqxI6hGxzbIqIf4PPWvdZHnlojBg
 A0LXNgJ5iGpIVwZtBtMCQ5kSxy9hJ72ilyWr5v8CEygh0fnxjE9yS+QQq+V2jzyNrK57olTaAk4
 CMpr/fgqz4AGsSUJQkoHFvydmt3ZBpSRBQvo+P6tw9yXP99bQ0sTJHmz6uRjyPt1zRGo3fg8cKG
 qdAFKPnrzJkWob39NNA==
X-Proofpoint-ORIG-GUID: Bs6b7hlwft8w_O3OtMXyoNzhkye6Kmd6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE0MCBTYWx0ZWRfX+TbQJK5sAcuj
 zb023AmXf4H1xKe6AWFLDMFRDoYxzlMAYAQTHxSQjrzO8/KLo7GvXV/G/w1peMdytUwppLqJH5P
 rMsgmdTr9KZZhCTNN+3NY9+vaK9Xpos=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160140

On Tue, Jun 16, 2026 at 10:45:10AM +0200, Miguel Ojeda wrote:
> On Tue, Jun 16, 2026 at 9:39 AM Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > Since fixing this requires a change in rustc to recognize the backchain
> > target feature, has this work been started? I think that for stuff like
> > this, we should make to at least start working on fixing the warning so
> > that we don't emit a warning forever.
>
> That is the expectation, yeah.
>
> Jan et al.: for powerpc I have been accumulating the links etc. in
> https://github.com/Rust-for-Linux/linux/issues/105 -- do you have
> similar links to the ongoing work for s390 so that I can fill the
> equivalent https://github.com/Rust-for-Linux/linux/issues/106?
>
> Thanks!
>
> Cheers,
> Miguel

Hi Miguel,

thanks for raising this. We discussed the backchain warning today with
the s390 compiler folks, and the plan is to move the backchain target
feature into stable so we can support the kernel use case without
carrying warnings indefinitely.

There is nothing public to point to just yet (no issue or tracking link
yet), but the work is now owned on the IBM/s390 side. Eduard Stefens will
take care of driving this forward from there.

So while we do not have a link to add today, the stabilization work is
expected to happen.

Thanks,
Jan
