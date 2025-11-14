Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164332E1C57;
	Fri, 14 Nov 2025 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763149361; cv=none; b=XGzyPhppM27qgOavsfSP5L98ouplb3nTpbeBfmG6xciXYcdMlqhNPBLLfcEVUqqm6+9pahhnu6LenRMMV8TKiB1ZY1jyt4KTGy8xoSOMK/YcTlQdfCiAXDah86GIeOjIAdcczkYwroAq3EUA9kJsFTfKhFAvdeC16Urs/vCVXXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763149361; c=relaxed/simple;
	bh=m3IHvVsPgDGgh4gxhht7IySilnSlK/VxUegrc5zLH3s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hii6kclI34o0PtnSj+uzt9EO77qWInDhCa2blzy+of+IXOogVs773VM+J64zh8PHhfG+IKsjz/4NJqSMhTyruG1MYDZfBQ+D50lNUEo/vPvfZZNsw7vZRVJ5wUHJmb/heQ8frbLN0FBJOL4QsxTw6NcTB/7fo7dvgqFsyHDMBmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tmPyGoi7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qKiOV8Nu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tmPyGoi7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qKiOV8Nu"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763149358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m3IHvVsPgDGgh4gxhht7IySilnSlK/VxUegrc5zLH3s=;
	b=tmPyGoi7m3AvXW/CX/zMIO65G7PyvJBKlfJsuix9wfjHJzRrlPqkABvOvY/bnCHnFo25uZ
	bTshnIsTcLeD762ltXy4fPtS9qdVymcUCVK5rnhpml6p7kTZIyWUea+nnu7etMEn4pmT81
	pSRtqWXhJ5DBoRpqzkIWW1J5kGdVedX3ZdHA5ql6iyUZKVWPVqr5OjW9tkfrVcZU9L4uLa
	zyZ+0aaDclAIzRfBjodzfRR12J/YeUpdD+u3b3ntB+1xhMBaJVgUYVIHIMT0jvyPpIteWG
	JppPfjJyfhN6nruv3z7JJCQI3f05RAdUgdw1S6qmKgbsYTtMC2Ti7y6nkdeptA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763149358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m3IHvVsPgDGgh4gxhht7IySilnSlK/VxUegrc5zLH3s=;
	b=qKiOV8Nu3bAHinKQUQaPR+3NsLwHyKY+LCxDv7LI8tochAdFWOuv24biMTpHainD+blGhr
	EdHuyMKEyEMqSJAQ==
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
 linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, will@kernel.org,
 kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/3] Make enter_lazy_tlb inline on x86
In-Reply-To: <20251113105227.57650-2-qq570070308@gmail.com>
References: <20251113105227.57650-1-qq570070308@gmail.com>
 <20251113105227.57650-2-qq570070308@gmail.com>
Date: Fri, 14 Nov 2025 20:42:35 +0100
Message-ID: <878qg8bduc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 13 2025 at 18:52, Xie Yuanbin wrote:

Please use the documented way to denote functions in subject and change
log:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#function-references-in-changelogs

Also you make this __always_inline and not inline.

