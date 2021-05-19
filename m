Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5691C433B4
	for <linux-s390@archiver.kernel.org>; Wed, 19 May 2021 16:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC5C2611C2
	for <linux-s390@archiver.kernel.org>; Wed, 19 May 2021 16:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240247AbhESQK3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 19 May 2021 12:10:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355077AbhESQK1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 May 2021 12:10:27 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14JG3YY3110958;
        Wed, 19 May 2021 12:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=FerZx/uTchInXOVU0A9WUtnnuDKz8NXTOuSSaJV5mA4=;
 b=i4mk/IUHF91hw4sPR2m3dwN88pqvS5N6oU+NFJSpOfDPqcvJCYIAUWKp6oFTuDTmKFpo
 45K9qBi43qEvqzXO6Qr99lyy+pZKqsPYzY1jaR2AVTRMH8iMsmrPRuOlKTjCLzuV5RcP
 092btpBmn7cmQLPTsI5/lDfYoORpPF+EQ0qyKSYQjgW2NK+md36rb/D7XNrWT7HjJ1tu
 wyvDpYOLRwMpcF+auz1dI1zF9IOqq34eYF5EYLimIVm3ntEn7OKo9Pg6AERKHiI0fFRk
 aYyoHPF8QBQ9lIP/xZFdpDHH+Nf1jpKo7LD5vGgHLYwHeDrdRZ8l7NWyk7t8qjid8vF9 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38n23ks3nm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 12:09:06 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14JG3uKj112314;
        Wed, 19 May 2021 12:09:06 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38n23ks36b-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 12:09:06 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14JFN4w8021700;
        Wed, 19 May 2021 15:39:26 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma05wdc.us.ibm.com with ESMTP id 38j7tb7gvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 15:39:26 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14JFdPQ32622200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 15:39:25 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFA95AC06F;
        Wed, 19 May 2021 15:39:25 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4837EAC060;
        Wed, 19 May 2021 15:39:25 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.177.219])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 19 May 2021 15:39:25 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v3 0/2] s390/vfio-ap: fix memory leak in mdev remove callback
Date:   Wed, 19 May 2021 11:39:19 -0400
Message-Id: <20210519153921.804887-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fZEG-dCKVoxtOFLHsdrHzZRctdoO1MYP
X-Proofpoint-ORIG-GUID: kyPXA9Y6HiIBQyxj4_H1W4zvCoFjpKoL
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_07:2021-05-19,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=806 spamscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190098
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Fixes a memory leak in the mdev remove callback when invoked while the
mdev is in use by a KVM guest. Instead of returning -EBUSY from the
callback, a full cleanup of the resources allocated to the mdev is
performed because regardless of the value returned from the function, the
mdev is removed from sysfs.

The cleanup of resources allocated to the mdev may coincide with the 
interception of the PQAP(AQIC) instruction in which case data needed to
handle the interception may get removed. A patch is included in this series
to synchronize access to resources needed by the interception handler to
protect against invalid memory accesses.

Change log:
v2 -> v3:
--------
* Added a patch to control access to the PQAP(AQIC) hook using RCU

v1 -> v2:
--------
* Call vfio_ap_mdev_unset_kvm() function from the remove callback instead
  of merely clearing the guest's APCB.

Tony Krowiak (2):
  s390/vfio-ap: fix memory leak in mdev remove callback
  s390/vfio-ap: control access to PQAP(AQIC) interception handler

 arch/s390/include/asm/kvm_host.h  |  1 +
 arch/s390/kvm/priv.c              | 47 +++++++++++++---------
 drivers/s390/crypto/vfio_ap_ops.c | 67 +++++++++++++++++++++----------
 3 files changed, 75 insertions(+), 40 deletions(-)

-- 
2.30.2

