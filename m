Return-Path: <linux-kernel-owner+w=401wt.eu-S1756629AbYCUMbG@vger.kernel.org>
Date: Fri, 21 Mar 2008 13:30:38 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 04/10] sched: Add arch_update_cpu_topology hook.
Message-ID: <20080321123038.GI25225@elte.hu>
References: <20080312173155.703966894@de.ibm.com> <20080312173217.078548501@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080312173217.078548501@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


* Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> Will be called each time the scheduling domains are rebuild. Needed 
> for architectures that don't have a static cpu topology.

thanks, applied.

	Ingo
