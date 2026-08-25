Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5643403E1
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787673723; cv=none; b=jGkksW2MeYaVhfMCz8+JoiWbjABzUUetlPtNdYfenPl6b/w8DYZYC0PFqaC/Vj7EPSlWJl2Skk97Prr3Kf5kndhhr3OGGtwXOsz9oPmz3GU3ysiaprSUQ9dkqxfFJr3s+nL307kAUlmMLN5JXut4s96PD7xkzChS4gRRk0ClAdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787673723; c=relaxed/simple;
	bh=82GIjjnVdwavk9wXB6jJfoP61PcUzddG1W8NontV2VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UeRR661+7txH1QfSw9XMv+bqWBHK48n1O4bDdds80rZwfYLPtAoykeh49eYFgun8FnUbHuhdAR98jSxFTQ3M9C6wVnLa53+TOLA8O8Xv/WqfVryJhvvkcZgnop70GxTAoBmbU26QdsBftANeP7WJEhpvZQpUVBtr7kzviXBgxl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f3gh/SzT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f3gh/SzT"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PEYrH41118420
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 16:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pWdvs4Fp/3OufvmTF
	H78Ps8KInMb4fWaK5cPMBBzyoY=; b=f3gh/SzTzP2LJXxsUIAdUtwLsZb1aSgr3
	ThpcpnIGv1Kt+0Awjr67I4bFsALRkUtsYpU70psoFXAXI1MmkxsCdeaI0N3MY830
	fix2Jd3/rZ0dtbgkXuyke6h4OEBJfuIzhTeUj6yb1u5Lm06yvyHQJleKFZe/SIft
	iDn2nhH/xEXoRnsk+MHBuOAC8HNOulzQYIQT4ibxICkm6f9DlneI4MjdZGgcSXNP
	/QTrIzP6I+eukXXjwudnGFFIJJ4UowQQ9nebz8mlrDBFRSN6gu+Bu2XuRFetzFES
	2dxnQuFCkS8EVSS9dVg7MYNR2R4jKh9DEOn4uQ4XJ49Dohn6m2A3g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g739417md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 16:02:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PFuGJk030105
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 16:01:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3q58g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 16:01:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PG1t1s39059926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 16:01:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A35720043;
	Tue, 25 Aug 2026 16:01:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35C672005A;
	Tue, 25 Aug 2026 16:01:55 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.133.174])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 16:01:55 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com, ifranzki@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v1 1/1] s390/zcrypt: Fix uninitialized padding in CRT key structure
Date: Tue, 25 Aug 2026 18:01:54 +0200
Message-ID: <20260825160154.106501-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825160154.106501-1-freude@linux.ibm.com>
References: <20260825160154.106501-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DuIKC6Y0zyuneJZ_PndoOKRs-ru7bxJA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEzNiBTYWx0ZWRfX2catLy+pfMbp
 ayBViKJe8RoI1wvET5Xl1smPIXFcCmxggps4BDun2+WX2aYZu2sDPf1/odiUnozen/fH5Wljy9m
 qOdFJMoCZqoSD9OOGldaqpRCpx7KlRAxp9x3EnMRdTMp2psXHrYUO5YugOXrqHjfJ9J4x7DYbht
 1h0eQ8Ci0S7F/j2Kjf+NkqI6tdkkRFICbrglge/N4hUrejAmr10923Ov2YpCzJWvqQMtla1OxpN
 FfG/yZM9+ePArghfRrU7ddPkf+sVL3AOppDT1X+95M5sZtMPThvqBl+P7tSz7s9mVFbu9LpHQ+A
 AZjbqBJLdPD6cwldDtfe2JSnhWNa5gMut8qxxtR5XLJNSWRlsE029dwHfZlthRn3tGsugTURZBH
 1x0MNTL+06iTiHgwBLDIz2PAUCzlWa0wp18fgOvTOtQWlO9T+7+d+MxQLXsJ4oU9uL7mSiL9H9A
 blPK2ewhOpvWbeOWyng==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8dbc78 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=yztkRGOF62FJB5_c-7IA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEzNiBTYWx0ZWRfX/77+Ynl78O6b
 L7UwonHnmJefo7JJt85As74QOq9ENu5AOgVCQbp9+NaxIPbjinQ6TV/aYJ07jKbB1ZX3LBawUA6
 ydX0dR9ciZTwWO5ltqW6RyqXSCCJ+qA=
X-Proofpoint-ORIG-GUID: DuIKC6Y0zyuneJZ_PndoOKRs-ru7bxJA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250136

The zcrypt_type6_crt_key() function leaves padding bytes uninitialized
between key components and the modulus in the CCA CRT key token. These
padding bytes are sent to the crypto card, potentially leaking kernel
memory contents.

The initial memset() only zeros fixed structure fields, not the
flexible array member key_parts[] where the padding resides. While key
components are properly copied from userspace, the calculated pad_len
bytes between them remain uninitialized.

Fix by explicitly zeroing the padding bytes after copying the CRT key
components.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_cca_key.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/crypto/zcrypt_cca_key.h b/drivers/s390/crypto/zcrypt_cca_key.h
index f5907b67db29..8a69eed75040 100644
--- a/drivers/s390/crypto/zcrypt_cca_key.h
+++ b/drivers/s390/crypto/zcrypt_cca_key.h
@@ -219,6 +219,7 @@ static inline int zcrypt_type6_crt_key(struct ica_rsa_modexpo_crt *crt, void *p)
 	    copy_from_user(key->key_parts + 2 * long_len + 2 * short_len,
 			   crt->u_mult_inv, long_len))
 		return -EFAULT;
+	memset(key->key_parts + 3 * long_len + 2 * short_len, 0, pad_len);
 	memset(key->key_parts + 3 * long_len + 2 * short_len + pad_len,
 	       0xff, crt->inputdatalength);
 	pub = (struct cca_public_sec *)(key->key_parts + key_len);
-- 
2.43.0

