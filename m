Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7081C49EC60
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455259; cv=none; b=qzUagG3jL2lzfSlYcfQ0mNdfJfNMkl2PNrXpusu2t5T2GiOaArzeQUF63+2GJ0xkcrnX4ow0vc9l1z0lq1VXnI2ks82gmhs6b3s0HuWs3wZPk0PIeDAfNa9LPQCoB1JtdzBfxwhJUXjMqVnYgh0iNOT82unbPhsq5SB+6nQh3jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455259; c=relaxed/simple;
	bh=W3/8W3/lNhkqiBlRITSzsVQkumsY+ppyl/x9JV/N/gg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Flp3Kc85ar1hK6BwKlPakn2t9Gy57zv2f3aEJSkEm+zjgc24yYuDBLNvKnRHMrcbpnLIb3KyxFQ/wH8m6yvXQFTA+VsBDwNMxyMPud5UhqlOAQO2sQLNWYcmefeac2mFWMbbcwY6xn89pgY+QHfUXGW6THWDcoeLKSARo45BmBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kZ3cPJBb; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kZ3cPJBb"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2db0a41434bso1017855ad.0
        for <linux-s390@vger.kernel.org>; Thu, 03 Sep 2026 10:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788455258; x=1789060058; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3rOl6zOJPV7OvaUeFzHxeB6d7+tFr+OSRYoJny2JJjQ=;
        b=kZ3cPJBbkhr0xv++As7MV8VrKKd/prQ/5GZdeCnTJIbwSbgaem2bwKJk9Tmmpee/mY
         WMnMt9Gj8q/Y9IXzK/+QweQDCxSTsQawkCAdHOhkhUMR2qKBXraeWsuazQgFTt1AwcIm
         NZeJeXZPs10YCDrfWn/1ECzgHWl+j2PM866igHUlRyQ4CwMbZVBUdaeGrv/enXoV1aSx
         wOBdJ/wgreR6E0XFMblnkB3OHdBiK3Oco0kgR0E5l6qYnLABTVjZ1H+Jf+y+llA+pGq8
         MRiL7CzIWWayep0O+vFOIuhxypUVL3MxC1n7MwqzjrazGpjMnb45uLSDsi0XC9Yb+J6B
         BZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788455258; x=1789060058;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3rOl6zOJPV7OvaUeFzHxeB6d7+tFr+OSRYoJny2JJjQ=;
        b=HQLxjj/6ASV7SBcZyz6tjVR3X4t3JDpW9U3H7dLAuuOLvriMgMQGNu+u/oVDQQgCtB
         ObNnVvzS1nFy2+XRDP+02ClDMu39Af0z0JadLhW9NV565zm4uXApHY7XCqjLiAQiy5T2
         wtuFs+2UTxaVDPengOTZUzgdOHvs8b4NzsSwLMIGKGS+C4vVH/PWV8ARdWMAo+4hGtSu
         aL0GM9roB8T5xcK9vvXUXaRTBrS+L/MNHPVj8EKfyCTR/JU9mbp1SVE6YReauGFxSgLo
         cxq4iacdeeBPjFqpuoYEDtNjy0zHi3ib8RoIrAExdoZBnNhQhH0fEGrXfsOEiQh++SQL
         qhUQ==
X-Forwarded-Encrypted: i=1; AKwUvBwUuCFzQux4k8pc+Pe/avRWlA0QO6FZtEJANYEWp/5ECxl4Nwx4I4g1vVvPBKfu8zuUYj+eMYT7vAAM@vger.kernel.org
X-Gm-Message-State: AFuF++lR5TkK0QsQOwrFqthMWNJ3pjO/4HpZycYxDGYvxhS9oBTcruIr
	rxsPMQvw9e8NThUrC5pxwC/3xd0NnWhNzGXre3JoGZUTm9hZvbPc5QinDlUgO0jvwDpYwzzJd/W
	ZlGoOZg==
X-Received: from plho15.prod.google.com ([2002:a17:903:23cf:b0:2cf:bf3e:41f0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:fa6:b0:2d9:4358:73ab
 with SMTP id d9443c01a7336-2db126326b2mr5500405ad.19.1788455257530; Thu, 03
 Sep 2026 10:07:37 -0700 (PDT)
Date: Thu, 3 Sep 2026 10:07:36 -0700
In-Reply-To: <20260903084221.C3B871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903-vfio-v2-1-ef4cd4190ae7@linux.ibm.com> <20260903084221.C3B871F000E9@smtp.kernel.org>
Message-ID: <apmpWNSv6ahYr2Bl@google.com>
Subject: Re: [PATCH v2] vfio: Use file-based reference counting for KVM
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Steffen Eiden <seiden@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, 
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 03, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> > index 940c0ff668bee..f160e1945fbce 100644
> > --- a/drivers/s390/crypto/vfio_ap_ops.c
> > +++ b/drivers/s390/crypto/vfio_ap_ops.c
> 
> [ ... ]
> 
> > @@ -1822,17 +1822,27 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
> >  
> >  /**
> >   * vfio_ap_mdev_set_kvm - sets all data for @matrix_mdev that are needed
> > - * to manage AP resources for the guest whose state is represented by @kvm
> > + * to manage AP resources for the guest whose state is represented by
> > + * @kvm_file
> >   *
> >   * @matrix_mdev: a mediated matrix device
> > - * @kvm: reference to KVM instance
> > + * @kvm_file: the KVM VM file this vfio device is associated with
> >   *
> > - * Return: 0 if no other mediated matrix device has a reference to @kvm;
> > + * Return: 0 if no other mediated matrix device has a reference to the VM;
> >   * otherwise, returns an -EPERM.
> >   */
> >  static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
> > -				struct kvm *kvm)
> > +				struct file *kvm_file)
> >  {
> > +	struct kvm *kvm;
> > +
> > +	if (!kvm_file)
> > +		return -ENOENT;
> > +
> > +	kvm = kvm_file->private_data;
> > +	if (!kvm)
> > +		return -ENOENT;
> > +
> >  	if (kvm->arch.crypto.crycbd) {
> 
> [Severity: Critical]
> Does this code adequately verify that the file is an s390 KVM file before
> casting its private_data in vfio_ap_mdev_set_kvm() inside
> drivers/s390/crypto/vfio_ap_ops.c?
> 
> If a user instantiates a VM using a concurrent KVM-arm64 module and attaches
> an s390-specific VFIO device to its KVM device, could this driver extract the
> untyped private_data and mistakenly treat an arm64 struct kvm as an s390 one?
> 
> Because the memory layouts of struct kvm_arch differ across architectures,
> would accessing s390-specific fields in the arch member (like
> kvm->arch.crypto.pqap_hook) result in arbitrary memory corruption?

This is effectively the same concern I raised[1] in the s390+arm64 series:

 : Side topic #2, this entire approach seems extremely brittle unless you make it
 : all but impossible for non-KVM code to get at KVM structure definitions.  Outside
 : of KVM, all compilation units will see the s390 version of KVM structures.  Which
 : is "fine", but obviously dangerous and IMO asking for maintenance issues down the
 : road.

I don't think we need to go to the super extreme lengths I proposed[2] back when
we were exploring multi-KVM on x86, but the direct dereference of ->private_data
is a huge red flag.

Given that external usage of "struct kvm" should be *super* rare, and IMO is
something we should actively discourage, I think we should make it opt-in.  Then
at the same time, define the API so that it's arch-specific, e.g. to yield
file_to_kvm_s390() so that drivers/s390/crypto/vfio_ap_ops.c can get exactly
what it wants.

Diff below, though it needs to be split into multiple patches (I'll respond with
more to the full patch).

[1] https://lore.kernel.org/all/aphLXQL1H2zYZgTi@google.com
[2] https://lore.kernel.org/all/20230916003118.2540661-1-seanjc@google.com

diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
index cd692f8fb764..8a7eed5847e1 100644
--- a/arch/s390/include/asm/kvm_host_s390.h
+++ b/arch/s390/include/asm/kvm_host_s390.h
@@ -27,6 +27,8 @@
 #include <asm/isc.h>
 #include <asm/guarded_storage.h>
 
+#define kvm_file_to_kvm_arch s390
+
 #define KVM_HAVE_MMU_RWLOCK
 #define KVM_MAX_VCPUS 255
 
diff --git a/arch/x86/include/asm/kvm_page_track.h b/arch/x86/include/asm/kvm_page_track.h
index 046a25c8fe4f..acc301f5e265 100644
--- a/arch/x86/include/asm/kvm_page_track.h
+++ b/arch/x86/include/asm/kvm_page_track.h
@@ -5,6 +5,9 @@
 #include <linux/kvm_types.h>
 
 #ifdef CONFIG_KVM_EXTERNAL_WRITE_TRACKING
+
+#define kvm_file_to_kvm_arch x86
+
 /*
  * The notifier represented by @kvm_page_track_notifier_node is linked into
  * the head which will be notified when guest is triggering the track event.
diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 96f89d6f7e6a..c6bf463f5032 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -60,7 +60,8 @@ exports_grep_trailer := --include='*.[ch]' -nrw $(srctree)/virt/kvm $(srctree)/a
 			grep -v -e kvm_page_track_register_notifier \
 				-e kvm_page_track_unregister_notifier \
 				-e kvm_write_track_add_gfn \
-				-e kvm_write_track_remove_gfn
+				-e kvm_write_track_remove_gfn \
+				-e kvm_file_to_kvm_fn
 
 # Force grep to emit a goofy group separator that can in turn be replaced with
 # the above newline macro (newlines in Make are a nightmare).  Note, grep only
diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index 98f133e4f0b3..ebf941b6378d 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -241,7 +241,7 @@ int kvm_page_track_register_notifier(struct file *file,
 				     struct kvm_page_track_notifier_node *n)
 {
 	struct kvm_page_track_notifier_head *head;
-	struct kvm *kvm = file_to_kvm(file);
+	struct kvm *kvm = file_to_kvm_x86(file);
 	int r;
 
 	if (!kvm || kvm->mm != current->mm)
@@ -272,7 +272,7 @@ void kvm_page_track_unregister_notifier(struct file *file,
 					struct kvm_page_track_notifier_node *n)
 {
 	struct kvm_page_track_notifier_head *head;
-	struct kvm *kvm = file_to_kvm(file);
+	struct kvm *kvm = file_to_kvm_x86(file);
 
 	head = &kvm->arch.track_notifier_head;
 
@@ -343,7 +343,7 @@ void kvm_page_track_delete_slot(struct kvm *kvm, struct kvm_memory_slot *slot)
  */
 int kvm_write_track_add_gfn(struct file *file, gfn_t gfn)
 {
-	struct kvm *kvm = file_to_kvm(file);
+	struct kvm *kvm = file_to_kvm_x86(file);
 	struct kvm_memory_slot *slot;
 	int idx;
 
@@ -374,7 +374,7 @@ EXPORT_SYMBOL_GPL(kvm_write_track_add_gfn);
  */
 int kvm_write_track_remove_gfn(struct file *file, gfn_t gfn)
 {
-	struct kvm *kvm = file_to_kvm(file);
+	struct kvm *kvm = file_to_kvm_x86(file);
 	struct kvm_memory_slot *slot;
 	int idx;
 
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 5705723f1f41..6b0eacde4f06 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2145,10 +2145,10 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	if (fd_empty(f))
 		return -EBADF;
 
-	if (!file_is_kvm(fd_file(f)))
+	source_kvm = file_to_kvm_x86(fd_file(f));
+	if (!source_kvm)
 		return -EBADF;
 
-	source_kvm = fd_file(f)->private_data;
 	ret = sev_lock_two_vms(kvm, source_kvm);
 	if (ret)
 		return ret;
@@ -2866,10 +2866,10 @@ int sev_vm_copy_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	if (fd_empty(f))
 		return -EBADF;
 
-	if (!file_is_kvm(fd_file(f)))
+	source_kvm = file_to_kvm_x86(fd_file(f));
+	if (!source_kvm)
 		return -EBADF;
 
-	source_kvm = fd_file(f)->private_data;
 	ret = sev_lock_two_vms(kvm, source_kvm);
 	if (ret)
 		return ret;
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index f160e1945fbc..96bcc47b824f 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1834,12 +1834,8 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
 static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 				struct file *kvm_file)
 {
-	struct kvm *kvm;
+	struct kvm *kvm = file_to_kvm_s390(kvm_file);
 
-	if (!kvm_file)
-		return -ENOENT;
-
-	kvm = kvm_file->private_data;
 	if (!kvm)
 		return -ENOENT;
 
diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
index 045132e90bfe..332bc66db55b 100644
--- a/drivers/vfio/pci/vfio_pci_zdev.c
+++ b/drivers/vfio/pci/vfio_pci_zdev.c
@@ -196,7 +196,7 @@ int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
 		return 0;
 
 	ret = -ENOENT;
-	kvm = vdev->vdev.kvm->private_data;
+	kvm = file_to_kvm_s390(vdev->vdev.kvm);
 	if (!kvm)
 		goto recovery;
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index bfecce1b5955..09e327843e6c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1088,8 +1088,11 @@ void kvm_exit(void);
 void kvm_get_kvm(struct kvm *kvm);
 bool kvm_get_kvm_safe(struct kvm *kvm);
 void kvm_put_kvm(struct kvm *kvm);
-bool file_is_kvm(struct file *file);
-struct kvm *file_to_kvm(struct file *file);
+#ifdef kvm_file_to_kvm_arch
+#define kvm_file_to_kvm_fn CONCATENATE(file_to_kvm_, kvm_file_to_kvm_arch)
+struct kvm *kvm_file_to_kvm_fn(struct file *file);
+#endif
+
 void kvm_put_kvm_no_destroy(struct kvm *kvm);
 
 static inline struct kvm_memslots *__kvm_memslots(struct kvm *kvm, int as_id)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 34b4c43908b3..9557026299d3 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5492,20 +5492,16 @@ static struct file_operations kvm_vm_fops = {
 	KVM_COMPAT(kvm_vm_compat_ioctl),
 };
 
-bool file_is_kvm(struct file *file)
+#ifdef kvm_file_to_kvm_fn
+struct kvm *kvm_file_to_kvm_fn(struct file *file)
 {
-	return file && file->f_op == &kvm_vm_fops;
-}
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(file_is_kvm);
-
-struct kvm *file_to_kvm(struct file *file)
-{
-	if (!file_is_kvm(file))
+	if (!file || file->f_op != &kvm_vm_fops)
 		return NULL;
 
 	return file->private_data;
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(file_to_kvm);
+EXPORT_SYMBOL_GPL(kvm_file_to_kvm_fn);
+#endif
 
 static int kvm_dev_ioctl_create_vm(unsigned long type)
 {

