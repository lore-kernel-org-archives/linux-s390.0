From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v3 1/2] KVM: kvm-io: support cookies
Date: Wed,  3 Jul 2013 15:50:38 +0200
Message-ID: <1372859439-18733-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1372859439-18733-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1372859439-18733-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Add new functions kvm_io_bus_{read,write}_cookie() that allows users of
the kvm io infrastructure to use a cookie value to speed up lookup of a
device on an io bus.

kvm_io_bus_{read,write} now returns the index on the bus; existing callers
have been fixed up to accept return codes > 0.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/ia64/kvm/kvm-ia64.c   |   2 +-
 arch/powerpc/kvm/powerpc.c |   4 +-
 arch/x86/kvm/x86.c         |   6 +--
 include/linux/kvm_host.h   |   4 ++
 virt/kvm/kvm_main.c        | 102 ++++++++++++++++++++++++++++++++++++++-------
 5 files changed, 97 insertions(+), 21 deletions(-)

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
index 7d71c0f..d58744b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3860,7 +3860,7 @@ static int vcpu_mmio_write(struct kvm_vcpu *vcpu, gpa_t addr, int len,
 		n = min(len, 8);
 		if (!(vcpu->arch.apic &&
 		      !kvm_iodevice_write(&vcpu->arch.apic->dev, addr, n, v))
-		    && kvm_io_bus_write(vcpu->kvm, KVM_MMIO_BUS, addr, n, v))
+		    && (kvm_io_bus_write(vcpu->kvm, KVM_MMIO_BUS, addr, n, v) < 0))
 			break;
 		handled += n;
 		addr += n;
@@ -3880,7 +3880,7 @@ static int vcpu_mmio_read(struct kvm_vcpu *vcpu, gpa_t addr, int len, void *v)
 		n = min(len, 8);
 		if (!(vcpu->arch.apic &&
 		      !kvm_iodevice_read(&vcpu->arch.apic->dev, addr, n, v))
-		    && kvm_io_bus_read(vcpu->kvm, KVM_MMIO_BUS, addr, n, v))
+		    && (kvm_io_bus_read(vcpu->kvm, KVM_MMIO_BUS, addr, n, v) < 0))
 			break;
 		trace_kvm_mmio(KVM_TRACE_MMIO_READ, n, addr, *(u64 *)v);
 		handled += n;
@@ -4361,7 +4361,7 @@ static int kernel_pio(struct kvm_vcpu *vcpu, void *pd)
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
index 1580dd4..eca3e00 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2863,11 +2863,30 @@ static int kvm_io_bus_get_first_dev(struct kvm_io_bus *bus,
 	return off;
 }
 
+static int __kvm_io_bus_write(struct kvm_io_bus *bus,
+			      struct kvm_io_range *range, const void *val)
+{
+	int idx;
+
+	idx = kvm_io_bus_get_first_dev(bus, range->addr, range->len);
+	if (idx < 0)
+		return -EOPNOTSUPP;
+
+	while (idx < bus->dev_count &&
+		kvm_io_bus_sort_cmp(range, &bus->range[idx]) == 0) {
+		if (!kvm_iodevice_write(bus->range[idx].dev, range->addr,
+					range->len, val))
+			return idx;
+		idx++;
+	}
+
+	return -EOPNOTSUPP;
+}
+
 /* kvm_io_bus_write - called under kvm->slots_lock */
 int kvm_io_bus_write(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
 		     int len, const void *val)
 {
-	int idx;
 	struct kvm_io_bus *bus;
 	struct kvm_io_range range;
 
@@ -2877,14 +2896,51 @@ int kvm_io_bus_write(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
 	};
 
 	bus = srcu_dereference(kvm->buses[bus_idx], &kvm->srcu);
-	idx = kvm_io_bus_get_first_dev(bus, addr, len);
+	return __kvm_io_bus_write(bus, &range, val);
+}
+
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
+	return __kvm_io_bus_write(bus, &range, val);
+}
+
+static int __kvm_io_bus_read(struct kvm_io_bus *bus, struct kvm_io_range *range,
+			     void *val)
+{
+	int idx;
+
+	idx = kvm_io_bus_get_first_dev(bus, range->addr, range->len);
 	if (idx < 0)
 		return -EOPNOTSUPP;
 
 	while (idx < bus->dev_count &&
 		kvm_io_bus_sort_cmp(&range, &bus->range[idx]) == 0) {
-		if (!kvm_iodevice_write(bus->range[idx].dev, addr, len, val))
-			return 0;
+		if (!kvm_iodevice_read(bus->range[idx].dev, range->addr,
+				       range->len, val))
+			return idx;
 		idx++;
 	}
 
@@ -2895,7 +2951,6 @@ int kvm_io_bus_write(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
 int kvm_io_bus_read(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
 		    int len, void *val)
 {
-	int idx;
 	struct kvm_io_bus *bus;
 	struct kvm_io_range range;
 
@@ -2905,18 +2960,35 @@ int kvm_io_bus_read(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
 	};
 
 	bus = srcu_dereference(kvm->buses[bus_idx], &kvm->srcu);
-	idx = kvm_io_bus_get_first_dev(bus, addr, len);
-	if (idx < 0)
-		return -EOPNOTSUPP;
+	return __kvm_io_bus_read(bus, &range, val);
+}
 
-	while (idx < bus->dev_count &&
-		kvm_io_bus_sort_cmp(&range, &bus->range[idx]) == 0) {
-		if (!kvm_iodevice_read(bus->range[idx].dev, addr, len, val))
-			return 0;
-		idx++;
-	}
+/* kvm_io_bus_read_cookie - called under kvm->slots_lock */
+int kvm_io_bus_read_cookie(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
+			   int len, void *val, long cookie)
+{
+	struct kvm_io_bus *bus;
+	struct kvm_io_range range;
 
-	return -EOPNOTSUPP;
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
+	return __kvm_io_bus_read(bus, &range, val);
 }
 
 /* Caller must hold slots_lock. */
-- 
1.8.2.2
