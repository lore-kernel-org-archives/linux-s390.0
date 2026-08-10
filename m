Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB0C3BE659;
	Mon, 10 Aug 2026 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786360492; cv=none; b=iXR3yBqDelBn161XhN0HHdRrz7Ab2gR0qTsQDJxZilgt27MNKRxlU1F58/Ez1W4C2JgE65udGP8tSFIVBmpOxINJiHSFs0QDbZFFsveyPIO5Z4laOxosu0koxusf94lc+DcopCDYGLu66wOs4K6lckKa4IOmBp5OyRICkzsAcgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786360492; c=relaxed/simple;
	bh=DAcPtw5y/AR4X6DapdtZe+gtfW6tp4upzGmyim5ulp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7xRxoh+BtdNJiqvPa+ozJ3BEEMtjYMmvmzpelmE8rQWTeO0+UgHAuT62FyKe3AsD+esO8cFXcUfKKvg3NLo2n6mH2/14mEdCJ3lnIIQloJcvdoHAUACC8v1043OniqWcXGjcShV+bngYOsqeKo9R9f7T2xWbGqIvD0ithiHVnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=If4Va1Nm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="If4Va1Nm"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A9VT6P1208869;
	Mon, 10 Aug 2026 11:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=F5sSozvRRGqo7fHQ1ImoJqlEG1S5UNjiqXB4AJUFP
	OY=; b=If4Va1NmBXltcjMnYSt7H89awqygrBAi9UopHqFJeqopUjYF/UiV0JmSr
	ZzwU+yrDcw5ad3z+IWX1Hummt1WNwZmxzYt1lCqmuEDXlbRuFZA2dlFKOu3Dn/mN
	qJM3leDVwioDoBYvLfJ8I2vR7v/DrVARbRy/QrmGBkQgfop3gZO6xcauz7BGqxpL
	q23wFn/YmUM/LrrPdORHa+y1bajLfveGerNKekVv4+2poMo+0vDqWuOQhxjAVOj6
	1N3I+X/Q8KSmLj9fGKxXjEPttfAkRHjRTYIhJiQZoRdIrQLtQwxd9bB/CA+b58Ba
	8ay5vvTj92xCJYpMgQDcDc1+PvA8Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq97jq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:14:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ABBL7v031225;
	Mon, 10 Aug 2026 11:14:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g4c1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:14:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ABEXDL51446234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 11:14:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 261A52004E;
	Mon, 10 Aug 2026 11:14:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5C392004B;
	Mon, 10 Aug 2026 11:14:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 10 Aug 2026 11:14:32 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id CC6F21603D2; Mon, 10 Aug 2026 13:14:32 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Hidayath Khan <hidayath@linux.ibm.com>,
        Dust Li <dust.li@linux.alibaba.com>, stable@vger.kernel.org,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net] net/dibs: Correct freeing of dmb_clientid_arr
Date: Mon, 10 Aug 2026 13:14:32 +0200
Message-ID: <20260810111432.2334900-1-wintera@linux.ibm.com>
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
X-Proofpoint-GUID: 7791h2VxduCO9UthnV-Ac9au4tE09Tb9
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a79b29e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=higaAn-RmfpUlMDw3n0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA5NiBTYWx0ZWRfX+cuDUCCq4/e0
 9tEOyExZxaj4RcBUPJo/Haet9kBl0Znw5DnZ1zyHIgEhpM3Y2QlxbWXfC7dIh3GhuVhd5YUETGE
 8CkWGTZ8FRxuzyFZUXsJEnUzGNelhtBxButOoEoGKSWewKV2oaNd1G0emK5o+cnLk9AzIO84cG6
 ejoCk2cjg8KueiozALjprJI2sg7X1+aAcaeH83YYDTcZm1h3iDzPbKs3K5pYNg8MkLrvKzAOj+f
 n31e0al5pQ9jPXcz84PD4g8Zk+LQ5dgG4sFpL/E5AkXUlSl7atZwh+zSO+7EavI7xwLIshPFmjM
 j9FoSiams+i1B0gURsdP+OtEghPhUFsxV1MiQ17TSD9zaI8pWibRc/4ICu8fObybNmknFGasArF
 9B/3HDLlN0rE6z82wsbGO/rLPPKh3UFzogYxe6CXWIszq9yEcQft5WIK8ll5k3IH4yWk5T7f5oU
 40gvjcSPXh4Nw06yt1g==
X-Proofpoint-ORIG-GUID: QYjAPgBnpCfl6JChPmiEr0ehuy95yLb9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA5NiBTYWx0ZWRfX4c9+oWD1kS+g
 HQGygNvTqNRHhsLQ8cPscKvaYsQIWHaAtjIsW/PS4v5jhLJClmdLNNhRtv4BIqyYHv1AitBYOLH
 WinwnBZISkIr7jIjs5+fTTGG+8A9Tu0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100096

A dibs device interrupt handler can be active after dibs_dev_del() and
may still access dmb_clientid_arr. (UAF)

In case of a failure in dibs_dev_add() being called by dibs_lo_dev_probe(=
)
dmb_clientid_arr is freed twice (double free).

Free dmb_clientid_arr in dibs_dev_release() after last reference is gone.
Note that allocating in dibs_dev_add() instead of dibs_dev_alloc() is ok
for now, because no dmbs can be registered before dibs_dev_add().

Fixes: cc21191b584c ("dibs: Move data path to dibs layer")
Cc: stable@vger.kernel.org
Co-developed-by: Hidayath Khan <hidayath@linux.ibm.com>
Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
This is a squash of [1] and [2] as requested by Jakub.

Simon and Dust Li, I'd appreciate, if you could double-check whether
you can give R-b again.

Link: https://lore.kernel.org/netdev/20260806120447.596164-1-hidayath@lin=
ux.ibm.com/ [1]
Link: https://lore.kernel.org/netdev/20260804085848.3579518-1-wintera@lin=
ux.ibm.com/ [2]

=20
---
 drivers/dibs/dibs_loopback.c |  1 -
 drivers/dibs/dibs_main.c     | 14 ++++----------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/dibs/dibs_loopback.c b/drivers/dibs/dibs_loopback.c
index fd5caf1e19a8..649e4e375be3 100644
--- a/drivers/dibs/dibs_loopback.c
+++ b/drivers/dibs/dibs_loopback.c
@@ -335,7 +335,6 @@ static int dibs_lo_dev_probe(void)
 	return 0;
=20
 err_reg:
-	kfree(dibs->dmb_clientid_arr);
 	/* pairs with dibs_dev_alloc() */
 	put_device(&dibs->dev);
 	kfree(ldev);
diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
index 4c26fd06973f..2b53a9d277dc 100644
--- a/drivers/dibs/dibs_main.c
+++ b/drivers/dibs/dibs_main.c
@@ -128,6 +128,7 @@ static void dibs_dev_release(struct device *dev)
=20
 	dibs =3D container_of(dev, struct dibs_dev, dev);
=20
+	kfree(dibs->dmb_clientid_arr);
 	kfree(dibs);
 }
=20
@@ -194,12 +195,13 @@ int dibs_dev_add(struct dibs_dev *dibs)
=20
 	ret =3D device_add(&dibs->dev);
 	if (ret)
-		goto free_client_arr;
+		return ret;
=20
 	ret =3D sysfs_create_group(&dibs->dev.kobj, &dibs_dev_attr_group);
 	if (ret) {
 		dev_err(&dibs->dev, "sysfs_create_group failed for dibs_dev\n");
-		goto err_device_del;
+		device_del(&dibs->dev);
+		return ret;
 	}
 	mutex_lock(&dibs_dev_list.mutex);
 	mutex_lock(&clients_lock);
@@ -214,13 +216,6 @@ int dibs_dev_add(struct dibs_dev *dibs)
 	mutex_unlock(&dibs_dev_list.mutex);
=20
 	return 0;
-
-err_device_del:
-	device_del(&dibs->dev);
-free_client_arr:
-	kfree(dibs->dmb_clientid_arr);
-	return ret;
-
 }
 EXPORT_SYMBOL_GPL(dibs_dev_add);
=20
@@ -247,7 +242,6 @@ void dibs_dev_del(struct dibs_dev *dibs)
 	mutex_unlock(&dibs_dev_list.mutex);
=20
 	device_del(&dibs->dev);
-	kfree(dibs->dmb_clientid_arr);
 }
 EXPORT_SYMBOL_GPL(dibs_dev_del);
=20
--=20
2.39.5 (Apple Git-154)

