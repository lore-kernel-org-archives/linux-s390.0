Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400673FB7C7;
	Fri, 29 May 2026 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066700; cv=none; b=U+8B04g++9HAZ0aAFdzEQ/OJWaZ/ankcqRIu3ShUAWpQe9hfEHxPDi8bJww9WzULvCg2TI9EtzdNliapYANU9HDMo4a3dLQ191xkpvF95NKlLqbbu2CcCpw8B5f/qDdXWMmcyXf1BS9VTue5SZGZudtacHBESvy4IhBVkuA0Bxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066700; c=relaxed/simple;
	bh=IWO7Uo2KXbmdRgXy4ayEN3ftvPxNIpRdKDci4TWZnjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4dMkhHHmltRdu+i1K9X6phxHZAGEhaL0pz52UpMDLTms0oG/KAVMHwTgsVu+kOt1/LFr/076RD+DzwFwVGeQY6cteBwC6jf3bqvxI3ULKn92J4P6I4yc81Q5Ml1F+8CjIQfZG0ZJc3fpvGSCwuKkACGEt4MK9IokxmVvh3lhzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gkAGQP5R; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gkAGQP5R"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TBjf0K1467798;
	Fri, 29 May 2026 14:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pphvuZo/ASvzdbuEo
	/WD9Nm83V0JqGg1rFjkIn+HN9o=; b=gkAGQP5RcC8SzmkPasGG9M9kw6fVgyKDs
	4Co4KEebp1VmZd3JQEIG/tErrnXcQemWsgbAvCQgQF/8AMBezrF+W6tupSUjliSY
	MJ1cfApJXOSToUdvOQ3Sx9Bd4AxzXaGN+fLAv4Go7H4QSMMxG5niPwduJA5l68/x
	1d5Itu3cc4cCkXan8EepPkIdrj/OFZJAQVepF0cY/FQwnWjOtpA2ruwmeFFRzyWc
	lEOyW0CYwSEIQbIZIzREltvY0rBPcGIMxreiALkGYGlBKhNvCZ+f7PPdRUpc3D6v
	qdhG3HfF90JlIV5l7qh1h0bEZvIZwP7yuDq3Kete1RSSwBsqs5sFg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee886jjpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 14:58:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TEs8Rk006469;
	Fri, 29 May 2026 14:57:59 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbf5gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 14:57:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TEvtlh15073758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 14:57:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4213520043;
	Fri, 29 May 2026 14:57:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED3EC2004D;
	Fri, 29 May 2026 14:57:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 14:57:54 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/6] rust/bindgen_parameters: Mark s390 types as opaque to prevent repr conflicts
Date: Fri, 29 May 2026 16:57:49 +0200
Message-ID: <20260529145752.1209016-4-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529145752.1209016-1-japo@linux.ibm.com>
References: <20260529145752.1209016-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: EWIHXImlfenCgyctbqHiQXdxCizZA29x
X-Authority-Analysis: v=2.4 cv=Z8Dc2nRA c=1 sm=1 tr=0 ts=6a19a978 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=_2yia0w1AAAA:8
 a=VnNF1IyMAAAA:8 a=7MZg_RI75Eq2x-0mQykA:9 a=4yAS8WwzZ1jAEY03B-5r:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NiBTYWx0ZWRfX1E/tl8E3Q57k
 wH/SCnWRL1rTxRGs0/YqK4fgoKQ6Utg0YBwR9dD4ZFOn/c1lza/awADWt1fhm9Gn8eoNTs88eR5
 Z+o5v+RTIKQG9cLN3sks55KY6x10m5WlkqLjXiVX3gOsI6CuMot3J3uz88pUJQJ7qkLHL4lU9kL
 oIPdid+58AlvZs+muduUbtaW84L8uX2/8QE8EsWYfxXPz2k4lwV3AD7MXqn1zYSnYBHzDXe6kAQ
 4G4WwrkwEoQvoPg7tHDshU9knuNYNTig88A3Bgd/qJa8vjLJFJQkDTx8gJEEsHcCLzhOVsahOX4
 CGGWcIdUa2bMnosiPkBv+Z1WVVZmk8//jiDb9uUz7SusceCSUAJBlqpIrSMSKCKRzFUFJviwtXW
 /wKPi15kO+TJfjarzn03BM1W5hQEeQLcqE/TkLpAY0xntKpJin2w5NLdX1dXxN4sR+IkzwLTWCR
 P348Re2D+qaSzRgKe7A==
X-Proofpoint-ORIG-GUID: LfFPcSpBDPNJXjUOzMLZjGCH7819_j_E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290146

Bindgen attempts to generate Rust layouts for a number of s390 structs
that are packed but contain, or transitively contain, aligned fields.
Rust rejects such layouts with E0588 ("packed type cannot transitively
contain a #[repr(align)] type").

Add the affected s390 types to the opaque type list so bindgen emits
opaque blob types instead of full representations. This matches existing
workarounds for x86 types such as alt_instr and x86_msi_data.

References: https://lore.kernel.org/all/e5c7aa10-590d-0d20-dd3b-385bee2377e7@intel.com/
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
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
2.53.0

