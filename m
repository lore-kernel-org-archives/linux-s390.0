From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v4 11/15] target-s390x: New QMP command query-cpu-model
Date: Wed, 1 Apr 2015 10:01:13 -0300
Message-ID: <20150401130113.GL7031@thinpad.lan.raisama.net>
References: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
 <1427725708-52100-12-git-send-email-mimu@linux.vnet.ibm.com>
 <20150331183526.GJ7031@thinpad.lan.raisama.net>
 <20150331220909.4410e8c0@bee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150331220909.4410e8c0@bee>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Mar 31, 2015 at 10:09:09PM +0200, Michael Mueller wrote:
> On Tue, 31 Mar 2015 15:35:26 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Mon, Mar 30, 2015 at 04:28:24PM +0200, Michael Mueller wrote:
> > > This patch implements a new QMP request named 'query-cpu-model'.
> > > It returns the cpu model of cpu 0 and its backing accelerator.
> > > 
> > > request:
> > >   {"execute" : "query-cpu-model" }
> > > 
> > > answer:
> > >   {"return" : {"name": "2827-ga2", "accel": "kvm" }}
> > > 
> > > Alias names are resolved to their respective machine type and GA names
> > > already during cpu instantiation. Thus, also a cpu model like 'host'
> > > which is implemented as alias will return its normalized cpu model name.
> > > 
> > > Furthermore the patch implements the following function:
> > > 
> > > - s390_cpu_models_used(), returns true if S390 cpu models are in use
> > > 
> > > Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> > > ---
> > [...]
> > > +static inline char *strdup_s390_cpu_name(S390CPUClass *cc)
> > > +{
> > > +    return g_strdup_printf("%04x-ga%u", cc->proc.type, cc->mach.ga);
> > > +}
> > 
> > How exactly is this information going to be used by clients? If getting
> > the correct type and ga values is important for them, maybe you could
> > add them as integer fields, instead of requiring clients to parse the
> > CPU model name?
> 
> The consumer don't need to parse the name, it is just important for them to have
> distinctive names that correlate with the names returned by query-cpu-definitions.
> Once the name of an active guest is known, e.g. ("2827-ga2", "kvm") a potential
> migration target can be verified, i.e. its query-cpu-definitions answer for "kvm"
> has to contain "2827-ga2" with the attribute runnable set to true. With that mechanism
> also the largest common denominator can be calculated. That model will be used then.

Understood. So the point is to really have a name that can be found at
query-cpu-definitions. Makes sense.

(BTW, if you reused strdup_s390_cpu_name() inside
s390_cpu_compare_class_name() too, you would automatically ensure that
query-cpus, query-cpu-definitions and s390_cpu_class_by_name() will
always agree with each other).

> 
> I also changed the above mentioned routine to map the cpu model none case:
> 
> static inline char *strdup_s390_cpu_name(S390CPUClass *cc)
> {
>     if (cpuid(cc->proc)) {
>         return g_strdup_printf("%04x-ga%u", cc->proc.type, cc->mach.ga);
>     } else {
>         return g_strdup("none");
>     }
> }

What about:

  static const char *s390_cpu_name(S390CPUClass *cc)
  {
      return cc->model_name;
  }

And then you can just set cc->model_name=_name inside S390_PROC_DEF (and
set it to "none" inside s390_cpu_class_init()).

I wonder if this class->model_name conversion could be made generic
inside the CPU class. We already have a CPU::class_by_name() method, so
it makes sense to have the opposite function too.

(But I wouldn't mind making this s390-specific first, and converted
later to generic code if appropriate).

> 
> This implicitly will fail a comparison for cpu model ("none", "kvm") as that will
> never be part of the query-cpu-definitions answer.

I am not sure I follow. If ("none", "kvm") is never in the list, is
"-cpu none -machine accel=kvm" always an invalid use case?

(I don't understand completely the meaning of "-cpu none" yet. How does
the CPU look like for the guest in this case? Is it possible to
live-migrate when using -cpu none?)

-- 
Eduardo
