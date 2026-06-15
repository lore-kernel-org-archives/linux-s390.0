Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6B33EFFCC;
	Mon, 15 Jun 2026 12:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527377; cv=none; b=Dl0YtiqON5sG0aQcCLT5hD4HehYKi5NsfzonUw6OctCPuktXcH48EL0LB6o3eCXfcOIJ6r+smABixf+1/Qm3+uc2mHrHjtp0khdaayN4M0h9ae88/+SzKWVD7aqh6eMSJxNfn3bDbxYdK+zzRJiO01AtZkWtQLMeGt/irOS7l9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527377; c=relaxed/simple;
	bh=30Wzo3dt3gVvMiPTCAupayC1M/JJeYgFnL6VnS5jFeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coYHoNxrF1Lfpv+6ivFcWpNxY2UATxrz0ApW7Retdck/g0633EgkBxXJ6wsx4HXIG78kRC9TjH51FtfPluthtZJIEcm1c/wUVwybuIc2diouEj++Ug4KOr9kyZmNfQm8ioK+z5AXFAxQ35ZgBfFKuwPgs/Zjd/aqLmI8iB5dSvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SNFV1jXY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SNFV1jXY"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FAqaCP2270919;
	Mon, 15 Jun 2026 12:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5BcQRrWBzAuCHIN4+
	bZgaoFrl+yQq3ApJidRcqAy200=; b=SNFV1jXYcbITXqPrLy6nXo+cdRMe/XJMk
	2GD+OTBhU2S1LJj9WijDYOPeme+TVhnf+gqTp8B8wg+TRHLcQrHwGFMdjioJEIfq
	S2KSGCI0TRaAPdYR+cMsyxrzLIN/xX67xxDsgN8GKPVE8kSBIZEVROq8avrBhhhN
	Y8OkuozGP3i+FXbSveb2aML85It5FhSP9Yf+D3HR4wxo8sD3raZ6M+2IN7Ns04Hq
	exn12g/yPb6elGkCas8e87A06yIEIWH+kceMIglvttAVaFazMweQihaXFYsU5Q0A
	hGj/5c9PXGLNE50uIfWnZwJEvmAytnGJ4mHSfX9uUX9PZVRGo0izw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1eg03jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FCYhNa004888;
	Mon, 15 Jun 2026 12:42:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshwvxnt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FCgm9x50069914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 12:42:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36CF720040;
	Mon, 15 Jun 2026 12:42:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C30612004B;
	Mon, 15 Jun 2026 12:42:47 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.31.49])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 12:42:47 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 08/17] KVM: s390: Allow for 2G hugepages
Date: Mon, 15 Jun 2026 14:42:34 +0200
Message-ID: <20260615124243.187614-9-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615124243.187614-1-imbrenda@linux.ibm.com>
References: <20260615124243.187614-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX4JWHcFi7Nnkv
 m4gWrDfc+JIq2Oaz9CgU89AfDhsV6x5/rXV8xQQQj4mbZT+UftYA94Hj9/GY9h1BucUTsbYrcub
 w9gl4HSGogOQqwkjBhBCroFv+I7OVqg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX9W6vsbyCc6GJ
 K3r07A0fMzMxvScYEhwO2qlBZLllPUiOXxdm5gWmdiEqu2GjCdqK+aSOuc57ishNSIyti69ZcNQ
 Itcnj27JKIZxLa4HrSLsfwopF0O4sXvqmj4SlVJUHaRGeoHPKf4TpMCxSpYjxaDXkuYqq95958i
 IeNExvqL+omFD9cIx0KxQ/4iJ+IvF86kVTY2OHrqHERF153tAUK7wJdFoCgzQmyqE82n0MtQ1DR
 SLWh0uvXc5K80V5jfpL5J186w6t/5HnEewlZUHywfHMrtb4yS5bXvNNWNXpTNZbOeWGb1OfG1+s
 mRcHqQkzc4B6dwWvSlYz+WTOsoyYt5PdXzbE/ySro/ucXBkQO+dQksl7mHuEzl0Go1rr8ai9JOh
 J98eCKA5DTUF1dXH+YbnbnOuMoAjvZ/LvTkNwhkxD1pYVHd9+EXCL3R83VNqfsf+2nfZ04OXzhF
 0BrEj3l2gaLQQMDZ34A==
X-Proofpoint-GUID: xv5xSJIIHV_8rakVNHigIbPC1Mk1sFZD
X-Authority-Analysis: v=2.4 cv=NuDhtcdJ c=1 sm=1 tr=0 ts=6a2ff34e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=jBZgYMDF7q3Z6fg6dRgA:9
X-Proofpoint-ORIG-GUID: xv5xSJIIHV_8rakVNHigIbPC1Mk1sFZD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150130

Change gmap_2g_allowed() to perform the necessary checks to allow for
2G hugepages to be used, instead of returning false. The
GMAP_FLAG_ALLOW_HPAGE_2G gmap flag is now taken into account.

Also add appropriate kerneldoc comments.

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260609150930.665370-4-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index f8bd6c135e3c..402573cb2590 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -624,10 +624,27 @@ int gmap_try_fixup_minor(struct gmap *gmap, struct guest_fault *fault)
 	return rc;
 }
 
+/**
+ * gmap_2g_allowed() - Check whether a 2G hugepage is allowed.
+ * @gmap: The gmap of the guest.
+ * @f: Describes the fault that is being resolved.
+ * @slot: The memslot the faulting address belongs to.
+ *
+ * The function checks whether the GMAP_FLAG_ALLOW_HPAGE_2G flag is set for
+ * @gmap, whether the offset of the address in the 2G virtual frame is the
+ * same as the offset in the physical 2G frame, and finally whether the whole
+ * 2G page would fit in the given memslot.
+ *
+ * Return: true if a 2G hugepage is allowed to back the faulting address, false
+ *         otherwise.
+ */
 static inline bool gmap_2g_allowed(struct gmap *gmap, struct guest_fault *f,
 				   struct kvm_memory_slot *slot)
 {
-	return false;
+	return test_bit(GMAP_FLAG_ALLOW_HPAGE_2G, &gmap->flags) &&
+	       !((f->gfn ^ f->pfn) & ~_REGION3_FR_MASK) &&
+	       slot->base_gfn <= ALIGN_DOWN(f->gfn, _PAGES_PER_REGION3) &&
+	       slot->base_gfn + slot->npages >= ALIGN(f->gfn + 1, _PAGES_PER_REGION3);
 }
 
 /**
-- 
2.54.0

