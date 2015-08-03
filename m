Return-Path: <michael@ozlabs.org>
In-Reply-To: <1436929315-28520-3-git-send-email-sukadev@linux.vnet.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v3,
 2/8] powerpc/perf/hv-24x7: Simplify extracting counter from result
 buffer
Message-Id: <20150803013505.22281140DF7@ozlabs.org>
Date: Mon,  3 Aug 2015 11:35:05 +1000 (AEST)
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2015-15-07 at 03:01:49 UTC, Sukadev Bhattiprolu wrote:
> Simplify code that extracts a 24x7 counter from the HCALL's result buffer.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/465345ca387ed491c467

cheers
