Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17151482F6;
	Mon, 29 Jul 2024 12:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256114; cv=none; b=qfwyJjwTFF6PaFrQcfPXn0/Js9BJvG92WXfT9f0C/Vpdoz6+5fJA2CEBee80R1n+mABl4nEfCSeRQggSw/zGCfFRf6xRhdKDDWdQlp+8mb0jArlj/3U61jj0pnanZnA4cRp9lk3Zf0JAOUdPTl82hzTpZzC5bLizAt/io74FHGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256114; c=relaxed/simple;
	bh=lTGJF5ueK5ItT508wCogsfzRhnN++E2Y/UtH4sd9wAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=COMbLorsSaNwkSWYFbU1ce8F6KY/IR0ZAmZGXNnOrC2pT4ajMV6Wt9o11+xVAPOp8ea0tBctv8HLiMPNWWgZzsy1f6aBNkXFaA+AFxxAIctyg8uSVSSYRE8g9Ugzjg9CZ9l6vr8NhGqdeGiX/J26Nzpk3iRS46/haUGyHCz8YgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Bc82reZ4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Bc82reZ4"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TCSNFq008557;
	Mon, 29 Jul 2024 12:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=clW8iS8GzuUl3bXBZcKoi9MelcyzggKXvvuyVFV
	ehk4=; b=Bc82reZ47sNh2aD1OfWOtwOfUACx2Z6DS9ZyDlLTS5Rp3oQpIlypxF3
	0zPYMYNK4+fL6B6/PplWsMBLtFjvpcOKpXjHHnqvDmGJZTP2K4ZB30zQR9pMzcWm
	s+I+1dfwbfpAjUcE6FKOgz3aFgOIY+YJtx2HkaRZQ26O9cheI5KPsOifF4p6F0gI
	tJ6fJHwwXsNGPvQbV9oCxHbqIFxcf9lU1SEDXmJDzhN0CYG/5GGmkc20fCp7CyWL
	KYKtLdLT0mcIo2T0eZd3H5L9Pr45EH+1Anl8i+f281qHsuBxlAHGMvUy9ixbRX1R
	Mt7k+ygom6c2B8e5DxTyAb6Hhi3voWA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40pb46000h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 12:28:26 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46TCSPbB008626;
	Mon, 29 Jul 2024 12:28:26 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40pb46000e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 12:28:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46TBUhTm003773;
	Mon, 29 Jul 2024 12:28:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndem6btr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 12:28:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46TCSJgi30540198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 12:28:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D9B220043;
	Mon, 29 Jul 2024 12:28:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B06420040;
	Mon, 29 Jul 2024 12:28:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 29 Jul 2024 12:28:19 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id B68ECE04DE; Mon, 29 Jul 2024 14:28:18 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH net] net/iucv: fix use after free in iucv_sock_close()
Date: Mon, 29 Jul 2024 14:28:16 +0200
Message-ID: <20240729122818.947756-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RjE4ke_5k9nvWCxYZJ5JzbJNXBEntWTm
X-Proofpoint-ORIG-GUID: 522Yh1WYRag8tED8KSzo-DVvqj1jW7BT
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_10,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 clxscore=1011 spamscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=763
 bulkscore=0 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407290083

iucv_sever_path() is called from process context and from bh context.
iucv->path is used as indicator whether somebody else is taking care of
severing the path (or it is already removed / never existed).
This needs to be done with atomic compare and swap, otherwise there is a
small window where iucv_sock_close() will try to work with a path that has
already been severed and freed by iucv_callback_connrej() called by
iucv_tasklet_fn().

Example:
[452744.123844] Call Trace:
[452744.123845] ([<0000001e87f03880>] 0x1e87f03880)
[452744.123966]  [<00000000d593001e>] iucv_path_sever+0x96/0x138
[452744.124330]  [<000003ff801ddbca>] iucv_sever_path+0xc2/0xd0 [af_iucv]
[452744.124336]  [<000003ff801e01b6>] iucv_sock_close+0xa6/0x310 [af_iucv]
[452744.124341]  [<000003ff801e08cc>] iucv_sock_release+0x3c/0xd0 [af_iucv]
[452744.124345]  [<00000000d574794e>] __sock_release+0x5e/0xe8
[452744.124815]  [<00000000d5747a0c>] sock_close+0x34/0x48
[452744.124820]  [<00000000d5421642>] __fput+0xba/0x268
[452744.124826]  [<00000000d51b382c>] task_work_run+0xbc/0xf0
[452744.124832]  [<00000000d5145710>] do_notify_resume+0x88/0x90
[452744.124841]  [<00000000d5978096>] system_call+0xe2/0x2c8
[452744.125319] Last Breaking-Event-Address:
[452744.125321]  [<00000000d5930018>] iucv_path_sever+0x90/0x138
[452744.125324]
[452744.125325] Kernel panic - not syncing: Fatal exception in interrupt

Note that bh_lock_sock() is not serializing the tasklet context against
process context, because the check for sock_owned_by_user() and
corresponding handling is missing.

Ideas for a future clean-up patch:
A) Correct usage of bh_lock_sock() in tasklet context, as described in
Link: https://lore.kernel.org/netdev/1280155406.2899.407.camel@edumazet-laptop/
Re-enqueue, if needed. This may require adding return values to the
tasklet functions and thus changes to all users of iucv.

B) Change iucv tasklet into worker and use only lock_sock() in af_iucv.

Fixes: 7d316b945352 ("af_iucv: remove IUCV-pathes completely")
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
The following inactive mailaddresses were not cc'ed:
schwidefsky@de.ibm.com, frank.blaschka@de.ibm.com, ursula.braun@de.ibm.com
---
 net/iucv/af_iucv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index c3b0b610b0aa..c00323fa9eb6 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -335,8 +335,8 @@ static void iucv_sever_path(struct sock *sk, int with_user_data)
 	struct iucv_sock *iucv = iucv_sk(sk);
 	struct iucv_path *path = iucv->path;
 
-	if (iucv->path) {
-		iucv->path = NULL;
+	/* Whoever resets the path pointer, must sever and free it. */
+	if (xchg(&iucv->path, NULL)) {
 		if (with_user_data) {
 			low_nmcpy(user_data, iucv->src_name);
 			high_nmcpy(user_data, iucv->dst_name);
-- 
2.43.0

