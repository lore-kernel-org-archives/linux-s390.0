Return-Path: <linux-kernel-owner+w=401wt.eu-S1753944AbYCMJtN@vger.kernel.org>
Subject: Re: [patch 03/10] sched: add exported arch_reinit_sched_domains()
	to header file.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20080312160328.50cecd7f.akpm@linux-foundation.org>
References: <20080312173155.703966894@de.ibm.com>
	 <20080312173216.861331041@de.ibm.com>
	 <20080312160328.50cecd7f.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Thu, 13 Mar 2008 10:48:52 +0100
Message-Id: <1205401732.26537.43.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2008-03-12 at 16:03 -0700, Andrew Morton wrote:
> > +#if defined(CONFIG_SCHED_MC) || defined(CONFIG_SCHED_SMT)
> > +extern int arch_reinit_sched_domains(void);
> > +#endif
> 
> I tend to recommend that the ifdefs be omitted here.
> 
> It has the downside that the build will then fail at link-time rather than
> at compile-time, but I haven't seen anyone complain about that.

Ok, I've removed the #if.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
