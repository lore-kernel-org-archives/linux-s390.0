Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] mutex: Introduce mutex_cpu_relax()
From: Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <1287070392.8344.15.camel@thinkpad>
References: <1287070392.8344.15.camel@thinkpad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Date: Thu, 14 Oct 2010 17:55:29 +0200
Message-ID: <1287071729.29097.278.camel@twins>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: gerald.schaefer@de.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2010-10-14 at 17:33 +0200, Gerald Schaefer wrote:
> From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> 
> The spinning mutex implementation uses cpu_relax() in busy loops as a
> compiler barrier. Depending on the architecture, cpu_relax() may do more
> than needed in this specific mutex spin loops. On System z we also give
> up the time slice of the virtual cpu in cpu_relax(), which prevents
> effective spinning on the mutex.
> 
> This patch replaces cpu_relax() in the spinning mutex code with a new
> function mutex_cpu_relax(), which can be defined by each architecture
> that selects HAVE_MUTEX_CPU_RELAX. The default is still cpu_relax(), so
> this patch should not affect other architectures than System z for now.

Sure.. I'll take it.
