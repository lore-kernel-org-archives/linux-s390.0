From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 00/17] s390x cpu model implementation
Date: Mon, 27 Apr 2015 10:11:50 +0200
Message-ID: <553DEF46.2030902@de.ibm.com>
References: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Andreas Faerber <afaerber@suse.de>
List-ID: <linux-s390.vger.kernel.org>

Am 13.04.2015 um 15:56 schrieb Michael Mueller:
> This patch set in combination with its kernel kvm patch set proposes an
> implementation of S390 CPU models. The origin of this item is to provide
> a means for management interfaces like libvirt to draw decisions if life
> guest migration to a target hypervisor is reasonable.
> 
> A migration constraint is that a target hypervisor is capable to run a
> guest with the same CPU model as the source hypervisor does. To
> verify this condition, the administration interface employes the existing
> QMP command "query-cpu-definitions" which returns a list of all currently
> supported CPU models of a given host system. Together with the extension of
> QMP command "query-cpus", the current CPU model of a guest is retrievable
> and a conclusion can be drawn if a migration is possible.
> 
> A S390 CPU model is defined as a triple of machine type, CPU facility set
> and IBC value. Each historic, current and future triple receives a name
> composed of the machine type and its general availability counter. This name
> forms the CPU model name (e.g.: "2817-ga2".)
> 
> With means of the Instruction Blocking Control feature (IBC), the instruction
> set available to a given guest is limitable.

From an s390 perspective this series looks like the right approach. When looking
closer things are slightly more complicated than expected:

The base line is the CPU type (like 2964 aka z13). This also qualifies the
type of the whole guest (its not a cpu but a system property). This can be
queried in the guest with the STIPD(store cpu id) instruction.

Then there a the guest visible facilities. Those are the common subset of
the facilities provides by the machine, LPAR and potentially z/VM. We can then
add the facilities that are fully handled by QEMU. In theory this can be
up to 16k facility bits and can be queried in the guest with the STFLE(store
facility list extended) instruction.

It is the responsibility of QEMU/KVM to follow the facility bits when doing
an instruction handling. For things handled by the HW we have to setup the 
IBC control to be as good as possible.

This series seem to handle all cases as far as I can see during test and review.

Christian


As long as the libvirt ans x86 folks are fine with the interfaces on the QMP
level I think this is almost good to go.

I have some minor style things as followup. With that fixed
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
for the series.
