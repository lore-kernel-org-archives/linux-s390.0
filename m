Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAC1C76196
	for <linux-s390@archiver.kernel.org>; Wed, 12 Apr 2023 01:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjDLBey (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 11 Apr 2023 21:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjDLBey (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 11 Apr 2023 21:34:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883BD40FB;
        Tue, 11 Apr 2023 18:34:53 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33C0FlXE010734;
        Wed, 12 Apr 2023 01:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=NNn6+bWCIz4UGHcO8NCCAFmgjFQkTlKaxIDWvzEgCl4=;
 b=kCQK0DeDSoXgox/BjG/Xd8qlCOhPj2UO34lXBMf35Z44p/BFA5TPKCdiPZlpWrtzSv2h
 O5qiVwE9LobXIDkj6MA3OuW3xGjqY5cfCaMRRfepVFrCNjXn5OVeCWxSEScOAeyPRQcm
 Aret8VIDOzUUSkG5lbR0YXWarNaSRdO5URzLMI6Ox0KJr5PX7b0OEWlpI0bXXWQY6zTW
 olltTR69O5uMUnOcOQS7UOkqCNgJrxVebhR5FAS2tIwcg0TabOpOW8tr2NLWxN5b8fMJ
 acfpGsM7pKun5W7P1M6XchKGIWhRXEvw+Z25D86zynmF1XQDf87H4Lw1nce1GsIcEMSm lQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pwhxut6c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 01:34:52 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33BNKul6028168;
        Wed, 12 Apr 2023 01:34:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3pu0mk9qen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 01:34:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33C1Yk8615860278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 01:34:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E62420043;
        Wed, 12 Apr 2023 01:34:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2847120040;
        Wed, 12 Apr 2023 01:34:46 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.53.228])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
        Wed, 12 Apr 2023 01:34:46 +0000 (GMT)
Date:   Wed, 12 Apr 2023 03:34:44 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 5/7] s390/dasd: add aq_timeouts autoquiesce trigger
Message-ID: <20230412033444.6e328c96.pasic@linux.ibm.com>
In-Reply-To: <20230405142017.2446986-6-sth@linux.ibm.com>
References: <20230405142017.2446986-1-sth@linux.ibm.com>
        <20230405142017.2446986-6-sth@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bXkbOmOy4hg7oI5qSNyr4f8IjPd28fbs
X-Proofpoint-GUID: bXkbOmOy4hg7oI5qSNyr4f8IjPd28fbs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120011
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed,  5 Apr 2023 16:20:15 +0200
Stefan Haberland <sth@linux.ibm.com> wrote:

> Add a sysfs attribute aq_timeouts that controls after how many
> timeouts a autoquiesce event might be triggered.
> 
> The default value is 32768 which is the maximum number of retries
> for the DASD device driver DASD_RETRIES_MAX. This means that the
> timeout trigger will never happen.
> 
> The default value for DASD retries is 255.
> Setting the value to below 255 will trigger the timeout autoquiesce
> event before an IO error is generated.
> 
> Also add the check for the configured amount of timeouts and trigger
> an autoquiesce event if exceeded.
> 
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

[..]
