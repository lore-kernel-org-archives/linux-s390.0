Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A18B3EC69D
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785841102; cv=none; b=OtXo70T0pTR9QZMSHmOoCp39jmQ7lGygRtlp6jPaLHsq5faPpenXyvr+GPjKeN9rcAxEukb2C8yd6IsGwdVXZndVgRCjwtR+FJ7vwpiVu6zPGoVCSdlafPt1eFsvGGqx8+d7DN7OOICyZifoMCP6uCGAiTZUCQte0yIQORPGUxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785841102; c=relaxed/simple;
	bh=ApTCrjkFyIQOQYBuGVuie5a+jG/e7otkmdxVSBzRsHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=szMM3eBgbaCsbBa2l+uEqVkHkPR0ir4lOpmUpzcqA7K8PAMEtzAR8K0UaaRz7EKO50rulFAei82VzJ0Vm978oXHOsy+mOCbUyILmx6duTmYNNjyN/rRPCl/FvJGPxpztTCUBbhGLldmIrBVuvuS77ZWX7EweTxCWourBH45D03k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i5Uw/fFK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i5Uw/fFK"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748I2Bt324250
	for <linux-s390@vger.kernel.org>; Tue, 4 Aug 2026 10:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=vhRu123j/8OA2qBYIQQsNjyU2ER2+oxleQ3SnwRws
	ng=; b=i5Uw/fFKhqDmTM9VizmVDIIdBypW3AliGKeUsXwK4OiAauhnUb/Jurbah
	RuSjg1+9rpMPcmAlrUX9Fu8ud3mZxg8eWs9uZtUzSF094ZKDh4Jbu9xeFFAAOy5c
	zhymZ0tx28ohrhKZcLrAaR89lsR9UZWiF3pR2zEqjGEw6UnjeXz6tRjOCCBTpns0
	UsQCc9fz5qeris7JGjPiecszIa3ZFvoFMAsUwzKaQaENWhYjrUCBhlkGlXw0zEzC
	f5l0rJjuNY49k39KErzKJ53qhDeVBmyfywKbT6bJUpp5mqxYlcBSCsNkIImVDmoU
	z80UJlpFCNX0/39osxNn/QxwC3mag==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4wf2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 10:58:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674AuGNN023285
	for <linux-s390@vger.kernel.org>; Tue, 4 Aug 2026 10:58:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qhrgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 10:58:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674AwCFb31785514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 10:58:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 041742004B;
	Tue,  4 Aug 2026 10:58:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA4BB20049;
	Tue,  4 Aug 2026 10:58:11 +0000 (GMT)
Received: from ibm.com (unknown [9.224.87.205])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 10:58:11 +0000 (GMT)
From: Finn Callies <fcallies@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, fcallies@linux.ibm.com, freude@linux.ibm.com
Subject: [PATCH v1 0/1] Fix MAPML calculation in ap bus code
Date: Tue,  4 Aug 2026 12:58:10 +0200
Message-ID: <20260804105811.17744-1-fcallies@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA4NSBTYWx0ZWRfXzBQTxZsOyemj
 wAgV+nSOLL4GoE163/me5xUUoOhfYESolN24jzi4M6+1/h+kUsa+N5VsaeK9vYWzytEyVy+PByX
 b+dQLLbJ/2bZ7HsnOR1DiA9jcUTEa0s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA4NSBTYWx0ZWRfX11MQFk5FTt0T
 +xO80HBJk1zkqkx0e2lS0uqAXs72ovHtM4lhqOHaxwdxVyAOdzMpWYIgIbMnIhXuloJfUz1j/N5
 OJj8JzseS7vMyMjxowQdZYB5p5KRAljeKKXwjmVgnaQ1VQkuDq8KV+mZtpIRlEqPN+ngHwfuJdq
 z4b/22zQQaTQ36rzlRSku7DT8OOSNKYTrnMhJMscXpFcPJDXt/dvK7s7MdVuMNQSVWI3PvYcJ2B
 pmrlke7wL6MQO43zyEoIA11E3FRtMdqZ+CvRydKd1ZQtKqorqkxzKz1POwqhBoI2qn7SWFHsf1B
 pgLtVpxGa2bM9DDiOkNWrXsfZAvAcmM43VI7+GdHrPkhnqgEY3Ei31E94iMqLiuiXlaLG/08xb6
 P8CDXgggu86cgJ4AJkJxmUUx6ICmSFBpAJiPHEcfWZEjUKuXV3UXQJcLNIwur1yPHdEHYQaxpca
 Em05i+0VjrVEbbiUihg==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a71c5c9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=wCpBzOWL--O8ZXUuk9QA:9
X-Proofpoint-ORIG-GUID: pMKRj3qBhaXJG7DmlQugHRWnEdhXT5o9
X-Proofpoint-GUID: pMKRj3qBhaXJG7DmlQugHRWnEdhXT5o9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040085

Pretty self explanatory...

====== CHANGELOG ======

v1:
    initial version

Finn Callies (1):
  s390/ap: Fix MAPML computation

 drivers/s390/crypto/ap_card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Finn Callies <fcallies@linux.ibm.com>
Linux on Z - crypto

