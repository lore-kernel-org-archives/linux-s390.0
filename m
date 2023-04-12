Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD99CC76196
	for <linux-s390@archiver.kernel.org>; Wed, 12 Apr 2023 01:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjDLBeT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 11 Apr 2023 21:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjDLBeS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 11 Apr 2023 21:34:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E31A40FB;
        Tue, 11 Apr 2023 18:34:17 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33C0ia3Z020708;
        Wed, 12 Apr 2023 01:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=zrGCm+vYDQFY+Fqz6yGzTPuu60dswHKLg3avh5DAvwE=;
 b=lDvtCIf5lIh2I/FWEsDlb/IbWZbLD9WWXpgjMbKFG8DZ/68ZiIF4+aPmRfpLPmzgmJUb
 4AOafuohOYdROakVPmXWyqeAYeIjYtnsL7hdbPCg75+vMbL7TrSowQyEkjOa5Gp7XiIE
 3/pgvIw7QZuVClu/D/YK2tK4GeatHDdnT+7fZzxNmA8Wvs8/+DhcKuCHtBtqmICX+x4l
 SuoG6uWXxk1FoYqMcA0p5jeF7y0yJe3kb++rUjA1nFWvoHYp0ot/rFRkphkV2jhCxq6m
 7FuQ6yhguiXKs22zTgDB2JWtPZ9FZ++NLWsmPd7qEBdkgeGxCUQd2cJVwXUVn8r3pbAm jw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pwjcb1e8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 01:34:16 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33C154JT018615;
        Wed, 12 Apr 2023 01:34:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3pu0jk1qg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 01:34:12 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33C1Y8CN19530308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 01:34:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D46A820040;
        Wed, 12 Apr 2023 01:34:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4239B20043;
        Wed, 12 Apr 2023 01:34:08 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.53.228])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
        Wed, 12 Apr 2023 01:34:08 +0000 (GMT)
Date:   Wed, 12 Apr 2023 03:34:07 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 4/7] s390/dasd: add aq_requeue sysfs attribute
Message-ID: <20230412033407.5f2f18cf.pasic@linux.ibm.com>
In-Reply-To: <20230405142017.2446986-5-sth@linux.ibm.com>
References: <20230405142017.2446986-1-sth@linux.ibm.com>
        <20230405142017.2446986-5-sth@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kD-lYsnpQyQGXJIlg8I54hn5ZBjqLYiv
X-Proofpoint-ORIG-GUID: kD-lYsnpQyQGXJIlg8I54hn5ZBjqLYiv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=703
 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120011
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed,  5 Apr 2023 16:20:14 +0200
Stefan Haberland <sth@linux.ibm.com> wrote:

> Add a sysfs attribute to control if all IO requests will be requeued to
> the blocklayer in case of an autoquiesce event or not.
> 
> A value of 1 means that in case of an autoquiesce event all IO requests
> will be requeued to the blocklayer.
> 
> A value of 0 means that the device will only be stopped.
> 
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

[..]
