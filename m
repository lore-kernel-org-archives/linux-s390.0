Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA585C433EF
	for <linux-s390@archiver.kernel.org>; Fri,  5 Nov 2021 14:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD419611EF
	for <linux-s390@archiver.kernel.org>; Fri,  5 Nov 2021 14:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhKEOOf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 5 Nov 2021 10:14:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233098AbhKEOOf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 5 Nov 2021 10:14:35 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A5BUXL2023896
        for <linux-s390@vger.kernel.org>; Fri, 5 Nov 2021 14:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=P2m9aUGX/Bn53qB4Ka+0itGi/NpxAQgkanLuEPKqnwM=;
 b=mfcq+bl7NwJyR4LLMMdCPAjyZPoxDTTg32maeMerpp0kx9JFpILRn1N80B6xMH/9gEI9
 YYzUE0Dosdtd57H6TVcpFJ1rYOe8t0PR+o9yjmbJAwajZ4Vl7tV0dwLhQP+k2Dl5CLU8
 h1glXiVBRhCG16DWbtX24uhynetLDWzgUHXHtr3W1Bc0e1YOKJx1MoVNb33Yg3RNSau8
 eRcKh/ef57HNwO2wqY9ZTX/B0AFTeg/OkJ0VY3zyE0EB3lkROKD/Mf22A+WXNvdN0yEz
 AeUu+q6q7A9PITY+MAqy26dnEquRW/VY+JOjk5PS6zx2v1gwuTna34jjOCe1jlw3gYTM cA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c50y2pjna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 05 Nov 2021 14:11:54 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1A5DnvFn008101
        for <linux-s390@vger.kernel.org>; Fri, 5 Nov 2021 14:11:54 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c50y2pjmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Nov 2021 14:11:54 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A5E7KvB001977;
        Fri, 5 Nov 2021 14:11:52 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3c4t4dde76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Nov 2021 14:11:52 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A5EBndB44499332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Nov 2021 14:11:49 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20149A405C;
        Fri,  5 Nov 2021 14:11:49 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79B61A4054;
        Fri,  5 Nov 2021 14:11:47 +0000 (GMT)
Received: from sig-9-65-203-91.ibm.com (unknown [9.65.203.91])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  5 Nov 2021 14:11:47 +0000 (GMT)
Message-ID: <3fe1c5f67652af50bf03d40996bd55513a6b56c6.camel@linux.ibm.com>
Subject: Re: [RFC v2 0/1]s390/cio: remove uevent suppress from cio driver
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
Cc:     oberpar@linux.ibm.com, Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Date:   Fri, 05 Nov 2021 15:11:46 +0100
In-Reply-To: <87a6ilb62b.fsf@redhat.com>
References: <20211027085059.544736-1-vneethv@linux.ibm.com>
         <87lf26bmlq.fsf@redhat.com>
         <3ab690456a523951ad59c17ac71e6b294ff12d98.camel@linux.ibm.com>
         <87a6ilb62b.fsf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KAkBqajbD2hzyiCAwpiLZ4U_u5PsmazG
X-Proofpoint-ORIG-GUID: BKi77GknwaVMe5DKfJHCqAe0bmki-JKK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-05_02,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=823 impostorscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111050081
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 2021-11-03 at 16:41 +0100, Cornelia Huck wrote:
> > > - interaction with driverctl (and maybe mdevctl) for vfio-ccw
> > I have done couple of tests with driverctl. Also, i was wondering if vfio-ccw
> > can make use of 'dev_busid' sysfs-interface under each subchannels while writing
> > the rules. This is totally different topic, which i do not want to mix up in
> > this thread.
> 
> Oh, did not know about that interface.
> 
> <looks>
> Doesn't the code need to check for 'w' for message subchannels, though?
You are right. For the message-subchannels, we need to check 'W'.
I will send a fix.

Thank you.

