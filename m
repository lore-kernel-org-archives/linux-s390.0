Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA565C54EE9
	for <linux-s390@archiver.kernel.org>; Thu, 22 Sep 2022 13:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiIVNHN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 22 Sep 2022 09:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiIVNHM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 22 Sep 2022 09:07:12 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F0FEA595
        for <linux-s390@vger.kernel.org>; Thu, 22 Sep 2022 06:07:10 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MC7vAQ040487
        for <linux-s390@vger.kernel.org>; Thu, 22 Sep 2022 13:07:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TOx+McXdu6sMebhsentVSIyAaaXg3hSDB9T9ebXcDio=;
 b=lnH0CY8q5p54N1FyyGddoM1k4s+tzrBPlts+xETYusOJqlBaigI0xVJyRadL5xChwOmH
 mg+qH3HDWe9XYR7kqZdWW2f3VwXQucz0Zi9rhDQh57R4WBGiCw7ga1Wm2NVqmaqMkLao
 K+HVoAAIYuuXimHUOJUvDh9LVfNYbWCYeOPIfy9S0/LLD8kI9oEBU0RuL3Bg/FuY8S00
 EnU9KQkVWqJtT+/OHSFFd2nirZOUIRe86jE+BdHUrihxrZD9PvyUWLhJDz2Stpy5mDlT
 RDbOVJ0qfbjphdAmumfHUeZ3PdbjJ9fGzC1Re5h6P/gQxqa3T1R9VBrOG1hTVvHHPMwg OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jrptcb5tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 22 Sep 2022 13:07:09 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28MCAPPC010418
        for <linux-s390@vger.kernel.org>; Thu, 22 Sep 2022 13:07:09 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jrptcb5m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 13:07:08 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28MD5CM3009725;
        Thu, 22 Sep 2022 13:07:06 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3jn5v8ppm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 13:07:05 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28MD72G441222516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 13:07:02 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77845AE057;
        Thu, 22 Sep 2022 13:07:02 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52198AE045;
        Thu, 22 Sep 2022 13:07:02 +0000 (GMT)
Received: from [9.145.147.112] (unknown [9.145.147.112])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 22 Sep 2022 13:07:02 +0000 (GMT)
Message-ID: <e81df559-8a54-aa95-5d05-6c75398e6ab6@linux.ibm.com>
Date:   Thu, 22 Sep 2022 15:07:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] docs/ABI: remove invalid email address from sysfs-bus-css
Content-Language: en-US
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
To:     cohuck@redhat.com
Cc:     oberpar@linux.ibm.com, linux-s390@vger.kernel.org
References: <20220922125952.2825830-1-vneethv@linux.ibm.com>
In-Reply-To: <20220922125952.2825830-1-vneethv@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4p5MmWoU8oUppFeh9RuUg7XrEdGrmisM
X-Proofpoint-ORIG-GUID: lR_VVdslksQDKu4KtGrANl-ct_M7RJ5j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_08,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209220087
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Please ignore this patch.

I will share the updated one.

On 9/22/22 14:59, Vineeth Vijayan wrote:
> Remove Cornelia's invalid email address from the file as suggested by
> her. List only the linux-s390 vger address as the contact.
>
> Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
> ---
>   Documentation/ABI/testing/sysfs-bus-css | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-css b/Documentation/ABI/testing/sysfs-bus-css
> index 12a733fe357f..d4d5cfb63b90 100644
> --- a/Documentation/ABI/testing/sysfs-bus-css
> +++ b/Documentation/ABI/testing/sysfs-bus-css
> @@ -1,22 +1,19 @@
>   What:		/sys/bus/css/devices/.../type
>   Date:		March 2008
> -Contact:	Cornelia Huck <cornelia.huck@de.ibm.com>
> -		linux-s390@vger.kernel.org
> +Contact:	linux-s390@vger.kernel.org
>   Description:	Contains the subchannel type, as reported by the hardware.
>   		This attribute is present for all subchannel types.
>   
>   What:		/sys/bus/css/devices/.../modalias
>   Date:		March 2008
> -Contact:	Cornelia Huck <cornelia.huck@de.ibm.com>
> -		linux-s390@vger.kernel.org
> +Contact:	linux-s390@vger.kernel.org
>   Description:	Contains the module alias as reported with uevents.
>   		It is of the format css:t<type> and present for all
>   		subchannel types.
>   
>   What:		/sys/bus/css/drivers/io_subchannel/.../chpids
>   Date:		December 2002
> -Contact:	Cornelia Huck <cornelia.huck@de.ibm.com>
> -		linux-s390@vger.kernel.org
> +Contact:	linux-s390@vger.kernel.org
>   Description:	Contains the ids of the channel paths used by this
>   		subchannel, as reported by the channel subsystem
>   		during subchannel recognition.
> @@ -26,8 +23,7 @@ Users:		s390-tools, HAL
>   
>   What:		/sys/bus/css/drivers/io_subchannel/.../pimpampom
>   Date:		December 2002
> -Contact:	Cornelia Huck <cornelia.huck@de.ibm.com>
> -		linux-s390@vger.kernel.org
> +Contact:	linux-s390@vger.kernel.org
>   Description:	Contains the PIM/PAM/POM values, as reported by the
>   		channel subsystem when last queried by the common I/O
>   		layer (this implies that this attribute is not necessarily
> @@ -38,8 +34,7 @@ Users:		s390-tools, HAL
>   
>   What:		/sys/bus/css/devices/.../driver_override
>   Date:		June 2019
> -Contact:	Cornelia Huck <cohuck@redhat.com>
> -		linux-s390@vger.kernel.org
> +Contact:	linux-s390@vger.kernel.org
>   Description:	This file allows the driver for a device to be specified. When
>   		specified, only a driver with a name matching the value written
>   		to driver_override will have an opportunity to bind to the
