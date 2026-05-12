Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC1738E8B1;
	Tue, 12 May 2026 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778583620; cv=none; b=NwhNAXfS4QcOyo0OsKS3VNY0nGFTNU2+KA4mivh/v6xz83RMaiKlQNA02cP+nE2RPe5CO6dHC7v9sfpIIQElb8LIzHvqkjhnfmHZLGZUCjf9mA6yzzawvojcnRSYLPYNhKLzCvFOwNaXuliyOrTpcoBSCWQm+btRqXP1X/iB1+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778583620; c=relaxed/simple;
	bh=Re8+bd2wq8+ZexfcrJuSaZHFiBHz1OF4GU4RxncQ+dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nm2k0IKw9QKgAMebzYze6zXwWD2ae/7xVvpVnXlwLxQUuvgoQnlwGO1X7HcJHeLUCN+DoOahTWvljFOdmFGvisvq9G1uxHr2zCXhSoXn/MESNBdX4It0SwusdBBspWBy2462tSuIFzxPTCj8wTgonpMfrqSXNVU9P5kUIxx/uK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KOINCfbB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KOINCfbB"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK7Z5X2611836;
	Tue, 12 May 2026 10:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=h0yk3VYeg6jg7PMBb
	qESJV6xdZRUSbooCkYHv7lCfbc=; b=KOINCfbBWyJLbN2xazfSOtSKkT2hO9fmw
	/khx5pM/pnFtQ1VmrMKl5N2ToZBLGmLMqYaAP/9SPp9/bG95wc+Ww/DpGKjoxhwA
	lWXpPh+HYr/0vbJV0zIjzw/mm2PrHEsQuIZDwoslMf/4g4SHDW286KHVanSZZIzB
	XA5/3tJdM3uQNavKkEjAAnzMQGG010SaHW2vI7ZOxWeXbXAzMxUTb9NiSzr6RtLi
	3gVrel/2qG3+2QzW0vKjWOByDS+p5WlvVaa9hSkUdr7T+DK24vF40E8SiBlpwMkJ
	Ipd5ogAm61IbYCSfkGefX1bjMJkWyubAn4JAkungvJYixnhkb1PdA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nvdtp3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 10:59:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CAsKnS021920;
	Tue, 12 May 2026 10:59:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgat70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 10:59:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CAxXZ714942488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 10:59:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8504520043;
	Tue, 12 May 2026 10:59:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29C722004F;
	Tue, 12 May 2026 10:59:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 10:59:33 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] rust/bindgen_parameters: Mark s390 types as opaque to prevent repr conflicts
Date: Tue, 12 May 2026 12:59:19 +0200
Message-ID: <20260512105920.2426293-4-japo@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260512105920.2426293-1-japo@linux.ibm.com>
References: <20260512105920.2426293-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Y/XIdBeN c=1 sm=1 tr=0 ts=6a03081a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8
 a=Ulcv6RcHQRQKaI22KjAA:9
X-Proofpoint-GUID: cQvzuh0RaOFnRv8kiQ_h-HjqcEM7g4zz
X-Proofpoint-ORIG-GUID: u77MItQkDtBSHXEejGEAMwyaRXk1qvLj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEwOSBTYWx0ZWRfX65uWPGxstxEq
 mm9oUlhTX7mpzUfYMOnUqfnNDD7RYtfDfW9+wIvfKcul9dSEmFeV4Sby8Kr/6rUrJQeWtPf6X5b
 ifvlfzFYnZrE7K4RlGcKJV71HjHZg9Bq7LjkohtuZl2G1BeIrlkOtFi0t+ytPHNvjHDFErVJrAL
 vcmdBJPbm5FdGsEwDnfrY9Q4odfPqtFXh4r4xXqhvhnfkrtXk7bgAzO+dQKpIsOcVQb38DsWZwo
 BfXbDuwzXDswNPH7il7pASIWOqJNrSVN90T4VqZ5ne7RngG6nlwqUgcZDpb7mDBpl7QipBJGqKM
 /+WFXkGWJSnel1SqPd8zm2MBOM+fUm7B+jHSK+tW7tEnAFHbZepD91csvlB5ikOoxRn0BtIStkF
 4TB9yVIha4rj2+6/LC7Dz40ho6u0CvtLaBokYYVjk8n0LOZSt+/oWmTEKx6vWI7oFQdHpdErLFz
 AQ94WapzXQmX1KdV5fg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120109

Bindgen attempts to generate Rust layouts for a number of s390 structs
that are packed but contain, or transitively contain, aligned fields.
Rust rejects such layouts with E0588 ("packed type cannot transitively
contain a #[repr(align)] type").

Add the affected s390 types to the opaque type list so bindgen emits
opaque blob types instead of full representations. This matches existing
workarounds for x86 types such as alt_instr and x86_msi_data.

References: https://lore.kernel.org/all/e5c7aa10-590d-0d20-dd3b-385bee2377e7@intel.com/
Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 rust/bindgen_parameters | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index 6f02d9720ad2..8402b0c93545 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -14,6 +14,13 @@
 --opaque-type alt_instr
 --opaque-type x86_msi_data
 --opaque-type x86_msi_addr_lo
+# s390-only: same packed/align issue as above (E0588).
+--opaque-type lowcore
+--opaque-type tod_clock
+--opaque-type tpi_info
+--opaque-type uv_cb.*
+--opaque-type uv_secret.*
+--opaque-type zpci_fib
 
 # If SMP is disabled, `arch_spinlock_t` is defined as a ZST which triggers a Rust
 # warning. We don't need to peek into it anyway.
-- 
2.51.0

