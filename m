Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D2E48E0FF;
	Wed,  7 Oct 2026 11:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373362; cv=none; b=k5ACx1XfxF9xKdD3uJ6OqBcnXyGlWgPt9ZxUMrPyHJfv7FyRGG5DK42Oc7uWplpnVmtRS3vhonW9GrCPZc7dFs6mXF/0exbkq6o2FnwjpiMel5entFkp3PDhHUdoCRujlVwuW65fBX2n46MEx/UcxrfkGFRhnTEav8ucwwUGYg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373362; c=relaxed/simple;
	bh=iiur6aY7ihXLVnJsFw+mqcA/BhFnbcUQjaRhNMYXKsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAbz63xGrGRBguykt4v63hYzdz+tt1LQWYOv4ltMETF8T0q2tV2/cC4+w3NObSioVYqIZsqMDee4JTA33BtSMwH2wu5iKdARA0jxGAAVdNJF4jxoEdfZHjZgo5BAn/clfulu7W84dDPlTMmD8/oHbWi1u7+qP6uyhI4TkFFV/CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HndN3FPf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HndN3FPf"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZj7Z2463294;
	Wed, 7 Oct 2026 11:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1LiOmrvlTfjWNHeBp
	GO5NZA+KzANzlXnyAx48w5onXo=; b=HndN3FPf8RXcbff/1GB3yZ1FKD4Df0Jj7
	fD/+aMpTeAVHvEX4fgTr90VS8wU9dtwkoV5xN8Opm5n9grjYBgd0dtFGAYs32nQ+
	X02dNSb5JG0XX++QVkpR6BNP4V7F/n0j9HR/K2xVjXl6/YI9LbiusaoDayxmvkqF
	3HEgGDLTJArR4Pt2GjEzZcqQJnTNlm4Vf03+eH8bTEL19RGsb4m5GHfOGUzkH27z
	KcB1hFR6xrXkfS9gEkLuaBowDbFGokN3iV8g6M0gUq3Y58d+G0Qr1qDqb75PHaAE
	APh/O618Pf0RRLo83jgDnaBceekxcheFbwo/bQrS2RnOMNRO8E/sw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74w8c4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697BX72E1852621;
	Wed, 7 Oct 2026 11:42:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgxauf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:42:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697Bfxs328181036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 11:41:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 639FD2004D;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18FED20049;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  7 Oct 2026 11:41:59 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 8BFD1160A17; Wed, 07 Oct 2026 13:41:58 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Muhammad Usama Anjum <usama.anjum@arm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: [PATCH v8 09/15] xen: use hw_pte_t for PTE range callbacks
Date: Wed,  7 Oct 2026 13:41:52 +0200
Message-ID: <50a0425734a973b4432f754587621c71d5abd14f.1791365932.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1791365932.git.agordeev@linux.ibm.com>
References: <cover.1791365932.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 29khGV0tqgVaj7j2p1ac_N_w6nKzZrc-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX1+hlbpnBjlVB
 iT13GyfVrrfT74HouY5VkD78x+F5kYiNlXBBZoJftxtJbDFltP8Yx3DdBte5wfMHPQg1BBg1Gu6
 e5FCX7rB5Pmdg3WWpUMizm/kD6F2flw=
X-Proofpoint-GUID: NZWHIrnsolE5RFvuKq9V-erZ0nRhquxZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX+qq6cPOmMC3E
 EnvmsjIv06vjpvF/KVaEuzrbSk+qw3TnRWuIJ48BQZITz8qPahXIBvz/XxAIJXSdf99LHpC4wfT
 9f84NyDwAvm3gmx3euNzLchrGNYBCNQfhiGTcDJ7dKauc6ZCL6oDb4P3XpPXQQyXXF358c/xK6h
 nKSOYRUzOPF7+x3dN5zcLqt2u9SGsaq5Kra2KnQDgXxdtFBDWmI3YmdsXMKtvnCuC75kHrgEbB3
 M+FONX64lDPOttbcYi9h5CTvUzqLMd7KlRjspIegsr6eSx6WK55KcwRA4PsW6DSY+7atOssJ/yf
 mQlw/jefP4PQ6cxLzfLq77T3CHz1WTCdP2/vMN/zaSNyGfPZEoCFERoxr/NCSl7onuj+p6WivaC
 KNsjFRhUJVRsWFXbZEyrpnZIS7bFyml1IybGd+6+XGlHg7SfsOmnIRrPKbrypA3O2Bx8i7ZKwxT
 z96siA1m1vJRgaatllg==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac6300c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=7CQSdrXTAAAA:8 a=iox4zFpeAAAA:8
 a=PZL_jg6TPyYw_DeWY7AA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070046

From: Muhammad Usama Anjum <usama.anjum@arm.com>

Generic PTE range and remapping helpers now pass pointers to PTE table
storage as hw_pte_t *. Update the Xen callbacks to match those interfaces=
.

Keep software PTE values as pte_t and continue to access them through the
existing PTE helpers. This is required when Xen is built for an
architecture that selects the distinct hw_pte_t wrapper.

Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
---
 drivers/xen/gntdev.c               | 2 +-
 drivers/xen/privcmd.c              | 2 +-
 drivers/xen/xenbus/xenbus_client.c | 2 +-
 drivers/xen/xlate_mmu.c            | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 1dcc4675580e..b013bcad99b5 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -301,7 +301,7 @@ void gntdev_put_map(struct gntdev_priv *priv, struct =
gntdev_grant_map *map)
=20
 /* ------------------------------------------------------------------ */
=20
-static int find_grant_ptes(pte_t *pte, unsigned long addr, void *data)
+static int find_grant_ptes(hw_pte_t *pte, unsigned long addr, void *data=
)
 {
 	struct gntdev_grant_map *map =3D data;
 	unsigned int pgnr =3D (addr - map->pages_vm_start) >> PAGE_SHIFT;
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 7cfc28f1bb86..e724cc053e26 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -1658,7 +1658,7 @@ static int privcmd_mmap(struct file *file, struct v=
m_area_struct *vma)
  * on a per pfn/pte basis. Mapping calls that fail with ENOENT
  * can be then retried until success.
  */
-static int is_mapped_fn(pte_t *pte, unsigned long addr, void *data)
+static int is_mapped_fn(hw_pte_t *pte, unsigned long addr, void *data)
 {
 	return pte_none(ptep_get(pte)) ? 0 : -EBUSY;
 }
diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenb=
us_client.c
index 27682cb5e58a..387f97a55559 100644
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -749,7 +749,7 @@ int xenbus_unmap_ring_vfree(struct xenbus_device *dev=
, void *vaddr)
 EXPORT_SYMBOL_GPL(xenbus_unmap_ring_vfree);
=20
 #ifdef CONFIG_XEN_PV
-static int map_ring_apply(pte_t *pte, unsigned long addr, void *data)
+static int map_ring_apply(hw_pte_t *pte, unsigned long addr, void *data)
 {
 	struct map_ring_valloc *info =3D data;
=20
diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
index 8efd7b55223f..d7244f9f9a54 100644
--- a/drivers/xen/xlate_mmu.c
+++ b/drivers/xen/xlate_mmu.c
@@ -93,7 +93,7 @@ static void setup_hparams(unsigned long gfn, void *data=
)
 	info->fgfn++;
 }
=20
-static int remap_pte_fn(pte_t *ptep, unsigned long addr, void *data)
+static int remap_pte_fn(hw_pte_t *ptep, unsigned long addr, void *data)
 {
 	struct remap_data *info =3D data;
 	struct page *page =3D info->pages[info->index++];
@@ -269,7 +269,7 @@ struct remap_pfn {
 	unsigned long i;
 };
=20
-static int remap_pfn_fn(pte_t *ptep, unsigned long addr, void *data)
+static int remap_pfn_fn(hw_pte_t *ptep, unsigned long addr, void *data)
 {
 	struct remap_pfn *r =3D data;
 	struct page *page =3D r->pages[r->i];
--=20
2.53.0

