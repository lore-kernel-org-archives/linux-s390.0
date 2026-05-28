Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FF12D97A6;
	Thu, 28 May 2026 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977071; cv=none; b=jGSwc7xUcPY2fyD66CfL7GnhJ36fk1fBfWxu54Q+BAg2sZn82wVfJPpv7otywPUmAiRomrLIdgtTWfiyUTzx3aVyj+JSQJbWXDZ12gJcPph57xmGxmwpWjWiIH3/iermNRbADhP8lcz1ItXmvu1HlunOjC4mF27Z+7RsveXiqus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977071; c=relaxed/simple;
	bh=GzEgE7aJn62jUxv5D+sWBVYasoRwbWFk+RpXT+lnbGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LU2x0Ui5l2NXKSnw3Uy0l2rooW3mP+J0Sx81Ajh9/WClCIKLKKNGb5TqBspe5+m2WNUADPHsfpSXbMJgKOrRBIQMOJhCkqOdiSeamSrNaNmDPUr2b7cA54rl2C6pGCV/mRlyo4wE7RCbNCO5Jw9GjxuX7kkK2VzMvhFBG/sA+g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JNXWk1FA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JNXWk1FA"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SCb67B035764;
	Thu, 28 May 2026 14:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xkAk38
	irsJ8vUg9+GGroS/WDtXDtvSLQ57kPQkdfOyw=; b=JNXWk1FA2jpk/hUidSuY7/
	c++lncOHVH3cAipjytvO/GLKdDtk/6sUHteeD6AJaloMOs8Izew5ANrFTlqWgVt7
	sHKBWtlrAZqS6vEEdprnTDLwH9eyY+tMcWv51M2WqPt8iB+0PuF1887J7ZTB4Jj1
	jTfEG9fKLyDgh1cxXaYT/b8G4UxULgSjdQDMBvO9fg/fyTTk3JjoYT9FumwU1FZm
	l3qNzLBrr6mq+/kLhVHIPycIJDU7Z3bBLX4mCZgcri/Bz98EZTa7N5bFCKSCbMq1
	xAl/A/csO7y5j0i2TakrclbIFDl78ZxRV/rKmLKucXDIleSWKw2JXy9kFdaCYyLg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee88bb6am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 14:04:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SDs6F9022600;
	Thu, 28 May 2026 14:04:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrb8d9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 14:04:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SE42uF51970442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 14:04:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2C8720040;
	Thu, 28 May 2026 14:04:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DEC120043;
	Thu, 28 May 2026 14:04:01 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown [9.111.71.22])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 28 May 2026 14:04:01 +0000 (GMT)
Date: Thu, 28 May 2026 16:03:59 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>, Boqun Feng <boqun@kernel.org>
Cc: gor@linux.ibm.com, agordeev@linux.ibm.com, ojeda@kernel.org,
        peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com,
        aliceryhl@google.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] s390: Enable Rust support and add required arch
 glue
Message-ID: <ahhLT-fFx2lUi_FV@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260521165622.279953-1-japo@linux.ibm.com>
 <CANiq72kT7YEuMaM7wkOtCz8ZqEXbPLniA-x4L7E=B+x0zXt_2Q@mail.gmail.com>
 <20260526161312.19291A8f-hca@linux.ibm.com>
 <CANiq72m4GVWFYqnxNtCHTPu7XcGewHB5LNwOoayTfnXs9pPbNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72m4GVWFYqnxNtCHTPu7XcGewHB5LNwOoayTfnXs9pPbNg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEzOCBTYWx0ZWRfX+qilrhiDv5t4
 y6ONZvqjmCDDr/LTX+72FXbPeoN5yCFCViJE8Ry5qBxxg+d3QJ8PhMlfSKunwkWwrWnOOA5eWIt
 TB7Q88kdADyvjD0PxiGi17pYiI0x1MfDaRQ68+yMXZbUygdRJA2xbBnaQEOJnQ9uAa8d5/aA4K1
 ZBw4DHwXS6Rn1W0DiLzZ0Wg4ho6j3Kwrxqd2jVUC7/hIqcvMpbFjde6KkdFYBGKbLxEUFajruyh
 30vbIngBjp7gOX7sh/JGMmmfKYStHdaS2piCVfN8P2Pwa5GT0LtptKT41Syv/fU3OMaCzIGgx53
 c6fIlaVXz+tUkRMYtBROQt4wXjZp3Pg4uos5ZiVFbYLHwUMA9PRlQxYNeIFh+UWCtQYWrlldHAZ
 XmrUbnLwL/cMguKpGthXsb/K98VpE/mC9U/2dade8pgtx4Ybt2g0+WyjetHb9t/A/S3tsWpDkV3
 0loSJtdGw2ksotUJeBA==
X-Proofpoint-ORIG-GUID: VpA2yPYcvm_OwT0cPXdAYMgS3TqJMmZr
X-Authority-Analysis: v=2.4 cv=IJEyzAvG c=1 sm=1 tr=0 ts=6a184b57 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=_ZthinDZHpcC7BOMtskA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: iRkmDbNMCFvXkTGN_ZMNaxCGJYdwpN9W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280138

On Wed, May 27, 2026 at 12:08:38PM +0200, Miguel Ojeda wrote:
> On Tue, May 26, 2026 at 6:13 PM Heiko Carstens <hca@linux.ibm.com> wrote:
> >
> > An Ack from you would be appreciated, even though you made it already
> > clear that this series looks ok.
>
[snip]
> similarly named function `memcmp` defined here
>         |
>
> So we likely want a Rust helper here in `rust/helpers/`.
>
> Up to you which configs you want to support initially and how clean
> you want everything to be, of course, so:
>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
>
> I hope this helps!
>
> Cheers,
> Miguel
Hi Miguel,

thanks a lot for testing and for the Ack.

The backchain warning is known. The KASAN report around the 1/2-byte
xchg emulation and the missing memchr in some configurations look like
separate follow-up patches rather than issues in this series, and I
plan to address them separately.

Best regards,
Jan
