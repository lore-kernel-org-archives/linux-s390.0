Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278856;
	b=hza6Rn1vGySgGYgSlgfq2YIUqpLUwrOybajkbDXKAH7OEFIu/RdyCdz/DE+neQfR/XS0
	 5McKwfMdz2A/nR+bx/VkmbtfyWlQzHtG6ZFRtV3G2WyUO8ZTgLrZXkv97rkxvXD+aqEN+
	 5AwCd8+T3zEQtP7owikoinPKm8GYy8aBINNpTCEGYCVQKR3dXVlAb0oEGgrHzI4WO6FSx
	 Ub7gAyxB+uHoUJ5B5RFMVZYh2k56+O3MZ/OC7A3GICxKzaYcIhYWOOblHc/d2sZTf9NRm
	 wq7ueHxviE/GU6IZP/OPKuo6Jn9cwSsJVZcmpRCg9/CE5jez/XIgUVcXDFM1kJAU7KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278856;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=gDMF6nh563d1FK6OpPIQbUJiS0W4eUqZXnmocnnyCHI=;
	b=yS8UboPTZdRkJdAgJBj3Vd5WvBorI/JcaTWzEqMBGOcAf2W2cLBzd8EcPZBDccgIAUMx
	 vVVF12Kfn+LQ3xXsB7CuKElgDdIjvp8vGSTdgbC5Fw03sUqPpOfkh3DajDFR1sPDhitmw
	 QIvo9z8REOopiRgywgpzXuarddX5CZuVN9rs6gW9uM1TodEpKL+lBCmACfLLvToZR50ol
	 bnIyjep06HctajUlogReva1U7V1us1oVUFB9BPtfavU9AfKY8uCIVDhGOg6nu+8IoIt7D
	 MIU+iLXwc5LkNhotsKWY0xRbwfFvnAXrkDYyy1QPzNGdrLx5FzpgqkS7x8GmJ2XaWhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UabKjayR;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFE0606A320;
	Thu, 29 Oct 2026 13:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BFE0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UabKjayR
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCiHaW2580895;
	Thu, 29 Oct 2026 13:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gDMF6nh563d1FK6Op
	PIQbUJiS0W4eUqZXnmocnnyCHI=; b=UabKjayRJgGrFraSrNrIUmFbcIoZPV0pA
	ssPHa5vdBxzPZM9CP7dtpl6em9N/5Q1qIdiRzDvZ0wFVlcA8mjYM4CFIKvk9Fzkt
	zYsfhmT7PTslF1Idf18GsYsi+jQawBw5yougYT4th8K4iHb5U434n3E3z2USXLor
	Tu0aFCn4BawrNp3FBUxI7O/TkZWQLDjDs55DtJ0MpnVAMUdliWvQ6T6E9znCVplz
	pyBesl1Lwpx7k4YUnXRFMCOvdv8JjU/nFE1pC3Jrmj3cyJDewSCQvjMSLSVhomSd
	/bUIgcAknuNhcVoc9Vi3W5zRpv1z73TfV40Oh5SEelLRaisGDH54A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmbtaa4w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 13:00:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCnsSA3084952;
	Thu, 29 Oct 2026 13:00:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hjtnnhp3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Oct 2026 13:00:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69TD0jHh44106092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Oct 2026 13:00:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C57F92004B;
	Thu, 29 Oct 2026 13:00:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6CED20043;
	Thu, 29 Oct 2026 13:00:45 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.68.31.243])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Oct 2026 13:00:45 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v5 6/7] KVM: s390: Introduce gmap_enable_cmm()
Date: Thu, 29 Oct 2026 14:00:43 +0100
Message-ID: <20261029130044.125032-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029130044.125032-1-imbrenda@linux.ibm.com>
References: <20261029130044.125032-1-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0OSBTYWx0ZWRfX6VbJ9SPRdXU3
 suYLYPCIxli79XwawO8XJpe1qLy5J7RgA9ggW6R8lsivoxlustyAgCWsnNzWlsMI4LRG/CgT4uo
 0Khz7mK0X93jA0JUN+uhz02kGe5NLhom36kRR7h/yXY0wysJTGerBYwAqebeeOIHlSVjj+FbeDz
 L+x4X8Zt/oiHx7DswV5G+A4qi6gnQUaZxJe3WSOusr60yXCZIpx2fAbTUEB0XoelmPVN/CHjduW
 wkEaCePWKciISUB3PKkrXG6lTLRZaMwHp2rqo+JwR5ORiHyAx5HtX1ZIg0cj2ut45BW1EXEdVYZ
 uJzYf1FY8xHrYJXR3esGQ7K2+9fKcNL2sevYtMmLAgZVuHMwbKF+XcEpOVZS5eiA8krCYW3h4SZ
 KLvXTCRMAkzNI2nN7QbU9Apv8qmRH/vDtBjvRTMIEG6LRQrvVsz5uHOgmidVWcL1z8Kjjhfssy4
 5bZgGPpfpbpVOIp+AHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0OSBTYWx0ZWRfX8ldX82PCnejQ
 wal4qf87tINU7ZhNYzNhMKo7uxB5Lvp8S55ugiUaVCDE5uO95vVvgCli63UUcfbyGnlwx/Sa2BU
 AQ9CS8jOBTgNpI0KtwkOezihBTJZCmA=
X-Proofpoint-ORIG-GUID: HkQENunPVbk3vg_6zc3oovXIioDHjhYP
X-Proofpoint-GUID: HkQENunPVbk3vg_6zc3oovXIioDHjhYP
X-Authority-Analysis: v=2.4 cv=CeKdd7rl c=1 sm=1 tr=0 ts=6ae34384 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=RYenmbwOtGmHXC-y7nAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290049

Introduce gmap_enable_cmm_already_locked() and its locking wrapper
gmap_enable_cmm() to attempt to allocate all page tables of a running
guest. This means that all hugepages will be mapped with 4k pages
regardless of the hpage parameter.

Existing mappings with large pages will be split.

If any memory allocation fails, ignore the error and give up. This is
only a best effort.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: stable@vger.kernel.org # 7.0+: prerequisite for the next patch
---
 arch/s390/kvm/gmap/gmap.c | 37 +++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/gmap/gmap.h | 11 +++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index b9d92bef5459..e0c584ec6906 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -1524,3 +1524,40 @@ struct gmap *gmap_create_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *pare
 	}
 	return new;
 }
+
+/* Bail out for any allocation failure. This is only a best effort to allocate all page tables. */
+void gmap_enable_cmm_already_locked(struct kvm_s390_mmu_cache *mc, struct gmap *gmap)
+{
+	struct kvm_memory_slot *ms;
+	struct kvm_memslots *slots;
+	gfn_t gfn, start, end;
+	union crste *crstep;
+	union pte *ptep;
+	int flags, bkt;
+
+	if (uses_cmm(gmap))
+		return;
+
+	set_bit(GMAP_FLAG_USES_CMM, &gmap->flags);
+
+	slots = kvm_memslots(gmap->kvm);
+	if (!slots || kvm_memslots_empty(slots))
+		return;
+
+	flags = DAT_WALK_ALLOC | DAT_WALK_SPLIT | (uses_skeys(gmap) ? DAT_WALK_USES_SKEYS : 0);
+
+	kvm_for_each_memslot(ms, bkt, slots) {
+		start = ALIGN(ms->base_gfn, _PAGE_ENTRIES);
+		end = ALIGN_DOWN(ms->base_gfn + ms->npages, _PAGE_ENTRIES);
+
+		for (gfn = start; gfn < end; gfn += _PAGE_ENTRIES) {
+			if (kvm_s390_mmu_cache_topup(mc))
+				return;
+
+			guard(write_lock)(&gmap->kvm->mmu_lock);
+
+			dat_entry_walk(mc, gfn, gmap->asce, flags, TABLE_TYPE_PAGE_TABLE,
+				       &crstep, &ptep);
+		}
+	}
+}
diff --git a/arch/s390/kvm/gmap/gmap.h b/arch/s390/kvm/gmap/gmap.h
index 8f47f29c89fd..226fb6595fe4 100644
--- a/arch/s390/kvm/gmap/gmap.h
+++ b/arch/s390/kvm/gmap/gmap.h
@@ -113,6 +113,7 @@ void _gmap_handle_vsie_unshadow_event(struct gmap *parent, gfn_t gfn);
 struct gmap *gmap_create_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *gmap,
 				union asce asce, int edat_level);
 void gmap_split_huge_pages(struct gmap *gmap);
+void gmap_enable_cmm_already_locked(struct kvm_s390_mmu_cache *mc, struct gmap *gmap);
 
 static inline bool uses_skeys(struct gmap *gmap)
 {
@@ -345,4 +346,14 @@ static inline bool gmap_is_shadow_valid(struct gmap *sg, union asce asce, int ed
 	return sg->guest_asce.val == asce.val && sg->edat_level == edat_level;
 }
 
+static inline void gmap_enable_cmm(struct kvm_s390_mmu_cache *mc, struct gmap *gmap)
+{
+	/* CMMA already enabled, nothing to do */
+	if (uses_cmm(gmap))
+		return;
+
+	guard(mutex)(&gmap->kvm->slots_arch_lock);
+
+	gmap_enable_cmm_already_locked(mc, gmap);
+}
 #endif /* ARCH_KVM_GMAP_GMAP_H */
-- 
2.56.0

