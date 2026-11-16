Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839769;
	b=Q7q4lpL1nhRzyeM9j0gSWFQ6FKh7+uxj6GDhxtIqdbkmz74RJaF5gB8fmckfsWibBvjD
	 pCxQK2IL3sKphNDgcAW33HfcMEeH0PHvL3ptKSKWyEoT8HhwJAFVwx8tYLKJuu4EaGjRU
	 W057FK+2knbQgP+r5NVW4MXeGyrRRINkPVzgGLxJ+BqaHaoaO/0MQxk8QuZnqb4oeysa4
	 vv39fzqC/yeYBzrWE1vqjXnR7eyEyjHlC0wzp0jOe5XOtqNIdM+9kPBdTP+B1/mD+5i8t
	 8k+93+QRCGrYqhyVZcpPj+HsAxcSvIYb5XOqyRAZVT52ldwgpM+FkoUuiCiX2LYiNTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839769;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=QROLCvXVdb/joVZydleSGlQ1lSZPrcgD28BofkklKnw=;
	b=5JPc+fAz2lvJbYl3OgNEb1UkTn0lljkBMJmlwgbtfvgycoD9N7g/K9wZje3ALud3Cnxk
	 XJAZyCEUAuKBvqzywzApmJgbXWbhNHqlldSoz3oyKFQx1oqYR8yjafV+4Xv/HAMnB2sGL
	 3JXs7oQ51kmoISkHrNiSfJ+YexoOsmu2NnRdJ1LkYJIVP6rl1Linuaf0OM1oxnS4ls/0J
	 slz4pUc9F7TXZL5xeRsYrGSV7EKRwlxil8aGH7M874QR78vZc7AhFdWx1URJue+xIFmz4
	 A6mcIeIAJCy3Ax7PGvEsQnn1yyeI06YPttSfRHt2DdI9XQeKW7Vlz5BTI3/UfMGmyEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bcHXql0d;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8841606A881;
	Mon, 16 Nov 2026 14:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8841606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bcHXql0d
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGDuQZm3631163;
	Mon, 16 Nov 2026 14:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QROLCvXVdb/joVZyd
	leSGlQ1lSZPrcgD28BofkklKnw=; b=bcHXql0dUQDTUtoqTeH6m++xY7/cKUVHz
	ozDm7s/L6gpMxDq6hL11n7FTOUyiJbbo07/nI4wwqdlNn2uLRQupbTiI7m4mhAXd
	zHtvVSUjWD8z16+LclP89QnLyQhQz7c947IOSqfxltPOcZS3bcxmqHGj5uyyI3BA
	UZy8g9orcii4ggU5SE3/TNcppNu9ekD46UttIhDVVCsvRsbAHf/uWMtIPGlu63qa
	OMedpk/dLtYg/MYnt2mGBOG1m8TMcFseGHoY8DknDOrsXYRxycCjJeoz8Xx1B3+r
	GMcLlnTzAygbS6ixd9zV4G26tm+3K6pYon+iy3lVF2s6AGqHkkP9w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxf5665py-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 14:36:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGC53EB1877719;
	Mon, 16 Nov 2026 14:36:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hy46fymsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 14:36:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AGEZaOb40894944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 14:35:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71AD62004D;
	Mon, 16 Nov 2026 14:35:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 157582004E;
	Mon, 16 Nov 2026 14:35:36 +0000 (GMT)
Received: from osiris.ibmuc.com (unknown [9.111.42.169])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Nov 2026 14:35:36 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Anastasia Eskova <anastasia.eskova@ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 04/15] s390/cert_store: Check key_lookup() return code in invalidate_keyring_keys()
Date: Mon, 16 Nov 2026 15:35:23 +0100
Message-ID: <20261116143534.158375-5-hca@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116143534.158375-1-hca@linux.ibm.com>
References: <20261116143534.158375-1-hca@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1NyBTYWx0ZWRfX/ELBfIrl8aHd
 8FNkktdEKtvFXKVQj8Xaxe1kC4FSvVTKLnLauBodojQMcMNwj0vWcbPTVl9W6SItLv85veTIO6U
 7VTh4ivNR9YscTuLeB3MmjS5zRQdQng=
X-Proofpoint-GUID: F04z4-zLd1bDwxN21MK3RHBzOCMawo5y
X-Authority-Analysis: v=2.4 cv=ROImjIi+ c=1 sm=1 tr=0 ts=6afb14d7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=CmLlC_FBG8pvwVJZj8oA:9
X-Proofpoint-ORIG-GUID: F04z4-zLd1bDwxN21MK3RHBzOCMawo5y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1NyBTYWx0ZWRfX3CcZ2LgraU8n
 b33AJWQ+PsbvfqSLnlbINaIs7FCqDlcmLUk+cRj3Z7AqwXeW5Du+xt1RAwJoW1Os4PFs2J3zsKu
 2cap9nx9ppGFA08OJbKoBuwOucySSvs4GvdfB/4ry5OxXcY04P6jY1sXvYdo50teLkHsky0BBP2
 M7P+YHHajXoT3EmOG4ve+vJw0mUg3ZcBJWhpvEgKSPGXLe7s4gsvqF5YJ7wRuAC5MdloDjmBVaV
 a19XXZkQuMDcfNy9KfvQ99MRTRe+6/Flw4BKeoRuGSYHWEgDml+s1w+0xCXEXW1+hzHvQekbquJ
 s+XQfrAM1MAbF0m7KLnrKFmIkVKRLDsPQb9g4wsZo2bBLNbQtWN9w6v2nqrao2O8majLvxjh6VF
 TpwssFbzIQmCtYQBIQpIE0x3rY5mP/4/hVIG2tZ483bpdFTbu5riUqZGa4otQLS0EwDZ+rVU1Rw
 u6q47ZNZDoBE6akavrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160057

keyring->sem is released after writing the key serial numbers into
key_array. Keys corresponding to those serial numbers may have been
removed before key_lookup() is called.

Therefore check the return code of key_lookup() before dereferencing it.

Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/cert_store.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
index e5060777ce6f..8eb32497ca24 100644
--- a/arch/s390/kernel/cert_store.c
+++ b/arch/s390/kernel/cert_store.c
@@ -339,8 +339,11 @@ static int invalidate_keyring_keys(struct key *keyring)
 		goto out;
 	}
 
+	rc = 0;
 	for (key_index = 0; key_index < num_keys; key_index++) {
 		current_key = key_lookup(key_array[key_index]);
+		if (IS_ERR(current_key))
+			continue;
 		pr_dbf_msg("Invalidating key %08x", current_key->serial);
 
 		key_invalidate(current_key);
-- 
2.56.1

