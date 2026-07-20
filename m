Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE183449B25;
	Mon, 20 Jul 2026 22:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784586173; cv=none; b=UFQAwJ64f59CUNNwWp/Euxd3sAV78HKOWNapUd4HK0I34hGhEMTW6eG8Krm6XynnK3MiMAiRtcUjOiW248q96qHJls5J5EWF2GJRHGDqXAA//RhND2alqZKzRLJApOsvj3n8z+CaCab/WU6b8Z3JLX625nL1+FdkUxfe3NTJfnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784586173; c=relaxed/simple;
	bh=Rxy0yIKRfMPcf3+ShCD2kUCFrShrLuuTgNqOJF2bJL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yr60I/dJT2PQg+giLjsuUW/yQfUKaWujtJQRNxdsR3nja9PiuIvAZ6il74fbLvGr51sm41YGDMJ5cRG4pz6uCRXbub1AMPS0yrwbsqcsOLAVqq4TXS7MpGKa6mU7lWc+q/6V/5JkF22BOE5qZQQEAfdKbjnVQyK+mGiFNGCr0Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aHYJM4AI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aHYJM4AI"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KJfchA1245764;
	Mon, 20 Jul 2026 22:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=oMahkUsl8pWrYQrKksQp6/p03wgTU10psdAiIKZVn
	N4=; b=aHYJM4AI2WAGbDi6sO5IrA2okWiOdjmZHzuG5NOqwa9dk+fM3D9z6vOF1
	8mzHo41+t2QTaaYXCMVl/wBs+tBPRyt4+GKFSNTDzxx/KvXgXqeFrusaKvg0PDTi
	GbdOR989efyx6a9a+P1by55LEdYBaC29+WRHH0Svd7qpkWa+I8RG8Uf4vcc0gUBA
	urTvOZd9tcaBhRpqsDjan4LBnNxzT0g/uF1xNQoAPxDSAC1dkk2Z551Id1QT1SA6
	WZIB4EfpcYMQOXseyoY7c4Kg+lw4f9QR+iNFjqexAIxo+duRS5YI2f0/hEhUQKnx
	2rh4wN3DycpjhoZ+phpQAGq4EeEBQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77a9r7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 22:22:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KMJa61022272;
	Mon, 20 Jul 2026 22:22:49 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktpyrqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 22:22:49 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KMMmmP26804810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 22:22:48 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D6915805A;
	Mon, 20 Jul 2026 22:22:48 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5748058054;
	Mon, 20 Jul 2026 22:22:47 +0000 (GMT)
Received: from IBM-GLTZVH3.ibm.com (unknown [9.61.250.131])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 22:22:47 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: david@kernel.org, svens@linux.ibm.com, mjrosato@linux.ibm.com,
        freimuth@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH v1] KVM: s390: Fall back to short-term pinning in MAP ioctl
Date: Mon, 20 Jul 2026 17:22:38 -0500
Message-ID: <20260720222238.1576-1-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: V62-ViBgAVPqFzhJUVuJ8Kjuhdk7SEAl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDI0MSBTYWx0ZWRfX7ASOC1bUUXNF
 N0uUO9hOaFTcJ/9PIrkyCTQtQHxQEQaUWp8bbdv0XXVWeAUVEhI6eYFFHS3Hmn0/hDXAgsGTaND
 Nguwfgl+5gdJAJ8d4yh+Z+f5ZB+QP/8=
X-Proofpoint-GUID: V62-ViBgAVPqFzhJUVuJ8Kjuhdk7SEAl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDI0MSBTYWx0ZWRfX7P75IT/w2VT5
 4NAXljakq5rLGsiG2DtseWNtd8/1UtPSmTkFIJqA+L0ls3hfiGCn/5XBOurK0RFNnrzF3CghE2s
 +xYqFpSgoAsv7H1vzCZvUZ/Tfh7JqpmIyXveuNRBHKYlunYojKqFTIQIo8bglRIPmYv1X3m/n/R
 XmSkdGuMYBx9lTtsZGS3wwbab8VeXYxeusKRt6dD+Xg06wPAU3dG7GAcihVVjInBMEpkXgvx0a/
 usNSJAEB9PR9urIcJLukPyxd6jmhX5qDyk7Yt7kZBY/X4r5RjdqCyu8NJsNdywL4yHcdbnl7/4z
 hi/QFM4Lv71/E6a8FPzwwc9S/Ow+TWOoJlNCbcXufyqrFYfg1Oilho+RzWcTHKTtH/llVLBp1In
 H6R1ovKMCElePJ2DDwnfHSnoJ8xBE2CH5WaIiRcKpm9Mfb7PcCh5NlMoKLpG90xQNnE03MzWhZ9
 t05IifXlGpo6H3iBXXw==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a5e9fba cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=DHE891H7Gske2VlohvUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200241

FOLL_LONGTERM pinning fails for some memory types, such as file-backed
guest memory. As a result, kvm_s390_adapter_map() returns -EINVAL and
irqfd adapter registration fails even though interrupt delivery could
still work via the existing non-atomic path.

When FOLL_LONGTERM pinning fails, verify that the page is accessible
using a short-term pin instead. If the short-term pin succeeds,
immediately unpin the page and return success. The non-atomic irqfd
path already performs short-term pinning for interrupt delivery, so
this restores the previous behavior for memory that cannot be pinned
long-term.

Fixes: adcd5b3e758b ("KVM: s390: Add map/unmap ioctl and clean mappings post-guest")
Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 9e3e6b0d72ad..4b68e0cb51f6 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2520,8 +2520,19 @@ static int kvm_s390_adapter_map(struct kvm *kvm, unsigned int id, __u64 addr)
 	map->addr = host_addr;
 	map->page = pin_map_page(kvm, host_addr, FOLL_LONGTERM);
 	if (!map->page) {
-		ret = -EINVAL;
-		goto out;
+		/*
+		 * Long-term pinning may fail for memory types such as file-backed
+		 * memory. Check whether short-term pinning is possible so that the
+		 * non-atomic irqfd path can handle interrupt injection.
+		 */
+		map->page = pin_map_page(kvm, host_addr, 0);
+		if (!map->page) {
+			ret = -EINVAL;
+			goto out;
+		}
+		unpin_user_page(map->page);
+		kfree(map);
+		return 0;
 	}
 	spin_lock_irqsave(&adapter->maps_lock, flags);
 	if (adapter->nr_maps < MAX_S390_ADAPTER_MAPS) {
-- 
2.43.0

