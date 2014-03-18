From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2 3/5] KVM: s390: adapter interrupt sources
Date: Tue, 18 Mar 2014 09:11:19 +0100
Message-ID: <20140318081119.GA4311@osiris>
References: <1395079899-29239-1-git-send-email-cornelia.huck@de.ibm.com>
 <1395079899-29239-4-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1395079899-29239-4-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, pbonzini@redhat.com, gleb@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Mar 17, 2014 at 07:11:37PM +0100, Cornelia Huck wrote:
> Add a new interface to register/deregister sources of adapter interrupts
> identified by an unique id via the flic. Adapters may also be maskable
> and carry a list of pinned pages.
> 
> These adapters will be used by irq routing later.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---

[...]

> +#define MAX_S390_IO_ADAPTERS (MAX_ISC + 1) * 8

Subtle possible bug alert ;) Please add braces around (MAX_ISC + 1) * 8.
