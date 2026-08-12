Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2A838E129;
	Wed, 12 Aug 2026 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550139; cv=none; b=mMRECAgtb7xFq88QLWckBew85gcLvE4/r7FHBCwO8l2f47oGsTE1ZIouapOEiPQe1ImMdbEP/GX6ko+Nsj5Q0ZNLM6WPc5kqAVuyi4/cpVMI4VwlWTMDfKj89a+qk5HjvOyD8+xeMp1NM/uz3unAdL7SL4wR8D0uduGiM55ItK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550139; c=relaxed/simple;
	bh=/M3cZ9tWi04foDvxUp00P+i4/eului6c/MEbpt6Ol1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kugnY7+AS0KiCVIq5xGWzHzajgZ8N/MeW45a6qVjfxhJUbHkS+Jawl2+Bhi3huFf4binewAMwi9hf3rh6ybl9MdKgubAYlPCA8tDKbPri9NtV+7iqe7LdhHwDvfPiQBjii8uLcp4EvrJn5Bip6Iw2m6u5rDvlzSVFuybA+Dz1jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fDJpha9k; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fDJpha9k"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1RI93686394;
	Wed, 12 Aug 2026 15:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HAQjSk
	k1XabV5AnNe6uhk2qvxyeDu2IrbwXgCLMJS5k=; b=fDJpha9kQvodRcoa4NLR4m
	zHJjviC1dPIj5XFNPQQetBvjALpRyhsMN8OzNb66jG1U5lGwJZKi08mDQXM7OIh0
	vdd17FRdi9jU7qOqxB9c6IsO/cSQYMmUa+TEEX2k2RkXyHlDIKgXf3dKpddmHe9n
	iD6/cR2MXART0iNOQ8hRn0eMTRZBn5u5eohDSC7Sie2HtTWA0apU7ArfxKeYHrLX
	TrV3uDN64HyDW8Kbdf9zogROhJh4+d4dOrvBq22epJR6BauL6mNKQoUXF+v+enKG
	f47BAwYMb4jLSQ/WW+KsrGVpk/PDEKsaexo8bfsbTfUXk2nazJxD+F11vBZux25w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9ucte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:55:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFfJhq000436;
	Wed, 12 Aug 2026 15:55:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h6qc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:55:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CFtVAx34668870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:55:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F280620040;
	Wed, 12 Aug 2026 15:55:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C122C20043;
	Wed, 12 Aug 2026 15:55:30 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 15:55:30 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Wed, 12 Aug 2026 17:55:20 +0200
Subject: [PATCH v3 2/2] s390/uv: Prevent potential out-of-bounds read
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-uv_secrets_fix-v3-2-a85bd29e0666@linux.ibm.com>
References: <20260812-uv_secrets_fix-v3-0-a85bd29e0666@linux.ibm.com>
In-Reply-To: <20260812-uv_secrets_fix-v3-0-a85bd29e0666@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX4Tmyso7ugs3q
 mJaGHdbbJ1K71SlrWc2+yxg+4IrMseEVogYdJwAef2YpCgh/J1ROzJlGx59kKEvG97ZhSjjzvEA
 AYXVTMqWK7cZ+0asR+xp6YEbwzT8ps/Wnf3Tv/QnXHx28jHCJnjpBM/4cQmF69X2KV9GBozZIw5
 SRafvB8SBToqN16C7D67Q3QbWBUfSHwo6MuZDdNYlrsO6tn0n1Gk2elh5tvC9gdEBEh2bkKNRBY
 +rMv4ZAsHG29VQSgYFAbgml0nvCJwDybY+yhYTDBEnDosmw1Tniahf791Uxghn+wYhMYq2UpcSK
 8XS/rdiOm7sAifBkW2MGQ6TQnmB7vSqL4hL9R6dNFvSREt6XKu/QBsdK0TodxavXIP4lFqP9jEy
 UfWj5j3aT4JFPbxQo3kWPO92SZHxFZlEcbt1EHlvX5fd//jY6lVSJ2hIV3mn8JSSl5heRZgkvRX
 yxDa8x2kV4IPmGwpWVg==
X-Proofpoint-ORIG-GUID: kyj0If_SH5d2-A-EfrcLljjZwh5z8KWq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX+YCxzgXO1kSG
 ilS2lG5Zhs1q8QAGDoObhewIwmJzxVHXfVcqCNKlsOqk6lZIu/wBwUHmn+SWekHOXE+SDzxh6sJ
 6CSJ2JReUyHpEhs1BhCYCknV1Qxuq1U=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7c9778 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=25poj8ZeXyvPz4Svze8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kyj0If_SH5d2-A-EfrcLljjZwh5z8KWq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120126

When the system has more than 85 secrets, the uv_secret_list struct
array only holds up to 85 items per page, resulting in an out of bounds
read in find_secret_in_page if the targeted secret is in the next page
or not stored at all.

Fix this by looping over the number of stored secrets which is the
per sub-list count of stored secrets and not the overall count.

Fixes: 7c9137af2042 ("s390/uv: Retrieve UV secrets support")
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kernel/uv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index d970b15ef126..e70acad09cd5 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -760,7 +760,7 @@ static int find_secret_in_page(const u8 secret_id[UV_SECRET_ID_LEN],
 {
 	u16 i;
 
-	for (i = 0; i < list->total_num_secrets; i++) {
+	for (i = 0; i < list->num_secr_stored; i++) {
 		if (memcmp(secret_id, list->secrets[i].id, UV_SECRET_ID_LEN) == 0) {
 			*secret = list->secrets[i].hdr;
 			return 0;

-- 
2.53.0

