From: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC][patch 3/6] KVM: s390: Add GISA support
Date: Fri, 05 Sep 2014 10:29:26 +0200
Message-ID: <54097466.2090502@suse.de>
References: <20140904105223.336503578@de.ibm.com> <20140904105337.081387456@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20140904105337.081387456@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: frank.blaschka@de.ibm.com, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: aik@ozlabs.ru, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>



On 04.09.14 12:52, frank.blaschka@de.ibm.com wrote:
> From: Frank Blaschka <frank.blaschka@de.ibm.com>
> 
> This patch adds GISA (Guest Interrupt State Area) support
> to s390 kvm. GISA can be used for exitless interrupts. The
> patch provides a set of functions for GISA related operations
> like accessing GISA fields or registering ISCs for alert.
> Exploiters of GISA will follow with additional patches.
> 
> Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>

That's a nice feature. However, please make sure that you maintain the
abstraction levels.

What should happen is that you request an irqfd from FLIC. Then you
associate that irqfd with the PCI device.

Thanks to that association, both parties can now talk to each other and
negotiate their GISA number space and make sure things are connected.

However, it should always be possible to do things without this direct
IRQ injection.

So you should be able to receive an irqfd event when an IRQ happened, so
that VFIO user space applications can also handle interrupts for example.

And the same applies for interrupt injection. We also need to be able to
inject an adapter interrupt from QEMU for emulated devices ;).


Alex
