Return-Path: <sukadev@linux.vnet.ibm.com>
Date: Wed, 9 Sep 2015 14:12:55 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [[PATCH v6 09/10] powerpc/perf/hv-24x7: Use PMU_TXN_READ interface
Message-ID: <20150909211255.GB30739@us.ibm.com>
References: <1441336073-22750-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1441336073-22750-10-git-send-email-sukadev@linux.vnet.ibm.com>
 <1441703275.7601.5.camel@ellerman.id.au>
 <20150908112900.GF3644@twins.programming.kicks-ass.net>
 <1441764905.7854.5.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441764905.7854.5.camel@ellerman.id.au>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Michael Ellerman [mpe@ellerman.id.au] wrote:
| > > This looks fine to me from an arch perspective. I assume the whole series can
| > > go via tip-something?
| > 
| > Yeah, I've had it queued for a few days, there was one s390 compile
| > fail reported by the build-bot, which I've just fixed. So if nothing
| > weird happens, it should hit tip somewhere this week.

Peter, thanks for fixing the typo.

| 
| Great, thanks.
| 
| Now Sukadev can focus on getting the JSON events support merged, hopefully it
| won't require another 16 versions.

:-) BTW, other than an occasional patch from Andi Kleen (on top of the v16), I
have not received any comments on the JSON file patch set, so I don't have a
v17 in the pipeline...

Sukadev
