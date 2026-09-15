Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7FE2FD7B1
	for <linux-s390@vger.kernel.org>; Tue, 15 Sep 2026 23:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515762; cv=none; b=rR1Fxha8T1apCzPcgHVLgSej4+iYEIt5EFGy2OfhYEnO9oVQYD5xlmMdyWmbTLfaVj3C55iRquG5FBFHuUAQD9fgSyNN81Ho71L4HZ2uZ2xo29nZZbOs96B7xNoqmxLvygZFnexMZ80lANJ7gUHcaELiQiZ22CDilKFEVdeAwjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515762; c=relaxed/simple;
	bh=dxg52INW+Mj6Q6Lb2jquqMFPjl6/Rh2+AATGon4TcZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RGY6j0Mmyz3DyY5C8Au2XVOd+x9fmqwuVn5NTxGTgm0gRMX6OMINLRE+B6xIl8yIzHT1kBXKVmqlTol3e9yI/PmUYSDwDjUgZsf2Ynq+7wMQqf89K4h7od2t2qyiwW0Ei07ZZXGMIkvqka8faGiwYYM3kccFtkJy7JX8KnTS1UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Oe2VLdiG; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=erM29vpc; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Oe2VLdiG";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="erM29vpc"
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FMbV5u2693018
	for <linux-s390@vger.kernel.org>; Tue, 15 Sep 2026 19:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=uZE/najFT9R5zTEBz7Fhsb26kJ
	qZDk8owuOeuq8Y1m4=; b=Oe2VLdiGVsKZ19PvlL2qhCRXsxSeze/p+R148PoKqk
	JQU/6vxvqL+/5CyvNmq2sQGAWD8vVOmyvHNISYnC9p3ROhXQnEreUKiaMH5vYHrx
	kDhMOv8vW/a+eatdK895SrrI4ycPRWs5yTEjZ+BZil5/f+Nnk91NTJQhfRcyR9ji
	CNOZ+aL8PXpF6epP7fFhIzf6sBllao8JxnOoACzvuMLEG1MlsW9KUArXfFrVMdaV
	PA0luBiyaa6kC7X+G/Vvc7YO0fsSf1t1qeDAZ2qhGMXPYJV3xqsa/cPyVn8q1nuF
	EUK6AdtpUGXuLk6siHS6BHAraJD1j9x34g3Z/hUl5ELg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gq9n5unrt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 15 Sep 2026 19:42:40 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-530d86d40acso101082881cf.3
        for <linux-s390@vger.kernel.org>; Tue, 15 Sep 2026 16:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1789515759; x=1790120559; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uZE/najFT9R5zTEBz7Fhsb26kJqZDk8owuOeuq8Y1m4=;
        b=erM29vpcbDGBHpifWzdJ1M/7wDKmO8O32bCFuDaPmH+gOX+VZMg/0PRn2UluG4t9us
         QS73N9RcBpp/h7QbF/SZkpbaI8mgSzAok9nc2AfaDKM1rkicB9YOqaxYed9bUDEFDZcY
         AidtMuMxofLNbKf5ynz2iKLgJoqv+W6rVMGfW0TQGzWm+RO3fgvMdIRyBjqGQ0ERkoge
         pdJXQZvoY3zAXbu4Kc7PUyZjOcytimnv3pHwyU2bMoIay+RMsM46gGOY/1mJASCwdBKP
         S4N+BWfxPA21aEi6VukWWVIFbsCEDe3y8WivLsqM2yWchxPLI/itvpbOjF3fRmIKDk6E
         +txw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789515759; x=1790120559;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uZE/najFT9R5zTEBz7Fhsb26kJqZDk8owuOeuq8Y1m4=;
        b=BFxrI8F2dW5Cw+4BOBWEbuMzRkOW2nu0lEW18jjB1qLsGLKCauB84yUN99bN+42xrx
         t6iT47fPKVKCu1RdZS9YDHR7DM0slTHmHO7gow5dqH227AoOh8vws1jVSiiSJSISxz8c
         QpKwq6s2jn8jUw0wbvf/doCZr6JA0QbPg5/tfMXO9hCS1d8c+DJjybUirN17oPK0TdOc
         vvQfs/ocjuE8HVjkTHSv6pkcSCrJOmUfu86N5bVX5g+NR23CwpLZQ8bQ6YOlKhc3gfqq
         vgwqsVd9bZ7ShHqfaZSfZzc29OE1iguANCdCEDXpTM2Kub+CeIkqRVUcJuqkrltp3M2C
         nbnA==
X-Forwarded-Encrypted: i=1; AKwUvBwhGOhbcXq2yahqJc4QhncwsnNjYcb4PczEb08H8OM9FEMW3RCfnUXen008+n1z4iQ9pp4W2c8XANmx@vger.kernel.org
X-Gm-Message-State: AFuF++nGXEg44fz1QPKw08+zLH3vrE3L1pXnt1cVvsrNnsWVZnhTSOO7
	ijRlAe2GrgVJAnrp7z2bmcXOv2/AISYv4YmuL/IQ2OWBYrOEvozPcz3XosSMXashgqv/+EEIUz1
	e3KgvAaiOnFL8Qd0AxcyZhyOBHWpzVg6ylIn20UYZcZHg17MRoJqSkjb6Jw4=
X-Gm-Gg: AYBFou0wxXR7LurV3mJm7t3a9zVgI8rK8vE6LrJbmOeaOmDqCzJ6lk/kAX1w0/3agRM
	odZ57nmUiqYbGd0rLCF+R5XXmPx+bEmiMKCk5SgzPfg46NHVKM5WhEiDEFi2Dxwav4j5kV6ECrB
	e9GvI2gu2q7wdhjrlGb0uKP+RYc4Tft4TdPYn5euk2WpdN4U9smGi7US8hgv++c0MLE5Nw+Ug7f
	bWFwur25IZDIoKr0K14gTMrVrfa95WTrU1qrNbPm88OXD5T6pHrx17rs3XtP3lwQDEcFP1itTxZ
	SUQxZgjoF6NANVnJyTQAKC6ydFGCOmPr8517N2bQ2SbRdummugv/rGUyBRK23D2tFKZUkQXFUZs
	lNccZ5MDEr+nDFuhz+XSFBtsaAB0xATcRUu4dxLm62cZYpVIw
X-Received: by 2002:a05:622a:14d1:b0:516:e10f:7140 with SMTP id d75a77b69052e-5327f1aaad1mr8805291cf.35.1789515759173;
        Tue, 15 Sep 2026 16:42:39 -0700 (PDT)
X-Received: by 2002:a05:622a:14d1:b0:516:e10f:7140 with SMTP id d75a77b69052e-5327f1aaad1mr8804961cf.35.1789515758797;
        Tue, 15 Sep 2026 16:42:38 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-179-204.net.columbia.edu. [128.59.179.204])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123be7f316sm11399396d6.25.2026.09.15.16.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 16:42:38 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 15 Sep 2026 19:42:15 -0400
Subject: [PATCH] vmcore: convert mmap_vmcore_fault() to use folios
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-vmcore-fault-folio-v1-1-a0cb6278670f@columbia.edu>
X-B4-Tracking: v=1; b=H4sIANbXqWoC/yXMQQ6CMBBG4auQWTtJHQ2oVzEsoP4DY5CaFogJ4
 e5WWX6L91ZKiIZEt2KliMWShTHjeCjI983Yge2RTeKkdFdX8fLyIYK1mYeJNQwW+NyeLgKoSim
 Uw3eE2uc/vde709w+4affibbtC9g6lTh2AAAA
X-Change-ID: 20260907-vmcore-fault-folio-4b382eeff262
To: Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Dave Young <ruirui.yang@linux.dev>
Cc: linux-mm@kvack.org, linux-s390@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789515757; l=2125;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=dxg52INW+Mj6Q6Lb2jquqMFPjl6/Rh2+AATGon4TcZU=;
 b=vdxoyuEon/H05Tmo1Fpa9qQA+JGXLiAWR1tlAA1+IiA+X8bmd6jRJvtBx0LctZl43TGXziRTe
 +GTwRByLmR/A0o+4UaXDSlvV8ydx7axk3vRrDxpQ8p2sw2e06k6g4vx
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: nEqUkTyf57yRX2YGf4ABx-u2oilEWEnw
X-Proofpoint-ORIG-GUID: nEqUkTyf57yRX2YGf4ABx-u2oilEWEnw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDM0NyBTYWx0ZWRfX31FxYgNZY6FY
 pBjjKyPuMt+nJYCHcbjM5Y1momg5AvVaEKEKkp5DNT6iUx98Fcsv5Lrih+FacSuXWI+TU5CiGXb
 Syze+Rhc/wI3Z8fO8zG1pXkQzY72ZYP4CD81Itc8m57UjbXpdC9Bgu3YSWqtWDlekMUpuKUze7e
 gOARKPKnjFHdEt/cHbFlehkyb9436o50VCkRqgPN5k3AUceW7JRgubwOS0sbMo5rSp/FoBmgP10
 YGSyWMIf0RQxUFqgY95qw5SZam+29FSmNjtalJxt2W+f7Pudj1bQvo9ZYXNUCOF3GznyzPJhpc8
 L6uheU+nRrO0j8DCpQuUbSxcySUUlk8lUz3xMmXcn5mhzZ8MJwdiMLha1tatEmmRdGh8TWfxX4n
 bGqpKC0Epd9U/usuVzktwWmMiusX4LvMEFpJ9NrMNUKGSApwmlZ4frW8Qb2vvuE+XxXW8ovqK1J
 NZ8c6NBv7u9Wear/yNQ==
X-Authority-Analysis: v=2.4 cv=KZVHIgYD c=1 sm=1 tr=0 ts=6aa9d7f0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=hXAsoc/zAxyCEdIRhrpmVw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=LFCUUKIxLatyyoosy-EA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDM0NyBTYWx0ZWRfX0oDn48zL8TcX
 7soLXXtSy++x+I/4PVQ/qStzVd8COgXaKBBjILgqi2Y0RvI8ww6whgsSKX8MK8NoNvNxpH9Iz38
 QxFGF2JyDco62YowL5oDCPTkThdMR9k8R9KGceOvik63edHV7VB4
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11906
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=10 bulkscore=10 clxscore=1011
 phishscore=0 lowpriorityscore=10 adultscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150347

Use a folio for the page cache page the s390 fault handler reads the
old kernel's memory into. This removes four compound_head() calls and
one of the last callers of find_or_create_page().

The vmcore mapping only has order-0 folios, so the logic is unchanged.

Compile tested for s390.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
This is based on the kexec-next branch of the liveupdate tree.
---
 fs/proc/vmcore.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 44d15436439f..2dc3803aa11d 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -474,29 +474,30 @@ static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
 	pgoff_t index = vmf->pgoff;
 	struct iov_iter iter;
 	struct kvec kvec;
-	struct page *page;
+	struct folio *folio;
 	loff_t offset;
 	int rc;
 
-	page = find_or_create_page(mapping, index, GFP_KERNEL);
-	if (!page)
+	folio = __filemap_get_folio(mapping, index,
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, GFP_KERNEL);
+	if (IS_ERR(folio))
 		return VM_FAULT_OOM;
-	if (!PageUptodate(page)) {
-		offset = (loff_t) index << PAGE_SHIFT;
-		kvec.iov_base = page_address(page);
-		kvec.iov_len = PAGE_SIZE;
-		iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, PAGE_SIZE);
+	if (!folio_test_uptodate(folio)) {
+		offset = folio_pos(folio);
+		kvec.iov_base = folio_address(folio);
+		kvec.iov_len = folio_size(folio);
+		iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, folio_size(folio));
 
 		rc = __read_vmcore(&iter, &offset);
 		if (rc < 0) {
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			return vmf_error(rc);
 		}
-		SetPageUptodate(page);
+		folio_mark_uptodate(folio);
 	}
-	unlock_page(page);
-	vmf->page = page;
+	folio_unlock(folio);
+	vmf->page = folio_file_page(folio, index);
 	return 0;
 #else
 	return VM_FAULT_SIGBUS;

---
base-commit: 4d17a004cfd5489f88ad0a7a151dea11a533338b
change-id: 20260907-vmcore-fault-folio-4b382eeff262

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

