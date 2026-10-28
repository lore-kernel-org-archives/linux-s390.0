Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793213675;
	b=PXJ7cg9FSmlvzqf/RgAiQ3WYer4PjzEiaq3MVo6HEmHhMvRYveDNdbY8MPJgLtMwTWy3
	 Q8NUuNu8TFBViddnvawMd99Xn2X3Y8Uy8C6sHKhV8YY5DHcR6pdMhZnDjxhvzrz4Mj577
	 C+z87MjwB9c+uX11rTYN18BiwWzQloTCRWeIF+/wiLHmBsxfO/LCm2nivKBmMjVAfbIsy
	 nqnEaCziugYaSc+70Y3kdRHNcXTPeTljzda7sMX6qmKaFvaPFQ+NH1TMoiqoI74Cp4Haa
	 /N94/xlzUF2q6KFV8tIt7DEBH+81WnIs56S9VlQw2MT4oJSrnCARgjIE6FL+JYUXHrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213675;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=68kVRADS3+B6EP2J8vzzZ72bTxdXqUSr8stra/Pas4Q=;
	b=kWkg3uFj02ms7oZerp8bglvjGWi8OWxnEEk7Kei9L865bqMDiHBwjHSAsTa1QNtekVxi
	 YfTFG+TYqsguU7uT3eo/aDrGHjkaK8cWxeQbFilYGJs8qOwluTvcOBzpSTlw80rWXgXfk
	 /0XDyQHf70sbcvPLZIDkmQNViBudND6cauKMo3TJ1RWyjch4QmLo1XigJXEh6J2Wpotrd
	 KTaJYDj/xGmFMl8urJPZjOXY3XkQlvC3bWzJtgYJrREMq/BILOEAK4IrQPVizvygXmTKP
	 SlmW131vixK5i3GLb7oIR22/qp6Pio4Zf9w5LsE9YLSxVYijEqPdRqA8pG0CoXUbiaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oYk7oOHW;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBBB606A336;
	Wed, 28 Oct 2026 18:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FBBB606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oYk7oOHW
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SIiL0Y869461;
	Wed, 28 Oct 2026 18:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=68kVRADS3+B6EP2J8
	vzzZ72bTxdXqUSr8stra/Pas4Q=; b=oYk7oOHWWxeP8vaQ7Ufxl1V6NTZZPbsVW
	BrnSQiOxUN67z6k/23fjl+LxIgxIIoj3aEFk/qxlcGlq+ZyNi5I+6vnoqFwX4o5Y
	ivGfUqRWuS0tkASVW8bPGFH37CSCEq4SRB6KhHBiKmDlTtXAJVhVLpMXIUib18SB
	2LZyGi9tgXTmtZNntGxe3c9U874J5EDdcANx4cds1TiUeCTcQQbQOfRf5+zzkClZ
	OrjKlKALzo4jrcrzn8tmcG+gmw4Q1BHOzx11jT/1uF2YOscSs3ubHqyVYsJ04q1v
	Uda7M4eymU834/tLCZ9NEz2WMvje2Mh2G9NJVZOYEDTF+xzZCM7GA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgk3g69fm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 18:54:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SIYrEs2008261;
	Wed, 28 Oct 2026 18:54:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh8gh8pwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 18:54:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SIsNYW41091366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 18:54:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6530120040;
	Wed, 28 Oct 2026 18:54:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4636D2004B;
	Wed, 28 Oct 2026 18:54:23 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.68.31.243])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 18:54:23 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v4 6/7] KVM: s390: Introduce gmap_allocate_all_page_tables_best_effort()
Date: Wed, 28 Oct 2026 19:54:21 +0100
Message-ID: <20261028185422.272146-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028185422.272146-1-imbrenda@linux.ibm.com>
References: <20261028185422.272146-1-imbrenda@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BOMmP1QG c=1 sm=1 tr=0 ts=6ae244e6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=ilytlXuMzrteemsZqbQA:9
X-Proofpoint-ORIG-GUID: yoML6U4-b6l-Iie0RrKxhsn94xOiT2QS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3NCBTYWx0ZWRfX7Ov7PwyEooGV
 0IW4Mye6gVasnvNXFIoniLeWc6zR+Txiumtxb325GQV9dZnK35/J79L8PP1arVa8ERLyrEH/k2S
 uRFyacaM/IMR+hxXaeHi8F6EIJ2Zqq7mopmXKlX+ZGfUmQFQqaFev1RKv9ZkxwKmXSTsLtO1NGo
 YLTgalSi/mmZPGtUwralrXwTLcSsPhDNXERLkEWWFRvxxoKYpuCsgFP7cCDgNJUSGfm+tqStGtZ
 JXVfQ3+52k1KA21zONZDLppnuPBoQ0Nwoj+Z5CrIyh44i8GZx9enGOK5QeIl0WdZwByEhTR+ASh
 O/16JoUxsn2vJqLc2/H/lHuMetrpI7Z00lBidqh4NULKo2bBDJgC8r6e6E//coKvaDey9W86IAB
 KSzdKazeDtJyQ+saMGPwxm9WorT8ZVnG26F/EcX9B3k7STl4ss8oDxmk4P3wPBvXqEByHonjQEN
 vQz+06OwbCzpvLMQ4pg==
X-Proofpoint-GUID: yoML6U4-b6l-Iie0RrKxhsn94xOiT2QS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3NCBTYWx0ZWRfXxeTpvCPoHZGu
 LVPI2gnxAQDng33IR0OH2X23XGp7wAGVPE+DD3f8Lem/CYRJLYjQo//s3WatxuojM18VmTrKd80
 FwIXGo5Yct3NokOy2heL3DGVu1Dp3mY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280074

Introduce gmap_allocate_all_page_tables_best_effort() to attempt to
allocate all page tables of a running guest. This means that all
hugepages will be mapped with 4k pages regardless of the hpage
parameter.

Existing mappings with large pages will be split.

If any memory allocation fails, ignore the error and give up. This is
only a best effort.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: stable@vger.kernel.org # 7.0+: prerequisite for the next patch
---
 arch/s390/kvm/gmap/gmap.c | 37 +++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/gmap/gmap.h |  1 +
 2 files changed, 38 insertions(+)

diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index 04f3ab03a041..3ff08232cbb3 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -1524,3 +1524,40 @@ struct gmap *gmap_create_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *pare
 	}
 	return new;
 }
+
+/* Bail out for any allocation failure. This is only a best effort to allocate all page tables. */
+void gmap_allocate_all_page_tables_best_effort(struct gmap *gmap)
+{
+	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
+	struct kvm_memory_slot *ms;
+	struct kvm_memslots *slots;
+	gfn_t gfn, start, end;
+	union crste *crstep;
+	union pte *ptep;
+	int bkt;
+
+	mc = kvm_s390_new_mmu_cache();
+	if (!mc)
+		return;
+
+	guard(srcu)(&gmap->kvm->srcu);
+
+	slots = kvm_memslots(gmap->kvm);
+	if (!slots || kvm_memslots_empty(slots))
+		return;
+
+	kvm_for_each_memslot(ms, bkt, slots) {
+		start = ALIGN(ms->base_gfn, _PAGE_ENTRIES);
+		end = ALIGN_DOWN(ms->base_gfn + ms->npages, _PAGE_ENTRIES);
+
+		for (gfn = start; gfn < end; gfn += _PAGE_ENTRIES) {
+			if (kvm_s390_mmu_cache_topup(mc))
+				break;
+
+			guard(write_lock)(&gmap->kvm->mmu_lock);
+
+			dat_entry_walk(mc, gfn, gmap->asce, DAT_WALK_ALLOC | DAT_WALK_SPLIT,
+				       TABLE_TYPE_PAGE_TABLE, &crstep, &ptep);
+		}
+	}
+}
diff --git a/arch/s390/kvm/gmap/gmap.h b/arch/s390/kvm/gmap/gmap.h
index 8f47f29c89fd..9b5d394e9146 100644
--- a/arch/s390/kvm/gmap/gmap.h
+++ b/arch/s390/kvm/gmap/gmap.h
@@ -113,6 +113,7 @@ void _gmap_handle_vsie_unshadow_event(struct gmap *parent, gfn_t gfn);
 struct gmap *gmap_create_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *gmap,
 				union asce asce, int edat_level);
 void gmap_split_huge_pages(struct gmap *gmap);
+void gmap_allocate_all_page_tables_best_effort(struct gmap *gmap);
 
 static inline bool uses_skeys(struct gmap *gmap)
 {
-- 
2.56.0

