From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 13/15] cpu-model/s390: Add processor
 property routines
Date: Fri, 20 Feb 2015 17:04:08 +0100
Message-ID: <20150220170408.49db6da5@bee>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1424183053-4310-14-git-send-email-mimu@linux.vnet.ibm.com>
	<54E73EB2.6050700@suse.de>
	<20150220163209.4e082e0b@bee>
	<54E755BD.5000705@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54E755BD.5000705@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 20 Feb 2015 16:41:49 +0100
Andreas F=C3=A4rber <afaerber@suse.de> wrote:

> Can't you just implement the class-level name-to-ObjectClass callback
> that other CPUs have grown for the above use case?

If it fulfills the requirements sure. Please point me to an example, so=
unds that
s390_select_cpu_model() is doing something similar to that, just that i=
t hooks in
the s390_set_processor_props() call.

const char *s390_select_cpu_model(const char *model)
{
    S390ProcessorProps proc;
    const char *typename;
    S390CPUClass *cc;

    /* return already selected cpu typename */
    typename =3D s390_cpu_typename();
    if (typename) {
        goto out;
    }

    /* return standard cpu typename when cpu models are unavailable */
    typename =3D TYPE_S390_CPU;
    if (!s390_cpu_classes_initialized() || !model) {
        goto out;
    }
    cc =3D S390_CPU_CLASS(s390_cpu_class_by_name(model));
    if (!cc) {
        goto out;
    }
    proc.cpuid =3D cpuid(cc->proc);
    proc.ibc =3D cc->proc->ibc;
    memcpy(proc.fac_list, cc->fac_list, S390_ARCH_FAC_LIST_SIZE_BYTE);
    if (s390_set_processor_props(&proc)) {
        goto out;
    }

    /* return requested cpu typename in success case */
    typename =3D object_class_get_name((ObjectClass *) cc);
out:
    selected_cpu_typename =3D typename;
    trace_select_cpu_model(model, typename);
    return typename;
}


>=20
> Also a general comment: cpu-model/ is not an existing directory nor o=
ne
> you add, so please use "target-s390x: Add foo to S390CPU" or so.
