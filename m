Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18B9C433DB
	for <linux-s390@archiver.kernel.org>; Thu,  4 Mar 2021 18:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F14C64F10
	for <linux-s390@archiver.kernel.org>; Thu,  4 Mar 2021 18:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhCDSgc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 4 Mar 2021 13:36:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232584AbhCDSg1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 4 Mar 2021 13:36:27 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 124IWwZm008243;
        Thu, 4 Mar 2021 13:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=iSdvSQSDfrdq+uGc+n7CiTZiXoEsTxCHbW2Zu6hOkmI=;
 b=ApJ9nVqYl5lk67H+L7h4FCDWBBYbIUPjWzVFPEGJVRhLflr5IbhWEmHAUa3k+dNeITxE
 g84tfn2GQghfZVEbyb9DtedEG9ZDoS7Tm0/UC9yDn3XM/+F+5NxzpYGCBJhb2MdWMJ+V
 ihxEbRsrUBC1lPejklJTS++7IarKIWLduf31+QaUFcVSSaOBHIRig0N2QybZORkaafVv
 p9UO+1r7leQ92eO895E5HAdZoWx1rrWvJdxIu5WkD4jTZZNSfbPwlo0/QssIlQLKijKl
 52dCBymyxfvrDqZs5NgqdLPXAmH0yDU7BFS/odQZ1fG4PZ1IWq0820cbl/dwnesRNyqh Ig== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3734e11c24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 13:35:42 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 124IXp7l003421;
        Thu, 4 Mar 2021 18:35:40 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 371162k2jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 18:35:39 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 124IZNww30015762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Mar 2021 18:35:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B19CAAE04D;
        Thu,  4 Mar 2021 18:35:37 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D04BAE056;
        Thu,  4 Mar 2021 18:35:37 +0000 (GMT)
Received: from osiris (unknown [9.171.88.145])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  4 Mar 2021 18:35:37 +0000 (GMT)
Date:   Thu, 4 Mar 2021 19:35:36 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-s390@vger.kernel.org, smatch@vger.kernel.org
Subject: Re: smatch and copy_{to,from}_user return values
Message-ID: <YEEoeIR7X2kSSYkW@osiris>
References: <b57b4f40-d67c-d57c-c5b2-077b623ed4ed@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b57b4f40-d67c-d57c-c5b2-077b623ed4ed@prevas.dk>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_05:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=750
 impostorscore=0 lowpriorityscore=0 clxscore=1011 mlxscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103040088
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Mar 03, 2021 at 08:50:19AM +0100, Rasmus Villemoes wrote:
> Hi Dan
> 
> If you look at vfio_ccw_mdev_ioctl() in drivers/s390/cio/vfio_ccw_ops.c,
> and vfio_ap_mdev_get_device_info() in drivers/s390/crypto/vfio_ap_ops.c,
> there are examples of functions that can both return -Esomething as well
> as may return the return value of a copy_{to,from}_user directly (i.e.,
> in case of error some positive number).
> 
> [Those "return copy_to_user();" should probably all be changed to
> "return copy_to_user() ? -EFAULT : 0;" - cc'ing the s390 list in case
> the maintainers want to do that.]

This has been reported just a couple of days ago - fixes will go
upstream soon.

Thanks for reporting anyway!
