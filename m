Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FEE2E652;
	Fri,  9 Feb 2024 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707482733; cv=none; b=D1jrxat4/u4LBIMJuakj/izA1F+I5c/C+lGGAbnypGeA0U6jL4oHLXg6Hifzps2rZnZhn1tY+vBfG+wURiUUxT7OQ5ai0KHSP1133BtG5bFXTiPCXMc7HsgqTp0al+uTGVcIu7vYKlU3QTqf9ESLyWZYp/CA6gNtIT7L3i8tBM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707482733; c=relaxed/simple;
	bh=h7Sz3JS5VTisYQPmsgusb7gQk0ADCCwVfEATk51pKso=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Y8vEcArSNrLW+nK5i6VhmqZvEF37OYRza/MjCMhM9UdC757Bq57/YxWf9oPL5TPo43cQfCGjG4pafgh1N/jXFogkOv9HoCiVvA/LVCsEbPwu+kjYhQ52qa5eeeI/A5QyIE3+J3quvSWfLB/O/5eRwZLqxFZSd7gQUrfoikU08uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q11ZneHe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q11ZneHe"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 419CbxPR023173;
	Fri, 9 Feb 2024 12:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=xeNnVMhWPpw56eboh4TqNYLCnTgApodAvFibwq4u9GY=;
 b=q11ZneHeOJLEHajXZhZfp0ZrCjykXnvECGJfBW+H0FTMjXYSbwuKMMRwpg9iM5+b0imW
 /GAGlLTcmsDpK2Eyaasw2dbrXmFe+ACPj8Y8YFBVOPMzZ0V1ZPWPJRkXNgA1W7yLQ0EM
 6cfJvYEP7MvTG9PijOLyfZOGLLMUDa5HdsedjdufZZzQKqcoohRdiAIjGirIKW6IXtIZ
 4tKRh5KFmSCA66eBHVXNAWSrR5LI+SRvM+R/xqmOUcLk3doov8MwwySYHfAGUMh6pBJP
 10NAv0pl5gdpwZt9XIicKeINDLBajE177t6stX9VSm02bOEZRBULDne4kELaTLcnM8SQ VA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w5m7jr697-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 12:45:29 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4199nUfv020375;
	Fri, 9 Feb 2024 12:45:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w1yttkd2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 12:45:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 419CjMgl28246364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Feb 2024 12:45:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC4E02004D;
	Fri,  9 Feb 2024 12:45:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B94792004B;
	Fri,  9 Feb 2024 12:45:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  9 Feb 2024 12:45:22 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id 80BC0E0361; Fri,  9 Feb 2024 13:45:22 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Miroslav Franc <mfranc@suse.cz>
Subject: [PATCH RESEND 0/2] two missing patches
Date: Fri,  9 Feb 2024 13:45:20 +0100
Message-Id: <20240209124522.3697827-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Gcpmw7ztUDm_aLRRAbrr5OWn3d8Hvc4q
X-Proofpoint-GUID: Gcpmw7ztUDm_aLRRAbrr5OWn3d8Hvc4q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_10,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=764 clxscore=1015
 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402090093

Hi Jens,

somehow two of the patches have not been sent with the patchset yesterday.
Sorry for this.

Here are the two missing patches.
Please apply for the upcomming merge window.

Jan Höppner (1):
  s390/dasd: Improve ERP error messages

Miroslav Franc (1):
  s390/dasd: fix double module refcount decrement

 drivers/s390/block/dasd.c          |  5 +--
 drivers/s390/block/dasd_3990_erp.c | 51 ++++++++----------------------
 2 files changed, 14 insertions(+), 42 deletions(-)

-- 
2.40.1

