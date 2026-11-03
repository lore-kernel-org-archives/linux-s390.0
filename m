Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723859;
	b=ahTA+ocgBb9JxAtEWSdJT2mfCUtKs7O0LRvcyRiF4/MksoanBMUrlcZ4WRmFqX/c+pXB
	 uA4ly0aTuC+Fb1dMreCQQA6F/1CeXHZpqpBL363j02TuxQ/j64ClrZa5/aQeGifLdHkRh
	 mX7IYYgQnvd+GZBHhI107TJPSCHy7lgoLbvf+5EVDU/zpq0rIKk94cnlRH8yZUp3M8y4I
	 DtjZek3+9MdUTX1rTc0Q6p16n6DbHXNdHrSlUAdheB8Kw6H7d/7d5N1cl3xAKKj3OZuQm
	 64tMbF7RZkqujCbPvAc5E6X6EkbMBj4kyF9W4THSgW538mgvAAGPu2pNqYhclLShwmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723859;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-TM-AS-GCONF:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=j/879LMy1v0OwfAGB70ib6CEmpUITc36AhH7gQjH+Hg=;
	b=SwT3nHDaNj8ZgWuvd3OcfWuPi1495kQ3plavgdPFIP+SQrpJeDncyNdBhN6bO/UEhget
	 Cm3L/tcoiL8pz2xUVcf+WbynZ244obmZil4QR/jpX5DEhaFslpGF09JlBCIm01ka+QjPT
	 2J2ZlWkYEpL5hnK7f0EwmYnScojZa6jNHhjO1Jk7+BMs5o8glXDQVa1ihyoXYIhWj7jgE
	 bv+9TdwNhCpsq3xK/mYyHK0ZgqAfJWWcoIKt3iNlfTmGXXqmOFcp5hjlLylozxIONL0PK
	 yBknEg7QXhsdaSMCiupH7aCdQOAOIs3VYb1Onj3vVyxm/3kUJ0h0fEQJDlcCwX/TWpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="hvSpgT/c";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553CD606A337;
	Tue,  3 Nov 2026 16:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 553CD606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hvSpgT/c
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EEIJa407313;
	Tue, 3 Nov 2026 16:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=j/879L
	My1v0OwfAGB70ib6CEmpUITc36AhH7gQjH+Hg=; b=hvSpgT/cbVkrHaBqHOIIj4
	qllXZTorimmNoqNB4xpntBFTqZZagUpbYR5gRjP/FSD7E4BuNiQz7sO9qNluQns6
	mm6UeIwdb26hKe4elnEs+IkL2+0f5gnQhmZ9F1wAcxINHKcKopVs4/pUv2es8IgQ
	O5EFBN63Kp5GkR8OG53d0IAC+APs6fgpr/E3NdNIHpH3FYnSG5165Lf+6y0ywUCg
	Gw/3sdienRY3f+zlwt5qp1+6vv+0Kf2GWe/YtGG0HFBiZepoTqascJ7oIOOBXdR9
	jBsFZEobzqKboIE4N8QKsvR/vaHHAiORCVjpaPW3GNCJvqzoLJntcqy9u3v7j6gg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn80sq051-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 16:37:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EJvfq2625365;
	Tue, 3 Nov 2026 16:37:24 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqbqka35m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 16:37:24 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A3GbNf231523524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 16:37:24 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95CBB58059;
	Tue,  3 Nov 2026 16:37:23 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A5D55805D;
	Tue,  3 Nov 2026 16:37:21 +0000 (GMT)
Received: from a46lp21.lnxne.boe (unknown [9.87.84.240])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 16:37:20 +0000 (GMT)
From: Andreas Grapentin <gra@linux.ibm.com>
Date: Tue, 03 Nov 2026 17:37:02 +0100
Subject: [PATCH 1/3] KVM: s390: arm64: Turn vcpu->arch.pause into a counter
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-s390_arm64_kvm_fixups-v1-1-21c36fedd878@linux.ibm.com>
References: <20261103-s390_arm64_kvm_fixups-v1-0-21c36fedd878@linux.ibm.com>
In-Reply-To: <20261103-s390_arm64_kvm_fixups-v1-0-21c36fedd878@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andreas Grapentin <gra@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1505; i=gra@linux.ibm.com;
 h=from:subject:message-id; bh=ZZ/dddmMoMIsufUrKWjbz7kSNC0F0/G1jtL3L4wM0fo=;
 b=owEBbQKS/ZANAwAKAXUg1t0k8konAcsmYgBq6g23Vmk6ol9BNDw1zcCPszJyj135S8fMie+m1
 iGfkH2dPOKJAjMEAAEKAB0WIQRrKkreGscL2VvlPix1INbdJPJKJwUCauoNtwAKCRB1INbdJPJK
 J66KD/wO6fDCVTaH+Z/xf475QQWl/xvR3IksJ1hYm8H/kbYg2dIVh4vdo4c5OYqSCX3yDcyFPdx
 Hf9A5WDwqiX100efjn2QuwDF33R8qGTgSAmtOz3X17mMIfeZCHP6IRV6VBIfr3G0pz2Q7BLGOmY
 YLEUMJmeEuvtCBgs/AXL3LV1vlOiSZAMR0mCFvoE2X13ergwGzuhvc2BS0YprOEpb2X0YFJNncs
 OvD7gQEmvODNhO1ETHng0d6QVWB7/H8OKkndyob1csPfTfN4uY2gGydbns2Cu/yVv1UrUDjS9vR
 O6mBz78MBoJ8JiMa1npd7S8hS3piP7BqK/pfKu0E23KkFJcs3RX+ZRy0CRX5apMOQnkVS3B7KvI
 iXsKRnERuDBxR5ViJljf5eESROKND7OXCMbI589GVT1lOFCdY0JYbwBP3JU7c4i3tJMHy/sjHOI
 BFXPB8cRyLHGJsq8/YZ6qMzBFGYk4ZAwKInyRQXZ6ljTzymPpya6Jo8csxAEVJ0zecNgXjugjp5
 cbXM/O1UKICELd+lXle0b3y/O0ReVu97e5sbd+DoluppeCNrJkgClPAqEFnVSSkSiBTmrD9Zbfz
 CcWv8YzeemLcuQ+khMbno4PtRR7LJGxEONiBPVgbG9sYkEyuVXUSPGJ/qtVX37WUyrNcI2IKjRp
 gLuFiQT+bO7oC9g==
X-Developer-Key: i=gra@linux.ibm.com; a=openpgp;
 fpr=3B910193D094AA78FD974A04D8BFC37DD553D93F
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fpVjXn2dcM9asTVBJdGwxpiDuXaOn1uM
X-Proofpoint-ORIG-GUID: fpVjXn2dcM9asTVBJdGwxpiDuXaOn1uM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2NCBTYWx0ZWRfX+IbjjDzhAyXN
 VKrARn6OlX/E5C5xx50U9kiTsJ13tjZ/yTLcEbmSMPHhFUVxtZbwm/TPPha21LMZ/zVLZ4ALDOR
 SxDP8hCBfDMdmk0u85QfTwRiSODHo3G+v8EKSVO79yKc6lGtGhFyr+OZ+Zk4B7UrEWI3t3WaAb9
 TywLNX6XD68A7RK0wW+la7opIGhUoFu2uDQtSd9hLtaSdRyWs/X1tQ9kM12XPdDFwa4swctRnPZ
 Zo9GiWcE/VVBKcn6sPHoi9Ko2u24L/2y2d1deH/ZKjrXODPqw16Sp5UBww6jkNpdd0TXKoR9Yhr
 5tIUyA6e1RPUk9byXKkJEAVVMBjG6R55DNaeMBrXQ/5PfLdep3z0pxOVBlspP4ieUjRSYE2c+aS
 Kfbsczgiff0nrdD+5cRXRM4uf3VgeiUKdcWDJ2EreCELOA4+2KLEN0ST3hgW/rshEsdEfZm2Gsi
 zBFr/NJI4/oHtOb+UHw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2NCBTYWx0ZWRfX2cNRo822Tnm7
 2B+9rjZ5pNTIC51iAri8AZgEPCouK2EneF6/YgyFudh7ZSXGM2r9s1HIhQCKgVClO4Q1YgjsgS+
 t816sFvm1XJ0TiXOaI1cP+4S1q4NQFs=
X-Authority-Analysis: v=2.4 cv=FIqOVOos c=1 sm=1 tr=0 ts=6aea0dc5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=3n9Dgo04BRxGV_azSxAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030064

From: Steffen Eiden <seiden@linux.ibm.com>

The s390 arm64 vcpu struct mirrors arm64's kvm_vcpu_arch. When commit
e64309198eda2 ("KVM: arm64: Turn vcpu->arch.pause into a counter")
changed the type of kvm_vcpu_arch.pause from bool to atomic_t, the merge
into this tree missed the s390 copy, leaving it out of sync.

Nothing on the s390 side accesses vcpu->arch.pause yet, so this has
no functional effect. Align the type to keep the mirror identical to
its arm64 counterpart.

Fixes: e6c329180d1d ("KVM: s390: arm64: Introduce host definitions")
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_arm64.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
index 82343e723ebf..a3e40650d75d 100644
--- a/arch/s390/include/asm/kvm_host_arm64.h
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -63,11 +63,10 @@ struct kvm_vcpu_arch {
 	/*
 	 * Don't run the guest (internal implementation need).
 	 *
-	 * Contrary to the flags above, this is set/cleared outside of
-	 * a vcpu context, and thus cannot be mixed with the flags
-	 * themselves (or the flag accesses need to be made atomic).
+	 * Contrary to the flags above, this is updated outside of
+	 * a vcpu context, and thus cannot be mixed with the flags.
 	 */
-	bool pause;
+	atomic_t pause;
 
 	/* vcpu power state */
 	struct kvm_mp_state mp_state;

-- 
2.55.0

