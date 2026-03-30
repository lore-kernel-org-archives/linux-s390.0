Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD1C3C8708;
	Mon, 30 Mar 2026 11:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774871091; cv=none; b=GKWWXVHG5OrWaZwDnpk3yC0h5deRQShucOyNbz2Q77p5zsBpjo6EDF2F9KXP0bV5ipN7OCFTvRCWwkQFv6EBvhzAz9CJ/D/K6UC42dYKa/DPS8C/bhL10X5OuSrRzEsRlCnUClO261TWzAyLz36pu8Io+VJvyo4FsM0n5Mue5BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774871091; c=relaxed/simple;
	bh=+vNFMjBw+BlWXkXKp5/4ZPOOzvowJH1kwHTM8x5kX+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KMZ8Hdz1n094v/kwCSXESOAKJkrCFr22REzA+YQ6R0z49z0GCTOMsFDwMXHVhsJhJiKPYlrMXWwALIb+tQucaWjvXuiSfV8tVCXnWglsPFb8dPw0jhkmOWlJojdKKTXzWRcxbUg4QvluPD8o2ITKYGkQGP2H28reuOhxFnFFyCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YYmjw9F/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YYmjw9F/"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62TFkTaS3661208;
	Mon, 30 Mar 2026 11:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=wCNCpVtkWBSkchpYjTadWOMtt6ARsf5cI42FipovX
	pQ=; b=YYmjw9F/vGbgXci4qOucFSAZbrSp2UiOiMKh4As7EjqIGlByhQyCsvIfu
	4E/9GdEAJ9RaHyjMy+UKFxivtDheS4ZyD0u30diZt1cLXXdCAftOZFrmw/ISGYpx
	EsUuN4QKQfnhKA/BkL9WtY1+jrXMYzckJnyLDc6tnHwOdu03VkFp/PLc1DPFoo3F
	bnjwVeJ/hJOwsjOvNTO0MnlEWAx0aMUWIcRZ9E+gKaWZeIEmimQVnmrOKlz0Zh+g
	edbzijNoERBWXKhy4jEmJVFgvz0oPb3a9gYe5WUDCLSWu/rao4eHTaR2uOKKmbDd
	euEoiyueWeRuNqc6PQaCqPN3ps3dA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgeepy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 11:44:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62U9UFoO005977;
	Mon, 30 Mar 2026 11:44:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spxvryx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 11:44:40 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62UBia4I17105218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 11:44:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF35920043;
	Mon, 30 Mar 2026 11:44:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E16920040;
	Mon, 30 Mar 2026 11:44:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 30 Mar 2026 11:44:36 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 6CA64E083A; Mon, 30 Mar 2026 13:44:36 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Aswin Karuvally <aswin@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>,
        Nagamani PV <nagamani@linux.ibm.com>
Subject: [PATCH net-next] net/iucv: Add missing kernel-doc return value descriptions
Date: Mon, 30 Mar 2026 13:44:36 +0200
Message-ID: <20260330114436.2010108-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4OSBTYWx0ZWRfX9/yYC1bEQD1t
 QzCCLfRIay3Uy47HFNRdwcXjyU1eNl+IkizLV9f7Dd0ccDEDSfPmJlwW6SuGFLib68H2bv0pYF3
 V4xmEFtY23zSEOA3I3RFgzYSATdRAA0XwFetuWso6YARzTT/Kz3G52uRinjdIYELg6ydlDZqIQU
 tIxTcOQ9PR2dGydsXWS2qtLh6M8PA2dr8qM+lR9f7CMiW9w2W+o8SELpcmvRJgu8g+2OHEwWtsN
 D0W+pRI2CUxRpfpU7+hpgpOL92JhAQAo3YPg/+cqRaU3aYeNOYd3IZDIKZYfBet+hF3NUeyLOwf
 hbfaVvi/9JeBXTnoFm0PwfMCeiYvxS4tiXVcg9gCElP5zvoa3RK3pAzgZGN17MvlNpiGLks/omv
 hc8w73eQ4EHnL6+WIQkxcaDEosOl0CKl+WU+8SabRzIyI2dF1g7vuy1VgnwXcTNSBgDAA6/R6wG
 dqRMzbUTBKClscfDnHg==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69ca6229 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=hiOhG4pdgJk7uAqAlJ4A:9
X-Proofpoint-GUID: zAH9kKw55int6JhHooHDSWnU2COFV92V
X-Proofpoint-ORIG-GUID: I-z35pEHXLzFInofZempiY0Wn7N1vbMz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300089

From: Nagamani PV <nagamani@linux.ibm.com>

Add missing return value descriptions for several functions in
net/iucv/af_iucv.c and net/iucv/iucv.c to address kernel-doc warnings.

Warnings detected with:
scripts/kernel-doc -none -Wall net/iucv/*
Warning: net/iucv/af_iucv.c:131 No description found for return value of =
'iucv_msg_length'
Warning: net/iucv/af_iucv.c:150 No description found for return value of =
'iucv_sock_in_state'
...

No functional change.

Reviewed-by: Aswin Karuvally <aswin@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Nagamani PV <nagamani@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 net/iucv/af_iucv.c | 12 +++++++-----
 net/iucv/iucv.c    |  6 ++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 6554d2cffc19..72dfccd4e3d5 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -127,6 +127,8 @@ static inline void low_nmcpy(unsigned char *dst, char=
 *src)
  * if the socket data len is > 7, the function returns 8.
  *
  * Use this function to allocate socket buffers to store iucv message da=
ta.
+ *
+ * Returns: Length of the IUCV message.
  */
 static inline size_t iucv_msg_length(struct iucv_message *msg)
 {
@@ -145,7 +147,7 @@ static inline size_t iucv_msg_length(struct iucv_mess=
age *msg)
  * @state:	first iucv sk state
  * @state2:	second iucv sk state
  *
- * Returns true if the socket in either in the first or second state.
+ * Returns: true if the socket is either in the first or second state.
  */
 static int iucv_sock_in_state(struct sock *sk, int state, int state2)
 {
@@ -156,9 +158,9 @@ static int iucv_sock_in_state(struct sock *sk, int st=
ate, int state2)
  * iucv_below_msglim() - function to check if messages can be sent
  * @sk:		sock structure
  *
- * Returns true if the send queue length is lower than the message limit=
.
- * Always returns true if the socket is not connected (no iucv path for
- * checking the message limit).
+ * Returns: true, if either the socket is not connected (no iucv path fo=
r
+ * checking the message limit) or if the send queue length is lower
+ * than the message limit.
  */
 static inline int iucv_below_msglim(struct sock *sk)
 {
@@ -883,7 +885,7 @@ static int iucv_sock_getname(struct socket *sock, str=
uct sockaddr *addr,
  * list and the socket data len at index 7 (last byte).
  * See also iucv_msg_length().
  *
- * Returns the error code from the iucv_message_send() call.
+ * Returns: the return code from the iucv_message_send() call.
  */
 static int iucv_send_iprm(struct iucv_path *path, struct iucv_message *m=
sg,
 			  struct sk_buff *skb)
diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index 6641c49b09ac..e03bc4a74f67 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -687,6 +687,8 @@ static int iucv_cpu_down_prep(unsigned int cpu)
  *
  * @pathid: path identification number.
  * @userdata: 16-bytes of user data.
+ *
+ * Returns: 0 on success, the result of the CP b2f0 IUCV call.
  */
 static int iucv_sever_pathid(u16 pathid, u8 *userdata)
 {
@@ -1092,6 +1094,8 @@ EXPORT_SYMBOL(iucv_message_purge);
  *
  * Internal function used by iucv_message_receive and __iucv_message_rec=
eive
  * to receive RMDATA data stored in struct iucv_message.
+ *
+ * Returns: 0
  */
 static int iucv_message_receive_iprmdata(struct iucv_path *path,
 					 struct iucv_message *msg,
@@ -1852,6 +1856,8 @@ static enum cpuhp_state iucv_online;
=20
 /**
  * iucv_init - Allocates and initializes various data structures.
+ *
+ * Returns: 0 on success, return code on failure.
  */
 static int __init iucv_init(void)
 {
--=20
2.51.0

