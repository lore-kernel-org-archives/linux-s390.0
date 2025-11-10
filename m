Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0161A23504B;
	Mon, 10 Nov 2025 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762817007; cv=none; b=StPhlC9hfDxzl/hPY1tmbrC4vutt4+Fe26zT+G8BqMUgedTg/vjmq1DmbDMC332JWg+grXERbliYRfZrZMy6BDAa9gGy0X8LcYFdB81yHxG28zMweBqv+g/0PuGz4OlTAVXWEp7/OSjs6CkS7Wt7ImeWX7ZQe5bUvvv/wtvcnjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762817007; c=relaxed/simple;
	bh=lgcoh9p9TCLcPD8PGPy9BtJzRmki9rWnfrJ00klkhMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENIn/QWUSGNfCGx7phI1cNiRHanqJ5Yxjz6QNK/T6ntkwU7Q62ZnEis4MzXXfswoHkcN62IyifiGH4aXCiKqqwnnn+omgLxVSh65J1zwTMdOND2qBVUG8W43I23oe6nxXuivQ/LG+aWvpPIXdKcIfb/W94fT3S2HUDAAsvz/a2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=rjYuoLzl; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="rjYuoLzl"
Received: from [IPV6:2601:646:8081:9484:a4ce:2dbc:ef8e:acc2] ([IPv6:2601:646:8081:9484:a4ce:2dbc:ef8e:acc2])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5AANLvc93880957
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 10 Nov 2025 15:21:58 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5AANLvc93880957
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1762816923;
	bh=BsN8VBFD5PAgYi4bwE42pnqSTmd+qcr29mOqQybepiA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rjYuoLzlgViwlHxmQg2QGfpz9LPJDhOQAbw4/6aIGNHbpNN57PZ51RsVPdOwQA6yB
	 2eNjlZzKfZya7G4KhhWgguyHM00AgCEGTcGmu22T0V87nzs1CGXLylHaQ1B7bKomCf
	 4yz/0LhiJbU3IVmkAeDaty+clqMjGVgwRilI7qypUsrfnmUZvKS2i/+F35IPLAcw7f
	 BuHueJostF0V0GWeV+jp1PoPSmefFxcdjXd9xrdrNwYM/y51ZIXY3w9UdXd+X2Dg8x
	 SQzYlmvO8N1yVdVU38QI6EboQsWVZ7uNLIiYngGzemAcHknbmnXkOfw56rFOGv28uz
	 uQr7m3HHG+8FA==
Message-ID: <128b82ff-d304-41d6-b914-a44706d8781f@zytor.com>
Date: Mon, 10 Nov 2025 15:21:52 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] Provide the always inline version of some
 functions
To: Peter Zijlstra <peterz@infradead.org>
Cc: Xie Yuanbin <qq570070308@gmail.com>, david@redhat.com, tglx@linutronix.de,
        segher@kernel.crashing.org, riel@surriel.com, linux@armlinux.org.uk,
        mathieu.desnoyers@efficios.com, paulmck@kernel.org, pjw@kernel.org,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net,
        andreas@gaisler.com, luto@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, acme@kernel.org, namhyung@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        james.clark@linaro.org, anna-maria@linutronix.de, frederic@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, nathan@kernel.org,
        nick.desaulniers+lkml@gmail.com, morbo@google.com,
        justinstitt@google.com, thuth@redhat.com, brauner@kernel.org,
        arnd@arndb.de, jlayton@kernel.org, aalbersh@redhat.com,
        akpm@linux-foundation.org, david@kernel.org,
        lorenzo.stoakes@oracle.com, max.kellermann@ionos.com,
        ryan.roberts@arm.com, nysal@linux.ibm.com, urezki@gmail.com,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-perf-users@vger.kernel.org, llvm@lists.linux.dev,
        will@kernel.org
References: <20251108172346.263590-1-qq570070308@gmail.com>
 <20251108172346.263590-4-qq570070308@gmail.com>
 <04CA2D22-4DE2-4DE1-A2BC-AACE666F5F93@zytor.com>
 <20251109115152.GD2545891@noisy.programming.kicks-ass.net>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20251109115152.GD2545891@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-11-09 03:51, Peter Zijlstra wrote:
> On Sat, Nov 08, 2025 at 02:14:44PM -0800, H. Peter Anvin wrote:
> 
>>> +static struct rq *finish_task_switch(struct task_struct *prev)
>>> +{
>>> +	return finish_task_switch_ainline(prev);
>>> +}
>>> +
>>> /**
>>>  * schedule_tail - first thing a freshly forked thread must call.
>>>  * @prev: the thread we just switched away from.
>>
>> There is, in fact: you have to have an always_inline version, and wrap it in a noinline version.
> 
> Yes, but all of this is particularly retarded, there are exactly _2_
> callers of this function. Keeping an out-of-line copy for one while
> inlineing the other makes 0 sense.
> 
> Also, the amount of crap he needs to mark __always_inline doesn't make
> much sense to me, is he building with -Os or something?

That's another issue -- unless the second instance of the function is on a
slow path which wants to be isolated from the rest of its function (unlikely.)

I was merely commenting on the claim that there is no way to control inlining
on a call site basis - there is.

	-hpa

