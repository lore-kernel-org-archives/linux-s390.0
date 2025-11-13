Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F17434AB09;
	Thu, 13 Nov 2025 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035896; cv=none; b=NWePfr9j2EhEtsne3/iue59KaJZfnkZzV5LmdteBv8f1ckRanpJ6Tg5/bqerd6M9+0hKMNt7f3bE0ZIOGNLh3TYeo7rCBpQxhvY85kqQmloHfqgGLnK5H5oM7SKB9OxUz5U3urpRVf8Tj2Jb/NRcvKRDGc8OhDCaDb/C1MdGrro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035896; c=relaxed/simple;
	bh=Re1je7zQc+x3bKvtwuM4wZn4KGHoRXGn+zQBODkxr50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tIIDN5D8Qgc79V0Tkjbx09NdXA91N0paJTVTyVGwiGb87gto/s5RPluEhuObkG/t/wtn17NcC1xrW0Rt2yzLwZRwKt2EkrY6mbHTF829pOTs+ZeutgELEbXU1rRagrHZ9P8QFNEc0ItuXqA50GSYjMUMqG6GZGLid90l+icqZ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hv9b7xs+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hv9b7xs+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71383C116D0;
	Thu, 13 Nov 2025 12:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763035896;
	bh=Re1je7zQc+x3bKvtwuM4wZn4KGHoRXGn+zQBODkxr50=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hv9b7xs+9rTAxcmcEMkcl99qjgmEvtnz2aJ3Saur/UfhHxxrkaBy2g8C300bh8nru
	 eQfDbA9ZEeOHpSdfF01cV/KZCH8JdeuFkvXDaRvDaT6Eo8X4yKsuMf+1wHdypIhfzn
	 XXOHkGaU70hqlYrL4zixPenh7EnlGHuE8M+TrPHJ9xI61zc6KNX3G6u+ILDB9tfyY/
	 bcyicslf9h/3vfr24u01+x4XoYfoCArW2OHycxLZYcPVtHzzMtxIskvnkASLKnY/bQ
	 czf8HF7tr144ZO+8k1Elc0hVLdFwJpist64JRgnwZmnKhPThRE66/0JkXsemQ5CcFt
	 Raa7YHyDBrT0A==
Message-ID: <ef9b57ee-5ea4-4ce9-ab9d-02502c410630@kernel.org>
Date: Thu, 13 Nov 2025 13:11:18 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] Make enter_lazy_tlb inline on x86
To: Xie Yuanbin <qq570070308@gmail.com>, tglx@linutronix.de,
 riel@surriel.com, segher@kernel.crashing.org, peterz@infradead.org,
 hpa@zytor.com, osalvador@suse.de, linux@armlinux.org.uk,
 mathieu.desnoyers@efficios.com, paulmck@kernel.org, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, davem@davemloft.net, andreas@gaisler.com,
 luto@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
 anna-maria@linutronix.de, frederic@kernel.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 thuth@redhat.com, brauner@kernel.org, arnd@arndb.de, sforshee@kernel.org,
 mhiramat@kernel.org, andrii@kernel.org, oleg@redhat.com, jlayton@kernel.org,
 aalbersh@redhat.com, akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 baolin.wang@linux.alibaba.com, max.kellermann@ionos.com,
 ryan.roberts@arm.com, nysal@linux.ibm.com, urezki@gmail.com
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, will@kernel.org,
 kernel test robot <lkp@intel.com>
References: <20251113105227.57650-1-qq570070308@gmail.com>
 <20251113105227.57650-2-qq570070308@gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251113105227.57650-2-qq570070308@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.11.25 11:52, Xie Yuanbin wrote:
> This function is very short, and is called in the context switching,
> which is the hot code path.
> 
> Change it to inline function

"always_inline" here and in the subject.

-- 
Cheers

David
