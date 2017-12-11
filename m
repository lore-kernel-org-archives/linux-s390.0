From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 02/16] KVM: Prepare for moving vcpu_load/vcpu_put
 into arch specific code
Date: Mon, 11 Dec 2017 12:57:49 +0100
Message-ID: <20171211125749.445a8260.cohuck@redhat.com>
References: <20171204203538.8370-1-cdall@kernel.org>
        <20171204203538.8370-3-cdall@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171204203538.8370-3-cdall@kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christoffer Dall <cdall@kernel.org>
Cc: kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon,  4 Dec 2017 21:35:24 +0100
Christoffer Dall <cdall@kernel.org> wrote:

> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> In preparation for moving calls to vcpu_load() and vcpu_put() into the
> architecture specific implementations of the KVM vcpu ioctls, move the
> calls in the main kvm_vcpu_ioctl() dispatcher function to each case
> of the ioctl select statement.  This allows us to move the vcpu_load()
> and vcpu_put() calls into architecture specific implementations of vcpu
> ioctls, one by one.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  virt/kvm/kvm_main.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
