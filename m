From: Sasha Levin <sasha.levin@oracle.com>
Subject: Re: [PATCH v4 3/6] KVM: Initialize irqfd from kvm_init().
Date: Tue, 02 Apr 2013 20:40:53 -0400
Message-ID: <515B7A95.6020800@oracle.com>
References: <1362043352-56889-1-git-send-email-cornelia.huck@de.ibm.com> <1362043352-56889-4-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1362043352-56889-4-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
List-ID: <linux-s390.vger.kernel.org>

On 02/28/2013 04:22 AM, Cornelia Huck wrote:
> Currently, eventfd introduces module_init/module_exit functions
> to initialize/cleanup the irqfd workqueue. This only works, however,
> if no other module_init/module_exit functions are built into the
> same module.
> 
> Let's just move the initialization and cleanup to kvm_init and kvm_exit.
> This way, it is also clearer where kvm startup may fail.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

I'm seeing this during boot:

[    6.763302] ------------[ cut here ]------------
[    6.763763] WARNING: at kernel/workqueue.c:4204 destroy_workqueue+0x1df/0x3d0()
[    6.764507] Modules linked in:
[    6.764792] Pid: 1, comm: swapper/0 Tainted: G        W    3.9.0-rc5-next-20130402-sasha-00015-g3522ec5 #324
[    6.765654] Call Trace:
[    6.765875]  [<ffffffff811074fb>] warn_slowpath_common+0x8b/0xc0
[    6.766436]  [<ffffffff81107545>] warn_slowpath_null+0x15/0x20
[    6.766947]  [<ffffffff8112ca7f>] destroy_workqueue+0x1df/0x3d0
[    6.768631]  [<ffffffff8100d880>] kvm_irqfd_exit+0x10/0x20
[    6.770000]  [<ffffffff81004dbb>] kvm_init+0x2ab/0x310
[    6.770607]  [<ffffffff86183dc0>] ? cpu_has_kvm_support+0x4d/0x4d
[    6.771241]  [<ffffffff86183fb4>] vmx_init+0x1f4/0x437
[    6.771709]  [<ffffffff86183dc0>] ? cpu_has_kvm_support+0x4d/0x4d
[    6.772266]  [<ffffffff810020f2>] do_one_initcall+0xb2/0x1b0
[    6.772995]  [<ffffffff86180021>] kernel_init_freeable+0x15d/0x1ef
[    6.773857]  [<ffffffff8617f801>] ? loglevel+0x31/0x31
[    6.774609]  [<ffffffff83d51230>] ? rest_init+0x140/0x140
[    6.775551]  [<ffffffff83d51239>] kernel_init+0x9/0xf0
[    6.776162]  [<ffffffff83dbf37c>] ret_from_fork+0x7c/0xb0
[    6.776662]  [<ffffffff83d51230>] ? rest_init+0x140/0x140
[    6.777241] ---[ end trace 10bba684ced4346a ]---

And I think it has something to do with this patch.


Thanks,
Sasha
