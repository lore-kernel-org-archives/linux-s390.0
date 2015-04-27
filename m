From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 15/17] target-s390x: Extend arch
 specific QMP command query-cpu-definitions
Date: Mon, 27 Apr 2015 12:29:23 +0200
Message-ID: <20150427122923.490287f0@bee>
References: <1428933396-37887-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1428933396-37887-16-git-send-email-mimu@linux.vnet.ibm.com>
	<553DEF31.5070803@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <553DEF31.5070803@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Andreas Faerber <afaerber@suse.de>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 27 Apr 2015 10:11:29 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> > This patch implements the QMP command 'query-cpu-definitions' in the S390
> > context. The command returns a list of cpu definitions in the current host
> > context. A runnable and migratable cpu model has the related attributes
> > set to true. The order attribute is used to bring the listed cpu definitions
> > in a release order.  
> 
> Can you add some explanation why we need the fallback code (e.g. something
> along the line, when querying no KVM guest is available and to query the
> capabilities we have to open a dummy VM bla bla)

Maybe something like that:

The returned values for attributes like runnable depend on the machine type QEMU is running on.
The function kvm_s390_get_machine_props() is used to determine that. If QEMU was started for
accelerator KVM, a KVMstate is established and machine properties are retrieved by
cpu_model_get(). In case no KVMstate was established, e.g. during QEMU startup in daemonized mode
with the default accelerator TCG, a fallback routine named get_machine_props_fallback() is used
to retrieve the KVM machine properties. It first creates a temporary VM, performs the required
ioctls and finally destroys the VM again.

Michael
