From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC 00/19] KVM: s390/crypto/vfio: guest dedicated crypto
 adapters
Date: Wed, 18 Oct 2017 18:43:58 +0200
Message-ID: <efa05ec7-81e0-eb3d-535b-65c6ca8308cc@de.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

As a remark. I think it makes more sense to concentrate on the whole concept 
before doing an depth review (of course, if you have the cycles - feel free
to go ahead :-) ).
Let me just summarize the HW idea in a very simplified fashion, so that we can
try to let everybody understand what is going on here.

Implementation-wise (in LPAR and as supported by the HW-virtualization for KVM) the 
implementation itself is really really simple. As a satellite block of the
state descriptor (sie control block) there is the crypto control block.
(usually one per guest). This contains 3 256bit bitfields which allow/disallow
1. adapters by number (0-255)
2. usage domains by number (0-255)
3. control domains by number (0-255)

For simplicity lets ignore the control domains, the mechanism is similar to
the usage domain.

The guest will then have access to ALL elements of the cross product.
So adapter 1,2,3 and domain 10,11,12 will result in 9 tuples accessible by 
the guest (1,10) ; (1,11) ; (1,12) ; (2,10) ; (2,11) ; (2,12) ; (3,10) ;
(3,11) ; (3,12)
the admin (or the management instance) must ensure that each tuple
is only in use by 1 guest.
Setting the bits is basically all what is needed (plus some minimal glue
and handling), everything else will be handled by hardware/firmware.

Now if we do not need to care about security, we could just use some kvm
ioctl and be done with it. As we learned for PCI, this is not going to be
secure as qemu is untrusted in svirt/appamor contexts.

So this is basically using vfio and mdev as a means to orchestrate things.
And this is where things get complicated and multiple options are possible.

Christian
