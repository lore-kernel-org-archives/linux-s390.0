Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD9A2F8E85;
	Fri, 21 Aug 2026 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787316919; cv=none; b=c7WqViKdBtoU1U2DjcI5J/mwR3IjB43wSlJ1Je73P2thux4jxwLPT+x5qa0fD/EyIty3VYlRxKhl1/pz+plIHD88zTxP8Y+V/jwNUeUnuctNfiSfA6Wl0eR5mn7NNYUkCbCeNcgYrOHtzG/Rs7kQePtF7YImDg5E6lyvSRXmRbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787316919; c=relaxed/simple;
	bh=s9wTT/4lNifGl9E4TI/nvgm+jvsQwa1y0ghbn9UC5eE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YY/SHqM5PzWnLItDPcuitsFd+3JPb9zabMaIGfP09AZN3v2n1ptnqk1wluk/cUSWqix3NKjEilyeALIkmmefR81666fN6Lyzb1RFfkFzrNyzZDbGLKqHf/dww0k/3ZMqP/BDlZXbgzywsVwMNbte8AkluvU+aBFEMUO3nOPWtXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XCAqtlvV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XCAqtlvV"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LC1Y131391506;
	Fri, 21 Aug 2026 12:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=8ZYQmLaslDy51WJETmPI5hkKfhql9GlfRjpJ+/+VE
	LY=; b=XCAqtlvVywQ9nlesTyEjumV1wfkKGVV8pacWLtqgSZzc+x1oQlnjo3YrN
	KMCFUufH9qj6HretOgstanRA+VL9iFqPJDXNUlTkl1HC5dS92jVP2B2trnaH3kLP
	uXUzaPN7ruf9+/fX5TogXidfK3maVcAX77RqCiXWdCrvRRidxg7mYkBs6A9xCwbx
	NQVW17z+Zsaf7zLQ8DlKl3kKj4B9/416YSveUuwP4vZ48vl0JS/SGy28RZTp4iQn
	PwoZ/XbjRiOWPjPlE61k9JbyOSmqrrkaHgR8ChukF9fx8wj49Wd7xkCt8PLqq4qC
	qRmUE+baVaBmfI2vV3P3FdDVBNuvQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu1sf6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 12:55:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LCkwMa027060;
	Fri, 21 Aug 2026 12:55:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhmpw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 12:55:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LCt1X229032740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 12:55:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6706120043;
	Fri, 21 Aug 2026 12:55:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F2A02004D;
	Fri, 21 Aug 2026 12:55:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri, 21 Aug 2026 12:55:01 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 1A8521618E7; Fri, 21 Aug 2026 14:55:01 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: Bryam Vargas <hexlabsecurity@proton.me>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Hidayath Khan <hidayath@linux.ibm.com>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>,
        stable@vger.kernel.org
Subject: [PATCH net] net/iucv: filter frames in afiucv_hs_rcv() by ingress device
Date: Fri, 21 Aug 2026 14:55:01 +0200
Message-ID: <20260821125501.3718748-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=LsCiDHdc c=1 sm=1 tr=0 ts=6a884aab cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=V0ECBEa9ytxByMJEgYQA:9
X-Proofpoint-GUID: j3Am_HH4ZpSvOLxCmNTwgXRBWF4qS-Tf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5NiBTYWx0ZWRfXwAy+YYoq/gjN
 nQHh2gF60kik9liLO8tafRYHN/3UrPI9CJWLzfdUhQRzr8GnMxrWvrSFXQ8+DlJYlT3pKhH+Bc6
 dhZuy5x1xFfmPb4DdmXrQkmHv6OgBRw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5NiBTYWx0ZWRfXzaFeNnlEmbQY
 lt31O6L4bBCrK05b2gS53IlTaZR7GWz7yriwZ6WGQh4/2Z7FFUSFX6CmELiwiR5FyNatLf6g17B
 2D2N0He6IJy1e4vMcI0VcT7uZ2wsHzLZrXzn6VwgKXagYrKteg3bTLFIuY8twn36v0pS773JVXA
 wUfzO5JII/9GmSa4uLatIpLJPg76lgem29iBQkSQBE6A//PjTv/TxQdOym5cTlNIy5Zq3Ejz8sx
 Kh9SXAn3mYDeS4brIu4oR+pxFCJ8ZSX3aBlOqjNhaG/R84A7yNQMwSxvTK5kw1owHB3MJHgWDVx
 Hr83LioMqXw9H1qcCmh9+AXWQLiVMEbj4L9W/To4T3BAmLjmb7Tnrwd1iJK8kY04jZVZ4ZUgLHJ
 /n2HECdfWnncsa6HjsmkCoECiASezruDunmLoW/TxySHlS7Q7DzeHMBj5T0fOx1dDCc4J65BmDL
 XK/EJOuuyabpwiCtfjQ==
X-Proofpoint-ORIG-GUID: f_8LTHksoZc0d8X8YX23OSctkrjJ3xZN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210096

afiucv_hs_rcv() selects a socket from iucv_sk_list by matching four 8-byt=
e
name fields in the transport header alone. No check is made against the
net_device the frame arrived on.

This can cause a frame arriving on any netdev to be delivered to an AF_IU=
CV
socket. Three problems follow.

First, a frame arriving over HiperSockets can be delivered to a socket
bound to the classic z/VM IUCV transport, which has iucv->hs_dev =3D=3D N=
ULL.
iucv_sock_bind() takes the classic path whenever the requested userid
matches iucv_userid, even on a guest that also has a HiperSockets device
carrying the same identifier. The child socket created by
afiucv_hs_callback_syn() for such a match inherits hs_dev =3D NULL and
transport =3D AF_IUCV_TRANS_HIPER, so the first send() on it returns -ENO=
DEV.
The socket delivered to accept() is unusable.

Second, a frame arriving on one netdev can be delivered to a socket bound
to a different IQD device. Which can lead to
- Accept-queue exhaustion (DoS)
- Attacker-controlled peer identity in the child socket
- Data injection into existing sockets
- Fabric noise on the IQD fabric, where bogus replies are sent
- killing established connections

Third, all AF_IUCV sockets live in init_net, as iucv_sock_alloc() calls
sk_alloc(&init_net, ...). But even frames arriving on netdev devices in a
namespace can be delivered to an IUCV socket. So a process in an
unprivileged user and network namespace holding only the CAP_NET_RAW
capability valid within that namespace can send a raw ETH_P_AF_IUCV frame
on its own lo device and have it matched against init_net sockets.

Fix all three by skipping any socket whose hs_dev does not match the
ingress device. A classic z/VM IUCV socket has hs_dev =3D=3D NULL; the in=
gress
dev is never NULL, so classic sockets are skipped automatically. An unbou=
nd
HIPER socket also has hs_dev =3D=3D NULL and is skipped. A bound HIPER so=
cket
is only reachable from the exact IQD device it was bound to. Because hs_d=
ev
is always a device in init_net (iucv_sock_bind() scans
for_each_netdev_rcu(&init_net, ...) exclusively), a frame whose ingress
device belongs to another namespace never matches any socket.

Note that AF_IUCV over HiperSockets provides no per-connection
authentication: no sequence numbers, no TLS, no nonce. The four name fiel=
ds
identifying a connection are exchanged in plaintext on the shared
HiperSockets segment (VCHID). Any host on the same HiperSockets segment
could spoof any frame type against an existing connection. That is a
protocol-level property unchanged by this patch. The fix reduces the atta=
ck
surface to peers present on the same HiperSockets segment.

Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
Cc: stable@vger.kernel.org
Co-developed-by: Bryam Vargas <hexlabsecurity@proton.me>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
I think this fix covers the issues adressed by [1] and [2], and
further reduces the attack surface.

Bryam, would you accept a Co-developed-by, as you did the analysis
and you proposed to add checks in afiucv_hs_rcv()?

[1] [PATCH net] net/iucv: only deliver HiperSockets frames to HiperSocket=
s sockets
Link: https://lore.kernel.org/netdev/20260813-b4-disp-60433a46-v1-1-509e1=
200533e@proton.me/ [1]
[2] [PATCH net 1/2] net/iucv: drop HiperSockets frames from other network=
 namespaces
Link: https://lore.kernel.org/netdev/20260815-b4-disp-dc82fde4-v1-1-e83b1=
0b22ce9@proton.me/ [2]

---
 net/iucv/af_iucv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index ea047bab65e7..4e5cc9da6e06 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -2079,6 +2079,8 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struc=
t net_device *dev,
 	sk =3D NULL;
 	read_lock(&iucv_sk_list.lock);
 	sk_for_each(sk, &iucv_sk_list.head) {
+		if (iucv_sk(sk)->hs_dev !=3D dev)
+			continue;
 		if (trans_hdr->flags =3D=3D AF_IUCV_FLAG_SYN) {
 			if ((!memcmp(&iucv_sk(sk)->src_name,
 				     trans_hdr->destAppName, 8)) &&
--=20
2.53.0

