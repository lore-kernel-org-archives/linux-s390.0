Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAA62F7EE8;
	Fri,  5 Jun 2026 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780656735; cv=none; b=tVySdoStfo+r/P0BjyzgWulJrL8EjaNW+Lb/9dPxKxRnnX1VNcHSt29zj33egMymbssnqxPdxgp4zU1F3Y5WXyWnZOTVzd3HxRXUmbzdA/Od8/GGxB5UIeyPA+2fEsg3uW5iewwKBVD+ha/qD7cqKBLd4ydap4Bf1+2dzXqfyrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780656735; c=relaxed/simple;
	bh=Kp88CfWJhKI320XGbyQ0RpILkFzMNto9LCY1T4+1sDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4J/JXRAFnB8TvVMWs1yw9b5UAkOae+mUfjNPQUGXhr2m6ejoXOz0wIMZDyK+TiPNsH+NJNVVZblYxRg9VSINORtYKMJynPluoh6xkANcLk3CK5FdqDHKTkYL+pUov9piSSUxfTXWxl9eyefCJGUh+LkZ17PzOSm95xXpasymSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TWsw68I2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gkepEn1z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TWsw68I2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gkepEn1z"
Date: Fri, 5 Jun 2026 12:52:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780656732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbTEHibifwAS/Cw0ufnS3oYrVQV2+Oq2MfEqzhSRPHs=;
	b=TWsw68I2oPzchuEQp8x5s2s4lpXAIohG51NlKcuRSouDpKUF/CT9fd8zT2ppxqmyd6g8Ri
	4xpkPp68KEpS6PW2GLqNXPTqWTbyOPDoDLqWMu5j1908oXGehlpGUfOdZBEF41wv/tPOru
	+7gCsv2Avip1SR7kq1E1v1fnH65cNSjRxXAXIAPbXj5WZhm4STZAI8SZvV933v/24nN42x
	oiXnu+BU75EOIjXKQAxIVVUPuByYmGnBlM2wEdmQ6/ljqB+PUffHtdwdnLqSc77n3KOqDr
	Sg07bC74QZC68XtPHIugriBDwGszu3zF8Xrk6Sd0RU6Kl5Kn87rl/Okai9HlXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780656732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbTEHibifwAS/Cw0ufnS3oYrVQV2+Oq2MfEqzhSRPHs=;
	b=gkepEn1zqv58JRpoV6Mu6UFgN7N4CN1hUYlBRLY+55/yoENhueYAkjwdTF1UMjtwALBJ0S
	woRr3aCdakCliaCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ciunas Bennett <ciunas@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Douglas Freimuth <freimuth@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>, mingo@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, clrkwllms@kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-s390@vger.kernel.org, Matthew Rosato <mjrosato@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Marco Crivellari <marco.crivellari@suse.com>
Subject: Re: [PATCH] sched: Further restrict the preemption modes
Message-ID: <20260605105211.rZ8x7Hd5@linutronix.de>
References: <20251219101502.GB1132199@noisy.programming.kicks-ass.net>
 <182f110b-ac63-4db4-8b01-0e841639bc39@linux.ibm.com>
 <a7180379-04f5-4f61-b60a-0ff7cf85134d@linux.ibm.com>
 <ec3987e3-4eb7-4d07-be9e-bd8dc9ad176f@linux.ibm.com>
 <08307223-88ad-4550-963e-5d1ee315023c@linux.ibm.com>
 <a3bbf315-536f-429e-afb2-adcbf508a66f@linux.ibm.com>
 <20260303115235.GQ1282955@noisy.programming.kicks-ass.net>
 <6c3fbb6d-d4e1-4984-b584-c067be844098@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6c3fbb6d-d4e1-4984-b584-c067be844098@linux.ibm.com>

On 2026-06-05 11:43:24 [+0100], Ciunas Bennett wrote:
=E2=80=A6
> Quick refresh:
> Workload: uperf sending TCP data between two VMs (client and server), eac=
h configured with a single vhost queue (min vhost ques for testing)
> Issue: With lazy preemption as the default preemption mode where previous=
ly it was full preemption, there is a significant drop in performance for t=
his workload
>=20
> Simplification of the issue
> We have two tasks:
>=20
> TaskA produces data
> TaskB consumes the data produced by TaskA
>=20
> Notification path: TaskA informs TaskB that new data is available by
> adding a new item to a workqueue. This triggers a kworker which runs
> and notifies TaskB.
>=20
> Issue
> TaskA is configured to use schedule_work(). Internally, schedule_work() u=
ses system_percpu_wq, which is configured as:
> <WQ_PERCPU =3D 1 << 8, /* bound to a specific cpu */>
>=20
> This means the workqueue item will be woken up and executed on the same C=
PU that queued the work.
> If the task that queues the work (TaskA) is a long-running task with
> limited opportunities to call schedule(), then the kworker may be
> delayed significantly before it gets CPU time.

There is some work done by Marco to rework the API to explicitly state
if a per-CPU workqueue is mandatory _or_ if an CPU unbound workqueue can
be used instead. (Rather than having schedule_work() not knowing the
implications).

> In our scenario:
>=20
> TaskA continuously produces data
> There is no dependency requiring TaskA to yield due to TaskB
> As a result, TaskA can occupy the CPU for an entire tick before being pre=
empted by the kworker
>=20
> Observed behavior
> This is exactly what we observe in practice:
>=20
> TaskB corresponds to the VM consuming data generated by our vhost task
> When running uperf, this behavior leads to a significant drop in throughp=
ut (Gb/s)
> The VM is unable to consume data in a timely manner
> When it is finally notified of new data, the delayed signaling introduces=
 jitter
> This causes TCP issues, including retransmissions and out-of-order packets
>=20
> Results:
>   |--------------+-----+------------------+------------------------|
>   | preempt mode | Gbs | workqueue pool   | kworker latency avg ms |
>   |--------------+-----+------------------+------------------------|
>   | full         | ~50 | system_percpu_wq |                  0.002 |
>   | lazy         | ~13 | system_percpu_wq |                  0.721 |
>   | lazy         | ~50 | system_dfl_wq    |                  0.005 |
>   |--------------+-----+------------------+------------------------|
>=20
> So I did some more testing and if I use a different workqueue pool the sy=
stem_dfl_wq the TP was good again, as you can see in the results table.
> Since the kworker is not CPU-bound, the scheduler has flexibility to sele=
ct a more suitable CPU for execution.
>=20
>  /* system_dfl_wq is unbound workqueue.  Workers are not bound to
>   * any specific CPU, not concurrency managed, and all queued works are
>   * executed immediately as long as max_active limit is not reached and
>   * resources are available. */
>=20
> Given this understanding, what would be the best approach here? Should
> we consider changing the workqueue usage in the KVM code, or do you
> see an alternative way to address this issue?

It seems that using an unbound worker would avoid the problem at hand,
correct?

Sebastian
