From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 11/15] target-s390x: New QMP command
	query-cpu-model
Date: Tue, 31 Mar 2015 22:09:09 +0200
Message-ID: <20150331220909.4410e8c0@bee>
References: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1427725708-52100-12-git-send-email-mimu@linux.vnet.ibm.com>
	<20150331183526.GJ7031@thinpad.lan.raisama.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <20150331183526.GJ7031@thinpad.lan.raisama.net>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 31 Mar 2015 15:35:26 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Mar 30, 2015 at 04:28:24PM +0200, Michael Mueller wrote:
> > This patch implements a new QMP request named 'query-cpu-model'.
> > It returns the cpu model of cpu 0 and its backing accelerator.
> > 
> > request:
> >   {"execute" : "query-cpu-model" }
> > 
> > answer:
> >   {"return" : {"name": "2827-ga2", "accel": "kvm" }}
> > 
> > Alias names are resolved to their respective machine type and GA names
> > already during cpu instantiation. Thus, also a cpu model like 'host'
> > which is implemented as alias will return its normalized cpu model name.
> > 
> > Furthermore the patch implements the following function:
> > 
> > - s390_cpu_models_used(), returns true if S390 cpu models are in use
> > 
> > Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> > ---
> [...]
> > +static inline char *strdup_s390_cpu_name(S390CPUClass *cc)
> > +{
> > +    return g_strdup_printf("%04x-ga%u", cc->proc.type, cc->mach.ga);
> > +}
> 
> How exactly is this information going to be used by clients? If getting
> the correct type and ga values is important for them, maybe you could
> add them as integer fields, instead of requiring clients to parse the
> CPU model name?

The consumer don't need to parse the name, it is just important for them to have
distinctive names that correlate with the names returned by query-cpu-definitions.
Once the name of an active guest is known, e.g. ("2827-ga2", "kvm") a potential
migration target can be verified, i.e. its query-cpu-definitions answer for "kvm"
has to contain "2827-ga2" with the attribute runnable set to true. With that mechanism
also the largest common denominator can be calculated. That model will be used then.

I also changed the above mentioned routine to map the cpu model none case:

static inline char *strdup_s390_cpu_name(S390CPUClass *cc)
{
    if (cpuid(cc->proc)) {
        return g_strdup_printf("%04x-ga%u", cc->proc.type, cc->mach.ga);
    } else {
        return g_strdup("none");
    }
}

This implicitly will fail a comparison for cpu model ("none", "kvm") as that will
never be part of the query-cpu-definitions answer.

I actually applied a couple of your suggestions like:

- test for NULL skipped after strdup_s390_cpu_name()
- strdup_s390_cpu_name() now also handles none cpu model case
- omit runnable and is-default field from query-cpu-definitions
  answer when they are false
- global variable cpu_models_used dropped
- function s390_cpu_models_used() dropped
- routine query-cpu-definitions has a single code path now

Only the integration of the ACCEL_ID with the cpu state in cpu_generic_init() and
the change for the query-cpus implementation is under construction. I hope to resend
the patches by tomorrow evening.

Thanks,
Michael 

> 
