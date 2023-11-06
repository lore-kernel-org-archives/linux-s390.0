Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BE6C4332F
	for <linux-s390@archiver.kernel.org>; Mon,  6 Nov 2023 12:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjKFMbX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 6 Nov 2023 07:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjKFMbX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Nov 2023 07:31:23 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AE4A4
        for <linux-s390@vger.kernel.org>; Mon,  6 Nov 2023 04:31:20 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6BlHgd025595
        for <linux-s390@vger.kernel.org>; Mon, 6 Nov 2023 12:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=J6zrOtNnHzETgVq1MXtCyUNJtlPiqfaGnHat/IrTdq4=;
 b=I2/WxIKvz8I3V/Y0OH4yrnQI449QWTfsw5H/7G38ze4mPDxmaGnPWjnIGVC9KeBSgslc
 za/nSd3sl3K8RlHinQ/iBVUC6RNNi40l6do1GOlHPUmrUFV06sctwt7dz9SpknBm8BYY
 adOVE8pjedPumXwme5fOiQtwEqdR4ARjuy9NjGSxtSYDPkO5JfgsrYqyi0kT08e4xaZ6
 vicVuzPJODW10hYELFgvf9tPol0g5nPTgc5bF/F5q/US8Fnlc3trd8817OdEHVwyTim1
 QgEvojYhzRgN1buXJEfI1XJ7HnXX0vL+o5TZnwlR1fCLBEFs/rLVBPIwmgYtmZZNrU2O Og== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u6yjx9c2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 06 Nov 2023 12:31:19 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6B531O025606
        for <linux-s390@vger.kernel.org>; Mon, 6 Nov 2023 12:31:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u619n9679-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 06 Nov 2023 12:31:18 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A6CVF6O25821722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 12:31:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDF7620043;
        Mon,  6 Nov 2023 12:31:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C45A20040;
        Mon,  6 Nov 2023 12:31:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Nov 2023 12:31:15 +0000 (GMT)
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     linux-s390@vger.kernel.org
Cc:     Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v1 1/1] s390/uvdevice: Report additional-data length for attestation
Date:   Mon,  6 Nov 2023 13:31:15 +0100
Message-Id: <20231106123115.3007725-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HGJ3mLmfNRDu9bTW_FE2suzi48FhlnGC
X-Proofpoint-GUID: HGJ3mLmfNRDu9bTW_FE2suzi48FhlnGC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_11,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=984 phishscore=0
 mlxscore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060101
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Additional data length in the attestation request is an in/out variable.
Software provides the capacity of the buffer. Upon successful request,
firmware reports the actual bytes written to the additional data in that
field. This information is lost, as the length field was not copied back
to userspace before. Attestation might fail, if user space did not
specify the exact amount of needed bytes required, as this length is
part of the attestation measurement.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 drivers/s390/char/uvdevice.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
index 144cd2e03590..42c9f77f8da0 100644
--- a/drivers/s390/char/uvdevice.c
+++ b/drivers/s390/char/uvdevice.c
@@ -109,6 +109,7 @@ static int uvio_copy_attest_result_to_user(struct uv_cb_attest *uvcb_attest,
 					   struct uvio_attest *uvio_attest)
 {
 	struct uvio_attest __user *user_uvio_attest = (void __user *)uv_ioctl->argument_addr;
+	u32 __user *user_buf_add_len = (u32 __user *)&user_uvio_attest->add_data_len;
 	void __user *user_buf_add = (void __user *)uvio_attest->add_data_addr;
 	void __user *user_buf_meas = (void __user *)uvio_attest->meas_addr;
 	void __user *user_buf_uid = &user_uvio_attest->config_uid;
@@ -117,6 +118,8 @@ static int uvio_copy_attest_result_to_user(struct uv_cb_attest *uvcb_attest,
 		return -EFAULT;
 	if (add_data && copy_to_user(user_buf_add, add_data, uvio_attest->add_data_len))
 		return -EFAULT;
+	if (put_user(uvio_attest->add_data_len, user_buf_add_len))
+		return -EFAULT;
 	if (copy_to_user(user_buf_uid, uvcb_attest->config_uid, sizeof(uvcb_attest->config_uid)))
 		return -EFAULT;
 	return 0;
-- 
2.39.2

