Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795084392;
	b=ZT33q74NMgvhmsxxmSVd6HvC1VPTQBoUKPS/R4iEF3PyS7kFPHWKY0QA32KNZMctUPy5
	 G2UAgOZLyOf0ReneWd+5ghN+aoePsAbJYWaDBeUqD7SKuHtt8pfmfLWAoWKdAMWuEXxR9
	 4HD12STN7ryBKg8fGI472LC4SLRigbcXOCRBhG6oH7g6aGUYHnYDbU45xPWWQ9i2MGZrz
	 8tNHUQTFSeoqffNTtxZDxLOvUkA8IHtsISjCCKhQ61jjjcOcIBd6bf1kL6bf+U3AbtRJN
	 or/vXYrKkYQVf4QlHecjjPbuzWJmlYIRhmqxrOMQB6yapBA4q3YnpUj0baddeb8MqnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084392;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Z4qzCzNdeoCDVTN55IpX0tUuSJH1wbhLqQ7KegQwJUA=;
	b=wHQrZhlckqLeTLy206AUTmWAMInyXtMn1krgVo+jEXRHKXp9ou4G93iJ6AXYKZQqkY/C
	 TrBph2Guao/mPZAaAVlNC8Xb89m8QwcFO3KCinMA2YDKG7AMpB+rhgTqLpL+fN2VQWyt8
	 /NvD9osyY+v5hQikzjBhc80uDfJNcCHRtw7Cy2ylA0SfK/lu1X/uaF5xQrE19jBahEjx0
	 Dt18LlLtf+kNmQbvwiin7WudBWBALn2ZuCu+uTTkH9G9KYROJ4haJ1EUF/sXnY0q41Zwn
	 s+TQMkDdQQfwj6bfRcSmmjFCIxDQDTyserUFAZehF6aaGpJIgrKiuz65GuvavjVBqXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RnUpbzvg;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCBC606A324;
	Thu, 19 Nov 2026 10:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFCBC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RnUpbzvg
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6ueet2236438;
	Thu, 19 Nov 2026 10:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Z4qzCzNdeoCDVTN55
	IpX0tUuSJH1wbhLqQ7KegQwJUA=; b=RnUpbzvgEvgQqJq+Pi/hu1K50oVZ7fwEl
	X9gZbt3Uv1owvCWfVn4cmyriWbLsIsSO0eLFgTiXvDgUFjINC2T79Y9u+yOUdMEp
	AU5Yb4zbTPMlno3zDhkAOyRtaV/5K8zf1PUaHkkMyJzHaxeB1fKteBRb5FB2CeO2
	cZ+SlqUR1TXpCo/fJs+VIo8FxJhVOoI/VEnxAcoIvMA8FCIjmvxZ4gY2Iy+ueCVI
	RzbO4UCo0uNpkmwaCMs9m7aqDRg1DPfmgdRcOMNEb2oburtd0wQE9l8nLXWiNNRC
	p4OoNATsed8urnQsnp07BtyapI53tLRC6tzwiP9noudMhlCSTM0dA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105w01y5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 10:33:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJA1k402161191;
	Thu, 19 Nov 2026 10:33:06 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1v9x90hg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 10:33:06 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJAX4ag16777896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 10:33:05 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C214758066;
	Thu, 19 Nov 2026 10:33:04 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92A1058064;
	Thu, 19 Nov 2026 10:33:02 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 10:33:02 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Steffen Eiden <seiden@linux.ibm.com>, Marc Zyngier <maz@kernel.org>
Subject: [GIT PULL 1/6] KVM: s390: arm64: Tolerate unused functions in extracted source
Date: Thu, 19 Nov 2026 11:32:54 +0100
Message-ID: <20261119103259.7523-2-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119103259.7523-1-borntraeger@linux.ibm.com>
References: <20261119103259.7523-1-borntraeger@linux.ibm.com>
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
X-Proofpoint-GUID: rOxjplRZwf6SB-1xI14Vy2XlKqtmkKF9
X-Authority-Analysis: v=2.4 cv=Z8x5j3RA c=1 sm=1 tr=0 ts=6afed063 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=R7EaXgVFCislUhSyr_kA:9
X-Proofpoint-ORIG-GUID: rOxjplRZwf6SB-1xI14Vy2XlKqtmkKF9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0MSBTYWx0ZWRfX6AKgaLjeUar6
 28t2fGccxU2qOOMA0W+23C847JODZpiRpNs4/mTRacqyX7c/hnLs691IGXP0vtrv3VUsZNC6XBZ
 WLHA74moQ+z2DrV+/HLCZkiJeZWNOE0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0MSBTYWx0ZWRfX5cFssY6UHoCS
 WsbBeljSv/GeobUzUTzrMNMOpMhvWvVaWBiHkbOqqoltrRCrEkSEkrZ+pnswA/Rfk/cBhQEeXyA
 K3daWATnEUTnEAf5SYpVs61pvMWZAhGRHduYe+mHW7SHFINHtDq5Z0xNciyK6FpmisJW6uDAz1t
 eTNiHCbQVcSIKboJiLHiGKTXUKwDRTHkW2TMmkv86Ka0yvig91PhyAAZtGrd/dmrNVIjWHC6bIG
 caOuH8+uspjmqyvCev6lYYoYpkQrbroKTn4sjP8qV+VNArq9m6bsWWCx1WCcrXYqhZMp8V8b55l
 j1gVBgUjl6iTfUTI87yuqS+z5B+rFmzunBIqv/osPhVkQjgRKSCXdWznLJgH8WLjbH3msl+Cont
 TXFDR30wbOk59DHDgZsJDLSxRGw4i/68AkwGKRctC1/zRarSmX1Mwi3QLvTz8U+zj3DwJBK7Ssc
 n+mzzbbxivu1IPC5yTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190041

From: Andreas Grapentin <gra@linux.ibm.com>

Extracting static declared arm64 functions with no consumer on the s390
side into the generated sources causes compiler warnings when subsuming
the generated sources from s390. This causes spurious compiler warnings
that make it harder to extract larger, more cohesive portions of the
arm64 source.

Update the extraction logic to wrap the extracted source into diagnostic
pragmas to disable -Wunused-function for the extracted block. This
allows us to share more freely, and also opens up more paths for future
code sharing with a separation of extraction and definition of consumers
in separate commits.

Obviously no functional change intended.

Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/arm64/copy-arm64c.awk | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/arm64/copy-arm64c.awk b/arch/s390/kvm/arm64/copy-arm64c.awk
index 640a7bcb7e23e..a318be97c4191 100644
--- a/arch/s390/kvm/arm64/copy-arm64c.awk
+++ b/arch/s390/kvm/arm64/copy-arm64c.awk
@@ -42,6 +42,9 @@ BEGIN {
 	print "#endif /* __INCL_GEN_ARM_FILE */"
 	print "#undef __INCL_GEN_ARM_FILE"
 	print ""
+	print "__diag_push()"
+	print "__diag_ignore_all(\"-Wunused-function\", \"tolerate unused functions shared from arm64\")"
+	print ""
 
 	file_header_done = 1
 }
@@ -78,5 +81,10 @@ copying {
 }
 
 END {
-	exit error || !found_marker || copying
+	ok = !error && found_marker && !copying
+	if (ok) {
+		print ""
+		print "__diag_pop()"
+	}
+	exit !ok
 }
-- 
2.53.0

