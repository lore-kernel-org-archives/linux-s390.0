Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA173CB2FD;
	Mon, 22 Jun 2026 16:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144470; cv=none; b=SKk014+S0wINHURSMkVX9slhJfOHlW9jcUqRgz22brxcicRMmx/jRB8o6Dvxh+2etPJ6/B6/V6lI3lga4dPfABwx/T59vrIkZGLRo0AK1RwTASEXmxYwfKPBB5EEFJbKPFQAQUeQel3MDi3FKW1SYS05btlbeemf4l1ZGf1udIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144470; c=relaxed/simple;
	bh=MotyW5vj3zXvDoMxIEdjCCbCRVxwaVElCvaRRg6AbiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/k4/MfjofAlaI+ttOXoobu/O/6ZqZ1x4vwN2Z/VLSS7wyF7DoOLUg6SsySGIbOCxp+lZpL7WS0h51stXLpGAN7mW0uegE8dt9LIVT1f2FTGDx2dcPV9CPF5gtJzvqq6MXLPzBPQwCCQ45HBitWUvRUBgCAz6Ea7hqIlK3lzJvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=achpKtol; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="achpKtol"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MFmREd3394137;
	Mon, 22 Jun 2026 16:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TzaokU+Y+h3u3u2lE
	74js3Fr+ir14XtNtlTgxLuH7gE=; b=achpKtolLOgZcsjIx2g9uxa9A705QtjqX
	3Pgdj84d5w2hJ3mdHNotW1b9dBossyxcy3EY8pFEhjkc0VrLnkHBc/YidnbrO7x4
	umyFxrSOQa0FicKz9pIASlEgKrezxFFmL+JF5FA51tXX1ejmjgTIIrEUgNa3bUoa
	YMvmll37oo/4onpIpyWly0h+gXugigO7ssP9bK6vKK81yusvZCzat3biTkXKnZHJ
	gdRRoaCiLETtgNEPQx1A9FMa6d5haRx1nj1f9jg1H5yHeJ1GhUsap2lAoc/lJc6s
	42rzwclg1rOIy2fG/hWS55dzy+zu6AESUbFmFPVvLVfMwpzjolxqQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9ga6n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 16:07:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MG4j0V028244;
	Mon, 22 Jun 2026 16:07:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jw73vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 16:07:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MG7e8K43319686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 16:07:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AACE22004B;
	Mon, 22 Jun 2026 16:07:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 745BD20049;
	Mon, 22 Jun 2026 16:07:40 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 16:07:40 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v5 2/9] KVM: s390: Fix dat_peek_cmma() overflow
Date: Mon, 22 Jun 2026 18:07:32 +0200
Message-ID: <20260622160739.202044-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622160739.202044-1-imbrenda@linux.ibm.com>
References: <20260622160739.202044-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aUBMSCfIUPZGwNDb-5syE82M5Rg9IrNu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE1NyBTYWx0ZWRfX+A8bNY5XgVEg
 ZVAWz7RcX+VyrNHMpE5UUqoo8OY1lvc9Zp+yxq3eZP2lta7oa2goQwgxM3GhbtrPhG3FQUJMV0v
 WAaSeU+Xo/mtdzGkQ6jukhqbnPdUzmI=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a395dd1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=0SZZOaMt82sS6LYugLYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE1NyBTYWx0ZWRfXyFfF2JTM+OxC
 iMSSwTJeGSDlL+sHJfOj4Xp8hhGnqPo0wS2Ac1svvRVP2VqmGFiRwI22aKegUtwUw7Fh2jWGXbC
 Wssj7slarMMcx8V+wr4Ujg0kcO6EmcsTufCnKzliJbvh69zvR+/n3tTH+VmLzbqwvZ0b01nxPYw
 1bW8ckYP4acjJVDyeGWU2cUs1o8tteIoyAG4FTSFFTn2iBjAlvwaT0RMsPtcYBbVGiF8xSimlP6
 0W5wq4bd4cs+fLluUUKxwgbc2XLlZJTcaAi9um/8OrWL989i+LXUUoT+FFGJ439c9YZdlqpj/s3
 vevylk14jSGAFs85+hVM5lOKLVj42/rlh1kTr8phhNo7l5MR+tQ0unUSFuI8wgp3o3PicphHbmR
 hefDN+Tvz1kgdCWd+G3pR7hPsHdeEGWtPqGYbY8qt33Hw5QeuKlKWE8BeiImHECzN4fJfC60Djx
 vKh80V7NhJpOwG7YXpg==
X-Proofpoint-ORIG-GUID: aUBMSCfIUPZGwNDb-5syE82M5Rg9IrNu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220157

If userspace passes a start address that is out of bounds,
_dat_walk_gfn_range() will fail with -EFAULT, but state.end will not be
touched and will stay 0. This will cause *count to underflow and report
a very high number, and the function will end up erroneously reporting
success.

Fix by only setting *count if the end address is not smaller than the
starting address. This way invalid starting addresses will correctly
return -EFAULT and *count will correctly indicate that no values have
been returned.

Fixes: 7b368470e1a4 ("KVM: s390: KVM page table management functions: CMMA")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/dat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 4a41c0247ffa..cffac7782c4b 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -1209,7 +1209,7 @@ int dat_peek_cmma(gfn_t start, union asce asce, unsigned int *count, u8 *values)
 	int rc;
 
 	rc = _dat_walk_gfn_range(start, start + *count, asce, &ops, DAT_WALK_DEFAULT, &state);
-	*count = state.end - start;
+	*count = state.end >= start ? state.end - start : 0;
 	/* Return success if at least one value was saved, otherwise an error. */
 	return (rc == -EFAULT && *count > 0) ? 0 : rc;
 }
-- 
2.54.0

