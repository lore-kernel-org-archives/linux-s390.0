Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249852BE0F9;
	Tue, 13 May 2025 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747150840; cv=none; b=Aql6TjgsEScNtPCK70s1OpRMUCCibwoGI78XKhI1k6JkCHHh06ylVeZnuItXoMwLYQ9Jx9bcWjxQmGTrP1Olum6AAp8aYNNDeyWuL9MG3PY9Ku+8E5B9Q2rVZyn7fBKuBODv1QFN2vvNaylK+nxsPHzqV+ppLBPZZnN2i/2vMcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747150840; c=relaxed/simple;
	bh=CA9HKh4zrFSNCYLEtZ0JCP1cKMnxrY99Mpg4RTowzeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TkYyJk/PuFKetPWsw8DJHz/nHHEOmjbiiIbduYnAzOokPdLu3XPR45JpMFvkfjvtpxnZsaFXSnWtAa4WW4aaL33enxcGFHRZplqg0ZFSF53vHpoVzSWPlpfLh8yQzlGdjfOnRZNXPwn7hzi0D/l31Rf1xSdnri9fI/sTBpH0LgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hxvAFFFb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hxvAFFFb"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DDni6C032140;
	Tue, 13 May 2025 15:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=CQfh1MzvC6iT6mM7lVHwgZXBAw8DRUvB7ncdS0TY2
	e0=; b=hxvAFFFbkhqdWNx95+5jOo17Y6uIjiDUF7i8oTaX/TkUPk3FjUkX1Wjl+
	y9t5ShYsSoAYgxO2faRcbywCasa2mSvTKs9Ylkx1mjVQPEoyeir2fAwlhnT77uKl
	MrS4AxM58esi9zO8wNKw1uFULgqn7L71vIo2IGkNXx+EW78lrBUTzD5F3Bz51ctA
	10wfAh6abnhyXwFvfr3yDVVB9plJNW+w4pDuxaOvU/1KGmIUtUTWRRpDEzMzoJ01
	ZgN043TjpKI/NVgfuHQYqnxedrP/G8qZdZf6qJo20gkuqFJzvItSZOPWyBwODPOb
	vpq/7kK7y6EXr5qPUSbOB3PokCSHg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46m7a70jc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 15:40:31 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54DFNlGl022147;
	Tue, 13 May 2025 15:40:30 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46m7a70jc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 15:40:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54DBt8I0011552;
	Tue, 13 May 2025 15:40:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46jku2be14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 15:40:29 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54DFeSHS52822340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 15:40:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E17F20102;
	Tue, 13 May 2025 15:21:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AAFE20101;
	Tue, 13 May 2025 15:21:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 13 May 2025 15:21:03 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id CCFCBE0609; Tue, 13 May 2025 17:21:02 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Daniel Axtens <dja@axtens.net>, Harry Yoo <harry.yoo@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, linux-s390@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v8 0/1] kasan: Avoid sleepable page allocation from atomic context
Date: Tue, 13 May 2025 17:21:01 +0200
Message-ID: <cover.1747149155.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=K8ciHzWI c=1 sm=1 tr=0 ts=682367ef cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=dt9VzEwgFbYA:10 a=M4n5Zv9w_bjhLjlc4U8A:9 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: DBBehTTBvX9qsC78fS4B-Pq9qcDH0x5W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDE0OCBTYWx0ZWRfX3Ro2qgunbtst YpiEJWshZEpwgFgNh6DUgLqham72fs4BvvKMKutOoHPSH07AlpYe7pQ5YCi2HdZ5nILC75uCiju IWYImiPzfWf3podYFZOjSls1rcOdgk72yDa3rolzKL4vg7MxTtRRzOD7Zs54dCpcFIWuxuu+EK0
 QkIJ/BRGoGmhUCBjzaDyz1IMReBDty2ghHIQLCL1vaAhGz9JkAgbrDVty+dUOHB1jXN44t7HVJK cMtIYLYwLwmus3mL71kB6cl1K28JDvLF2O3KG8dkNu9dJXSM3ofh9geWQ4w/j6r7+O4igy6meEp 0nXf51BmQu16OcHzaLETtDpfMQ+PxaAqgY6hNFo+C5dr11+LBz1O0Gz/NEb1ZL+oousbZmNyN0g
 kS3cSLrkhmXIK/w+vptnwdeTNCkhyZ72QS3kKi57VyvofCfZSG4SaN1iUvPpz4AIUvoDujXn
X-Proofpoint-ORIG-GUID: eeJyLkhC8F1qa6Wbqxc-xE5X7ub4YSI3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=721
 phishscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130148

Hi All,

Chages since v7:
- drop "unnecessary free pages" optimization
- fix error path page leak

Chages since v6:
- do not unnecessary free pages across iterations

Chages since v5:
- full error message included into commit description

Chages since v4:
- unused pages leak is avoided

Chages since v3:
- pfn_to_virt() changed to page_to_virt() due to compile error

Chages since v2:
- page allocation moved out of the atomic context

Chages since v1:
- Fixes: and -stable tags added to the patch description

Thanks!

Alexander Gordeev (1):
  kasan: Avoid sleepable page allocation from atomic context

 mm/kasan/shadow.c | 77 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 63 insertions(+), 14 deletions(-)

-- 
2.45.2

