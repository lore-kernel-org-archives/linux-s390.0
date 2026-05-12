Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA752BEC55;
	Tue, 12 May 2026 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778603300; cv=none; b=PcIL6YhQirrJuyBld/hvmbDXsf89xwBU3Bfshe5U5MMo8R91uGG8sAg5Taxdp30W+AIPdYRALwQXGwPYiLs1TW2vdoUev0RPIhN96xtWbr9PSWKzfVeD3oDVUPRraV5Nn2XVbCThNOgytIJnDjY6WHlUiMvD8I6CsoRagAqMjTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778603300; c=relaxed/simple;
	bh=umumbv8Xibwz5PNmq41/86fqZ+V9d7EWj8qghUf6648=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JORTLqNDkmhOohil4+oByu6g6k9yOzszO6fcQ137dfJY5DcmyZu4ExJC6z3rDgMLKgWENZEZz3pc0Xm5/TM3qHsrKJBfyH+Ja5szprZ905peACOA2qaIqzSGf0JZkOTyzM8F8Ug9qvV2IIP2El8LEnqoqVqtVzcjdOkKroEFdag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 9609D8D429;
	Tue, 12 May 2026 16:28:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 6520B22;
	Tue, 12 May 2026 16:28:00 +0000 (UTC)
Date: Tue, 12 May 2026 12:28:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Boqun Feng <boqun@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Jonas Bonn
 <jonas@southpole.se>, Stefan Kristiansson
 <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
 <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Waiman
 Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Jinjie Ruan <ruanjinjie@huawei.com>, Ada Couprie Diaz
 <ada.coupriediaz@arm.com>, Lyude Paul <lyude@redhat.com>, Sohil Mehta
 <sohil.mehta@intel.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 "Xin Li (Intel)" <xin@zytor.com>, Sean Christopherson <seanjc@google.com>,
 Nikunj A Dadhania <nikunj@amd.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Randy Dunlap
 <rdunlap@infradead.org>, Yury Norov <ynorov@nvidia.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 01/11] preempt: Introduce HARDIRQ_DISABLE_BITS
Message-ID: <20260512122801.79884485@gandalf.local.home>
In-Reply-To: <20260508042111.24358-2-boqun@kernel.org>
References: <20260508042111.24358-1-boqun@kernel.org>
	<20260508042111.24358-2-boqun@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 6520B22
X-Stat-Signature: siy76ic6a7ndj93xh66ps7gdgrg9ceru
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18cv6OoxCsPoWj2y+4BLp9UBWsID8JUeTk=
X-HE-Tag: 1778603280-691158
X-HE-Meta: U2FsdGVkX1/WJk38SJasulkhnQXt2POZLq/n9mG8yUmGvlU1cvDkEMx/1czYXGKaI6jwDsOoayRYhKNLN7D2cm2gXXb9Aq6fcV286VwXJMoXfhQAmqWayZ7FO7uBMpfYALvr6k8q5+C844+pyxrkcPKZIHG0UpA8eND8aUR1qV3Zey5gF66bPEvznJjErU/ghNqkks7E4ZrOjqwGOH9cbQ2YNlzGdtNEvhRJ837KpC0/1+Q4KbRBDF2vVKDC+KJbm4exqmUM3UBL5/n5gFKfXFfLTyXf3fw+GOAkZIQOSpq6V1O4ZarEKK2ObeVgb1FRQ1UZkbZDX7SjsgNcLOyYctfAIXAueSYLbvzTw4FD5IEWC9GX+/qb8WbFhecsmI2yYMgy3reGMVP67RuIxP5gWaCJhml0VABFZd2u+I8/8lZtWEiFJo4DfgDHgzbvMJCuzBIPCan0onkB3frlIlWfipjO1DnWOQtS

On Thu,  7 May 2026 21:21:01 -0700
Boqun Feng <boqun@kernel.org> wrote:

> From: Boqun Feng <boqun.feng@gmail.com>
> 
> In order to support preempt_disable()-like interrupt disabling, that is,
> using part of preempt_count() to track interrupt disabling nested level,
> change the preempt_count() layout to contain 8-bit HARDIRQ_DISABLE
> count.
> 
> Note that HARDIRQ_BITS and NMI_BITS are reduced by 1 because of this,
> and it changes the maximum of their (hardirq and nmi) nesting level.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Boqun Feng <boqun@kernel.org>
> Link: https://patch.msgid.link/20260121223933.1568682-2-lyude@redhat.com
> ---
>  include/linux/preempt.h | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> index d964f965c8ff..f07e7f37f3ca 100644
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -17,6 +17,7 @@
>   *
>   * - bits 0-7 are the preemption count (max preemption depth: 256)
>   * - bits 8-15 are the softirq count (max # of softirqs: 256)
> + * - bits 16-23 are the hardirq disable count (max # of hardirq disable: 256)
>   *
>   * The hardirq count could in theory be the same as the number of
>   * interrupts in the system, but we run all interrupt handlers with
> @@ -26,29 +27,34 @@
>   *
>   *         PREEMPT_MASK:	0x000000ff
>   *         SOFTIRQ_MASK:	0x0000ff00
> - *         HARDIRQ_MASK:	0x000f0000
> - *             NMI_MASK:	0x00f00000
> + * HARDIRQ_DISABLE_MASK:	0x00ff0000
> + *         HARDIRQ_MASK:	0x07000000
> + *             NMI_MASK:	0x38000000

I wonder if you should switch patch 1 and 2 and move the NMI bits out
first. That way you avoid the side effect of this patch shrinking the NMI
nest count from 15 to 7. It may not matter, but I hate when a patch
introduces a side effect like this.

-- Steve


>   * PREEMPT_NEED_RESCHED:	0x80000000
>   */
>  #define PREEMPT_BITS	8
>  #define SOFTIRQ_BITS	8
> -#define HARDIRQ_BITS	4
> -#define NMI_BITS	4
> +#define HARDIRQ_DISABLE_BITS	8
> +#define HARDIRQ_BITS	3
> +#define NMI_BITS	3
>  
