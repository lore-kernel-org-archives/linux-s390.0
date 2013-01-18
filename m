From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 01/12] s390: Add a hypercall registration interface.
Date: Fri, 18 Jan 2013 17:51:39 +0100
Message-ID: <0FF3D242-AA94-443D-AC16-6EEA9BDBA427@suse.de>
References: <1358432637-42512-1-git-send-email-cornelia.huck@de.ibm.com> <1358432637-42512-2-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1358432637-42512-2-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 17.01.2013, at 15:23, Cornelia Huck wrote:

> Allow virtio machines to register for different diag500 function
> codes and convert s390-virtio to use it.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

Thanks, applied to s390-next.

Alex
