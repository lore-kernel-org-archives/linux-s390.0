From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 11/15] target-s390x: New QMP command
 query-cpu-model
Date: Wed, 1 Apr 2015 21:10:32 +0200
Message-ID: <20150401211032.7034bad3@bee>
References: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1427725708-52100-12-git-send-email-mimu@linux.vnet.ibm.com>
	<20150331183526.GJ7031@thinpad.lan.raisama.net>
	<20150331220909.4410e8c0@bee>
	<20150401130113.GL7031@thinpad.lan.raisama.net>
	<20150401183123.7a1f9d6c@bee>
	<20150401165905.GM7031@thinpad.lan.raisama.net>
	<20150401210531.57d2ea98@bee>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150401210531.57d2ea98@bee>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 1 Apr 2015 21:05:31 +0200
Michael Mueller <mimu@linux.vnet.ibm.com> wrote:

> And cpu model "none" just means that QEMU does not manage the cpu model. That's also
> the reason why I initially returned an empty "[]" model and not "none". This somewhat
> convinces me to go back to this approach...

And for query-cpus that can be represented as a non-existent model field:

[{"current":true,"CPU":0,"halted":false,"thread_id":39110}, ...]
