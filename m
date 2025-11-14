Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BBD2773F4;
	Fri, 14 Nov 2025 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763149458; cv=none; b=XhMmMeyZBgjEdI96ZNav3qjjbqIlBPZBHDTF6/vLnbqYveBuzdyGNyoNvklcTI3Ub4cxccQKLcO+vTdbeQfO9BkjKE5LsrR1kOB775zI08zl0rcpDKz9tqAJ1On1G5SeEUa9nopcYVRs7KujtfpPzouB5UVbcMiXscGdUkPkfhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763149458; c=relaxed/simple;
	bh=X3YYGc4b5Pr9c4KoZvbwK3VLYSBe3af5xbvfb36+JCI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eUx9NtB1X25rTUj7r+hz9GHMWTrJQy/dVIcWYWcTvkcRXT86WvlB/0gz4D1x5ap4OZDtiFA3qWg2O1fCAzye0l08U48L1IoQN/ZyD75mg1hTr0PdkELbWP+xpqBioCmEqIrobLrXZrEzt9ffTkMI4Uh67QRBf05U8M0JEChY/JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LexRWbmL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=40zAVFBm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LexRWbmL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="40zAVFBm"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763149455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X3YYGc4b5Pr9c4KoZvbwK3VLYSBe3af5xbvfb36+JCI=;
	b=LexRWbmLGZy53r6pTcHou9ffaCf/nQBlEuUud81fffTY1piVuJlKS99+J4BVcxB2h84jVA
	JsDVd16BrBOgFBCT0hiKaD7d1DxSchV3AhjHg6spJ+D8Gu1klglzmpMaCgeLWDvOCTsERG
	TahicHhYFn5juSANT1fOG4/BZZs5E3i6st/AMlK6rq5Pm1MD7bn2QLirPCQ7mVfpyvBxWQ
	y7N47YdVd0cXYHN6TOzrpQYHtzJQEMqS9a5FiIqS7VRv11cqcF4oP2jHm0V9jlhe0nHqdy
	77RvM4vBdYBuThkDLcQ8hKvNll7l50VNArnuoyW+n4X3SrmRWt78tbrbjEWkJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763149455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X3YYGc4b5Pr9c4KoZvbwK3VLYSBe3af5xbvfb36+JCI=;
	b=40zAVFBmoQ9ytl+qD4DXmOWJ1OqpyrNSsoOVU2TYC6tHo4z2zi5Tm3fE+RnPtd7F0VaBLs
	VPpdI75gggZjAvAg==
To: Xie Yuanbin <qq570070308@gmail.com>, riel@surriel.com,
 segher@kernel.crashing.org, david@redhat.com, peterz@infradead.org,
 hpa@zytor.com, osalvador@suse.de, linux@armlinux.org.uk,
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
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 qq570070308@gmail.com, thuth@redhat.com, brauner@kernel.org,
 arnd@arndb.de, sforshee@kernel.org, mhiramat@kernel.org,
 andrii@kernel.org, oleg@redhat.com, jlayton@kernel.org,
 aalbersh@redhat.com, akpm@linux-foundation.org, david@kernel.org,
 lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com,
 max.kellermann@ionos.com, ryan.roberts@arm.com, nysal@linux.ibm.com,
 urezki@gmail.com
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, will@kernel.org
Subject: Re: [PATCH v3 2/3] Make raw_spin_rq_unlock inline
In-Reply-To: <20251113105227.57650-3-qq570070308@gmail.com>
References: <20251113105227.57650-1-qq570070308@gmail.com>
 <20251113105227.57650-3-qq570070308@gmail.com>
Date: Fri, 14 Nov 2025 20:44:13 +0100
Message-ID: <875xbcbdrm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 13 2025 at 18:52, Xie Yuanbin wrote:

> This function is short, and is called in some critical hot code paths,
> such as finish_lock_switch.
>
> Make it inline to optimize performance.

> +static inline void raw_spin_rq_unlock(struct rq *rq)

That inline does not guarantee that the compiler actually inlines
it. clang is obnoxiously bad at that.
