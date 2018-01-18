From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2] KVM: s390: wire up bpb feature
Date: Thu, 18 Jan 2018 10:59:16 +0100
Message-ID: <20180118105916.68a1586c.cohuck@redhat.com>
References: <1516182519-10623-6-git-send-email-schwidefsky@de.ibm.com>
        <20180117134434.48676-1-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117134434.48676-1-borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 17 Jan 2018 14:44:34 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> The new firmware interfaces for branch prediction behaviour changes
> are transparently available for the guest. Nevertheless, there is
> new state attached that should be migrated and properly resetted.
> Provide a mechanism for handling reset, migration and VSIE.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
> v1->v2: - review feedback from David
> 	- rename seb(c) into bpb(c)
>  arch/s390/include/asm/kvm_host.h |  3 ++-
>  arch/s390/include/uapi/asm/kvm.h |  5 ++++-
>  arch/s390/kvm/kvm-s390.c         | 12 ++++++++++++
>  arch/s390/kvm/vsie.c             | 10 ++++++++++
>  include/uapi/linux/kvm.h         |  1 +
>  5 files changed, 29 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

But I'd like to see some documentation (a line) for the new cap under
Documentation/. However, this can be done as a separate update (we
might be missing more).
