Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E2242B75A
	for <linux-s390@vger.kernel.org>; Wed, 27 May 2026 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899639; cv=none; b=SLbeXgOisBJ02xHT83RnPUirEEmrMulluBj/lZqLQuSnucJHr4acAM4XTxj26YBXspvfFteaACn2jVG26AT+k/xIEKBeq4+KSIlHWn7RvT+d5Nwtlua7WxzQZ55KsU1NrWOkUSw2EQTlNtCjRqujgsz5i2jbLZf3TPrHE5tzBHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899639; c=relaxed/simple;
	bh=qyQZY8SQQakK1rScQtf2rXlg0CADamrWOX0ENN2fHgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+l4x/42mOKaixAUdC3biRI9X2K61/w42/QQBKecH4VmPsvmvu3+0MZZV5wGgN/LTVkOCkA17pxVH92AT2qwgk/T+qt1GWijFQCdBh3XlCCLX5IH7JNsEgXqMedwBGcA7M/RI9wqwNtENKUvEUQ1jMc4GugACLFrptYXfGy+QRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnunUOG6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnunUOG6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BD81F00A3E;
	Wed, 27 May 2026 16:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779899638;
	bh=ny4zxAIapacb/F0Bfl3M7CTeOVF4rGsMsPQ88ReG9Ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gnunUOG6fcXzOLP+gyxX2W+RYaumI6Smps5PRxsHC67sm+0gZQnuKGPI66/KuriG8
	 1s1vAs0cxCndhN9dQEAosts6oBoSgl2RSJqeZYAuLdaIeL8HNID+u7pz4fVdpIoxpc
	 QJpaQDM/9TMm8JmywXWlfbBXo5I2Po8f0j7O4AE0t8QhofQ2xeSH+fmhUW+BQTrEd3
	 vKFLDDtGnWlECgRjsGIn7Wk9rcdhIgorNgctrmoK276UppPIEYE9JyckJyESV0IsAl
	 S/6GCJyoKowUVpbix8CMQiiMFIGfbzDRC0LIhAF7Uz3xgkB6JP9u0UmCc1aqhaUE7/
	 cardlv3bU/MHg==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 09743F40090;
	Wed, 27 May 2026 12:33:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 27 May 2026 12:33:56 -0400
X-ME-Sender: <xms:8xwXamCgFw0ZKZ736J163z9iGdBrNjJ2tK5qo1axKEnKEAssI9TuTw>
    <xme:8xwXalYYGJlnEsx0a9PUE30o0Rots_F4naiR1uA_WWpgaiTImaYZNK0nFN-qBQtW9
    O7JJgKzltEe6HHwLsYS9QDzq-T5X-GjIoMB5NE7do_11cvm3kJ62oY>
X-ME-Received: <xmr:8xwXavc2EVg5HkOGrxegia3GGXM8LAH45U35zEQhmSTeUmcMxMj9t597zCP4VNrK7wbPCGcl5E78VojbZ4LJ0Et3LlZVY6gO>
X-ME-Proxy-Cause: dmFkZTGz1sE3TSHgPZWvADxdSlCyQIsRYRll5OVk6HOSZ0HDMtjjDQcx22t0e7Zo87zpJF
    5dKOEz5BLUwMW0hAxQ5tH0DSbMfbPaOIIRW+eAQ7hECu37aAdhVkYQhnLU+kTI+/b+jmwa
    W5vF88fmvhFDzhBvj0G8scNp9kzCE6SvBHtqwJNASVh2TLOo7MUhS2e9i/TTyrOOMTNcSY
    /E9Emn93gORsxloK41GWNxuY/sH5AVW9Z03Me/E5GuZEHWGeNqe55C+pIwZbqxfslgvkM1
    UuGq49m9ayY1i4vyQ4tRGADSxB7dc2cl92KGKL7FvNoVJtvP08EsbGAaNZfuW189aHZrDq
    7/9yj0xTG9U7dpW2phMsbnQkSohyyTEWHg3TCrF8eS+biDHCD+kgjVszu+WeKsiDPbXYZS
    tQa9mZin0vTqvxt+l50hN0EfrlSk+v7zgj8Fm2k6Yfwu5HBIvdsp9s6vyDsNWurlIp9N+v
    IqiHnWVpP0e5Vmwt75CrkesefzdFUMV5pJP5iUly6e/b58gQXZ5CzORrBYcCylNmTggyOO
    ELngs5fg/skBFnaB1mBz4jhuLrc8FTucnDdOV2yVGlEWooxWg28Zkd9XDCC2/x9abL6Pi1
    FN5LMnxp+uCTUAyPVdEoNtTs/HmGy1ly0myKYAhkQO4wuTv7k/Qb0O+fhD1g
X-ME-Proxy: <xmx:8xwXanMXB5gx1pQWrfjGVmI8HO_DE6S4HOSTeLDp39g9pzE-WK-CLA>
    <xmx:8xwXahWlTjM1dHOOVngYyTO19pPjvISL8nqnNZi9xidvlF1ofjIoYg>
    <xmx:8xwXao2UAqjRB9nbDSBEgNCC1rpt2o139oqtGiOfupjfRKoEWy73cg>
    <xmx:8xwXas6y6z4zEDAT2YBkcvpKrDgInMuuBgAucBv4MRDKZFGlNISACg>
    <xmx:9BwXate9SRPIOrXWP8cjBpX5VijoO_Qp7xuFBr_fVyprx0UEVUE7psDw>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 12:33:55 -0400 (EDT)
Date: Wed, 27 May 2026 09:33:53 -0700
From: Boqun Feng <boqun@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,	Will Deacon <will@kernel.org>,
 Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,	Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>,	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,	Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>,	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,	Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,	Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>,	Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,	Jinjie Ruan <ruanjinjie@huawei.com>,
 Lyude Paul <lyude@redhat.com>,	Thomas Huth <thuth@redhat.com>,
 Sohil Mehta <sohil.mehta@intel.com>,	"Xin Li (Intel)" <xin@zytor.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,	Yury Norov <ynorov@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: Re: [PATCH v2 00/12] Refcounted interrupt disable and SpinLockIrq
 for rust (Part 1)
Message-ID: <ahcc8Tudh4TJI5UM@tardis.local>
References: <20260526152148.30514-1-boqun@kernel.org>
 <20260527161844.GG3102624@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527161844.GG3102624@noisy.programming.kicks-ass.net>

On Wed, May 27, 2026 at 06:18:44PM +0200, Peter Zijlstra wrote:
> On Tue, May 26, 2026 at 08:21:36AM -0700, Boqun Feng wrote:
> > Hi Peter,
> > 
> > This is a follow-up for Lyude's work [1]. After learning the current
> > preempt_count() usage and how ARM64 handle this, I came up with this
> > series that could resolve your feedback [2]. The basic idea is based on:
> > 
> > 1) preempt_count() previously already masks our NEED_RESCHED bit, so the
> >    effective bits is 31bits
> > 2) with a 64bit preempt count implementation (as in your PREEMPT_LONG
> >    proposal), the effective bits that record "whether we CAN preempt or
> >    not" still fit in 32bit (i.e. an int)
> > 
> > as a result, I don't think we need to change the existing
> > preempt_count() API, but rather keep "32bit vs 64bit" as an
> > implementation detail. This saves us the need to change the printk code
> > for preempt_count().
> 
> > 
> > v1: https://lore.kernel.org/rust-for-linux/20260508042111.24358-1-boqun@kernel.org/
> > 
> > Changes since v1:
> > 
> > * Rename PREEMPT_COUNT_64BIT to HAS_SEPARATE_PREEMPT_RESCHED_BITS per
> >   Mark Rutland.
> 
> Blergh, so I really don't like that new name. It isn't that
> PREEMPT_RESCHED is separate, it really is a 64bit preempt count.
> 
> Shashiko has a few fits, but its mostly being stupid. Although I think
> it might be useful to perhaps put a WARN_ON_ONCE(in_nmi()) in
> local_interrupt_disable().

Yes, that's also what I'm thinking of, and also we need to check
local_softirq_pending() in local_interrupt_enable() I think, because now
HARDIRQ_DISABLE bits being non-zero means deferring softirq. (Shashiko
also reported this as well).

> 
> Anyway, I'll re-read things again tomorrow, but I suppose this will do.
> 

Thank you!

Regards,
Boqun
