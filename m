Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4661434FF4D;
	Mon, 23 Feb 2026 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847614; cv=none; b=BNa54xW9uBqf480UH9VZNH70OEggjIrkhUB2ist9OUtyhc24FnMIBF+5oE4RJ3fAlgKb+/bDcUWFxd9MM+6ZAMh2T1is++Kt/E4+PzC3wmZZGAxhoFjSHiB0+fc4Uckaeys1vP8fpkGIm5E690MR35TQIKBZP3JH0APfidHjVac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847614; c=relaxed/simple;
	bh=VLTBtbUx77gzumExkwQ+UsZaY5sqhpu/Y8wOE2jbbEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGENLGSqUtcluNzxmVXcsgHCt7TS+JEoY8lPqbBX6GOFAs4NYXJj2mq3m2RgA5RPmoWJg90hR3fdT0EoQOPFk2zQANAAWVMIgmYsVeVar4KCUgEBaEbiZlTukaiTpeOS1NXnznMrA7v/pD2FVN53AbVqRnNMEmwsuHWVi9spHBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jp8eTwpb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jp8eTwpb"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N1bvMK3315819;
	Mon, 23 Feb 2026 11:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VLTBtbUx77gzumExk
	wQ+UsZaY5sqhpu/Y8wOE2jbbEc=; b=Jp8eTwpbqSGWtu5FS4DBCf0AAR2JEELvk
	FiKbWklVCNRdNXTrRt6xsfisN6dDQw66AWZOeeDexXNxv67Li6A4CcWVak7/MYyq
	zQugjyp6d3n2D+viaNXLB5mXiFvjIHNQ3AmnpHrbTvoBWWHRR0ms58M09NYvJpjn
	n2AFZT+RVhmT+NMV7Jwn9qUy1bpx7QvACMExanE7dy9piR+Vn8fvyC6XfGP2NGLC
	c9OgdmHRsJNFwze9TyDLD+gEm7JTb0g3++HPJGoMNuc3+My6HYdVaU5sQtsqvSYp
	+n4EV7geNlSVf1t4g0CHlN7jctMte+rP7jT8orE6pHDKIaO8WfFXA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf471pymx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 11:53:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61NBiUlY004541;
	Mon, 23 Feb 2026 11:53:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfs8jmd7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 11:53:18 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61NBrGEm31785692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 11:53:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E8402004F;
	Mon, 23 Feb 2026 11:53:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 673422004B;
	Mon, 23 Feb 2026 11:53:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 23 Feb 2026 11:53:16 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 47EB0E0BAA; Mon, 23 Feb 2026 12:53:16 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
Subject: [PATCH 4/4] s390: Enable page table check for debug_defconfig
Date: Mon, 23 Feb 2026 12:53:16 +0100
Message-ID: <fa08bb93c20a48884b7836834c79f44b5fb9b8b3.1771845678.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1771845678.git.agordeev@linux.ibm.com>
References: <cover.1771845678.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UTiM2q-6iZvpMeP5gTtkFRmbUSSW2s_X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA5OSBTYWx0ZWRfX6BvNd3T/IZJu
 OZ4C0j8MAlKXKMBI+WRSs6rU5KkA3WD/TuG2rz0Ir4iYHpRSCBCKncBr2l3uAIHqp+oBIOQrD4C
 y0qNPjma/5b50SbwtJAa+UiDJabVp4cBqO/fFTSF9tEqg9huF4ZzcsXKTPiPIQYY2pJcmyuZ2oQ
 LkWJxyMjMu8EWXKHi6Cy6vvxMasenEg7sPehdRr2PJwMuiRR/OGXQLsqfXV+hpEH8wOXInt0qK1
 p/2BRAQTDVyI3+0YsGeXVYsFYLydHq6eoOWCu9KUaeZEpeDhvoF7iIoMfly4Raw9pW5ky3U9nuq
 07PurA31R0C9x66txtYfbxvTHU/YG1CJ/it4ZoAzeBwPenLAsvp5HbqXhTMj5Z6uRXx7YGuBNKd
 lvDUSEyXSyHQdg9AJ14Eq8dwlVyeLEDk1Xq+C0CXgpA0+NmAuFFDiph+7UzGTn9xcXeeRviAwnv
 1Gxv9Qovir/8lnXyzVg==
X-Authority-Analysis: v=2.4 cv=R7wO2NRX c=1 sm=1 tr=0 ts=699c3faf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=ll0qgXPPjJRHf6HrCsAA:9
X-Proofpoint-GUID: UTiM2q-6iZvpMeP5gTtkFRmbUSSW2s_X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602230099

Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/configs/debug_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_=
defconfig
index 98fd0a2f51c6..12cdaaefb6db 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -929,3 +929,5 @@ CONFIG_PERCPU_TEST=3Dm
 CONFIG_ATOMIC64_SELFTEST=3Dy
 CONFIG_TEST_BITOPS=3Dm
 CONFIG_TEST_BPF=3Dm
+CONFIG_PAGE_TABLE_CHECK=3Dy
+CONFIG_PAGE_TABLE_CHECK_ENFORCED=3Dy
--=20
2.51.0

