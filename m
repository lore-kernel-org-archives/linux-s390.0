Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047C9C76196
	for <linux-s390@archiver.kernel.org>; Wed, 12 Apr 2023 01:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjDLBd7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 11 Apr 2023 21:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjDLBd6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 11 Apr 2023 21:33:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845A440FB;
        Tue, 11 Apr 2023 18:33:56 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33C0iYE6020442;
        Wed, 12 Apr 2023 01:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=rxPpKfLscYs5Y3pOkEG8KSvoV9fwhyjjYeLSqD2s4X4=;
 b=l3bXe1AeqbE58JnWHtmM+jps5vPE046uwWHNZCrv7lDLanczecKsz290o5uL6ljIGEyV
 vzRL5+Ljv5butkb5SrZ7vEFuXlser/QreqsUuIzgKaEMM0/UX9DhCC10Xwr/0Pby15S9
 JYvkrPzH17zZvu/Nfg5qgW4P8kJqNem6kRpTzQ4riWMXT5Htvma287SDtyaodnTKgjhk
 QeiO7FL0oC5LX1BJs4MwogW/VkjZX9IQQ/uDcCYnhi+JGNdR4Ud2XoW1xLe0mZkrjxoe
 RPHYlqek7vG0ZoF+o7Clcx87K8Kb9ufmCrMkfmp2RIbs2fB/u3cnBRTb6tEP0uR9SRj2 2Q== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pwjcb1dsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 01:33:54 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33C1USnn032371;
        Wed, 12 Apr 2023 01:33:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3pu0m1a1qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 01:33:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33C1XmSZ23921166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 01:33:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D8ED20043;
        Wed, 12 Apr 2023 01:33:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A9E320040;
        Wed, 12 Apr 2023 01:33:48 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.53.228])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
        Wed, 12 Apr 2023 01:33:47 +0000 (GMT)
Date:   Wed, 12 Apr 2023 03:33:38 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 3/7] s390/dasd: add aq_mask sysfs attribute
Message-ID: <20230412033338.1a7e0e10.pasic@linux.ibm.com>
In-Reply-To: <20230405142017.2446986-4-sth@linux.ibm.com>
References: <20230405142017.2446986-1-sth@linux.ibm.com>
        <20230405142017.2446986-4-sth@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QtdYMTykmn01pVKUuovpYXo6Wo9LZg2D
X-Proofpoint-ORIG-GUID: QtdYMTykmn01pVKUuovpYXo6Wo9LZg2D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=949
 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120011
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed,  5 Apr 2023 16:20:13 +0200
Stefan Haberland <sth@linux.ibm.com> wrote:

> Add sysfs attribute that controls the DASD autoquiesce feature.
> The autoquiesce is disabled when 0 is echoed to the attribute.
> 
> A value greater than 0 will enable the feature.
> The aq_mask attribute will accept an unsigned integer and the value
> will be interpreted as bitmask defining the trigger events that will
> lead to an automatic quiesce.
> 
> The following autoquiesce triggers will currently be available:
> 
> DASD_EER_FATALERROR  1 - any final I/O error
> DASD_EER_NOPATH      2 - no remaining paths for the device
> DASD_EER_STATECHANGE 3 - a state change interrupt occurred
> DASD_EER_PPRCSUSPEND 4 - the device is PPRC suspended
> DASD_EER_NOSPC       5 - there is no space remaining on an ESE device
> DASD_EER_TIMEOUT     6 - a certain amount of timeouts occurred
> DASD_EER_STARTIO     7 - the IO start function encountered an error
> 
> The currently supported maximum value is 255.
> 
> Bit 31 is reserved for internal usage.
> Bit 0 is not used.
> 
> Example:
> 
>  - deactivate autoquiesce
>    $ echo 0 > /sys/bus/ccw/0.0.1234/aq_mask
> 
>  - enable autoquiesce for FATALERROR, NOPATH and TIMEOUT
>    (0000 0000 0000 0000  0000 0000 0100 0110 => 70)
>    $ echo 70 > /sys/bus/ccw/0.0.1234/aq_mask
> 
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

[..]
