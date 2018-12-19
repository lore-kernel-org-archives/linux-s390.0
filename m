From: Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v5 07/15] s390/cio: add function chsc_sgib()
Date: Wed, 19 Dec 2018 20:17:48 +0100
Message-ID: <20181219191756.57973-8-mimu@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219191756.57973-1-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, kvm390-list@tuxmaker.boeblingen.de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch implements the Set Guest Information Block operation
to request association or disassociation of a Guest Information
Block (GIB) with the Adapter Interruption Facility. The operation
is required to receive GIB alert interrupts for guest adapters
in conjunction with AIV and GISA.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
---
 arch/s390/include/asm/cio.h |  1 +
 drivers/s390/cio/chsc.c     | 37 +++++++++++++++++++++++++++++++++++++
 drivers/s390/cio/chsc.h     |  1 +
 3 files changed, 39 insertions(+)

diff --git a/arch/s390/include/asm/cio.h b/arch/s390/include/asm/cio.h
index 225667652069..1727180e8ca1 100644
--- a/arch/s390/include/asm/cio.h
+++ b/arch/s390/include/asm/cio.h
@@ -331,5 +331,6 @@ extern void css_schedule_reprobe(void);
 /* Function from drivers/s390/cio/chsc.c */
 int chsc_sstpc(void *page, unsigned int op, u16 ctrl, u64 *clock_delta);
 int chsc_sstpi(void *page, void *result, size_t size);
+int chsc_sgib(u32 origin);
 
 #endif
diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index a0baee25134c..4159c63a5fd2 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -1382,3 +1382,40 @@ int chsc_pnso_brinfo(struct subchannel_id schid,
 	return chsc_error_from_response(brinfo_area->response.code);
 }
 EXPORT_SYMBOL_GPL(chsc_pnso_brinfo);
+
+int chsc_sgib(u32 origin)
+{
+	struct {
+		struct chsc_header request;
+		u16 op;
+		u8  reserved01[2];
+		u8  reserved02:4;
+		u8  fmt:4;
+		u8  reserved03[7];
+		/* operation data area begin */
+		u8  reserved04[4];
+		u32 gib_origin;
+		u8  reserved05[10];
+		u8  aix;
+		u8  reserved06[4029];
+		struct chsc_header response;
+		u8  reserved07[4];
+	} *sgib_area;
+	int ret;
+
+	spin_lock_irq(&chsc_page_lock);
+	memset(chsc_page, 0, PAGE_SIZE);
+	sgib_area = chsc_page;
+	sgib_area->request.length = 0x0fe0;
+	sgib_area->request.code = 0x0021;
+	sgib_area->op = 0x1;
+	sgib_area->gib_origin = origin;
+
+	ret = chsc(sgib_area);
+	if (ret == 0)
+		ret = chsc_error_from_response(sgib_area->response.code);
+	spin_unlock_irq(&chsc_page_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(chsc_sgib);
diff --git a/drivers/s390/cio/chsc.h b/drivers/s390/cio/chsc.h
index 78aba8d94eec..e57d68e325a3 100644
--- a/drivers/s390/cio/chsc.h
+++ b/drivers/s390/cio/chsc.h
@@ -164,6 +164,7 @@ int chsc_get_channel_measurement_chars(struct channel_path *chp);
 int chsc_ssqd(struct subchannel_id schid, struct chsc_ssqd_area *ssqd);
 int chsc_sadc(struct subchannel_id schid, struct chsc_scssc_area *scssc,
 	      u64 summary_indicator_addr, u64 subchannel_indicator_addr);
+int chsc_sgib(u32 origin);
 int chsc_error_from_response(int response);
 
 int chsc_siosl(struct subchannel_id schid);
-- 
2.13.4
