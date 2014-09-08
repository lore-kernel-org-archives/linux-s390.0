From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC][patch 0/6] pci pass-through support for qemu/KVM on s390
Date: Mon, 08 Sep 2014 08:19:32 -0600
Message-ID: <1410185972.2982.136.camel@ul30vt.home>
References: <20140904105223.336503578@de.ibm.com> <54097287.1000006@suse.de>
	 <20140905113954.GB17325@tuxmaker.boeblingen.de.ibm.com>
	 <540A44F2.3040803@suse.de> <540D74F9.50903@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <540D74F9.50903@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Frank Blaschka <blaschka@linux.vnet.ibm.com>, frank.blaschka@de.ibm.com, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, aik@ozlabs.ru
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2014-09-08 at 11:20 +0200, Paolo Bonzini wrote:
> Il 06/09/2014 01:19, Alexander Graf ha scritto:
> >> > 1) interpretive execution of pci load/store instruction. If we use this function
> >> >    pci access does not get intercepted (no SIE exit) but is handled via microcode.
> >> >    To enable this we have to disable zpci device and enable it again with information
> >> >    from the SIE control block.
> > Hrm. So how about you create a special vm ioctl for KVM that allows you
> > to attach a VFIO device fd into the KVM VM context? Then the default
> > would stay "accessible by mmap traps", but we could accelerate it with KVM.
> 
> There is already KVM_DEV_VFIO_GROUP_ADD and KVM_DEV_VFIO_GROUP_DEL.
> 
> Right now, they result in a call to kvm_arch_register_noncoherent_dma or
> kvm_arch_unregister_noncoherent_dma, but you can add more hooks.

Eric Auger is also working on a patch series to do IRQ forward control
on ARM via the kvm-vfio pseudo device, extending the interface to
register VFIO device fds.  Sounds like that may be a good path to follow
here too.  Thanks,

Alex
