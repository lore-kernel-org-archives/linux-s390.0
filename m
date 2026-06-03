Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCC433DEC2;
	Wed,  3 Jun 2026 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501689; cv=none; b=j9VptS93Xka1DvAOGoQLWL35ZLoQzDs6JwjK5KGxKN+2x9AG9hj6MS4UriM+LjuxyzHOE688A0Y3MQBac26T5tGeGusG6kP/rNBg1JUzjs3lowraENV3ICuxxgrI0JrDalm7O7x54Es1lCN7EHvBwxPfCfETqx5NdL6Djjg84FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501689; c=relaxed/simple;
	bh=VPvznYntSlTfUxnZqVhjwJU7MibGaN5jzHR1v555J/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nJtro3HbTwjeVnsnaUEIM4ViVYXbAPlyYYmRKjaKmFD9226QsdR4Q8HyIZS2GPy16epIIjjdT6WpZtdXdjzOG/ByZs5tt2qwAUJL2vL/ZSB7RYHZy/0uQQ8Z3ToA0UTzmXBTPvJoby3OqHrBbGr8bIlNcoEL6BwFnWBvSKmPOJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dxEYmpQ0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dxEYmpQ0"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6538VeHO1773281;
	Wed, 3 Jun 2026 15:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Pb06BowVsUQpVME/K4zelxc4Syh5jED/o59CeqDN9
	hM=; b=dxEYmpQ0txLf+gX6mmKsONK4eyzvRgum7BzXTfnNver4owNIk6KfZSzZ9
	jECeVWMOyk5/z2lW8lWyw52BtcY8hNRdnrELLEqqokihrfAwUK10PZn1Fz4rOdgq
	9d9AXEt0NZQk+AMtIGeKLF1xj9jSn4zCuftOh/D9nRaGjrpP51VyTRMsMLmHRtDE
	9i33HdWZHybg9GBPhy7/5TW1HUtYoXN3zB4sqN18kWB2/9Erue+g7DtSgnTGGmQl
	YukSx7yaPml42tH36KU0wpzT3n1xBXEWKc7bHT0bo/aF6aqYpWi+yM8QyJzJVBmO
	ulYr4cawesonEUkSRCMoI/DGotKoA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd4btsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 15:48:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653FdLN6000873;
	Wed, 3 Jun 2026 15:48:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k8wxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 15:48:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 653Flxem51183898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 15:47:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F338120043;
	Wed,  3 Jun 2026 15:47:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3EAB2004B;
	Wed,  3 Jun 2026 15:47:58 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 15:47:58 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 0/3] KVM: s390: Add support for 2G hugepages
Date: Wed,  3 Jun 2026 17:47:55 +0200
Message-ID: <20260603154758.234768-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE1MSBTYWx0ZWRfX5Qn+HaNafpux
 XeT7HIoeCbbPCYW5jqkdWKnQkRb+cND0zWFBtzAFSbUjTAtbx8rVJDoGYVSPlEbVyAze8AsF9oK
 QJnWGDizSrH7v6qaTleMkF7D+nbePm0AnmJ1S1VOtdLBTL7wu0QNIav+NB7Yzs66hi3Om28n+50
 BHnCKPhW0qfvEKbvULScCJVqzgKCJH8ztdauQGm+ePy+a2JXf0YmXH6tU75nK7WXkPlKekY2GBG
 d5bGYQUG+t36ufu3E1cXX0zEd+2DqY2IBnpAbw5plS5D5hHkbmAONjvPN9fJQossqQbGesV/ZRh
 l6NBCxNrKkLEAktKFh0rrbnu7dXSFShQxaZGQsrZDTWhvP8prLpKvtDREsdbuupqs3WaN2t72HB
 m7SvH5TpYfBJ9jXpbn6dSR+Lm/zPVfPcfzvxUP6AiUEPhsCTqdw/hTGohaO01GUvIJKjNZ3H2St
 AflMGBRbFZLJ7ipwcjg==
X-Proofpoint-GUID: ut3gaJ0C88VRGofHixu58h0LgKGKOjuO
X-Proofpoint-ORIG-GUID: ut3gaJ0C88VRGofHixu58h0LgKGKOjuO
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a204cb6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=QnIkhjQrAr_Oq8dr9QoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030151

Add support for 2G hugepages.

In theory, since kernel 7.0, userspace could already use 2G hugepages
to back guest memory, but KVM would use 4k or 1M pages in gmap to
actually map the guest.

This series allows KVM on s390 to actually use 2G hugepages in gmap to
map guest memory that is backed by 2G hugepages in userspace.

Nested guests remain possible.

Claudio Imbrenda (3):
  KVM: s390: Add module parameter to fence 2G hugepages
  KVM: s390: Add capability to support 2G hugepages
  KVM: s390: Allow for 2G hugepages

 arch/s390/kvm/gmap.c     | 24 +++++++++++++++++++++++-
 arch/s390/kvm/kvm-s390.c | 38 +++++++++++++++++++++++++++++++++++++-
 arch/s390/kvm/pv.c       |  1 +
 include/uapi/linux/kvm.h |  1 +
 4 files changed, 62 insertions(+), 2 deletions(-)

-- 
2.54.0

