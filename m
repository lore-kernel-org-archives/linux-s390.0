Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672C92BD587;
	Tue, 23 Jun 2026 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228820; cv=none; b=VtoRk1YilDfRgbsQMc+JNOloWUYEZh1faLcE8o/GIotza7tJWEKbdQL9v0w+jrlWZkupr8rkBi9tnsSurJqFMx/GtkUhAGSFz0LIjiXJjIBy3ccJrqWx5RYKR470/ewWoPqQSvEv4wBumL23vRPZXXB8SB6EMkSx2yVZVx/j4GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228820; c=relaxed/simple;
	bh=MotyW5vj3zXvDoMxIEdjCCbCRVxwaVElCvaRRg6AbiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gd9XX3WBFv9c4oifUgnxL1q8LeRxh1aUxPg6QHfomlGxZBJkUF+Z4JHjNMDKYYTt4QEinSLhJ6as0cfmLgRTbvSOgvtClyNnIhnwBkgQYsAvU3EZ26GknzJOyBlPWkOLOP/Wu4FMc1vlimgNhTjcgz7u2+gChp1kiWPptMKuqDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qMnCAP2z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qMnCAP2z"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmLHl1983984;
	Tue, 23 Jun 2026 15:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TzaokU+Y+h3u3u2lE
	74js3Fr+ir14XtNtlTgxLuH7gE=; b=qMnCAP2zX+CkGYrZBXirMYD7nx3LnVa/I
	hz2ftTc7KqBh8mE3eJi6+8Zzj9+HbxMR3d2ZfXlj/3Xs0h/LVZECkHlSBfdUq6Np
	i+hW1juNvvHkX4qHA7wa+ReljTDVSZrw32mQ1wBxitoDKzinMNK/PaCrEiZD9LA5
	Q2p/X+OwF0kfB4xPDGMBwy+lUK9QFseK8ebvdtQaGHgahvCfGVPz4tqkjsos34i2
	lWrVXxitNrz8U6SNtOMW0Lkn6R4+JNvjDRBy02xUrHSQcmwxEA5jndX7AEFKC+32
	Aey8MY9zjjFWLhkpmCE0NGz2A1zi/M9MyDNOVFWXvM1SqRhNxQ/wQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3fewe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 15:33:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NF4cZ3012758;
	Tue, 23 Jun 2026 15:33:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jwc4d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 15:33:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NFXW9R47710574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 15:33:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B22F20040;
	Tue, 23 Jun 2026 15:33:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C76C820043;
	Tue, 23 Jun 2026 15:33:31 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 15:33:31 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v6 02/10] KVM: s390: Fix dat_peek_cmma() overflow
Date: Tue, 23 Jun 2026 17:33:23 +0200
Message-ID: <20260623153331.233784-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623153331.233784-1-imbrenda@linux.ibm.com>
References: <20260623153331.233784-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3aa751 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=0SZZOaMt82sS6LYugLYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyNiBTYWx0ZWRfX6piAANn+p8Hf
 0OwpT8SwIT4eUBDeYhkcorVRIod7PuHdmaZ8bYhrU9YNl3KVwm8XOKin+rMkF5H/d6VIc91NL3Q
 NhU1urThTt3Yu3mq2+dtIVfUvjViQuc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyNiBTYWx0ZWRfXyZGtlZL8bXiy
 qbOlU/NWcFe6qVuPxUeE6jFLn/Di+gwa4vg6qj+a5mRJwy2invIElqe0mkognGrq1llf4hhPaot
 gaP9hCLTHggYI/xy6YfdHbey9DaqJKbhE0zf4R+HxEYOb/maM7isyOJHNSmCwdGR9Btk58aEzlM
 F9JIzaWMiUvD63oLUigh7kxWXMctGVjy7HV6mVdQ11fK6kdmSexcjPb1IdlTV3lE9PVEejZ+h+C
 fzTchlLeDwXtEv5PkC6ffpvFqRc2Qo+YIhscn5jaeXhFSopQSPKOZNQey58mgRLuMDdPSCqAd/6
 V+jFZHzopCfFUiOJS0NkjBgYnIBqA2/Rs8ku+m3NaK8YTbPd+rb+jIqb+IVl3qDRwWTUWfwrFhx
 V4cQm0bsjDe092FW0dZvfBFVQeh9NIBONA1tPAFYUb+ebHscY2/Zw3v6IktPbtRcClcRk1EHD76
 BhU+tj+ODxLPi/L+u+w==
X-Proofpoint-ORIG-GUID: vWkvv8e1K4gHn2Qt5r4OGV5NmLGgOY71
X-Proofpoint-GUID: vWkvv8e1K4gHn2Qt5r4OGV5NmLGgOY71
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230126

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

