Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795773110;
	b=uZ7RZ6OpvYEXXJivmtFyKBc7u5K12XIcWQ4sD3KwmjmQKqTykYuJzgy1Ge3juqyDWmaS
	 GKU8g4FWr7ogRNS/5lnqZH0H4nayiDhC0g5PAF6T1Uux0k0S57rzgtrDdepKl1OGsr7jQ
	 Vit0Lnsnt1By//6qrbno0DSCF6mfLkec7AHKOGIWfLEZeQ8hHccON81JZxgvO2daCUs6p
	 O6AHvtKo9qsilJuaci8qRcvTkpb9AgKUHLvnzs1b4J9HGmiJQXNv3hSiElJXHp0kYVa/d
	 +SsLeM3R7FJBqR+5FIftmd1WlEitXkOzskUCfD5jufwx0+i4MSMkbDTdTrFhj3OPeUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795773110;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NzweNjpRZGnTZ0R4HXeifJcRXkrYK3SG/ovnEkbKnAo=;
	b=BnNr6PS34NGiD/B0I9MB1oQ72OUorNXiywnB3WYEL9KWuzPs4NA8GqaKSsZZPrKJBC7G
	 2rRdB8tKlCnxE+DusOS8jJc227ejcO8utQd9ZeT89SVrEKdTRGOCh3N8VBFjO7QQb1mHC
	 yvxkfcBhlpz+sbel5UaG2lZV0dUSOYG2YLmzhJ3W1ELoGtUdSpVngKTcyMkv+sHA/cYAp
	 1f6gObZxlB6/J0UyM4jG2zsk8dYTDSeu4IwFu6vbDDjViNsmIpmOpfLNBv5/FWH264R0y
	 WV23ag9gjb+j95zN7/Hrhi500gosA2q/BOgYmCCtO4jkZfdd63D3hXMoOfVNwMKrzJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Z+Rtr7vv;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198BA606A31E;
	Fri, 27 Nov 2026 09:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 198BA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Z+Rtr7vv
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7YesV2458177;
	Fri, 27 Nov 2026 09:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=NzweNjpRZGnTZ0R4HXeifJcRXkrYK3SG/ovnEkbKnAo=; b=Z+Rtr7vv
	kE09QzWyL1mhoBsPhajif6gCuQ9dHo2QADMQ07wj1klHrKD4espBGx5//bC1U3S2
	1yEFV6ehXiQ/zI6PApSBhK7yzeKzs2cH0nRK/OJIxBbVxScrTp0bMQ1pL9XsGILy
	PDQn2j0sHTMYVsrAv4lc4BiDSLGGplelB0ArlxiyGJ44Ag0XV9ZfsHAmg7mdlXD8
	w6r5astYRLk2fl3YJP1T2QsJq9DxssKetvoIs+3P3DmV9yu5mWtz+8nq3RAZRCxu
	OL/IfafJdiDqTWC5kr+WAVxf/lYTTCtw2/M96XCcsHxqaQZ3ULkyedQ3Dp0IELNk
	5QNwyE9G7F0ytw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gvmh9k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 09:51:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7JMdR2811038;
	Fri, 27 Nov 2026 09:51:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5uxx8awq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 09:51:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AR9pdDr42926362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 09:51:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 207AD2004B;
	Fri, 27 Nov 2026 09:51:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F405D20049;
	Fri, 27 Nov 2026 09:51:38 +0000 (GMT)
Received: from tuxmaker (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 27 Nov 2026 09:51:38 +0000 (GMT)
Date: Fri, 27 Nov 2026 10:51:36 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 fixes for 7.4-rc5
Message-ID: <20261127095136.2292357A6b-agordeev@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b0952af cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=lpGbSgCZW7Kyy4ZyuYwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzOCBTYWx0ZWRfX5BwRfrtzqRXQ
 4xrkQVCB8foqLey/SvV/K2OUqS6BeqC5ptzIsYcNyPiDnlibpq0OlWIbr+XgCjHNAI3FcGc8ukC
 iIfKPYbH230QwTGDDykJWAoCsz+zzIo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzOCBTYWx0ZWRfX73KGZO2uL0rT
 oeN5FXEbg47Q++PtMOnGDOMxnkbfEWjOvaJj8igTMBAkdvcd/tIGADRX6M4PIqPiJS6qTPPFuTc
 ghddiuHQjCilrlxPOWDNf6mJsDeteuoxQN6f0hzbMBiN45xFvAU4pyUlZtO3pSshgIAoMvCElSV
 kwZb6uAySHUrTllch9k1PnINauPQwiEMBwBfS1ys+9DWYou6y3Fx2fM77U7wYYxH/Jk6Kxia3/n
 prkUuGVCAlFjy3Taib8uXRF7FJlJ38QJ0e9g6wRHTBWd3xstc9uvY3V/Y5qA2fAI9XisVuil/Ym
 8sx4fNzgZBhmWtJeonDFjVLP+S0LEFfadLaAneMJEuQVG3GfiFrpdjFg1ULwyJkek7HzV4m/nZy
 1Oxwr8tDejwLu5ZA9qI692QrIU4yRJmW0P7Yzma8dwDHvxCoj+VMOHvvmA0BI6Xc7V9WT1jO8HL
 Fquq41prcWsqS8wKedA==
X-Proofpoint-ORIG-GUID: ACK3LkuYB7PVTIURBEgxlM64cMlVEjbc
X-Proofpoint-GUID: ACK3LkuYB7PVTIURBEgxlM64cMlVEjbc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270038

Hi Linus,

please pull s390 fixes for 7.4-rc5.

Thanks,
Alexander Gordeev

The following changes since commit 64ee7f863655e67f26947420516daba4e232675d:

  s390/dcssblk: Initialize device semaphore before sysfs registration (2026-11-05 17:54:25 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-7.4-3

for you to fetch changes up to 23a04cb4f2bdbfc87fc4e1c15450e7f8cfc9842a:

  s390/cert_store: Only allow the kernel to create cert_store_key keys (2026-11-23 15:15:58 +0100)

----------------------------------------------------------------
s390 fixes for 7.4-rc5

- Fix in the cert_store code keyring locking, lifetime handling,
  missing error and return code checks, several reference leaks
  and potential use-after-free issues caused by unbalanced keyring
  reference counting

- Look up the cert_store keyring only in the user session keyring.
  As result a foreign keyring named "cert_store", which a task may
  have inherited, is no longer destroyed during refresh

- Fix out-of-bounds reads in hash validation and in Verification
  Certificate Entry (VCE) debug output, avoid copying uninitialized
  DIAG 320 data to the debug area, and print the correct value of
  max_vcxe_length

- Allocate the cert_store keyring with a link restriction, so that
  arbitrary keys cannot be linked into it

- Allow only the kernel to create keys of type cert_store_key. This
  prevents users from creating such keys with short descriptions,
  which could disclose kernel heap memory via /proc/keys

----------------------------------------------------------------
Anastasia Eskova (2):
      s390/cert_store: Allocate keyring with link restriction
      s390/cert_store: Only allow the kernel to create cert_store_key keys

Heiko Carstens (14):
      s390/cert_store: Fix return code handling in invalidate_keyring_keys()
      s390/cert_store: Fix potential use-after-free in invalidate_keyring_keys()
      s390/cert_store: Check key_lookup() return code in invalidate_keyring_keys()
      s390/cert_store: Unlink before invalidate in invalidate_keyring_keys()
      s390/cert_store: Fix cs_keyring reference leak in fill_cs_keyring()
      s390/cert_store: Fix potential use-after-free caused by find_cs_keyring()
      s390/cert_store: Remove unnecessary static specifier in create_cs_keyring()
      s390/cert_store: Fix error handling of get_user_session_keyring()
      s390/cert_store: Fix keyring refcount handling in get_user_session_keyring()
      s390/cert_store: Do not search the process keyrings for the cert_store keyring
      s390/cert_store: Validate hash length in check_certificate_valid()
      s390/cert_store: Fix max_vcxe_length output in pr_dbf_vcssb()
      s390/cert_store: Fix out-of-bounds read in pr_dbf_vce()
      s390/cert_store: Initialize ism array in query_diag320_subcodes()

Jarkko Sakkinen (1):
      s390/cert_store: Hold keyring->sem while reading the keyring

 arch/s390/kernel/cert_store.c | 139 ++++++++++++++++++++++++++----------------
 1 file changed, 87 insertions(+), 52 deletions(-)
