Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310254;
	b=3/bP/dpDReOhw7kgT54M5lzAI+LVxBo5TSkQD8+DNM4ieH5B6jy65jq1IXJSYrx0YCZX
	 aW6nVmODOjVuJb1rjZxfWH6iMdVtuInCJQ7vkPplGYDaG4I6jFxZ/CI8rBvzMMFzpz14h
	 YMf++oJ0pzVP9qWwWDbonL4wy7ay9NG77g6lz05mMjHwMmo62dCAvNpyGMfk6/LEnWrVX
	 e06B2dHXKJmxQeg0c92cfOHU38gsjKIqOslA7P1/b22qiBZacFDXt1XnqShB0ZVoiS1r0
	 1i9S6Cv54QxYURbSAoe+KaxGLM9KBnplP5Rjsqmsnuodh8O4cgNj56tqoLFwIIi9K5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310254;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=YLLKQ0qDfE0cXQHdHfYqGvFGLhG9S+oZrcRmGh9u4o4=;
	b=j4Hx1rhhQujmBwOVkFFZil8aUaXutRV/KMKSwFk6/32vTLXqdCmJobl8m8BZu7SpcRHS
	 vXumw/32S8MuweOtsCSmOr52NDxVGzCioJKuMiKWo2ox0UMBuKNhmVEvS5kvJk8pZpjE8
	 DMwxu5Q/qfPcBfadRCqCVK3kdOqlOZfJXG25LP5E6UJ68FoMWALlHDOCw/7oEMvegqMrK
	 hk9Mw3Bc8BZwbURItskG7GvIn33/zxEDB6QFaBkP5OzP0PJWrafHB6+Ru8hVgl6TpuuIm
	 qG9gLWC7WbGMjNoLWX7812BhkqKjfywCWrYKHWSVV7+dziq2sM66DWimJZ7mNtmb5IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=R27burOV;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F11606A332
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4F11606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=R27burOV
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABEhW3962950
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YLLKQ0qDfE0cXQHdH
	fYqGvFGLhG9S+oZrcRmGh9u4o4=; b=R27burOV/Zvfpa+WwHlFo17aOA97qjXt7
	3PXSSaeVKcX6EOjP5A/yB5mIVMXACmVyYduQbj3FarHgHxPwbeWxVcXxQEE2lA/9
	iNTYjRuCfcszPjBDgNJjFNxdDBMgJ5+POk6jBkNmXnYQBY1VXEmpTpPdVL/gxZ7h
	NwGga1SuAmsc6WSo7Lg/d7j9lCECp03x9b3oanB0on8Ou0K0JwsjMbSjeWcUf69o
	vXez/fwcXjF3zwLCSQTWKef9ekZzosepylBGvHlo/bybG3Inj8BjdlFKOdWlNHZ9
	/sts5jKD6HyAssYBTzqEzbJTGZhvpdCKh5E6jZU41yP95Jh1/8G+w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdg45ff-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABK0w3561578
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4htghg62q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AABUmOW37880130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 11:30:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 604F52004B;
	Tue, 10 Nov 2026 11:30:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CCBC20049;
	Tue, 10 Nov 2026 11:30:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 11:30:48 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: oberpar@linux.ibm.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH v8 4/5] s390/sclp_ocf: Fix computation of length of GDS values
Date: Tue, 10 Nov 2026 12:30:46 +0100
Message-ID: <20261110113047.238367-5-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110113047.238367-1-egorenar@linux.ibm.com>
References: <20261110113047.238367-1-egorenar@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af3006c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=3p12VsNbHHCjkpGzt3EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0NCBTYWx0ZWRfX5GkR2BfGGMQC
 r8aJMQgGB6/aBtT5Agod+7btXkIOEy5GDJb6f4OnHURroL8Uls5vvsGM+mzxkVRSKcgVlgXyenV
 RudKZHWVhOysPNcTxIZtkkuTXnJRz1IqeIVD1DcxHko1r6Cepocp3w+QjanVxmpZb/JKMO7j8Rh
 BLnj3zYNvCjZLtl4iyhJ4r0LTw+3X/zIMBqbeBv1859fcqgTPkD7jTj/del/oGHriPbJ9t5I4jq
 /Z2oOWJpMnXa+Pav8ReacajB35kswqm1iEmPYEYxcMpd0wr5zs3jLvDniSM7SDZm+MBrJ0VJEdd
 b2NTFfzc/Hjh1knI0nrOQSxGdb2xMahBOjDhteUFV8SaIzq7fFd+rgU8JCmuyYkhWPS0MD4xId0
 2P82BSUw8qKKNzClISr/MzIfTDNf9ufdA+5EEUPl/ev/1ta853VeI861VzvBJA8T3cUlFInEG9V
 k6fTTVxfcSyE55vGe/w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0NCBTYWx0ZWRfX6/9uzWIeYDmC
 MOyXI6eDoetFIzMAJsUDwUUjhkj3RRIMxpniTVAcN95nm+NBpsVk7qQ2dbdPGsfpXQ+CAEIJlN0
 DX0KIx3ir0UV64z4qElKtim+wBYSco4=
X-Proofpoint-GUID: CniADBDJPHQJ6SbYkoLLzSqGqT7kQR8h
X-Proofpoint-ORIG-GUID: CniADBDJPHQJ6SbYkoLLzSqGqT7kQR8h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100044

Fix length calculation for HMC-network and CPC names in OCF event data
by excluding the GDS subvector header size. This prevents a potential
invalid read access beyond the available GDS name data.

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Fixes: 7eb9d5bec552 ("[S390] get CPC image name")
---
 drivers/s390/char/sclp_ocf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_ocf.c b/drivers/s390/char/sclp_ocf.c
index 35f3a4a08b12..cee4bfa4a48a 100644
--- a/drivers/s390/char/sclp_ocf.c
+++ b/drivers/s390/char/sclp_ocf.c
@@ -66,13 +66,13 @@ static void sclp_ocf_handler(struct evbuf_header *evbuf)
 	/* Copy network name and cpc name. */
 	spin_lock(&sclp_ocf_lock);
 	if (netid) {
-		size = min(OCF_LENGTH_HMC_NETWORK, (size_t) netid->length);
+		size = min(OCF_LENGTH_HMC_NETWORK, (size_t) netid->length - sizeof(*netid));
 		memcpy(hmc_network, netid + 1, size);
 		EBCASC(hmc_network, size);
 		hmc_network[size] = 0;
 	}
 	if (cpc) {
-		size = min(OCF_LENGTH_CPC_NAME, (size_t) cpc->length);
+		size = min(OCF_LENGTH_CPC_NAME, (size_t) cpc->length - sizeof(*cpc));
 		memset(cpc_name, 0, OCF_LENGTH_CPC_NAME);
 		memcpy(cpc_name, cpc + 1, size);
 	}
-- 
2.53.0

