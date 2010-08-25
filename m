From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 2/3] S390: Add virtio hotplug add support
Date: Wed, 25 Aug 2010 10:20:03 +0200
Message-ID: <FA6CB344-B4ED-45C1-8478-367038F5F95F@suse.de>
References: <1282657732-20902-1-git-send-email-agraf@suse.de> <1282657732-20902-2-git-send-email-agraf@suse.de> <20100825081630.GE2153@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20100825081630.GE2153@osiris.boeblingen.de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: virtualization@lists.linux-foundation.org, Rusty Russell <rusty@rustcorp.com.au>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Carsten Otte <carsteno@de.ibm.com>, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, KVM list <kvm@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>


On 25.08.2010, at 10:16, Heiko Carstens wrote:

> On Tue, Aug 24, 2010 at 03:48:51PM +0200, Alexander Graf wrote:
>> +static void hotplug_devices(struct work_struct *dummy)
>> +{
>> +	unsigned int i;
>> +	struct kvm_device_desc *d;
>> +	struct device *dev;
>> +
>> +	for (i = 0; i < PAGE_SIZE; i += desc_size(d)) {
> 
> This should be 
> 
> 	for (i = 0; i + desc_size(d) <= PAGE_SIZE; i += desc_size(d)) {
> 
> otherwise you might have memory accesses beyond the device page...

Oh, this is a simple copy&paste from the original search method. Is d valid in the first part of the loop already?

> 
>> +		d = kvm_devices + i;
>> +
>> +		/* end of list */
>> +		if (d->type == 0)
>> +			break;
> 
> ...even if that should not happen if everything works.
> But let's be paranoid.

Yeah :). I like paranoid.


Alex
