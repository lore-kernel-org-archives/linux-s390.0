Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D523C4707D
	for <linux-s390@archiver.kernel.org>; Fri, 21 May 2021 19:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F6BF613D8
	for <linux-s390@archiver.kernel.org>; Fri, 21 May 2021 19:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbhEUTiU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 21 May 2021 15:38:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48498 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232214AbhEUTiU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 May 2021 15:38:20 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14LJXlXI042086;
        Fri, 21 May 2021 15:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=faxDq6fhgdTsYJpR8vIrbF5wBKoQKAmcvKiF49fQ/Y4=;
 b=CvdGWPsnXRGj5U60qe719HpoFz5pnyUYHw73UB7gvXeRrkTfVdHN2i6Lj/6aekdt3tCN
 dwEdgo+OJedZHRwPxnMwrCNSCLQQd8a0e/Rla9Y9bse9Y8rJg/5npSY2NUu09Nl6itEs
 1Oa4AmEph5nDAO0sB8twc8KKx8InGetJTpi5lGAwzQda+pVbtJPhciy28YAeeHRYonGD
 wFuk8wpS9kS68FPyM0WOoqJeRcnLbZXL987cPkF/83lrtjFv5g63/Z5UR/1NbtznHT/X
 WVtscG29MHMoDTtBTSS9c4dqkUcKSXZkU/xVjHVnVKZ39Y2jcJQkWjSJFQ5w6Um2gJge Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38pgd4mb1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 15:36:55 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14LJXmY2042136;
        Fri, 21 May 2021 15:36:54 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38pgd4mb1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 15:36:54 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14LJZvFJ009230;
        Fri, 21 May 2021 19:36:53 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 38j5xaenpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 19:36:53 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14LJaqOQ10027374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 19:36:52 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A88A6E056;
        Fri, 21 May 2021 19:36:52 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AEA26E050;
        Fri, 21 May 2021 19:36:50 +0000 (GMT)
Received: from cpe-172-100-179-72.stny.res.rr.com (unknown [9.85.177.219])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 21 May 2021 19:36:50 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: [PATCH v4 0/2]  s390/vfio-ap: fix memory leak in mdev remove callback
Date:   Fri, 21 May 2021 15:36:46 -0400
Message-Id: <20210521193648.940864-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1p2bozsnMct4QmVx4QFDPoDAYz-rRlO-
X-Proofpoint-ORIG-GUID: Fsk69raI_3iSO3kShnF3oEXf89KyjGmA
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-21_09:2021-05-20,2021-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210103
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

The first pass (PATCH v3) at trying to synchronize access to the pqap
function pointer employed RCU. The problem is, the RCU read-side critical
section would have to include the execution of the pqap function which
sleeps; RCU disallows sleeping inside an RCU region. When I subsequently 
tried to encompass the pqap function within the 
rcu_read_lock/rcu_read_unlock, I ended up seeing lockdep warnings in the
syslog.

It was suggested that we use an rw_semaphore to synchronize access to 
the pqap hook, but I also ran into similar lockdep complaints something
like the following:

  Possible unsafe locking scenario:

        CPU0                            CPU1
        ----                            ----
   down_read(&rwsem)
   in handle_pqap (priv.c);   
   
                                  lock(&matrix_dev->lock);
                                  in vfio_ap_mdev_set_kvm (vfio_ap_ops.c)
                                
                                  down_write(&rwsem;
                                  in vfio_ap_mdev_set_kvm (vfio_ap_ops.c)
                                
   lock(&matrix_dev->lock);
   in handle_pqap(vfio_ap_ops.c)

Access to the mdev must be done under the matrix_dev->lock to ensure that
it doesn't get freed via the remove callback while in use. This appears
to be mutually exclusive with setting/unsetting the pqap_hook pointer
due to lockdep issues.

The solution:
------------
The lifetime of the handle_pqap function (vfio_ap_ops) is syncrhonous
with the lifetime of the vfio_ap module, so there really is not reason
to tie the setting/clearing of its function pointer with the lifetime
of a guest or even an mdev. If the function pointer is set when the
vfio_ap module is loaded and cleared when the vfio_ap module is unloaded,
then access to it can be protected independently from mdev creation or
removal as well as the starting or shutdown of a guest. As long as
access to the mdev is always controlled by the matrix_dev->lock, the 
mdev can not be freed without other functions being aware.

Change log:
v3 -> v4:
--------
* Created a registry for crypto hooks in priv.c with functions for
  registering/unregistering function pointers in kvm_host.h (for s390).

* Register the function pointer for handling the PQAP instruction when
  the vfio_ap module is loaded and unregister it when the module is 
  unloaded.

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

 arch/s390/include/asm/kvm_host.h      | 13 +++--
 arch/s390/kvm/priv.c                  | 70 +++++++++++++++++++++++++--
 drivers/s390/crypto/vfio_ap_ops.c     | 50 ++++++++++++-------
 drivers/s390/crypto/vfio_ap_private.h |  1 -
 4 files changed, 107 insertions(+), 27 deletions(-)

-- 
2.30.2

