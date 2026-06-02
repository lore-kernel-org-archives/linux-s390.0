Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4615E3AB5B2;
	Tue,  2 Jun 2026 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410247; cv=none; b=dIcPMsrQSkfYbF6yX+5U6EnhwY3m+KFAt2uGR5AtK+3bihuIcU3mjeKvQZApz1/zcruzCTYmb1RolbxKZ7vDeemER/ceIhyZiOHB54Y3EYmHb9Eh9hI9uiGIZuPpRE1Mse7JLm5g4PYUXvXLdc8cRR+oUxG3hlWYzZ2ffJK3rFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410247; c=relaxed/simple;
	bh=PFeMKJR8nR7wr+MoY/+dZNvE3wZJ8jFHROaaMChHhQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9KKCFzHZ21nwtAZBP8eES56+vVI0SmINEZpWQkovbQDDUgy5ZzNWC2NYb0Tcx0efio9HOxnUGW7A1ZrkzSMaLGGjgmGJNl2hNauov8MyBOBdNXnXk+rRR0tyhbWVPPka28Yns2CPRT/7NG06j/5ebCRYyCn+xMSYOrgA9AAWL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XwkZq1+M; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XwkZq1+M"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6524ZR0h798759;
	Tue, 2 Jun 2026 14:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lmk3DeMg100OdUmml
	UuLjTKMHcFnlbhpGWHXgUhCo4U=; b=XwkZq1+Md75p7OhIE2OYXhkSGdhP97brz
	i7N7MyFhAAvqGgc9AqNUHHiUmY69N0WW21zjI8u1UL2Kue7NvkDZn1cMK8ceF71x
	run+W0s5BKWiB04ledxqsIkI5Q5nhtTvGggnr2Brz2C7wPB8T4jeiqcsmpHustDc
	2+L0pHnG1NbVy9WOvYUWZRqfnJAk/pFU/wpsaqTyRHbAo8ByFm5hIuD+rUk8EztO
	I+i6vmpt9CIlZ/S385KRhWKOsopI5W2Q2/W81y869w91C2ghFU9Mkgyok27XW/Mt
	wGq1Dr4V0xt1zI9/CKF3p1EfJsr2Jx1q4ZEoS63/ok/wOeZzyj00A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjq6auv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 14:24:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652E9AjC014051;
	Tue, 2 Jun 2026 14:24:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegkcjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 14:24:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652ENvcX47776014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 14:23:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4639520040;
	Tue,  2 Jun 2026 14:23:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C51620043;
	Tue,  2 Jun 2026 14:23:57 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 14:23:57 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 02/10] KVM: s390: Fix _gmap_crstep_xchg_atomic()
Date: Tue,  2 Jun 2026 16:23:48 +0200
Message-ID: <20260602142356.169458-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602142356.169458-1-imbrenda@linux.ibm.com>
References: <20260602142356.169458-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mK-E2199bP7qROiRrK1e9vVW50MfiwX4
X-Proofpoint-GUID: mK-E2199bP7qROiRrK1e9vVW50MfiwX4
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a1ee784 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=SMUcQ3FjFaoWpPRfvsEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDEzNiBTYWx0ZWRfX++PmWS8MxZfb
 rNmPedLv85al9ieEw5VQZUCGm4kIcxeMM0N+8JmEl0SCjfnWLLMNqjZHwEb2xKlMyfkjhGpcvf4
 hVGdFRnyXphBSbFpth8qWt2wnOYtxYO4fDjggZgGFz7H4LPRHo78Xnsxsp2w4eUTN8U+jJyJWnv
 g4w/04gY/ThJjFWlv/wFAsbNx0yHXXlsEc5wbeFCpJ5QbYPxZYU1RHF7vnQlozcbL/OxSU3SkYV
 pKwHEwgfXwAfEXRCx2+J6tZ+FYMrZWR3N/uUBXb/8Dq2iNytzxS542Ee3k95gsZXxPldpShqyfQ
 RRoRPzDDwVvswq/q7N1sfnlBBSKyKBFlMmI9IJn3OtTd3pAdI19KS2/5x87AbEZwgKdZBQgFYxE
 tPO+idcyU9rWoi76WToH3Fg+hk5MHLUZJuHjiuvVHt4IE2kVbF3ikAgcUzmpMMmgmYh1O7bx02g
 ruLw+4t3Q8Axt+CJpkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020136

The previous incorrect behaviour cleared the vsie_notif bit without
returning false, which allowed shadow crstes to be installed without
the vsie_notif bit.

Return false and do not perform the operation if an unshadow event has
been triggered, but still attempt to clear the vsie_notif bit from the
existing crste.

This will prevent the installation of shadow crstes without vsie_notif
bit and will also prevent the caller from looping forever if it was
not checking for the sg->invalidated flag.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: b827ef02f409 ("KVM: s390: Remove non-atomic dat_crstep_xchg()")
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
---
 arch/s390/kvm/gmap.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
index 742e42a31744..5374f21aaf8d 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap.h
@@ -273,11 +273,14 @@ static inline bool __must_check _gmap_crstep_xchg_atomic(struct gmap *gmap, unio
 		gmap_unmap_prefix(gmap, gfn, gfn + align);
 	}
 	if (crste_leaf(oldcrste) && crste_needs_unshadow(oldcrste, newcrste)) {
+		newcrste = oldcrste;
 		newcrste.s.fc1.vsie_notif = 0;
 		if (needs_lock)
 			gmap_handle_vsie_unshadow_event(gmap, gfn);
 		else
 			_gmap_handle_vsie_unshadow_event(gmap, gfn);
+		dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, gmap->asce);
+		return false;
 	}
 	if (!oldcrste.s.fc1.d && newcrste.s.fc1.d && !newcrste.s.fc1.s)
 		SetPageDirty(phys_to_page(crste_origin_large(newcrste)));
-- 
2.54.0

