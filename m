Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7873A3D9035;
	Mon,  8 Jun 2026 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942522; cv=none; b=WLclCGPN659ziNAzMwmPRGorn5wzCkrWVgQ2KGY1BtOXwVN/hwaibjipjpec5sFCrv5tS/0Ch2tc4x60tbH/7KjC/mTJjMfRtXnemIkCDMzxGtBcda3UnP1YL/BiFLvgWbNi6PJEHx3xJZlbJRaavtDvVI4TPHdpGEuKTFIaEZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942522; c=relaxed/simple;
	bh=qWolF4Y3S+HO+T4uRPNwjeV2U2dgXoB68nyfNxJHb4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rc4U2+xOjeltomTFDbWyO+8sZEqEVct4sUvgaagqcyInUSaQCwqcsMiukgSI3CZBHk0W+2+upJQgZjOFuHS0NNc8qyxPJPXRujE4SvuLchixlagLIcjI4e73wCtx+mbnh+U2sbcILePqxjQGrYNt879mYOiAyHyQqY0JMZnsYMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WzHbmv7j; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WzHbmv7j"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658DWSQj2661850;
	Mon, 8 Jun 2026 18:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XbnC7mQ2CCKjbfHIq
	J5fafLzxjlhe0unKwj/TF24/bc=; b=WzHbmv7jJazs36Kj423FnX7cJShIe8+Rr
	U2LYrSwXOCafFeATL83KHlNy20eaCDt5BEplraXolsI3ftK7KHG1kolw84WiXYKk
	2DYLcFSekWrG8OdkYGI3g0iWSf4MIHFhVoBF8xCecP9chu75lz/OuoSrXSbXc/Cm
	w4+70LcvXk8WF1bY5SsB6t33jH6T50RdKu/OX+J7Cl50q/c66Ix1309r0mIYMypj
	SXIx71l0GCJ/JqDU00wOVOmt65UXjPka6phWiEiZJJ80Lx4rAiicMY+l/0+vamB9
	JEzVQs1XeKHDmhmlToh3QWYAo0FZ4kSL3Dp+lB9GYdg7AAOQB5cAQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb958nrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 18:15:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658I4aiX003280;
	Mon, 8 Jun 2026 18:15:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03fxbv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 18:15:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658IEvZe51184006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 18:14:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EFAC2004B;
	Mon,  8 Jun 2026 18:14:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36CC02004D;
	Mon,  8 Jun 2026 18:14:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 18:14:57 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        japo@linux.ibm.com (Jan Polensky)
Subject: [PATCH v6 3/6] rust/bindgen_parameters: Mark s390 types as opaque to prevent repr conflicts
Date: Mon,  8 Jun 2026 20:14:48 +0200
Message-ID: <20260608181451.3734956-4-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608181451.3734956-1-japo@linux.ibm.com>
References: <20260608181451.3734956-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a2706a6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8
 a=_2yia0w1AAAA:8 a=7MZg_RI75Eq2x-0mQykA:9 a=4yAS8WwzZ1jAEY03B-5r:22
X-Proofpoint-ORIG-GUID: nZnCAixn83C8vFUhgsW4B4lDx3tKjYsq
X-Proofpoint-GUID: R4uZvzQjh7xvVsjnY1PckTFll6soZAM_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE3MCBTYWx0ZWRfX1dF0VqaleRfT
 4dBwcY2Pvx+m6zez6TvrJLv17jh2dVbu/vTdIp0Q1lPvpdmjnucAH7DnGMu5TDY3fCavoHiOIbe
 BkbTCwVQEORh7ZX+68bXBGObHqQQLiP+BT/AoNd3E1wCgWI2g1JSZ41VSodWTBFFE8IJmMMXZ67
 DtgSyZU0CcoIjQaGzp42c+9SBJBfvDa6eVWS/NUeue99G6oqMTAUv/3loJeXG+tFtHv5dZAT1r2
 bOD2wDG0WjYYBPFoPryDVsTMuQ30fDujRmOgqnK+TEqa9vBvUdCqstY2oxm+9a8/8uZaovCnrt9
 jeaPzBQ2YQtV7QfNvM3YJkX1u4z7/cFXFSRak0Ph/I+bR5KSpDWXIXCkTFUZbGbzzMPz8nyz97T
 ZYN6dxegY8BUV/a5EQLF29ROmLaYgwjXb01aBm7rtul8TQIQ0Vwswkz6uuhVhExZB+10KdsPeJC
 8qfCbypB3pBJ2QC3uyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080170

Bindgen attempts to generate Rust layouts for a number of s390 structs
that are packed but contain, or transitively contain, aligned fields.
Rust rejects such layouts with E0588 ("packed type cannot transitively
contain a #[repr(align)] type").

Add the affected s390 types to the opaque type list so bindgen emits
opaque blob types instead of full representations. This matches existing
workarounds for x86 types such as alt_instr and x86_msi_data.

Link: https://lore.kernel.org/all/e5c7aa10-590d-0d20-dd3b-385bee2377e7@intel.com/
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
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

