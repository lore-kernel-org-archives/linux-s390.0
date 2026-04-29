Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42231401A02;
	Wed, 29 Apr 2026 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470167; cv=none; b=bXyhc9eW9fbWREuxtwtECJ6SfPGiCfDslhRMIHyEtIOdDfHl3lF+xy8WuowWH4Wce37rdEadqv7xgVNaPr3+5x5O8n2wH/r2spX90mcJsP5dKN/uIwpJJSYf00wbU6IU3wTi9ICkhyWkv9EF96lkMKvy019XdYIS59uHwsImbBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470167; c=relaxed/simple;
	bh=a+7XuyHe4EWHnX6s11UGKgV6DlS21CowOLqbN6S2Lg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=og8PICTTsitAX7Jb/6C13mVEU8+Jj6nmHdnH4kRwMEA5fU+9QQnILMwa8iNr48fqJBUXpCWvQct/y54CvRc1ixc5XPGRHFCXY07Q78MxKxSO5PeFi4IaWh2Vb0zm7iGFht89v/5SW9s+K5LTseZZ6N7AxirteVThcUzETymr0K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OE6rjPL/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OE6rjPL/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0897C2BCB8;
	Wed, 29 Apr 2026 13:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777470166;
	bh=a+7XuyHe4EWHnX6s11UGKgV6DlS21CowOLqbN6S2Lg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OE6rjPL/oe/WMCFrDH6l3RbMArU6cghOl5LqMUtgZvG93/JEtP90ZRaC0R0/nGTJ4
	 i572MX4/7aD2rfZ53EXS46/FDWqfHYU05/BmQIc+RlsiVLJkDNacCGZ/MfIvtgp3vF
	 Bxg77LO0XIFRq8wXYAO0F+CeZ4hlYusXnDMTKe+c9pYwyPznu/Gnx6ihT1KvAbd7xW
	 BcmxHOc8NbxIy4uK1TCKCt9SLUhJcTudfvODsIt5bMkg3e6IZW+gRLAI82UCOlmfir
	 5B2/FrFB9LuiytqiN486dclU0Nc+jC8Q6z06/I6g+k/xMWoJVFDIeC3yeD/Gd+xlq/
	 tjEWzpbb7DouA==
Date: Wed, 29 Apr 2026 15:42:43 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xin Zhao <jackzxcui1989@163.com>, linux-pm@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 04/14] powerpc/time: Prepare to stop elapsing in
 dynticks-idle
Message-ID: <afIK02h-gBvuqJnn@pavilion.home>
References: <20260331131622.30505-1-frederic@kernel.org>
 <20260331131622.30505-5-frederic@kernel.org>
 <2dab11d1-18ca-4da4-a33e-3f2c3c4b6320@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2dab11d1-18ca-4da4-a33e-3f2c3c4b6320@kernel.org>

Le Mon, Apr 13, 2026 at 01:00:07PM +0200, Christophe Leroy (CS GROUP) a écrit :
> > @@ -37,11 +37,17 @@ extern void vtime_account_irq(struct task_struct *tsk, unsigned int offset);
> >   extern void vtime_account_softirq(struct task_struct *tsk);
> >   extern void vtime_account_hardirq(struct task_struct *tsk);
> >   extern void vtime_flush(struct task_struct *tsk);
> > +extern void vtime_reset(void);
> > +extern void vtime_dyntick_start(void);
> > +extern void vtime_dyntick_stop(void);
> >   #else /* !CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
> >   static inline void vtime_account_irq(struct task_struct *tsk, unsigned int offset) { }
> >   static inline void vtime_account_softirq(struct task_struct *tsk) { }
> >   static inline void vtime_account_hardirq(struct task_struct *tsk) { }
> >   static inline void vtime_flush(struct task_struct *tsk) { }
> > +static inline void vtime_reset(void) { }
> > +static inline void vtime_dyntick_start(void) { }
> > +extern inline void vtime_dyntick_stop(void) { }
> 
> You mean 'static' inline, not 'extern' ?

I might have been too creative here, yes.

Thanks.

> 
> Christophe
> 
> >   #endif
> >   /*
> 

-- 
Frederic Weisbecker
SUSE Labs
