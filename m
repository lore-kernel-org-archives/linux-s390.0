Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F75C76196
	for <linux-s390@archiver.kernel.org>; Wed, 12 Apr 2023 01:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjDLBfi (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 11 Apr 2023 21:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjDLBfi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 11 Apr 2023 21:35:38 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF44448A;
        Tue, 11 Apr 2023 18:35:37 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BN280h035898;
        Wed, 12 Apr 2023 01:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=gNlgKv0nxDs1RQjxJStOW6+SvxUTTCRHuvDMFxaLSxw=;
 b=CmdEbkhC604HoeOIcJE0U9uMr5muSK+R59oLSPXcMKYKVjpcSZucps+jm6i7anYegwd+
 vFSmE6ftAgLtCC51i0zJEqZ7rzoT+/5ym5u82SvPhUUD+QrMeKd4xhJsdlURwG7Zsw7O
 aj7ecVuZK8jT4K4QszfRXnvdBtPHSDcacY7fF87UE6XHJQkrfij/qr5///9M4Actzsz5
 emqIITCfVwFDjdvynrYTNT/GEyocQWpuNlUQC33Uut/VVSRSV9hOwDST/fGniTpVcBir
 j1muydePPv4wM+GePMoyi7UITEMI8ICavjNoIOr5qb5heqHXHb9eimCEXhZQ3buuFfJD HQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pwgv246m0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 01:35:35 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33BMw15A030088;
        Wed, 12 Apr 2023 01:33:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3pu0m1a1qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 01:33:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33C1XEDY43450886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 01:33:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62D0120043;
        Wed, 12 Apr 2023 01:33:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE0D320040;
        Wed, 12 Apr 2023 01:33:13 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.53.228])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
        Wed, 12 Apr 2023 01:33:13 +0000 (GMT)
Date:   Wed, 12 Apr 2023 03:33:12 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 2/7] s390/dasd: add autoquiesce feature
Message-ID: <20230412033312.71e414b4.pasic@linux.ibm.com>
In-Reply-To: <20230405142017.2446986-3-sth@linux.ibm.com>
References: <20230405142017.2446986-1-sth@linux.ibm.com>
        <20230405142017.2446986-3-sth@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iLSuUrm7YHsjgNjviMaUL9FvdO2QjljG
X-Proofpoint-GUID: iLSuUrm7YHsjgNjviMaUL9FvdO2QjljG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=828 spamscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0 phishscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120011
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed,  5 Apr 2023 16:20:12 +0200
Stefan Haberland <sth@linux.ibm.com> wrote:

> Add the internal logic to check for autoquiesce triggers and handle
> them.
> 
> Quiesce and resume are functions that tell Linux to stop/resume
> issuing I/Os to a specific DASD.
> The DASD driver allows a manual quiesce/resume via ioctl.
> 
> Autoquiesce will define an amount of triggers that will lead to
> an automatic quiesce if a certain event occurs.
> There is no automatic resume.
> 
> All events will be reported via DASD Extended Error Reporting (EER)
> if configured.
> 
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

[..]
