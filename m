Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D387C433B4
	for <linux-s390@archiver.kernel.org>; Wed, 28 Apr 2021 21:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A51B61107
	for <linux-s390@archiver.kernel.org>; Wed, 28 Apr 2021 21:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhD1V36 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Apr 2021 17:29:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230416AbhD1V36 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Apr 2021 17:29:58 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SLOFfb047781;
        Wed, 28 Apr 2021 17:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=e7ssmoTCG461tljZydTGlfgnz2kpotgx6iYW7xdaFDg=;
 b=Vt8FBCmyHNpg8E8OdBxllufW7YWJL82Vy+Oi/tygUDk16fT5Kg5FcEV79MWTNAAR9+Fs
 brbxf0jDcIMAsT7FenJkliXkkf/qF9NYhOwgVKQc6PS4XtxbWHvUYK3LBbssMYeTnW85
 6U2A7LOpfPCNPoLTLAFwfaNvT4uvtRKWfwKGNgS653A7D0iaGutGGFk8p8bOqfo0BwIo
 jCQ/jXecGi7PUJQ16qxOib9+AD6hwVpb/4qLK7PX+mGzSKS2OqHiCLWOoW5MjlQey4nr
 uae0aOwgH+PRhNOLgrC5N6QMOONEHJ4qP6maeqDEuYeDlR/WjSzO1cuLVswuCelNq7t0 vA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 387f92ggcu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 17:29:12 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13SLTCTX070110;
        Wed, 28 Apr 2021 17:29:12 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 387f92ggcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 17:29:12 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13SLTAGJ030874;
        Wed, 28 Apr 2021 21:29:10 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 384ay8s5q6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Apr 2021 21:29:10 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13SLSgKc36438434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 21:28:42 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 702F152050;
        Wed, 28 Apr 2021 21:29:06 +0000 (GMT)
Received: from osiris.fritz.box (unknown [9.171.11.104])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 1053F52052;
        Wed, 28 Apr 2021 21:29:06 +0000 (GMT)
Date:   Wed, 28 Apr 2021 23:29:03 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Thomas Huth <thuth@redhat.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, cohuck@redhat.com
Subject: Re: [PATCH] arch/s390/configs: Change CONFIG_VIRTIO_CONSOLE to "m"
Message-ID: <YInTn6HRpUUGmKjX@osiris.fritz.box>
References: <20210428082442.321327-1-thuth@redhat.com>
 <c015ef3f-ff88-113b-a089-e2af9202399a@de.ibm.com>
 <6e44cc81-fe19-f75b-972f-5c4707f2410f@redhat.com>
 <b75f0447-55d4-09b8-8f3e-d0d54471cac1@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b75f0447-55d4-09b8-8f3e-d0d54471cac1@de.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cXQHfjS85N_LJcki5yjkWmzIAhHYdMby
X-Proofpoint-ORIG-GUID: 6pC7WTpBOdKKmkgaxNw-5qOk5MJo4TVT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-28_16:2021-04-28,2021-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104280136
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Apr 28, 2021 at 11:03:22PM +0200, Christian Borntraeger wrote:
> On 28.04.21 11:30, Thomas Huth wrote:
> > On 28/04/2021 10.31, Christian Borntraeger wrote:
> > > On 28.04.21 10:24, Thomas Huth wrote:
> > > > In former times, the virtio-console code had to be compiled into
> > > > the kernel since the old guest virtio transport had some hard de-
> > > > pendencies. But since the old virtio transport has been removed in
> > > > commit 7fb2b2d51244 ("s390/virtio: remove the old KVM virtio transport"),
> > > > we do not have this limitation anymore.
> > > > Commit bb533ec8bacd ("s390/config: do not select VIRTIO_CONSOLE via
> > > > Kconfig") then also lifted the hard setting in the Kconfig system, so
> > > > we can finally switch the CONFIG_VIRTIO_CONSOLE knob to compile this
> > > > driver as a module now, making it more flexible for the user to only
> > > > load it if it is really required.
> > > 
> > > Isnt that a distro specific decision? I would be perfectly fine to have
> > > this change in Fedora, Redhat and co.
> > 
> > Sure, I'll try to get it changed there, too.
> > 
> > > Not so sure about defconfig.
> > > We often use the defconfig in our CI and development things to have a
> > > kernel config that boots up fine, even without a ramdisk. I agree that
> > > virtio console is no longer really the most important console but does
> > > it really hurt?
> > Well, it's about a default configuration that should be fine for
> > most users. I don't think that anybody really uses virtio-console
> > in a ramdisk already ... or are you really doing that in your CI?
> > If so, then please disregard my patch.
> 
> I think anybody uses the sclp console nowadays. The only question is, do
> we care about manual configs with virtio-console?

Not really. If it breaks someone's workflow we will know for sure
pretty soon. Therefore let's just change this.
