Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B458C76196
	for <linux-s390@archiver.kernel.org>; Wed, 12 Apr 2023 01:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDLBfe (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 11 Apr 2023 21:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjDLBfd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 11 Apr 2023 21:35:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534FB40FB;
        Tue, 11 Apr 2023 18:35:33 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33C0iVmh020017;
        Wed, 12 Apr 2023 01:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=BPrgpdqeDPcqFBy+r3TzAglpUKKtW11RB3HAPUcLwBU=;
 b=llbsxO+dOG/cdmtwQI47nkYTYh4yGh6D8YpuRorarj2ozT9/wFhvN7Z1lbi+d49VS2V9
 jOs2kdPr9iusoVMBW23kp3CFyFVGZB7Qa2CVNmp7w2R8kLDKeI96544uTBhyOapbb9E6
 6qZYEwIbdhgR73hHPO+oqVnxv3MCQ+nS9wufZetYNEZ4iO+CKK2ylLF38a2+FdY0E4Di
 JjtoE3RpmONcrDUC+Q3ic45Ce4vv/UiiAFx455gYYO2quGWiShsofIP197k/wFV7gPHb
 gYfxCvlxWgqUSjA1+Xbji+XNDO2RHvsM/J2F4FdpIwU+XYvuDhsJVMeVLsWaYFEP0dZz 9Q== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pwjcb1fp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 01:35:32 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33C0G2dO012887;
        Wed, 12 Apr 2023 01:35:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3pu0hq1qtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 01:35:28 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33C1ZPdD28967318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 01:35:25 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6029A20049;
        Wed, 12 Apr 2023 01:35:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A16D020040;
        Wed, 12 Apr 2023 01:35:24 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.53.228])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
        Wed, 12 Apr 2023 01:35:24 +0000 (GMT)
Date:   Wed, 12 Apr 2023 03:35:23 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 7/7] s390/dasd: fix hanging blockdevice after request
 requeue
Message-ID: <20230412033523.39950741.pasic@linux.ibm.com>
In-Reply-To: <20230405142017.2446986-8-sth@linux.ibm.com>
References: <20230405142017.2446986-1-sth@linux.ibm.com>
        <20230405142017.2446986-8-sth@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bYZj4oDsgfLeDTn0-V-5fKeAf8vEoSF3
X-Proofpoint-ORIG-GUID: bYZj4oDsgfLeDTn0-V-5fKeAf8vEoSF3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=963
 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120011
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed,  5 Apr 2023 16:20:17 +0200
Stefan Haberland <sth@linux.ibm.com> wrote:

> The DASD driver does not kick the requeue list when requeuing IO requests
> to the blocklayer. This might lead to hanging blockdevice when there is
> no other trigger for this.
> 
> Fix by automatically kick the requeue list when requeuing DASD requests
> to the blocklayer.
> 
> Fixes: e443343e509a ("s390/dasd: blk-mq conversion")
> CC: stable@vger.kernel.org # 4.14+
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

[..]
