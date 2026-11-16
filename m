Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849961;
	b=qu+G5hMRVLFD5wQwBDJnH5fCc3hqDRdZqgewO5TRUH1VHtEKonLpSH/Z+0MwInYww686
	 kB5qrW/I2MwVuEw9pA55mP2WeUSSqgmD7Uv8uNhnhWj7KnsdgTD4Sy3YtD7BDDG+spPcw
	 gEmavvh2JeJxQwx0kyjq31LwhypFFKW/Ab/JShaTEvjPzdwH+WI7Wp8WWfKaFHYh5yXAN
	 N/7xpUrbYvC7hInY0Vp8pAKaCxkAOEHuKCrakflyunab18Luc0E0q/uRqMLdE5enL1Tof
	 u5HzkmzF5HpvxUI2cLo95JwXSe5+B4cyYmrlCmQ2MP6U5O/kUJ2VOmcf2MhynVaJu3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849961;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=eIaMQSms0ib/rnyNyDcHc0m8VqXnAfPgurSvPfp7yZE=;
	b=w+bgmu09XZmnSDoh6WRSfNfsjFU4f4psns+r3inuTFUrn5oTDd2ZHPe7HFQKPDz0tJEW
	 0V2WuPwzSTj1rrcL37pDa4/TGXHNhCA0k4eh15+7218hz2yiWWrj7EwiGCp2VJlCXYUwk
	 gcZT2q1VixJa8YD7jSIz0jdV9iqBwW3TDqG1NToXREZGKm3XSYarHfpNJ95qbHBXtWm5f
	 X1BTSKYS1v/xQNRViIp2YQ1Rjof2vZiIJLrs/mMM5BvD38Y7mYsISPubnYfrqlvrjYBON
	 WTsaOQZ7s+1KZF445+lYd6DhlYQVaKl6/FmBlQFbx+LuIfc8mI2PmhZSwPfU0WFh3vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NbKrPwqv;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93040606A31C;
	Mon, 16 Nov 2026 17:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93040606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NbKrPwqv
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGQS3s2143572;
	Mon, 16 Nov 2026 17:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eIaMQSms0ib/rnyNy
	DcHc0m8VqXnAfPgurSvPfp7yZE=; b=NbKrPwqv4gDIp9II6fMHQ+KVH2pw3ko1r
	moyyIjG/1kNkV1es80kyOXWdkgNloov8jVUId5yyUBzWFtkAGNwQGB/nq6Gt5i5w
	rc/ihQ4e7uE21PfN+HquMoVPZbLARut5muSHiRdtPZ6tp37mSU4vfcSw5zgcNw88
	chMwDv2w6juTsUP1L4tAojBXNn5PedjnKEUk6tSRYWhZsvmzafGDGcQ/o6G8gsuA
	u2uHFOxW3XvOcoN4UZngQDSTMovq5/p4o2/vefzdsRrIjqICxH/qB3O+BfV1gIqD
	wvxbvj8BjdHRIIF+HbxF27KVh5ZXoyUcNf4MxvEuhPd1cMYGjqsUA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxfasxqu5-134
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 17:25:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGDGcHA005835;
	Mon, 16 Nov 2026 14:35:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j02ju831y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 14:35:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AGEZdPl52691350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 14:35:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8CE520040;
	Mon, 16 Nov 2026 14:35:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74F622004E;
	Mon, 16 Nov 2026 14:35:39 +0000 (GMT)
Received: from osiris.ibmuc.com (unknown [9.111.42.169])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Nov 2026 14:35:39 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Anastasia Eskova <anastasia.eskova@ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 12/15] s390/cert_store: Validate hash length in check_certificate_valid()
Date: Mon, 16 Nov 2026 15:35:31 +0100
Message-ID: <20261116143534.158375-13-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2NyBTYWx0ZWRfX8TKsECMfFY4e
 OMc7hji4ly+ko53nonehP+c3mrlEBeBaXSqE1F6F8xwA3HjA+5e41FfFoL5XfRzJzAoeewBaA6X
 /VtJHcwNIpOh4Q6erKTbE++JJcuWXhQ=
X-Proofpoint-ORIG-GUID: oZitktc6VZEuA48Ak0RkjBS0VRQSLg5T
X-Proofpoint-GUID: oZitktc6VZEuA48Ak0RkjBS0VRQSLg5T
X-Authority-Analysis: v=2.4 cv=IaESymqa c=1 sm=1 tr=0 ts=6afb3ca6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=V_FGvT7VLOnEk_afoOYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NyBTYWx0ZWRfXwmnWM3oIPNPi
 d7Di6RKtUG36PLVqeNtu/cewnnucbREPBAXs03sj51EdB4WZF6fgXU0swgSQfhRte/jy7UoaoGW
 RLUvLpOfbuUR1LXVo5kH61enVbUSnjJztb66n+pRBfST65oWMmSswvGPHpWVF4Ee4VVxIbAQNRS
 j/FycMfPVLJI/vYtSptk+5hQ2qVRmvyjHWvCiaRIrOB9lmKg4xuE2iL5sUgNkVSjzKYBA0bfTPn
 +WZnKlKHXjXKkCNkShEfj6jSYAZAh+e0WrEHoxy8HwildKlXPUKZzpdvVTASlZEoZpaPSBq4/9+
 32kasUfh93YSA+sm+JSsllRg1hmyHCM3HUi+Qn0mS5sqvOHjocZrhy0rx/5VQk2dkbgt0prrxEG
 6q0dnu4reWfVSXqKcZ7pSQrEo2kr1P5aTJTR+7tp2E9nAMM2r3+Uecg/H0tKTMFQyrOit5cogQh
 KDsiV83YrIHcRZV9oEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160067

Validate that vc_hash_length is SHA256_DIGEST_SIZE before checking the
hash and use sizeof(hash) in memcmp(). This avoids an out-of-bounds
read if vc_hash_length is incorrect.

Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/cert_store.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
index 551b538ea930..ecfb7641d427 100644
--- a/arch/s390/kernel/cert_store.c
+++ b/arch/s390/kernel/cert_store.c
@@ -261,13 +261,11 @@ static int diag320(unsigned long subcode, void *addr)
 static int check_certificate_hash(const struct vce *vce)
 {
 	u8 hash[SHA256_DIGEST_SIZE];
-	u16 vc_hash_length;
 	u8 *vce_hash;
 
 	vce_hash = (u8 *)vce + vce->vce_hdr.vc_hash_offset;
-	vc_hash_length = vce->vce_hdr.vc_hash_length;
 	sha256((u8 *)vce + vce->vce_hdr.vc_offset, vce->vce_hdr.vc_length, hash);
-	if (memcmp(vce_hash, hash, vc_hash_length) == 0)
+	if (memcmp(vce_hash, hash, sizeof(hash)) == 0)
 		return 0;
 
 	pr_dbf_msg("SHA256 hash of received certificate does not match");
@@ -293,6 +291,10 @@ static int check_certificate_valid(const struct vce *vce)
 		pr_dbf_msg("Hash type is not supported");
 		return -EINVAL;
 	}
+	if (vce->vce_hdr.vc_hash_length != SHA256_DIGEST_SIZE) {
+		pr_dbf_msg("Hash length is not supported");
+		return -EINVAL;
+	}
 
 	return check_certificate_hash(vce);
 }
-- 
2.56.1

