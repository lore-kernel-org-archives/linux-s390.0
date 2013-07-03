From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 1/2] KVM: kvm-io: support cookies
Date: Wed, 3 Jul 2013 12:51:38 +0200
Message-ID: <20130703125138.400ac1ef@gondolin>
References: <1372841780-29645-1-git-send-email-cornelia.huck@de.ibm.com>
	<1372841780-29645-2-git-send-email-cornelia.huck@de.ibm.com>
	<51D3E96E.5080405@redhat.com>
	<51D3ED13.2020408@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <51D3ED13.2020408@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 03 Jul 2013 11:21:23 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> Il 03/07/2013 11:05, Paolo Bonzini ha scritto:
> > Nice idea, though I don't really like the duplication between
> > kvm_io_bus_write and kvm_io_bus_write_cookie.
> > 
> > Can you make kvm_io_bus_write, and perhaps kvm_io_bus_read too, return
> > the cookie, and return -EINVAL here if the cookie is garbage?
> 
> On second though---no need to return -EINVAL, you can just pass the
> cookie by value and tail-call kvm_io_bus_write.  Whatever makes the s390
> code look nicer.

It would probably be easier to have the non-cookie functions call the
cookie functions with a negative cookie value, like the following
(untested):

From 12a6e9821f1a07ecd918e927a4049263ad6f1724 Mon Sep 17 00:00:00 2001
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue, 2 Jul 2013 13:30:56 +0200
Subject: [PATCH] KVM: kvm-io: support cookies

Add new functions kvm_io_bus_{read,write}_cookie() that allows users of
the kvm io infrastructure to use a cookie value to speed up lookup of a
device on an io bus.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 include/linux/kvm_host.h |  4 +++
 virt/kvm/kvm_main.c      | 82 ++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 70 insertions(+), 16 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e3aae6d..97849fc 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -159,8 +159,12 @@ enum kvm_bus {
 
 int kvm_io_bus_write(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
 		     int len, const void *val);
+int kvm_io_bus_write_cookie(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
+			    int len, const void *val, long *cookie);
 int kvm_io_bus_read(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr, int len,
 		    void *val);
+int kvm_io_bus_read_cookie(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
+			   int len, void *val, long *cookie);
 int kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
 			    int len, struct kvm_io_device *dev);
 int kvm_io_bus_unregister_dev(struct kvm *kvm, enum kvm_bus bus_idx,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1580dd4..21e6d7d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2863,11 +2863,11 @@ static int kvm_io_bus_get_first_dev(struct kvm_io_bus *bus,
 	return off;
 }
 
-/* kvm_io_bus_write - called under kvm->slots_lock */
-int kvm_io_bus_write(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
-		     int len, const void *val)
+/* kvm_io_bus_write_cookie - called under kvm->slots_lock */
+int kvm_io_bus_write_cookie(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
+			    int len, const void *val, long *cookie)
 {
-	int idx;
+	int idx, ret = -EOPNOTSUPP;
 	struct kvm_io_bus *bus;
 	struct kvm_io_range range;
 
@@ -2877,25 +2877,50 @@ int kvm_io_bus_write(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
 	};
 
 	bus = srcu_dereference(kvm->buses[bus_idx], &kvm->srcu);
+
+	/* First try the device referenced by *cookie. */
+	if ((*cookie >= 0) && (*cookie < bus->dev_count) &&
+	    (kvm_io_bus_sort_cmp(&range, &bus->range[*cookie]) == 0))
+		if (!kvm_iodevice_write(bus->range[*cookie].dev, addr, len,
+					val))
+			return 0;
+
+	/*
+	 * *cookie contained garbage; fall back to search and return the
+	 * correct value in *cookie.
+	 */
 	idx = kvm_io_bus_get_first_dev(bus, addr, len);
 	if (idx < 0)
-		return -EOPNOTSUPP;
+		goto out;
 
 	while (idx < bus->dev_count &&
 		kvm_io_bus_sort_cmp(&range, &bus->range[idx]) == 0) {
-		if (!kvm_iodevice_write(bus->range[idx].dev, addr, len, val))
-			return 0;
+		if (!kvm_iodevice_write(bus->range[idx].dev, addr, len, val)) {
+			ret = 0;
+			goto out;
+		}
 		idx++;
 	}
+	idx = -ENOENT;
+out:
+	*cookie = idx;
+	return ret;
+}
+
+/* kvm_io_bus_write - called under kvm->slots_lock */
+int kvm_io_bus_write(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
+		     int len, const void *val)
+{
+	long tmp = -1;
 
-	return -EOPNOTSUPP;
+	return kvm_io_bus_write_cookie(kvm, bus_idx, addr, len, val, &tmp);
 }
 
-/* kvm_io_bus_read - called under kvm->slots_lock */
-int kvm_io_bus_read(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
-		    int len, void *val)
+/* kvm_io_bus_read_cookie - called under kvm->slots_lock */
+int kvm_io_bus_read_cookie(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
+			   int len, void *val, long *cookie)
 {
-	int idx;
+	int idx, ret = -EOPNOTSUPP;
 	struct kvm_io_bus *bus;
 	struct kvm_io_range range;
 
@@ -2905,18 +2930,43 @@ int kvm_io_bus_read(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
 	};
 
 	bus = srcu_dereference(kvm->buses[bus_idx], &kvm->srcu);
+
+	/* First try the device referenced by *cookie. */
+	if ((*cookie >= 0) && (*cookie < bus->dev_count) &&
+	    (kvm_io_bus_sort_cmp(&range, &bus->range[*cookie]) == 0))
+		if (!kvm_iodevice_read(bus->range[*cookie].dev, addr, len,
+				       val))
+			return 0;
+
+	/*
+	 * *cookie contained garbage; fall back to search and return the
+	 * correct value in *cookie.
+	 */
 	idx = kvm_io_bus_get_first_dev(bus, addr, len);
 	if (idx < 0)
-		return -EOPNOTSUPP;
+		goto out;
 
 	while (idx < bus->dev_count &&
 		kvm_io_bus_sort_cmp(&range, &bus->range[idx]) == 0) {
-		if (!kvm_iodevice_read(bus->range[idx].dev, addr, len, val))
-			return 0;
+		if (!kvm_iodevice_read(bus->range[idx].dev, addr, len, val)) {
+			ret = 0;
+			goto out;
+		}
 		idx++;
 	}
+	idx = -ENOENT;
+out:
+	*cookie = idx;
+	return ret;
+}
+
+/* kvm_io_bus_read - called under kvm->slots_lock */
+int kvm_io_bus_read(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
+		    int len, void *val)
+{
+	long tmp = -1;
 
-	return -EOPNOTSUPP;
+	return kvm_io_bus_read_cookie(kvm, bus_idx, addr, len, val, &tmp);
 }
 
 /* Caller must hold slots_lock. */
-- 
1.8.2.2
