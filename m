Return-Path: <linux-kernel-owner+w=401wt.eu-S1756725AbZCEQ7k@vger.kernel.org>
From: Dan Smith <danms@us.ibm.com>
Subject: Re: [PATCH] s390: Expose a constant for the number of words representing the CRs
References: <1236271688-18806-1-git-send-email-danms@us.ibm.com>
Date: Thu, 05 Mar 2009 08:54:11 -0800
In-Reply-To: <1236271688-18806-1-git-send-email-danms@us.ibm.com> (Dan Smith's
	message of "Thu, 5 Mar 2009 11:48:08 -0500")
Message-ID: <87tz67vrkc.fsf@caffeine.danplanet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

DS> We need to use this value in the checkpoint/restart code and would
DS> like to have a constant instead of a magic '3'.

DS> Changelog:
DS>     Mar 03:
DS>             . Picked up additional use of magic '3' in ptrace.h

DS> Signed-off-by: Dan Smith <danms@us.ibm.com>
DS> Cc: linux-s390@vger.kernel.org
DS> ---
DS>  arch/s390/include/asm/ptrace.h   |    4 +++-
DS>  arch/s390/kernel/compat_ptrace.h |    3 ++-
DS>  2 files changed, 5 insertions(+), 2 deletions(-)

If there aren't any objections to this patch, can it get picked up?

Thanks!

-- 
Dan Smith
IBM Linux Technology Center
email: danms@us.ibm.com
