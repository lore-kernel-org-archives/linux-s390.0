From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 13/15] cpu-model/s390: Add processor
 property routines
Date: Fri, 20 Feb 2015 16:32:09 +0100
Message-ID: <20150220163209.4e082e0b@bee>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1424183053-4310-14-git-send-email-mimu@linux.vnet.ibm.com>
	<54E73EB2.6050700@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <54E73EB2.6050700@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 20 Feb 2015 15:03:30 +0100
Alexander Graf <agraf@suse.de> wrote:

> > 
> > - s390_get_proceccor_props()
> > - s390_set_proceccor_props()
> > 
> > They can be used to request or retrieve processor related information from an accelerator.
> > That information comprises the cpu identifier, the ICB value and the facility lists.
> > 
> > Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>  
> 
> Hrm, I still seem to miss the point of this interface. What do you need
> it for?

These functions make the internal s390 cpu model API independent from a specific accelerator:  

int s390_set_processor_props(S390ProcessorProps *prop)
{
    if (kvm_enabled()) {
        return kvm_s390_set_processor_props(prop);
    }
    return -ENOSYS;
}

It's called by:

s390_select_cpu_model(const char *model)

which is itself called by:

S390CPU *cpu_s390x_init(const char *cpu_model)
{
    S390CPU *cpu;

    cpu = S390_CPU(object_new(s390_select_cpu_model(cpu_model)));

    object_property_set_bool(OBJECT(cpu), true, "realized", NULL);

    return cpu;
}

So above s390_set/get_processor_props() the code is accelerator independent.

Michael
