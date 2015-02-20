From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 04/15] cpu-model/s390: Introduce
 S390 CPU models
Date: Fri, 20 Feb 2015 16:02:22 +0100
Message-ID: <20150220160222.4a7817d7@bee>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1424183053-4310-5-git-send-email-mimu@linux.vnet.ibm.com>
	<54E73CD4.8080506@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54E73CD4.8080506@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 20 Feb 2015 14:55:32 +0100
Alexander Graf <agraf@suse.de> wrote:

> >  /**
> >   * S390CPUClass:
> >   * @parent_realize: The parent class' realize handler.
> > @@ -52,6 +69,11 @@ typedef struct S390CPUClass {
> >      void (*load_normal)(CPUState *cpu);
> >      void (*cpu_reset)(CPUState *cpu);
> >      void (*initial_cpu_reset)(CPUState *cpu);
> > +    bool is_active[ACCEL_ID_MAX]; /* model enabled for given host and accel */
> > +    bool is_host[ACCEL_ID_MAX];   /* model markes host for given accel */
> > +    uint64_t *fac_list;           /* active facility list */
> > +    S390CPUMachineProps   *mach;  /* machine specific properties */
> > +    S390CPUProcessorProps *proc;  /* processor specific properties */  
> 
> Sorry, same here. Just put the structs straight into the class struct.

Yep, consistent.
