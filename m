From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 1/2] KVM: kvm-io: support cookies
Date: Wed, 3 Jul 2013 13:45:15 +0200
Message-ID: <20130703134515.0b5095b9@gondolin>
References: <1372841780-29645-1-git-send-email-cornelia.huck@de.ibm.com>
	<1372841780-29645-2-git-send-email-cornelia.huck@de.ibm.com>
	<51D3E96E.5080405@redhat.com>
	<51D3ED13.2020408@redhat.com>
	<20130703125138.400ac1ef@gondolin>
	<51D403B8.5040002@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <51D403B8.5040002@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 03 Jul 2013 12:58:00 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> Il 03/07/2013 12:51, Cornelia Huck ha scritto:
> > On Wed, 03 Jul 2013 11:21:23 +0200
> > Paolo Bonzini <pbonzini@redhat.com> wrote:
> > 
> >> Il 03/07/2013 11:05, Paolo Bonzini ha scritto:
> >>> Nice idea, though I don't really like the duplication between
> >>> kvm_io_bus_write and kvm_io_bus_write_cookie.
> >>>
> >>> Can you make kvm_io_bus_write, and perhaps kvm_io_bus_read too, return
> >>> the cookie, and return -EINVAL here if the cookie is garbage?
> >>
> >> On second though---no need to return -EINVAL, you can just pass the
> >> cookie by value and tail-call kvm_io_bus_write.  Whatever makes the s390
> >> code look nicer.
> > 
> > It would probably be easier to have the non-cookie functions call the
> > cookie functions with a negative cookie value, like the following
> > (untested):
> 
> That would work too, but it adds a small overhead to the non-cookie
> calls.  If Gleb agrees with you, it is fine; otherwise, I'd prefer that
> one explicitly requests the cookie on input.

Just to compare, I also did a patch that returns the index instead
(equally untested). Changing the callers was straightforward; we gain
an extra scu_dereference() in the invalid cookie case.

From ff45cdc27e47020251f0100759adf372c19a29c4 Mon Sep 17 00:00:00 2001
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue, 2 Jul 2013 13:30:56 +0200
Subject: [PATCH 1/2] KVM: kvm-io: support cookies

Add new functions kvm_io_bus_{read,write}_cookie() that allows users of
the kvm io infrastructure to use a cookie value to speed up lookup of a
device on an io bus.

kvm_io_bus_{read,write} now returns the index on the bus; existing callers
have been fixed up to accept return codes > 0.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/ia64/kvm/kvm-ia64.c   |  2 +-
 arch/powerpc/kvm/powerpc.c |  4 ++--
 arch/x86/kvm/x86.c         |  8 ++++---
 include/linux/kvm_host.h   |  4 ++++
 virt/kvm/kvm_main.c        | 58 +++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/arch/ia64/kvm/kvm-ia64.c b/arch/ia64/kvm/kvm-ia64.c
index 5b2dc0d..465ab54 100644
--- a/arch/ia64/kvm/kvm-ia64.c
+++ b/arch/ia64/kvm/kvm-ia64.c
@@ -250,7 +250,7 @@ mmio:
 	else
 		r = kvm_io_bus_write(vcpu->kvm, KVM_MMIO_BUS, p->addr,
 				     p->size, &p->data);
-	if (r)
+	if (r < 0)
 		printk(KERN_ERR"kvm: No iodevice found! addr:%lx\n", p->addr);
 	p->state = STATE_IORESP_READY;
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 6316ee3..26c44d0 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -649,7 +649,7 @@ int kvmppc_handle_load(struct kvm_run *run, struct kvm_vcpu *vcpu,
 
 	srcu_read_unlock(&vcpu->kvm->srcu, idx);
 
-	if (!ret) {
+	if (ret >= 0) {
 		kvmppc_complete_mmio_load(vcpu, run);
 		vcpu->mmio_needed = 0;
 		return EMULATE_DONE;
@@ -711,7 +711,7 @@ int kvmppc_handle_store(struct kvm_run *run, struct kvm_vcpu *vcpu,
 
 	srcu_read_unlock(&vcpu->kvm->srcu, idx);
 
-	if (!ret) {
+	if (ret >= 0) {
 		vcpu->mmio_needed = 0;
 		return EMULATE_DONE;
 	}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7d71c0f..62b325c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3860,7 +3860,8 @@ static int vcpu_mmio_write(struct kvm_vcpu *vcpu, gpa_t addr, int len,
 		n = min(len, 8);
 		if (!(vcpu->arch.apic &&
 		      !kvm_iodevice_write(&vcpu->arch.apic->dev, addr, n, v))
-		    && kvm_io_bus_write(vcpu->kvm, KVM_MMIO_BUS, addr, n, v))
+		    && (kvm_io_bus_write(vcpu->kvm, KVM_MMIO_BUS, addr, n, v)
+			< 0))
 			break;
 		handled += n;
 		addr += n;
@@ -3880,7 +3881,8 @@ static int vcpu_mmio_read(struct kvm_vcpu *vcpu, gpa_t addr, int len, void *v)
 		n = min(len, 8);
 		if (!(vcpu->arch.apic &&
 		      !kvm_iodevice_read(&vcpu->arch.apic->dev, addr, n, v))
-		    && kvm_io_bus_read(vcpu->kvm, KVM_MMIO_BUS, addr, n, v))
+		    && (kvm_io_bus_read(vcpu->kvm, KVM_MMIO_BUS, addr, n, v)
+			< 0))
 			break;
 		trace_kvm_mmio(KVM_TRACE_MMIO_READ, n, addr, *(u64 *)v);
 		handled += n;
@@ -4361,7 +4363,7 @@ static int kernel_pio(struct kvm_vcpu *vcpu, void *pd)
 		r = kvm_io_bus_write(vcpu->kvm, KVM_PIO_BUS,
 				     vcpu->arch.pio.port, vcpu->arch.pio.size,
 				     pd);
-	return r;
+	return (r >= 0) ? 0 : r;
 }
 
 static int emulator_pio_in_out(struct kvm_vcpu *vcpu, int size,
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e3aae6d..60e261c9 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -159,8 +159,12 @@ enum kvm_bus {
 
 int kvm_io_bus_write(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
 		     int len, const void *val);
+int kvm_io_bus_write_cookie(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
+			    int len, const void *val, long cookie);
 int kvm_io_bus_read(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr, int len,
 		    void *val);
+int kvm_io_bus_read_cookie(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
+			   int len, void *val, long cookie);
 int kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
 			    int len, struct kvm_io_device *dev);
 int kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1580dd4..ed34f10 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2884,13 +2884,41 @@ int kvm_io_bus_write(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
 	while (idx < bus->dev_count &&
 		kvm_io_bus_sort_cmp(&range, &bus->range[idx]) == 0) {
 		if (!kvm_iodevice_write(bus->range[idx].dev, addr, len, val))
-			return 0;
+			return idx;
 		idx++;
 	}
 
 	return -EOPNOTSUPP;
 }
 
+/* kvm_io_bus_write_cookie - called under kvm->slots_lock */
+int kvm_io_bus_write_cookie(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
+			    int len, const void *val, long cookie)
+{
+	struct kvm_io_bus *bus;
+	struct kvm_io_range range;
+
+	range = (struct kvm_io_range) {
+		.addr = addr,
+		.len = len,
+	};
+
+	bus = srcu_dereference(kvm->buses[bus_idx], &kvm->srcu);
+
+	/* First try the device referenced by cookie. */
+	if ((cookie >= 0) && (cookie < bus->dev_count) &&
+	    (kvm_io_bus_sort_cmp(&range, &bus->range[cookie]) == 0))
+		if (!kvm_iodevice_write(bus->range[cookie].dev, addr, len,
+					val))
+			return cookie;
+
+	/*
+	 * cookie contained garbage; fall back to search and return the
+	 * correct cookie value.
+	 */
+	return kvm_io_bus_write(kvm, bus_idx, addr, len, val);
+}
+
 /* kvm_io_bus_read - called under kvm->slots_lock */
 int kvm_io_bus_read(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
 		    int len, void *val)
@@ -2919,6 +2947,34 @@ int kvm_io_bus_read(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
 	return -EOPNOTSUPP;
 }
 
+/* kvm_io_bus_read_cookie - called under kvm->slots_lock */
+int kvm_io_bus_read_cookie(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
+			   int len, void *val, long cookie)
+{
+	struct kvm_io_bus *bus;
+	struct kvm_io_range range;
+
+	range = (struct kvm_io_range) {
+		.addr = addr,
+		.len = len,
+	};
+
+	bus = srcu_dereference(kvm->buses[bus_idx], &kvm->srcu);
+
+	/* First try the device referenced by cookie. */
+	if ((cookie >= 0) && (cookie < bus->dev_count) &&
+	    (kvm_io_bus_sort_cmp(&range, &bus->range[cookie]) == 0))
+		if (!kvm_iodevice_read(bus->range[cookie].dev, addr, len,
+				       val))
+			return cookie;
+
+	/*
+	 * cookie contained garbage; fall back to search and return the
+	 * correct cookie value.
+	 */
+	return kvm_io_bus_read(kvm, bus_idx, addr, len, val);
+}
+
 /* Caller must hold slots_lock. */
 int kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
 			    int len, struct kvm_io_device *dev)
-- 
1.8.2.2
