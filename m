Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81323F7882;
	Thu, 28 May 2026 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981596; cv=none; b=mhgUkynqkcjJm2Z6XKwZcIMZsWE+b+bg/H1Yb3PcnyLGZ08mhSepCMzr+1sBrHTgP0+NGm8wCWkU1BpWo4ovG9xsX/k5FuS21JgGU6HxaBuJOe5yaEQmFhaFS/WOZ0zdBUT3kZRMNIFuE2+PHeQdEVZ24tJP1yZFl+6stSx7egU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981596; c=relaxed/simple;
	bh=Cju7GfJQO1f+eQIAu4wlLwOh7kTjaS5mSuAjHrSW1A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYv/uiC9bWRRbUGKKeneA8DD+fBm+7iaeA9OdrKD6OEYI1s2Voi6ZPLYpi+lmIEWicW882IVbL3LHdp+KbdDqtsWscBPZly00iF5fTBwc75BBBQAWidZzvW8w+izjvkrJUDEMSgnq9eycayQD+Y275M2GMx/uBVp+VyLk2npufo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JbPsiZog; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JbPsiZog"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SCJPhC3784701;
	Thu, 28 May 2026 15:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CuqlQf
	EgD7iXXrynPvbGdJECJBOurjPHem+jryYWm9k=; b=JbPsiZogaBnBc28flZwRcY
	KJgRrmZhPERODhh7i+IIpDOK0+BrhGC5I/hiKEr3DZL7r5U6G2M97kIwen9Muxpr
	yM8GRr3vlZCFLqWzRtVjkiVJ8YDfyEPSRDP3bNknbqNmJQnKUxw0FjVcbAlg2+OZ
	kUSoV/mrIhsiZWp+6Gjjc+AfuYSaI0Pu2sWTem4lDNHnQaEAtrgEND63tcFSp/ib
	VGtgB9tLMfOBvaDQ0fKje5ksVtAX1GN3EDqjbiyL8+y3ABqPW+mfnM9Zd3dd1YlD
	0pvhb9E+NKA8ounbc5rpf98otCWRSRJvZ01UAekNihbUU6Jr7nrVT4inyga4cYGw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee889bhph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 15:18:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SEsAWn025348;
	Thu, 28 May 2026 15:18:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrb8pre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 15:18:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SFINCj61342002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 15:18:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C1D820043;
	Thu, 28 May 2026 15:18:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C381620040;
	Thu, 28 May 2026 15:18:19 +0000 (GMT)
Received: from osiris (unknown [9.111.53.179])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 28 May 2026 15:18:19 +0000 (GMT)
Date: Thu, 28 May 2026 17:18:18 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Boqun Feng <boqun@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>,
        Jinjie Ruan <ruanjinjie@huawei.com>, Lyude Paul <lyude@redhat.com>,
        Thomas Huth <thuth@redhat.com>, Sohil Mehta <sohil.mehta@intel.com>,
        "Xin Li (Intel)" <xin@zytor.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, Yury Norov <ynorov@nvidia.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        rust-for-linux@vger.kernel.org,
        Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
        Daniel Almeida <daniel.almeida@collabora.com>
Subject: Re: [PATCH v2 12/12] s390/preempt: Enable
 HAS_SEPARATE_PREEMPT_RESCHED_BITS
Message-ID: <20260528151818.15387E85-hca@linux.ibm.com>
References: <20260526152148.30514-1-boqun@kernel.org>
 <20260526152148.30514-13-boqun@kernel.org>
 <20260528105325.GI343181@noisy.programming.kicks-ass.net>
 <ahhUFPdzboMWbXjn@tardis.local>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahhUFPdzboMWbXjn@tardis.local>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: C4AjXlVXzp9FM5vEbjPoE1iPygIKAMIH
X-Proofpoint-GUID: LDSTk6Bc2eAgCG66BOzIe49MCNr_aeil
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a185cc4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=BQv42HuiQXlAielMBlgA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE1MyBTYWx0ZWRfXwKCHgy9dP6n0
 h7UNt2b7cfzAkKoNumPXe8ri3EkDoBGMTOc19rw8h4nddZm7LRtQI4EZ1guFFBK/GWY4e64G/kt
 8F+zIJaqvg8pFBHzfUKzO7ShA3e2kaI3ocYlVQYzdNrftBNBNjg4FebBTLqt62XYb6ooZRgOYvj
 szPfd1IF9l8v/gP6J/1GT0Uod2Z+xe+OnfRS9m5mEeYqTaN/8BZkRvxMnUcW1Um0Vwd2R2fp1ga
 7HOhqAB0XYc/hstqRyH9dwvpA//mpCz725R+yNrPB4ej48miTPOz8yrTZdYbCJD0Uf+znO4tALO
 31JjUJnVTW2fn7vjP7XTLqfTuA24iaT1SoDqOxcylV3oEhGmYODtYK59ZNQwedO+j1KmUZbZLQj
 XAoJLo7CquKoC4q5jO+JfPwvJzWZJrqKF5Wg+jyjt6rHQWsDfBawGcqMqyKr93WWKmgQjw4owhO
 MpTWsjnNjOD7da1AUPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280153

On Thu, May 28, 2026 at 07:41:24AM -0700, Boqun Feng wrote:
> On Thu, May 28, 2026 at 12:53:25PM +0200, Peter Zijlstra wrote:
> > On Tue, May 26, 2026 at 08:21:48AM -0700, Boqun Feng wrote:
> > > From: Heiko Carstens <hca@linux.ibm.com>
> > > diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
> > > index 50ffe75adeb4..0974ab278169 100644
> > > --- a/arch/s390/include/asm/lowcore.h
> > > +++ b/arch/s390/include/asm/lowcore.h
> > > @@ -160,10 +160,15 @@ struct lowcore {
> > >  	/* SMP info area */
> > >  	__u32	cpu_nr;				/* 0x03a0 */
> > >  	__u32	softirq_pending;		/* 0x03a4 */
> > > -	__s32	preempt_count;			/* 0x03a8 */
> > > -	__u32	spinlock_lockval;		/* 0x03ac */
> > > -	__u32	spinlock_index;			/* 0x03b0 */
> > > -	__u8	pad_0x03b4[0x03b8-0x03b4];	/* 0x03b4 */
> > > +	union {
Ä> > > +		struct {
> > > +			__u32	need_resched;	/* 0x03a8 */
> > > +			__u32	count;		/* 0x03ac */
> > > +		} preempt;
> > > +		__u64	preempt_count;		/* 0x03a8 */
> > > +	};
> > 
> > I'm a little confused by this union; afaict it isn't actually used.
> 
> (TIL: s390 is big endian)
> 
> In preempt_count() the union is used for reading the lower 32bits in an
> asm block.

Yes, it is used there to read only the lower 32 bits (count) in order
to avoid masking out the higher 32 bits, which would be required with
a 64 bit load.
