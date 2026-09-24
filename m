Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A124734C5;
	Thu, 24 Sep 2026 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790246861; cv=none; b=uwZNVINCr9PMZ/d6SPF11JRZt9rQX2e0Bjwt8ytp99xjhnN4EQ7ABJpzMNps6M7uA4mCN3jMQo4JtU8CXWWzUDPEa7KGsCNqBR6H95wf/IHwOIQ+rgNCmgWbERz1HMJX2F7k615EbpySYWRxN9n7kxyb1SdJSeVf3OUs0Kf9ZcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790246861; c=relaxed/simple;
	bh=I0F6xohJ90jkLggooRIj7haBLxgbKGPMhADub2pUMzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JztJi5fBj0TaSOF9fB6q/cSFAoVYJfe3ZqQiHonxvB0UuTXz9Edmii7uAeGbtqy3GdIyh3Q10n2woBfgAs5cMg6REqzrTqyDAILlVsttckqVqUeSUN56sNjm5saiLwUSPC6vN//w9GpqmKAY5QkRxek0kv3e02/m2r23+74F+l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jwD5tr+8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jwD5tr+8"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5cEBw1342813;
	Thu, 24 Sep 2026 10:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=MhL26xstVnZl3mFxUrhrt5lcR0/SBr4baRqO6BlUH
	9Y=; b=jwD5tr+8LrmRsWWrLb+k2lkIQb7Omfup/cc12iPU0iE/6nD6k+a1VhgeX
	fdLK1BYIHYE/qYrod8kk4MpD18k6I3/kt52tDe+pn6y4aVIxfb/N1JgtUobSX++B
	HpevpuDrdp49TKjr3txBvlNz/k54HnCjz4mu02EGmd2X0G+I/31sVFOl0CM6Oy5N
	rVYPfGFQx8CGlL1MUl69tDL9qRKzaZTNY29Yrr+Z/yibe0LRW8SJLGeMAEHXgva2
	/C8PfZ8nNFIY5dpFLpisj7jlYeErt3rauuixJPcMY8XKY9PNDLLvthapnDiNRHQB
	f31pqzsDZ4mapNLbZsifLhwsLQP0Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2rh00-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 10:47:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OAMREx1554949;
	Thu, 24 Sep 2026 10:47:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8jw9vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 10:47:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OAlYts50856258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 10:47:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 913DC20043;
	Thu, 24 Sep 2026 10:47:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A69720040;
	Thu, 24 Sep 2026 10:47:34 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ehn-de.ibm.com (unknown [9.224.79.183])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 10:47:34 +0000 (GMT)
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: oberpar@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        brueckner@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
        maximilian.immanuel.brandtner@protonmail.com
Subject: [PATCH v3 0/2] s390/sclp: Resize for sclp-vt220 console
Date: Thu, 24 Sep 2026 12:47:30 +0200
Message-ID: <20260924104732.1978942-1-maxbr@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: EQaQ9uLcJDRk9w7JmupZKBLsJtTL659S
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab4ffcb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=_utb3vzC3PctqlYe5i0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0NCBTYWx0ZWRfXw9BWMymLy8xR
 zvQgjqSWAKSe2HWQNXH0kqYfLd69BoX7pc7/ENnMVF+wELeyftMnWsQ+sRXUdvJ6Fnk0Qk2Jcyz
 Jsql4diT3Gy2TVnyDeWeBL+JAEQ1T1Au80J2RoafgBYuKoaRhO1CRxO24VxCR8mow0bdMeDwb42
 p1JJqYcHt5rwuzN+hFfgM9xew+NDF4COWSf6NyV5xY2qsI8U9epZMdLso6NYiJOEMswPOD/ZEsH
 UDP9oyqA+33kFAwtmh9RBJwm0eeJJWX4VwfDW//merBUJ5pM4slX2uu4VbbKNXe1FTFyBDyau+0
 I+hEDKh61iZEjbqVkU5GK4Oeu4BJg5x62k6O1+0I8KV3WNGjkur03gCYaiZ7/za5t6wIRft03lb
 Ez4dLYv7Th2Wv9Ce/0WajQy1DkvJ1WbxYuRoKtBglrLjPa00DonmyLd7yj3rwu+JKieM7uKVXVS
 wPPX7cfrrRpdK2Ok87A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0NCBTYWx0ZWRfX+9SG6QBIlAPT
 CmEb+OfuAffUknvtRI+8QGTzGVdgRqDsMV1wzy7XaUyFccFBJrud2DmgUbi0voQS+5jsdnqALcv
 DoGYoqdwW3pg9SbrOu9mSxAK5lAG/KE=
X-Proofpoint-GUID: LGgjYQ_8nwFIO6LYwTKINWItZNzfwCnG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240044

This patch-set implements resize event handling for the sclp-vt220
console and refactors some of the surrounding code.

---
v3:
- guard against races when setting the initial winsize
- validate sclp header length

v2:
- don't set the initial winsize asynchronously
- validate sclp buffer length

Testing:
- Tested on QEMU: commit 38879a667f with the following patches applied:
    [PATCH] s390x/sclpconsole: implement resizing for vt220 consoles
    [PATCH v7 00/12] virtio-console: notify about the terminal size
    (https://lore.kernel.org/qemu-devel/20260609-console-resize-v7-0-0c550fdcec15@gmail.com/)
 - Tested on linux-next (commit c1f49dea2b8f)

Maximilian Immanuel Brandtner (2):
  s390/sclp: Introduce dedicated sclp-vt220 event buffer type
  s390/sclp: Implement resize for sclp-vt220 console

 drivers/s390/char/sclp_vt220.c | 87 +++++++++++++++++++++++++++++-----
 1 file changed, 74 insertions(+), 13 deletions(-)

-- 
2.54.0

