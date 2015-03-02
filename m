From: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v3 00/16] s390x cpu model implementation
Date: Mon, 2 Mar 2015 16:25:42 -0300
Message-ID: <20150302192542.GL3513@thinpad.lan.raisama.net>
References: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Mar 02, 2015 at 01:43:52PM +0100, Michael Mueller wrote:
[...]
> 
> What's currently a little bit unclear to me is how to best initialize the
> various accelerators for machine 'none'. I played around with different
> options and finally came up with the following sugguestion:
> 
> Introduce a QEMU "probe mode" that gets entered in case the current machine
> is "none" and no specific accelerator is requested on the cmd line. When
> in that mode, loop trough a list of acellerators in configure_accelerator
> and invoke all their init methods once. The last accelerator to init shall
> be tcg.
> 
> In cpu model context that allows to initialize the S390 CPU classes for
> each single accelertor which supports it. Whence the callback for
> qemu-cpu-definitions allows to populate its answer string according to the
> above sketched extended CpuDefinitionInfo type for multiplaccelerators. 

To initialize the various accelereators, you should just be able to
create temporary QOM accelerators on the fly, when you need them. That
was the whole point of the conversion of accelerators to QOM.

So we shouldn't need any special probe mode as long as: 1) all
accelerators don't do anything destructive (that affects global QEMU
state) in their instance_init functions; 2) the probing code simply
creates the accel objects when needed, query for information, and then
destroy them.

-- 
Eduardo
