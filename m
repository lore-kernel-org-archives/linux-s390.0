Return-Path: <balbir@linux.vnet.ibm.com>
Message-ID: <471F15D5.3050100@linux.vnet.ibm.com>
Date: Wed, 24 Oct 2007 15:22:21 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] taskstats scaled time cleanup
References: <8789.1193208897@neuling.org>
In-Reply-To: <8789.1193208897@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: balbir@linux.vnet.ibm.com
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
To: Michael Neuling <mikey@neuling.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org, linux390@de.ibm.com, akpm@linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

Michael Neuling wrote:
> This moves the ability to scale cputime into generic code.  This
> allows us to fix the issue in kernel/timer.c (noticed by Balbir) where
> we could only add an unscaled value to the scaled utime/stime.
> 
> This adds a cputime_to_scaled function.  As before, the POWERPC
> version does the scaling based on the last SPURR/PURR ratio
> calculated.  The generic and s390 (only other arch to implement
> asm/cputime.h) versions are both NOPs.
> 
> Also moves the SPURR and PURR snapshots closer.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Looks good to me

Acked-by: Balbir Singh <balbir@linux.vnet.ibm.com>

-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
