From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 6/6] cputime: Introduce
 cputime_to_timespec64()/timespec64_to_cputime()
Date: Wed, 15 Jul 2015 12:31:23 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1507151226210.18576@nanos>
References: <cover.1436511577.git.baolin.wang@linaro.org> <a1bd8d71caeb4051d0be87aad1baae7ababa4df7.1436511577.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <a1bd8d71caeb4051d0be87aad1baae7ababa4df7.1436511577.git.baolin.wang@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: benh@kernel.crashing.org, arnd@arndb.de, john.stultz@linaro.org, peterz@infradead.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, rth@twiddle.net, riel@redhat.com, cl@linux.com, tj@kernel.org, fweisbec@gmail.com, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, y2038@lists.linaro.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 15 Jul 2015, Baolin Wang wrote:

> The cputime_to_timespec() and timespec_to_cputime() functions are
> not year 2038 safe on 32bit systems due to that the struct timepsec
> will overflow in 2038 year.

And how is this relevant? cputime is not based on wall clock time at
all. So what has 2038 to do with cputime?

We want proper explanations WHY we need such a change.

Thanks,

	tglx
