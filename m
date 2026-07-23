Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC39F42FCCF
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 09:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800500; cv=none; b=r6rlzRrjubO3/R2San6wPNFX5hUr5VZ+4bSFDGlYYclD/vHXYj76jFGIkxY61jOcyeWzbtxBLT+2JKPbiIXO0nhGEg8JVFTYdJPVFAg2WhAE0W3hw/z+sGjPzhg90BR//Nh22X/MmFglwmrpr848xZA9WkmVgmthQBSP81AcNSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800500; c=relaxed/simple;
	bh=+kzpDWdrVLlsFomMNruKAbtFFDqovU9kwGEaQj66oNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9K0PThdqCm61CyylKpFqs8HYR73VRHjM5+cAYMyJHYwN3pae8vBY+3W3SeV2SxP+GwJYH+a+9ju3s2S3IvO+W+f8qWOsjSvQWq2kqlB3s7fXtyL5W4wVHSIk8wSXFDyHQI5NthTT2APtSCVoGRUa5JeVK/RjCKqS6aTuCaheK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qMvb2RZ+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qMvb2RZ+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N9Bgxe2580297
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 09:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MVY3hfHo3gfbjKmW1
	J/uot3ToyYP4L1mPIgrj9wQy2o=; b=qMvb2RZ+JuDm2Xu/Fb+aTqRRaO9bkKpko
	Ig8D8klO2rYkTBoLLoq/eF4ZPbL2kPz7smb7IJbFVAlMAs1t7vnX71oUro8V0Z6O
	8ZZ5qJLiVCG7BipcplzMlIU1k+Vh4Fv5SZN9ZvmXID7rdLSNN3lCoJX645A37ZGg
	zSVkcU5x+AxPgFRT7dhy3yd+eS+O19QPieJq8nfjou9RMEfm2w6UH+NCkpt9Bcbl
	xidaepXhSwI+zpasTjqWN6026y7wU1wuB3XhUtTdtK/TDn3nlkWfGwEtbLLYLyfJ
	biXOMl4OiO+ByeA/XSTAOknN7Aqp5ks9xVwUQ2MrZGI9ozJ9tdVOA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abpwr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 09:54:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66N9nbE6014790
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 09:54:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqbr02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 09:54:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66N9srjc42729936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 09:54:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56121200F5;
	Thu, 23 Jul 2026 09:54:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D443200F7;
	Thu, 23 Jul 2026 09:54:53 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.142.235])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 09:54:53 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH v3 2/2] s390/zcrypt: Close speculative mem read possibility
Date: Thu, 23 Jul 2026 11:54:53 +0200
Message-ID: <20260723095453.127322-3-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723095453.127322-1-freude@linux.ibm.com>
References: <20260723095453.127322-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA5NiBTYWx0ZWRfXwLgfmjq4mVzE
 cUvrm/+pFycbBT2ddfEJQICOWzkILtsflgL5bBhBSxlt5iUPoVeeuF99pIVdQgL7YDgwgRmbNq5
 tMYmKrpfSgTQPme3eCayNU3T799rD18dd2DVwhrEBtHgKLui8kXhmG5zchv8m/FJNwvPjoVvHdz
 ZCd7ff9Ds8GcRoTWz3MXhmiOe+KkmtwzpMR3MJGKRcQPjilCRZlAEqk7zepaOmEyIM2s4XiYYbJ
 RN9//uaE5+cEgCZwUyaZGQ9Wbdjw7kpQ49AfI3u3qF6pRRd7pvbgLjgoH5qlpcCjpOtm0HENlR9
 6pAqFX6tx4EUBfeeYErLIBWgZdHUYcvRU0XXE64FXqA5dprbG97Urd4b25QOE0c324epYvu6yoI
 FqGf1K8osknS4bX1WSqxdulpMIzTEhh4kZbx8GTWfUkG88GoGxCuKVNa8Ji8hy0j8XdppEK322k
 PbJBzeSLME2LOq/TOfA==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a61e4f1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=IZBGf3zZmU-6-mvM01AA:9
X-Proofpoint-ORIG-GUID: rhRp2GSoRKNUexclnGR5i_ckoNUsP2xN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA5NiBTYWx0ZWRfX/I2myWZCNOIJ
 qE2e6Dsdzw1MH25sIuKaMM2koNfinOT75QHSVDQuXkWbOPudYEPAC48T7UDb4LEDUmZP2j7KCza
 PBy6tk8y90+KnQiKCkKmd8Po72o5ClY=
X-Proofpoint-GUID: rhRp2GSoRKNUexclnGR5i_ckoNUsP2xN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230096

The domain value is extracted from a given CCA or EP11 ioctl struct
when a CPRB is about to be sent. Thus this is a user controlled value.
Under some special conditions (custom device node used, administrative
load) this value is used as an array index after bounds checking, but
without speculation barrier.

Add the missing array_index_nospec() call to prevent speculative
execution where this domain value is used.

Fixes: cfd68b33094e ("s390/zcrypt: Filter admin CPRBs on custom devices")
Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
Cc: stable@vger.kernel.org
---
 drivers/s390/crypto/zcrypt_api.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 81eefdeae248..ec6a4c2f9f04 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -879,6 +879,7 @@ static long _zcrypt_send_cprb(u32 xflags, struct ap_perms *perms,
 
 	if (perms != &ap_perms && domain < AP_DOMAINS) {
 		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
+			domain = array_index_nospec(domain, AP_DOMAINS);
 			if (!test_bit_inv(domain, perms->adm)) {
 				rc = -ENODEV;
 				goto out;
@@ -1079,6 +1080,7 @@ static long _zcrypt_send_ep11_cprb(u32 xflags, struct ap_perms *perms,
 
 	if (perms != &ap_perms && domain < AP_DOMAINS) {
 		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
+			domain = array_index_nospec(domain, AP_DOMAINS);
 			if (!test_bit_inv(domain, perms->adm)) {
 				rc = -ENODEV;
 				goto out;
-- 
2.43.0

