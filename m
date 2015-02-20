From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 10/15] cpu-model/s390: Add cpu class
 initialization routines
Date: Fri, 20 Feb 2015 17:27:27 +0100
Message-ID: <20150220172727.5ab559f4@bee>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1424183053-4310-11-git-send-email-mimu@linux.vnet.ibm.com>
	<54E75AA2.9070503@twiddle.net>
	<20150220171249.210a0236@bee>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150220171249.210a0236@bee>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>
Cc: Richard Henderson <rth@twiddle.net>, linux-s390@vger.kernel.org, frank.blaschka@de.ibm.com, kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 20 Feb 2015 17:12:49 +0100
Michael Mueller <mimu@linux.vnet.ibm.com> wrote:

> Good spot, it's not being used yet. It's planned to be used with a patch that implements zPCI
> related instructions on QEMU side. Maybe you have seen the discussion from Frank Blaschka in
> this e-mail list in regard to that.

I will factor it out.
