From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [RFC PATCH 1/3] KVM: s390: Move out initialization code.
Date: Thu, 21 Feb 2013 15:56:35 +0100
Message-ID: <20130221155635.33de37b6@gondolin>
References: <1361452380-50398-1-git-send-email-cornelia.huck@de.ibm.com>
	<1361452380-50398-2-git-send-email-cornelia.huck@de.ibm.com>
	<20130221134355.GA24738@redhat.com>
	<20130221150732.1580dbd4@gondolin>
	<20130221141834.GB24738@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20130221141834.GB24738@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 21 Feb 2013 16:18:34 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Feb 21, 2013 at 03:07:32PM +0100, Cornelia Huck wrote:
> > On Thu, 21 Feb 2013 15:43:55 +0200
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > On Thu, Feb 21, 2013 at 02:12:58PM +0100, Cornelia Huck wrote:
> > > > kvm-s390's module initialization code needs to live in a separate
> > > > module (kvm-s390.ko) if we want to include eventfd (which has its
> > > > own module init func).
> > > > 
> > > > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > > 
> > > I don't get this explanation.
> > > What's the problem this solves?
> > > Could you clarify please?
> > 
> > On s390, we currently build a single 'kvm' module, with a module_init
> > function. eventfd has its own module_init function, and we can't have
> > two of them in the same module. I just moved our specific module
> > initialization into a new 'kvm_s390' module.
> 
> 
> You mean this?
> 
> virt/kvm/eventfd.c:static int __init irqfd_module_init(void)
> virt/kvm/eventfd.c:module_init(irqfd_module_init);
> 
> I see. Won't it be easier to just call irqfd_module_init
> from kvm_init?
> 
It does make it clearer what happens, and eliminates the need for a new
module on s390. I'll do that in the next round:

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index d7965fb..55a6de1 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -423,6 +423,19 @@ void kvm_vcpu_uninit(struct kvm_vcpu *vcpu);
 int __must_check vcpu_load(struct kvm_vcpu *vcpu);
 void vcpu_put(struct kvm_vcpu *vcpu);
 
+#ifdef __KVM_HAVE_IOAPIC
+int kvm_irqfd_init(void);
+void kvm_irqfd_exit(void);
+#else
+static inline int kvm_irqfd_init(void)
+{
+	return 0;
+}
+
+static inline void kvm_irqfd_exit(void)
+{
+}
+#endif
 int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
 		  struct module *module);
 void kvm_exit(void);
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 63fe454..c631c4b 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -544,7 +544,7 @@ void kvm_irq_routing_update(struct kvm *kvm,
  * aggregated from all vm* instances. We need our own isolated single-thread
  * queue to prevent deadlock against flushing the normal work-queue.
  */
-static int __init irqfd_module_init(void)
+int kvm_irqfd_init(void)
 {
 	irqfd_cleanup_wq = create_singlethread_workqueue("kvm-irqfd-cleanup");
 	if (!irqfd_cleanup_wq)
@@ -553,13 +553,10 @@ static int __init irqfd_module_init(void)
 	return 0;
 }
 
-static void __exit irqfd_module_exit(void)
+void kvm_irqfd_exit(void)
 {
 	destroy_workqueue(irqfd_cleanup_wq);
 }
-
-module_init(irqfd_module_init);
-module_exit(irqfd_module_exit);
 #endif
 
 /*
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index adc68fe..7c188a3 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2920,6 +2920,9 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
 	int r;
 	int cpu;
 
+	r = kvm_irqfd_init();
+	if (r)
+		goto out_irqfd;
 	r = kvm_arch_init(opaque);
 	if (r)
 		goto out_fail;
@@ -3000,6 +3003,8 @@ out_free_0a:
 out_free_0:
 	kvm_arch_exit();
 out_fail:
+	kvm_irqfd_exit();
+out_irqfd:
 	return r;
 }
 EXPORT_SYMBOL_GPL(kvm_init);
@@ -3016,6 +3021,7 @@ void kvm_exit(void)
 	on_each_cpu(hardware_disable_nolock, NULL, 1);
 	kvm_arch_hardware_unsetup();
 	kvm_arch_exit();
+	kvm_irqfd_exit();
 	free_cpumask_var(cpus_hardware_enabled);
 }
 EXPORT_SYMBOL_GPL(kvm_exit);
