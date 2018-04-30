From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Date: Mon, 30 Apr 2018 16:33:25 +0000
Subject: [PATCH v5 2/2] KVM: s390: Fix storage attributes migration with memory slots
Message-Id: <1525106005-13931-3-git-send-email-imbrenda@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is a fix for several issues that were found in the original code
for storage attributes migration.

Now no bitmap is allocated to keep track of dirty storage attributes;
the extra bits of the per-memslot bitmap that are always present anyway
are now used for this purpose.

The code has also been refactored a little to improve readability.

Fixes: 190df4a212a ("KVM: s390: CMMA tracking, ESSA emulation, migration mode")
Fixes: 4036e3874a1 ("KVM: s390: ioctls to get and set guest storage attributes")
Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |   9 +-
 arch/s390/kvm/kvm-s390.c         | 293 +++++++++++++++++++++++----------------
 arch/s390/kvm/priv.c             |  28 ++--
 3 files changed, 195 insertions(+), 135 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 81cdb6b..f548419 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -793,12 +793,6 @@ struct kvm_s390_vsie {
 	struct page *pages[KVM_MAX_VCPUS];
 };
 
-struct kvm_s390_migration_state {
-	unsigned long bitmap_size;	/* in bits (number of guest pages) */
-	atomic64_t dirty_pages;		/* number of dirty pages */
-	unsigned long *pgste_bitmap;
-};
-
 struct kvm_arch{
 	void *sca;
 	int use_esca;
@@ -827,7 +821,8 @@ struct kvm_arch{
 	struct kvm_s390_vsie vsie;
 	u8 epdx;
 	u64 epoch;
-	struct kvm_s390_migration_state *migration_state;
+	int migration_mode;
+	atomic64_t cmma_dirty_pages;
 	/* subset of available cpu features enabled by user space */
 	DECLARE_BITMAP(cpu_feat, KVM_S390_VM_CPU_FEAT_NR_BITS);
 	struct kvm_s390_gisa *gisa;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 64c9862..9bb4d7e 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -855,54 +855,37 @@ static void kvm_s390_sync_request_broadcast(struct kvm *kvm, int req)
  */
 static int kvm_s390_vm_start_migration(struct kvm *kvm)
 {
-	struct kvm_s390_migration_state *mgs;
 	struct kvm_memory_slot *ms;
-	/* should be the only one */
 	struct kvm_memslots *slots;
-	unsigned long ram_pages;
+	unsigned long ram_pages = 0;
 	int slotnr;
 
 	/* migration mode already enabled */
-	if (kvm->arch.migration_state)
+	if (kvm->arch.migration_mode)
 		return 0;
-
 	slots = kvm_memslots(kvm);
 	if (!slots || !slots->used_slots)
 		return -EINVAL;
 
-	mgs = kzalloc(sizeof(*mgs), GFP_KERNEL);
-	if (!mgs)
-		return -ENOMEM;
-	kvm->arch.migration_state = mgs;
-
-	if (kvm->arch.use_cmma) {
+	if (!kvm->arch.use_cmma) {
+		kvm->arch.migration_mode = 1;
+		return 0;
+	}
+	/* mark all the pages in active slots as dirty */
+	for (slotnr = 0; slotnr < slots->used_slots; slotnr++) {
+		ms = slots->memslots + slotnr;
 		/*
-		 * Get the first slot. They are reverse sorted by base_gfn, so
-		 * the first slot is also the one at the end of the address
-		 * space. We have verified above that at least one slot is
-		 * present.
+		 * The second half of the bitmap is only used on x86,
+		 * and would be wasted otherwise, so we put it to good
+		 * use here to keep track of the state of the storage
+		 * attributes.
 		 */
-		ms = slots->memslots;
-		/* round up so we only use full longs */
-		ram_pages = roundup(ms->base_gfn + ms->npages, BITS_PER_LONG);
-		/* allocate enough bytes to store all the bits */
-		mgs->pgste_bitmap = vmalloc(ram_pages / 8);
-		if (!mgs->pgste_bitmap) {
-			kfree(mgs);
-			kvm->arch.migration_state = NULL;
-			return -ENOMEM;
-		}
-
-		mgs->bitmap_size = ram_pages;
-		atomic64_set(&mgs->dirty_pages, ram_pages);
-		/* mark all the pages in active slots as dirty */
-		for (slotnr = 0; slotnr < slots->used_slots; slotnr++) {
-			ms = slots->memslots + slotnr;
-			bitmap_set(mgs->pgste_bitmap, ms->base_gfn, ms->npages);
-		}
-
-		kvm_s390_sync_request_broadcast(kvm, KVM_REQ_START_MIGRATION);
+		memset(kvm_second_dirty_bitmap(ms), 0xff, kvm_dirty_bitmap_bytes(ms));
+		ram_pages += ms->npages;
 	}
+	atomic64_set(&kvm->arch.cmma_dirty_pages, ram_pages);
+	kvm->arch.migration_mode = 1;
+	kvm_s390_sync_request_broadcast(kvm, KVM_REQ_START_MIGRATION);
 	return 0;
 }
 
@@ -912,21 +895,12 @@ static int kvm_s390_vm_start_migration(struct kvm *kvm)
  */
 static int kvm_s390_vm_stop_migration(struct kvm *kvm)
 {
-	struct kvm_s390_migration_state *mgs;
-
 	/* migration mode already disabled */
-	if (!kvm->arch.migration_state)
+	if (!kvm->arch.migration_mode)
 		return 0;
-	mgs = kvm->arch.migration_state;
-	kvm->arch.migration_state = NULL;
-
-	if (kvm->arch.use_cmma) {
+	kvm->arch.migration_mode = 0;
+	if (kvm->arch.use_cmma)
 		kvm_s390_sync_request_broadcast(kvm, KVM_REQ_STOP_MIGRATION);
-		/* We have to wait for the essa emulation to finish */
-		synchronize_srcu(&kvm->srcu);
-		vfree(mgs->pgste_bitmap);
-	}
-	kfree(mgs);
 	return 0;
 }
 
@@ -954,7 +928,7 @@ static int kvm_s390_vm_set_migration(struct kvm *kvm,
 static int kvm_s390_vm_get_migration(struct kvm *kvm,
 				     struct kvm_device_attr *attr)
 {
-	u64 mig = (kvm->arch.migration_state != NULL);
+	u64 mig = kvm->arch.migration_mode;
 
 	if (attr->attr != KVM_S390_VM_MIGRATION_STATUS)
 		return -ENXIO;
@@ -1596,6 +1570,134 @@ static long kvm_s390_set_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
 #define KVM_S390_CMMA_SIZE_MAX ((u32)KVM_S390_SKEYS_MAX)
 
 /*
+ * Similar to gfn_to_memslot, but returns the index of a memslot also when the
+ * address falls in a hole. In that case the index of one of the memslots
+ * bordering the hole is returned.
+ */
+static int gfn_to_memslot_approx(struct kvm_memslots *slots, gfn_t gfn)
+{
+	int start = 0, end = slots->used_slots;
+	int slot = atomic_read(&slots->lru_slot);
+	struct kvm_memory_slot *memslots = slots->memslots;
+
+	if (gfn >= memslots[slot].base_gfn &&
+	    gfn < memslots[slot].base_gfn + memslots[slot].npages)
+		return slot;
+
+	while (start < end) {
+		slot = start + (end - start) / 2;
+
+		if (gfn >= memslots[slot].base_gfn)
+			end = slot;
+		else
+			start = slot + 1;
+	}
+
+	if (gfn >= memslots[start].base_gfn &&
+	    gfn < memslots[start].base_gfn + memslots[start].npages) {
+		atomic_set(&slots->lru_slot, start);
+	}
+
+	return start;
+}
+
+static int kvm_s390_peek_cmma(struct kvm *kvm, struct kvm_s390_cmma_log *args,
+			      u8 *res, unsigned long bufsize)
+{
+	unsigned long pgstev, hva, cur_gfn = args->start_gfn;
+
+	args->count = 0;
+	while (args->count < bufsize) {
+		hva = gfn_to_hva(kvm, cur_gfn);
+		/*
+		 * We return an error if the first value was invalid, but we
+		 * return successfully if at least one value was copied.
+		 */
+		if (kvm_is_error_hva(hva))
+			return args->count ? 0 : -EFAULT;
+		if (get_pgste(kvm->mm, hva, &pgstev) < 0)
+			pgstev = 0;
+		res[args->count++] = (pgstev >> 24) & 0x43;
+		cur_gfn++;
+	}
+
+	return 0;
+}
+
+static unsigned long kvm_s390_next_dirty_cmma(struct kvm_memslots *slots,
+					      unsigned long cur_gfn)
+{
+	int slotidx = gfn_to_memslot_approx(slots, cur_gfn);
+	struct kvm_memory_slot *ms = slots->memslots + slotidx;
+	unsigned long ofs = cur_gfn - ms->base_gfn;
+
+	if (ms->base_gfn + ms->npages <= cur_gfn) {
+		slotidx--;
+		/* If we are above the highest slot, wrap around */
+		if (slotidx < 0)
+			slotidx = slots->used_slots - 1;
+
+		ms = slots->memslots + slotidx;
+		ofs = 0;
+	}
+	ofs = find_next_bit(kvm_second_dirty_bitmap(ms), ms->npages, ofs);
+	while ((slotidx > 0) && (ofs >= ms->npages)) {
+		slotidx--;
+		ms = slots->memslots + slotidx;
+		ofs = find_next_bit(kvm_second_dirty_bitmap(ms), ms->npages, 0);
+	}
+	return ms->base_gfn + ofs;
+}
+
+static int kvm_s390_get_cmma(struct kvm *kvm, struct kvm_s390_cmma_log *args,
+			     u8 *res, unsigned long bufsize)
+{
+	unsigned long mem_end, cur_gfn, next_gfn, hva, pgstev;
+	struct kvm_memslots *slots = kvm_memslots(kvm);
+	struct kvm_memory_slot *ms;
+
+	cur_gfn = kvm_s390_next_dirty_cmma(slots, args->start_gfn);
+	ms = gfn_to_memslot(kvm, cur_gfn);
+	args->count = 0;
+	args->start_gfn = cur_gfn;
+	if (!ms)
+		return 0;
+	next_gfn = kvm_s390_next_dirty_cmma(slots, cur_gfn + 1);
+	mem_end = slots->memslots[0].base_gfn + slots->memslots[0].npages;
+
+	while (args->count < bufsize) {
+		hva = gfn_to_hva(kvm, cur_gfn);
+		if (kvm_is_error_hva(hva))
+			return 0;
+		/* Decrement only if we actually flipped the bit to 0 */
+		if (test_and_clear_bit(cur_gfn - ms->base_gfn, kvm_second_dirty_bitmap(ms)))
+			atomic64_dec(&kvm->arch.cmma_dirty_pages);
+		if (get_pgste(kvm->mm, hva, &pgstev) < 0)
+			pgstev = 0;
+		/* Save the value */
+		res[args->count++] = (pgstev >> 24) & 0x43;
+		/* If the next bit is too far away, stop. */
+		if (next_gfn > cur_gfn + KVM_S390_MAX_BIT_DISTANCE)
+			return 0;
+		/* If we reached the previous "next", find the next one */
+		if (cur_gfn == next_gfn)
+			next_gfn = kvm_s390_next_dirty_cmma(slots, cur_gfn + 1);
+		/* Reached the end of memory or of the buffer, stop */
+		if ((next_gfn >= mem_end) ||
+		    (next_gfn - args->start_gfn >= bufsize))
+			return 0;
+		cur_gfn++;
+		/* Reached the end of the current memslot, take the next one. */
+		if (cur_gfn - ms->base_gfn >= ms->npages) {
+			ms = gfn_to_memslot(kvm, cur_gfn);
+			if (!ms)
+				return 0;
+		}
+	}
+	return 0;
+}
+
+/*
  * This function searches for the next page with dirty CMMA attributes, and
  * saves the attributes in the buffer up to either the end of the buffer or
  * until a block of at least KVM_S390_MAX_BIT_DISTANCE clean bits is found;
@@ -1606,22 +1708,18 @@ static long kvm_s390_set_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
 static int kvm_s390_get_cmma_bits(struct kvm *kvm,
 				  struct kvm_s390_cmma_log *args)
 {
-	struct kvm_s390_migration_state *s = kvm->arch.migration_state;
-	unsigned long bufsize, hva, pgstev, i, next, cur;
-	int srcu_idx, peek, r = 0, rr;
-	u8 *res;
-
-	cur = args->start_gfn;
-	i = next = pgstev = 0;
+	unsigned long bufsize;
+	int srcu_idx, peek, ret;
+	u8 *values;
 
-	if (unlikely(!kvm->arch.use_cmma))
+	if (!kvm->arch.use_cmma)
 		return -ENXIO;
 	/* Invalid/unsupported flags were specified */
 	if (args->flags & ~KVM_S390_CMMA_PEEK)
 		return -EINVAL;
 	/* Migration mode query, and we are not doing a migration */
 	peek = !!(args->flags & KVM_S390_CMMA_PEEK);
-	if (!peek && !s)
+	if (!peek && !kvm->arch.migration_mode)
 		return -EINVAL;
 	/* CMMA is disabled or was not used, or the buffer has length zero */
 	bufsize = min(args->count, KVM_S390_CMMA_SIZE_MAX);
@@ -1629,74 +1727,35 @@ static int kvm_s390_get_cmma_bits(struct kvm *kvm,
 		memset(args, 0, sizeof(*args));
 		return 0;
 	}
-
-	if (!peek) {
-		/* We are not peeking, and there are no dirty pages */
-		if (!atomic64_read(&s->dirty_pages)) {
-			memset(args, 0, sizeof(*args));
-			return 0;
-		}
-		cur = find_next_bit(s->pgste_bitmap, s->bitmap_size,
-				    args->start_gfn);
-		if (cur >= s->bitmap_size)	/* nothing found, loop back */
-			cur = find_next_bit(s->pgste_bitmap, s->bitmap_size, 0);
-		if (cur >= s->bitmap_size) {	/* again! (very unlikely) */
-			memset(args, 0, sizeof(*args));
-			return 0;
-		}
-		next = find_next_bit(s->pgste_bitmap, s->bitmap_size, cur + 1);
+	/* We are not peeking, and there are no dirty pages */
+	if (!peek && !atomic64_read(&kvm->arch.cmma_dirty_pages)) {
+		memset(args, 0, sizeof(*args));
+		return 0;
 	}
 
-	res = vmalloc(bufsize);
-	if (!res)
+	values = vmalloc(bufsize);
+	if (!values)
 		return -ENOMEM;
 
-	args->start_gfn = cur;
-
 	down_read(&kvm->mm->mmap_sem);
 	srcu_idx = srcu_read_lock(&kvm->srcu);
-	while (i < bufsize) {
-		hva = gfn_to_hva(kvm, cur);
-		if (kvm_is_error_hva(hva)) {
-			r = -EFAULT;
-			break;
-		}
-		/* decrement only if we actually flipped the bit to 0 */
-		if (!peek && test_and_clear_bit(cur, s->pgste_bitmap))
-			atomic64_dec(&s->dirty_pages);
-		r = get_pgste(kvm->mm, hva, &pgstev);
-		if (r < 0)
-			pgstev = 0;
-		/* save the value */
-		res[i++] = (pgstev >> 24) & 0x43;
-		/*
-		 * if the next bit is too far away, stop.
-		 * if we reached the previous "next", find the next one
-		 */
-		if (!peek) {
-			if (next > cur + KVM_S390_MAX_BIT_DISTANCE)
-				break;
-			if (cur == next)
-				next = find_next_bit(s->pgste_bitmap,
-						     s->bitmap_size, cur + 1);
-		/* reached the end of the bitmap or of the buffer, stop */
-			if ((next >= s->bitmap_size) ||
-			    (next >= args->start_gfn + bufsize))
-				break;
-		}
-		cur++;
-	}
+	if (peek)
+		ret = kvm_s390_peek_cmma(kvm, args, values, bufsize);
+	else
+		ret = kvm_s390_get_cmma(kvm, args, values, bufsize);
 	srcu_read_unlock(&kvm->srcu, srcu_idx);
 	up_read(&kvm->mm->mmap_sem);
-	args->count = i;
-	args->remaining = s ? atomic64_read(&s->dirty_pages) : 0;
 
-	rr = copy_to_user((void __user *)args->values, res, args->count);
-	if (rr)
-		r = -EFAULT;
+	if (kvm->arch.migration_mode)
+		args->remaining = atomic64_read(&kvm->arch.cmma_dirty_pages);
+	else
+		args->remaining = 0;
 
-	vfree(res);
-	return r;
+	if (copy_to_user((void __user *)args->values, values, args->count))
+		ret = -EFAULT;
+
+	vfree(values);
+	return ret;
 }
 
 /*
@@ -2140,10 +2199,6 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kvm_s390_destroy_adapters(kvm);
 	kvm_s390_clear_float_irqs(kvm);
 	kvm_s390_vsie_destroy(kvm);
-	if (kvm->arch.migration_state) {
-		vfree(kvm->arch.migration_state->pgste_bitmap);
-		kfree(kvm->arch.migration_state);
-	}
 	KVM_EVENT(3, "vm 0x%pK destroyed", kvm);
 }
 
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index ebfa044..38084d9 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -984,9 +984,11 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static inline int do_essa(struct kvm_vcpu *vcpu, const int orc)
+/*
+ * Must be called with relevant read locks held (kvm->mm->mmap_sem, kvm->srcu)
+ */
+static inline int __do_essa(struct kvm_vcpu *vcpu, const int orc)
 {
-	struct kvm_s390_migration_state *ms = vcpu->kvm->arch.migration_state;
 	int r1, r2, nappended, entries;
 	unsigned long gfn, hva, res, pgstev, ptev;
 	unsigned long *cbrlo;
@@ -1036,10 +1038,12 @@ static inline int do_essa(struct kvm_vcpu *vcpu, const int orc)
 		cbrlo[entries] = gfn << PAGE_SHIFT;
 	}
 
-	if (orc && gfn < ms->bitmap_size) {
-		/* increment only if we are really flipping the bit to 1 */
-		if (!test_and_set_bit(gfn, ms->pgste_bitmap))
-			atomic64_inc(&ms->dirty_pages);
+	if (orc) {
+		struct kvm_memory_slot *ms = gfn_to_memslot(vcpu->kvm, gfn);
+
+		/* Increment only if we are really flipping the bit */
+		if (ms && !test_and_set_bit(gfn - ms->base_gfn, kvm_second_dirty_bitmap(ms)))
+			atomic64_inc(&vcpu->kvm->arch.cmma_dirty_pages);
 	}
 
 	return nappended;
@@ -1068,7 +1072,7 @@ static int handle_essa(struct kvm_vcpu *vcpu)
 						: ESSA_SET_STABLE_IF_RESIDENT))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	if (likely(!vcpu->kvm->arch.migration_state)) {
+	if (!vcpu->kvm->arch.migration_mode) {
 		/*
 		 * CMMA is enabled in the KVM settings, but is disabled in
 		 * the SIE block and in the mm_context, and we are not doing
@@ -1096,10 +1100,16 @@ static int handle_essa(struct kvm_vcpu *vcpu)
 		/* Retry the ESSA instruction */
 		kvm_s390_retry_instr(vcpu);
 	} else {
-		/* Account for the possible extra cbrl entry */
-		i = do_essa(vcpu, orc);
+		int srcu_idx;
+
+		down_read(&vcpu->kvm->mm->mmap_sem);
+		srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
+		i = __do_essa(vcpu, orc);
+		srcu_read_unlock(&vcpu->kvm->srcu, srcu_idx);
+		up_read(&vcpu->kvm->mm->mmap_sem);
 		if (i < 0)
 			return i;
+		/* Account for the possible extra cbrl entry */
 		entries += i;
 	}
 	vcpu->arch.sie_block->cbrlo &= PAGE_MASK;	/* reset nceo */
-- 
2.7.4
