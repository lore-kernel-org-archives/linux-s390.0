Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005CB3939CE;
	Mon, 24 Aug 2026 21:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787608581; cv=none; b=r3i/Nnh1wkyxX0lTKsqtr1FAcHcXDUDfLb3aFXRZx0IrjRgTdpothqfa3C+Zm0tkEVtBK7jdtWh7H+mxTOUv8142nTCsv5EiBiEMq4e97Evm3tLzPkD4Yt+BsCtkLn98ZGcbN+6rVq87ufX5ViYTWcDk3Ze0vVYWQweRZ421XM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787608581; c=relaxed/simple;
	bh=hkz/wFuYIvindBkr6hwhmI9QLpbCBWV1ipyTD84LOXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=enJDX5YoJ1+56rsKgxJrlWvImE7nO+kXxgX4QWlLQ0DSrAnLtQ0HJthdX64q6lx2e9APJC/NWe5OvkoTKKWD4NhNg101I1BOBxDtwT97ApM3R2AavjjAStzoaiyO/HZbIDSJSzaJRcI17zKGgANJETNccilopZO4u3k7Qu8spQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mVvHZauo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mVvHZauo"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OJVi1k985071;
	Mon, 24 Aug 2026 21:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=nZK9EVo8FUZG4ALWynN0iEX7sYZljAIVEKDSfK9+S
	S0=; b=mVvHZauoLKPUn2+A2ENSqpEzz73O6Nf4U1KYi/l+MDxbAlI/WXRZQSeau
	EWASjX3HFrrN95JT2n+0y63cvg3cmC9Z19n609Xta0YItXYXNU97V+LRpk8iCGnw
	m9Vv+AYi+PXeYh3+6j7xcamCGtLeO2z4EI+11QuX9QM5s+M5Lype+1hrT6S+138+
	7XE8wtVe9UvuiMHdvE0+JzapOoD5wZ1ct7UdNrIepMHq6VXfGq3qZXkkzRt3EDJj
	l9Zs/7tHDaxgeX+iL0OUykC+KDFFBiikSQg+ipkZSPdJ1pkzw1jG4NqiibnUlb0O
	lQlqfvJnrp6NC28HzXTATMBjEPWEA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqmd3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 21:56:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OLfG5S001587;
	Mon, 24 Aug 2026 21:56:08 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag8hn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 21:56:08 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OLu6iP37683526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 21:56:06 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74FF358053;
	Mon, 24 Aug 2026 21:56:06 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5D1E58043;
	Mon, 24 Aug 2026 21:56:04 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.96.163])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 21:56:04 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com
Subject: [PATCH v2 0/4] s390/vfio-ap: Fix pre-existing bugs in vfio_ap device driver
Date: Mon, 24 Aug 2026 17:55:59 -0400
Message-ID: <20260824215603.819379-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rER4i0xnlEWzuRQCqwADM7yBHJtXqihc
X-Proofpoint-ORIG-GUID: rER4i0xnlEWzuRQCqwADM7yBHJtXqihc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE4MiBTYWx0ZWRfX1fjTUvCSzmF/
 /Uj6MACSfn2rlcqWozRRqDzNheonmq8XbzDjReoRSAEE8+GTRcr0Ik1h6VqqPCKG+yWLzPn/B4M
 4Ghfxapgoom2Zi/w3mpUDi6P43MC3oC1ddzedxwqa4+vE9ymn4Nu2uLnDBYKkTle4gdpVvumK2a
 dJxXkmEkZfg1I6vbIb6vfFT7yLwlCYZrCAwZQ9Khcb/NfU1CMJZb0SGNSmYeOJ8nTTLNbYbTCcG
 zsZ9GL7mvk7jw3FobTrnU6q0DvAXqxYllOOrshFy3vdZsHfvkIkzgQsfdtREkZ7IyuhO9MqQu0r
 pt+VYwpcyMWRHIL76QwVkX4yKQXglzOPOlSnflQKERyCJM9RXqi30/WThWiMw07o0LZSROgU73D
 iQbqFO6r0S05OyJKZj3f10ZBdsK5pa1ova4t7LhimQTkbo4aomE2JvGLcA+rJkDTfgaQPJS/ozq
 P83WMwiFb92EF09O9IQ==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8cbdf8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=k-DkGLZXk-_WHkAabbsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE4MiBTYWx0ZWRfX+sLekGwLP3oN
 7EqYT6sh3fMY1tLJqqaIUUciGmeF4Zc6N+y0GUwykCYBELL8/Oc5/5TVfFgbY0hR94+RuiWbA3q
 62z7dEbsI4oXa9ummqst1UBbNnDc8gI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240182

The sashiko AI reported several pre-existing bugs in the vfio_ap device
driver code while reviewing unrelated patches. This series fixes four
such bugs.

This series is based on the 'next' branch in the 
https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
source tree.

Change log v1 => v2:
~~~~~~~~~~~~~~~~~~~
Patch 1/4: Fix leak of pinned NIB and registered NISC in 
           vfio_ap_irq_enable() 
* Removed call to pr_warn() in vfio_ap_irq_enable() for the default case
  in the switch statement to avoid flooding of the dmesg log. This was
  a pre-existing condition detected by sashiko and fixed here since it is
  in the code block changed by this patch. The VFIO_AP_DBF_WARN that occurs
  after the switch statement will display the error to the dbf log. 

Patch 3/4: Fix unbounded loop in apq_reset_check()
* Removed call to vfio_ap_free_aqic_resources() and provided a doc block
  explaining the rationale for allowing the leak of resources.

Patch 4/4: Use AP_DOMAINS for adm_add bitmap size in vfio_ap_mdev_cfg_add()
* Changed subject prefix to Use AP_DOMAINS for aqm/adm bitmap size
* Fixed two other locations where AP_DEVICES was used for the aqm/adm
  bitmap size.

Anthony Krowiak (4):
  s390/vfio-ap: Fix leak of pinned NIB and registered NISC in
    vfio_ap_irq_enable()
  s390/vfio-ap: Fix failure to release IRQ notification eventfd contexts
  s390/vfio-ap: Fix unbounded loop in apq_reset_check()
  s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap size in
    vfio_ap_mdev_cfg_add()

 drivers/s390/crypto/vfio_ap_ops.c | 55 +++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 7 deletions(-)

-- 
2.53.0

