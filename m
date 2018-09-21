From: Eric Farman <farman@linux.ibm.com>
Date: Fri, 21 Sep 2018 20:40:13 +0000
Subject: [PATCH v2 2/2] s390/cio: Refactor alloc of ccw_io_region
Message-Id: <20180921204013.95804-3-farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

If I attach a vfio-ccw device to my guest, I get the following warning
on the host when the host kernel is CONFIG_HARDENED_USERCOPY=y

[250757.595325] Bad or missing usercopy whitelist? Kernel memory overwrite attempt detected to SLUB object 'dma-kmalloc-512' (offset 64, size 124)!
[250757.595365] WARNING: CPU: 2 PID: 10958 at mm/usercopy.c:81 usercopy_warn+0xac/0xd8
[250757.595369] Modules linked in: kvm vhost_net vhost tap xt_CHECKSUM iptable_mangle ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack libcrc32c devlink tun bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables sunrpc dm_multipath s390_trng crc32_vx_s390 ghash_s390 prng aes_s390 des_s390 des_generic sha512_s390 sha1_s390 eadm_sch tape_3590 tape tape_class qeth_l2 qeth ccwgroup vfio_ccw vfio_mdev zcrypt_cex4 mdev vfio_iommu_type1 zcrypt vfio sha256_s390 sha_common zfcp scsi_transport_fc qdio dasd_eckd_mod dasd_mod
[250757.595424] CPU: 2 PID: 10958 Comm: CPU 2/KVM Not tainted 4.18.0-derp #2
[250757.595426] Hardware name: IBM 3906 M05 780 (LPAR)
...snip regs...
[250757.595523] Call Trace:
[250757.595529] ([<0000000000349210>] usercopy_warn+0xa8/0xd8)
[250757.595535]  [<000000000032daaa>] __check_heap_object+0xfa/0x160
[250757.595540]  [<0000000000349396>] __check_object_size+0x156/0x1d0
[250757.595547]  [<000003ff80332d04>] vfio_ccw_mdev_write+0x74/0x148 [vfio_ccw]
[250757.595552]  [<000000000034ed12>] __vfs_write+0x3a/0x188
[250757.595556]  [<000000000034f040>] vfs_write+0xa8/0x1b8
[250757.595559]  [<000000000034f4e6>] ksys_pwrite64+0x86/0xc0
[250757.595568]  [<00000000008959a0>] system_call+0xdc/0x2b0
[250757.595570] Last Breaking-Event-Address:
[250757.595573]  [<0000000000349210>] usercopy_warn+0xa8/0xd8

While vfio_ccw_mdev_{write|read} validates that the input position/count
does not run over the ccw_io_region struct, the usercopy code that does
copy_{to|from}_user doesn't necessarily know this. It sees the variable
length and gets worried that it's affecting a normal kmalloc'd struct,
and generates the above warning.

Adjust how the ccw_io_region is alloc'd with a whitelist to remove this
warning. The boundary checking will continue to do its thing.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index f48e6f84eefe..f47d16b5810b 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -22,6 +22,7 @@
 #include "vfio_ccw_private.h"
 
 struct workqueue_struct *vfio_ccw_work_q;
+struct kmem_cache *vfio_ccw_io_region;
 
 /*
  * Helpers
@@ -115,8 +116,8 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	if (!private)
 		return -ENOMEM;
 
-	private->io_region = kzalloc(sizeof(*private->io_region),
-				     GFP_KERNEL | GFP_DMA);
+	private->io_region = kmem_cache_zalloc(vfio_ccw_io_region,
+					       GFP_KERNEL | GFP_DMA);
 	if (!private->io_region) {
 		kfree(private);
 		return -ENOMEM;
@@ -147,7 +148,7 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	cio_disable_subchannel(sch);
 out_free:
 	dev_set_drvdata(&sch->dev, NULL);
-	kfree(private->io_region);
+	kmem_cache_free(vfio_ccw_io_region, private->io_region);
 	kfree(private);
 	return ret;
 }
@@ -162,7 +163,7 @@ static int vfio_ccw_sch_remove(struct subchannel *sch)
 
 	dev_set_drvdata(&sch->dev, NULL);
 
-	kfree(private->io_region);
+	kmem_cache_free(vfio_ccw_io_region, private->io_region);
 	kfree(private);
 
 	return 0;
@@ -242,10 +243,20 @@ static int __init vfio_ccw_sch_init(void)
 	if (!vfio_ccw_work_q)
 		return -ENOMEM;
 
+	vfio_ccw_io_region = kmem_cache_create_usercopy("vfio_ccw_io_region",
+					sizeof(struct ccw_io_region), 0,
+					SLAB_ACCOUNT, 0,
+					sizeof(struct ccw_io_region), NULL);
+	if (!vfio_ccw_io_region) {
+		destroy_workqueue(vfio_ccw_work_q);
+		return -ENOMEM;
+	}
+
 	isc_register(VFIO_CCW_ISC);
 	ret = css_driver_register(&vfio_ccw_sch_driver);
 	if (ret) {
 		isc_unregister(VFIO_CCW_ISC);
+		kmem_cache_destroy(vfio_ccw_io_region);
 		destroy_workqueue(vfio_ccw_work_q);
 	}
 
@@ -256,6 +267,7 @@ static void __exit vfio_ccw_sch_exit(void)
 {
 	css_driver_unregister(&vfio_ccw_sch_driver);
 	isc_unregister(VFIO_CCW_ISC);
+	kmem_cache_destroy(vfio_ccw_io_region);
 	destroy_workqueue(vfio_ccw_work_q);
 }
 module_init(vfio_ccw_sch_init);
-- 
2.16.4
