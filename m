Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429431;
	b=x1tRxbSH4bSh5D/pz4ZRrgaa+xJ+7LQXuPgEoDXTMWIlx5kMiR+emD1BVrjsYCOkvn63
	 7vEBwm4Lp1ug0boZYb4lhdkrPufwebdwNT9HORO+vTsJhIe8GRO3+E57za4EQoIRuekoK
	 Qg+XnrOcDHxraJg4hnLW4cl0T8TnaBUOn1ur7jTpqRRedByXcOO4nc+ZBbGMw25mlDcAp
	 3xdIa7K0IVfj13aqHJYoyIBvatyjKnFB7vOVU3QMxVtwC6Jn2y/uveNswxAlPdXefWK7p
	 9nFlUYy314DpnCnuOAjR4MkdhA5VOm2wKo+y3SLvwGbk1vER9Be7TlVGcf6fTbtyvMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429431;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=JAL2U0t4V71fb/VZoafl1Gy05ja1d/91+p5wuYGVZpA=;
	b=T0tyN2bXWsGMBQjsNb1J6M69raGRl/53dynVC7KfczGQni20CkuHbZqS9y3+nSr49u7O
	 HHVt+4m/3KmJQAMoKbD592mODaak/5bUCT+DLgbVAUe/m2NKhW7R07iinBKRxitvlanTC
	 9SzgEATg12nfAwaN36c36ajuxqpOXzNDcPadgvJ3hu7Pa0UKI8gMVlsvChG+d6Sh+eAEM
	 WbyAdc/tmO1LKJkHlqmSZ6Q2iGbAIMMFT+CfAD4Z3ayLc1HzISQKs505DrdH47hBbwtc9
	 84L7c3Y4ab6rmejCtlRflDPnEPbi/f6QvNpmh5f/u7VOmAozx8/APLu7d/QtqTm0jnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lBmgQub9;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E648606A31F;
	Mon, 23 Nov 2026 10:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E648606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lBmgQub9
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9Z2DS1984587;
	Mon, 23 Nov 2026 10:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JAL2U0t4V71fb/VZo
	afl1Gy05ja1d/91+p5wuYGVZpA=; b=lBmgQub9G3mc9Xax8+03iRhJtgCf2AHDW
	lc1ThMeWug2j0ZHe20Euiw3gHi+kuLg3w5rEbCOBqNW/SZpGFo00CcajCL7YKyAj
	0B82Jv5lDr5gxMWkWm5JSp5jPcE4rzaXa367Wi2zdEsNmEV31LTGl6wD7kIVaI+f
	V+4VKZbU61HOE2zAgKfrNo8OWcOXVn7A0gm1Cus5mjuAXkGG6sLyXPq/Wn0yQJgs
	8bw6cuNAmnfEr6P5bzZ4DWAlMv9VXqGWg5APbP3791eYgr6wY3lf4VxENjQ0Baq4
	5iydx1pt0NgHJ5FgJ5yyPc6x7DifIy2NC+KfPowgg1tw2nuVAMECQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4a6k2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 10:23:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9JNVO956280;
	Mon, 23 Nov 2026 10:23:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3p0vee7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 10:23:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ANANOFJ52166978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 10:23:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C37D12005A;
	Mon, 23 Nov 2026 10:23:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1C4020049;
	Mon, 23 Nov 2026 10:23:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 10:23:24 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Anastasia Eskova <anastasia.eskova@ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 2/2] s390/cert_store: Only allow the kernel to create cert_store_key keys
Date: Mon, 23 Nov 2026 11:23:24 +0100
Message-ID: <20261123102324.483917-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123102324.483917-1-hca@linux.ibm.com>
References: <20261123102324.483917-1-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0MCBTYWx0ZWRfX4xJKiYd98E8q
 flyqdFSPVe63+LUbNEIXLLZH98VoLyEneZ4EXLFDNLKMpScJO1FW3WbuR6+TdwS+c848Oy8BcoH
 fbSijIK3cQc0pnvA61nLl7M2t0IU1nM=
X-Proofpoint-GUID: DYIUhjNbMGpIW0KQ1kEFcWQKu7ppehiy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0MCBTYWx0ZWRfXwHemBO0ywDyQ
 7mn8/d64ieNI85vrIzC7Xltvyw+qGH7cfIESXAgDvntlNLK4X+T0H8H7IYOp1d7kjFs8Ae8wjQ7
 iTrIk/rRf2TtfSyytc2JZ8imwQsdtRA6JdWBaqitdiyGGt3KyajA7FWcRrfBuiQ7Bj6VNbvoU9T
 qrg3d/B3jZYOBixHUf0sETsz1X0mZ1pWQZT5NL76jL7n7PeJCzxOsHXSbLt4mlpP1BZPy+GbolN
 DVBNb12cvr+x4onTKknWc+ZJTXSCirUWsMTBkEvmdFJ4tyAi+8mFpieWr4ZHN1yVs09KMfqbjSf
 IpI/Si2THDDvnqrYiQ5a6HShKUyF0c3S0YsUmRFDqYtP6kkgZn4QCmmCHSrOB6b6FDvCGhj6hrb
 gwxRjjgOsfKlDHBLi02J+LcalioQN5HibhfJB/FPbXEjQhe63TBcJ0sauib85PC6kuo6gZWp9wv
 P6Tfz9FZoo4vXPZ2Gfw==
X-Proofpoint-ORIG-GUID: DYIUhjNbMGpIW0KQ1kEFcWQKu7ppehiy
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b041424 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=3TLB47XasoVzS6DKMv0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230040

From: Anastasia Eskova <anastasia.eskova@ibm.com>

Keys of type cert_store_key can be created by any user with add_key() in
any keyring, as the key type has no vet_description() callback. The type
is registered whenever CONFIG_CERT_STORE is enabled, even if the machine
has no DIAG 320 support.

cert_store_key_describe() expects a description in the format created by
get_key_description(), i.e. a 64 byte key name followed by the VCE index
and the certificate store token. If a key with a shorter description is
created, seq_puts() may read beyond the end of the description
allocation. Reading /proc/keys may then disclose adjacent kernel heap
memory to the user space. Also, a consumer which trusts keys by type can
be fooled by keys that were not created from the certificate store.

Add a vet_description() callback which only accepts the task currently
executing refresh_store(), which creates all valid keys of this type.

Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
Signed-off-by: Anastasia Eskova <anastasia.eskova@ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/cert_store.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/s390/kernel/cert_store.c b/arch/s390/kernel/cert_store.c
index 6f5c63cd907f..6e518ff38322 100644
--- a/arch/s390/kernel/cert_store.c
+++ b/arch/s390/kernel/cert_store.c
@@ -46,6 +46,9 @@
 static debug_info_t *cert_store_dbf;
 static debug_info_t *cert_store_hexdump;
 
+/* Task currently running refresh_store(). Written under cs_refresh_lock. */
+static struct task_struct *cs_refresh_task;
+
 #define pr_dbf_msg(fmt, ...) \
 	debug_sprintf_event(cert_store_dbf, 3, fmt "\n", ## __VA_ARGS__)
 
@@ -148,12 +151,24 @@ static void cert_store_key_describe(const struct key *key, struct seq_file *m)
 		seq_printf(m, ": %u", key->datalen);
 }
 
+/*
+ * Only the kernel may create keys of this type. Accept the task which runs
+ * refresh_store(), as it cannot execute userspace during the refresh.
+ */
+static int cert_store_key_vet_description(const char *description)
+{
+	if (READ_ONCE(cs_refresh_task) != current)
+		return -EPERM;
+	return 0;
+}
+
 /*
  * Certificate store key type takes over properties of
  * user key but cannot be updated.
  */
 static struct key_type key_type_cert_store_key = {
 	.name		= CERT_STORE_KEY_TYPE_NAME,
+	.vet_description = cert_store_key_vet_description,
 	.preparse	= user_preparse,
 	.free_preparse	= user_free_preparse,
 	.instantiate	= generic_key_instantiate,
@@ -768,6 +783,7 @@ static ssize_t refresh_store(struct kobject *kobj, struct kobj_attribute *attr,
 	if (rc)
 		return rc;
 
+	WRITE_ONCE(cs_refresh_task, current);
 	for (retries = 0; retries < DIAG_MAX_RETRIES; retries++) {
 		/* Request certificates from certificate store. */
 		rc = fill_cs_keyring();
@@ -776,6 +792,7 @@ static ssize_t refresh_store(struct kobject *kobj, struct kobj_attribute *attr,
 		if (rc != -EAGAIN)
 			break;
 	}
+	WRITE_ONCE(cs_refresh_task, NULL);
 	cs_status_val = rc;
 	mutex_unlock(&cs_refresh_lock);
 
-- 
2.53.0

