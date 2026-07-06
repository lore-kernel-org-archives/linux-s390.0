Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94186388361;
	Mon,  6 Jul 2026 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351162; cv=none; b=qpBgkfG+K0xngGpS5rzZ7P3pIaSu6eklJyYIamYRmfuRwcEMYnFT6AWhZbcKhsjJEAEJsDUyqdWP8dvGZSfoX+kDPoFj6az6r8i293n1zJRN3dszVk3j+uNJKqbPdH+KaQspR7q2HFJlFj22jHoAlPXXkKzD2UkKnAdb6seVOPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351162; c=relaxed/simple;
	bh=/em+/fWGqoO4FJ4rk+/EAbhj7WjgSWw5ByHWYq7p9RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sR5XoznBaTB+lQHH5/uz3X65vnmI9kJg18M5ukwcMujdR2lRKbu18ApoLAPeelk16tG1s1IEDt7vj/dLH4mj5aR8EZA/Efd9dtDTjovMm/ExfDLaFoD2P77NBQSAzjS+ZKHXr/45bbq5F0vD+TCJFQ3zy4yUivIPQwFJP0nS3tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PjOA3vQU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PjOA3vQU"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FIKIH962075;
	Mon, 6 Jul 2026 15:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=+BnXVWJEaGq1dERwqjSHiClEYeuJGSo7brU1K6OKm
	GA=; b=PjOA3vQUcuUvyCMwyNYYNCm7HpuOj8feOfJvSyarNSUSjawLTwc2UOh95
	UklQJxt8OzNMUqw944abQJj8XB0XtT2Dkz+0koXTmnzjelaelcn4K+ihhwxf+rb/
	/r7Py40Lz+xwS8oUf6Zg39tP7c2oEUzHc1oQD6cZ431y9rJZspQXVptdsNHpDr0K
	/5ovouWZDoNNRCA0sfl3VFOBv2Q9saW9YxLPtnhvsLd7RW+VMBkPoFQXHJxpgpZy
	c1wYrEvJT3An+t+lI41oP6bi80h0/3ytiVtUMBewh3i6rVgrnuCQ0LLypb4RlsQC
	l9B2wocuxhgU5UpFWDpoZufi46PIg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqj0mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 15:19:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666F4cXw019990;
	Mon, 6 Jul 2026 15:19:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgjx4jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 15:19:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666FJApd43319650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 15:19:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A972220043;
	Mon,  6 Jul 2026 15:19:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7707520040;
	Mon,  6 Jul 2026 15:19:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 15:19:10 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/2] s390/vdso: Fix GNU_EH_FRAME PHDR
Date: Mon,  6 Jul 2026 17:19:07 +0200
Message-ID: <20260706151909.103539-1-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE1NiBTYWx0ZWRfXy2EBRDchhfDY
 GxyFl6opurzYzSgl9DghdDs19o2Ul99QCg/d3xeG2UjnO20yXBMaZ/AYxUqmIJ4XRmLt5fd5R7y
 Op5EOoP3POqdSf98KpVZviwo8EaiM48=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE1NiBTYWx0ZWRfX1Bw2jcDUw7yU
 47Hsg/DKvZxvSfehhDsWy3GCly0/f9JkBD/dC9HtRpgVx70wAdEuzP8BloDamyR2aVmFYUeropa
 P4zK4T29gK5HAOZqfYtZcTKJEbm91/VuKYW7qcp/tSEGhT/1sQFz2OhLDODXfOLWVLyQLzHvmhK
 y93i02l84cgOYa014f2QFq0I9xQLXIBc7KKz5fS0kVPDo3QWeF5bf6GXe3WL3Dq8NjKS1ViyJUO
 QM2U1/Z6yupqwp8811Aqnvp37HhmzLuakQJkFnPULWqRNpVgvjBb1vwzgDywRmFwOjWapnCEuiG
 GrfYI4rGTo4U9NmaD7RcZMzkgsKDs9viTQQ5Lu0GPz+Tc3+0b0ADmsLSloFH87ksKVmKotubMSl
 x+5jtZgVDgXVraS7/Bxbvm5fhk1DWHBtTRzAs4JW7xmcChjpp47K0tNQp5jY//5LrascQUc/kLa
 CWkE34EWUysOR5YYOIA==
X-Proofpoint-GUID: T0CHmP5E8nmUze8j1jj6kGcGO_BCPu8v
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4bc774 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=eGuSQdGhVvtJuAFz5r0A:9
X-Proofpoint-ORIG-GUID: T0CHmP5E8nmUze8j1jj6kGcGO_BCPu8v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060156

Patch 1 fixes the empty GNU_EH_FRAME program table header entry to
enable unwinders and stacktracers to locate the .eh_frame_hdr section.

Patch 2 uses symbolic constants for the PHDR permission flags to improve
readability and explicitly specifies the GNU_EH_FRAME PHDR to be read-
only.

Regards,
Jens


Jens Remus (2):
  s390/vdso: Pass --eh-frame-hdr to the linker
  s390/vdso: Use symbolic constants for the PHDR permission flags

 arch/s390/kernel/vdso/Makefile   |  3 ++-
 arch/s390/kernel/vdso/vdso.lds.S | 12 ++++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)


base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
-- 
2.53.0

