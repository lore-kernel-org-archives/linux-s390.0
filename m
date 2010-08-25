From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/3] S390: Add virtio hotplug add support
Date: Wed, 25 Aug 2010 10:16:30 +0200
Message-ID: <20100825081630.GE2153@osiris.boeblingen.de.ibm.com>
References: <1282657732-20902-1-git-send-email-agraf@suse.de>
 <1282657732-20902-2-git-send-email-agraf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1282657732-20902-2-git-send-email-agraf@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: virtualization@lists.linux-foundation.org, Rusty Russell <rusty@rustcorp.com.au>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Carsten Otte <carsteno@de.ibm.com>, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, KVM list <kvm@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Aug 24, 2010 at 03:48:51PM +0200, Alexander Graf wrote:
> +static void hotplug_devices(struct work_struct *dummy)
> +{
> +	unsigned int i;
> +	struct kvm_device_desc *d;
> +	struct device *dev;
> +
> +	for (i = 0; i < PAGE_SIZE; i += desc_size(d)) {

This should be 

	for (i = 0; i + desc_size(d) <= PAGE_SIZE; i += desc_size(d)) {

otherwise you might have memory accesses beyond the device page...

> +		d = kvm_devices + i;
> +
> +		/* end of list */
> +		if (d->type == 0)
> +			break;

...even if that should not happen if everything works.
But let's be paranoid.
