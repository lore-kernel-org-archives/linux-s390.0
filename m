Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9F21F4C8E;
	Tue, 19 May 2026 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202890; cv=none; b=tIRiGH1CFHLUCIYuXcVXbR6zi6W2u0HqzBpjYzmoSOXBSRVCtwGT9cdHA0K+nFU7W/dP8Kq5uRy2p+F1wFjCIT5YsqE+gyNzfiJxNpueMv+zHDv9GqAMnXdvGW/96YEERt4SEKEWh8aGj0kE4j9fnGAhjaZ2OmBfimj37d9YV5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202890; c=relaxed/simple;
	bh=IrEkMtCf4TWoWU+UwykTTGinZFw4RRZbvO+pLuau2G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WizKBnfBjjlFJcBujtUIwJ2LN3un8f/F6zPEXzOiMQ5Mn42oKo7Rufdr5IRPAbkjbeQrej9KoYHM0Hd+uG8u7pIHaIkGiT57sooAaKdh1FA3eOKijBmKPSf2gngEEow5x8V12XV9JBKTw4TcoSwguQYcQVdY6ntqt3tirXRbKE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZV8nTb/f; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZV8nTb/f"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J4bWld1839474;
	Tue, 19 May 2026 15:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TpqZZZASTZSaoZTMC
	Z6ykU1jk53p+LOl+YQFoTRfbQI=; b=ZV8nTb/fvCApga3s/jjQigBmzISpoX+Qz
	uIVXxvq3Nm7ju4LiGhAWFgHefZ/a9YBJ0lYJPVZnYnN9fNK586y7S+kzoML2wC3H
	J5/53Z7JG9W5xZcHQu0Adaz5iFqIjospL4gY3W8VdUtUW/Ajt1i7dsjydNcEhSum
	6JGNnYbm62E1ME4bTcYr6SUBr0kaMTIuUL88UVq9trPySsO0uFMqEFDg8MXTc1ss
	EEePIgWzgzB+rMsQpZ/3yMfizkAgIyPlc5ymFjlX0Kjf5gA6qIroAyyjrOhuw+h+
	52xAxBPiaEsU841Z/B9UPdbWfQ7J2zi7wNo4W+BGJyClUBjubWTmw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mnm9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 15:01:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JEs84N016542;
	Tue, 19 May 2026 15:01:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739vua3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 15:01:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JF1GMC37159220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 15:01:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F1872004B;
	Tue, 19 May 2026 15:01:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97F9D20040;
	Tue, 19 May 2026 15:01:15 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.4.60])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 15:01:15 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 1/5] KVM: s390: vsie: Fix memory leak when unshadowing
Date: Tue, 19 May 2026 17:01:10 +0200
Message-ID: <20260519150114.264309-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519150114.264309-1-imbrenda@linux.ibm.com>
References: <20260519150114.264309-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y9SVFoVvSgAUWkbTy2_YPXjM5jSY9Eqt
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0c7b44 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=HcuRRwaqOfwKfrSmNnAA:9
X-Proofpoint-ORIG-GUID: Y9SVFoVvSgAUWkbTy2_YPXjM5jSY9Eqt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE0NSBTYWx0ZWRfX4U+UxjPwtVWa
 mVAk6XN/TouhukIEJ84ZkZKtpYD2rHSJXiy1P3e7jEKUctN5NnB6+Hi3E/CtnvLNioeR5vsoWCp
 1D+I5M5OQ0sK0cHMT0EmGnac2Sw/yP2t93+0ToP+KwW37E9KqFzUfIAISUkq28KDOID5eAZ9nL5
 rSq8C/ikqeHs5LzVj/0Ab1OtHFj/c7d3T9YYYuGqJoopjGqLSztqirqr+wzFnKOqHObY7fkXTW6
 MaVOu317fbyFwUwlouKQn9OgppArzacRYzG9jL545I2Vk/oGbxYZGES5k7X9s9SSgpmYg9B+Vvr
 SSB+uk+R5ZPRrLjD9FQNWDdDdx2swGLmTPvppVXhOT27Q26guVFNuaF79s2QvVQmOY96HQ5wFzg
 zCd4cjAzwbcdIDWAK9V+BxRDmtqlgmQpn0KjxbksGBOCjldazzVI+yY6cg4vAdSPoedOUTgp7vv
 E+zxJc864WJGRty+vtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190145

When performing a partial unshadowing, the rmap was being leaked.

Add the missing kfree().

Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/gmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 3c26e35af0ef..fd1927761980 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -1143,8 +1143,10 @@ void _gmap_handle_vsie_unshadow_event(struct gmap *parent, gfn_t gfn)
 		}
 		scoped_guard(spinlock, &sg->host_to_rmap_lock)
 			head = radix_tree_delete(&sg->host_to_rmap, gfn);
-		gmap_for_each_rmap_safe(rmap, rnext, head)
+		gmap_for_each_rmap_safe(rmap, rnext, head) {
 			gmap_unshadow_level(sg, rmap->r_gfn, rmap->level);
+			kfree(rmap);
+		}
 	}
 }
 
-- 
2.54.0

