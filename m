Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4767AC433ED
	for <linux-s390@archiver.kernel.org>; Thu, 20 May 2021 08:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A74660234
	for <linux-s390@archiver.kernel.org>; Thu, 20 May 2021 08:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhETIuc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 20 May 2021 04:50:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63882 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231327AbhETIu3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 May 2021 04:50:29 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14K8XbSj109369;
        Thu, 20 May 2021 04:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=3BTS8X/BF0hBtVsWyUvfPuTrJLgKfy/67BLmvvvtcZA=;
 b=WxKRFEoHvLP8XGoFH6rmSM3kp/tJx65z/cbMfjish0mu3lWCBAMCdLpDrMjxJ7ObkpYg
 HM0gQ87TePD6ZYbTjRx7I+THA0ak/zNtJcL1TNameb1ta4Sy7QE/2NnPYA/8vx4TGmO3
 LsbPovltcQJBEX5YTe383nIIv3aUCmeZWns5CdQASZvENZPXFNjIvxX691ByMPMTtacW
 4BkKNis0wYMejGJfr4vXGgYO2yzEWaV5hxfsZZ9hfP5oTagucDQr675OsrfLNTkD2lf4
 YYh2YitNbbGGNFef70iwbHLuKXCJgcT4ukiV3bro4178FTHM+MnPG+Iy6AK2018JkMI2 ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38nkn0htsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 04:49:06 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14K8YIex111236;
        Thu, 20 May 2021 04:49:05 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38nkn0htrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 04:49:05 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14K8mHe8029954;
        Thu, 20 May 2021 08:49:03 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 38j5jgtgxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 08:49:03 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14K8n0wi46334214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 08:49:00 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67E62A4069;
        Thu, 20 May 2021 08:49:00 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFD98A404D;
        Thu, 20 May 2021 08:48:59 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.68.61])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 20 May 2021 08:48:59 +0000 (GMT)
Date:   Thu, 20 May 2021 10:48:57 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        cohuck@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com
Subject: Re: [PATCH v3 2/2] s390/vfio-ap: control access to PQAP(AQIC)
 interception handler
Message-ID: <20210520104857.65d75858.pasic@linux.ibm.com>
In-Reply-To: <330f099c-3d5e-c552-3047-4b462b1c9fa9@linux.ibm.com>
References: <20210519153921.804887-1-akrowiak@linux.ibm.com>
        <20210519153921.804887-3-akrowiak@linux.ibm.com>
        <20210519161610.GO1002214@nvidia.com>
        <8c93c29a-e223-ac9a-5b54-7329587084c9@linux.ibm.com>
        <20210519232202.GV1002214@nvidia.com>
        <330f099c-3d5e-c552-3047-4b462b1c9fa9@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -0pvXTxs9dAuSrFCTyePfqjlbz6e_31x
X-Proofpoint-GUID: iMDKktRqHLPpdYcfHo6EeAW6ECF8h9J8
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-20_01:2021-05-20,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105200065
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 19 May 2021 21:08:15 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> >
> > This is nonesense too:
> >
> > 	if (vcpu->kvm->arch.crypto.pqap_hook) {
> > 		if (!try_module_get(vcpu->kvm->arch.crypto.pqap_hook->owner))
> > 			return -EOPNOTSUPP;
> > 		ret = vcpu->kvm->arch.crypto.pqap_hook->hook(vcpu);
> >
> > It should have a lock around it of some kind, not a
> > try_module_get. module_get is not la lock.  
> 
> As I said earlier, I don't know why the author did this. 

Please have a look at these links from the archive to get some
perspective:
https://lkml.org/lkml/2020/12/4/994
https://lkml.org/lkml/2020/12/3/987
https://www.lkml.org/lkml/2019/3/1/260

We can ask the original author, but I don't think we have to. BTW the
patch that introduced it has your r-b.

> My best guess
> is that he wanted to ensure that the module was still loaded; otherwise,
> the data structures contained therein - for example, the pqap_hook
> and matrix_mdev that contains it - would be gonzo.

More precisely prevent the module from unloading while we execute code
from it. As I've pointed out in a previous email the module may be gone
by the time we call try_module_get().

Regards,
Halil
