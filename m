Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF10374CC;
	Fri,  9 Feb 2024 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707482733; cv=none; b=U3OFIPXPojor6VQDMgj8PndsjWJJ27btkNoKJCWKKpBIVFGipOTwwXh5EEgB9VIfmlBzaxf6PTU+bIpNMmRw1AxJnYfx/5/eUZG1Vhbd/jlBgkqn3VzLLjhgXzK4WUDtQ2R86Hu/EC9tZKf1VLisocfxRzsXVQOTXUMUN9MXjaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707482733; c=relaxed/simple;
	bh=elXA0Ksm5mb4jnP65PdA3s52EPbUsLR2oOSQIEBBQtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cr1cfr12aWpp+di/uEtGkD+zuEcGsJykuKRiqzOoZmjFTYI/33jOzYTFzq7POSzocJ8Yda6IVP4oy+kMjCnzNGE4lXNr2L9gPI5s2QJvILrVhw3COX9jZowvQbdRAv5iauUv3UVjD4k4nbRCkHNirXeP/i1rkFUnnd+RSVuMteA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TZhn3Obu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TZhn3Obu"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 419Cc3B5023296;
	Fri, 9 Feb 2024 12:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=5+EdPaMIjToTH4qCNU5WJSqW5nniVGk1xMnn4EPfGD8=;
 b=TZhn3Obuo0VC0dAlk0rIZHnbr9RCGbyb1pp+Fus2aYbV78giphOjmoe/Gnhge24iarSS
 5WTM7qWDjRPr7gH1Tx+N7X+tzVgQnYHy7/eoVWJfcn7Dz2UKxdML/SEV/8KlKygZhfbT
 hijwsgvEBCOct2GTsNeomSo5goB5xBwima54mS64HOI9G0VsFb2M9inmovxknadLpe5r
 RPOjQFsSZS4gvfH4ITQ7RHl2ahAZnMa4jiO7wW3EhToFTtDzsOIsWcbGEjdCE7yJdrtF
 8XjvyAENyix1tzwilAO1oAsgzqrx5P4aYrQ/MWVat21s95IbmayW7WTZ/E76WO8ouRSx cQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w5m7jr691-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 12:45:28 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 419C0K2b008527;
	Fri, 9 Feb 2024 12:45:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w221kjrq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 12:45:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 419CjNrC15532568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Feb 2024 12:45:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB08A20043;
	Fri,  9 Feb 2024 12:45:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBC6720040;
	Fri,  9 Feb 2024 12:45:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  9 Feb 2024 12:45:22 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id A02CFE15C0; Fri,  9 Feb 2024 13:45:22 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Miroslav Franc <mfranc@suse.cz>
Subject: [PATCH RESEND 2/2] s390/dasd: fix double module refcount decrement
Date: Fri,  9 Feb 2024 13:45:22 +0100
Message-Id: <20240209124522.3697827-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240209124522.3697827-1-sth@linux.ibm.com>
References: <20240209124522.3697827-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DlFCPwJjAgPAvk58ds_OeWT3VKzJ5Y0R
X-Proofpoint-GUID: DlFCPwJjAgPAvk58ds_OeWT3VKzJ5Y0R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_10,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=654 clxscore=1015
 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402090093

From: Miroslav Franc <mfranc@suse.cz>

Once the discipline is associated with the device, deleting the device
takes care of decrementing the module's refcount.  Doing it manually on
this error path causes refcount to artificially decrease on each error
while it should just stay the same.

Fixes: c020d722b110 ("s390/dasd: fix panic during offline processing")
Signed-off-by: Miroslav Franc <mfranc@suse.cz>
Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index fdb6cb8d8abf..2f3adf5d8fee 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3503,12 +3503,11 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 		dasd_delete_device(device);
 		return -EINVAL;
 	}
+	device->base_discipline = base_discipline;
 	if (!try_module_get(discipline->owner)) {
-		module_put(base_discipline->owner);
 		dasd_delete_device(device);
 		return -EINVAL;
 	}
-	device->base_discipline = base_discipline;
 	device->discipline = discipline;
 
 	/* check_device will allocate block device if necessary */
@@ -3516,8 +3515,6 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 	if (rc) {
 		dev_warn(dev, "Setting the DASD online with discipline %s failed with rc=%i\n",
 			 discipline->name, rc);
-		module_put(discipline->owner);
-		module_put(base_discipline->owner);
 		dasd_delete_device(device);
 		return rc;
 	}
-- 
2.40.1

