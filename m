Return-Path: <linux-kernel-owner+w=401wt.eu-S1764548AbZBYPXl@vger.kernel.org>
Message-Id: <20090225150828.464020227@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:28 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 06/46] dasd: add large volume support
Content-Disposition: inline; filename=105-dasd-large-volume.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Weinhuber <wein@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Weinhuber <wein@de.ibm.com>

The dasd device driver will now support ECKD devices with more then
65520 cylinders.
In the traditional ECKD adressing scheme each track is addressed
by a 16-bit cylinder and 16-bit head number. The new addressing
scheme makes use of the fact that the actual number of heads is
never larger then 15, so 12 bits of the head number can be redefined
to be part of the cylinder address.

Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/dasd.h    |   10 +--
 arch/s390/include/asm/vtoc.h    |   16 ++++-
 drivers/s390/block/dasd_eckd.c  |  126 +++++++++++++++++++++-------------------
 drivers/s390/block/dasd_eckd.h  |    9 ++
 drivers/s390/block/dasd_int.h   |    2 
 drivers/s390/block/dasd_ioctl.c |    4 -
 drivers/s390/block/dasd_proc.c  |    2 
 fs/partitions/ibm.c             |  101 ++++++++++++++++++++++----------
 8 files changed, 171 insertions(+), 99 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/dasd.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/dasd.h
+++ quilt-2.6/arch/s390/include/asm/dasd.h
@@ -162,15 +162,15 @@ typedef struct dasd_profile_info_t {
         unsigned int dasd_io_nr_req[32]; /* histogram of # of requests in chanq */
 } dasd_profile_info_t;
 
-/* 
+/*
  * struct format_data_t
  * represents all data necessary to format a dasd
  */
 typedef struct format_data_t {
-	int start_unit; /* from track */
-	int stop_unit;  /* to track */
-	int blksize;    /* sectorsize */
-        int intensity;  
+	unsigned int start_unit; /* from track */
+	unsigned int stop_unit;  /* to track */
+	unsigned int blksize;	 /* sectorsize */
+	unsigned int intensity;
 } format_data_t;
 
 /*
Index: quilt-2.6/arch/s390/include/asm/vtoc.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/vtoc.h
+++ quilt-2.6/arch/s390/include/asm/vtoc.h
@@ -39,7 +39,7 @@ struct vtoc_labeldate
 	__u16 day;
 } __attribute__ ((packed));
 
-struct vtoc_volume_label
+struct vtoc_volume_label_cdl
 {
 	char volkey[4];		/* volume key = volume label */
 	char vollbl[4];		/* volume label */
@@ -56,6 +56,14 @@ struct vtoc_volume_label
 	char res3[29];		/* reserved */
 } __attribute__ ((packed));
 
+struct vtoc_volume_label_ldl {
+	char vollbl[4];		/* volume label */
+	char volid[6];		/* volume identifier */
+	char res3[69];		/* reserved */
+	char ldl_version;	/* version number, valid for ldl format */
+	__u64 formatted_blocks; /* valid when ldl_version >= f2  */
+} __attribute__ ((packed));
+
 struct vtoc_extent
 {
 	__u8 typeind;			/* extent type indicator */
@@ -140,7 +148,11 @@ struct vtoc_format4_label
 	char res2[10];		/* reserved */
 	__u8 DS4EFLVL;		/* extended free-space management level */
 	struct vtoc_cchhb DS4EFPTR; /* pointer to extended free-space info */
-	char res3[9];		/* reserved */
+	char res3;		/* reserved */
+	__u32 DS4DCYL;		/* number of logical cyls */
+	char res4[2];		/* reserved */
+	__u8 DS4DEVF2;		/* device flags */
+	char res5;		/* reserved */
 } __attribute__ ((packed));
 
 struct vtoc_ds5ext
Index: quilt-2.6/drivers/s390/block/dasd_eckd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_eckd.c
+++ quilt-2.6/drivers/s390/block/dasd_eckd.c
@@ -159,6 +159,14 @@ recs_per_track(struct dasd_eckd_characte
 	return 0;
 }
 
+static void set_ch_t(struct ch_t *geo, __u32 cyl, __u8 head)
+{
+	geo->cyl = (__u16) cyl;
+	geo->head = cyl >> 16;
+	geo->head <<= 4;
+	geo->head |= head;
+}
+
 static int
 check_XRC (struct ccw1         *de_ccw,
            struct DE_eckd_data *data,
@@ -186,11 +194,12 @@ check_XRC (struct ccw1         *de_ccw,
 }
 
 static int
-define_extent(struct ccw1 * ccw, struct DE_eckd_data * data, int trk,
-	      int totrk, int cmd, struct dasd_device * device)
+define_extent(struct ccw1 *ccw, struct DE_eckd_data *data, unsigned int trk,
+	      unsigned int totrk, int cmd, struct dasd_device *device)
 {
 	struct dasd_eckd_private *private;
-	struct ch_t geo, beg, end;
+	u32 begcyl, endcyl;
+	u16 heads, beghead, endhead;
 	int rc = 0;
 
 	private = (struct dasd_eckd_private *) device->private;
@@ -248,27 +257,24 @@ define_extent(struct ccw1 * ccw, struct 
 	    && !(private->uses_cdl && trk < 2))
 		data->ga_extended |= 0x40; /* Regular Data Format Mode */
 
-	geo.cyl = private->rdc_data.no_cyl;
-	geo.head = private->rdc_data.trk_per_cyl;
-	beg.cyl = trk / geo.head;
-	beg.head = trk % geo.head;
-	end.cyl = totrk / geo.head;
-	end.head = totrk % geo.head;
+	heads = private->rdc_data.trk_per_cyl;
+	begcyl = trk / heads;
+	beghead = trk % heads;
+	endcyl = totrk / heads;
+	endhead = totrk % heads;
 
 	/* check for sequential prestage - enhance cylinder range */
 	if (data->attributes.operation == DASD_SEQ_PRESTAGE ||
 	    data->attributes.operation == DASD_SEQ_ACCESS) {
 
-		if (end.cyl + private->attrib.nr_cyl < geo.cyl)
-			end.cyl += private->attrib.nr_cyl;
+		if (endcyl + private->attrib.nr_cyl < private->real_cyl)
+			endcyl += private->attrib.nr_cyl;
 		else
-			end.cyl = (geo.cyl - 1);
+			endcyl = (private->real_cyl - 1);
 	}
 
-	data->beg_ext.cyl = beg.cyl;
-	data->beg_ext.head = beg.head;
-	data->end_ext.cyl = end.cyl;
-	data->end_ext.head = end.head;
+	set_ch_t(&data->beg_ext, begcyl, beghead);
+	set_ch_t(&data->end_ext, endcyl, endhead);
 	return rc;
 }
 
@@ -294,13 +300,14 @@ static int check_XRC_on_prefix(struct PF
 	return rc;
 }
 
-static int prefix(struct ccw1 *ccw, struct PFX_eckd_data *pfxdata, int trk,
-		  int totrk, int cmd, struct dasd_device *basedev,
-		  struct dasd_device *startdev)
+static int prefix(struct ccw1 *ccw, struct PFX_eckd_data *pfxdata,
+		  unsigned int trk, unsigned int totrk, int cmd,
+		  struct dasd_device *basedev, struct dasd_device *startdev)
 {
 	struct dasd_eckd_private *basepriv, *startpriv;
 	struct DE_eckd_data *data;
-	struct ch_t geo, beg, end;
+	u32 begcyl, endcyl;
+	u16 heads, beghead, endhead;
 	int rc = 0;
 
 	basepriv = (struct dasd_eckd_private *) basedev->private;
@@ -374,33 +381,30 @@ static int prefix(struct ccw1 *ccw, stru
 	    && !(basepriv->uses_cdl && trk < 2))
 		data->ga_extended |= 0x40; /* Regular Data Format Mode */
 
-	geo.cyl = basepriv->rdc_data.no_cyl;
-	geo.head = basepriv->rdc_data.trk_per_cyl;
-	beg.cyl = trk / geo.head;
-	beg.head = trk % geo.head;
-	end.cyl = totrk / geo.head;
-	end.head = totrk % geo.head;
+	heads = basepriv->rdc_data.trk_per_cyl;
+	begcyl = trk / heads;
+	beghead = trk % heads;
+	endcyl = totrk / heads;
+	endhead = totrk % heads;
 
 	/* check for sequential prestage - enhance cylinder range */
 	if (data->attributes.operation == DASD_SEQ_PRESTAGE ||
 	    data->attributes.operation == DASD_SEQ_ACCESS) {
 
-		if (end.cyl + basepriv->attrib.nr_cyl < geo.cyl)
-			end.cyl += basepriv->attrib.nr_cyl;
+		if (endcyl + basepriv->attrib.nr_cyl < basepriv->real_cyl)
+			endcyl += basepriv->attrib.nr_cyl;
 		else
-			end.cyl = (geo.cyl - 1);
+			endcyl = (basepriv->real_cyl - 1);
 	}
 
-	data->beg_ext.cyl = beg.cyl;
-	data->beg_ext.head = beg.head;
-	data->end_ext.cyl = end.cyl;
-	data->end_ext.head = end.head;
+	set_ch_t(&data->beg_ext, begcyl, beghead);
+	set_ch_t(&data->end_ext, endcyl, endhead);
 	return rc;
 }
 
 static void
-locate_record(struct ccw1 *ccw, struct LO_eckd_data *data, int trk,
-	      int rec_on_trk, int no_rec, int cmd,
+locate_record(struct ccw1 *ccw, struct LO_eckd_data *data, unsigned int trk,
+	      unsigned int rec_on_trk, int no_rec, int cmd,
 	      struct dasd_device * device, int reclen)
 {
 	struct dasd_eckd_private *private;
@@ -493,10 +497,11 @@ locate_record(struct ccw1 *ccw, struct L
 	default:
 		DEV_MESSAGE(KERN_ERR, device, "unknown opcode 0x%x", cmd);
 	}
-	data->seek_addr.cyl = data->search_arg.cyl =
-		trk / private->rdc_data.trk_per_cyl;
-	data->seek_addr.head = data->search_arg.head =
-		trk % private->rdc_data.trk_per_cyl;
+	set_ch_t(&data->seek_addr,
+		 trk / private->rdc_data.trk_per_cyl,
+		 trk % private->rdc_data.trk_per_cyl);
+	data->search_arg.cyl = data->seek_addr.cyl;
+	data->search_arg.head = data->seek_addr.head;
 	data->search_arg.record = rec_on_trk;
 }
 
@@ -1002,13 +1007,20 @@ dasd_eckd_check_characteristics(struct d
 			    "rc=%d", rc);
 		goto out_err3;
 	}
+	/* find the vaild cylinder size */
+	if (private->rdc_data.no_cyl == LV_COMPAT_CYL &&
+	    private->rdc_data.long_no_cyl)
+		private->real_cyl = private->rdc_data.long_no_cyl;
+	else
+		private->real_cyl = private->rdc_data.no_cyl;
+
 	DEV_MESSAGE(KERN_INFO, device,
 		    "%04X/%02X(CU:%04X/%02X) Cyl:%d Head:%d Sec:%d",
 		    private->rdc_data.dev_type,
 		    private->rdc_data.dev_model,
 		    private->rdc_data.cu_type,
 		    private->rdc_data.cu_model.model,
-		    private->rdc_data.no_cyl,
+		    private->real_cyl,
 		    private->rdc_data.trk_per_cyl,
 		    private->rdc_data.sec_per_trk);
 	return 0;
@@ -1157,8 +1169,6 @@ dasd_eckd_end_analysis(struct dasd_block
 	}
 
 	private->uses_cdl = 1;
-	/* Calculate number of blocks/records per track. */
-	blk_per_trk = recs_per_track(&private->rdc_data, 0, block->bp_block);
 	/* Check Track 0 for Compatible Disk Layout */
 	count_area = NULL;
 	for (i = 0; i < 3; i++) {
@@ -1200,14 +1210,14 @@ dasd_eckd_end_analysis(struct dasd_block
 		block->s2b_shift++;
 
 	blk_per_trk = recs_per_track(&private->rdc_data, 0, block->bp_block);
-	block->blocks = (private->rdc_data.no_cyl *
+	block->blocks = (private->real_cyl *
 			  private->rdc_data.trk_per_cyl *
 			  blk_per_trk);
 
 	DEV_MESSAGE(KERN_INFO, device,
 		    "(%dkB blks): %dkB at %dkB/trk %s",
 		    (block->bp_block >> 10),
-		    ((private->rdc_data.no_cyl *
+		    ((private->real_cyl *
 		      private->rdc_data.trk_per_cyl *
 		      blk_per_trk * (block->bp_block >> 9)) >> 1),
 		    ((blk_per_trk * block->bp_block) >> 10),
@@ -1262,7 +1272,8 @@ dasd_eckd_format_device(struct dasd_devi
 	struct eckd_count *ect;
 	struct ccw1 *ccw;
 	void *data;
-	int rpt, cyl, head;
+	int rpt;
+	struct ch_t address;
 	int cplength, datasize;
 	int i;
 	int intensity = 0;
@@ -1270,24 +1281,25 @@ dasd_eckd_format_device(struct dasd_devi
 
 	private = (struct dasd_eckd_private *) device->private;
 	rpt = recs_per_track(&private->rdc_data, 0, fdata->blksize);
-	cyl = fdata->start_unit / private->rdc_data.trk_per_cyl;
-	head = fdata->start_unit % private->rdc_data.trk_per_cyl;
+	set_ch_t(&address,
+		 fdata->start_unit / private->rdc_data.trk_per_cyl,
+		 fdata->start_unit % private->rdc_data.trk_per_cyl);
 
 	/* Sanity checks. */
 	if (fdata->start_unit >=
-	    (private->rdc_data.no_cyl * private->rdc_data.trk_per_cyl)) {
-		DEV_MESSAGE(KERN_INFO, device, "Track no %d too big!",
+	    (private->real_cyl * private->rdc_data.trk_per_cyl)) {
+		DEV_MESSAGE(KERN_INFO, device, "Track no %u too big!",
 			    fdata->start_unit);
 		return ERR_PTR(-EINVAL);
 	}
 	if (fdata->start_unit > fdata->stop_unit) {
-		DEV_MESSAGE(KERN_INFO, device, "Track %d reached! ending.",
+		DEV_MESSAGE(KERN_INFO, device, "Track %u reached! ending.",
 			    fdata->start_unit);
 		return ERR_PTR(-EINVAL);
 	}
 	if (dasd_check_blocksize(fdata->blksize) != 0) {
 		DEV_MESSAGE(KERN_WARNING, device,
-			    "Invalid blocksize %d...terminating!",
+			    "Invalid blocksize %u...terminating!",
 			    fdata->blksize);
 		return ERR_PTR(-EINVAL);
 	}
@@ -1389,8 +1401,8 @@ dasd_eckd_format_device(struct dasd_devi
 	if (intensity & 0x01) {	/* write record zero */
 		ect = (struct eckd_count *) data;
 		data += sizeof(struct eckd_count);
-		ect->cyl = cyl;
-		ect->head = head;
+		ect->cyl = address.cyl;
+		ect->head = address.head;
 		ect->record = 0;
 		ect->kl = 0;
 		ect->dl = 8;
@@ -1404,8 +1416,8 @@ dasd_eckd_format_device(struct dasd_devi
 	if ((intensity & ~0x08) & 0x04) {	/* erase track */
 		ect = (struct eckd_count *) data;
 		data += sizeof(struct eckd_count);
-		ect->cyl = cyl;
-		ect->head = head;
+		ect->cyl = address.cyl;
+		ect->head = address.head;
 		ect->record = 1;
 		ect->kl = 0;
 		ect->dl = 0;
@@ -1418,8 +1430,8 @@ dasd_eckd_format_device(struct dasd_devi
 		for (i = 0; i < rpt; i++) {
 			ect = (struct eckd_count *) data;
 			data += sizeof(struct eckd_count);
-			ect->cyl = cyl;
-			ect->head = head;
+			ect->cyl = address.cyl;
+			ect->head = address.head;
 			ect->record = i + 1;
 			ect->kl = 0;
 			ect->dl = fdata->blksize;
Index: quilt-2.6/drivers/s390/block/dasd_eckd.h
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_eckd.h
+++ quilt-2.6/drivers/s390/block/dasd_eckd.h
@@ -48,6 +48,11 @@
 #define PSF_ORDER_PRSSD 0x18
 #define PSF_ORDER_SSC	0x1D
 
+/*
+ * Size that is reportet for large volumes in the old 16-bit no_cyl field
+ */
+#define LV_COMPAT_CYL 0xFFFE
+
 /*****************************************************************************
  * SECTION: Type Definitions
  ****************************************************************************/
@@ -228,7 +233,8 @@ struct dasd_eckd_characteristics {
 	__u8 factor7;
 	__u8 factor8;
 	__u8 reserved2[3];
-	__u8 reserved3[10];
+	__u8 reserved3[6];
+	__u32 long_no_cyl;
 } __attribute__ ((packed));
 
 /* elements of the configuration data */
@@ -406,6 +412,7 @@ struct dasd_eckd_private {
 	int uses_cdl;
 	struct attrib_data_t attrib;	/* e.g. cache operations */
 	struct dasd_rssd_features features;
+	u32 real_cyl;
 
 	/* alias managemnet */
 	struct dasd_uid uid;
Index: quilt-2.6/drivers/s390/block/dasd_int.h
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_int.h
+++ quilt-2.6/drivers/s390/block/dasd_int.h
@@ -378,7 +378,7 @@ struct dasd_block {
 	struct block_device *bdev;
 	atomic_t open_count;
 
-	unsigned long blocks;	   /* size of volume in blocks */
+	unsigned long long blocks; /* size of volume in blocks */
 	unsigned int bp_block;	   /* bytes per block */
 	unsigned int s2b_shift;	   /* log2 (bp_block/512) */
 
Index: quilt-2.6/drivers/s390/block/dasd_ioctl.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_ioctl.c
+++ quilt-2.6/drivers/s390/block/dasd_ioctl.c
@@ -146,7 +146,7 @@ static int dasd_format(struct dasd_block
 	}
 
 	DBF_DEV_EVENT(DBF_NOTICE, base,
-		      "formatting units %d to %d (%d B blocks) flags %d",
+		      "formatting units %u to %u (%u B blocks) flags %u",
 		      fdata->start_unit,
 		      fdata->stop_unit, fdata->blksize, fdata->intensity);
 
@@ -170,7 +170,7 @@ static int dasd_format(struct dasd_block
 		if (rc) {
 			if (rc != -ERESTARTSYS)
 				DEV_MESSAGE(KERN_ERR, base,
-					    " Formatting of unit %d failed "
+					    " Formatting of unit %u failed "
 					    "with rc = %d",
 					    fdata->start_unit, rc);
 			return rc;
Index: quilt-2.6/drivers/s390/block/dasd_proc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_proc.c
+++ quilt-2.6/drivers/s390/block/dasd_proc.c
@@ -112,7 +112,7 @@ dasd_devices_show(struct seq_file *m, vo
 			seq_printf(m, "n/f	 ");
 		else
 			seq_printf(m,
-				   "at blocksize: %d, %ld blocks, %ld MB",
+				   "at blocksize: %d, %lld blocks, %lld MB",
 				   block->bp_block, block->blocks,
 				   ((block->bp_block >> 9) *
 				    block->blocks) >> 11);
Index: quilt-2.6/fs/partitions/ibm.c
===================================================================
--- quilt-2.6.orig/fs/partitions/ibm.c
+++ quilt-2.6/fs/partitions/ibm.c
@@ -21,20 +21,38 @@
  * compute the block number from a
  * cyl-cyl-head-head structure
  */
-static inline int
+static sector_t
 cchh2blk (struct vtoc_cchh *ptr, struct hd_geometry *geo) {
-        return ptr->cc * geo->heads * geo->sectors +
-	       ptr->hh * geo->sectors;
+
+	sector_t cyl;
+	__u16 head;
+
+	/*decode cylinder and heads for large volumes */
+	cyl = ptr->hh & 0xFFF0;
+	cyl <<= 12;
+	cyl |= ptr->cc;
+	head = ptr->hh & 0x000F;
+	return cyl * geo->heads * geo->sectors +
+	       head * geo->sectors;
 }
 
 /*
  * compute the block number from a
  * cyl-cyl-head-head-block structure
  */
-static inline int
+static sector_t
 cchhb2blk (struct vtoc_cchhb *ptr, struct hd_geometry *geo) {
-        return ptr->cc * geo->heads * geo->sectors +
-		ptr->hh * geo->sectors +
+
+	sector_t cyl;
+	__u16 head;
+
+	/*decode cylinder and heads for large volumes */
+	cyl = ptr->hh & 0xFFF0;
+	cyl <<= 12;
+	cyl |= ptr->cc;
+	head = ptr->hh & 0x000F;
+	return	cyl * geo->heads * geo->sectors +
+		head * geo->sectors +
 		ptr->b;
 }
 
@@ -43,14 +61,15 @@ cchhb2blk (struct vtoc_cchhb *ptr, struc
 int
 ibm_partition(struct parsed_partitions *state, struct block_device *bdev)
 {
-	int blocksize, offset, size,res;
-	loff_t i_size;
+	int blocksize, res;
+	loff_t i_size, offset, size, fmt_size;
 	dasd_information2_t *info;
 	struct hd_geometry *geo;
 	char type[5] = {0,};
 	char name[7] = {0,};
 	union label_t {
-		struct vtoc_volume_label vol;
+		struct vtoc_volume_label_cdl vol;
+		struct vtoc_volume_label_ldl lnx;
 		struct vtoc_cms_label cms;
 	} *label;
 	unsigned char *data;
@@ -85,14 +104,16 @@ ibm_partition(struct parsed_partitions *
 	if (data == NULL)
 		goto out_readerr;
 
-	strncpy (type, data, 4);
-	if ((!info->FBA_layout) && (!strcmp(info->type, "ECKD")))
-		strncpy(name, data + 8, 6);
-	else
-		strncpy(name, data + 4, 6);
 	memcpy(label, data, sizeof(union label_t));
 	put_dev_sector(sect);
 
+	if ((!info->FBA_layout) && (!strcmp(info->type, "ECKD"))) {
+		strncpy(type, label->vol.vollbl, 4);
+		strncpy(name, label->vol.volid, 6);
+	} else {
+		strncpy(type, label->lnx.vollbl, 4);
+		strncpy(name, label->lnx.volid, 6);
+	}
 	EBCASC(type, 4);
 	EBCASC(name, 6);
 
@@ -110,36 +131,54 @@ ibm_partition(struct parsed_partitions *
 			/*
 			 * VM style CMS1 labeled disk
 			 */
+			blocksize = label->cms.block_size;
 			if (label->cms.disk_offset != 0) {
 				printk("CMS1/%8s(MDSK):", name);
 				/* disk is reserved minidisk */
-				blocksize = label->cms.block_size;
 				offset = label->cms.disk_offset;
 				size = (label->cms.block_count - 1)
 					* (blocksize >> 9);
 			} else {
 				printk("CMS1/%8s:", name);
 				offset = (info->label_block + 1);
-				size = i_size >> 9;
+				size = label->cms.block_count
+					* (blocksize >> 9);
 			}
+			put_partition(state, 1, offset*(blocksize >> 9),
+				      size-offset*(blocksize >> 9));
 		} else {
-			/*
-			 * Old style LNX1 or unlabeled disk
-			 */
-			if (strncmp(type, "LNX1", 4) == 0)
-				printk ("LNX1/%8s:", name);
-			else
+			if (strncmp(type, "LNX1", 4) == 0) {
+				printk("LNX1/%8s:", name);
+				if (label->lnx.ldl_version == 0xf2) {
+					fmt_size = label->lnx.formatted_blocks
+						* (blocksize >> 9);
+				} else if (!strcmp(info->type, "ECKD")) {
+					/* formated w/o large volume support */
+					fmt_size = geo->cylinders * geo->heads
+					      * geo->sectors * (blocksize >> 9);
+				} else {
+					/* old label and no usable disk geometry
+					 * (e.g. DIAG) */
+					fmt_size = i_size >> 9;
+				}
+				size = i_size >> 9;
+				if (fmt_size < size)
+					size = fmt_size;
+				offset = (info->label_block + 1);
+			} else {
+				/* unlabeled disk */
 				printk("(nonl)");
-			offset = (info->label_block + 1);
-			size = i_size >> 9;
-		}
-		put_partition(state, 1, offset*(blocksize >> 9),
+				size = i_size >> 9;
+				offset = (info->label_block + 1);
+			}
+			put_partition(state, 1, offset*(blocksize >> 9),
 				      size-offset*(blocksize >> 9));
+		}
 	} else if (info->format == DASD_FORMAT_CDL) {
 		/*
 		 * New style CDL formatted disk
 		 */
-		unsigned int blk;
+		sector_t blk;
 		int counter;
 
 		/*
@@ -166,7 +205,8 @@ ibm_partition(struct parsed_partitions *
 				/* skip FMT4 / FMT5 / FMT7 labels */
 				if (f1.DS1FMTID == _ascebc['4']
 				    || f1.DS1FMTID == _ascebc['5']
-				    || f1.DS1FMTID == _ascebc['7']) {
+				    || f1.DS1FMTID == _ascebc['7']
+				    || f1.DS1FMTID == _ascebc['9']) {
 					blk++;
 					data = read_dev_sector(bdev, blk *
 							       (blocksize/512),
@@ -174,8 +214,9 @@ ibm_partition(struct parsed_partitions *
 					continue;
 				}
 
-				/* only FMT1 valid at this point */
-				if (f1.DS1FMTID != _ascebc['1'])
+				/* only FMT1 and 8 labels valid at this point */
+				if (f1.DS1FMTID != _ascebc['1'] &&
+				    f1.DS1FMTID != _ascebc['8'])
 					break;
 
 				/* OK, we got valid partition data */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
