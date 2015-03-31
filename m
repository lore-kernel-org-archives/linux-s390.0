From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 10/15] target-s390x: Prepare accelerator
 during cpu object realization
Date: Tue, 31 Mar 2015 12:26:31 +0200
Message-ID: <20150331122631.44f50fa5@bee>
References: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1427725708-52100-11-git-send-email-mimu@linux.vnet.ibm.com>
	<20150330193351.GC7031@thinpad.lan.raisama.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150330193351.GC7031@thinpad.lan.raisama.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 30 Mar 2015 16:33:51 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Mar 30, 2015 at 04:28:23PM +0200, Michael Mueller wrote:
> > This patch implements routine s390_cpu_model_init(). It is called by the
> > realize function during instantiation of an cpu object. Its task is to
> > initialize the current accelerator with the properties of the selected
> > processor model.
> > 
> > Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> > ---
> >  target-s390x/cpu-models.c | 37 +++++++++++++++++++++++++++++++++++++
> >  target-s390x/cpu-models.h |  4 ++++
> >  target-s390x/cpu.c        |  1 +
> >  3 files changed, 42 insertions(+)
> > 
> > diff --git a/target-s390x/cpu-models.c b/target-s390x/cpu-models.c
> > index 8a877d3..ba873ea 100644
> > --- a/target-s390x/cpu-models.c
> > +++ b/target-s390x/cpu-models.c
> > @@ -111,6 +111,7 @@ typedef struct ParmAddrAddrModeMask {
> >  } ParmAddrAddrModeMask;
> >  
> >  static GSList *s390_cpu_aliases;
> > +static bool cpu_models_used;
> >  
> >  /* compare order of two cpu classes for ascending sort */
> >  gint s390_cpu_class_asc_order_compare(gconstpointer a, gconstpointer b)
> > @@ -670,3 +671,39 @@ uint64_t *s390_current_fac_list_mask(void)
> >      return s390_fac_list_mask_by_machine(mc->name);
> >  }
> >  #endif
> > +
> > +/**
> > + * s390_cpu_model_init:
> > + * @cc: S390 CPU class
> > + *
> > + * This function intitializes the current accelerator with processor
> > + * related properties.
> > + *
> > + * Since: 2.4
> > + */
> > +void s390_cpu_model_init(S390CPUClass *cc)
> > +{
> > +    S390ProcessorProps proc;
> > +
> > +    /* none cpu model case */
> > +    if (!strcmp(object_class_get_name(OBJECT_CLASS(cc)), TYPE_S390_CPU)) {
> > +        return;
> > +    }
> 
> Instead of checking the class name, can't you just check a S390CPUClass
> field that may indicate that s390_cpu_model_init() doesn't need to do
> anything for the class? Maybe (cpuid(cc->proc) == 0)?

That will work as well but excludes cpuid 0 from being a valid cpu id.

> 
> 
> > +
> > +    /* accelerator already prepared */
> > +    if (cpu_models_used) {
> > +        return;
> > +    }
> 
> I'm still trying to understand the need for this global. But I will ask
> for more details in the following patches that actually use
> s390_cpu_models_used()?

I'm currently using the variable to avoid multiple calls to kvm_s390_set_processor_props() as it
sets the processor properties for all vcpus. I will not hurt to call it twice or more often, it
is just not required and just consumes cpu cycles.

> 
> > +
> > +    proc.cpuid = cpuid(cc->proc);
> > +    proc.ibc = cc->proc.ibc;
> > +    bitmap_zero(proc.fac_list, FAC_LIST_ARCH_S390_SIZE_UINT1);
> > +    bitmap_copy(proc.fac_list, cc->fac_list[ACCEL_CURRENT],
> > +                FAC_LIST_CPU_S390_SIZE_UINT1);
> > +
> > +    if (kvm_enabled()) {
> > +        if (!kvm_s390_set_processor_props(&proc)) {
> > +            cpu_models_used = true;
> > +        }
> > +    }
> > +}
> > diff --git a/target-s390x/cpu-models.h b/target-s390x/cpu-models.h
> > index 9562088..fe3997f 100644
> > --- a/target-s390x/cpu-models.h
> > +++ b/target-s390x/cpu-models.h
> > @@ -45,6 +45,9 @@
> >  #define type_cpuid(x)     ((uint64_t)((x) & 0xffff) << 16)
> >  #define id_cpuid(x)       ((uint64_t)((x) & 0xffffff) << 32)
> >  #define ver_cpuid(x)      ((uint64_t)((x) & 0xff) << 56)
> > +#define cpuid(x)          (ver_cpuid(x.ver) |  \
> > +                           id_cpuid(x.id) |    \
> > +                           type_cpuid(x.type))
> >  
> >  #define oldest_ibc(x)     (((uint32_t)(x) >> 16) & 0xfff)
> >  #define newest_ibc(x)     ((uint32_t)(x) & 0xfff)
> > @@ -108,6 +111,7 @@ void s390_cpu_list_entry(gpointer data, gpointer user_data);
> >  bool s390_cpu_classes_initialized(void);
> >  uint64_t *s390_fac_list_mask_by_machine(const char *name);
> >  uint64_t *s390_current_fac_list_mask(void);
> > +void s390_cpu_model_init(S390CPUClass *cc);
> >  
> >  extern uint64_t qemu_s390_fac_list_mask[];
> >  
> > diff --git a/target-s390x/cpu.c b/target-s390x/cpu.c
> > index c33f05e..829945d 100644
> > --- a/target-s390x/cpu.c
> > +++ b/target-s390x/cpu.c
> > @@ -180,6 +180,7 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
> >      CPUState *cs = CPU(dev);
> >      S390CPUClass *scc = S390_CPU_GET_CLASS(dev);
> >  
> > +    s390_cpu_model_init(scc);
> >      s390_cpu_gdb_init(cs);
> >      qemu_init_vcpu(cs);
> >  #if !defined(CONFIG_USER_ONLY)
> > -- 
> > 1.8.3.1
> > 
> 
