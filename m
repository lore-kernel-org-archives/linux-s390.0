Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFCB31280C;
	Mon, 20 Apr 2026 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776687245; cv=none; b=TQRr9Oz3SQ8+D40KxoZxJYaqNQ1AzgnOEzrNkAr1n6w27nw3TrAqZdAVohpPTF/a8LtOWeRTr70DHt2tcULnIxzzKhqyhodzrNVNnmM4TzdprS9sNEmuJmGQr2mJ2CnIOAFBFM9RoGEjKVUT6i3lahftVzPJc3QXJcEG0BqdGTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776687245; c=relaxed/simple;
	bh=s+lCGpiZKuBU4l1IDT/DawFQHmq0aOtvV1SBpsqqCCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E2RPuEqHeke9dHRlHxzHCiMiOSmGTDAp2SLMymDqQj6ppG5tf8Q4ME8CVQNDiV2CCvF1wBxt0egCNeEc2w666VYCZakmIAE/QmiozMCy9iVU4uKZbKlDEzibXl4vSX++cDJrIb0iE13PsbiULp8aR+7wzgXACdbAA92fUO9CPcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gZlCJ5pD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gZlCJ5pD"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KBwhMR3108458;
	Mon, 20 Apr 2026 12:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=nJgkI7RbD14lsI+Zd/4+PHkt3gvbu2pFlqS4g1GDZ
	T8=; b=gZlCJ5pD5kc83eh5zvwSCEi9K3XB+Jhxx/wY6EVtWFO/Vn/0kfi36XFU7
	2oFHN/Eer94Ep4So2zkdKNr/V7mDWL578U97h91FTPxd44dasc5b8kgRTU/WIKXq
	JlMqZTiaja/LczxPc8ij8ps29D9Kg1Mo5rI3jt3sD86kU3YkdaWSDbxXvFymbSpw
	vYrAxJPzCpRsNKd/J6SErc8Tyeladv0t9reudoPsAeaSMF52PQf6ko34L2GVFRHf
	1tVsvNqyUhHCM9MePI4Qijn7wKmeN6UjZT9aVpMnuu3Iv+PxnZNcte66NQsQ5My/
	+JOKQJfXBUNKeeWAiE8ZUbrD3eeyA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2h9f0f9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 12:13:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63KC5KJP021295;
	Mon, 20 Apr 2026 12:13:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmm9pvt7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 12:13:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63KCDrKh31130260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 12:13:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26C0C2004B;
	Mon, 20 Apr 2026 12:13:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDC5420040;
	Mon, 20 Apr 2026 12:13:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 20 Apr 2026 12:13:52 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id CF88CE0749; Mon, 20 Apr 2026 14:13:52 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: [RFC PATCH 0/2] mm/gup: pgtable entry acccessors cleanup
Date: Mon, 20 Apr 2026 14:13:50 +0200
Message-ID: <cover.1776684344.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3GfFdJNwNXlttYprI9xIIKLTBOuuPMXI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDExNSBTYWx0ZWRfX3+75nW9ikULN
 mk6WTmIRZda1SiewI32TVpWu8iMVv1xi9G+PVp3buQufIIvXGRvHANLKVyw1kIcUqFpsMcevp5t
 5keATs1YycwiEytJOmN8QE86QXE0/HavXDcewGxgcf/1J1Ixxd81jmcbj2vNQpqfOjfgpHHVL/r
 jNkkgMY7x+G80KXE2g8CCNw3zGvans2JJfYllW/g9oSxoQ2JgBr/WYnw7ph/nD36dbMwBwjlzZM
 ba2jhjD5MqZbuhlMzjiRHledWj/E/UzWpRTxVp8UvNLn7ltyOAsNFvMPDY/vzt6lsUYXtbfFv3H
 sEz96nCSGikjzvYDYm3Wq3lMGH1TrvXAC5mJ4sFxGtG9jkdJowIqeha4W9V/RVh6S7fKQ/6MP4k
 vNi0IGoc8oc7pSqJHDgwYd44+CqNDWyaO1+SJXhGFThfJsUDlLua0cpBEBoOx2AmQj7x4XVk1Ih
 +/Q2f/3IEg71+sgLu7Q==
X-Authority-Analysis: v=2.4 cv=XLYAjwhE c=1 sm=1 tr=0 ts=69e61885 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=aTGr7PAGRYz1C1UlONgA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: 3GfFdJNwNXlttYprI9xIIKLTBOuuPMXI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200115

Hi All,

This rework is necessary to allow a KASAN PTE access sanitizer
(so far s390-only) that hits on direct PTE entries dereferences,
like pte =3D *ptep as opposed to pte =3D ptep_get(ptep).

I am not posting the sanitizer itself (yet), since it does not
fly without the suggested patches, but I am not sure whether
these changes make sense for the generic case.

Thus, sending it as a RFC.

Thanks!

Alexander Gordeev (2):
  mm/gup: add missing pXdp_get() conversions
  mm/gup: add lockless access semantics on entries validation

 mm/gup.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--=20
2.51.0

