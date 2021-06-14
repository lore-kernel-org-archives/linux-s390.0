Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE9EC49360
	for <linux-s390@archiver.kernel.org>; Mon, 14 Jun 2021 07:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B0F761246
	for <linux-s390@archiver.kernel.org>; Mon, 14 Jun 2021 07:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbhFNHxX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 14 Jun 2021 03:53:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18340 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232583AbhFNHxX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Jun 2021 03:53:23 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15E7XfmS107462;
        Mon, 14 Jun 2021 03:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=BxKI6DtgpRagaD4T7QD8EYfW5Yx5ORMfKAMndQ8F+r8=;
 b=VoF4x+Zapn2sk9TMm8k4EWRl6/FZSYW86+NBYa06rierBJLM3e0a/ky3H1XbzVMCVH5z
 3vByhOFb0dM/RB9e/aBBOmb+k8OA4rA4S4GR6hnFtiTUzUsBiDtTyNgJ1ymQZsiLTTAw
 F/TjIvWAU2RA165iwrpUYcy16KuIMtmxmMTq0LXIu+nPjzL1v1nhjxE+e8q4DJ7XaYvD
 IZLhbq1RClPNfDrHlljkhKIy2JufLTNmtOzE3IYBYolMC48kYe1EeO3MMkZGUsYj5wsU
 go3DCyRbf3mtjLBwf7D+MQOCOZmR7kFn8YD+QDBqUnpGEF3ZhoeNj/thZCXpDFIV1kUj mQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39629xs82s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 03:51:18 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15E7ZcOV115635;
        Mon, 14 Jun 2021 03:51:18 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39629xs824-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 03:51:18 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15E7mqn9003674;
        Mon, 14 Jun 2021 07:51:16 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 394mj8rsjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 07:51:16 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15E7pDT331523222
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 07:51:13 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5430A4060;
        Mon, 14 Jun 2021 07:51:12 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5946DA4062;
        Mon, 14 Jun 2021 07:51:12 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.91.122])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jun 2021 07:51:12 +0000 (GMT)
Subject: Re: [PATCH v4 0/2] s390/vfio-ap: fix memory leak in mdev remove
 callback
To:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        jgg@nvidia.com, alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
References: <20210521193648.940864-1-akrowiak@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <b5ff6818-fb8c-3d50-2d2e-d3992be1644b@de.ibm.com>
Date:   Mon, 14 Jun 2021 09:51:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210521193648.940864-1-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BsCMWfQNzDh4WyVjLxEFSc-gN8Yb4rwU
X-Proofpoint-ORIG-GUID: 2VX3HGAQ3RNWcKpgE-rFCND32A0gzw9A
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-14_01:2021-06-11,2021-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140055
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On 21.05.21 21:36, Tony Krowiak wrote:
> Fixes a memory leak in the mdev remove callback when invoked while the
> mdev is in use by a KVM guest. Instead of returning -EBUSY from the
> callback, a full cleanup of the resources allocated to the mdev is
> performed because regardless of the value returned from the function, the
> mdev is removed from sysfs.
> 
> The cleanup of resources allocated to the mdev may coincide with the
> interception of the PQAP(AQIC) instruction in which case data needed to
> handle the interception may get removed. A patch is included in this series
> to synchronize access to resources needed by the interception handler to
> protect against invalid memory accesses.
> 
> The first pass (PATCH v3) at trying to synchronize access to the pqap
> function pointer employed RCU. The problem is, the RCU read-side critical
> section would have to include the execution of the pqap function which
> sleeps; RCU disallows sleeping inside an RCU region. When I subsequently
> tried to encompass the pqap function within the
> rcu_read_lock/rcu_read_unlock, I ended up seeing lockdep warnings in the
> syslog.
> 
> It was suggested that we use an rw_semaphore to synchronize access to
> the pqap hook, but I also ran into similar lockdep complaints something
> like the following:
> 
>    Possible unsafe locking scenario:
> 
>          CPU0                            CPU1
>          ----                            ----
>     down_read(&rwsem)
>     in handle_pqap (priv.c);
>     
>                                    lock(&matrix_dev->lock);
>                                    in vfio_ap_mdev_set_kvm (vfio_ap_ops.c)
>                                  
>                                    down_write(&rwsem;
>                                    in vfio_ap_mdev_set_kvm (vfio_ap_ops.c)
>                                  
>     lock(&matrix_dev->lock);
>     in handle_pqap(vfio_ap_ops.c)
> 
> Access to the mdev must be done under the matrix_dev->lock to ensure that
> it doesn't get freed via the remove callback while in use. This appears
> to be mutually exclusive with setting/unsetting the pqap_hook pointer
> due to lockdep issues.
> 
> The solution:
> ------------
> The lifetime of the handle_pqap function (vfio_ap_ops) is syncrhonous
> with the lifetime of the vfio_ap module, so there really is not reason
> to tie the setting/clearing of its function pointer with the lifetime
> of a guest or even an mdev. If the function pointer is set when the
> vfio_ap module is loaded and cleared when the vfio_ap module is unloaded,
> then access to it can be protected independently from mdev creation or
> removal as well as the starting or shutdown of a guest. As long as
> access to the mdev is always controlled by the matrix_dev->lock, the
> mdev can not be freed without other functions being aware.
> 
> Change log:
> v3 -> v4:
> --------
> * Created a registry for crypto hooks in priv.c with functions for
>    registering/unregistering function pointers in kvm_host.h (for s390).
> 
> * Register the function pointer for handling the PQAP instruction when
>    the vfio_ap module is loaded and unregister it when the module is
>    unloaded.

Was there a v5? I cannot find it.
