Return-Path: <scottwood@freescale.com>
Message-ID: <1443453406.32298.171.camel@freescale.com>
Subject: Re: [PATCH v8 1/4] perf,kvm/{x86,s390}: Remove dependency on
 uapi/kvm_perf.h
From: Scott Wood <scottwood@freescale.com>
Date: Mon, 28 Sep 2015 10:16:46 -0500
In-Reply-To: <56094F5D.9090805@gmail.com>
References: <1443161838-31462-1-git-send-email-hemant@linux.vnet.ibm.com>
 <87bncm7l6z.fsf@linux.vnet.ibm.com> <56094F5D.9090805@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: David Ahern <dsahern@gmail.com>
Cc: Alexander Yarygin <yarygin@linux.vnet.ibm.com>, Hemant Kumar <hemant@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, acme@kernel.org, sukadev@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, mpe@ellerman.id.au, paulus@samba.org, mingo@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2015-09-28 at 08:31 -0600, David Ahern wrote:
> On 9/28/15 7:00 AM, Alexander Yarygin wrote:
> > > diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> > > index fc1cffb..ef25fcf 100644
> > > --- a/tools/perf/builtin-kvm.c
> > > +++ b/tools/perf/builtin-kvm.c
> > > @@ -31,20 +31,18 @@
> > >   #include <math.h>
> > > 
> > >   #ifdef HAVE_KVM_STAT_SUPPORT
> > > -#include <asm/kvm_perf.h>
> > >   #include "util/kvm-stat.h"
> > > 
> > > -void exit_event_get_key(struct perf_evsel *evsel,
> > > -                 struct perf_sample *sample,
> > > +void exit_event_get_key(struct perf_evsel *evsel, struct perf_sample 
> > > *sample,
> > >                           struct event_key *key)
> > >   {
> > >           key->info = 0;
> > > - key->key = perf_evsel__intval(evsel, sample, KVM_EXIT_REASON);
> > > + key->key = perf_evsel__intval(evsel, sample, exit_reason_code);
> > >   }
> > > 
> > >   bool kvm_exit_event(struct perf_evsel *evsel)
> > >   {
> > > - return !strcmp(evsel->name, KVM_EXIT_TRACE);
> > > + return !strncmp(evsel->name, kvm_events_tp[1], strlen(evsel->name));
> > >   }
> > 
> > Hmm, direct access to kvm_events_tp? Maybe add a getter for this or
> > something like extern char *kvm_exit_trace;?
> > /* why strncmp? */
> > 
> > > 
> > >   bool exit_event_begin(struct perf_evsel *evsel,
> > > @@ -60,7 +58,7 @@ bool exit_event_begin(struct perf_evsel *evsel,
> > > 
> > >   bool kvm_entry_event(struct perf_evsel *evsel)
> > >   {
> > > - return !strcmp(evsel->name, KVM_ENTRY_TRACE);
> > > + return !strncmp(evsel->name, kvm_events_tp[0], strlen(evsel->name));
> > >   }
> > > 
> > >   bool exit_event_end(struct perf_evsel *evsel,
> 
> I agree; don't rely on kvm_events_tp. Define KVM_ENTRY_TRACE and 
> KVM_EXIT_TRACE like x86.

If you mean defining them in uapi, that doesn't work for arches that have 
multiple subarches that may have different trace events.  This patchset 
doesn't actually implement dynamic support for the subarches, but it avoids 
adding constants to uapi headers that only apply to one of the subarches.

-Scott
