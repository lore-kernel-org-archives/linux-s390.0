Return-Path: <sukadev@linux.vnet.ibm.com>
Date: Tue, 1 Sep 2015 15:11:53 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 1/8] perf: Add a flags parameter to pmu txn interfaces
Message-ID: <20150901221153.GB4158@us.ibm.com>
References: <1439534981-7937-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1439534981-7937-2-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150901103859.GP19282@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150901103859.GP19282@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Peter Zijlstra [peterz@infradead.org] wrote:
| 
| when looking at this (I almost pressed A for apply) it occurred to me
| that we now keep double state, cpuhw->txn_flags and cpuhw->group_flag
| are basically the same thing.
| 
| Would not something like the below avoid this duplication?

Yes, it makes sense to drop the duplication. Will similarly drop the usage
of PERF_EVENT_TXN from other architectures too and try it out.

Thanks,

Sukadev
