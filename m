Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C80B3E00A5;
	Mon,  1 Jun 2026 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336032; cv=none; b=t5nRwA+Qk7rzJTlrjA+DM6A5pyWjNv2GlQPAgGVUFINCSQOqMvh93LMufT29BjWpmnEJ1Ft7jQ3WA5CvSn7Ler4roy23fZbWXiLCrt731cFXP8WW9iEacO7iWWEUnK2hoWS7zO0++tsryDGMpQqN1sntfvmpmO8srAd+alAnjGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336032; c=relaxed/simple;
	bh=Vd7JkkJGwU+ndIOE2hGalsRoLJ3LOkBDeYaTorLewrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2V6mPRRT7zMHlRsUyD2R1aJUH1w8gWp4W7CqDB3Sj13rGBJaCeFkqPA8ZF6y+T+kdFWtXuZWph3G5J4Ue439DD19Ge02CQFRwAQCI1Zv1VDgvDoTHY+egop+kyEgO1Ml308zVIn9kkdde8OGEjUl8rN51LQEb/hBNAsGbtNv54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CCldWWOL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CCldWWOL"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651FkAjX2063712;
	Mon, 1 Jun 2026 17:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+lHgl9XGuPjotBOZW
	0LAcVmsVCtDfpfxl4qC6+TiOW4=; b=CCldWWOL5cP3tq2TbAQAYBX5/XvmbET4C
	RuZcJ0ZjzvSN5j89Z7SnoJoJCjfsyU/cbRm8iRlOQJkNr7ShVuuGQztErGS2OvVv
	PgQu+cAUK41cnJQd85YCuzy/BvP8noGhQ5Y8yQzEvAii/z7k13unLxAPJwRfCaQV
	rR0TabeAOY5WYoB51gFoMwQbXlY9/tmBPGXSxXSqbw9yhfG+gH+jtfaX6m+111Bo
	vq8qOLy0ZJuwG/Xa+Eu92/SW3VMpazD3G6zicS1u0vBNTe2ALaDguHjBv502LAV9
	dDAvJHBRG22V/Fhs2UKFfbex/+TV9G3zlg6GsiRcjcE2i53vgVh+Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm4t5s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 17:46:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651Hd5Tl009459;
	Mon, 1 Jun 2026 17:46:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegf601-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 17:46:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651Hkl4H46399768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 17:46:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 980AC20040;
	Mon,  1 Jun 2026 17:46:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FDD92004B;
	Mon,  1 Jun 2026 17:46:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 17:46:47 +0000 (GMT)
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
Subject: [PATCH v5 3/6] rust/bindgen_parameters: Mark s390 types as opaque to prevent repr conflicts
Date: Mon,  1 Jun 2026 19:46:22 +0200
Message-ID: <20260601174625.2910233-4-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601174625.2910233-1-japo@linux.ibm.com>
References: <20260601174625.2910233-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: LBPPWJDlVVqqr7HuMK_z3TF6KKTKYFIH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE3NCBTYWx0ZWRfX+OA1hwk4WGIq
 9iNDTb8Ees+X5RRfJcg2vOWvhV+d008M6okDvVC09u/T7QIO/Zejt/tZPBYSSF6CaRUN3wz3xUK
 3GrPt4vaXfguVUxhNCF27nRvvnNA3AkkGzKsbAmY5DNce65zjSmNAL4eCIGY2X6oxlo/m8rfupI
 UWfR8xN2TCzfPSL9jjOAVWTo1yBx3FKZtw5vL3Yc/liGtzvlJg1AaqbzBGk5wWNriyqA5KdRF+4
 oWfGYfrvVI3JP1ZmDehdaXqj9q/GIx5C7mMwCA+JEu2Pu48bXGOXxFxMfhgpkHfAoXkZYmAUftb
 TFo2qGXyTDbRWZBwlnmzWpJZikIRKxppaX/5+ad7q8qusq+5p4hX5dIPYHAkeeSNeWZlaUKpqp5
 u14nmAzWBEDoUDmrWI/zzH4Fu47UkdXRMVZfKAmGUAXi7bGBivFzATxhrAAvFZhk51KBFYaAcDY
 boNuBLywSgEv6XtlRpA==
X-Proofpoint-ORIG-GUID: oJoe2p-06_IeNdB0DGWBgCaz5a8MaGgX
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a1dc58c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=_2yia0w1AAAA:8
 a=VnNF1IyMAAAA:8 a=7MZg_RI75Eq2x-0mQykA:9 a=4yAS8WwzZ1jAEY03B-5r:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010174

Bindgen attempts to generate Rust layouts for a number of s390 structs
that are packed but contain, or transitively contain, aligned fields.
Rust rejects such layouts with E0588 ("packed type cannot transitively
contain a #[repr(align)] type").

Add the affected s390 types to the opaque type list so bindgen emits
opaque blob types instead of full representations. This matches existing
workarounds for x86 types such as alt_instr and x86_msi_data.

Link: https://lore.kernel.org/all/e5c7aa10-590d-0d20-dd3b-385bee2377e7@intel.com/
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

