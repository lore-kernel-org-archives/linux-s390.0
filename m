Return-Path: <linux-kernel-owner+w=401wt.eu-S1756293AbYCLXDq@vger.kernel.org>
Date: Wed, 12 Mar 2008 16:03:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 03/10] sched: add exported arch_reinit_sched_domains()
 to header file.
Message-Id: <20080312160328.50cecd7f.akpm@linux-foundation.org>
In-Reply-To: <20080312173216.861331041@de.ibm.com>
References: <20080312173155.703966894@de.ibm.com>
	<20080312173216.861331041@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 12 Mar 2008 18:31:58 +0100
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> +#if defined(CONFIG_SCHED_MC) || defined(CONFIG_SCHED_SMT)
> +extern int arch_reinit_sched_domains(void);
> +#endif

I tend to recommend that the ifdefs be omitted here.

It has the downside that the build will then fail at link-time rather than
at compile-time, but I haven't seen anyone complain about that.
