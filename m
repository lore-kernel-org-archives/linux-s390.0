Return-Path: <peterz@infradead.org>
Date: Thu, 13 Aug 2015 22:47:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 09/10] Define PERF_PMU_TXN_READ interface
Message-ID: <20150813204714.GG16853@twins.programming.kicks-ass.net>
References: <1437975638-789-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1437975638-789-10-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150806121029.GQ19282@twins.programming.kicks-ass.net>
 <20150812041400.GA28426@us.ibm.com>
 <20150812084545.GR16853@twins.programming.kicks-ass.net>
 <20150813200428.GA19057@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150813200428.GA19057@us.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Aug 13, 2015 at 01:04:28PM -0700, Sukadev Bhattiprolu wrote:

> | > | +static int perf_read_group(struct perf_event *event,
> | > | +				   u64 read_format, char __user *buf)
> | > | +{
> | > | +	struct perf_event *leader = event->group_leader, *child;
> | > | +	struct perf_event_context *ctx = leader->ctx;
> | > | +	int ret = leader->read_size;

> One other question, We return leader->read_size but allocate/copy_to_user
> the sibling's event->read_size. We consistently use read_format from the
> 'event' being read, rather than its 'group_leader', so we are ok in terms
> of what we copy into values[] for each event in the group.
> 
> But, can the leader's read_format (and hence its read_size) differ from
> its sibling's read_size? If so, in the current code, we return the event's
> read_size but in the new code, we return the leader's read_size.

Hmm, good spotting that. I'm fairly sure I didn't do that on purpose.

I think we should use event->read_size there too and have the lot
consistent. I don't think we require read_format to be uniform across
siblings.
