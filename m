From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: s390 kvm_virtio.c build error
Date: Mon, 05 May 2008 15:06:50 +0200
Message-ID: <1209992810.7089.15.camel@localhost>
References: <20080503174716.GM5838@cs181133002.pp.htv.fi>
	 <20080504192537.GA5499@osiris.boeblingen.de.ibm.com>
	 <200805051429.47446.borntraeger@de.ibm.com> <481F0504.3010503@qumranet.com>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759373AbYEENIl@vger.kernel.org>
In-Reply-To: <481F0504.3010503@qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@qumranet.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Adrian Bunk <bunk@kernel.org>, Carsten Otte <cotte@de.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, kvm-devel@lists.sourceforge.net, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2008-05-05 at 16:00 +0300, Avi Kivity wrote:
> Christian Borntraeger wrote:
> >> Hmm... this should help:
> >>
> >> ---
> >>  drivers/s390/kvm/kvm_virtio.c |   40 
> >>     
> > +++++++++++++++++++++++-----------------
> >   
> >>  1 file changed, 23 insertions(+), 17 deletions(-)
> >>     
> >
> > Thanks Heiko.
> > I did a short test and it seems to work.
> >
> > Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >
> > This looks almost identical to Rusty's patch. Who is going to send this (or 
> > Rustys) patch to Linus?
> >   
> 
> I can, but tell me which one.  Also, the patch (Heiko's) needs a 
> changelog entry and a signoff.

I've added Heiko's patch to my patchqueue. But since this is
drivers/s390/kvm this should go in over the kvm.git. See patch below.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.

---
Subject: [PATCH] kvm/s390 compile error

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Fix kvm compile error:

Commit c45a6816c19dee67b8f725e6646d428901a6dc24
(virtio: explicit advertisement of driver features)
and commit e976a2b997fc4ad70ccc53acfe62811c4aaec851
(s390: KVM guest: virtio device support, and kvm hypercalls)
don't like each other:

  CC      drivers/s390/kvm/kvm_virtio.o
drivers/s390/kvm/kvm_virtio.c:224: error: unknown field 'feature' specified in initializer
drivers/s390/kvm/kvm_virtio.c:224: warning: initialization from incompatible pointer type
make[3]: *** [drivers/s390/kvm/kvm_virtio.o] Error 1

Cc: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/kvm/kvm_virtio.c |   40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff -urpN linux-2.6/drivers/s390/kvm/kvm_virtio.c linux-2.6-patched/drivers/s390/kvm/kvm_virtio.c
--- linux-2.6/drivers/s390/kvm/kvm_virtio.c	2008-05-05 13:20:45.000000000 +0200
+++ linux-2.6-patched/drivers/s390/kvm/kvm_virtio.c	2008-05-05 13:20:48.000000000 +0200
@@ -78,27 +78,32 @@ static unsigned desc_size(const struct k
 		+ desc->config_len;
 }
 
-/*
- * This tests (and acknowleges) a feature bit.
- */
-static bool kvm_feature(struct virtio_device *vdev, unsigned fbit)
+/* This gets the device's feature bits. */
+static u32 kvm_get_features(struct virtio_device *vdev)
 {
+	unsigned int i;
+	u32 features = 0;
 	struct kvm_device_desc *desc = to_kvmdev(vdev)->desc;
-	u8 *features;
+	u8 *in_features = kvm_vq_features(desc);
 
-	if (fbit / 8 > desc->feature_len)
-		return false;
+	for (i = 0; i < min(desc->feature_len * 8, 32); i++)
+		if (in_features[i / 8] & (1 << (i % 8)))
+			features |= (1 << i);
+	return features;
+}
 
-	features = kvm_vq_features(desc);
-	if (!(features[fbit / 8] & (1 << (fbit % 8))))
-		return false;
+static void kvm_set_features(struct virtio_device *vdev, u32 features)
+{
+	unsigned int i;
+	struct kvm_device_desc *desc = to_kvmdev(vdev)->desc;
+	/* Second half of bitmap is features we accept. */
+	u8 *out_features = kvm_vq_features(desc) + desc->feature_len;
 
-	/*
-	 * We set the matching bit in the other half of the bitmap to tell the
-	 * Host we want to use this feature.
-	 */
-	features[desc->feature_len + fbit / 8] |= (1 << (fbit % 8));
-	return true;
+	memset(out_features, 0, desc->feature_len);
+	for (i = 0; i < min(desc->feature_len * 8, 32); i++) {
+		if (features & (1 << i))
+			out_features[i / 8] |= (1 << (i % 8));
+	}
 }
 
 /*
@@ -221,7 +226,8 @@ static void kvm_del_vq(struct virtqueue 
  * The config ops structure as defined by virtio config
  */
 static struct virtio_config_ops kvm_vq_configspace_ops = {
-	.feature = kvm_feature,
+	.get_features = kvm_get_features,
+	.set_features = kvm_set_features,
 	.get = kvm_get,
 	.set = kvm_set,
 	.get_status = kvm_get_status,
