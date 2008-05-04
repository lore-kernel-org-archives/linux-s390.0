From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: s390 kvm_virtio.c build error
Date: Sun, 4 May 2008 21:25:37 +0200
Message-ID: <20080504192537.GA5499@osiris.boeblingen.de.ibm.com>
References: <20080503174716.GM5838@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20080503174716.GM5838@cs181133002.pp.htv.fi>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel@lists.sourceforge.net>
List-Help: <mailto:kvm-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: kvm-devel-bounces@lists.sourceforge.net
Errors-To: kvm-devel-bounces@lists.sourceforge.net
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Adrian Bunk <bunk@kernel.org>
Cc: Carsten Otte <cotte@de.ibm.com>, linux-s390@vger.kernel.org, kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Avi Kivity <avi@qumranet.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Sat, May 03, 2008 at 08:47:17PM +0300, Adrian Bunk wrote:
> Commit c45a6816c19dee67b8f725e6646d428901a6dc24
> (virtio: explicit advertisement of driver features)
> and commit e976a2b997fc4ad70ccc53acfe62811c4aaec851
> (s390: KVM guest: virtio device support, and kvm hypercalls)
> don't like each other:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/s390/kvm/kvm_virtio.o
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/s390/kvm/kvm_virtio.c:224: error: unknown field 'feature' specified in initializer
> /home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/s390/kvm/kvm_virtio.c:224: warning: initialization from incompatible pointer type
> make[3]: *** [drivers/s390/kvm/kvm_virtio.o] Error 1
> 
> <--  snip  -->

Hmm... this should help:

---
 drivers/s390/kvm/kvm_virtio.c |   40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

Index: linux-2.6/drivers/s390/kvm/kvm_virtio.c
===================================================================
--- linux-2.6.orig/drivers/s390/kvm/kvm_virtio.c
+++ linux-2.6/drivers/s390/kvm/kvm_virtio.c
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

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
