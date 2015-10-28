From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 2/3] virtio_ring: Support DMA APIs
Date: Wed, 28 Oct 2015 17:39:43 +0900
Message-ID: <563089CF.10001@de.ibm.com>
References: <cover.1446009834.git.luto@kernel.org>
 <ef92832ae3e58afb161a92858dc8428e6a0f63b5.1446009834.git.luto@kernel.org>
 <563062B0.5070608@de.ibm.com> <1446012277.3405.179.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446012277.3405.179.camel@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>, Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <jroedel@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Am 28.10.2015 um 15:04 schrieb David Woodhouse:
> On Wed, 2015-10-28 at 14:52 +0900, Christian Borntraeger wrote:
>>            000000000059b25a: e32010200004       lg      %r2,32(%r1)
>>           #000000000059b260: e310b0a00004       lg      %r1,160(%r11)
>>           >000000000059b266: 4810100c           lh      %r1,12(%r1)
> 
> Precisely what is that? Is that loading ->archdata.dev_ops (offset 160)
> from a device and then trying to find the ->unmap_page method therein?
> 

qemu 2.4 works, and current qemu master has a broken gdb server....I am going to fix
this first.
What I can tell, that the problem goes away if I disable virtio 1.0 so I assume
that things are fine when Andy sends a v4 with the endianess fixes.

Christian
